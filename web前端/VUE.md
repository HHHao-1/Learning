# 关于vue中的$符号总结一下

### vue的实例属性和方法

除了数据属性，Vue 实例还暴露了一些有用的实例属性与方法。它们都有前缀 `$`，以便与用户定义的属性区分开来。例如：

```
var data = { a: 1 } var vm = new Vue({  el: '#example',  data: data }) vm.$data === data // => true vm.$el === document.getElementById('example') // => true // $watch 是一个实例方法 vm.$watch('a', function (newValue, oldValue) {  // 这个回调将在 `vm.a` 改变后调用 })
```

所以在vue文档的API中还可以看到完整的[实力属性](https://cn.vuejs.org/v2/api/#实例属性)和方法。

### 表示为变量

可以用来表示变量，比如变量 var s='asdsd'或var $s='asdasd';

es6中也可以采用${XXX}来在字符串中插入变量（这个记住要利用v-bind）

# es6新增语法之`${}`

这是es6中新增的字符串方法

可以配合反单引号完成拼接字符串的功能

1、反单引号怎么打出来？
将输入法调整为英文输入法，单击键盘上数字键1左边的按键。

2、用法
step1： 定义需要拼接进去的字符串变量
step2： 将字符串变量用${}包起来，再写到需要拼接的地方

3、示例代码：

```
let a='Karry Wang';

let str=`I love ${a}, because he is handsome.`;
//注意：这行代码是用返单号引起来的

alert(str);
```

一定是用反单引号啊！不要写成单引号了！！





**一、常用简写**

- `npm install`=`npm i`。在git clone项目的时候，项目文件中并没有 node_modules文件夹，项目的依赖文件可能很大。直接执行，npm会根据package.json配置文件中的依赖配置下载安装。
- `-global`=`-g`，全局安装，安装后的包位于系统预设目录下
- `--save`=`-S`，安装的包将写入package.json里面的dependencies，dependencies：生产环境需要依赖的库
- `--save-dev`=`-D`，安装的包将写入packege.json里面的devDependencies，devdependencies：只有开发环境下需要依赖的库





# [VueCli4.X 目录结构](https://www.cnblogs.com/zx-fjs/p/12769828.html)

按照目录顺序排的：

- dist:用于存放使用 *npm run build* 命令打包的项目文件
- node_modules:用于存放我们项目的各种依赖
- public：用于存放静态资源
- public/index.html：是一个模板文件，作用是生成项目的入口文件。浏览器访问项目的时候就会默认打开的是生成好的index.html。
- src：是存放各种vue文件的地方。
- src/assets：用于存放着各种静态文件，比如图片。
- src/components:用于存放我们的公共组件，比如header、footer等。
- src/router/index.js：vue-router路由文件。需要引入src/views文件夹下的.vue，配置path、name、component。
- src/store/index.js：是vuex的文件，主要用于项目里边的一些状态保存。比如state、mutations、actions、getters、modules。
- src/views：用于存放我们写好的各种页面，比如Login.vue，Home.vue。
- src/App.vue：是主vue模块，主要是使用router-link引入其他模块，App.vue是项目的主组件，所有的页面都是在App.vue下切换的。
- src/main.js：入口文件，主要作用是初始化vue实例，同时可以在此文件中引用某些组件库或者全局挂载一些变量。
- .gitignore：配置git上传想要忽略的文件格式。
- babel.config.js：是一个工具链，主要用于在当前和较旧的浏览器或环境中将ES6的代码转换向后兼容（低版本ES）。
- package.json：模块基本信息项目开发所需要的模块，版本，项目名称。
- package-lock.json：是在npm install时候生成的一份文件，用于记录当前状态下实际安装的各个npm package的具体来源和版本号



```
*//align : 垂直对齐 left middle right* 

*//justify: 水平对齐 start center end*
<Row type="flex" justify="center" align="middle">

label::before,label::after {
 display:none;
}
```





# CSS

## css3 object-fit详解

上传头像的时候遇到了头像变形的问题，最后通过object-fit: cover完美解决了。这个CSS属性可以达到最佳最完美的居中自动剪裁图片的功能。

 

**object-fit****理解**

CSS3 background-size出现的比较早，大家应该知道其支持的一些值，除了数值之外，其还支持几个关键字，例如：cover, contain等。

object-fit也是类似的，但还是有些差异，具体有5个值：

.fill { object-fit: fill; }

.contain { object-fit: contain; }

.cover { object-fit: cover; }

.none { object-fit: none; }

.scale-down { object-fit: scale-down; }

每个属性值的具体含义如下（自己理解的白话文，官方释义见官网）：

- fill: 中文释义“填充”。**默认值**。替换内容拉伸填满整个[content](https://www.ylefu.com/tags/113/) box, 不保证保持原有的比例。
- contain: 中文释义“包含”。保持原有尺寸比例。保证替换内容尺寸一定可以在容器里面放得下。因此，此参数可能会在容器内留下空白。
- cover: 中文释义“覆盖”。保持原有尺寸比例。保证替换内容尺寸一定大于容器尺寸，宽度和高度至少有一个和容器一致。因此，此参数可能会让替换内容（如[图片](https://www.ylefu.com/tags/58/)）部分区域不可见。
- none: 中文释义“无”。保持原有尺寸比例。同时保持替换内容原始尺寸大小。
- scale-down: 中文释义“降低”。就好像依次设置了none或contain, 最终呈现的是尺寸比较小的那个。

 

**object-fit****属性测试**

**下面我们来测试一下每一个属性值显示的效果每个img标签都设置的 width:200px 和 width:200px，再加上设置的object-fit属性的不同值，效果图如下：**

![img](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjpb7ob0xmj31aw0oujwv.jpg)

**object-fit****兼容性**

![img](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjpbbrjo0qj30q5080mxz.jpg)

```stylus
img {
        /* 会失真 */
        width: 100%;

        /* 解决方法一 */
        image-rendering: -moz-crisp-edges;
        /* Firefox */
        image-rendering: -o-crisp-edges;
        /* Opera */
        image-rendering: -webkit-optimize-contrast;
        /*Webkit (non-standard naming) */
        image-rendering: crisp-edges;
        -ms-interpolation-mode: nearest-neighbor;
        /* IE (non-standard property) */

        /* 解决方法二 */
        object-fit: fill;
        object-fit: contain;
        object-fit: scale-down;
    }
```

