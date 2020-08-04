---
title: Python文件读写时的换行符与回车符
date: 2020-03-13 20:03:24
categories:
- python
tags:
- python2.7
---


# 主流操作系统结束符

| 操作系统        | 字符组合 |
| --------------- | -------- |
| UNIX & Mac OS X | '\n'     |
| MS Windows      | '\r\n'   |

# 测试环境：win10 + python2.7

```python
for char in ("\n", "\r\n"):
    for mode in ("w", "wb"):
        filename = "%s_%s.txt" % (mode, "n" if len(char) == 1 else "rn")
        with open(filename, mode) as f:
            for x in range(5):
                f.write("%s%s" % (x, char))
```
```
w_n.txt   \r\n
w_rn.txt   \r\n
wb_n.txt   \n
wb_rn.txt   \r\n
```
1. "w"方式写时的'\n'会在被系统自动替换为'\r\n'
2. "wb"方式写时的'\n'和'\r\n'保持原样

```python
for filename in ("test_n.txt", "test_rn.txt"):
    for mode in ("r", "rb"):
        with open(filename, mode) as f:
            info = f.read()
            print(filename, mode, info.__repr__())
```
```
('test_n.txt', 'r', "'aa\\nsdfd\\ndffdf\\n'")
('test_n.txt', 'rb', "'aa\\nsdfd\\ndffdf\\n'")
('test_rn.txt', 'r', "'aa\\nsdfd\\ndffdf\\n'")
('test_rn.txt', 'rb', "'aa\\r\\nsdfd\\r\\ndffdf\\r\\n'")
```
3. "r"方式读时，文件中的'\r\n'会被系统替换为'\n'
4. "rb"方式读时，文件中的'\r\n'或'\n'保持原样

# 测试环境：linux + python2.7
```
w_n.txt   \n
w_rn.txt   \r\n
wb_n.txt   \n
wb_rn.txt   \r\n
```
1. "w"和"wb"方式写时的'\r\n'和'\n'都保持原样

```
('test_n.txt', 'r', "'aa\\nsdfd\\ndffdf\\n'")
('test_n.txt', 'rb', "'aa\\nsdfd\\ndffdf\\n'")
('test_rn.txt', 'r', "'aa\\r\\nsdfd\\r\\ndffdf\\r\\n'")
('test_rn.txt', 'rb', "'aa\\r\\nsdfd\\r\\ndffdf\\r\\n'")
```
2. "r"和"rb"方式读时，文件中的'\r\n'和'\n'都保持原样

- linux的所有读写方式都会保持换行符原样
