# Scripts

## cc-switch-codex-proxy.ps1

用途：在 Windows 上切换 Codex 的 OpenAI 兼容代理 API 配置。

它会修改：

```text
%USERPROFILE%\.codex\config.toml
%USERPROFILE%\.codex\.env
```

它不会把真实 API Key 写进 Git 仓库。真实配置请放在被 `.gitignore` 忽略的：

```text
config/codex-proxy-profiles.local.json
```

## 使用方法

1. 初始化本地配置：

```powershell
.\scripts\cc-switch-codex-proxy.ps1 init
```

2. 编辑本地配置：

```text
config/codex-proxy-profiles.local.json
```

填入：

```json
{
  "profiles": {
    "my-proxy": {
      "model": "your-model-name",
      "openai_base_url": "https://your-openai-compatible-proxy.example.com/v1",
      "api_key_env": "OPENAI_API_KEY",
      "api_key": "your-api-key"
    }
  }
}
```

3. 查看配置：

```powershell
.\scripts\cc-switch-codex-proxy.ps1 show
```

4. 切换到指定代理：

```powershell
.\scripts\cc-switch-codex-proxy.ps1 apply -Profile my-proxy
```

5. 取消脚本管理的代理配置：

```powershell
.\scripts\cc-switch-codex-proxy.ps1 unset
```

## 说明

- Codex 官方文档建议：如果只是让内置 OpenAI provider 指向代理、路由或数据驻留项目，使用 `openai_base_url`。
- 修改 `~/.codex/config.toml` 或 `~/.codex/.env` 后，需要重启 Codex Desktop 或 VS Code 扩展。
- 脚本会自动给 `config.toml` 创建备份。
- 如果不想把 key 写到 local profile，可以留空 `api_key`，然后手动编辑 `%USERPROFILE%\.codex\.env`。

