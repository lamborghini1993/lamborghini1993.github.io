---
title: LeetCode-061-rotate-list
date: 2018-12-26 19:52:40
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/rotate-list/
- 中文：https://leetcode-cn.com/problems/rotate-list/

# 题意：
给定一个链表，旋转链表，将链表每个节点向右移动 k 个位置，其中 k 是非负数。

示例 1:

输入: 1->2->3->4->5->NULL, k = 2
输出: 4->5->1->2->3->NULL
解释:
向右旋转 1 步: 5->1->2->3->4->NULL
向右旋转 2 步: 4->5->1->2->3->NULL

示例 2:

输入: 0->1->2->NULL, k = 4
输出: 2->0->1->NULL
解释:
向右旋转 1 步: 2->0->1->NULL
向右旋转 2 步: 1->2->0->NULL
向右旋转 3 步: 0->1->2->NULL
向右旋转 4 步: 2->0->1->NULL

# 解题思路：
1. 遍历链表，记录末位链表指针，以及链表长度:cnt
2. 因为旋转的长度可能大于链表的长度，所以需要做如下处理`t=(cnt - k % cnt) % cnt`
3. 然后将前t个放到末位即可

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

struct ListNode
{
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

class Solution
{
  public:
    ListNode *rotateRight(ListNode *head, int k)
    {
        ListNode *tmp = head, *tail;
        int cnt = 0; //  链表长度
        while (tmp)
        {
            cnt++;
            tail = tmp;
            tmp = tmp->next;
        }
        if (cnt == 0)
            return head;
        int t = (cnt - k % cnt) % cnt; // 移动的次数
        if (t == 0)
            return head;
        tail->next = head; // 将链表指向头
        while (t--)
        {
            tmp = head;
            head = head->next;
        }
        tmp->next = NULL;
        return head;
    }
};
```

# github
- https://github.com/lamborghini1993/LeetCode
