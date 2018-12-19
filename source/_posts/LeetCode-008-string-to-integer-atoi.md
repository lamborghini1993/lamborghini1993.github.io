---
title: LeetCode-008-string-to-integer-atoi
date: 2018-12-19 23:06:44
update: 2018-12-19 23:08:10
categories:
- LeetCode
tags:
- LeetCode
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/string-to-integer-atoi/
- 中文：https://leetcode-cn.com/problems/string-to-integer-atoi/

# 题意：
请你来实现一个 atoi 函数，使其能将字符串转换成整数。

首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。

当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。

该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。

注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。

在任何情况下，若函数不能进行有效的转换时，请返回 0。

说明：

假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231,  231 − 1]。如果数值超过这个范围，qing返回  INT_MAX (231 − 1) 或 INT_MIN (−231) 。

# 解题思路
1. 给开始标记判断是否为空格，然后记录符号为正，还是负
2. 然后在正确的获取数字的情况下，判断如果符号为负就取当前数字的负数。
3. 判断添加之后是否会溢出
4. `r = r * 10 + tmp`

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
using namespace std;

class Solution
{
  public:
    // 2147483647 -2147483648
    int min = INT_MIN / 10, max = INT_MAX / 10;
    int myAtoi(string str)
    {
        int r = 0;
        int stautu = 0;
        bool space = true;
        for (int i = 0; i < str.length(); i++)
        {
            if (space && str[i] == ' ' && stautu == 0)
                continue;
            else if (space && stautu == 0 && str[i] == '-')
                stautu = -1;
            else if (space && stautu == 0 && str[i] == '+')
                stautu = 1;
            else if (str[i] >= '0' && str[i] <= '9')
            {
                space = false;
                int tmp = str[i] - '0';
                if (stautu == -1)
                    tmp = -tmp;
                if (r > max || (r == max && tmp > 7))
                    return INT_MAX;
                if (r < min || (r == min && tmp < -8))
                    return INT_MIN;
                r = r * 10 + tmp;
            }
            else
                break;
        }
        return r;
    }
};

// int main(int argc, const char *argv[])
// {
//     Solution obj = Solution();
//     printf("%d\n", obj.myAtoi("    -42"));
//     printf("%d\n", obj.myAtoi("4193 with words"));
//     printf("%d\n", obj.myAtoi("words and 987"));
//     printf("%d\n", obj.myAtoi("-91283472332"));
//     printf("%d\n", obj.myAtoi("- 12 3"));
//     printf("%d\n", obj.myAtoi("  -123 sdf34"));
//     printf("%d\n", obj.myAtoi("-2147483649"));
//     printf("%d\n", obj.myAtoi("0-1"));
//     return 0;
// }
```

# github
- https://github.com/lamborghini1993/LeetCode
