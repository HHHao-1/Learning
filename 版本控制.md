# Git 

## GIT原理

```css
克隆 Git 资源作为工作目录。
在克隆的资源上添加或修改文件。
如果其他人修改了，你可以更新资源。
在提交前查看修改。
提交修改。
在修改完成后，如果发现错误，可以撤回提交并再次修改并提交。
```

![59c31e4400013bc911720340](https://tva1.sinaimg.cn/large/007S8ZIlly1gf9fhb12v0j30wk09gdg2.jpg)

## 快速使用


```shell
$ git init

$ git add 文件名

# 添加当前目录的所有文件到暂存区
$ git add .

$ git commmit -m  "代码提交信息"

$ git remote add origin(远程仓库名) 链接

$ git push origin master

$ git push origin HEAD:test

$ git pull [remote] [branch]

$ git status

$ git log

# 下载远程仓库的所有变动
$ git fetch [remote]

# 管理远程仓库
$ git remote rm origin
$ git remote set-url origin 链接
$ git remote -v

#克隆:本地/远程SSH/远程HTTPS
$ git clone /path/to/repository
$ git clone username@host:/path/to/repository
$ git clone 连接地址
```

## Git命令大全

### 1. 新建代码库

```shell
# 在当前目录新建一个Git代码库
$ git init

# 新建一个目录，将其初始化为Git代码库
$ git init [project-name]

# 下载一个项目和它的整个代码历史
```

### 2. 配置

```shell
# 显示当前的Git配置
$ git config --list

# 编辑Git配置文件
$ git config -e [--global]

# 设置提交代码时的用户信息
$ git config [--global] user.name "[name]"
$ git config [--global] user.email "[email address]"
```

### 3. 增加/删除文件

```shell
# 添加指定文件到暂存区
$ git add [file1] [file2] ...

# 添加指定目录到暂存区，包括子目录
$ git add [dir]

# 添加当前目录的所有文件到暂存区
$ git add .

# 添加每个变化前，都会要求确认
# 对于同一个文件的多处变化，可以实现分次提交
$ git add -p

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]

# 改名文件，并且将这个改名放入暂存区
$ git mv [file-original] [file-renamed]
```

### 4. 代码提交

```shell
# 提交暂存区到仓库区
$ git commit -m [message]

# 提交暂存区的指定文件到仓库区
$ git commit [file1] [file2] ... -m [message]

# 提交工作区自上次commit之后的变化，直接到仓库区
$ git commit -a

# 提交时显示所有diff信息
$ git commit -v

# 使用一次新的commit，替代上一次提交
# 如果代码没有任何新变化，则用来改写上一次commit的提交信息
$ git commit --amend -m [message]

# 重做上一次commit，并包括指定文件的新变化
$ git commit --amend [file1] [file2] ...
```

### 5. 分支

```shell
# 列出所有本地分支
$ git branch
 
# 列出所有远程分支
$ git branch -r
 
# 列出所有本地分支和远程分支
$ git branch -a
 
# 新建一个分支，但依然停留在当前分支
$ git branch [branch-name]
 
# 新建一个分支，并切换到该分支
$ git checkout -b [branch]
 
# 新建一个分支，指向指定commit
$ git branch [branch] [commit]
 
# 新建一个分支，与指定的远程分支建立追踪关系
$ git branch --track [branch] [remote-branch]
 
# 切换到指定分支，并更新工作区
$ git checkout [branch-name]
 
# 切换到上一个分支
$ git checkout -
 
# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]
 
# 合并指定分支到当前分支
$ git merge [branch]
 
# 选择一个commit，合并进当前分支
$ git cherry-pick [commit]
 
# 删除分支
$ git branch -d [branch-name]
 
# 删除远程分支
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]
```

### 6. 标签

```shell
# 列出所有tag
$ git tag
 
# 新建一个tag在当前commit
$ git tag [tag]
 
# 新建一个tag在指定commit
$ git tag [tag] [commit]
 
# 删除本地tag
$ git tag -d [tag]
 
# 删除远程tag
$ git push origin :refs/tags/[tagName]
 
# 查看tag信息
$ git show [tag]
 
# 提交指定tag
$ git push [remote] [tag]
 
# 提交所有tag
$ git push [remote] --tags
 
# 新建一个分支，指向某个tag
$ git checkout -b [branch] [tag]
```

### 7.远程同步

```shell
# 下载远程仓库的所有变动
$ git fetch [remote]
 
# 显示所有远程仓库
$ git remote -v
 
# 显示某个远程仓库的信息
$ git remote show [remote]
 
# 增加一个新的远程仓库，并命名
$ git remote add [shortname] [url]
 
# 取回远程仓库的变化，并与本地分支合并
$ git pull [remote] [branch]
 
# 上传本地指定分支到远程仓库
$ git push [remote] [branch]
 
# 强行推送当前分支到远程仓库，即使有冲突
$ git push [remote] --force
 
# 推送所有分支到远程仓库
$ git push [remote] --all
```

### 8. 查看信息

```shell
# 显示有变更的文件
$ git status
 
# 显示当前分支的版本历史
$ git log
 
# 显示commit历史，以及每次commit发生变更的文件
$ git log --stat
 
# 搜索提交历史，根据关键词
$ git log -S [keyword]
 
# 显示某个commit之后的所有变动，每个commit占据一行
$ git log [tag] HEAD --pretty=format:%s
 
# 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
$ git log [tag] HEAD --grep feature
 
# 显示某个文件的版本历史，包括文件改名
$ git log --follow [file]
$ git whatchanged [file]
 
# 显示指定文件相关的每一次diff
$ git log -p [file]
 
# 显示过去5次提交
$ git log -5 --pretty --oneline
 
# 显示所有提交过的用户，按提交次数排序
$ git shortlog -sn
 
# 显示指定文件是什么人在什么时间修改过
$ git blame [file]
 
# 显示暂存区和工作区的差异
$ git diff
 
# 显示暂存区和上一个commit的差异
$ git diff --cached [file]
 
# 显示工作区与当前分支最新commit之间的差异
$ git diff HEAD
 
# 显示两次提交之间的差异
$ git diff [first-branch]...[second-branch]
 
# 显示今天你写了多少行代码
$ git diff --shortstat "@{0 day ago}"
 
# 显示某次提交的元数据和内容变化
$ git show [commit]
 
# 显示某次提交发生变化的文件
$ git show --name-only [commit]
 
# 显示某次提交时，某个文件的内容
$ git show [commit]:[filename]
 
# 显示当前分支的最近几次提交
$ git reflog

#查看用户名和邮箱地址
$ git config user.name
$ git config user.email

#修改用户名和邮箱地址
$  git config --global user.name  "xxxx"
S  git config --global user.email  "xxxx"
```

### 9. 撤销

```shell
# 恢复暂存区的指定文件到工作区
$ git checkout [file]
 
# 恢复某个commit的指定文件到暂存区和工作区
$ git checkout [commit] [file]
 
# 恢复暂存区的所有文件到工作区
$ git checkout .
 
# 重置暂存区的指定文件，与上一次commit保持一致，但工作区不变
$ git reset [file]
 
# 重置暂存区与工作区，与上一次commit保持一致
$ git reset --hard
 
# 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变
$ git reset [commit]
 
# 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
$ git reset --hard [commit]
 
# 重置当前HEAD为指定commit，但保持暂存区和工作区不变
$ git reset --keep [commit]
 
# 新建一个commit，用来撤销指定commit
# 后者的所有变化都将被前者抵消，并且应用到当前分支
$ git revert [commit]
 
# 暂时将未提交的变化移除，稍后再移入
$ git stash
$ git stash pop
```

### 10. 忽略文件

**.gitignore忽略优先级**

```css
在 .gitingore 文件中，每一行指定一个忽略规则，Git 检查忽略规则的时候有多个来源，它的优先级如下（由高到低）：
- 从命令行中读取可用的忽略规则
- 当前目录定义的规则
- 父级目录定义的规则，依次递推
- $GIT_DIR/info/exclude 文件中定义的规则
- core.excludesfile中定义的全局规则
```

  **.gitignore匹配语法**

```css
在 .gitignore 文件中，每一行的忽略规则的语法如下：
- 空格不匹配任意文件，可作为分隔符，可用反斜杠转义
- \# 开头的文件标识注释，可以使用反斜杠进行转义
- ! 开头的模式标识否定，该文件将会再次被包含，如果排除了该文件的父级目录，则使用 ! 也不会再次被包含。可以使用反斜杠进行转义
- / 结束的模式只匹配文件夹以及在该文件夹路径下的内容，但是不匹配该文件
- / 开始的模式匹配项目跟目录
- 如果一个模式不包含斜杠，则它匹配相对于当前 .gitignore 文件路径的内容，如果该模式不在 .gitignore 文件中，则相对于项目根目录
- ** 匹配多级目录，可在开始，中间，结束
- ? 通用匹配单个字符
- [] 通用匹配单个字符列表
```

**常用匹配示例**

```css
- bin/: 忽略当前路径下的bin文件夹，该文件夹下的所有内容都会被忽略，不忽略 bin 文件
- /bin: 忽略根目录下的bin文件
- /*.c: 忽略 cat.c，不忽略 build/cat.c
- debug/*.obj: 忽略 debug/io.obj，不忽略 debug/common/io.obj 和 tools/debug/io.obj
- **/foo: 忽略/foo, a/foo, a/b/foo等
- a/**/b: 忽略a/b, a/x/b, a/x/y/b等
- !/bin/run.sh: 不忽略 bin 目录下的 run.sh 文件
- *.log: 忽略所有 .log 文件
- config.php: 忽略当前路径的 config.php 文件
```

**忽略不生效**
		.gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。解决方法就是先把本地缓存删除（改变成未track状态），然后再提交:

```shell
git rm -r --cached .``git add .``git commit -m ``'update .gitignore'
```

## 问题记录

### 1. github无法显示图片

- 输入raw.githubusercontent.com查询IP地址
- 修改hosts文件:sudo vi /etc/hosts
- 添加以下内容保存即可 （IP地址查询后相应修改，可以ping不同IP的延时 选择最佳IP地址）

```css
# GitHub Start
52.74.223.119 github.com
192.30.253.119 gist.github.com
54.169.195.247 api.github.com
185.199.111.153 assets-cdn.github.com
151.101.76.133 raw.githubusercontent.com
151.101.108.133 user-images.githubusercontent.com
151.101.76.133 gist.githubusercontent.com
151.101.76.133 cloud.githubusercontent.com
151.101.76.133 camo.githubusercontent.com
151.101.76.133 avatars0.githubusercontent.com
151.101.76.133 avatars1.githubusercontent.com
151.101.76.133 avatars2.githubusercontent.com
151.101.76.133 avatars3.githubusercontent.com
151.101.76.133 avatars4.githubusercontent.com
151.101.76.133 avatars5.githubusercontent.com
151.101.76.133 avatars6.githubusercontent.com
151.101.76.133 avatars7.githubusercontent.com
151.101.76.133 avatars8.githubusercontent.com
# GitHub End
```

# SVN 

## SVN 原理

**SVN 简介**

```css
Subversion(SVN) 是一个开源的版本控制系統, 也就是说 Subversion 管理着随时间改变的数据。 这些数据放置在一个中央资料档案库(repository) 中。 这个档案库很像一个普通的文件服务器, 不过它会记住每一次文件的变动。 这样你就可以把档案恢复到旧的版本, 或是浏览文件的变动历史。
```

**SVN 的一些概念**

```css
repository（源代码库）:源代码统一存放的地方

Checkout（提取）:当你手上没有源代码的时候，你需要从repository checkout一份

Commit（提交）:当你已经修改了代码，你就需要Commit到repository

Update（更新）:当你已经Checkout了一份源代码， Update一下你就可以和Repository上的源代码同步，你手上的代码就会有最新的变更

日常工作流程 ：Checkout（克隆,一段时间后）--> Update(获得最新的代码) -->  作出自己的修改并调试成功 --> Commit(大家就可以看到你的修改了) 。

Conflict（冲突）: 如果两个程序员同时修改了同一个文件呢, SVN 可以合并这两个程序员的改动，实际上SVN管理源代码是以行为单位的，就是说两个程序员只要不是修改了同一行程序，SVN都会自动合并两种修改。如果是同一行，SVN 会提示文件 Conflict,冲突，需要手动确认。
```

**SVN 工作流程**

**创建版本库**

```css
版本库相当于一个集中的空间，用于存放开发者所有的工作成果。版本库不仅能存放文件，还包括了每次修改的历史，即每个文件的变动历史。

Create 操作是用来创建一个新的版本库。大多数情况下这个操作只会执行一次。当你创建一个新的版本库的时候，你的版本控制系统会让你提供一些信息来标识版本库，例如创建的位置和版本库的名字。
```

**检出**

```css
Checkout 操作是用来从版本库创建一个工作副本。工作副本是开发者私人的工作空间，可以进行内容的修改，然后提交到版本库中。
```

**更新**

```css
Update 操作是用来更新版本库的。这个操作将工作副本与版本库进行同步。由于版本库是由整个团队共用的，当其他人提交了他们的改动之后，你的工作副本就会过期。
```

**执行变更**

```css
当检出之后，你就可以做很多操作来执行变更。编辑是最常用的操作。你可以编辑已存在的文件，例如进行文件的添加/删除操作。

你可以添加、删除、Rename、移动文件/目录。但是这些变更的文件目录不会立刻成为版本库的一部分，而是被添加进待变更列表中，直到执行了 commit 操作后才会成为版本库的一部分。
```

**复查变化**

```css
当你检出工作副本或者更新工作副本后，你的工作副本就跟版本库完全同步了。但是当你对工作副本进行一些修改之后，你的工作副本会比版本库要新。在 commit 操作之前复查下你的修改是一个很好的习惯。

Status 操作列出了工作副本中所进行的变动。正如我们之前提到的，你对工作副本的任何改动都会成为待变更列表的一部分。Status 操作就是用来查看这个待变更列表。

Status 操作只是提供了一个变动列表，但并不提供变动的详细信息。你可以用 diff 操作来查看这些变动的详细信息。
```

**修复错误**

```css
我们来假设你对工作副本做了许多修改，但是现在你不想要这些修改了，这时候 revert 操作将会帮助你。

Revert 操作重置了对工作副本的修改。它可以重置一个或多个文件/目录。当然它也可以重置整个工作副本。在这种情况下，revert 操作将会销毁待变更列表并将工作副本恢复到原始状态。
```

**解决冲突**

```css
合并的时候可能会发生冲突。Merge 操作会自动处理可以安全合并的东西。其它的会被当做冲突。例如，"hello.c" 文件在一个分支上被修改，在另一个分支上被删除了。这种情况就需要人为处理。Resolve 操作就是用来帮助用户找出冲突并告诉版本库如何处理这些冲突。
```

**提交更改**

```css
Commit 操作是用来将更改从工作副本到版本库。这个操作会修改版本库的内容，其它开发者可以通过更新他们的工作副本来查看这些修改。

在提交之前，你必须将文件/目录添加到待变更列表中。列表中记录了将会被提交的改动。当提交的时候，我们通常会提供一个注释来说明为什么会进行这些改动。这个注释也会成为版本库历史记录的一部分。

Commit 是一个原子操作，也就是说要么完全提交成功，要么失败回滚。用户不会看到成功提交一半的情况。
```

## 快速使用

```shell
svnadmin create /Users/apple/svn/mycode

svnserve -d -r /path/svn  

#初始化导入svn服务器
svn import /Users/apple/webSite svn://localhost/mycode/webSite --username=mj --password=123 -m "初始化导入"

svn checkout svn://localhost/mycode --username=mj --password=123 /Users/apple/svnwebSite

#提交更改过的代码到服务器
cd /Users/apple/svnwebSite
svn commit -m "修改了webSite文件"

#更新服务器端的代码到客户端
cd /Users/apple/svnwebSite
svn update

svn help
svnserve --version
```

## 配置及启动

**手动新建版本库目录**

```shell
mkdir /opt/svn
```

**创建版本库**

```shell
svnadmin create /opt/svn/runoob
```

**修改仓库配置**

修改conf文件夹下的svnserve.conf文件

```properties
[general]
#anon-access = none，这样禁止匿名访问，需要帐号密码才能访问
anon-access = none
auth-access = write
password-db = passwd
authz-db = authz
[sasl]
```

修改conf下的passwd文件，在[users]后面加入用户和密码

```css
  administrator = admin@Svnserver
  xiayong = xiayong
```

**启动svn服务**

> svnserve -d -r 目录 --log-file=/var/log/svn.log --listen-port 端口号

```css
-r: 配置方式决定了版本库访问方式。

--log-file=/var/log/svn.log: 指定日志路径

--listen-port: 指定SVN监听端口，不加此参数，SVN默认监听3690
```

> 两种启动方式：由于-r 配置方式的不一样，SVN启动就可以有两种不同的访问方式

> 方式一：

-r直接指定到版本库(称之为单库svnserve方式)，一个svnserve只能为一个版本库工作

```shell
svnserve -d -r /opt/svn/runoob
```

authz配置文件中对版本库权限的配置应这样写：

```properties
[groups]
admin=user1
dev=user2
[/]
@admin=rw
user2=r
```

使用类似这样的URL：svn://192.168.0.1/　即可访问runoob版本库

> 方式二：

指定到版本库的上级目录(称之为多库svnserve方式)，一个svnserve可以为多个版本库工作

```shell
svnserve -d -r /opt/svn
```


authz配置文件中对版本库权限的配置应这样写：

```properties
[groups]
admin=user1
dev=user2
[runoob:/]
@admin=rw
user2=r
[runoob01:/]
@admin=rw
user2=r
```

如果此时你还用[/]，则表示所有库的根目录，同理，[/src]表示所有库的根目录下的src目录。

使用类似这样的URL：svn://192.168.0.1/runoob　即可访问runoob版本库。

**启动测试(可选)**

```shell
telnet localhost 3690
```

**创建默认目录结构(可选)**

首先在本地把目录结构建立好

```shell
$ sudo mkdir -p /tmp/svntemp
$ cd /tmp/svntemp/
$ sudo mkdir tags trunk branches

1.trunk是主分支，是日常开发进行的地方。
2.branches是分支。一些阶段性的release版本，这些版本是可以继续进行开发和维护的，则放在branches目录中。又比如为不同用户客制化的版本，也可以放在分支中进行开发。
3.tags目录一般是只读的，这里存储阶段性的发布版本，只是作为一个里程碑的版本进行存档。
```

接下来将本地目录结构导入到我们的svn仓库中

```shell
$ sudo svn import -m 'init repo' /tmp/svntemp/ svn://localhost/local
Authentication realm: <svn://localhost:3690> af662c40-23bf-43f4-93fa-8bf7eff40771
Password for 'root':
Authentication realm: <svn://localhost:3690> af662c40-23bf-43f4-93fa-8bf7eff40771
Username: administrator
Password for 'administrator':
Adding         /tmp/svntemp/trunk
Adding         /tmp/svntemp/branches
Adding         /tmp/svntemp/tags
Committed revision 1.
```

我是使用administrator这个用户导入的，因为目前只有这个用户才有权限。

现在我们的svn服务器已经可以用了，可以使用svn://localhost/local来访问我们的local这个仓库，当然不要忘记了，我们刚才新添加了目录，需要修改权限。

```properties
[local:/branches]
@user = rw
[local:/tags]
@user = r
[local:/trunk]
@user = rw
```

**svn开机启动（可选）**

编辑/etc/rc.local文件，在这个文件中加入以下内容(此文件在Mac系统中是没有的，需要手动创建)

```shell
# to run the svnserver on the automatically.
svnserve -d -r /data/svn/repositories
```

## 问题记录

```shell
#linux 下停止所有的svn服务
killall svnserve

#windows 下停止svn服务
net stop svn 【停止服务】

#windows 下删除svn服务
sc delete svn 【删除服务】

#启动认证失败
#删除认证缓存设置即可
rm -rf ~/.subversion/auth
```

### 1. apache+svn

**mac系统在Apache中安装SVN插件**

编辑 /etc/apache2/httpd.conf 这个文件，确保该文件中有以下配置项(若没有，请加上，若注释掉的请取消注释)。注意，编辑此文件需要root权限。

```css
LoadModule dav_module libexec/apache2/mod_dav.so
LoadModule dav_fs_module libexec/apache2/mod_dav_fs.so
LoadModule dav_svn_module libexec/apache2/mod_dav_svn.so
LoadModule authz_svn_module libexec/apache2/mod_authz_svn.so
```

确认 /usr/libexec/apache2/ 目录下有上面配置项里的4个.so文件，`mod_dav``.so和mod_dav_fs.so这两个文件应该已经存在，mod_dav_svn.so和mod_authz_svn.so这两个文件需要到svn安装目录去拷贝。我假设你将svn安装在 /opt/subversion/ 下，使用如下命令拷贝文件，如果你的svn不是安装在这里，请到你的目录下面拷贝`

```bash
$ sudo cp /opt/subversion/lib/svn-apache/mod_dav_svn.so /usr/libexec/apache2/
$ sudo cp /opt/subversion/lib/svn-apache/mod_authz_svn.so /usr/libexec/apache2/
```

``

**在Apache中配置SVN**

```css
创建 /etc/apache2/other/svn.conf 这个文件，注意使用root权限才可以。
在此文件中加入以下配置
<Location /svn>
    DAV svn
    SVNParentPath /usr/local/data/svn/repositories
    SVNListParentPath on
    AuthType Basic
    AuthName "Subversion repositories"
    AuthUserFile /usr/local/data/svn/repositories/passwd
    AuthzSVNAccessFile /usr/local/data/svn/repositories/authz
    Require valid-user
</Location>
```

简单解释一下此配置

```css
SVNParentPath 目录指向我们svn仓库的上一级目录，这个目录下面的每个文件夹都会作为一个仓库。注意：我后来已经将仓库移动到了/usr/local/data/svn/repositories下面，如果大家按照我上一篇博文来配置的SVN仓库，这里的配置请改成你的SVN仓库的地址！

AuthUserFile 该配置指向svn用户配置文件

AuthzSVNAccessFile 该配置指向svn权限配置文件

AuthUserFile 和 AuthzSVNAccessFile这两个配置项建议不要指向原来仓库的配置文件，建议创建新的，SVN仓库中的配置文件只作用于某个仓库，而这里指向的配置文件作用于所有的仓库。
```

**创建用户、验证配置**

使用htpasswd命令添加用户

```bash
$ sudo htpasswd -c /usr/local/data/svn/repositories/passwd admin
New password:
Re-type new password:
Adding password for user admin
```

我们成功的添加了一个用户 admin， 并为其初始化了密码，首次添加用户使用了 -c 这个参数，以后可以不加此参数。/usr/local/data/svn/repositories/passwd是在 /etc/apache2/other/svn.conf 文件中AuthUserFile配置项指向的文件。刚添加的admin这个用户就写入了这个文件中。另外请手动在 /usr/local/data/svn/repositories/authz 为此用户配置权限。

**启动**

使用如下命令重启Apache

```bash
$ sudo apachectl restart
```

打开浏览器，在地址栏中访问http://localhost/svn/你将看到浏览器弹出了密码框让我们输入用户名密码。


