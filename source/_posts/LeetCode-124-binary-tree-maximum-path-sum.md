---
title: LeetCode-124-binary-tree-maximum-path-sum
date: 2018-12-26 19:53:22
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/binary-tree-maximum-path-sum/
- 中文：https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/

# 题意：
给定一个非空二叉树，返回其最大路径和。

本题中，路径被定义为一条从树中任意节点出发，达到任意节点的序列。该路径至少包含一个节点，且不一定经过根节点。

示例 1:

输入: [1,2,3]

       1
      / \
     2   3

输出: 6

示例 2:

输入: [-10,9,20,null,null,15,7]


        -10
        / \
       9  20
      /  \
     15   7

输出: 42




# 解题思路：
- 要求一条路径的最大值，可以从任意节点出发，转化为：
1. 从底层开始遍历，每次修改当前节点的值为`max(当前节点、当前节点+左节点、当前节点+右节点、当前节点+左右节点)`
2. 每次遍历时并记录最大值

# 代码一：
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

struct TreeNode
{
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution
{
  public:
    int result = INT_MIN;
    int maxPathSum(TreeNode *root)
    {
        DFS(root);
        return result;
    }

    void DFS(TreeNode *temp)
    {
        int o, a = 0, b = 0;
        o = temp->val;
        if (temp->left)
        {
            DFS(temp->left);
            a = temp->left->val;
        }
        if (temp->right)
        {
            DFS(temp->right);
            b = temp->right->val;
        }
        printf("%d %d %d %d", o, a, b, result);
        // 求最大值
        result = max(result, o);
        result = max(result, o + a);
        result = max(result, o + b);
        result = max(result, o + a + b);
        printf("----%d\n", result);
        // 算出当前节点最大的值
        temp->val = max(o, o + b);
        temp->val = max(temp->val, o + a);
    }
};
```

# 优化代码二：
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

struct TreeNode
{
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution
{
  public:
    int result = INT_MIN;
    int maxPathSum(TreeNode *root)
    {
        DFS(root);
        return result;
    }

    int DFS(TreeNode *temp)
    {
        if (temp == NULL)
            return 0;
        int left, right;
        left = max(0, DFS(temp->left));
        right = max(0, DFS(temp->right));
        result = max(result, temp->val + left + right);
        return max(temp->val, temp->val + max(left, right));
    }
};
```

# github
- https://github.com/lamborghini1993/LeetCode
