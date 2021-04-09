# 787原则

> 7属性-8方法-7指令

## 7属性

- el
  - 挂载vue实例的dom元素，用来指示vue编译器从什么地方开始解析vue的语法
  - 如果没有el选项可使用 vm.$mount("app")手动挂载
- data
  - 用来组织从view中抽象出来的属性，将视图的数据抽象出来存放在data中
- methods
  - 放置页面中的业务逻辑，js方法一般都放置在methods中
- computed
  - 定义计算属性的方法 
- template
  - 用来设置模板，会替换页面元素
- watch属性
  - 监听data中数据的变化
  - 两个参数，一个返回新值，一个返回旧值
- render属性
  - 创建Virtual Dom

## 8方法

初始化显示

- beforeCreate()
- created()
- beforeMount()
- mounted()

更新状态：this.xxx=value

- beforeUpdate()
- updated()

销毁 vue 实例：(View Model) vm.$destory() 

- beforeDestory()
- destoryed()

## 7指令

- v-if 条件渲染指令
  - 根据其后表达式的bool值进行判断是否渲染该元素
- v-show
  - 与v-if类似，只是会渲染其身后表达式为false的元素，相当于：style="display:none"
-  v-else
  - 必须跟在v-if/v-show指令之后，不然不起作用；如果v-if/v-show指令的表达式为true，则else元素不显示；如果v-if/v-show指令的表达式为false，则else元素会显示在页面上
-  v-for
  - 类似JS的遍历，用法为 v-for="item in items" / v-for="(item,index) in items"  items是数组，item为数组中的数组元素
-  v-bind
  -  这个指令用于响应式地更新 HTML 特性，它的语法糖为 '：'
-  v-on
  - 用于监听指定元素的DOM事件，比如点击事件，它的语法糖为 '@'
- v-model
  - 用于表单元素，进行双向数据绑定

# 生命周期

## 2.x与3.x

| 2.0 周期名称  | **3.0 周期名称** | **说明**                                 |
| ------------- | ---------------- | ---------------------------------------- |
| beforeCreate  | setup            | 组件创建之前                             |
| created       | setup            | 组件创建完成                             |
| beforeMount   | onBeforeMount    | 组件挂载之前                             |
| mounted       | onMounted        | onMounted	组件挂载完成                |
| beforeUpdate  | onBeforeUpdate   | 数据更新，虚拟 DOM 打补丁之前            |
| updated       | onUpdated        | onUpdated	数据更新，虚拟 DOM 渲染完成 |
| beforeDestroy | onBeforeUnmount  | 组件销毁之前                             |
| destroyed     | onUnmounted      | 组件销毁后                               |

# 组件选项

> **注意：**
>
> HTML 是大小写不敏感的，浏览器会把所有大写字符解释为小写字符。当使用camelCase (驼峰命名)时，需要使用其等价的 kebab-case (短横线分隔命名) 命名。

## name

组件名，可被vue-devtools追踪到

## el、data

el：用来挂载vue实例的dom元素；如果没有el选项可使用 vm.$mount("app")手动挂载

```js
var vm = new Vue({
  el:"#app2",
  //data:{
  //    message : "I am message."
  //},
  data(){
    return{
      message : "I am message."
    }
  },
  methods: {
    format(row, column) {
      console.log('test')
    }
  }
});
console.log(vm.$el);          //vm2.$el === 原生js中document.getElementById("app2") 
vm.$el.style.color = "red";   //变成红色
```

## components

```js
<top-bar></top-bar>
import TopBar from "@/components/bar/TopBar";
//import NewName from "@/components/bar/TopBar";
export default{
  components: {
    TopBar,
    //TopBar:NewName
  }
}
```

## props

外部数据，父元素-->子元素；这里的数据在调用上和data中的数据一样

```js
<child :text="scope.column.label"></child>
export default{
  //props: ['text'],
  
  props: {
    // 基础类型检测, null意味着任何类型都行
    propA: Number,
    // 多种类型
    propB: [String, Number],
    // 必传且是String
    propC: {
      type: String,
      required: true
    },
    // 数字有默认值
    propD: {
      type: Number,
      default: 101
    },
    // 数组、默认值是一个工厂函数返回对象
    propE: {
      type: Object,
      default: function() {
        console.log("propE default invoked.");
        return { message: "I am from propE." };
      }
    },
    // 自定义验证函数
    propF: {
      isValid: function(value) {
        return value > 100;
      }
    },
  }
}
```

## watch

```js
export default{
  data(){
    return{
      table1:[]
    }
  },
  
  watch: {
    table(newVal,oldVal){
      console.log(123)//基础数据类型监测
    },
    table2: {
      handler: function (newVal,oldVal) {
        console.log(123)//深度监测对象、数组等
      },
      deep: true,
    },
  }
}
```

## computed

```js
<input v-model="fullName"></input>
export default{
  computed:{
    fullName(){
      return this.firstName+""+this.lastName
    },
    fullName:{
      get(){
        return this.firstName+""+this.lastName
      },
      set(newVal){ //set方法接受v-model输入的newVal
        const twoName= newVal.split('')
        this.firstName = twoName[0]
        this.firstName = twoName[1]
      }

    },
  },
  
  methods:{
    test(){
      console.log(this.fullName)
    }
  }
}
```

## filters

```js
// 1. 插值表达式用法 {{'data1' | globalFilter}}
{{'2018' | filterA | filterB}}//2018传给A，结果再传给B
{{'2018' | filterA('07','17')}}//A接受三个参数（'2018'，'07'，'17'）
{{'hello','world' | filter)}}//A接受两个参数（'hello','world'）
// v-bind表达式用法
<div v-bind:id="rawId | formatId"></div>

Vue.filter('globalFilter',(value)=>{
  return value+"!!!"
})

filters:{
  componentFilter(value){
    return value+"!!!"
  }
}
```

## mixins

一种分发Vue组件中可复用功能的非常灵活的一种方式，既混合vue实例属性

```js
// mixin.js 
export const toggle = {
  data () {
    isshowing: false
  },
  methods: {
    toggleShow() {
      this.isshowing = !this.isshowing
    }
  }
}
// mixin.vue
<script>
export default {
  data () {
    isshowing: false
  },a
  methods: {
  toggleShow() {
    this.isshowing = !this.isshowing
  }
}
}
</script>
// modal.vue
// 将mixin引入该组件，就可以直接使用 toggleShow() 了
import {mixin} from '../mixin.js'

export default {
    mixins: [mixin],
    mounted () {
        
    }
}
//全局混入, created函数将会出现在每个组件上
//为自定义的选项 'myOption' 注入一个处理器。
Vue.mixin({
  created: function () {
    var myOption = this.$options.myOption
    if (myOption) {
      console.log(myOption)
    }
  }
})
new Vue({
  myOption: 'hello!'
})
// => "hello!"
```

- 冲突解决

```css
一、数据对象内
mixin的数据对象和组件的数据发生冲突时以组件数据优先。
二、钩子函数
同名钩子函数将会混合为一个数组，都将被调用到，但是混入对象的钩子将在组件自身钩子之前调用。
三、值为对象的选项
值为对象的选项，例如 methods, components 和 directives，将被混合为同一个对象。两个对象键名冲突时，取组件对象的键值对。
```

## directives

自定义指令

```js
<input v-focus>
directives: {
  focus: {
    inserted: function (el) {
      el.focus()
    }
  }
}
// 注册一个全局自定义指令 `v-focus`
Vue.directive('focus', {
  // 当被绑定的元素插入到 DOM 中时执行
  inserted: function (el) {
    // 聚焦元素，input元素在页面初始化时就处于聚焦状态
    el.focus()
  }
})
```

## template

```html
<div id="app"></div>

<template id="demo3">
  <h1 style="color:red">我是选项模板3</h1>
</template>

<script type="x-template" id="demo4">
    <h1 style="color:red">我是script标签模板4</h1>
</script>

<script>
  var vm=new Vue({
    el:"#app",
    data:{
      message:1
    },

    //第1种模板 写在构造器里
    //template:`<h1 style="color:red">我是选项模板2</h1>`

    //第2种模板 写在<template>标签里
    //template:'#demo3'

    //第3种模板 写在<script type="x-template">标签里
    //template:'#demo4'

    //第4种模板 写在<script>内或App.vue
    //template: '<App />'
    //components: {App,}
    // 组件App.vue 或如下
    //let App = {template: '<div>欢迎使用！</div>'}
  })
</script>
```

## extend

```js
//vue实例中如果有add方法，则会用vue实例中的方法。如果没有，则用extends选项扩展出的add方法
let extendObj = {
  methods: {
    add : function () {
      console.log("this is extend add");
    }
  }
};

let vue = new Vue({
  el: "#app",
  data: {
    num : 1
  },
  methods: {
    add : function () {
      console.log("this is original add");
      this.num++;
    }
  },
  extends: extendObj
});
```

```js
<div id="mount-point"></div>
// 使用基础 Vue 构造器，创建一个“子类”。参数是一个包含组件选项的对象，data在Vue.extend()中必须是函数
var Profile = Vue.extend({
  template: '<p>{{firstName}} {{lastName}} aka {{alias}}</p>',
  data: function () {
    return {
      firstName: 'Walter',
      lastName: 'White',
      alias: 'Heisenberg'
    }
  }
})
// 创建 Profile 实例，并挂载到一个元素上。
new Profile().$mount('#mount-point')

// 注册组件，传入一个扩展过的构造器
Vue.component('my-component', Vue.extend({ /* ... */ }))
// 注册组件，传入一个选项对象 (自动调用 Vue.extend)
Vue.component('my-component', { /* ... */ })
// 获取注册的组件 (始终返回构造器)
var MyComponent = Vue.component('my-component')
```

## render

```html
<div id="div1">
  <child :level="3">Hello world!</child>
</div>

<!--不使用render函数-->
<script type="text/x-template" id="template">
  <div>
    <h1 v-if="level === 1">
      <slot></slot>
  </h1>
    <h2 v-if="level === 2">
      <slot></slot>
  </h2>
    <h3 v-if="level === 3">
      <slot></slot>
  </h3>
  </div>
</script>
<script type="text/javascript">
  Vue.component('child', {
    template: '#template',
    props: {
      level: {
        type: Number,
        required: true
      }
    }
  })
  new Vue({
    el:"#div1"
  })
</script>

<!--使用render函数-->
<script type="text/javascript">
  Vue.component('child', {
    render: function (createElement) {
      return createElement(
        'h' + this.level,   // tag name 标签名称
        this.$slots.default // 子组件中的阵列
      )
    },
    props: {
      level: {
        type: Number,
        required: true
      }
    }
  })
  new Vue({
    el:"#div1"
  })
</script>
<!--element中render函数的使用-->
<script>
  addSearch (h, {column}) {
    let inputValue = {}
    return h('el-input', {
      attrs: {
        placeholder: 'Search',
        'suffix-icon': 'el-icon-search'
      },
      style: {
        paddingRight: '5px'
      },
      on: {
        input: val => {
          inputValue = val
          if (!inputValue) {
            this.vaildInputValue(column.label, inputValue)
          }
        },
        'change': () => {
          console.log('click')
          this.vaildInputValue(column.label, inputValue)
        },
        'enter': () => {
          console.log(enter)
          this.vaildInputValue(column.label, inputValue)
        }
      }
    })
</script>
```

```js
// @returns {VNode}
createElement(
  // {String | Object | Function}
  // 一个 HTML 标签名、组件选项对象，或者
  // resolve 了上述任何一种的一个 async 函数。必填项。
  'div',

  // {Object}
  // 一个与模板中 attribute 对应的数据对象。可选。
  {
    // (详情见下一段)
  },

  // {String | Array}
  // 子级虚拟节点 (VNodes)，由 `createElement()` 构建而成，
  // 也可以使用字符串来生成“文本虚拟节点”。可选。
  [
    '先写一些文字',
    createElement('h1', '一则头条'),
    createElement(MyComponent, {
      props: {
        someProp: 'foobar'
      }
    })
  ]
)
```

```json
{
  // 与 `v-bind:class` 的 API 相同，
  // 接受一个字符串、对象或字符串和对象组成的数组
  'class': {
    foo: true,
    bar: false
  },
  // 与 `v-bind:style` 的 API 相同，
  // 接受一个字符串、对象，或对象组成的数组
  style: {
    color: 'red',
    fontSize: '14px'
  },
  // 普通的 HTML attribute
  attrs: {
    id: 'foo'
  },
  // 组件 prop
  props: {
    myProp: 'bar'
  },
  // DOM property
  domProps: {
    innerHTML: 'baz'
  },
  // 事件监听器在 `on` 内，
  // 但不再支持如 `v-on:keyup.enter` 这样的修饰器。
  // 需要在处理函数中手动检查 keyCode。
  on: {
    click: this.clickHandler
  },
  // 仅用于组件，用于监听原生事件，而不是组件内部使用
  // `vm.$emit` 触发的事件。
  nativeOn: {
    click: this.nativeClickHandler
  },
  // 自定义指令。注意，你无法对 `binding` 中的 `oldValue`
  // 赋值，因为 Vue 已经自动为你进行了同步。
  directives: [
    {
      name: 'my-custom-directive',
      value: '2',
      expression: '1 + 1',
      arg: 'foo',
      modifiers: {
        bar: true
      }
    }
  ],
  // 作用域插槽的格式为
  // { name: props => VNode | Array<VNode> }
  scopedSlots: {
    default: props => createElement('span', props.text)
  },
  // 如果组件是其它组件的子组件，需为插槽指定名称
  slot: 'name-of-slot',
  // 其它特殊顶层 property
  key: 'myKey',
  ref: 'myRef',
  // 如果你在渲染函数中给多个元素都应用了相同的 ref 名，
  // 那么 `$refs.myRef` 会变成一个数组。
  refInFor: true
}
```

# 应用

## JSX

JSX语法是在JS代码里直接写XML，每个标签都会被JSX转换工具转换成纯JS代码

Vue使用JSX需要Babel plugin

```js
//不使用JSX这么写
render: function (h) {
  h(
    'div', 
    [
      h('span', 'Hello'),
      ' world!'
    ]
  )
}
//使用JSX可以像写xml/html这类标签语言一样写
//从Babel的3.4.0开始，自动注入 const h = this.$createElement，这样就可以去掉 (h) 参数了
render (h) {
  return (
    <div>
    	<span>Hello</span> world!
    </div>
  )
}
```

## 插槽

```vue
<template id="myLayout">
	<div>
  	<slot :player="players"></slot>
    <slot name="haveName"></slot>
  </div>
</template>
<script>
  export default {
    data:{
      players:["jordan","kobe","james","curry"]
    }
  }
</script>

<template id="myLayout">
	<my-layout>
		<template #default="slotProps">
      <h1>{{slotProps.player}}</h1>
		</template>
		<template v-slot:haveName>
		</template>
  </my-layout>
</template>
```

## 组件通信

### 传递

> 可传递数据、方法

- 父组件 --> 子组件：props

- 子组件 --> 父组件：$emit

  - ```js
    //子组件
    //this.$emit('父组件事件', ...参数)
    this.$emit('tableDate', this.table, this.tempData, this.mapDto, column)
    //父组件
    <child @tableDate="getDate"/>
    ```

### 引用

> \$parent、\$children不是响应式的；$children不保证顺序

- 父组件引用子组件：ref、$children

  - ```js
    <child ref="alias"></child>
    <h1 ref="getDom">中国是伟大的祖国</h1>
    <script>
      // 这里可以使用到child组建中的data、methods等
      console.log(this.$refs.alias.test)
    	console.log(this.$refs.getDom.innerText)
    </script>
    ```

  - ```js
    for(let i=0;i<this.$children.length;i++){
           console.log(this.$children[i].msg) //输出子组件的msg数据
     }
    ```

- 子组件引用父组件：$parent

## \<component>

### 动态组件

\<component>里使用 v-bind: is，可实现动态组件的效果

```js
<div id="app">
<component v-bind:is="whichcomp"></component>
<button v-on:click="choosencomp('a')">a</button>
</div>
var app=new Vue({
  el: '#app',
	components:{
		acomp:{
		   template:`
				<p>这里是组件A</p>
			`
			},
		bcomp:{
		   template:`
				<p>这里是组件B</p>		`
		},
		ccomp:{
			template:`
				<p>这里是组件C</p>
		`
		}},
	data:{whichcomp:""},
	methods:{
	   choosencomp:function(x){
	   this.whichcomp=x+"comp"}
   }
})
```

### \<keep-alive>

> \<keep-alive> 要求被切换到的组件都有自己的名字

```html
<!-- 失活的组件将会被缓存、避免重复渲染；切换组件时组件状态会被缓存、可获得此组件之前的状态-->
<keep-alive>
  <component v-bind:is="currentTabComponent"></component>
</keep-alive>
```

## 动态样式

### class

```js
// 1. 对象语法
<div class="static" v-bind:class="{ active: isActive, 'text-danger': hasError }"></div>
data: {
  isActive: true,
  hasError: false
}
<div v-bind:class="classObject"></div>
data: {
  classObject: {
    active: true,
    'text-danger': false
  }
}
data: {
  isActive: true,
  error: null
},
computed: {
  classObject: function () {
    return {
      active: this.isActive && !this.error,
      'text-danger': this.error && !this.isActive
    }
  }
}
```

```js
// 2.数组语法
<div v-bind:class="[activeClass, errorClass]"></div>
data: {
  activeClass: 'active',
  errorClass: 'text-danger'
}
<div v-bind:class="[isActive ? activeClass : '', errorClass]"></div>
<div v-bind:class="[{ active: isActive }, errorClass]"></div>
```

### style

```js
// 1. 对象语法
<div v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
data: {
  activeColor: 'red',
  fontSize: 30
}
<div v-bind:style="styleObject"></div>
data: {
  styleObject: {
    color: 'red',
    fontSize: '13px'
  }
}
```

```js
// 2.数组语法
<div v-bind:style="[baseStyles, overridingStyles]"></div>
data: {
  baseStyle1: {
    backgroundColor: 'red'
  },
    baseStyle2: {
      color: 'green'
    }
}
// 从 2.3.0起
<div :style="{ display: ['-webkit-box', '-ms-flexbox', '-webkit-flex', 'flex'] }"></div>
```



# 配置

## vue.config.js

此配置文件不影响nginx配置

```js
module.exports = {
  devServer: {
    proxy: {
      '/investigation': {
        target: 'http://192.168.7.105:9080/',
        // target: 'http://10.0.1.59:9091/',
        changeOrigin: true
      }
    }
  },
  // 改为false，否则生产环境里可以看到所有的源码
  productionSourceMap: false,
  // 关掉lint检查
  lintOnSave: false,
  // 开启调试
  configureWebpack: {
    devtool: 'source-map'
  },
  chainWebpack: config => {
    config
      .plugin('html')
      .tap(args => {
        args[0].title = 'chaindigg'
        return args
      })
  }
}
```

# VUE3

```tsx
//test.tsx
export default function(){
  setup(){
    const a = ref(1)
    return ()=>{
      <>
      	<div>a.value</div>
      </>
    }
  }
}
//test.vue
<template>
  <test/>
</template>
```

