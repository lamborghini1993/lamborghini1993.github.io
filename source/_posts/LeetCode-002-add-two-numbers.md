---
title: LeetCode-002-add-two-numbers
date: 2018-12-09 21:11:36
update: 2018-12-12 21:15:44
categories:
- LeetCode
tags:
- LeetCode
- python3
---

# 题目地址
- 英文：https://leetcode.com/problems/add-two-numbers/
- 中文：https://leetcode-cn.com/problems/add-two-numbers/

# 题意：
给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

# 解题思路：
相当于大数求和，遍历两个链表，类比做两个数相加，将余数加到列表，值放到下一位相加。
- 时间复杂度为O(N+M)
<!--python0-->
```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        lst = []
        tmp = 0
        while l1 or l2:
            a = b = 0
            if l1:
                a = l1.val
                l1 = l1.next
            if l2:
                b = l2.val
                l2 = l2.next
            c = a + b + tmp
            lst.append(c % 10)
            tmp = c // 10
        if tmp:
            lst.append(tmp)
        return lst
```

# github
- https://github.com/lamborghini1993/LeetCode
