---
title: LeetCode-062-unique-paths
date: 2018-12-26 19:53:05
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/unique-paths/
- 中文：https://leetcode-cn.com/problems/unique-paths/

# 题意：
一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。

机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。

问总共有多少条不同的路径？

例如，上图是一个7 x 3 的网格。有多少可能的路径？

说明：m 和 n 的值均不超过 100。

示例 1:

输入: m = 3, n = 2
输出: 3
解释:
从左上角开始，总共有 3 条路径可以到达右下角。
1. 向右 -> 向右 -> 向下
2. 向右 -> 向下 -> 向右
3. 向下 -> 向右 -> 向右

示例 2:

输入: m = 7, n = 3
输出: 28


# 解题思路一：
- 可以递推出`dp[i][j] = dp[i - 1][j] + dp[i][j - 1];`
- 所以显然可以直接用动态规划解决
- 这里其实可以优化为两个一维数组，因为每次进行for循环只和上一次有关系

# 代码如下：
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
using namespace std;

class Solution
{
  public:
    int uniquePaths(int m, int n)
    {
        int dp[110][110];
        int i, j;
        memset(dp, sizeof(dp), 0);
        for (i = 0; i < m; i++)
            dp[i][0] = 1;
        for (i = 0; i < n; i++)
            dp[0][i] = 1;
        for (i = 1; i < m; i++)
            for (j = 1; j < n; j++)
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
        return dp[m-1][n-1];
    }
};

int main(int argc, char const *argv[])
{
    printf("%d\n", Solution().uniquePaths(7, 3));
    return 0;
}

```

# 解题思路二：
- 因为只能往下和往右，总的步数为`n+m-2`
- 所以可以转化为求在`n+m-2`中求`n-1`次往右走，或者`m-1`次往下走的情况
- 所以结果为`C(n+m-2, n-1)`或者`C(n+m-2, m-1)`

# github
- https://github.com/lamborghini1993/LeetCode
