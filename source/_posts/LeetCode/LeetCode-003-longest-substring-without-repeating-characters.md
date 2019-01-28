---
title: LeetCode-003-longest-substring-without-repeating-characters
date: 2018-12-09 22:07:56
update: 2019-01-28 17:34:35
categories:
- LeetCode
tags:
- LeetCode
- python
---

# 题目地址
- 英文：https://leetcode.com/problems/longest-substring-without-repeating-characters/
- 中文：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/

# 题意：
给定一个字符串，请你找出其中不含有重复字符的 `最长子串` 的长度。

# 解题思路：
要求不重复字符的最长字符，只需要遍历维护当前不重复最长字串初始下标，
然后每次取最大值即可
- 时间复杂度为O(N)
- 空间复杂度为O(N)
<!--python0-->
```python
class Solution:
    def lengthOfLongestSubstring(self, s):
        """
        :type s: str
        :rtype: int
        """
        dInfo = {}
        iMax = 0
        iBeginIndex = -1 # 因为下标是从0开始的，所以赋值为-1
        for i, c in enumerate(s):
            if c in dInfo:
                iBeginIndex = max(iBeginIndex, dInfo[c])  #每次维护不重复串的初始下标
            iMax = max(i - iBeginIndex, iMax)
            dInfo[c] = i
        return iMax


def Test():
    """测试样例"""
    lstTest = ["", "abcabvd", "ab", "34f3", "pwwkew", "abba", "abbcccbba", "aabaab!bb"]
    lstResult = [0, 5, 2, 3, 3, 2, 2, 3]
    obj = Solution()
    for i, s in enumerate(lstTest):
        output = obj.lengthOfLongestSubstring(s)
        if lstResult[i] != output:
            print("结果不匹配 Input:%s Output:%s Expected:%s" % (s, output, lstResult[i]))
            break
    print("done")


if __name__ == "__main__":
    Test()
    print(Solution().lengthOfLongestSubstring("aabaab!bb"))

```

# github
- https://github.com/lamborghini1993/LeetCode
