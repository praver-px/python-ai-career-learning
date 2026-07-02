# AI 应用学习路线

这份文档回答三个问题：

```text
1. 学习计划里的 AI 部分到底学什么？
2. 学完能干什么，怎么做到学有所用？
3. 现在主流 AI 应用开发常见技能有哪些？
```

你的定位不是研究大模型训练，也不是只会聊天工具，而是：

```text
会把 AI 能力接入 Python / Django / 爬虫 / 数据平台，做出能解决实际问题的 AI 应用。
```

---

## 1. 你要学的 AI 不是哪一类

暂时不把重点放在这些方向：

```text
大模型预训练
底层深度学习框架训练
GPU 集群训练
模型压缩和微调算法
论文复现
```

这些更偏算法工程师、机器学习工程师或大模型基础设施岗位。你当前路线更适合：

```text
Python AI 应用开发
AI 工作流开发
AI + Django 后端
AI + 数据采集/数据处理
AI + 知识库/RAG
AI + 自动化工具
```

---

## 2. AI 应用开发能力地图

## 能力 1：提示词与上下文管理

学什么：

- Prompt 基础结构。
- 角色、任务、约束、输出格式。
- Few-shot 示例。
- 长上下文整理。
- 如何让 AI 先问问题、再回答。
- 如何让 AI 解释代码、Review 代码、生成测试。

能干嘛：

- 写学习助教。
- 写代码 Review 助手。
- 写文档总结工具。
- 写岗位 JD 分析工具。
- 提升你日常使用 AI 的质量。

做到什么程度：

```text
给 AI 一个明确任务后，它能稳定输出你要的格式，而不是泛泛聊天。
```

练习项目：

```text
projects/prompt_lab/
```

---

## 能力 2：结构化输出

学什么：

- JSON 输出。
- JSON Schema。
- 字段类型、必填字段、枚举值。
- 输出校验。
- 失败重试。

能干嘛：

- 从文章中抽取标题、摘要、关键词。
- 从招聘 JD 中抽取技能标签。
- 从爬虫数据中抽取结构化字段。
- 把 AI 输出接入数据库和接口。

做到什么程度：

```text
AI 输出可以被 Python 程序稳定解析，而不是人工复制粘贴。
```

练习项目：

```text
projects/jd_analyzer/
```

---

## 能力 3：Function Calling / Tool Calling

学什么：

- 什么是工具调用。
- 如何把 Python 函数暴露给模型。
- 工具参数如何用 JSON Schema 描述。
- 模型什么时候应该调用工具。
- 工具结果如何返回给模型。
- 工具调用失败如何处理。

能干嘛：

- 让 AI 查询数据库。
- 让 AI 调用爬虫任务。
- 让 AI 调用搜索、计算、文件读取、接口请求。
- 做一个能“查数据 + 分析 + 给结论”的助手。

做到什么程度：

```text
AI 不只是回答文本，而是能调用你写好的函数完成真实动作。
```

练习项目：

```text
projects/ai_tools_assistant/
```

示例工具：

```text
search_articles(keyword)
get_crawl_task_status(task_id)
analyze_job_description(text)
generate_weekly_plan(gap_list)
```

---

## 能力 4：RAG 知识库问答

学什么：

- 文档加载。
- 文档切分。
- embedding。
- 向量数据库。
- 相似度检索。
- 引用来源。
- 检索质量评估。
- 幻觉控制。

能干嘛：

- 做公司内部文档问答。
- 做学习资料问答。
- 做项目代码文档问答。
- 做爬虫采集数据的智能检索。

做到什么程度：

```text
回答必须基于检索到的资料，并能返回引用来源。
```

练习项目：

```text
projects/learning_rag/
```

注意：

```text
RAG 不是把文档全塞给模型，而是先检索相关片段，再让模型基于片段回答。
```

---

## 能力 5：AI 工作流

学什么：

- 顺序流程。
- 条件分支。
- 循环重试。
- 人工确认节点。
- 多步骤任务拆分。
- 状态保存。
- 失败恢复。

能干嘛：

- 自动处理采集文章：清洗 -> 摘要 -> 打标签 -> 入库 -> 生成题目。
- 自动分析岗位：抽取技能 -> 对比学习计划 -> 生成补弱建议 -> 生成简历描述。
- 自动处理客服/工单：分类 -> 补充信息 -> 查询系统 -> 生成回复草稿。

做到什么程度：

```text
能把一个 AI 功能拆成多个稳定节点，而不是一个超长 Prompt 解决所有问题。
```

练习项目：

```text
projects/ai_workflow_lab/
```

典型流程：

```text
输入文章
  -> 清洗文本
  -> AI 生成摘要
  -> AI 生成关键词
  -> 规则校验 JSON
  -> 人工确认
  -> 入库
```

---

## 能力 6：Agent

学什么：

- Agent 和 Workflow 的区别。
- 工具列表。
- 状态。
- 计划与执行。
- 观察结果。
- 终止条件。
- 防止无限循环。
- 权限控制。

能干嘛：

- 做一个学习助教 Agent。
- 做一个项目排障 Agent。
- 做一个数据采集任务助手。
- 做一个能调用工具查询资料和生成计划的岗位分析助手。

做到什么程度：

```text
先会做受控 Agent，不追求完全自动化。Agent 必须有工具边界、最大轮数、日志和人工确认点。
```

练习项目：

```text
projects/study_agent/
```

不要一开始追复杂多 Agent。先做：

```text
一个模型 + 三个工具 + 明确停止条件 + 日志
```

---

## 能力 7：多模态

学什么：

- 图片理解。
- OCR。
- 截图分析。
- 表格/文档解析。
- 图片和文本结合的输入输出。

能干嘛：

- 分析网页截图。
- 分析验证码实验样例。
- 处理 PDF、图片、扫描件。
- 做网页异常截图分析。

做到什么程度：

```text
能把图片、文本、结构化数据结合起来处理，而不是只会纯文本问答。
```

练习项目：

```text
projects/multimodal_ocr_lab/
```

---

## 能力 8：评估、日志、成本与安全

学什么：

- Prompt 版本管理。
- 输入输出日志。
- 结果评估。
- 人工抽检。
- 成本统计。
- 缓存。
- 限流。
- 敏感信息脱敏。
- API Key 管理。
- LLM 输出不可信原则。

能干嘛：

- 让 AI 功能能上线试用。
- 找到错误样例。
- 控制 API 成本。
- 避免泄露公司数据。
- 避免 Agent 乱调用工具。

做到什么程度：

```text
每个 AI 项目都能回答：准确率怎么样？失败样例在哪？一次调用多少钱？日志在哪？敏感数据怎么处理？
```

练习项目：

```text
projects/ai_eval_lab/
```

---

## 3. 主流 AI 应用技能清单

按现在主流 AI 应用开发，建议掌握这些：

```text
Prompt Engineering
Structured Outputs
Function Calling / Tool Calling
RAG
Agentic RAG
Workflow
Agent
多模态输入
文档解析
向量数据库
Embedding
结果评估
Prompt 版本管理
Observability / Trace
成本控制
缓存
权限和安全
人机协同
低代码 AI 平台使用
```

对应常见工具：

```text
OpenAI / OpenAI-compatible API
LangChain
LangGraph
LlamaIndex
Dify
FastAPI / Django / DRF
PostgreSQL / pgvector
Qdrant / Milvus / Chroma
Redis
Celery
LangSmith / Langfuse / OpenTelemetry
```

---

## 4. 与你现有学习路线怎么结合

## Python 基础阶段

AI 用法：

- 让 AI 解释概念。
- 让 AI 根据代码出题。
- 让 AI Review 代码。

目标：

```text
提升学习效率，但不替代自己写代码。
```

## 爬虫阶段

AI 用法：

- 分析网页请求。
- 总结字段。
- 生成解析规则初稿。
- 对采集数据做摘要和分类。

目标：

```text
把 AI 当数据处理助手，不当绕过工具。
```

## Django 阶段

AI 用法：

- 生成接口设计草稿。
- 生成 Serializer 字段。
- 生成测试用例。
- 辅助阅读公司魔改框架。

目标：

```text
把 AI 接进 Web 系统，而不是停留在命令行脚本。
```

## 项目阶段

AI 用法：

- JD 分析。
- 学习计划生成。
- 数据摘要和标签。
- RAG 问答。
- Agent 工具调用。

目标：

```text
做出能放进简历的 AI 应用项目。
```

---

## 5. 推荐学习顺序

先学最容易落地的：

```text
1. Prompt 与上下文管理
2. 结构化输出 JSON
3. LLM API 调用
4. Function Calling / Tool Calling
5. RAG
6. Workflow
7. Agent
8. 评估、日志、成本、安全
9. 多模态
10. 低代码 AI 平台
```

不建议一上来就学：

```text
复杂多 Agent
大规模微调
模型训练
一堆框架混用
没有评估的 RAG
没有权限边界的自动化 Agent
```

---

## 6. 你至少要做出的 4 个 AI 项目

## 项目 1：JD 岗位分析器

用途：

- 输入招聘 JD。
- 输出岗位类型、技能标签、能力缺口、学习建议。

价值：

- 直接服务求职。
- 练结构化输出。
- 练 Prompt 和 JSON 校验。

目录：

```text
projects/jd_analyzer/
```

## 项目 2：学习资料 RAG 问答

用途：

- 对本仓库 Markdown 学习资料问答。
- 回答时返回引用来源。

价值：

- 练 RAG。
- 以后能做公司文档问答。

目录：

```text
projects/learning_rag/
```

## 项目 3：AI 文章处理工作流

用途：

- 输入采集文章。
- 自动摘要、关键词、分类、生成题目、入库。

价值：

- 结合爬虫和 Django。
- 练 AI 工作流。

目录：

```text
projects/article_ai_workflow/
```

## 项目 4：学习助教 Agent

用途：

- 根据错题、笔记、学习计划生成复习任务。
- 调用工具查询本地学习资料。

价值：

- 练 Agent 和 Tool Calling。
- 不追求复杂，重点是受控、可解释、可停止。

目录：

```text
projects/study_agent/
```

---

## 7. 面试时要能讲清楚

你要能回答：

- Prompt、RAG、Agent、Workflow 的区别是什么？
- 为什么结构化输出比纯文本输出更适合接入业务系统？
- Function Calling 本质解决什么问题？
- RAG 为什么需要切分、检索和引用来源？
- Workflow 和 Agent 应该怎么选？
- AI 输出为什么不能直接信？
- 如何评估 AI 功能效果？
- 如何记录日志、控制成本、防止泄露敏感信息？
- 如果模型回答错了，你怎么定位问题？

---

## 8. 学到什么程度算有用

最低可用标准：

```text
能调用 LLM API。
能让模型输出稳定 JSON。
能把 AI 结果入库。
能做一个 Django/DRF AI 接口。
能做一个简单 RAG。
能让模型调用 2-3 个受控工具。
能记录日志、失败样例和成本。
```

简历可写标准：

```text
做出一个 AI + Django/DRF 项目。
做出一个 AI + 爬虫数据处理项目。
做出一个 RAG 或 Agent 小项目。
能讲清楚准确率、失败样例、成本控制和安全边界。
```

这才叫学有所用，学而知之。

