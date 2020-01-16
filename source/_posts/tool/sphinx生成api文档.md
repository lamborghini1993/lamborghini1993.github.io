---
title: sphinx生成api文档
date: 2020-01-14 20:31:45
categories:
- tool
- sphinx
tags:
- sphinx
- python
---

# 1.安装sphinx

`pip3 install sphinx`

# 2.设置文档来源

```shell
➜  Sphinx git:(master) ✗ sphinx-quickstart
欢迎使用 Sphinx 2.3.1 快速配置工具。

请输入接下来各项设置的值（如果方括号中指定了默认值，直接
按回车即可使用默认值）。

已选择根路径：.

布置用于保存 Sphinx 输出的构建目录，有两种选择。
一是在根路径下创建“_build”目录，二是在根路径下创建“source”
和“build”两个独立的目录。
> 独立的源文件和构建目录（y/n） [n]: y

项目名称会出现在文档的许多地方。
> 项目名称: ProjectName
> 作者名称: xiaohao
> 项目发行版本 []: 

If the documents are to be written in a language other than English,
you can select a language here by its language code. Sphinx will then
translate text that it generates into that language.

For a list of supported codes, see
https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-language.
> 项目语种 [en]: cn

创建文件 ./source/conf.py。
创建文件 ./source/index.rst。
创建文件 ./Makefile。
创建文件 ./make.bat。

完成：已创建初始目录结构。

你现在可以填写主文档文件 ./source/index.rst 并创建其他文档源文件了。 用 Makefile 构建文档，像这样：
 make builder
此处的“builder”是支持的构建器名，比如 html、latex 或 linkcheck。
```

# 3.运行构建

现在，您已经添加了一些文件和内容，让我们开始构建文档。使用sphinx-build程序开始构建：

`sphinx-build -b html sourcedir builddir`

其中sourcedir是源目录，而builddir是您要在其中放置构建文档的目录。该-b选项选择一个构建器；在此示例中，Sphinx将构建HTML文件。

```shell
➜  Sphinx git:(master) ✗ sphinx-build -b html source build 
正在运行 Sphinx v2.3.1
正在加载翻译 [cn]... 没有内置信息的翻译
构建 [mo]： 0 个 po 文件的目标文件已过期
构建 [html]： 1 个源文件的目标文件已过期
更新环境: [新配置] 已添加 1，0 已更改，0 已移除
阅读源... [100%] index                                                             
查找当前已过期的文件... 没有找到
pickling环境... 完成
检查一致性... 完成
准备文件... 完成
写入输出... [100%] index                                                            
generating indices...  genindex完成
writing additional pages...  search完成
复制静态文件... ... 完成
copying extra files... 完成
dumping search index in English (code: en)... 完成
dumping object inventory... 完成
构建 成功.

HTML 页面保存在 build 目录。
```


sphinx-quickstart脚本会创建Makefile和， make.bat这会使您的生活更加轻松。

```shell
➜  Sphinx git:(master) ✗ make html
正在运行 Sphinx v2.3.1
正在加载翻译 [cn]... 没有内置信息的翻译
制作输出目录... 完成
构建 [mo]： 0 个 po 文件的目标文件已过期
构建 [html]： 1 个源文件的目标文件已过期
更新环境: [新配置] 已添加 1，0 已更改，0 已移除
阅读源... [100%] index                                                             
查找当前已过期的文件... 没有找到
pickling环境... 完成
检查一致性... 完成
准备文件... 完成
写入输出... [100%] index                                                            
generating indices...  genindex完成
writing additional pages...  search完成
复制静态文件... ... 完成
copying extra files... 完成
dumping search index in English (code: en)... 完成
dumping object inventory... 完成
构建 成功.

HTML 页面保存在 build/html 目录。
```

# 4.调用 sphinx-apidoc

```shell
➜  Sphinx git:(master) ✗ sphinx-apidoc -o ./source/src ./Script
创建文件 ./source/src/test.rst。
创建文件 ./source/src/modules.rst。
```


# 5. 支持md文件
`pip install recommonmark`

在conf.py添加扩支持：

extensions = ['recommonmark']

# 6. vscode支持rst预览

reStructuredText插件 + `pip install doc8`

# 7. 重点配置说明

## 1. 源码路径
```python3
import os
import sys
sys.path.insert(0, os.path.abspath('../Script'))
```
这里需要添加python生成api文档的源码路径，一定要绝对路径，所以使用`abspath`

## 2. 一些常用插件

```python3
extensions = [
    "sphinx.ext.autodoc",       # 标准的Python模块扩展,为Sphinx提供的附加功能
    "recommonmark",             # markdown支持
    "sphinx_markdown_tables",   # markdown表格支持
    "sphinx.ext.napoleon",      # 支持numpy和google风格的docstrings
    "sphinx.ext.intersphinx",   # 启用链接
]
```

## 3. python官方主题

`html_theme = 'sphinx_rtd_theme'`

# 8. 关于__init__.py的坑

如果源码中存在`__init__.py`，那么sphinx会将其当成一个模块来看
所以在添加`sys.path.insert(0, os.path.abspath('../'))`的时候需要在脚本的外层路径（此时将脚本当成一个包）