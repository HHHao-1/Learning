# 概念

## 渐进式

Vue与其他框架的区别就是渐进式，也就是“Progressive”——这个词在英文中定义是渐进，一步一步，不是说你必须一竿子把所有的东西都用上。可以把一两个组件改用vue实现，当jQuery用；也可以整个用它全家桶开发，当Angular用。

## PWA

Progressive Web App（渐进式web应用），PWA 可以将 Web 和 App 各自的优势融合在一起：渐进式、可响应、可离线、实现类似 App 的交互、即时更新、安全、可以被搜索引擎检索、可推送、可安装、可链接。---- 既网页版app。

PWA 不是特指某一项技术，而是应用了多项技术的 Web App。其核心技术包括 App Manifest、Service Worker、Web Push，等等。

# mixins

> 混入 (mixins) 是一种分发 Vue 组件中可复用功能的非常灵活的方式。
>
> mixin的作用是提供公用数据和方法，与vuex不同的是它的数据不是共享的，只是其他组件把它定义好的数据和方法拿来用。

- 定义一个mixins.js

```jsx
let MIXINS = {
   data() {
       return {
           name: 'mixins'
       }
   },
   created() {
       console.log('mixin...', this.name);
   },
   mounted() {},
   methods: {}
};
export default MIXINS;
```

- 引用mixins

```dart
//全局引用
import mixin from './mixins'
Vue.mixin(mixin)

//在vue文件中引用
import '@/mixin'; // 引入mixin文件
export default {
   mixins: [mixin]
  methods:{
      demo1(){
        console.log(this.name);//mixins，这里可以直接调用mixins的数据、方法
      }   
  }
}
```

**当组件和mixins对象含有同名选项时：**

- 数据：组件数据优先。
- 钩子函数：混入对象的钩子将在组件自身钩子之前调用。
  - 同名钩子函数（created,mounted...）将混合为一个数组，因此都将被调用。
- 对象：两个对象键名冲突时，取组件对象的键值对。
  - 值为对象的选项（methods, components 和 directives）将被混合为同一个对象。

# Vue3

- 启动方式

```js
// src/main.js
// 调用 createApp 将返回一个新的app实例，该实例不会被应用于其他实例的任何全局配置污染。
import { createApp } from "vue";

const app = createApp({
  router,
  store,
  ...
  // 获取根实例来渲染该组件
  render: h => h(App)
});
app.mount("#app");

// Vue 3有一个更简单的方法——使 App 成为根组件
createApp(App).mount("#app");

import router from './router'
const app = createApp(App)
// 挂载我们的应用程序之前，加入其它模块
app.use(router)
app.mount('#app')

// src/App.vue
<script>
export default {
  data: () => ({
    modalOpen: true  
  }),
  methods: {
    toggleModalState() {
      this.modalOpen = !this.modalOpen;
    }
  }
};
</script>
```





# --- 记录 ---

# VueCli4目录

按照目录顺序排：

- dist
  - 用于存放使用 *npm run build* 命令打包的项目文件
- node_modules
  - 用于存放我们项目的各种依赖
- public
  - 用于存放静态资源
- public/index.html
  - 是一个模板文件，作用是生成项目的入口文件。浏览器访问项目的时候就会默认打开的是生成好的index.html。
- src
  - 是存放各种vue文件的地方。
- src/assets
  - 用于存放着各种静态文件，比如图片。
- src/components
  - 用于存放我们的公共组件，比如header、footer等。
- src/router/index.js
  - vue-router路由文件。需要引入src/views文件夹下的.vue，配置path、name、component。
- src/store/index.js
  - 是vuex的文件，主要用于项目里边的一些状态保存。比如state、mutations、actions、getters、modules。
- src/views
  - 用于存放我们写好的各种页面，比如Login.vue，Home.vue。
- src/App.vue
  - 是主vue模块，主要是使用router-link引入其他模块，App.vue是项目的主组件，所有的页面都是在App.vue下切换的。
- src/main.js
  - 入口文件，主要作用是初始化vue实例，同时可以在此文件中引用某些组件库或者全局挂载一些变量。
- .gitignore
  - 配置git上传想要忽略的文件格式。
- babel.config.js
  - 是一个工具链，主要用于在当前和较旧的浏览器或环境中将ES6的代码转换向后兼容（低版本ES）。
- package.json
  - 模块基本信息项目开发所需要的模块，版本，项目名称。
- package-lock.json
  - 是在npm install时候生成的一份文件，用于记录当前状态下实际安装的各个npm package的具体来源和版本号，不可手动更改，更改package.json后npm install自动更改

# vue实例属性和方法

除了数据属性，Vue 实例还暴露了一些有用的实例属性与方法。它们都有前缀 `$`，以便与用户定义的属性区分开来。如：

```js
var data = { a: 1 } 
var vm = new Vue({  el: '#example',  data: data }) 
vm.$data === data // => true 
vm.$el === document.getElementById('example') // => true 
// $watch 是一个实例方法 
vm.$watch('a', function (newValue, oldValue) {  
  // 这个回调将在 `vm.a` 改变后调用 
})
```

# 常用简写

- `npm install`=`npm i`。在git clone项目的时候，项目文件中并没有 node_modules文件夹，项目的依赖文件可能很大。直接执行，npm会根据package.json配置文件中的依赖配置下载安装。
- `-global`=`-g`，全局安装，安装后的包位于系统预设目录下
- `--save`=`-S`，安装的包将写入package.json里面的dependencies，dependencies：生产环境需要依赖的库
- `--save-dev`=`-D`，安装的包将写入packege.json里面的devDependencies，devdependencies：只有开发环境下需要依赖的库



