---
title: LeetCode-032-longest-valid-parentheses
date: 2019-01-28 17:34:35
update: 2019-01-28 17:34:35
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/longest-valid-parentheses/
- 中文：https://leetcode-cn.com/problems/longest-valid-parentheses/

# 题意：
给定一个只包含 '(' 和 ')' 的字符串，找出最长的包含有效括号的子串的长度。

示例 1:

输入: "(()"
输出: 2
解释: 最长有效括号子串为 "()"

示例 2:

输入: ")()())"
输出: 4
解释: 最长有效括号子串为 "()()"


# 解题思路：
- 看到括号匹配立即想到栈，`(`入栈，`)`则出栈；
- 要求最长有效括号子串长度，则求连续有效括号长度；
- 出栈之后将本位置，以及栈顶位置标记为`true`；
- 求最大连续为true的长度。
- PS:注意这里没说输入字符串最长数组多大，测试至少有9999位

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
#include <stack>
using namespace std;

bool Visit[99999];
int j, cnt;
int result = 0;

class Solution
{
  public:
    int longestValidParentheses(string s)
    {
        stack<int> my;
        cnt = result = 0;

        for (int i = 0; i < s.length(); i++)
        {
            Visit[i] = false;
            if (s[i] == '(')
            {
                my.push(i);
                continue;
            }
            if (!my.empty())
            {
                j = my.top();
                my.pop();
                Visit[j] = true;
                Visit[i] = true;
            }
        }
        for (int i = 0; i < s.length(); i++)
        {
            if (Visit[i])
            {
                cnt++;
                continue;
            }
            result = max(result, cnt);
            cnt = 0;
        }
        result = max(result, cnt);
        printf("结果为:%d\n", result);
        return result;
    }
};

// int main(int argc, char const *argv[])
// {
//     string s1 = ")(";
//     Solution().longestValidParentheses(s1);
//     return 0;
// }
```

# github
- https://github.com/lamborghini1993/LeetCode
