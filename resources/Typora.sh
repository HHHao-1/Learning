#! /bin/bash
# 上面中的 #! 是一种约定标记, 它可以告诉系统这个脚本需要什么样的解释器来执行;
cd /Users/hao/programming/笔记

git add .

git commit -m  "Typora"

#git push origin master
git push origin master

echo -e `date '+%Y-%m-%d %H:%M:%S'` "完成笔记github备份" >> /Users/hao/programming/log/notes.log
