# Python / Web / 爬虫 / Django / AI 综合学习方案 2026 版

这份方案是在原有三份文档基础上的升级版：

- `python_web_spider_learning_plan.md`：原始路线图。
- `python_web_spider_detailed_course.md`：Python/Web/爬虫/Django 讲义。
- `python_learning_learn_anything_upgrade.md`：用 AI 做学习教练的方法。

本方案解决一个新的现实问题：

> Codex 续费即将到期，后续不能假设一直有强 AI 助手陪跑；同时 AI 时代又必须补上 AI 使用和 AI 开发能力。

所以学习目标要调整为：

```text
从“我会用 AI 对话完成任务”
升级为
“我能低成本、可迁移地使用 AI 学习和开发，并能把 AI 能力接入 Python/Web/爬虫/Django 项目”
```

---

## 1. 新的总目标

学完后你应该具备五类能力：

1. Python 工程基础：能独立写脚本、拆模块、写日志、处理异常、做测试。
2. 爬虫能力：能分析 HTTP 请求、解析页面、保存数据、处理失败重试和反爬风险。
3. Django 工作能力：能读懂公司魔改 Django 框架，理解 URL、Middleware、View、Serializer、ORM、Response 链路。
4. AI 使用能力：能用低成本工具辅助学习、写代码、复盘、生成练习，而不是依赖某一个订阅产品。
5. AI 开发能力：能调用大模型 API，做简单 RAG、文本分类、信息抽取、AI 辅助爬虫和 Django AI 接口。

---

## 2. 学习路线总览

建议分成 6 个阶段：

```text
阶段 1：Python 基础与工程习惯
阶段 2：HTTP 与爬虫核心
阶段 3：数据库与 Django 工作能力
阶段 4：AI 使用能力，低成本学习法
阶段 5：AI 开发基础，API / Prompt / RAG / Agent
阶段 6：综合项目，AI + 爬虫 + Django
```

如果每天 1.5 到 2 小时，建议周期是 20 周。

时间紧可以压缩为：

```text
Python 基础：3 周
爬虫核心：4 周
Django：4 周
AI 使用：2 周
AI 开发：4 周
综合项目：3 周
```

---

# 第一部分：现实使用策略

## 3. Codex 到期后怎么继续学

你不应该把学习系统绑死在 Codex 上。

建议采用“三层学习工具”：

```text
第一层：离线资料
  Markdown 文档、官方文档、自己写的 README、错题本。

第二层：低成本 AI
  免费额度模型、网页 AI、第三方 API、公司已有 AI 工具、本地模型。

第三层：高质量 AI
  只在关键节点使用，例如项目设计、复杂 bug、代码 review、综合项目重构。
```

### 3.1 平时不用高级 AI 做什么

这些事情不值得消耗高级 AI：

- 查语法。
- 解释简单报错。
- 生成普通 CRUD。
- 写很小的练习题。
- 翻译文档。

这些可以用：

- 官方文档。
- 搜索引擎。
- 免费网页 AI。
- 本地笔记。

### 3.2 高级 AI 应该用在什么地方

高级 AI 应该用在高价值场景：

- 给公司 Django 魔改框架梳理调用链。
- 设计综合项目架构。
- Review 你写的爬虫或 Django 代码。
- 分析复杂反爬请求。
- 设计 RAG / Agent 方案。
- 帮你制定下一阶段学习计划。

### 3.3 没有 Codex 时的学习闭环

你可以这样学：

```text
1. 看本地 Markdown 讲义
2. 自己写代码
3. 用普通 AI 问概念
4. 用 pytest 检查结果
5. 用 README 做复盘
6. 每周只用一次高级 AI 做 code review
```

---

# 第二部分：Python / Web / 爬虫 / Django 主线

## 4. 保留原来的主线，但调整顺序

你当前工作偏爬虫和 Django，所以不需要按大学课程那样慢慢学。

推荐顺序：

```text
1. Python 函数、模块、文件、异常、日志
2. HTTP、requests、开发者工具
3. HTML / JSON / XPath / CSS 解析
4. SQLite / MySQL / ORM
5. Django URL / View / Model / Middleware
6. DRF 或公司 API 基类
7. Scrapy / Playwright / 异步
8. AI 接入
```

---

## 5. 每周学习模板

每周固定产出：

```text
1 个主题笔记
1 个可运行练习
1 个小作业
1 份 README
1 组复习题
```

每周目录：

```text
week-xx-topic/
  README.md
  notes.md
  practice/
  homework/
  tests/
```

README 固定模板：

```markdown
# 本周主题

## 我学了什么

## 我写了什么代码

## 遇到的问题

## 解决方法

## 仍然不懂的点

## 下次复习问题
```

---

# 第三部分：AI 使用能力

## 6. AI 使用能力不是“会聊天”

你现在已经会用 AI 对话完成一些任务，这是第一层能力。

下一步要升级到：

```text
1. 会拆任务
2. 会给上下文
3. 会验证结果
4. 会要求 AI 批改
5. 会沉淀提示词
6. 会控制成本
7. 会判断什么时候不用 AI
```

---

## 7. 必学的 AI 使用主题

### 7.1 Prompt 基础

要学：

- 角色设定。
- 上下文输入。
- 任务边界。
- 输出格式。
- 示例驱动。
- 分步执行。
- 让 AI 先提问。
- 让 AI 自检。

练习：

```text
让 AI 解释一个 Django Middleware。
要求它输出：
1. 概念
2. 请求链路位置
3. 最小代码
4. 公司魔改场景
5. 3 个自测题
```

### 7.2 AI 学习法

要学：

- 费曼学习法。
- 苏格拉底式追问。
- 间隔复习。
- 错题本。
- 代码 review。

练习：

```text
学习 requests timeout 和 retry。
让 AI 先讲，再出题，再批改，再让你重写代码。
```

### 7.3 AI 代码协作

要学：

- 如何让 AI 读代码。
- 如何让 AI 找 bug。
- 如何让 AI 生成测试。
- 如何让 AI review。
- 如何让 AI 不乱改。

推荐提示词：

```text
请作为高级 Python 工程师 review 我的代码。
重点看：
1. 逻辑错误
2. 异常处理
3. 可维护性
4. 日志
5. 测试缺失

请先列问题，不要直接重写。
```

### 7.4 成本控制

要学：

- 不把大文件整段贴给 AI。
- 先让 AI 看目录，再看关键文件。
- 把问题缩小到一个函数或一个调用链。
- 用本地文档沉淀常见解释。
- 复杂问题再用高级模型。

工作习惯：

```text
简单问题：搜索 / 文档 / 免费 AI
中等问题：普通模型
复杂问题：高级模型
长期知识：写成本地笔记
```

---

# 第四部分：AI 开发基础

## 8. AI 开发能力学习路线

AI 开发不要一开始就追多 Agent、工作流平台。先学最小闭环：

```text
Prompt
  -> API 调用
  -> 结构化输出
  -> 工具调用
  -> RAG
  -> Agent
  -> 接入 Django
```

---

## 9. 第 1 阶段：大模型 API 调用

目标：

```text
能用 Python 调用一个大模型接口，完成问答、总结、信息抽取。
```

要学：

- API key。
- base_url。
- model。
- messages。
- system / user / assistant。
- temperature。
- max_tokens。
- streaming。
- 错误重试。
- 超时。

最小练习：

```python
from openai import OpenAI

client = OpenAI(
    api_key="YOUR_API_KEY",
    base_url="YOUR_BASE_URL",
)

response = client.chat.completions.create(
    model="YOUR_MODEL",
    messages=[
        {"role": "system", "content": "你是一个 Python 老师"},
        {"role": "user", "content": "解释 requests 的 timeout 参数"},
    ],
)

print(response.choices[0].message.content)
```

作业：

```text
写一个 ai_explain.py：
输入一个 Python 概念，输出：
1. 简短解释
2. 代码示例
3. 工作场景
4. 练习题
```

---

## 10. 第 2 阶段：结构化输出

目标：

```text
让 AI 输出稳定 JSON，而不是一大段不可控文本。
```

适合场景：

- 从网页正文里抽取标题、作者、时间。
- 从接口文档里抽取字段。
- 从日志里抽取错误原因。
- 生成学习题目。

练习：

```text
输入一段文章，让 AI 输出：
{
  "title": "...",
  "author": "...",
  "publish_time": "...",
  "summary": "...",
  "keywords": []
}
```

作业：

```text
写一个 ai_extract_article.py：
读取 articles.jsonl，
调用 AI 为每篇文章生成 summary 和 keywords，
保存到 articles_ai.jsonl。
```

---

## 11. 第 3 阶段：RAG

RAG 是 Retrieval-Augmented Generation，意思是：

```text
先从你的资料里检索相关内容，再让 AI 根据检索结果回答。
```

它解决的问题：

```text
AI 不知道你公司的项目文档。
AI 容易胡说。
上下文太长不能全塞。
```

最小 RAG 不一定要向量数据库。初期可以这样做：

```text
1. 把 Markdown 文档切成小块
2. 用关键词搜索找到相关块
3. 把相关块交给 AI
4. 要求 AI 只基于材料回答
```

进阶再学：

- embedding。
- 向量数据库。
- chunk。
- top_k。
- rerank。
- citation。

作业：

```text
基于你自己的 Python 学习文档做一个问答脚本：
输入问题：
  Django 中间件在请求链路哪里？
脚本先检索文档，再让 AI 回答。
```

---

## 12. 第 4 阶段：Agent

Agent 不要神化。最简单的 Agent 就是：

```text
模型 + 工具 + 循环 + 状态
```

你要理解：

- 模型负责判断。
- 工具负责执行。
- 状态负责记忆。
- 规则负责限制。

适合你的 Agent 项目：

```text
爬虫学习助教 Agent：
1. 读取你的学习进度
2. 根据薄弱点出题
3. 批改代码
4. 安排复习
```

不建议一开始做：

- 多 Agent 协作平台。
- 自动操作浏览器买东西。
- 自动改生产代码。

---

## 13. 第 5 阶段：AI 接入 Django

目标：

```text
把 AI 能力接到 Web 项目里。
```

推荐接口：

```text
POST /api/ai/explain/
POST /api/ai/extract/
POST /api/ai/summarize/
POST /api/ai/quiz/
```

基本结构：

```text
django_ai_project/
  ai/
    views.py
    services.py
    prompts.py
    schemas.py
  articles/
  crawler/
```

原则：

- View 不直接拼 prompt。
- Prompt 放到 `prompts.py`。
- API 调用放到 `services.py`。
- 输入输出要校验。
- 日志不能记录完整敏感内容。
- API key 放环境变量。

作业：

```text
做一个 Django AI 学习接口：
输入 topic，
返回：
1. explanation
2. examples
3. exercises
4. quiz
```

---

# 第五部分：AI + 爬虫结合

## 14. AI 在爬虫里的实际用途

AI 不适合替代所有解析逻辑。结构稳定的数据，仍然应该用 XPath / CSS / JSON。

AI 适合：

- 非结构化正文摘要。
- 新闻分类。
- 关键词提取。
- 字段容错抽取。
- 页面结构变化后的辅助分析。
- 自动生成 XPath 候选。
- 日志错误归因。

不适合：

- 高频大规模逐条调用。
- 解析规则明确的列表页。
- 需要强一致的核心字段。
- 敏感数据直接上传。

---

## 15. AI 爬虫作业

### 作业 1：AI 摘要

```text
采集文章标题和正文。
用 AI 生成摘要。
保存 title、url、summary。
```

### 作业 2：AI 分类

```text
给文章自动分类：
技术 / 娱乐 / 财经 / 游戏 / 其他
要求输出 JSON。
```

### 作业 3：AI 解析错误诊断

```text
当 XPath 提取不到标题时：
保存 HTML 片段。
让 AI 分析可能的新选择器。
```

### 作业 4：AI + Django 展示

```text
Django 后台展示采集文章。
点击“生成摘要”按钮后调用 AI。
摘要入库。
```

---

# 第六部分：综合项目

## 16. 综合项目：AI 采集学习平台

这是最适合你的最终项目。

功能：

```text
1. Django 管理采集任务
2. 爬虫采集文章
3. AI 生成摘要和标签
4. AI 根据文章生成学习题
5. 页面展示结果
6. 支持搜索
7. 支持失败重试
8. 支持日志查看
```

推荐模块：

```text
collector_ai_platform/
  manage.py
  config/
  common/
    response.py
    logging.py
  crawler/
    services.py
    parsers.py
  articles/
    models.py
    views.py
  ai/
    client.py
    prompts.py
    services.py
    schemas.py
  learning/
    quiz.py
    review.py
```

阶段性目标：

```text
v1：Django + SQLite + 手动新增文章
v2：加入 requests 爬虫
v3：加入 AI 摘要
v4：加入 AI 题目生成
v5：加入任务状态和日志
v6：部署和 README
```

---

# 第七部分：低成本学习方案

## 17. 没有 Codex 时怎么继续

你可以用下面组合：

```text
本地 Markdown 文档：主教材
VS Code / PyCharm：写代码
pytest：自动检查
普通网页 AI：解释概念
第三方 API：练 AI 开发
每周一次高级 AI：做 review
```

### 17.1 自己构建“AI 助教提示词库”

建一个文件：

```text
prompts/
  explain.md
  quiz.md
  review.md
  debug.md
  django-framework-reading.md
```

这样你换任何 AI 工具都能继续学。

### 17.2 固定提示词

解释：

```text
请作为 Python Web 和爬虫老师解释这个概念。
要求：先讲工作场景，再讲原理，再给代码，再给练习题。
```

批改：

```text
请按初级 Python 工程师标准 review 我的代码。
优先指出 bug、异常处理、日志、可维护性和测试缺失。
```

复盘：

```text
我本周学了这些内容，请帮我生成复盘：
1. 掌握点
2. 薄弱点
3. 错题
4. 下周计划
```

---

# 第八部分：20 周计划

## 第 1-3 周：Python 工程基础

主题：

- 函数。
- 模块。
- 文件。
- JSON / CSV。
- 异常。
- 日志。
- pytest。

AI 内容：

- 学会让 AI 解释概念。
- 学会让 AI 批改小脚本。

产出：

```text
文本清洗工具
日志分析工具
CSV 用户管理工具
```

---

## 第 4-7 周：爬虫核心

主题：

- HTTP。
- requests。
- Session。
- Cookie。
- Header。
- XPath。
- BeautifulSoup。
- SQLite 存储。
- 重试和断点续爬。

AI 内容：

- 用 AI 分析请求差异。
- 用 AI 生成解析规则候选。
- 用 AI 批改爬虫结构。

产出：

```text
健壮版新闻采集器
SQLite 入库
失败重试
日志记录
```

---

## 第 8-11 周：Django 与公司框架

主题：

- Django 项目结构。
- URL。
- View。
- Model。
- ORM。
- Middleware。
- DRF。
- BaseAPIView。
- 公司魔改框架阅读。

AI 内容：

- 让 AI 画请求链路。
- 让 AI 根据代码解释 BaseView。
- 让 AI 生成接口测试。

产出：

```text
Django 文章查询系统
Django 采集任务管理接口
公司项目阅读报告模板
```

---

## 第 12-13 周：AI 使用能力

主题：

- Prompt。
- 任务拆解。
- 上下文管理。
- AI code review。
- AI 学习法。
- 成本控制。

产出：

```text
prompts/ 提示词库
个人 AI 使用规范
学习复盘模板
```

---

## 第 14-17 周：AI 开发基础

主题：

- 大模型 API。
- 结构化输出。
- 流式响应。
- 错误重试。
- RAG。
- 简单 Agent。

产出：

```text
ai_explain.py
ai_extract_article.py
markdown_rag_qa.py
Django AI explain API
```

---

## 第 18-20 周：综合项目

主题：

- Django + 爬虫 + AI。
- 任务管理。
- 文章摘要。
- 题目生成。
- 搜索。
- 日志。

最终产出：

```text
AI 采集学习平台
README
接口文档
项目复盘
```

---

# 第九部分：每周复盘问题

每周问自己：

```text
1. 这个知识点不用 AI 我能不能讲清楚？
2. 这个功能不用 AI 我能不能写出第一版？
3. AI 给我的代码我能不能判断对错？
4. 这个知识点在爬虫里怎么用？
5. 这个知识点在 Django 项目里怎么用？
6. 如果公司项目里出现类似代码，我能不能读懂？
7. 本周我沉淀了什么笔记？
```

---

# 第十部分：最终建议

你接下来不要把目标定成“学会所有 AI 工具”。

更正确的目标是：

```text
我能独立做 Python/Web/爬虫/Django 工作；
AI 是我的加速器，不是拐杖；
我能把 AI 能力接进自己的项目；
即使没有 Codex，我也能靠文档、代码、测试和低成本 AI 继续学习。
```

最优先开始的三个主题：

```text
1. django-drf-and-company-framework
2. ai-api-basic
3. ai-assisted-crawler
```

第一周建议从这里开始：

```text
主题：Django 公司魔改框架阅读 + AI 辅助读代码

作业：
1. 找一个 Django 项目。
2. 画出 URL -> Middleware -> View -> Service -> ORM -> Response 链路。
3. 写一份阅读报告。
4. 用 AI 帮你提问，但最终用自己的话总结。
```

