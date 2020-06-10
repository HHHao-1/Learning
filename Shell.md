# 简介

**Shell是个程序**

```css
图形界面和命令行要达到的目的都是让用户控制计算机。这两者的基本过程都是类似的，都需要查找程序在硬盘上的安装位置，然后将它们加载到内存运行。

然而，真正能够控制计算机硬件（CPU、内存、显示器等）的只有操作系统内核（Kernel），图形界面和命令行只是架设在用户和内核之间的一座桥梁，这样用户就能间接地使用操作系统内核了。在Linux下，这个命令行程序叫做 Shell。

Shell 是在内核的基础上编写的一个应用程序，它和QQ没有什么区别。但Shell 也有着它的特殊性，就是开机立马启动，并呈现在用户面前；用户通过 Shell 来使用 Linux，不启动 Shell 的话，用户就没办法使用 Linux。
```

**Shell** 是个编程语言

```css
Shell 虽然没有 C++、Java、Python 等强大，但也支持了基本的编程元素

if...else 选择结构，case...in 开关语句，for、while、until 循环；

变量、数组、字符串、注释、加减乘除、逻辑运算等概念；

函数，包括用户自定义的函数和内置函数（例如 printf、export、eval 等）。

它的编译器（解释器）是 Shell 这个程序。我们平时所说的 Shell，有时候是指连接用户和内核的这个程序，有时候又是指 Shell 编程。

Shell 主要用来开发一些实用的、自动化的小工具，而不是用来开发具有复杂业务逻辑的中大型软件，

例如：检测计算机的硬件参数、搭建 Web 运行环境、日志分析等，Shell 都非常合适。
```

**Shell 是个脚本语言**

```css
任何代码最终都要被“翻译”成二进制的形式才能在计算机中执行。
```

- 编译型语言

```css
如 C/C++、Pascal、Go语言、汇编等，必须在程序运行之前将所有代码都翻译成二进制形式，也就是生成可执行文件，用户拿到的是最终生成的可执行文件，看不到源码。

这个过程叫做编译（Compile），这样的编程语言叫做编译型语言，完成编译过程的软件叫做编译器（Compiler）。
```

- 解释型语言或者脚本语言（Script）

```css
如 Shell、JavaScript、Python、PHP等，需要一边执行一边翻译，不会生成任何可执行文件，用户必须拿到源码才能运行程序。程序运行后会即时翻译，翻译完一部分执行一部分，不用等到所有代码都翻译完。

这个过程叫做解释，这样的编程语言叫做解释型语言或者脚本语言（Script），完成解释过程的软件叫做解释器。
```

- 编译型语言的优点：

```css
是执行速度快、对硬件要求低、保密性好，适合开发操作系统、大型应用程序、数据库等。
```

- 脚本语言的优点：

```css
是使用灵活、部署容易、跨平台性好，非常适合 Web 开发以及小工具的制作。

Shell 就是一种脚本语言，我们编写完源码后不用编译，直接运行源码即可。
```

# shell脚本

##日期输出

```shell
将当前时间和包含换行符的文本内容输出到文件

echo -e $(date) "\nHello World !" >> test.txt

将当前时间（格式化）和包含换行符的文本内容输出到文件

echo -e `date '+%Y-%m-%d %H:%M:%S %A'` "\nHello World !" >> test.txt

同上，简化版

echo -e `date '+%F %T %A'` "\nHello World !" >> test.txt

输出到以日期格式文件名

echo -e $(date) "\nHello World !" >> test`date +'%Y-%m-%d'`.txt
```



# crontab

## 快速使用

### 1、查看 crontab 是否启动（可选）

```shell
sudo launchctl list | grep cron
```

### 2、命令行创建crontab执行文件

```shell
> crontab -l
> crontab -e
    */1 * * * * /bin/date >> /Users/xx/time.txt
    * * * * * /bin/date >> /Users/xx/time.txt
以上代码是每分钟执行一次date命令，输出时间到time.txt文本
```

**注意：若执行脚本要赋权限：chmod 777 test.sh**

### 3、使用crontab命令调用crontab文件

```shell
crontab testing_crontab
```

## 命令及配置

### 1. 启动-停止

```shell
linux
/sbin/service crond start   启动服务
/sbin/service crond stop    关闭服务
/sbin/service crond restart 重启服务
/sbin/service crond reload  重新载入配置
sudo /etc/init.d/cron start
sudo /etc/init.d/cron stop
sudo /etc/init.d/cron restart

mac
sudo /usr/sbin/cron start
sudo /usr/sbin/cron restart
sudo /usr/sbin/cron stop
```

### 2. 命令格式

```shell
crontab [-u user] file 
crontab [-u user] [ -e | -l | -r ]
```

```css
*   -u user：用来设定某个用户的crontab服务；
*   file：file是命令文件的名字,表示将file做为crontab的任务列表文件并载入crontab。如果在命令行中没有指定这个文件，crontab命令将接受标准输入（键盘）上键入的命令，并将它们载入crontab。
*   -e：编辑某个用户的crontab文件内容。如果不指定用户，则表示编辑当前用户的crontab文件。
*   -l：显示某个用户的crontab文件内容，如果不指定用户，则表示显示当前用户的crontab文件内容。
*   -r：从/var/spool/cron目录中删除某个用户的crontab文件，如果不指定用户，则默认删除当前用户的crontab文件。
*   -i：在删除用户的crontab文件时给确认提示。
```

### 3. cron expression

```jsx
分 时 日 月 星期 要运行的命令
*   第1列分钟0～59
*   第2列小时0～23（0表示子夜）
*   第3列日1～31
*   第4列月1～12
*   第5列星期0～7（0和7表示星期天）
*   第6列要运行的命令
```

```jsx
”*” 代表取值范围内的数字
“/” 代表”每”
“-” 代表从某个数字到某个数字
“,” 分开几个离散的数字
```

### 4. 使用实例

```shell
实例1：每1分钟执行一次myCommand
* * * * * myCommand

实例2：每小时的第3和第15分钟执行
3,15 * * * * myCommand

实例3：在上午8点到11点的第3和第15分钟执行
3,15 8-11 * * * myCommand

实例4：每隔两天的上午8点到11点的第3和第15分钟执行
3,15 8-11 */2  *  * myCommand

实例5：每周一上午8点到11点的第3和第15分钟执行
3,15 8-11 * * 1 myCommand

实例6：每晚的21:30重启smb
30 21 * * * /etc/init.d/smb restart

实例7：每月1、10、22日的4 : 45重启smb
45 4 1,10,22 * * /etc/init.d/smb restart

实例8：每周六、周日的1 : 10重启smb
10 1 * * 6,0 /etc/init.d/smb restart

实例9：每天18 : 00至23 : 00之间每隔30分钟重启smb
0,30 18-23 * * * /etc/init.d/smb restart

实例10：每星期六的晚上11 : 00 pm重启smb
0 23 * * 6 /etc/init.d/smb restart

实例11：每一小时重启smb
* */1 * * * /etc/init.d/smb restart

实例12：晚上11点到早上7点之间，每隔一小时重启smb
0 23-7 * * * /etc/init.d/smb restart

实例13：每10秒执行一次
* * * * * /Users/hao/Desktop/test.sh
* * * * * sleep 10;/Users/hao/Desktop/test.sh
* * * * * sleep 20;/Users/hao/Desktop/test.sh
* * * * * sleep 30;/Users/hao/Desktop/test.sh
* * * * * sleep 40;/Users/hao/Desktop/test.sh
* * * * * sleep 50;/Users/hao/Desktop/test.sh
```

### 5. 问题记录

**crontab无法执行git push**

```css
http连接：
在.git/config下配置好用户名密码
url = https://HHHao-1:chzaizg556677@github.com/HHHao-1/Notes.git
或者在脚本中
git push https://HHHao-1:chzaizg556677@github.com/HHHao-1/Notes.git master
    
ssh连接:
查看脚本log
00 12 * * * /home/user/project_path/push.sh >> /home/user/document/error.log 2>&1
$ cat /home/user/document/error.log
发现错误的是 id_rsa 的权限问题,id_rsa 的权限是 700
sudo chmod 700 ~/.ssh/id_rsa
```

## 附注

### 1. 环境变量问题

有时我们创建了一个crontab，但是这个任务却无法自动执行，而手动执行这个任务却没有问题，这种情况一般是由于在crontab文件中没有配置环境变量引起的。

不要假定cron知道所需要的特殊环境，它其实并不知道。所以你要保证在shelll脚本中提供所有必要的路径和环境变量，除了一些自动设置的全局变量。所以注意如下3点：

1. 脚本中涉及文件路径时写全局路径；
2. 脚本执行要用到java或其他环境变量时，通过source命令引入环境变量，如:

```bash
cat start_cbp.sh
    !/bin/sh
    source /etc/profile
    export RUN_CONF=/home/d139/conf/platform/cbp/cbp_jboss.conf
    /usr/local/jboss-4.0.5/bin/run.sh -c mev &
```

当手动执行脚本OK，但是crontab死活不执行时,很可能是环境变量惹的祸，可尝试在crontab中直接引入环境变量解决问题。如:

```shell
0 * * * * . /etc/profile;/bin/sh /var/www/java/audit_no_count/bin/restart_audit.sh
```

### 2. 清理系统用户邮件日志

每条任务调度执行完毕，系统都会将任务输出信息通过电子邮件的形式发送给当前系统用户，这样日积月累，日志信息会非常大，可能会影响系统的正常运行，因此，将每条任务进行重定向处理非常重要。 例如，可以在crontab文件中设置如下形式，忽略日志输出:

```shell
0 */3 * * * /usr/local/apache2/apachectl restart >/dev/null 2>&1
```

“/dev/null 2>&1”表示先将标准输出重定向到/dev/null，然后将标准错误重定向到标准输出，由于标准输出已经重定向到了/dev/null，因此标准错误也会重定向到/dev/null，这样日志输出问题就解决了。

### 3. 关于/dev/null文件

/dev/null 是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，那么什么也读不到。但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。如果希望屏蔽 stdout 和 stderr，可以这样写：

```shell
$ command > /dev/null 2>&1
```

> **注意：**0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。

### 4. 级任务调度与用户级任务调度

系统级任务调度主要完成系统的一些维护操作，用户级任务调度主要完成用户自定义的一些任务，可以将用户级任务调度放到系统级任务调度来完成（不建议这么做），但是反过来却不行，root用户的任务调度操作可以通过”crontab –uroot –e”来设置，也可以将调度任务直接写入/etc/crontab文件，需要注意的是，如果要定义一个定时重启系统的任务，就必须将任务放到/etc/crontab文件，即使在root用户下创建一个定时重启系统的任务也是无效的。

### 5. 其他注意事项

```shell
1. 新创建的cron job，不会马上执行，至少要过2分钟才执行。如果重启cron则马上执行。

2. 当crontab失效时，可以尝试重启解决问题。

   或者查看日志看某个job有没有执行/报错：tail -f /var/log/cron。

3. 千万别乱运行crontab -r。它从Crontab目录（/var/spool/cron）中删除用户的Crontab文件。删除了该用户的所有crontab都没了。

4. 在crontab中%是有特殊含义的，表示换行的意思。如果要用的话必须进行转义%，如经常用的date +%d，对%需要使用\进行转义，否则不能按预期执行，正确做法为：
   echo "`date +\%d`" > /tmp/r1r.txt
   而不能为
   echo "`date +%d`" > /tmp/r1r.txt

5. 更新系统时间时区后需要重启cron。

6. crontab 是系统自动启动的守护进程，不能杀死，杀死后又会重生，因为人家是 crontab 啊，生来就是不能停止工作的。
```


