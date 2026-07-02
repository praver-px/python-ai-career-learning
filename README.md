# Python / Django / 爬虫 / AI 学习与求职仓库

目标：围绕中国市场的 Python 后端、Django、数据采集、AI 应用开发岗位，建立一套可持续学习、练习、项目沉淀和简历投递体系。

## 仓库结构

```text
python-ai-career-learning/
  学习总计划.md                 # 最外层总计划，先读这个
  README.md
  docs/
    original/                  # 之前生成的原始学习文档归档
  weekly/                      # 按周学习计划
  projects/                    # 项目路线与项目说明
  exercises/                   # 练习题与作业要求
  prompts/                     # AI 提示词库，方便脱离 Codex 后继续使用
  resume/                      # 简历、投递、面试准备
  market-research/             # 岗位调研与能力矩阵
  notes/                       # 日常学习笔记
  src/                         # 后续代码练习区
```

## 学习定位

主目标不是“只学爬虫”，而是组合成更有市场弹性的能力：

```text
Python 工程基础
  + Django / DRF / 公司魔改框架阅读
  + 数据采集 / 清洗 / 入库
  + AI 应用开发 / RAG / Agent 基础
  + 项目交付 / 简历表达 / 面试准备
```

## 推荐阅读顺序

1. `学习总计划.md`
2. `详细学习资源与周计划.md`
3. `实战反爬与市场路线.md`
4. `轮子复用与源码阅读规范.md`
5. `AI应用学习路线.md`
6. `weekly/全周期学习资料索引.md`
7. `market-research/岗位能力矩阵.md`
8. `weekly/20周学习计划.md`
9. `projects/项目路线.md`
10. `resume/简历与投递策略.md`
11. `prompts/AI学习提示词库.md`

## 版本管理

本目录已设计为独立 Git 仓库。建议每周至少提交一次：

```bash
git add .
git commit -m "week-01: python foundation notes and exercises"
```

如果要同步到 GitHub：

```bash
git remote add origin https://github.com/<your-name>/python-ai-career-learning.git
git branch -M main
git push -u origin main
```

注意：不要提交 `.env`、API key、Cookie、公司代码、内部文档和隐私数据。
