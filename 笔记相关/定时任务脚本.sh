#! /bin/bash
# 上面中的 #! 是一种约定标记, 它可以告诉系统这个脚本需要什么样的解释器来执行;
cd /Users/hao/坚果云/我的坚果云/笔记

time=`date`

git add .

git commit -m  "提交的时间是: $time"

#git push origin master
git push https://HHHao-1:chzaizg556677@github.com/HHHao-1/Notes.git master

echo -e `date '+%Y-%m-%d %H:%M:%S'` "提交笔记" >> /Users/hao/programming/log/notes.log
