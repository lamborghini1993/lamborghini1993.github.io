---
title: LeetCode-043-multiply-strings
date: 2018-12-26 19:21:23
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/multiply-strings/
- 中文：https://leetcode-cn.com/problems/multiply-strings/

# 题意：
给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。

示例 1:

输入: num1 = "2", num2 = "3"
输出: "6"

示例 2:

输入: num1 = "123", num2 = "456"
输出: "56088"

说明：

    num1 和 num2 的长度小于110。
    num1 和 num2 只包含数字 0-9。
    num1 和 num2 均不以零开头，除非是数字 0 本身。
    不能使用任何标准库的大数类型（比如 BigInteger）或直接将输入转换为整数来处理。

# 解题思路：
- 简单的说就是大数相乘
1. 将字符串转为数字用数组逆序（方便计算乘法）存起来
2. 一一相乘两个数组，然后放到新数组中，记得做进位处理
```C++
tmp = result[i + j] + n1[i] * n2[j];
result[i + j] = tmp % 10;
result[i + j + 1] += tmp / 10;
```
- 代码如下：
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
    int i, j, l1, l2, tmp;
    int result[222], n1[111], n2[111];

    string multiply(string num1, string num2)
    {
        l1 = num1.length();
        for (i = 0; i < l1; i++)
            n1[i] = num1[l1 - 1 - i] - '0';
        l2 = num2.length();
        for (i = 0; i < l2; i++)
            n2[i] = num2[l2 - 1 - i] - '0';
        Print(n1, l1);
        Print(n2, l2);
        memset(result, sizeof(result), 0);
        for (i = 0; i < l1; i++)
        {
            for (j = 0; j < l2; j++)
            {
                tmp = result[i + j] + n1[i] * n2[j];
                result[i + j] = tmp % 10;
                result[i + j + 1] += tmp / 10;
            }
        }
        Print(result, l1 + l2);
        string re = "";
        tmp = l1 + l2;
        while (tmp >= 1 && result[tmp] == 0)
        {
            tmp--; //排除末位0
        }
        for (i = tmp; i >= 0; i--)
        {
            re += result[i] + '0';
        }
        cout << re << endl;
        return re;
    }

    void Print(int t[], int size)
    {
        for (int i = 0; i < size; i++)
        {
            printf("%d", t[i]);
        }
        printf("\n");
    }
};

int main(int argc, char const *argv[])
{
    string s1 = "123", s2 = "456";
    Solution().multiply(s1, s2);
    return 0;
}

```

# github
- https://github.com/lamborghini1993/LeetCode
