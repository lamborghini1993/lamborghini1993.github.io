---
title: LeetCode-016-3sum-closest
date: 2018-12-24 19:53:34
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/3sum-closest/
- 中文：https://leetcode-cn.com/problems/3sum-closest/

# 题意：
给定一个包括 n 个整数的数组 nums 和 一个目标值 target。找出 nums 中的三个整数，使得它们的和与 target 最接近。返回这三个数的和。假定每组输入只存在唯一答案。

例如，给定数组 nums = [-1，2，1，-4], 和 target = 1.

与 target 最接近的三个数的和为 2. (-1 + 2 + 1 = 2).

# 解题思路：
- 碰到这种问题解决方法：
    1. 排序
    2. 遍历一个数据i，将三数求和变为两数求和
    3. j = i + 1, k = len - 1 从两头开始遍历
- 每次遍历和target比较大小，
    1. `< target`时，j++，并且比较当前相差最小值+记录
    2. `> target`时，k--，并且记录当前相差最小值+记录
    3. `= target`时，直接返回target
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
    int value, minCha = INT_MAX, t;

    void Compare(int tmp, int target)
    {
        t = abs(tmp - target);
        if (t < minCha)
        {
            minCha = t;
            value = tmp;
        }
    }

    int threeSumClosest(vector<int> &nums, int target)
    {
        int i, j, k, tmp;
        sort(nums.begin(), nums.end());
        for (int i = 0; i < nums.size(); i++)
            cout << nums[i] << " ";
        cout << endl;

        for (i = 0; i < nums.size(); i++)
        {
            j = i + 1;
            k = nums.size() - 1;

            while (j < k)
            {
                tmp = nums[j] + nums[k] + nums[i];
                if (tmp > target)
                {
                    k--;
                    Compare(tmp, target);
                }
                else if (tmp < target)
                {
                    Compare(tmp, target);
                    j++;
                }
                else
                {
                    printf("%d %d %d %d %d\n", i, j, k, tmp, target);
                    return tmp;
                }
            }
        }
        return value;
    }
};

int main(int argc, char const *argv[])
{
    // int t[] = {-1, 2, 1, -4};
    // int iLen = sizeof(t) / sizeof(t[0]);
    // vector<int> p(t, t + iLen);
    // Solution obj = Solution();
    // printf("%d\n", obj.threeSumClosest(p, 1));

    int t[] = {0, 1, 2};
    int iLen = sizeof(t) / sizeof(t[0]);
    vector<int> p(t, t + iLen);
    Solution obj = Solution();
    printf("%d\n", obj.threeSumClosest(p, 3));
    return 0;
}

```

# github
- https://github.com/lamborghini1993/LeetCode
