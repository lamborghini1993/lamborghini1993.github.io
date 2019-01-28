---
title: LeetCode-033-search-in-rotated-sorted-array
date: 2018-12-24 19:53:34
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/search-in-rotated-sorted-array/
- 中文：https://leetcode-cn.com/problems/search-in-rotated-sorted-array/

# 题意：
假设按照升序排序的数组在预先未知的某个点上进行了旋转。

( 例如，数组 [0,1,2,4,5,6,7] 可能变为 [4,5,6,7,0,1,2] )。

搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。

你可以假设数组中不存在重复的元素。

你的算法时间复杂度必须是 O(log n) 级别。

示例 1:

输入: nums = [4,5,6,7,0,1,2], target = 0
输出: 4

示例 2:

输入: nums = [4,5,6,7,0,1,2], target = 3
输出: -1

# 解题思路：
因为是递增的一次旋转数组，所以我们也可以用二分+我们特殊的判断来做
- 如果二分到是正常的递增，那么按照正常的逻辑进行
- 否则继续按照一次旋转数组进行判断二分：
    - 左边是正常递增，如果目标在左边，则`r=m-1`，否则`l=m+1`
    - 右边是正常递增，如果目标在右边，则`l=m+1`，否则`r=m-1`
- 每次记得判断中数是否是寻找的值，是就直接返回
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
    int l, r, m;
    bool left;
    int search(vector<int> &nums, int target)
    {
        l = 0;
        r = nums.size() - 1;
        while (l <= r)
        {
            m = (l + r) / 2;
            printf("mid %d %d %d\n", l, m, r);
            if (nums[m] == target)
                return m;

            if (nums[l] < nums[r]) // 正常递增
            {
                if (nums[m] > target)
                    r = m - 1;
                else
                    l = m + 1;
            }
            else // 非正常递增
            {
                if (nums[l] <= nums[m]) // 左边是正常递增
                {
                    if (nums[l] <= target && target < nums[m])
                        r = m - 1;
                    else
                        l = m + 1;
                }
                else // 右边是正常递增
                {
                    if (nums[m] < target && target <= nums[r])
                        l = m + 1;
                    else
                        r = m - 1;
                }
            }
        }
        return -1;
    }
};

int main(int argc, char const *argv[])
{
    int t[] = {4, 5, 6, 7, 0, 1, 2};
    vector<int> p;
    int iLen = sizeof(t) / sizeof(t[0]);
    for (int i = 0; i < iLen; i++)
        p.push_back(t[i]);
    cout << Solution().search(p, 2) << endl;
    return 0;
}
```

# github
- https://github.com/lamborghini1993/LeetCode
