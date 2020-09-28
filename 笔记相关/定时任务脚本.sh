#! /bin/bash
# 上面中的 #! 是一种约定标记, 它可以告诉系统这个脚本需要什么样的解释器来执行;
cd /Users/chenghao/Nutstore\ Files/我的坚果云/01_笔记

time=`date '+%Y/%m/%d %T'`

/usr/local/bin/git add .

/usr/local/bin/git commit -m  "$time"

#git push origin master
/usr/local/bin/git push https://HHHao-1:chzaizg556677@github.com/HHHao-1/Notes.git master

echo -e $time "提交笔记" >> /Users/chenghao/program/Log/notes.log
