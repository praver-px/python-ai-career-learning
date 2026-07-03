# 本地记忆

更新时间：2026-07-04

这份文件用于保存当前学习项目和机器环境中的长期上下文，方便后续不依赖同一个 AI 会话也能继续推进。

## 用户学习偏好

- 主要使用中文学习和沟通。
- 学习方式偏好“讲义 + 练习题 + 作业 + 复盘”，不喜欢只有路线图没有教材内容。
- 希望学习路线贴近真实工作和市场岗位，而不是过于学院化。
- 当前工作中主要涉及 Python 爬虫，也会接触 Web 开发，尤其是公司魔改 Django 框架。
- 希望补齐 Python 基础、爬虫工程化、Django/DRF、AI 应用开发、求职简历能力。
- 希望学习中避免重复造轮子：工作中优先使用标准库、框架能力、公司封装和成熟第三方库；学习中保留最小手写实现理解原理。
- 后续可能减少或停止使用 Codex，所以学习资料需要尽量完整、能离线推进。

## 当前学习仓库

- 本地路径：`D:\download\codetools\py_code\work\python-ai-career-learning`
- GitHub：`https://github.com/praver-px/python-ai-career-learning.git`
- Git 分支：`main`
- 当前 Git 已配置本仓库代理：
  - `http.proxy=http://127.0.0.1:7890`
  - `https.proxy=http://127.0.0.1:7890`
- 当前 Clash 监听端口曾确认：`127.0.0.1:7890`

## 学习路线状态

- 已完成总计划：`学习总计划.md`
- 已完成详细资源计划：`详细学习资源与周计划.md`
- 已完成实战反爬路线：`实战反爬与市场路线.md`
- 已完成 AI 应用路线：`AI应用学习路线.md`
- 已完成轮子复用规范：`轮子复用与源码阅读规范.md`
- 已完成 20 周计划：`weekly/20周学习计划.md`
- 已完成全周期资料索引：`weekly/全周期学习资料索引.md`
- 已完成 Week 01-20 的 `学习讲义.md`
- Week 01 额外包含：
  - `weekly/week-01/练习题.md`
  - `weekly/week-01/sample_access.log`

## 机器和工具状态

- 用户机器是 Windows。
- Clash 不要随意关闭，之前网络修复时用户明确要求保留 Clash。
- GitHub 推送如果直连失败，优先检查 Git 是否走 Clash 代理。
- Claude Code 曾确认安装版本为 `2.1.158`。
- Claude Code 已设置 `CLAUDE_CODE_ATTRIBUTION_HEADER=0`，用于避免第三方 Anthropic 兼容代理缓存被动态 attribution header 干扰。
- `.claude/settings.json` 和 `.codex/config.toml` 中可能存在真实 API token；后续任何脚本、文档和提交都不要包含真实密钥。

## 网络修复记忆

- Apex 掉线排查中，曾停用或手动化部分虚拟网络服务：
  - Radmin VPN
  - ZeroTier
  - Tailscale
  - PgyVPN
- 当时要求保留 Clash。
- 如果后续再处理网络问题，不要默认关闭 Clash。

## 后续学习启动方式

每周固定流程：

```text
1. 打开 weekly/全周期学习资料索引.md
2. 打开 weekly/week-xx/README.md
3. 打开 weekly/week-xx/学习讲义.md
4. 做讲义中的练习题
5. 完成最终作业
6. 写 notes/week-xx.md
7. git add / commit / push
```

每周复盘必须包含：

```text
本周学了什么
我写了什么代码
我复用了哪些轮子
哪些地方原本想自己写，后来发现已有方案
为了理解原理手写了哪个最小版本
为什么这个手写版本不直接用于生产
我还不懂什么
```

