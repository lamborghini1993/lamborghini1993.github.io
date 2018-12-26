---
title: LeetCode-146-lru-cache
date: 2018-12-26 20:04:12
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- python
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/lru-cache/
- 中文：https://leetcode-cn.com/problems/lru-cache/

# 题意：
运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。

获取数据 get(key) - 如果密钥 (key) 存在于缓存中，则获取密钥的值（总是正数），否则返回 -1。
写入数据 put(key, value) - 如果密钥不存在，则写入其数据值。当缓存容量达到上限时，它应该在写入新数据之前删除最近最少使用的数据值，从而为新的数据值留出空间。

进阶:

你是否可以在 O(1) 时间复杂度内完成这两种操作？

示例:

LRUCache cache = new LRUCache( 2 /* 缓存容量 */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // 返回  1
cache.put(3, 3);    // 该操作会使得密钥 2 作废
cache.get(2);       // 返回 -1 (未找到)
cache.put(4, 4);    // 该操作会使得密钥 1 作废
cache.get(1);       // 返回 -1 (未找到)
cache.get(3);       // 返回  3
cache.get(4);       // 返回  4

# 解题思路：
- 这里其实就是想实现一个有序字典
- 可以使用`list（列表）` + `unordered_map（hash表）`来实现
- get：判断是否在列表中
    - 如果不在返回-1
    - 如果在，删除node，然后添加到列表第一位，返回结果
- put：判断是否在列表中
    - 如果在，删除node，然后添加到列表第一位
    - 不在，添加到列表中，如果越界删除最后一位

# C++代码：
<!--c++0-->
```C++
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <string>
#include <queue>
#include <climits>
#include <algorithm>
#include <map>
#include <unordered_map>
#include <list>
using namespace std;

class LRUCache
{
  public:
    struct _node
    {
        int _key;
        int _val;
        _node(int k, int v) : _val(v), _key(k){};
    };

  public:
    list<_node> _list;
    unordered_map<int, list<_node>::iterator> keynode;
    int _maxsize;
    int _cursize;
    LRUCache(int capacity)
    {
        _maxsize = capacity;
        _cursize = 0;
    }

    int get(int key)
    {
        if (_cursize == 0)
        {
            return -1;
        }
        if (keynode.find(key) != keynode.end())
        {
            int res = keynode[key]->_val;
            _list.erase(keynode[key]);
            _list.push_front(_node(key, res));
            keynode[key] = _list.begin();
            return res;
        }
        return -1;
    }

    void put(int key, int value)
    {
        if (keynode.find(key) != keynode.end())
        {
            _list.erase(keynode[key]);
            _list.push_front(_node(key, value));
            keynode[key] = _list.begin();
            return;
        }
        _cursize++;
        if (_cursize <= _maxsize)
        {
            _list.push_front(_node(key, value));
            keynode[key] = _list.begin();
        }
        else
        {
            _list.push_front(_node(key, value));
            int rkey = (--_list.end())->_key;
            keynode.erase(rkey);
            keynode[key] = _list.begin();
            _list.pop_back();
        }
    }
};
```

# python代码：
- python的话直接用`OrderedDict`
<!--python0-->
```python
# -*- coding:utf-8 -*-
"""
@Author: lamborghini
@Date: 2018-12-26 19:54:05
@Desc: LRU缓存机制
"""

from collections import OrderedDict


class LRUCache:

    def __init__(self, capacity):
        """
        :type capacity: int
        """
        self.m_Cap = capacity
        self.m_Cnt = 0
        self.m_Info = OrderedDict()

    def get(self, key):
        """
        :type key: int
        :rtype: int
        """
        if key in self.m_Info:
            val = self.m_Info[key]
            del self.m_Info[key]
            self.m_Info[key] = val
            return val
        return -1

    def put(self, key, value):
        """
        :type key: int
        :type value: int
        :rtype: void
        """
        if key in self.m_Info:
            del self.m_Info[key]
            self.m_Info[key] = value
            return
        self.m_Cnt += 1
        self.m_Info[key] = value
        if self.m_Cnt > self.m_Cap:
            for key in self.m_Info:
                del self.m_Info[key]
                return

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)

```

# github
- https://github.com/lamborghini1993/LeetCode
