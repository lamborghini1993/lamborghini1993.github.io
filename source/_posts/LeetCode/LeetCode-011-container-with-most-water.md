---
title: LeetCode-011-container-with-most-water
date: 2018-12-19 17:44:48
update: 2019-01-28 17:34:35
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/container-with-most-water/
- 中文：https://leetcode-cn.com/problems/container-with-most-water/

# 题意：
给定 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0)。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

说明：你不能倾斜容器，且 n 的值至少为 2。

示例:
- 输入: [1,8,6,2,5,4,8,3,7]
- 输出: 49

# 解题思路一：
> 相当于求：Area = Max(min(height[i], height[j]) * (j-i)) {其中0 <= i < j < height,size()}
>
> 直接暴力竟然过了
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
using namespace std;

class Solution
{
  public:
    int maxArea(vector<int> &height)
    {
        int mx = 0, tmp;
        for (int i = 0; i < height.size(); i++)
        {
            for (int j = i + 1; j < height.size(); j++)
            {
                tmp = (j - i) * min(height[i], height[j]);
                mx = max(mx, tmp);
            }
        }
        return mx;
    }
};

// int main(int argc, char const *argv[])
// {
//     vector<int> p;
//     int t[] = {1, 8, 6, 2, 5, 4, 8, 3, 7};
//     int iLen = sizeof(t) / sizeof(t[0]);
//     for (int i = 0; i < iLen; i++)
//         p.push_back(t[i]);
//     Solution obj = Solution();
//     obj.maxArea(p);
//     return 0;
// }

```

# 解题思路二：
> 维护两个指针，一个从开始进行-i，一个从末尾进行-j。
>
> 此时，如果height[i] < height[j]，那么一定有 （i+1，j）组成的面积大于等于(i,j-1)
>
> 请注意，进行第二步的时候，只是选择最优的移动一格求解最大值，并不代表，(i+1,j)大于(i,j)，所有进行每一步的时候需求与当前最大值进行比较。
<!--c++1-->
```C++
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <string>
#include <queue>
#include <climits>
using namespace std;

class Solution
{
  public:
    int maxArea(vector<int> &height)
    {
        int mx = 0, tmp;
        int i = 0, j = height.size() - 1;
        while (i < j)
        {
            tmp = (j - i) * min(height[i], height[j]);
            mx = max(mx, tmp);
            if (height[i] > height[j])
                j--;
            else
                i++;
        }
        return mx;
    }
};

// int main(int argc, char const *argv[])
// {
//     vector<int> p;
//     int t[] = {1, 8, 6, 2, 5, 4, 8, 3, 7};
//     int iLen = sizeof(t) / sizeof(t[0]);
//     for (int i = 0; i < iLen; i++)
//         p.push_back(t[i]);
//     Solution obj = Solution();
//     printf("%d\n", obj.maxArea(p));
//     return 0;
// }

```

# github
- https://github.com/lamborghini1993/LeetCode
