```
➜  ~ if [ $a==10 ];then echo "123";fi;
➜  ~ if [ $a -lt 11 ];then echo "123";fi;
➜  ~ if [[ $a<11 ]];then echo "123";fi;
➜  ~ if (( a<11 ));then echo "123";fi;
➜  ~ if [ $a -lt 11 ];then echo "123";fi;
➜  Desktop (ls;ll) | grep al*
algorithm
drwxr-xr-x   6 hao  staff   192B  4 30 15:54 algorithm
单小括号 ()
①命令组。括号中的命令将会新开一个子shell顺序执行，所以括号中的变量不能够被脚本余下的部分使用。括号中多个命令之间用分号隔开，最后一个命令可以没有分号，各命令和括号之间不必有空格。
②用于初始化数组。如：array=(a b c d)
大括号、花括号 {}
1、常规用法
①大括号拓展。
# ls {ex1,ex2}.sh 
ex1.sh ex2.sh 
# ls {ex{1..3},ex4}.sh 
ex1.sh ex2.sh ex3.sh ex4.sh 
# ls {ex[1-3],ex4}.sh 
ex1.sh ex2.sh ex3.sh ex4.sh
②代码块，又被称为内部组，这个结构事实上创建了一个匿名函数 。与小括号中的命令不同，大括号内的命令不会新开一个子shell运行，即脚本余下部分仍可使用括号内变量。括号内的命令间用分号隔开，最后一个也必须有分号。{}的第一个命令和左括号之间必须要有一个空格。
小括号和内容之间不必有空格，大括号、中括号和内容之间需要一个空格
```

首先启动内核程序

系统调用：内核对应用程序提供的访问接口

![image-20210908124857758](https://tva1.sinaimg.cn/large/008i3skNly1gu94i1zos2j60zu0jwgnf02.jpg)

windows 安装sigwin，在windows跑linux指令

查看系统调用： 2：系统调用，3：公共库函数

![image-20210908125117005](https://tva1.sinaimg.cn/large/008i3skNly1gu94kg5nl4j60ig036q3202.jpg)

系统调用复杂，所以公用库函数诞生，实现对系统调用的封装

![image-20210908125247494](https://tva1.sinaimg.cn/large/008i3skNly1gu94m1izmgj611c0oatb802.jpg)

没有图形界面之前，shell充当用户界面

![image-20210908125656135](https://tva1.sinaimg.cn/large/008i3skNly1gu94qc0g0vj61260cwab002.jpg)

没有path就是当前目录

find支持通配符模糊查询

-name 大小写敏感，-iname 大小写不敏感

man指令查看指令说明

![image-20210908130252523](https://tva1.sinaimg.cn/large/008i3skNly1gu94wiz0ikj61380jwtam02.jpg)

文件检索、文本检索

![image-20210908130433220](https://tva1.sinaimg.cn/large/008i3skNly1gu94y9ufdhj613w0h03zs02.jpg)

筛选出目标字符串所在的行

![image-20210908130705718](/Users/hao/Library/Application Support/typora-user-images/image-20210908130705718.png)

![image-20210908130810882](https://tva1.sinaimg.cn/large/008i3skNly1gu952266scj615w0j0ta402.jpg)

![image-20210908130916149](/Users/hao/Library/Application Support/typora-user-images/image-20210908130916149.png)

![image-20210908131025128](https://tva1.sinaimg.cn/large/008i3skNly1gu954dsxh6j60wo0aq75102.jpg)

![image-20210908131106040](https://tva1.sinaimg.cn/large/008i3skNly1gu9552rhh9j60oq04ywev02.jpg)

![image-20210908131157538](https://tva1.sinaimg.cn/large/008i3skNly1gu9560tqjuj616q0gywge02.jpg)

![image-20210908131209886](https://tva1.sinaimg.cn/large/008i3skNly1gu9566t05cj60tg0by75w02.jpg)

![image-20210908131348767](https://tva1.sinaimg.cn/large/008i3skNly1gu957wdm7wj612s01ydfw02.jpg)

-o 对数据进行筛选

![image-20210908131620738](https://tva1.sinaimg.cn/large/008i3skNly1gu95aqsb94j61pm06075g02.jpg)

-v 过滤掉指定要过滤的内容

![image-20210908132239886](https://tva1.sinaimg.cn/large/008i3skNly1gu95h4kzuoj61200dsaew02.jpg)

![image-20210908132317394](https://tva1.sinaimg.cn/large/008i3skNly1gu95hraqanj60x80eadgn02.jpg)

![image-20210908133752034](https://tva1.sinaimg.cn/large/008i3skNly1gu95wxntzuj60yq0ioq4o02.jpg)

文件统计及格式化数据  ![image-20210908133853534](https://tva1.sinaimg.cn/large/008i3skNly1gu95y09neaj60xo0fymzp02.jpg)

NR内建变量；显示表头，表头在第一行NR=1

默认分隔符是空格，-F用来选择其他分隔符

![image-20210908135837608](/Users/hao/Library/Application Support/typora-user-images/image-20210908135837608.png)

![image-20210908135938211](https://tva1.sinaimg.cn/large/008i3skNly1gu96jlvq1zj60sk0g4dgv02.jpg)

![image-20210908140342260](https://tva1.sinaimg.cn/large/008i3skNly1gu96ntjtj6j611y0l00xi02.jpg)

内容朱行统计，并列出结果

![image-20210908140550198](https://tva1.sinaimg.cn/large/008i3skNly1gu96q0vo62j60wi0g4q4302.jpg)

grep过滤，awk整理

![image-20210908141254334](https://tva1.sinaimg.cn/large/008i3skNly1gu96xdps1sj60g404amx802.jpg)

![image-20210908141348266](https://tva1.sinaimg.cn/large/008i3skNly1gu96ybme5rj60yu0budgm02.jpg)

![image-20210908141415562](https://tva1.sinaimg.cn/large/008i3skNly1gu96ytdcllj60qu06yq3j02.jpg)

s/:这里s表示进行字符串操作

![image-20210908141558975](https://tva1.sinaimg.cn/large/008i3skNly1gu970ldf9pj60v80kcgo302.jpg)

![image-20210908141644726](https://tva1.sinaimg.cn/large/008i3skNly1gu971dprtqj60qy07qq3r02.jpg)

不加-i只是输出到终端,并没修改

![image-20210908141714991](https://tva1.sinaimg.cn/large/008i3skNly1gu971wfhyyj60r607o75502.jpg)

不加g就是非全局的,只匹配替换第一次匹配到的

![image-20210908141816471](https://tva1.sinaimg.cn/large/008i3skNly1gu972zb9mfj60rw07uwfb02.jpg)

![image-20210908141904866](https://tva1.sinaimg.cn/large/008i3skNly1gu973v2zhdj60sg0ecmy302.jpg)

删除行

![image-20210908142831530](https://tva1.sinaimg.cn/large/008i3skNly1gu97dms3kxj60ne0580tg02.jpg)

![image-20210908142912905](https://tva1.sinaimg.cn/large/008i3skNly1gu97ecuqjcj60q804yjs202.jpg)

面试：用指令筛选出需要的数据

![image-20210908142952899](https://tva1.sinaimg.cn/large/008i3skNly1gu97f1rxksj60m80ie3z102.jpg)