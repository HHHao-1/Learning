# 简介

- Sass 是一种 CSS 的预编译语言。它提供了 变量（variables）、嵌套（nested rules）、 混合（mixins）、 函数（functions）等功能，并且完全兼容 CSS 语法。Sass 能够帮助复杂的样式表更有条理， 并且易于在项目内部或跨项目共享设计。

- 与CSS的关系：作为一种工具，既用工具生成CSS

- Sass工作流程

![image-20201104182722261](https://tva1.sinaimg.cn/large/0081Kckwly1gkdbfibh8gj31360eeq6c.jpg)

- .Sass与.Scss

可互相转换：`sass-convert   main.scss   main. sass`

![image-20201104182818656](https://tva1.sinaimg.cn/large/0081Kckwly1gkdbghbkk1j30uk0ig42m.jpg)

# 基础语法

```scss
1.scss和sass文件转换
  sass-convert main.scss main.sass
  // 将scss文件转换为sass文件;

2.编译
  compass create test
  // 创建工程
  cd test
  compass watch
  // 开启监听并自动编译
  // compass compile 编译

3.变量
  // Sass通过"$"声明变量;
  >1.声明变量
  $headline-ff:"宋体",Arial,sans-serif;
  $main-sec-ff:Arial,sans-serif;
  >2.引用变量
  .headline {
    font-family: $headline-ff;
  }
  .main-sec {
    font-family: $main-sec-ff;
  }

4.@import引入文件
  >1.新建局部文件
  _variables.scss
  // 以"_"开头的局部文件,不会被编译到css;作为引入文件使用;
  >2.@import引入文件
  @improt "variables";
	// 基于Sass的既定规则:
	// 1.没有文件后缀名的时候,sass会添加.scss或.sass的后缀;
	// 2.用同一目录下,局部文件和非局部文件不能重名;
	>3.使用css原生@import的既定规则:
    >>1.当@import后边跟的文件名是以".css"结尾的时候;
    >>2.当@import后边跟的是"http://"开头的字符串的时候;
    >>3.当@import后边跟的是一个url()函数的时候
    >>4.当@import后边带有media queries的时候;

5.注释
  >1.以"/**/"注释的内容最后被输出到了对应的css文件中;
  >2.以"//"注释的内容则没有输出到对应的css文件;

6.嵌套语法
  .main-sec{
    font-family: $main-sec-ff;
    #headline {
      font-family: $main-sec-ff;
    }
  }

7.属性嵌套语法
  .headline {
    font:{
      family:$main-sec-ff;
      size:16px;
    }
  }

8.父类选择器标识符&(自身调用)
  a {
    &:hover {
      color:red;
    }
  }
	带& 编译后为 a:hover
	否则，编译后为 a :hover 相当于 a *:hover，既a标签里所有元素的hover不是a超链接的hover
```

# 进阶语法

```scss
1.变量操作
  >1.直接操作变量,即变量表达式;
  >2.通过函数;
    >>1.跟代码块无关的函数,多是sass自己内置函数,称为functions;
    >>2.可重用的代码块:称为mixin;
      >>>1.@include;(调用)               // 以复制/拷贝的方式存在;
      >>>2.@extend;(继承)                 // 以组合声明的方式存在;

2.颜色值转换;
  Sass:
    color:hsl(270,100%,50%);
  Css:
    color:#7f00ff;

3.@mixin引用
  Sass:
    @mixin col-6 {                   // 声明col-6()函数;
      width:50%;
      float:left;
    }
    .webdemo-sec {
      @include col-6                 // 通过@include引入@col-6()函数;并且可以引入多个;
      &:hover {                      // &:表示父类选择器;
        background-color:#f5f5f5;
      }
    }
  Css:
    .webdemo-sec {                   // 继承了col-6()函数的属性值;
      width:50%;
      float:left;
    }
    .webdemo-sec:hover {             // 通过"&"调用到本身;
      background-color:#f5f5f5;
    }

4.@mixin包含参数引用;
  Sass:
    @mixin col($width:50%){           // 设置默认参数值;不传参数时,属性值为默认;
      width:$width;
      float:right;
    }
    .webdemo-abc {
      @include col(60%);              // 设置传参数;
    }
  Css:
    .webdemo-abc {
      width:60%;                      // 编译后的属性值;
      float:right;
    }

5.@extend继承
  >1.extend不可以继承选择器序列;（既 .a .b{}）
  >2.使用%,用来构建只用来继承的选择器;
  Sass:
    .error {
      color:#f00;
    }
    %error {                          // 构建只用来要继承的选择器;
      background:#0f0;
    }
    .serious-error {
      @extend .error;
      @extend %error;
      border:1px solid #f00;
    }
  Css:
    .error, .serious-error {          // 继承自.error;
      color:#f00;
    }
    .serious-error {                  // 继承自%error;
      background:#0f0;
    }
    .serious-error {                  // 自己的属性;
      border:1px solid #f00;
    }

6.@function
  //注意函数是返回一个值
  @function pxToEm($px, $base: 16) {
    @return ($px / $base) * 1em;
	}

7.内置函数
  //注意函数是返回一个值
	rgba
  rgba(#102030, 0.5) => rgba(16, 32, 48, 0.5)
  rgba(blue, 0.2)    => rgba(0, 0, 255, 0.2)
  
	length
  length($list)
  返回一个列表的长度
  length(10px) => 1
  length(#514721 #FFF6BF #FFD324) => 3
  
	nth
  nth(𝑙𝑖𝑠𝑡,n);
  返回列表里面第n个位置的值
  nth(10px 20px 30px, 1) => 10px
  nth((Helvetica, Arial, sans-serif), 3) => sans-serif
 
  三目判断
  if(true, 1px, 2px) => 1px
  if(false, 1px, 2px) => 2px
```

# 高级语法

```scss
1.@media用法
  // Sass中的@media与Css中的@media区别:
  // 1.Sass中的media query可以内嵌在css规则中;
  // 2.在生成css的时候,media query才会被提到样式的最高级;
  // 3.好处:避免了重复书写选择器或者打乱样式表的流程;
  Sass:
  @mixin col-sm ($width:50%){
    @media (min-width:768px){
      width:$width;
      float:left;
    }
  }
  .webdemo-sec {
    @include col-sm();
  }
  Css:
  @media (min-width:768px){
    .webdemo-sec {
      width:50%;
      float:left;
    }
  }

2.@at-root指令
  // 嵌套副作用:增加了样式修饰的权重;制造了样式位置的依赖;
  Sass:
  .main-sec {
    font-size:12px;
    @at-root {                        // 在嵌套的时候使用@at-root指令;
      .main-sec-headline {            // 指定被嵌套的内容输出到样式表的顶层;
        font-size:16px;
      }
      .main-sec-detail {
        font-size:14px;
      }
    }
  }
  Css:
  .main-sec {
    font-size:12px;
  }
  .main-sec-headline {　　　　　　　　　// 编译后成功输出到样式表的顶层;
    font-size:16px;
  }
  .main-sec-detail {
    font-size:14px;
  }

3.if操作符
  @mixin col-sa ($width:50%){
    // 使用type-of()方法:检测$width是否是数值类型;
    @if type-of($width) != number {
      // #{}:可以引用Sass的变量;--Ruby语法;
      // @error:表示错误信息;
      @error "$width必须是一个数值类型,你输入的width是:#{$width}.";
    }

    // 使用unitless()方法:判断当前的数值是否跟有单位;
    // 前置not表示否定,双重否定表示肯定;
    @if not unitless($width){             // 判断数值有单位;
      @if unit($width) != "%" {         // 如果单位不是%;
        @error "$width必须是一个数值类型,你输入的width是:#{$width}.";
      }
    } @else {                             // 判断数值没有单位;
      @warn "$width必须是一个数值类型,你输入的width是:#{$width}.";
      $width:(percentage($width)/100);  // 换算成带%单位的数值;
    }
    @media (min-width:768px){
      width:$width;
      float:left;
    }
  }

4.Sass的输出格式
  // 在config.rb配置文件里;
  >1.output_style = :expanded or :nested or :compact or :compressed
  >>0.:expanded   => 编译后的文件是展开的;
  >>1.:nested     => 根据嵌套,在输出的时候代码缩进;
  >>2.:compact    => 将所有的属性汇总到一行;选择器之间的关系更清晰;（单行css）
  >>3.:compressed => 将所有的代码压缩以占用最小的空间;
```

