param(
    [ValidateSet("init", "list", "show", "apply", "unset")]
    [string]$Action = "show",

    [string]$Profile = "custom-openai-compatible",

    [string]$ProfilesPath = (Join-Path $PSScriptRoot "..\config\codex-proxy-profiles.local.json"),

    [string]$CodexConfigPath = (Join-Path $env:USERPROFILE ".codex\config.toml"),

    [string]$CodexEnvPath = (Join-Path $env:USERPROFILE ".codex\.env"),

    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

$beginMarker = "# >>> cc-switch-codex-proxy"
$endMarker = "# <<< cc-switch-codex-proxy"

function Get-RepoRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Ensure-ConfigDirectory {
    $configDir = Join-Path (Get-RepoRoot) "config"
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir | Out-Null
    }
}

function Initialize-ProfilesFile {
    Ensure-ConfigDirectory
    $examplePath = Join-Path (Get-RepoRoot) "config\codex-proxy-profiles.example.json"
    if (Test-Path $ProfilesPath) {
        Write-Host "Profiles file already exists: $ProfilesPath"
        return
    }
    Copy-Item -LiteralPath $examplePath -Destination $ProfilesPath
    Write-Host "Created local profiles file: $ProfilesPath"
    Write-Host "Edit it and fill api_key or set the env var manually before applying."
}

function Load-Profiles {
    if (-not (Test-Path $ProfilesPath)) {
        throw "Profiles file not found: $ProfilesPath. Run: .\scripts\cc-switch-codex-proxy.ps1 init"
    }
    $json = Get-Content -LiteralPath $ProfilesPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if (-not $json.profiles) {
        throw "Invalid profiles file. Missing top-level 'profiles'."
    }
    return $json.profiles
}

function Get-ProfileObject {
    $profiles = Load-Profiles
    $profileObject = $profiles.PSObject.Properties[$Profile].Value
    if (-not $profileObject) {
        $available = ($profiles.PSObject.Properties.Name -join ", ")
        throw "Profile '$Profile' not found. Available profiles: $available"
    }
    return $profileObject
}

function Remove-ManagedBlock {
    param([string]$Text)
    $pattern = "(?ms)^$([regex]::Escape($beginMarker)).*?^$([regex]::Escape($endMarker))\r?\n?"
    return [regex]::Replace($Text, $pattern, "")
}

function Remove-TopLevelCodexKeys {
    param([string]$Text)

    $lines = $Text -split "`r?`n"
    $inTable = $false
    $kept = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        if ($line -match '^\s*\[') {
            $inTable = $true
            $kept.Add($line)
            continue
        }

        if (-not $inTable -and $line -match '^\s*(model|model_provider|openai_base_url)\s*=') {
            continue
        }

        $kept.Add($line)
    }

    return ($kept -join "`r`n").TrimEnd() + "`r`n"
}

function Quote-TomlString {
    param([string]$Value)
    return '"' + ($Value -replace '\\', '\\' -replace '"', '\"') + '"'
}

function Update-CodexConfig {
    param($ProfileObject)

    $codexDir = Split-Path -Parent $CodexConfigPath
    if (-not (Test-Path $codexDir)) {
        New-Item -ItemType Directory -Path $codexDir | Out-Null
    }

    $existing = ""
    if (Test-Path $CodexConfigPath) {
        $existing = Get-Content -LiteralPath $CodexConfigPath -Raw -Encoding UTF8
    }

    if (-not $NoBackup -and (Test-Path $CodexConfigPath)) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        Copy-Item -LiteralPath $CodexConfigPath -Destination "$CodexConfigPath.backup-$timestamp"
    }

    $clean = Remove-ManagedBlock $existing
    $clean = Remove-TopLevelCodexKeys $clean

    $model = [string]$ProfileObject.model
    $baseUrl = [string]$ProfileObject.openai_base_url

    if ([string]::IsNullOrWhiteSpace($model)) {
        throw "Profile '$Profile' is missing 'model'."
    }
    if ([string]::IsNullOrWhiteSpace($baseUrl)) {
        throw "Profile '$Profile' is missing 'openai_base_url'."
    }

    $block = @(
        $beginMarker,
        "# Managed by scripts/cc-switch-codex-proxy.ps1",
        "# Codex official docs recommend openai_base_url for OpenAI-compatible proxies.",
        "model = $(Quote-TomlString $model)",
        "model_provider = `"openai`"",
        "openai_base_url = $(Quote-TomlString $baseUrl)",
        $endMarker
    ) -join "`r`n"

    Set-Content -LiteralPath $CodexConfigPath -Encoding UTF8 -Value ($clean.TrimEnd() + "`r`n`r`n" + $block + "`r`n")
    Write-Host "Updated Codex config: $CodexConfigPath"
}

function Update-CodexEnv {
    param($ProfileObject)

    $apiKeyEnv = [string]$ProfileObject.api_key_env
    $apiKey = [string]$ProfileObject.api_key

    if ([string]::IsNullOrWhiteSpace($apiKeyEnv)) {
        $apiKeyEnv = "OPENAI_API_KEY"
    }

    if ([string]::IsNullOrWhiteSpace($apiKey)) {
        Write-Host "No api_key stored in profile. Set it manually in $CodexEnvPath as:"
        Write-Host "$apiKeyEnv=your-api-key"
        return
    }

    $envDir = Split-Path -Parent $CodexEnvPath
    if (-not (Test-Path $envDir)) {
        New-Item -ItemType Directory -Path $envDir | Out-Null
    }

    $lines = @()
    if (Test-Path $CodexEnvPath) {
        $lines = Get-Content -LiteralPath $CodexEnvPath -Encoding UTF8
    }

    $escaped = [regex]::Escape($apiKeyEnv)
    $lines = @($lines | Where-Object { $_ -notmatch "^\s*$escaped\s*=" })
    $lines += "$apiKeyEnv=$apiKey"
    Set-Content -LiteralPath $CodexEnvPath -Encoding UTF8 -Value $lines
    Write-Host "Updated Codex env file: $CodexEnvPath"
}

function Unset-CodexProxy {
    if (-not (Test-Path $CodexConfigPath)) {
        Write-Host "Codex config not found: $CodexConfigPath"
        return
    }

    if (-not $NoBackup) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        Copy-Item -LiteralPath $CodexConfigPath -Destination "$CodexConfigPath.backup-$timestamp"
    }

    $existing = Get-Content -LiteralPath $CodexConfigPath -Raw -Encoding UTF8
    $clean = Remove-ManagedBlock $existing
    Set-Content -LiteralPath $CodexConfigPath -Encoding UTF8 -Value $clean
    Write-Host "Removed cc-switch-codex-proxy managed block from: $CodexConfigPath"
}

switch ($Action) {
    "init" {
        Initialize-ProfilesFile
    }
    "list" {
        $profiles = Load-Profiles
        $profiles.PSObject.Properties.Name | ForEach-Object { Write-Host $_ }
    }
    "show" {
        Write-Host "Profiles file: $ProfilesPath"
        Write-Host "Codex config:  $CodexConfigPath"
        Write-Host "Codex env:     $CodexEnvPath"
        if (Test-Path $CodexConfigPath) {
            $text = Get-Content -LiteralPath $CodexConfigPath -Raw -Encoding UTF8
            if ($text.Contains($beginMarker)) {
                Write-Host "Managed proxy block: present"
            } else {
                Write-Host "Managed proxy block: absent"
            }
        }
    }
    "apply" {
        $profileObject = Get-ProfileObject
        Update-CodexConfig $profileObject
        Update-CodexEnv $profileObject
        Write-Host "Done. Restart Codex Desktop / VS Code extension after changing provider config."
    }
    "unset" {
        Unset-CodexProxy
        Write-Host "Done. Restart Codex Desktop / VS Code extension after changing provider config."
    }
}

