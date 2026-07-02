# Python Web 与爬虫开发详细课程讲义

这份文档不是单纯的路线图，而是一份可以按顺序学习的讲义。它会回答三个问题：

1. 这个知识点是什么。
2. 工作中为什么会用到。
3. 学完以后应该写什么代码巩固。

你的工作主线是爬虫，同时公司项目偏 Django 魔改框架，所以学习顺序应该是：

```text
Python 基础能力
  -> HTTP 与爬虫
  -> 数据库与数据建模
  -> Django Web 开发
  -> 公司魔改 Django 框架阅读方法
  -> 异步、Scrapy、Playwright
  -> 工程化与综合项目
```

建议学习周期：16 到 24 周。

---

## 0. 学习方法

不要把 Python 学成“背语法”。真正工作中遇到的问题通常是：

- 这个函数为什么返回 `None`？
- 请求明明浏览器能访问，代码为什么 403？
- 爬虫跑一会儿为什么挂？
- Django 项目入口在哪里？
- 一个接口从 URL 到数据库中间经过了哪些层？
- 公司封装的框架到底改了 Django 的哪里？

所以每学一个知识点，都要追问它在下面几个场景里的作用：

- 写脚本。
- 发 HTTP 请求。
- 解析网页。
- 保存数据。
- 写 API。
- 排查线上问题。

每一章建议你按这个节奏学：

1. 看讲解。
2. 手敲示例代码。
3. 不看文档重写一遍。
4. 完成本章作业。
5. 写一段复盘笔记。

---

# 第一部分：Python 基础能力

## 1. Python 程序是如何运行的

### 1.1 你需要理解的概念

Python 是解释型语言。你写的 `.py` 文件会被 Python 解释器读取并执行。

一个最小程序：

```python
print("hello python")
```

执行方式：

```bash
python hello.py
```

工作中你会看到几种运行方式：

```bash
python script.py
python manage.py runserver
python -m pytest
uvicorn app.main:app --reload
scrapy crawl news
```

这些本质都是“用某个入口启动 Python 代码”。

### 1.2 虚拟环境是什么

虚拟环境用于隔离项目依赖。项目 A 可能用 Django 3，项目 B 可能用 Django 4，如果都装到系统 Python 里，很容易冲突。

创建虚拟环境：

```bash
python -m venv .venv
```

Windows 激活：

```bash
.venv\Scripts\activate
```

安装依赖：

```bash
pip install requests django
```

导出依赖：

```bash
pip freeze > requirements.txt
```

### 1.3 工作中的常见坑

- 没激活虚拟环境，导致安装到了全局 Python。
- IDE 使用的解释器和终端使用的解释器不是同一个。
- `requirements.txt` 没更新，别人拉代码跑不起来。

### 作业

创建一个 `python-learning` 目录：

```text
python-learning/
  .venv/
  week01/
    hello.py
  requirements.txt
```

要求：

- 创建虚拟环境。
- 安装 `requests`。
- 写 `hello.py` 打印当前 Python 版本。
- 导出 `requirements.txt`。

---

## 2. 变量、类型与数据结构

### 2.1 变量是什么

变量是给数据取名字。

```python
name = "Tom"
age = 18
price = 19.8
is_active = True
```

Python 不需要提前声明类型，但数据本身有类型。

```python
print(type(name))      # <class 'str'>
print(type(age))       # <class 'int'>
print(type(price))     # <class 'float'>
print(type(is_active)) # <class 'bool'>
```

### 2.2 字符串

爬虫里字符串非常重要，因为网页源码、URL、请求头、JSON 字段多数都是字符串。

```python
title = " Python 爬虫入门 "

print(title.strip())       # 去掉首尾空白
print(title.replace(" ", ""))  # 替换
print(title.startswith(" "))   # 是否以某内容开头
print("爬虫" in title)         # 是否包含
```

格式化字符串推荐使用 f-string：

```python
page = 3
url = f"https://example.com/articles?page={page}"
```

### 2.3 列表 list

列表用于保存一组有顺序的数据。

```python
urls = [
    "https://example.com/page/1",
    "https://example.com/page/2",
    "https://example.com/page/3",
]

for url in urls:
    print(url)
```

爬虫中列表经常用于：

- 保存待采集 URL。
- 保存解析后的数据。
- 保存失败任务。

### 2.4 字典 dict

字典保存键值对。它是爬虫和 Web 中最常用的数据结构之一。

```python
article = {
    "title": "Python 爬虫入门",
    "url": "https://example.com/a/1",
    "author": "Tom",
}

print(article["title"])
print(article.get("publish_time", "未知"))
```

请求头也是字典：

```python
headers = {
    "User-Agent": "Mozilla/5.0",
    "Referer": "https://example.com",
}
```

JSON 数据在 Python 中通常也是字典或列表。

### 2.5 集合 set

集合用于去重。

```python
visited_urls = set()

url = "https://example.com/a/1"
if url not in visited_urls:
    visited_urls.add(url)
    print("开始采集")
```

爬虫中经常用集合做临时去重，但真正长期去重应该依赖数据库唯一索引。

### 本章作业

写 `basic_data_practice.py`：

1. 准备 10 条文章数据，每条是一个字典，字段包括 `title`、`url`、`status_code`。
2. 统计状态码为 `200` 的文章数量。
3. 找出重复 URL。
4. 输出标题中包含 `Python` 的文章。

---

## 3. 函数：把重复逻辑封装起来

### 3.1 函数是什么

函数是一段可以重复调用的代码。

```python
def clean_text(text):
    return text.strip().replace("\n", "")

title = clean_text("  Python\n ")
print(title)
```

爬虫里常见函数：

```python
def fetch_html(url):
    pass

def parse_list_page(html):
    pass

def save_to_csv(items):
    pass
```

这三个函数分别对应：

- 请求。
- 解析。
- 存储。

### 3.2 参数和返回值

```python
def build_url(page, keyword="python"):
    return f"https://example.com/search?q={keyword}&page={page}"
```

使用：

```python
print(build_url(1))
print(build_url(2, keyword="django"))
```

### 3.3 不推荐的写法

```python
def parse():
    print("解析完成")
```

如果函数只打印，不返回数据，后续代码就很难复用。

推荐：

```python
def parse():
    return {"title": "文章标题"}
```

### 本章作业

把下面三个能力分别封装成函数：

1. `build_page_url(page)`：生成分页 URL。
2. `clean_text(text)`：清洗文本。
3. `extract_domain(url)`：提取域名。

然后写一个主函数 `main()` 调用它们。

---

## 4. 文件、JSON、CSV

### 4.1 文件读写

```python
from pathlib import Path

path = Path("data.txt")
path.write_text("hello", encoding="utf-8")

content = path.read_text(encoding="utf-8")
print(content)
```

推荐用 `pathlib`，比手写字符串路径更清晰。

### 4.2 JSON

JSON 适合保存结构化数据。

```python
import json

article = {
    "title": "Python 爬虫",
    "url": "https://example.com/a/1",
}

with open("article.json", "w", encoding="utf-8") as f:
    json.dump(article, f, ensure_ascii=False, indent=2)
```

读取：

```python
with open("article.json", "r", encoding="utf-8") as f:
    data = json.load(f)
```

### 4.3 JSONL

JSONL 是一行一个 JSON，适合爬虫增量写入。

```python
import json

items = [
    {"title": "A", "url": "https://example.com/a"},
    {"title": "B", "url": "https://example.com/b"},
]

with open("articles.jsonl", "w", encoding="utf-8") as f:
    for item in items:
        f.write(json.dumps(item, ensure_ascii=False) + "\n")
```

### 4.4 CSV

CSV 适合表格数据。

```python
import csv

items = [
    {"title": "A", "url": "https://example.com/a"},
    {"title": "B", "url": "https://example.com/b"},
]

with open("articles.csv", "w", encoding="utf-8-sig", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["title", "url"])
    writer.writeheader()
    writer.writerows(items)
```

Windows 下用 Excel 打开 CSV，推荐 `utf-8-sig`，否则中文可能乱码。

### 本章作业

写 `article_storage.py`：

- 准备 5 条文章数据。
- 保存为 JSON。
- 保存为 JSONL。
- 保存为 CSV。
- 再分别读取回来并打印。

---

## 5. 异常与日志

### 5.1 为什么需要异常处理

爬虫和 Web 项目里，失败是常态：

- 网络超时。
- 页面结构变化。
- 数据库连接失败。
- 字段缺失。

不能让一个 URL 失败就导致整个程序退出。

```python
try:
    number = int("abc")
except ValueError as e:
    print(f"转换失败: {e}")
```

### 5.2 爬虫请求中的异常

```python
import requests

def fetch(url):
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        return response.text
    except requests.Timeout:
        print("请求超时")
    except requests.RequestException as e:
        print(f"请求失败: {e}")
    return None
```

### 5.3 日志 logging

`print` 适合学习，`logging` 适合项目。

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
    filename="app.log",
    encoding="utf-8",
)

logging.info("任务开始")
logging.warning("字段缺失")
logging.error("请求失败")
```

### 本章作业

改造前面的请求函数：

- 请求失败时不崩溃。
- 记录失败 URL。
- 日志写入 `spider.log`。
- 返回 `None` 表示失败。

---

# 第二部分：HTTP 与爬虫

## 6. HTTP 是爬虫的核心

### 6.1 一次 HTTP 请求包含什么

当浏览器打开网页时，大致发生：

1. 浏览器发送请求。
2. 服务器处理请求。
3. 服务器返回响应。
4. 浏览器渲染 HTML、CSS、JS。

请求通常包含：

- URL。
- Method：GET、POST。
- Headers。
- Cookies。
- Query 参数。
- Body。

响应通常包含：

- Status Code。
- Response Headers。
- Response Body。

### 6.2 GET 请求

```python
import requests

url = "https://httpbin.org/get"
params = {"q": "python", "page": 1}

response = requests.get(url, params=params, timeout=10)
print(response.status_code)
print(response.text)
```

### 6.3 POST 请求

```python
import requests

url = "https://httpbin.org/post"
payload = {"username": "tom", "password": "123456"}

response = requests.post(url, json=payload, timeout=10)
print(response.json())
```

### 6.4 Header 为什么重要

很多网站会判断请求是否像浏览器。

```python
headers = {
    "User-Agent": "Mozilla/5.0",
    "Accept": "text/html,application/xhtml+xml",
    "Referer": "https://example.com",
}
```

如果没有合适 Header，可能出现：

- `403 Forbidden`
- 返回空数据
- 跳转验证页

### 6.5 Cookie 与 Session

Cookie 是服务端给浏览器的一小段状态信息。

`requests.Session()` 可以保持 Cookie：

```python
import requests

session = requests.Session()
session.headers.update({"User-Agent": "Mozilla/5.0"})

session.get("https://example.com")
response = session.get("https://example.com/profile")
```

### 工作中的排查方法

当代码请求失败时，按顺序检查：

1. URL 是否一致。
2. 请求方法是否一致。
3. Query 参数是否一致。
4. Body 是否一致。
5. Header 是否缺失。
6. Cookie 是否缺失。
7. 是否有加密参数。
8. 是否触发频率限制。

### 本章作业

写 `http_compare.md`：

- 选择一个网页。
- 用浏览器开发者工具记录请求 URL、Method、Headers、Query。
- 用 Python 复刻请求。
- 对比浏览器响应和 Python 响应是否一致。

---

## 7. HTML 解析

### 7.1 HTML 是树

HTML 看起来是文本，本质上可以理解为树结构。

```html
<html>
  <body>
    <div class="article">
      <h2>标题</h2>
      <a href="/a/1">详情</a>
    </div>
  </body>
</html>
```

### 7.2 BeautifulSoup

```python
from bs4 import BeautifulSoup

html = """
<div class="article">
  <h2>Python 爬虫</h2>
  <a href="/a/1">详情</a>
</div>
"""

soup = BeautifulSoup(html, "html.parser")
title = soup.select_one(".article h2").get_text(strip=True)
link = soup.select_one(".article a")["href"]

print(title, link)
```

### 7.3 XPath

XPath 在爬虫项目中非常常见，尤其适合结构化提取。

```python
from lxml import etree

html = """
<div class="article">
  <h2>Python 爬虫</h2>
  <a href="/a/1">详情</a>
</div>
"""

tree = etree.HTML(html)
title = tree.xpath("//div[@class='article']/h2/text()")[0]
link = tree.xpath("//div[@class='article']/a/@href")[0]
```

### 7.4 解析时要做容错

不推荐：

```python
title = tree.xpath("//h2/text()")[0]
```

如果页面缺字段，会直接报错。

推荐：

```python
def first_or_none(values):
    return values[0].strip() if values else None

title = first_or_none(tree.xpath("//h2/text()"))
```

### 本章作业

写 `html_parser.py`：

- 准备一段文章列表 HTML。
- 提取标题、链接、作者、发布时间。
- 缺失字段返回 `None`。
- 结果保存为 JSONL。

---

## 8. 一个标准 requests 爬虫怎么写

标准结构：

```text
spider/
  main.py
  config.py
  fetcher.py
  parser.py
  storage.py
```

### 8.1 请求层

```python
# fetcher.py
import requests

def fetch_html(url, headers=None, timeout=10):
    response = requests.get(url, headers=headers, timeout=timeout)
    response.raise_for_status()
    return response.text
```

### 8.2 解析层

```python
# parser.py
from bs4 import BeautifulSoup

def parse_articles(html):
    soup = BeautifulSoup(html, "html.parser")
    items = []
    for node in soup.select(".article"):
        title_node = node.select_one(".title")
        link_node = node.select_one("a")
        items.append({
            "title": title_node.get_text(strip=True) if title_node else None,
            "url": link_node.get("href") if link_node else None,
        })
    return items
```

### 8.3 存储层

```python
# storage.py
import json

def save_jsonl(items, path):
    with open(path, "a", encoding="utf-8") as f:
        for item in items:
            f.write(json.dumps(item, ensure_ascii=False) + "\n")
```

### 8.4 入口

```python
# main.py
from fetcher import fetch_html
from parser import parse_articles
from storage import save_jsonl

def main():
    url = "https://example.com/articles"
    html = fetch_html(url)
    items = parse_articles(html)
    save_jsonl(items, "articles.jsonl")

if __name__ == "__main__":
    main()
```

### 本章作业

完成一个可运行的小爬虫，要求：

- 代码拆分为请求、解析、存储。
- 请求失败要记录日志。
- 数据保存为 JSONL。
- 重复 URL 不重复保存。

---

# 第三部分：数据库

## 9. SQLite 与 SQL 基础

### 9.1 为什么要学数据库

文件适合简单数据。数据库适合：

- 查询。
- 去重。
- 更新状态。
- 管理任务。
- 多表关联。

爬虫里常见表：

```text
article
  id
  title
  url
  content
  source
  created_at

spider_task
  id
  name
  status
  start_url
  created_at
  updated_at
```

### 9.2 SQLite 示例

```python
import sqlite3

conn = sqlite3.connect("articles.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS article (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    url TEXT NOT NULL UNIQUE
)
""")

cursor.execute(
    "INSERT OR IGNORE INTO article (title, url) VALUES (?, ?)",
    ("Python 爬虫", "https://example.com/a/1"),
)

conn.commit()
conn.close()
```

### 9.3 唯一索引

`url TEXT NOT NULL UNIQUE` 表示 URL 不能重复。

这比用 Python 的 `set` 更可靠，因为程序重启后数据库仍然记得哪些 URL 已经采集。

### 本章作业

改造你的爬虫：

- 保存到 SQLite。
- URL 唯一。
- 重复运行不重复插入。
- 提供一个查询函数，按关键词查标题。

---

# 第四部分：Django Web 开发

## 10. 为什么公司喜欢 Django

Django 是一个“大而全”的 Web 框架。它内置：

- 路由。
- ORM。
- 模板。
- 表单。
- 管理后台。
- 用户认证。
- 中间件。
- 配置系统。

很多公司会基于 Django 做魔改框架，是因为 Django 本身结构稳定、扩展点多，适合做内部平台。

你要重点理解 Django 的请求链路：

```text
浏览器/客户端
  -> URLConf
  -> Middleware
  -> View
  -> Service/业务逻辑
  -> ORM/Model
  -> Database
  -> Response
```

公司魔改框架通常会改这些地方：

- 统一响应格式。
- 统一异常处理。
- 权限认证。
- 日志追踪。
- API 基类。
- Model 基类。
- 分页器。
- 配置加载。
- Celery 任务封装。

---

## 11. Django 项目结构

创建项目：

```bash
django-admin startproject config .
python manage.py startapp articles
```

典型结构：

```text
project/
  manage.py
  config/
    settings.py
    urls.py
    wsgi.py
    asgi.py
  articles/
    models.py
    views.py
    urls.py
    admin.py
    apps.py
    migrations/
```

### 11.1 manage.py

`manage.py` 是 Django 命令入口。

常见命令：

```bash
python manage.py runserver
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
python manage.py shell
```

### 11.2 settings.py

核心配置文件，常见配置：

```python
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "articles",
]

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}
```

### 11.3 urls.py

路由入口：

```python
from django.urls import path
from articles import views

urlpatterns = [
    path("articles/", views.article_list),
]
```

### 11.4 views.py

视图函数接收请求，返回响应。

```python
from django.http import JsonResponse

def article_list(request):
    return JsonResponse({
        "items": [
            {"title": "Python 爬虫"}
        ]
    })
```

---

## 12. Django ORM

### 12.1 Model 是什么

Model 是数据库表在 Python 中的表示。

```python
from django.db import models

class Article(models.Model):
    title = models.CharField(max_length=200)
    url = models.URLField(unique=True)
    content = models.TextField(blank=True, default="")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "article"
```

生成迁移：

```bash
python manage.py makemigrations
python manage.py migrate
```

### 12.2 常见查询

```python
Article.objects.create(
    title="Python 爬虫",
    url="https://example.com/a/1",
)

articles = Article.objects.filter(title__icontains="Python")
article = Article.objects.get(id=1)
```

### 12.3 常见坑

`get()` 查不到会报错：

```python
from django.core.exceptions import ObjectDoesNotExist

try:
    article = Article.objects.get(id=1)
except Article.DoesNotExist:
    article = None
```

推荐列表接口用 `filter()`，详情接口再用 `get()` 或 `get_object_or_404()`。

### 本章作业

创建 Django app `articles`：

- 定义 `Article` 模型。
- 字段包含标题、URL、正文、来源、创建时间。
- URL 唯一。
- 写一个脚本插入 5 条文章。
- 在 Django shell 中查询标题包含 Python 的文章。

---

## 13. Django View 与接口

### 13.1 函数视图

```python
from django.http import JsonResponse
from .models import Article

def article_list(request):
    keyword = request.GET.get("keyword", "")
    qs = Article.objects.all()

    if keyword:
        qs = qs.filter(title__icontains=keyword)

    items = [
        {"id": item.id, "title": item.title, "url": item.url}
        for item in qs[:20]
    ]
    return JsonResponse({"items": items})
```

### 13.2 请求参数

GET 参数：

```python
keyword = request.GET.get("keyword")
```

POST JSON：

```python
import json

data = json.loads(request.body.decode("utf-8"))
```

### 13.3 统一响应格式

公司项目里经常会封装成这样：

```python
def success(data=None, message="ok"):
    return JsonResponse({
        "code": 0,
        "message": message,
        "data": data,
    })

def fail(message="error", code=1):
    return JsonResponse({
        "code": code,
        "message": message,
        "data": None,
    })
```

业务代码就会写成：

```python
def article_list(request):
    items = [{"title": "Python"}]
    return success(items)
```

这就是常见“魔改”的第一层：统一 API 返回格式。

### 本章作业

写三个接口：

- `GET /articles/`：文章列表，支持 `keyword`。
- `GET /articles/<id>/`：文章详情。
- `POST /articles/`：新增文章。

返回格式统一为：

```json
{
  "code": 0,
  "message": "ok",
  "data": {}
}
```

---

## 14. Django 中间件

### 14.1 中间件是什么

中间件是在请求进入 View 前、响应返回客户端前执行的逻辑。

适合放：

- 请求日志。
- 登录校验。
- 权限判断。
- 异常捕获。
- 请求耗时统计。
- Trace ID。

### 14.2 示例：请求耗时中间件

```python
import time
import logging

logger = logging.getLogger(__name__)

class RequestLogMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        start = time.time()
        response = self.get_response(request)
        cost = time.time() - start

        logger.info(
            "method=%s path=%s status=%s cost=%.3f",
            request.method,
            request.path,
            response.status_code,
            cost,
        )
        return response
```

配置：

```python
MIDDLEWARE = [
    "common.middleware.RequestLogMiddleware",
    # ...
]
```

### 14.3 公司魔改框架中的中间件

你看到公司项目里如果有这些文件，要重点看：

```text
middleware.py
middlewares/
core/middleware/
common/middleware/
```

重点查：

- 是否改了 `request.user`。
- 是否往 request 上挂了公司自己的属性，如 `request.tenant`、`request.operator`。
- 是否捕获所有异常。
- 是否统一包裹响应。
- 是否校验签名、Token、权限。

### 本章作业

写一个中间件：

- 打印请求方法、路径、耗时。
- 如果发生异常，记录日志。
- 给响应加一个 Header：`X-App-Name: python-learning`。

---

## 15. Django REST Framework 与公司 API 基类

很多公司 Django 项目会使用 DRF，或者自己封装类似 DRF 的 API 基类。

### 15.1 DRF 基础概念

DRF 常见组件：

- `APIView`
- `Serializer`
- `ModelSerializer`
- `ViewSet`
- `Router`
- `Permission`
- `Authentication`
- `Pagination`

### 15.2 Serializer 是什么

Serializer 负责输入校验和输出转换。

```python
from rest_framework import serializers
from .models import Article

class ArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Article
        fields = ["id", "title", "url", "content", "created_at"]
```

### 15.3 APIView 示例

```python
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Article
from .serializers import ArticleSerializer

class ArticleListView(APIView):
    def get(self, request):
        qs = Article.objects.all()[:20]
        serializer = ArticleSerializer(qs, many=True)
        return Response({"code": 0, "data": serializer.data})
```

### 15.4 公司魔改 API 基类怎么读

公司可能会有类似：

```python
class BaseAPIView(APIView):
    pass

class CompanyModelViewSet(ModelViewSet):
    pass
```

你读这种类时按这个顺序：

1. 看继承了谁。
2. 看重写了哪些方法。
3. 看 `dispatch()` 是否被改。
4. 看 `initial()` 是否被改。
5. 看认证、权限、限流是否被默认加上。
6. 看异常是否被统一捕获。
7. 看响应是否被统一改格式。

DRF 请求链路大致是：

```text
dispatch
  -> initialize_request
  -> initial
     -> authentication
     -> permissions
     -> throttling
  -> get/post/put/delete
  -> finalize_response
```

如果公司魔改框架接管了认证、权限、响应，通常就在这些方法里。

### 本章作业

在你自己的项目中写一个 `BaseAPIView`：

- 继承 DRF 的 `APIView`。
- 提供 `success()` 和 `fail()` 方法。
- 所有接口都用统一响应格式。
- 写一个文章列表接口继承它。

---

## 16. Django 项目排查与接手方法

接手公司魔改 Django 项目时，不要从业务文件乱翻。按下面路径读：

### 16.1 第一步：找启动入口

看：

```text
manage.py
uwsgi.ini
gunicorn.conf.py
Dockerfile
docker-compose.yml
supervisor.conf
```

你要搞清楚：

- 生产环境怎么启动。
- settings 用的是哪个。
- 环境变量有哪些。

### 16.2 第二步：找 settings

重点看：

```text
settings.py
settings/
config/
```

关注：

- `INSTALLED_APPS`
- `MIDDLEWARE`
- `DATABASES`
- `CACHES`
- `CELERY`
- `REST_FRAMEWORK`
- 日志配置
- 自定义配置加载逻辑

### 16.3 第三步：找 URL

从根路由开始：

```python
urlpatterns = [
    path("api/", include("apps.xxx.urls")),
]
```

一路追到具体 view。

### 16.4 第四步：找 View 基类

业务接口如果长这样：

```python
class TaskView(BaseView):
    pass
```

你必须先读 `BaseView`，否则看业务代码会很迷糊。

### 16.5 第五步：找 Model 基类

公司项目常见：

```python
class BaseModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_deleted = models.BooleanField(default=False)

    class Meta:
        abstract = True
```

如果有软删除，查询逻辑可能被 Manager 改过：

```python
Article.objects.filter(...)
```

看起来是查全部，实际上可能默认排除了 `is_deleted=True` 的数据。

### 16.6 第六步：找异常和响应封装

关键词搜索：

```text
exception_handler
BaseException
middleware
JsonResponse
Response
code
message
data
```

### 16.7 第七步：找任务系统

爬虫和数据处理项目里常见 Celery。

搜索：

```text
celery.py
@shared_task
delay(
apply_async(
beat
```

你要搞清楚：

- 任务在哪里定义。
- 什么时候触发。
- 失败是否重试。
- 日志在哪里。

### 本章作业

找一个公司项目或开源 Django 项目，写一份项目阅读报告：

```text
1. 项目启动入口：
2. settings 文件：
3. 根路由：
4. 主要 app：
5. API 基类：
6. Model 基类：
7. 中间件：
8. 统一响应格式：
9. 认证权限方式：
10. 异步任务：
```

---

# 第五部分：高级爬虫

## 17. 异步爬虫

### 17.1 为什么需要异步

爬虫大量时间花在等待网络响应。同步代码会一个请求等完再发下一个。

异步可以在等待 A 网站响应时，去请求 B 网站。

### 17.2 httpx 异步示例

```python
import asyncio
import httpx

async def fetch(client, url):
    response = await client.get(url, timeout=10)
    return url, response.status_code

async def main():
    urls = [
        "https://example.com",
        "https://httpbin.org/get",
    ]

    async with httpx.AsyncClient() as client:
        tasks = [fetch(client, url) for url in urls]
        results = await asyncio.gather(*tasks, return_exceptions=True)
        print(results)

asyncio.run(main())
```

### 17.3 并发限制

并发不是越大越好。

```python
sem = asyncio.Semaphore(5)

async def fetch_with_limit(client, url):
    async with sem:
        return await fetch(client, url)
```

### 本章作业

写一个异步 URL 检测器：

- 输入 100 个 URL。
- 并发数限制为 10。
- 输出状态码、耗时。
- 失败请求写日志。

---

## 18. Scrapy

### 18.1 Scrapy 解决什么问题

Scrapy 是爬虫框架，帮你处理：

- 请求调度。
- 并发。
- 去重。
- 重试。
- 下载中间件。
- 数据管道。
- 日志。

### 18.2 Scrapy 核心结构

```text
scrapy_project/
  scrapy.cfg
  news_spider/
    items.py
    middlewares.py
    pipelines.py
    settings.py
    spiders/
      news.py
```

### 18.3 Spider 示例

```python
import scrapy

class NewsSpider(scrapy.Spider):
    name = "news"
    start_urls = ["https://example.com/articles"]

    def parse(self, response):
        for node in response.css(".article"):
            yield {
                "title": node.css(".title::text").get(),
                "url": node.css("a::attr(href)").get(),
            }
```

### 18.4 Pipeline

Pipeline 负责处理解析后的数据。

```python
class NewsPipeline:
    def process_item(self, item, spider):
        item["title"] = item["title"].strip() if item.get("title") else None
        return item
```

### 本章作业

写一个 Scrapy 项目：

- 采集列表页。
- 采集详情页。
- 保存到 SQLite。
- 加下载延迟。
- 加失败日志。

---

## 19. Playwright 动态网页

### 19.1 什么时候用 Playwright

优先级应该是：

1. 能直接请求接口，就直接请求接口。
2. 不能直接请求接口，再考虑 Playwright。

Playwright 适合：

- 页面由 JS 渲染。
- 需要点击加载更多。
- 需要登录态。
- 需要执行 JS。

### 19.2 示例

```python
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto("https://example.com")
    page.wait_for_load_state("networkidle")
    title = page.title()
    html = page.content()
    print(title)
    browser.close()
```

### 19.3 工作技巧

使用 Playwright 时同时观察 Network：

- 页面是不是调用了 JSON 接口？
- 接口参数从哪里来？
- Cookie 是否必要？
- Header 是否必要？

如果找到真实接口，就把 Playwright 降级为“只用来拿参数或 Cookie”，真正采集仍用 requests/httpx。

### 本章作业

写一个动态页面分析报告：

- 用 Playwright 打开页面。
- 截图。
- 提取页面中的 10 条数据。
- 找出背后的接口。
- 尝试用 requests 复刻接口。

---

# 第六部分：工程化综合项目

## 20. 最终项目：Django 采集管理平台

这个项目最贴近你的工作方向。

### 20.1 项目目标

做一个 Django 项目，实现：

- 文章数据表。
- 采集任务表。
- 创建采集任务接口。
- 后台执行采集。
- 查询任务状态。
- 查询采集结果。
- 统一响应格式。
- 统一异常处理。
- 请求日志中间件。

### 20.2 推荐结构

```text
collector_platform/
  manage.py
  config/
    settings.py
    urls.py
  common/
    response.py
    exceptions.py
    middleware.py
    models.py
  articles/
    models.py
    views.py
    urls.py
    services.py
  tasks/
    models.py
    views.py
    urls.py
    services.py
  crawlers/
    news.py
```

### 20.3 统一响应

```python
from django.http import JsonResponse

def success(data=None, message="ok"):
    return JsonResponse({
        "code": 0,
        "message": message,
        "data": data,
    })

def fail(message="error", code=1):
    return JsonResponse({
        "code": code,
        "message": message,
        "data": None,
    })
```

### 20.4 BaseModel

```python
from django.db import models

class BaseModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True
```

### 20.5 Article

```python
class Article(BaseModel):
    title = models.CharField(max_length=200)
    url = models.URLField(unique=True)
    content = models.TextField(blank=True, default="")
    source = models.CharField(max_length=100, blank=True, default="")
```

### 20.6 SpiderTask

```python
class SpiderTask(BaseModel):
    STATUS_CHOICES = [
        ("pending", "待执行"),
        ("running", "执行中"),
        ("success", "成功"),
        ("failed", "失败"),
    ]

    name = models.CharField(max_length=100)
    start_url = models.URLField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="pending")
    error_message = models.TextField(blank=True, default="")
```

### 20.7 Service 层

不要把所有逻辑都写在 view 里。

```python
def create_spider_task(name, start_url):
    return SpiderTask.objects.create(
        name=name,
        start_url=start_url,
        status="pending",
    )
```

View 只负责接请求和返回响应，Service 负责业务逻辑。

### 20.8 最终作业要求

接口：

- `POST /api/tasks/` 创建采集任务。
- `GET /api/tasks/` 查看任务列表。
- `GET /api/tasks/<id>/` 查看任务详情。
- `POST /api/tasks/<id>/run/` 执行任务。
- `GET /api/articles/` 查看采集结果。

工程要求：

- 使用 Django ORM。
- 使用统一响应。
- 使用中间件记录请求日志。
- 使用 Service 层。
- 爬虫请求有 timeout。
- URL 唯一去重。
- README 写清楚如何运行。

---

# 复习清单

## Python 基础

- 我能不能把重复代码拆成函数？
- 我能不能处理文件编码问题？
- 我能不能用日志替代 print？
- 我能不能解释 list、dict、set 的使用场景？

## 爬虫

- 我能不能用开发者工具复刻请求？
- 我能不能解释 Cookie 和 Header 的作用？
- 我能不能写出请求、解析、存储分层？
- 我能不能处理重试、超时、去重？

## Django

- 我能不能从 URL 找到 View？
- 我能不能从 View 找到 Model？
- 我能不能解释 Middleware 的作用？
- 我能不能读懂一个 BaseAPIView？
- 我能不能判断公司魔改框架改了 Django 的哪一层？

## 工程化

- 我能不能写 README？
- 我能不能给核心函数写测试？
- 我能不能把配置从代码里拆出来？
- 我能不能通过日志定位一次请求失败？

---

# 后续学习建议

如果你要优先服务当前工作，学习顺序可以调整为：

1. Python 函数、文件、异常、日志。
2. requests、HTTP、开发者工具。
3. HTML 解析、JSON 接口分析。
4. SQLite 和 Django ORM。
5. Django URL、View、Model、Middleware。
6. 公司魔改框架阅读方法。
7. Scrapy 和 Playwright。
8. 异步与工程化。

不要急着追高级反爬。先把“请求怎么来、数据怎么解析、代码怎么分层、接口怎么走、日志怎么看”练扎实。这些是你在公司项目里最常用、也最能拉开差距的基础能力。
