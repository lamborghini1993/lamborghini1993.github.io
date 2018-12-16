---
title: LeetCode-001-two-sum
date: 2018-12-08 13:04:49
update: 2018-12-16 14:53:30
categories:
- LeetCode
tags:
- LeetCode
- python
---

# 题目地址
- 英文：https://leetcode.com/problems/two-sum/
- 中文：https://leetcode-cn.com/problems/two-sum/

# 题意：
给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

# 解题思路一：
双重循环遍历，判断nums[i] + nums[j] = target，很显然这种方式太暴力
- 时间复杂度为O(N*N)
- 空间复杂度：O(1)

# 解题思路二：
竟然给定了target，我们就可以根据一个值求出另一个值
然后在判断这个值是否在nums数组中，即可。
- 时间复杂度为O(N*M)
- 空间复杂度：O(1)
<!--python0-->
```python
class Solution:
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        for i, v in enumerate(nums):
            value = target - v
            if value not in nums:
                continue
            j = nums.index(value)
            if i != j:
                return [i, j]
        return None

```

# 解题思路三：
在二的基础上，判断是否在数组中，可以遍历一次用字典存储起来，然后获取另一个值
- 时间复杂度为O(N)
- 空间复杂度：O(N)
<!--python1-->
```python
class Solution:
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        dInfo = {}
        for x, xValue in enumerate(nums):
            yValue = target - xValue
            if yValue in dInfo:
                return [dInfo[yValue], x]
            dInfo[xValue] = x
        return None

```

# github
- https://github.com/lamborghini1993/LeetCode
