---
title: LeetCode-005-longest-palindromic-substring
date: 2018-12-12 21:15:44
update: 2018-12-26 20:04:12
categories:
- LeetCode
tags:
- LeetCode
- python
---

# 题目地址
- 英文：https://leetcode.com/problems/longest-palindromic-substring/
- 中文：https://leetcode-cn.com/problems/longest-palindromic-substring/

# 题意：
给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。

# 解题思路一：
> 回文子串的规律是左右对称，所有我们可以遍历每个字符，向两边做扩展来判断最大的回文串长度
>
> 时间复杂度为:o(N*N)

# 解题思路二：
> Manacher 算法
>
> 在一中其实很多回文串我们已经做过遍历了，所以我们想办法来利用之前得到的遍历数据
>
> 可见连接：https://segmentfault.com/a/1190000003914228#articleHeader3
> 写的挺详细的

<!--python0-->
```python
class Solution:
    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        s = "#" + "#".join(s) + "#"
        RL = [0] * len(s)
        maxRight = 0
        pos = 0
        maxLen = 0
        maxIndex = 0
        for i in range(len(s)):
            if i < maxRight:
                RL[i] = min(RL[2*pos-i], maxRight-i)
            else:
                RL[i] = 1
            while i-RL[i] >= 0 and i+RL[i] < len(s):
                l = s[i-RL[i]]
                r = s[i+RL[i]]
                if l != r:
                    break
                RL[i] += 1
            if RL[i] + i - 1 > maxRight:
                maxRight = RL[i]
                pos = i
            if RL[i] > maxLen:
                maxLen = RL[i]
                maxIndex = i
        p = s[maxIndex-maxLen+1:maxIndex+maxLen-1]
        return p.replace("#", "")


Solution().longestPalindrome("babad")

```

# github
- https://github.com/lamborghini1993/LeetCode
