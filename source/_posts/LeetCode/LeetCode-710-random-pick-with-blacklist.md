---
title: LeetCode-710-random-pick-with-blacklist
date: 2019-05-16 20:45:36
update: 2019-05-16 20:45:36
categories:
- LeetCode
tags:
- LeetCode
- python
- C++
---

# 题目地址

- 英文：https://leetcode.com/problems/random-pick-with-blacklist/
- 中文：https://leetcode-cn.com/problems/random-pick-with-blacklist/

# 题意：

给你一个整数N，一个黑名单B的列表，让你从[0,n)中随机产生一个不在B列表中的数。

# 解题思路一：

排序B列表，然后新建一个白名单列表0到n-1依次开始添加，如果在黑名单中就跳过。
- C++ 代码超时
- python 代码超内存

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
#include <unordered_map>
using namespace std;

class Solution
{
public:
    vector<int> p;
    int size;
    Solution(int N, vector<int> blacklist)
    {
        if (blacklist.size() != 0)
        {
            sort(blacklist.begin(), blacklist.end());
        }
        int j = 0;
        for (int i = 0; i < N; i++)
        {
            while (j < blacklist.size() && blacklist[j] < i)
            {
                j++;
            }
            if(j>=blacklist.size() || blacklist[j]!=i)
                p.push_back(i);
        }
        size = p.size();
        for (int i = 0; i < size; i++)
        {
            printf("%d ",p[i]);
        }
        printf("\n");
    }

    int pick()
    {
        return p[rand() % size];
    }
};

/**
 * Your Solution object will be instantiated and called as such:
 * Solution obj = new Solution(N, blacklist);
 * int param_1 = obj.pick();
 */
```

<!--python1-->
```python
import random


class Solution(object):

    def __init__(self, N, blacklist):
        """
        :type N: int
        :type blacklist: List[int]
        """
        self.m_WhiteList = list(set(range(N)).difference(set(blacklist)))

    def pick(self):
        """
        :rtype: int
        """
        return random.choice(self.m_WhiteList)

# o = Solution(15, [3, 6, 2, 13, 4])
# for x in range(10):
#     print(o.pick())

```

# 解题思路二：

我们可以对黑名单做一个白名单的映射表，比如：N = 15， B = [3, 6, 2, 13, 4]
最终的白名单个数为 `N - len(B) = 10`,所以可得如下映射表`map`:
```python3
{
    3: 14,
    6: 13,
    2: 12,
    13: 11,
    4: 10,
}
```
所以此时可的这样的对应关系：
`0-0 1-1 2-2 3-14 4-10 5-5 6-13 7-7 8-8 9-9`
最终的结果就是`map.get(x,x)`

<!--python0-->
```python
import random


class Solution(object):

    def __init__(self, N, blacklist):
        """
        :type N: int
        :type blacklist: List[int]
        """
        self.m_Map = {}
        self.m_Size = N-len(blacklist)
        replace = N-1
        # 建立黑名单中的替代路径
        for n in blacklist:
            self.m_Map.setdefault(n, replace)
            replace -= 1

        # 路径压缩
        for n in blacklist:
            if n >= self.m_Size:
                continue
            if n in self.m_Map:
                nxt = self.m_Map[n]
                while nxt in self.m_Map:
                    nxt = self.m_Map[nxt]
                self.m_Map[n] = nxt

    def pick(self):
        """
        :rtype: int
        """
        rd = int(random.random()*self.m_Size)
        return self.m_Map.get(rd, rd)


# o = Solution(15, [3, 6, 2, 13, 4])
# for x in range(10):
#     print(o.pick())

```

# github
- https://github.com/lamborghini1993/LeetCode
