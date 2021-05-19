---
title: Python实现c3mro算法
date: 2021-05-19 20:03:24
categories:
- python
tags:
- python2.7
- python3.8
---

# mro算法解析
- `class X(X1, X2, ..., Xn)`:那么 `mro[X] = [X] + merge(mro[X1], mro[X2], ... , mro[Xn], [X1], [X2], ... , [Xn])`
- merge实现:
    1. 遍历执行 merge 操作的序列，如果一个序列的第一个元素，在其他序列中也是第一个元素，或不在其他序列出现，则从所有执行 merge 操作序列中删除这个元素，合并到当前的 mro list 中。merge 操作后的序列，递归地执行 merge 操作，直到 merge 操作的序列为空。
    2. 如果 merge 操作的序列无法为空，则说明不合法。
```python
class A(object):pass
class B(object):pass
class C(A,B):pass

mro[A] = [A] + merge(mro[object], [object]) = [A, object]
mro[B] = [B, object]
mro[C] = [C] + merget(mro[A], mro[B], [A], [B])
       = [C] + merget([A, object], [B, object], [A], [B])
    1. A 符合，提出A
       = [C, A] + merget([object], [B, object], [B])
    2. object 不符合，继续下一个B符合，提出B
       = [C, A, B] + merget([object], [object])
       = [C, A, B, object]
```

# 例子 实现
```python
class A(object):pass
class B(object):pass
class C(object):pass
class E(A,B):pass
class F(B,C):pass
class G(E,F):pass


def mro(cls):
    if cls is object:
        return [object]
    mro_lst = getattr(cls, "mro_"+ cls.__name__, [])
    if mro_lst:
        return mro_lst
    merge_list = [mro(base_cls) for base_cls in cls.__bases__]
    merge_list.append(list(cls.__bases__))
    mro_lst = [cls] + merge(merge_list)
    setattr(cls, "mro_"+ cls.__name__, mro_lst)
    return mro_lst


def merge(merge_list):
    if not merge_list:
        return []
    head = None
    for i, sub_list in enumerate(merge_list):
        tail_find, head = False, sub_list[0]
        for j in range(i+1, len(merge_list)):
            if head in merge_list[j][1:]:
                tail_find = True
                break
        if not tail_find:
            break

    next_list = []
    for sub_list in merge_list:
        tmp_lst = [cls for cls in sub_list if cls != head]
        if tmp_lst:
            next_list.append(tmp_lst)
    return [head] + merge(next_list)

print(mro(G))
print(G.mro())
```

```python
class Mro(object):
    def __init__(self):
        self._mro = {object: [object]}

    def mro(self, cls):
        if cls in self._mro:
            return self._mro[cls]
        merge_list = [self.mro(base_cls) for base_cls in cls.__bases__]
        merge_list.append(list(cls.__bases__))
        mro_lst = [cls] + self.merge(merge_list)
        self._mro[cls] = mro_lst
        return mro_lst

    def merge(self, merge_list):
        if not merge_list:
            return []
        head = None
        for i, sub_list in enumerate(merge_list):
            tail_find, head = False, sub_list[0]
            for j in range(i+1, len(merge_list)):
                if head in merge_list[j][1:]:
                    tail_find = True
                    break
            if not tail_find:
                break
        else:
            raise Exception("Error Inhert")

        next_list = []
        for sub_list in merge_list:
            tmp_lst = [cls for cls in sub_list if cls != head]
            if tmp_lst:
                next_list.append(tmp_lst)
        return [head] + self.merge(next_list)
```