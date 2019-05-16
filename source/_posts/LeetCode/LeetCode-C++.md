---
title: LeetCode-C++
date: 2019-05-16 20:57:43
update: 2019-05-16 20:57:43
categories:
- LeetCode
tags:
- LeetCode

---

# 模板

```c++
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <string>
#include <queue>
#include <climits>
#include <algorithm>
#include <unordered_map>
using namespace std;

int main()
{
    return 0;
}
```

# 二维数组初始化

```c++
int h = 5, w = 8;
char xh[h][w] = {{'1', '1', '1', '1', '1', '1', '1', '1'},
                {'1', '1', '1', '1', '1', '1', '1', '0'},
                {'1', '1', '1', '1', '1', '1', '1', '0'},
                {'1', '1', '1', '1', '1', '0', '0', '0'},
                {'0', '1', '1', '1', '1', '0', '0', '0'}};
// 赋值给vector
vector<vector<char>> matrix;
for (int i = 0; i < h; i++)
{
    vector<char> tmp(xh[i], xh[i] + w);
    matrix.push_back(tmp);
}
```

# 二维vector

```c++
vector<vector<int>> dp(N, vector<int>(M));
```
# github
- https://github.com/lamborghini1993/LeetCode
