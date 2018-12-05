---
title: Git submodlue使用和一键配置
date: 2018-12-05 19:42:15
categories:
- git
- submodlue
tags:
- git
- submodlue
---

# Git submodlue介绍
经常碰到这种情况：当你在一个Git 项目上工作时，你需要在其中使用另外一个Git 项目。也许它是一个第三方开发的Git 库或者是你独立开发和并在多个父项目中使用的。这个情况下一个常见的问题产生了：你想将两个项目单独处理但是又需要在其中一个中使用另外一个。

在Git 中你可以用子模块`submodule`来管理这些项目，`submodule`允许你将一个Git 仓库当作另外一个Git 仓库的子目录。这允许你克隆另外一个仓库到你的项目中并且保持你的提交相对独立。

# 添加子模块

本文将统一使用`git@github.com:lamborghini1993/Test.git`来当做子模块使用
```shell
$ git submodule add git@github.com:lamborghini1993/Test.git Test
正克隆到 '/home/duoyi/mygit/other/Test2'...
remote: Enumerating objects: 8, done.
remote: Counting objects: 100% (8/8), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 8 (delta 1), reused 7 (delta 0), pack-reused 0
接收对象中: 100% (8/8), 完成.
处理 delta 中: 100% (1/1), 完成.
```

添加子模块后运行`git status`, 可以看到目录有增加1个文件`.gitmodules`, 这个文件用来保存子模块的信息。
```shell
$ git status 
位于分支 master
您的分支与上游分支 'origin/master' 一致。

要提交的变更：
  （使用 "git reset HEAD <文件>..." 以取消暂存）

	新文件：   .gitmodules
	新文件：   Test
```

# 查看子模块
```shell
$ git submodule 
 f8b5eedbdf35f99b0ac6ff1ff6f5c6d506dd4328 Test (heads/master)
```

# 克隆包含子模块的项目
克隆包含子模块的项目有二种方法：一种是先克隆父项目，再更新子模块；另一种是直接递归克隆整个项目。
- 先克隆父项目，再更新子模块:
    1. `git clone https://github.com/lamborghini1993/Test2.git other`
    2. 查看子模块
        ```shell
        $ git submodule
        -f8b5eedbdf35f99b0ac6ff1ff6f5c6d506dd4328 Test
        ```
        子模块前面有一个-，说明子模块文件还未检入（空文件夹）。
    3. 初始化子模块`git submodule init`(初始化模块只需在克隆父项目后运行一次)
    4. 更新子模块
        ```shell
        $ git submodule update
        正克隆到 '/home/duoyi/mygit/other/Test'...
        子模组路径 'Test'：检出 'f8b5eedbdf35f99b0ac6ff1ff6f5c6d506dd4328'
        ```
        子模块前面有一个-，说明子模块文件还未检入（空文件夹）。
- 递归克隆整个项目
    ```shell
    $ git clone https://github.com/lamborghini1993/Test2.git other2 --recursive 
    正克隆到 'other2'...
    remote: Enumerating objects: 6, done.
    remote: Counting objects: 100% (6/6), done.
    remote: Compressing objects: 100% (4/4), done.
    remote: Total 6 (delta 0), reused 3 (delta 0), pack-reused 0
    展开对象中: 100% (6/6), 完成.
    子模组 'Test'（git@github.com:lamborghini1993/Test.git）未对路径 'Test' 注册
    正克隆到 '/home/duoyi/mygit/other2/Test'...
    remote: Enumerating objects: 8, done.        
    remote: Counting objects: 100% (8/8), done.        
    remote: Compressing objects: 100% (7/7), done.        
    接收对象中: 100% (8/8), 完成.
    处理 delta 中: 100% (1/1), 完成.
    remote: Total 8 (delta 1), reused 7 (delta 0), pack-reused 0        
    子模组路径 'Test'：检出 'f8b5eedbdf35f99b0ac6ff1ff6f5c6d506dd4328'
    ```
- 推荐使用第一种方法，因为第二种方法存在父目录克隆了，但是子目录克隆失败的情况。

# 修改子模块
- 修改子模块记得一定要先提交子模块，然后在提交父模块
```shell
➜  Test git:(f8b5eed) touch a.txt
➜  Test git:(f8b5eed) ✗ git status
头指针分离于 f8b5eed
未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）

	a.txt

提交为空，但是存在尚未跟踪的文件（使用 "git add" 建立跟踪）
➜  Test git:(f8b5eed) ✗ git add *
➜  Test git:(f8b5eed) ✗ git commit -m "test"
[分离头指针 5cc4941] test
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a.txt
➜  Test git:(5cc4941) git push 
fatal: 您当前不在一个分支上。
现在为推送当前（分离头指针）的历史，使用

    git push origin HEAD:<远程分支名字>

➜  Test git:(5cc4941) git push origin HEAD:master
对象计数中: 2, 完成.
Delta compression using up to 4 threads.
压缩对象中: 100% (2/2), 完成.
写入对象中: 100% (2/2), 250 bytes | 250.00 KiB/s, 完成.
Total 2 (delta 0), reused 0 (delta 0)
To github.com:lamborghini1993/Test.git
   f8b5eed..5cc4941  HEAD -> master
➜  Test git:(5cc4941) cd ..
➜  other git:(master) ✗ git status 
位于分支 master
您的分支与上游分支 'origin/master' 一致。

尚未暂存以备提交的变更：
  （使用 "git add <文件>..." 更新要提交的内容）
  （使用 "git checkout -- <文件>..." 丢弃工作区的改动）

	修改：     Test (新提交)

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
➜  other git:(master) ✗ git commit -a -m "test"
[master 757352f] test
 1 file changed, 1 insertion(+), 1 deletion(-)
➜  other git:(master) git push
对象计数中: 2, 完成.
Delta compression using up to 4 threads.
压缩对象中: 100% (2/2), 完成.
写入对象中: 100% (2/2), 239 bytes | 239.00 KiB/s, 完成.
Total 2 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To github.com:lamborghini1993/Test2.git
   461dca1..757352f  master -> master
➜  other git:(master) git status
位于分支 master
您的分支与上游分支 'origin/master' 一致。

无文件要提交，干净的工作区

```
- 注意：提交子模块时一定要指明*远程分支*`git push origin HEAD:master`

# 更新子模块
1. 在父目录下执行：`git submodule update`
2. 在子目录下执行：`git pull origin HEAD:master`
- 更新子目录时最好，一起更新，不然父目录会出现修改
```shell
➜  Test git:(f8b5eed) git pull origin HEAD:master
来自 github.com:lamborghini1993/Test
   f8b5eed..5cc4941             -> master
更新 f8b5eed..5cc4941
Fast-forward
 a.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a.txt
➜  Test git:(5cc4941) ls
a.txt  新建文本文档.txt
➜  Test git:(5cc4941) cd ..
➜  other2 git:(master) ✗ git status 
位于分支 master
您的分支与上游分支 'origin/master' 一致。

尚未暂存以备提交的变更：
  （使用 "git add <文件>..." 更新要提交的内容）
  （使用 "git checkout -- <文件>..." 丢弃工作区的改动）

	修改：     Test (新提交)

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
➜  other2 git:(master) ✗ git pull
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 2 (delta 1), reused 2 (delta 1), pack-reused 0
展开对象中: 100% (2/2), 完成.
来自 https://github.com/lamborghini1993/Test2
   461dca1..757352f  master     -> origin/master
更新 461dca1..757352f
Fast-forward
 Test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
➜  other2 git:(master) git status 
位于分支 master
您的分支与上游分支 'origin/master' 一致。

无文件要提交，干净的工作区

```

# 删除子模块
git 并不支持直接删除Submodule需要手动删除对应的文件
1. 删除子模块文件夹
    ```shell
    ➜  other2 git:(master) git rm --cached Test 
    rm 'Test'
    ➜  other2 git:(master) ✗ ls
    README.md  Test
    ➜  other2 git:(master) ✗ rm -rf Test
    ```

2. 删除.gitmodules文件中相关子模块信息
[submodule "Test"]
	path = Test
	url = git@github.com:lamborghini1993/Test.git

3. 删除.git/config中的相关子模块信息
[submodule "Test"]
	url = git@github.com:lamborghini1993/Test.git

4. 删除.git文件夹中的相关子模块文件
