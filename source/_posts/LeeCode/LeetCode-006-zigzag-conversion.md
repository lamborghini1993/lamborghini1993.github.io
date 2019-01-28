---
title: LeetCode-006-zigzag-conversion
date: 2018-12-13 19:35:48
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- python
---

# 题目地址
- 英文：https://leetcode.com/problems/zigzag-conversion/
- 中文：https://leetcode-cn.com/problems/zigzag-conversion/

# 题意：
将一个给定字符串根据给定的行数，以从上往下、从左到右进行 Z 字形排列。

比如输入字符串为 "LEETCODEISHIRING" 行数为 3 时，排列如下：

L   C   I   R
E T O E S I I G
E   D   H   N

之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如："LCIRETOESIIGEDHN"。



# 解题思路：
- 完全的模拟题目，找规律题目
- 可以转化为先向下numRows-1次，然后向右上numRows-1次
- 可以用一个列表存储没行数据，然后模拟到第几行就在对应行上加上字符
- 最后将列表相加即为所得
- PS：注意特判numRows为1的情况

<!--python0-->
```python
class Solution:
    def convert(self, s, numRows):
        """
        :type s: str
        :type numRows: int
        :rtype: str
        """
        if numRows == 1:    # 特判一下为1的情况
            return s
        result = []
        for i in range(numRows):
            result.append("")
        bUp2Down = False
        for i, c in enumerate(s):
            mod = i % (numRows-1)
            if not mod:
                bUp2Down = not bUp2Down
                
            if bUp2Down:
                result[mod] += c
            else:
                t = numRows-1-mod
                result[t] += c
        r = ""
        for i in range(numRows):
            r += result[i]
            print(result[i])
        return r


Solution().convert("LEETCODEISHIRING", 3)

```

# github
- https://github.com/lamborghini1993/LeetCode
