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