# Apache

## 简介

Apache只是一个web服务器，负责响应客户端请求。对于静态页面请求，会立即返回相应页面给客户端；

如果是动态页面，Apache会根据 httpd.conf中的AddType配置，提交给合适的动态脚本解析程序预处理，然后将脚本解析程序处理后生成的静态页面返回给客户端。  

单纯只安装apache是无法处理动态页面的，必须安装相应的动态脚本解析程序或动态库，并在httpd.conf中增加必要的AddType配置项 （如：要支持php脚本，需要安装php，并在httpd.conf中增加配置 AddType application/x-httpd-php .php；要支持jsp需要结合tomcat）。

## 快速使用

### 1. 启动 Apache 服务

在终端输入命令：`sudo apachectl start`

```properties
在浏览器中输入如下网址，检查 Apache 服务是否启动成功！
    http://localhost
    http://127.0.0.1
在打开的页面中，如果显示 It works！表示 Apache 服务启动成功。
```

### 2. 查看 Apache 版本

在终端输入命令：`sudo apachectl -v`

```properties
在本机中版本信息如下:
    Server version: Apache/2.4.28 (Unix)
    Server built:   Oct 29 2017 19:28:54
```

### 3. 关闭 Apache 服务

在终端输入命令：`sudo apachectl stop`

### 4. 重启 Apache 服务

在终端输入命令：`sudo apachectl restart`

## 配置

### 1. 安装路径

Apache 服务默认安装路径在 /private/etc/apache2/ ，属于系统私有目录，不可以直接在 Finder 中找到该路径

### 2. 部署路径

Apache 服务部署路径在 资源库/WebServer/Documents/ ，我们的项目需要放置在该路径下才能正常访问。如果想要修改部署路径，可以在 /private/etc/apache2/目录下找到并打开httpd.conf文件，搜索 DocumentRoot 修改部署路径。

  **注意：Mac下修改路径后，部署文件需要使用  chmod  777  文件路径命令赋予访问权限。**

### 3. 端口号

Apache 服务端口号默认为 80，如果想要修改端口号，可以在/private/etc/apache2/ 目录下找到并打开 httpd.conf 文件，搜索  Listen 80 修改端口号。


