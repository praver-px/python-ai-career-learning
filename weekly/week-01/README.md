# Week 01 - Python 环境与基础语法

这一周不用再自己到处找资料，直接按本目录的学习包走。

## 本周学习顺序

1. 先读 `学习讲义.md`，里面已经把本周要学的内容、概念解释、代码例子、每天安排写清楚。
2. 再做 `练习题.md`，每天做对应练习。
3. 最后完成 `log_analyzer.py` 作业。

## 本周要打开的文件

```text
weekly/week-01/学习讲义.md
weekly/week-01/练习题.md
weekly/week-01/sample_access.log
notes/week-01.md
src/week01/log_analyzer.py
```

## 本周学习目标

- 会创建和使用 Python 虚拟环境。
- 会运行 Python 文件。
- 理解变量、字符串、数字、布尔值。
- 掌握 `list`、`dict`、`set`、`tuple` 的基础用法。
- 掌握 `if`、`for`、`while`。
- 会用 `pathlib` 读取文件。
- 会用字典统计日志中的 IP、状态码、URL。

## 本周最终作业

写 `src/week01/log_analyzer.py`：

- 读取日志文件。
- 统计总行数。
- 统计访问量 Top 10 IP。
- 统计状态码数量。
- 统计访问量 Top 10 URL。
- 输出分析结果。

## 验收标准

- 能运行：`python src/week01/log_analyzer.py weekly/week-01/sample_access.log`
- 不写死文件路径。
- 使用函数拆分逻辑。
- 至少使用 `list`、`dict`、`for`、`if`、`pathlib`。
- 在 `notes/week-01.md` 写学习复盘。
- 完成一次 Git commit。

