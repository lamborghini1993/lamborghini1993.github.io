---
title: LeetCode-015-3sum
date: 2018-12-19 23:06:44
update: 2018-12-19 23:08:10
categories:
- LeetCode
tags:
- LeetCode
- go
---

# 题目地址
- 英文：https://leetcode.com/problems/3sum/
- 中文：https://leetcode-cn.com/problems/3sum/

# 题意：
给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。

注意：答案中不可以包含重复的三元组。

> 例如, 给定数组 nums = [-1, 0, 1, 2, -1, -4]，
>
> 满足要求的三元组集合为：
>
>[
>  [-1, 0, 1
>  [-1, -1, 2]
>]


# 解题思路：
- 很显然进行三重遍历会超时。
- 这里我们可以取一个数a，然后其他两个数b，c使得a+b+c=0即可
- 找bc我们可以先进行排序，然后从两边往中间扫，使a+b+c=0
- 这里注意记得去重（相同就跳过就行）
<!--go0-->
```go
package main

import (
	"fmt"
	"sort"
)

func threeSum(nums []int) [][]int {
	sort.Ints(nums)
	var items [][]int
	var i,j,k,s int
	for i = 0; i < len(nums); i++ {
		if i != 0 && nums[i] <= nums[i-1] {
			continue	// 去重相同的
		}
		j = i + 1
		k = len(nums) - 1
		for j < k {
			s = nums[i] + nums[j] + nums[k]
			if s == 0 {
				tmp := []int{nums[i], nums[j], nums[k]}
				items = append(items, tmp)
				j += 1
				k -= 1
				for j < k && nums[j] == nums[j-1] {	
					j += 1	 // 去重相同的
				}
				for j < k && nums[k] == nums[k+1] {	
					k -= 1	// 去重相同的
				}
			} else if s < 0 {
				j += 1
			} else {
				k -= 1
			}
		}
	}
	return items
}

func main() {
	nums := []int{-1, 0, 1, 2, -1, -4}
	fmt.Println(threeSum(nums))
	nums = []int{0,0,0}
	fmt.Println(threeSum(nums))
}

```

# github
- https://github.com/lamborghini1993/LeetCode
