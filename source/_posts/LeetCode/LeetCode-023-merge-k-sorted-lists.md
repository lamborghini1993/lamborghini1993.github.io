---
title: LeetCode-023-merge-k-sorted-lists
date: 2018-12-24 19:53:34
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/merge-k-sorted-lists/
- 中文：https://leetcode-cn.com/problems/merge-k-sorted-lists/

# 题意：
合并 k 个排序链表，返回合并后的排序链表。请分析和描述算法的复杂度。
示例:

输入:
[
  1->4->5,
  1->3->4,
  2->6
]

输出: 1->1->2->3->4->4->5->6


# C++中.和->区别
好久没写C++，现在准备捡回来

> c++中当定义类对象是指针对象时候，就需要用到 “->” 指向类中的成员；
> 
> 当定义一般对象时候时就需要用到 “.” 指向类中的成员……

例如：
```c++
struct MyStruct
{ 
    int member; 
};
MyStruct a, *p;
a.member = 1;
p->member = 1;
(*p).member =1
```
总结：
- 箭头（->）：左边必须为指针；
- 点号（.）：左边必须为实体。

# 解题思路一：
- 将所有数字放到一个列表里，然后用快排
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
vector<ListNode *> mylists;
int i;

ListNode *AddListNode(int t[], int size)
{
    ListNode *head = NULL, *first = NULL, *current = NULL;
    if(size==0)
        return head;
    head = first = new ListNode(t[0]);
    for (int i = 1; i < size; i++)
    {
        current = new ListNode(t[i]);
        first->next = current;
        first = first->next;
    }
    mylists.push_back(head);
    return head;
}

class Solution
{
  public:
    ListNode *mergeKLists(vector<ListNode *> &lists)
    {
        ListNode *result = NULL;
        if(lists.size() == 0)
            return result;
        int t[999999], cnt = 0;
        for (i = 0; i < lists.size(); i++)
        {
            while (lists[i])
            {
                t[cnt++] = lists[i]->val;
                lists[i] = lists[i]->next;
            }
        }
        sort(t, t + cnt);
        for (i = 0; i < cnt; i++)
            cout << t[i] << " ";
        cout << endl;
        ListNode *head = AddListNode(t, cnt);
        result = head;
        while (head)
        {
            cout << head->val << "->";
            head = head->next;
        }
        cout << endl;
        return result;
    }
};

int main(int argc, char const *argv[])
{
    int t1[] = {1, 4, 5};
    int t2[] = {1, 3, 4};
    int t3[] = {2, 6};
    AddListNode(t1, 3);
    AddListNode(t2, 3);
    AddListNode(t3, 2);
    ListNode *result = Solution().mergeKLists(mylists);
    return 0;
}

```

# 解题思路二：
- 我们知道如果是将两个有序列表合并成一个有序列表就很简单了。
- 所以可以使用归并排序的思想，每次进行两两合并。
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
#include <algorithm>
using namespace std;

struct ListNode
{
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};
vector<ListNode *> mylists;

ListNode *AddListNode(int t[], int size)
{
    ListNode *head = NULL, *first = NULL, *current = NULL;
    if (size == 0)
        return head;
    head = first = new ListNode(t[0]);
    for (int i = 1; i < size; i++)
    {
        current = new ListNode(t[i]);
        first->next = current;
        first = first->next;
    }
    mylists.push_back(head);
    return head;
}

class Solution
{
  public:
    int i, t, lsize;

    ListNode *mergeKLists(vector<ListNode *> &lists)
    {
        if (lists.size() == 0)
            return NULL;
        lsize = lists.size();
        // 归并合并
        while (lsize > 1)
        {
            t = (1 + lsize) / 2;
            for (i = 0; i < lsize / 2; i++)
            {
                lists[i] = mergeTwoLists(lists[i], lists[i + t]);
                // printf("mergeTwoLists %d:", i);
                // nodeprint(lists[i]);
            }
            lsize = t;
        }
        return lists[0];
    }

    ListNode *mergeTwoLists(ListNode *l1, ListNode *l2)
    {
        ListNode *head, *cur;
        head = cur = new ListNode(0);
        // nodeprint(l1);
        // nodeprint(l2);
        while (l1 && l2)
        {
            if (l1->val > l2->val)
            {
                cur->next = l2;
                l2 = l2->next;
            }
            else
            {
                cur->next = l1;
                l1 = l1->next;
            }
            cur = cur->next;
        }
        if (l1)
            cur->next = l1;
        if (l2)
            cur->next = l2;
        // nodeprint(head->next);
        return head->next;
    }

    void nodeprint(ListNode *print)
    {
        while (print)
        {
            cout << print->val << " ";
            print = print->next;
        }
        cout << endl;
    }
};

int main(int argc, char const *argv[])
{
    int t1[] = {1, 4, 5};
    int t2[] = {1, 3, 4};
    int t3[] = {2, 6};
    AddListNode(t1, 3);
    AddListNode(t2, 3);
    AddListNode(t3, 2);
    ListNode *result = Solution().mergeKLists(mylists);
    return 0;
}

```

# github
- https://github.com/lamborghini1993/LeetCode
