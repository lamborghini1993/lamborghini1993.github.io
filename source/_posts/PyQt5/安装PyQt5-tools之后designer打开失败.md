---
title: 安装PyQt5-tools之后designer打开失败
date: 2020-05-13 14:32:25
categories:
- python
- PyQt5
tags:
- PyQt5
- designer
---

# 问题

运行命令`pip install pyqt5-tools`安装qtdesigner，双击`site-packages\pyqt5_tools\Qt\bin\designer.exe`发现打不开

![qtdesigner打开失败](/image/python/qtdesigner_open_error.png)

版本如下：
| 软件     | 版本  | 
| :-------: | :-------: |
| python      |   3.8.2   |
| PyQt5      |   5.14.2   |
| PyQt5-sip      |   12.7.2   |
| pyqt5-tools      |   5.14.2.1.7b3   |

# 解决办法

从命令中我们得知找不到Qt插件目录，所以我们在系统变量里面添加一个参数`QT_PLUGIN_PATH`
![qtdesigner_add_path](/image/python/qtdesigner_add_path.png)

添加完毕之后打开正常
