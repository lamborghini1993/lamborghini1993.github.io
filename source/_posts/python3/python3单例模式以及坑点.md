---
title: python3单例模式以及坑点
date: 2019-12-04 20:03:24
categories:
- python3
tags:
- single
---

# 一、几种单例模式的实现

## 1. 使用装饰器
```python3
def Singleton(cls):
    _instance = {}

    def _single(*args, **kwargs):
        if cls not in _instance:
            _instance[cls] = cls(*args, **kwargs)
        return _instance[cls]

    return _single

@Singleton
class A:
    ...

A()
```

## 2. 使用类方法
```python3
class Singleton(object):

    @classmethod
    def instance(cls, *args, **kwargs):
        if not hasattr(cls, "_instance"):
            cls._instance = cls(*args, **kwargs)
        return cls._instance

class A(Singleton):
    pass

A.instance()
```

## 3. 使用__new__(推荐)
```python3
class Singleton(object):
    _instance = None

    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = object.__new__(cls)
        return cls._instance

class A(Singleton):
    ...

A()
```

# 二、几个坑点

## 1.使用__new__方式会多次调用__init__
```python3
class Singleton(object):
    _instance = None

    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = object.__new__(cls)
        return cls._instance


class A(Singleton):
    M = 1

    def __init__(self, a):
        print("init", a, self.M)


for i in range(5):
    A(i)
```
```shell
➜ python3 test.py
init 0 1
init 1 1
init 2 1
init 3 1
init 4 1
```
所以在__init__里面做初始化逻辑的类需要注意，自己处理一下或者使用其他两种方式

## 2.关于单例类多继承问题

```python3
class Singleton(object):
    _instance = None

    def __new__(cls, *args, **kwargs):
        if not Singleton._instance:
            Singleton._instance = object.__new__(cls)
        print(cls, Singleton._instance) #
        return Singleton._instance
```
- 看到网上有这样的一种写法
- 运行起来没什么问题，但是到类有继承关系的时候就会出问题
```python3
class A(Singleton):
   ...

class B(Singleton):
    ...

A()
B()
```
```shell
➜  python3 test.py
<class '__main__.A'> <__main__.A object at 0x7f9d1c8dab70>
<class '__main__.B'> <__main__.A object at 0x7f9d1c8dab70>
```
- 可以发现A类和B类生成的实例对象是同一个
- 但是常规的应该是两种不同的单例对象，应该不一样（当然也有可能有该需求，可以使用此方法）
