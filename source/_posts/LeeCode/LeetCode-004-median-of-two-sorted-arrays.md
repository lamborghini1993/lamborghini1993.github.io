---
title: LeetCode-004-median-of-two-sorted-arrays
date: 2018-12-09 22:34:38
update: 2018-12-19 23:08:10
categories:
- LeetCode
tags:
- LeetCode
- python
---

# 题目地址
- 英文：https://leetcode.com/problems/median-of-two-sorted-arrays/
- 中文：https://leetcode-cn.com/problems/median-of-two-sorted-arrays/

# 题意：
给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。
请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
你可以假设 nums1 和 nums2 不会同时为空。

# 解题思路：
1. 直接拼接两个有序列表，然后求中值，时间复杂应该是O(N+M)，但是竟然没有超时
- 时间复杂度为O(N+M)
<!--python0-->
```python
class Solution:
    def findMedianSortedArrays(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: float
        """
        lstResult = []
        i = j = 0
        while i < len(nums1) or j < len(nums2):
            if j >= len(nums2):
                lstResult.append(nums1[i])
                i += 1
                continue
            if i >= len(nums1):
                lstResult.append(nums2[j])
                j += 1
                continue
            if nums1[i] < nums2[j]:
                lstResult.append(nums1[i])
                i += 1
            else:
                lstResult.append(nums2[j])
                j += 1
        iLen = len(lstResult)
        if iLen % 2:
            return lstResult[iLen // 2]
        return (lstResult[iLen // 2 - 1] + lstResult[iLen // 2]) / 2


obj = Solution()
print(obj.findMedianSortedArrays([1, 3], [2]))
print(obj.findMedianSortedArrays([1, 2], [3, 4]))

```

# github
- https://github.com/lamborghini1993/LeetCode
