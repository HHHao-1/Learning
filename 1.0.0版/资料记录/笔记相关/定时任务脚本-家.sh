#! /bin/bash
# 上面中的 #! 是一种约定标记, 它可以告诉系统这个脚本需要什么样的解释器来执行;
cd /Users/hao/我的坚果云/01_笔记

time=`date '+%Y/%m/%d %T'`

git add .

git commit -m  "$time"

#git push origin master
git push

echo -e $time "提交笔记" >> /Users/hao/program/log/notes.log
