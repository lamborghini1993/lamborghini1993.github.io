---
title: python3中super的顺序
date: 2019-03-13 20:03:24
categories:
- python
tags:
- super
---

# 问题
我们都知道python中允许多继承，使用super来调用父类，但是对于多继承的顺序总是弄不清楚，所以自己写了代码来弄清楚一下具体顺序。

# 代码
```python

class A1:
    def __init__(self):
        super(A1, self).__init__()
        print("A1.__init__")

    def Test(self):
        print("A1.Test")


class B1:
    def __init__(self):
        super(B1, self).__init__()
        print("B1.__init__")

    def Test(self):
        print("B1.Test")


class C1(A1, B1):
    """
    父类__init__中有super
    """

    def __init__(self):
        super(C1, self).__init__()
        print("C1.__init__")

    def Test(self):
        """
        macro顺序为: C1 A1 B1 object
        super方式无法调用B.Test
        """
        super(C1, self).Test()
        print("C1.Test")


#########################################


class A2(object):
    def __init__(self):
        print("A2.__init__")

    def Test(self):
        print("A2.Test")


class B2:
    def __init__(self):
        print("B2.__init__")

    def Test(self):
        print("B2.Test")


class C2(A2, B2):
    """
    父类__init__中无super
    """

    def __init__(self):
        super(C2, self).__init__()
        print("C2.__init__")

    def Test(self):
        """
        macro顺序为: C2 A2 B2 object
        super方式无法调用B.Test
        """
        super(C2, self).Test()
        print("C2.Test")


#########################################


class AA(object):
    def __init__(self):
        print("AA.__init__")

    def Test(self):
        print("AA.Test")


class BB:
    def __init__(self):
        print("BB.__init__")

    def Test(self):
        print("BB.Test")


class CC(AA, BB):
    def __init__(self):
        AA.__init__(self)
        BB.__init__(self)
        print("CC.__init__")

    def Test(self):
        AA.Test(self)
        BB.Test(self)
        print("CC.Test")


if __name__ == "__main__":
    C1().Test()
    print(C1.mro())
    print("-" * 50)
    C2().Test()
    print(C2.mro())
    print("-" * 50)
    CC().Test()
    print(CC.mro())

```

# 输出结果
```
B1.__init__
A1.__init__
C1.__init__
A1.Test
C1.Test
[<class '__main__.C1'>, <class '__main__.A1'>, <class '__main__.B1'>, <class 'object'>]
--------------------------------------------------
A2.__init__
C2.__init__
A2.Test
C2.Test
[<class '__main__.C2'>, <class '__main__.A2'>, <class '__main__.B2'>, <class 'object'>]
--------------------------------------------------
AA.__init__
BB.__init__
CC.__init__
AA.Test
BB.Test
CC.Test
[<class '__main__.CC'>, <class '__main__.AA'>, <class '__main__.BB'>, <class 'object'>]
```

1. 第一种A和B的\_\_init\_\_中都调用了super方法，此时在C中调用super，发现先输出B，再输出A。而Test2调用只输出了A。
2. 第二种A和B的\_\_init\_\_中都没调用super方法，此时在C中调用super，发现只输出A。而Test2调用也只输出了A。
3. 第三张我们不用super，改用cls.Method调用，这个好理解，直接按照我们调用的顺序输出，Test2也一样。


# MRO算法
这里也大致说下MRO算法：
```python
class A(O):pass
class B(O):pass
class C(A, B):pass
```
此时MRO(C) = [C] + merge(mro)
```python
mro(C) = [C] + merge(mro(A), mro(B), [A,B])     
            # 上面这个merge这个是按照class C(A, B)中AB的顺序来的
       = [C] + merge([A,O], [B,O], [A,B])
```
执行merge操作的序列为[A,O]、[B,O]、[A,B]
A是序列[A,O]中的第一个元素，在序列[B,O]中不出现，在序列[A,B]中也是第一个元素，所以从执行merge操作的序列([A,O]、[B,O]、[A,B])中删除A，合并到当前mro中。
```python
mro(C) = [C,A] + merge([O], [B,O], [B])
```
再执行merge操作，O是序列[O]中的第一个元素，但O在序列[B,O]中出现并且不是其中第一个元素。继续查看下一个元素，也就是[B,O]的第一个元素B，B满足是所有序列中的第一个元素条件，所以从执行merge操作的序列中删除B，合并到[C, A]中。
```python
mro(C) = [C,A,B] + merge([O], [O]) 
       = [C,A,B,O]
```
所以C的顺序为：C、A、B、O(object)，复合上面C.mro的输出。

总结一下：从头开始，不断寻找满足所有出现的序列中的第一个元素，找到合并到mro中，删除所有序列中的该元素，继续寻找

# 分析
通过查找资料，发现这里的顺序是通过一个叫[MRO算法](https://www.jianshu.com/p/a08c61abe895)生成的，具体可以点击链接看看。

mro算法是求继承顺序的，所以对于一
1. 先运行A的\_\_init\_\_，然后A又调用super
2. 运行B的\_\_init\_\_，然后B调用super
3. 运行object的\_\_init\_\_。
4. 打印输出B.\_\_init\_\_。
5. 打印输出A.\_\_init\_\_。
5. 打印输出C.\_\_init\_\_。

对于二同理分析即可。
