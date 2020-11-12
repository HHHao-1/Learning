# 简介

Compass是在Sass基础上二次开发的一套css框架。

> 常用命令：
>
> - compass create test
>
> - compass watch
>
> - compass compile

Compass内置模块可实现复杂且可复用的功能。

**核心模块：**

![image-20201104205526287](https://tva1.sinaimg.cn/large/0081Kckwly1gkdfpkqdhtj31cc0hw11b.jpg)

# Compass搭建项目

```scss
compass create sass

directory sass/sass/                  // sass文件所在目录;
directory sass/stylesheets/           // css文件所在目录;
create sass/config.rb                 // 项目配置文件;

-----------------------------------------------------------------------------------------
create sass/sass/screen.scss          // 主要针对屏幕的sass文件;
create sass/sass/print.scss           // 主要针对打印设备;
create sass/sass/ie.scss              // 主要针对IE浏览器;
write sass/stylesheets/ie.css
write sass/stylesheets/print.css
write sass/stylesheets/screen.css     // scss文件编译后对应的css文件;最终将引入到HTML中的文件;
```