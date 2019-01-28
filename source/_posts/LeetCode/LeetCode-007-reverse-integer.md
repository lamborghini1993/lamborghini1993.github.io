---
title: LeetCode-007-reverse-integer
date: 2018-12-17 19:32:55
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- python
- C++
---

# 题目地址
- 英文：https://leetcode.com/problems/reverse-integer/
- 中文：https://leetcode-cn.com/problems/reverse-integer/

# 题意：
> 给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。
> 
> 注意:
>
> 假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−231,  231 − 1]。
> 
> 请根据这个假设，如果反转后整数溢出那么就返回 0。

# 解题思路python：
- 转化为字符串，然后直接反转字符串
- 注意判断负号以及溢出即可
<!--python0-->
```python
class Solution:
    m_Min = -2**31
    m_Max = 2**31 - 1

    def reverse(self, x):
        """
        :type x: int
        :rtype: int
        """
        if x < 0:
            str_x = str(abs(x))
            x = "-"
        else:
            str_x = str(x)
            x = ""
        x += str_x[::-1]
        result = int(x)
        print(self.m_Max, self.m_Min)
        if result < self.m_Min or result > self.m_Max:
            return 0
        return result


print(-2 % 10)    # python结果为8
Solution().reverse(123)
Solution().reverse(-123)

```

# 解题思路C++：
- 一步一步进行：取模然后 * 10 + lastresult
- 因为可能溢出，所以与最大值、最小值除以10来比较
- 最大值：2147483647 
- 最小值：-2147483648
<!--c++0-->
```C++
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

class Solution
{
  public:
    int min = INT_MIN / 10, max = INT_MAX / 10;
    int reverse(int x)
    {
        int r = 0, tmp;
        while (x != 0)
        {
            tmp = x % 10;
            x = x / 10;
            // 2147483647 -2147483648
            if (r > max || (r == max && tmp > 7))
                return 0;
            if (r < min || (r == min && tmp < -8))
                return 0;
            r = r * 10 + tmp;
        }
        return r;
    }
};

// int main(int argc, const char* argv[])
// {
//     Solution obj = Solution();
//     printf("%d\n", -2 % 10); // C++ 结果为-2
//     printf("%d\n", obj.reverse(123));
//     printf("%d\n", obj.reverse(-123));
//     return 0;
// }

```

# github
- https://github.com/lamborghini1993/LeetCode
