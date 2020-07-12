# 简介

## MVC

**MVC是一种设计模式**

> M-Model 模型（完成业务逻辑：由javaBean构成，service+dao+entity）
>
> V-View 视图（做界面的展示  jsp，html……）
>
> C-Controller 控制器servlet（接收请求—>调用模型—>根据结果派发页面）

**图示**

<img src="https://img.mubu.com/document_image/ed3f54cb-aeac-49c9-a65a-6c268f9328b7-6184605.jpg" alt="img" style="zoom:88%;" align="left" />

## Spring MVC

Spring框架的一个后续产品

> 目前最好的实现MVC设计模式的框架
>
> Spring框架的一个子模块,二者可以很好的结合使用,不需要整合

Springmvc的使用

> 大部分组件由框架提供,开发者只需通过配置进行关联，开发者只需手动编写 Handler，Vie

# 运行原理

## 流程图

**请求--> 中央处理器-->  委派请求由控制器处理数据并返回--> 委派数据模型由视图解析器处理并返回-->响应**

![0A7E50F3-23F6-4004-858A-47A389C763FF](https://tva1.sinaimg.cn/large/007S8ZIlly1gfodgqwtxsj30y60gkguw.jpg)

## 核心组件

- Dispatcherservlet:前置控制器

  > `<mvc:default-servlet-handler/> ` 将图片/JS/CSS等静态资源排除在外,可提高执行效率 

- Handlermapping:将请求映射到 Handler

- Handler:后端控制器,完成具体业务逻辑

- Handler interceptor:处理器拦截器

  > 类似于Servlet开发中的过滤器Filter，用于处理器进行预处理和后处理。

- HandlerexecutionChain:处理器执行链

- Handleradapter:处理器适配器。

  > 每个handler类型都不一样，要可统一执行，需要通过适配器（适配器模式的应用）

- Modelandview:裝载模型数据和视图信息

- Viewresolver:视图解析器。

# 数据绑定

## 接收数据

### URL Mapping 注解

> @RequestMapping-通用绑定
>
> ```java
> @RequestMapping("/a")
> @RequestMapping(value="/b" , method = RequestMethod. GET)
> @RequestMapping(value="/c" , method = RequestMethod. POST)
> ```
>
> @GetMapping-绑定Get请求
>
> @PostMapping-绑定Post请求

### Controller方法接收

> @RequestParam(required = true)：表示参数必填
>
> ```java
> @RequestParam(value="username") String username1,
> @RequestParam(value="age"，required=false) Integer age1)
> ```

```java
@Controller
@RequestMapping("/um")
public class URLMappingController {
    @GetMapping("/g")
    @ResponseBody
    /*
    http://localhost/um/g?manager_name=lily
    */
    public String getMapping(@RequestParam("manager_name") String managerName , Date createTime){
        System.out.println("managerName:"+managerName);
        return "This is get method";
    }  
```

```java
<body>
    <form action="/um/p1" method="post">
        <input name="username"><br/>
        <input name="password"><br/>
        <input name="createTime"><br/>
        <input type="submit" value="提交">
    </form>
</body>
    
    @PostMapping("/p")
    @ResponseBody
    //可将接收的参数强制转换类型（long）
    public String postMapping(String username,Long password){
    //User u = new User(),这样用javabean接收太麻烦
    //u.setUsername(username)
    //request.getParameter()
    System.out.println(username+":"+password);
    return "This is post method";}
```

### javabean接收

```java
@PostMapping("/p1")
@ResponseBody
//只要参数由username这个属性，springmvc就会一并为它们赋值
public String postMapping1(User user , String username){
    System.out.println(user.getUsername() + ":" + user.getPassword());
    return "<h1>这是Post响应</h1>";
}
```

## 响应结果

@ResponseBody-产生响应文本

> @ResponseBody直接产生响应体的数据,过程不涉及任何视图
>
> @ResponseBody可产生标准字符串JSON/XML等格式数据
>
> @ResponseBody被StringHttpMessageConverter所影响

ModelAndView-利用模板引擎渲染输出

> ModelAndView对象是指"模型(数据)与视图(界面)"对象
>
> 通过ModelAndView可将包含数据对象与模板引擎进行绑定
>
> SpringMVC中默认的View是JSP,也可以配置其他模板引擎

ModelAndView-应用

> mav.addobject()方法设置的属性默认存放在当前请求域中
>
> 默认ModelAndView使用请求转发(forward)至页面
>
> 重定向使用new ModelAndView("redirect:/index.jsp")

```java
@GetMapping("/view")
public ModelAndView showView(Integer userId){
    //ModelAndView mav = new ModelAndView("redirect:/view.jsp");重定向
    //重定向：在当前请求内部处理和跳转页面联系不紧密时使用
    ModelAndView mav = new ModelAndView();
    //绝对路径：路径开头的"/"表示webapp的根目录
    mav.setViewName("/view.jsp");
    //相对路径：开头没有"/"表示对于当前requestmapping路径下的相对路径
    //既需要在webapp目录创建requestmapping路径对应的文件夹um，将view.jsp放入其中
    //mav.setViewName("view.jsp");
    User user = new User();
    if(userId == 1){
        user.setUsername("lily");
    }else if(userId == 2){
        user.setUsername("smith");
    }else if(userId == 3){
        user.setUsername("lina");
    }
    mav.addObject("u" , user);
    return mav;
}
```

# 拦截器

## 简介

拦截器( interceptor)用于对URL请求进行前置/后置过滤 

interceptor与 Filter用途相似但实现方式不同 

> - 拦截器是使用JDK动态代理实现的拦截的是对应调用方法的拦截
> - 过滤器是使用Filter实 的,拦截是的request对象

interceptor底层就是基于 Spring AOPI面向切面编程实现

## 开发流程

1. **Maven依赖 servlet-api** 

> ```xml
> <dependency>
>     <groupId>javax.servlet</groupId>
>     <artifactId>javax.servlet-api</artifactId>
>     <version>3.1.0</version>
>     <!--Tomcat自带servlet-api，provided表示在开发编译环境才会引用，打包部署时会被排除-->
>     <scope>provided</scope>
> </dependency>
> ```

2. **实现Handlerlnterceptor接口** 

> prehandle-前置执行处理 
>
> ```j's
> 预处理回调方法，实现处理器的预处理（如登录检查），第三个参数为响应的处理器
> 
> 返回值：true表示继续流程（如调用下一个拦截器或处理器）；
> 
> 返回值：false表示流程中断（如登录检查失败），不会继续调用其他的拦截器或处理器，此时我们需要通过response来产生响应
> ```
>
> posthandle-目标资源已被 Spring MVC框架处理 
>
> ```
> 后处理回调方法，实现处理器的后处理（在渲染视图之前），此时我们可以通过modelAndView（模型和视图对象）对模型数据进行处理或对视图进行处理，modelAndView也可能为null。
> ```
>
> afterCompletion-响应文本已经产生
>
> ```
> 整个请求处理完毕回调方法，即在视图渲染完毕时回调，如性能监控中我们可以在此记录结束时间并输出消耗时间，还可以进行一些资源清理，类似于try-catch-finally中的finally，但仅调用处理器执行链中preHandle返回true的拦截器的afterCompletion。
> ```

```java
public class MyInterceptor1 implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println(request.getRequestURL()+"-准备执行-1");
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println(request.getRequestURL()+"-目标处理成功-1");
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println(request.getRequestURL()+"-响应内容已产生-1");
    }
}
```

![946FC175-E1A1-4664-B311-6A6EFB149FC3](https://tva1.sinaimg.cn/large/007S8ZIlly1gfpi83nb3gj30m408nguy.jpg)

> 每个被访问资源拦截器都会以此顺序执行，包括静态文件，拦截器访问静态文件不受下面这个标签控制，只要符合过滤器url的执行条件

```xml
<mvc:default-servlet-handler/> 
```

> 所以要排除不需要拦截的URI

```xml
<mvc:interceptors>
    <mvc:interceptor>
        <mvc:exclude-mapping path="/**.ico"/>
        <mvc:exclude-mapping path="/**.js"/>
        <mvc:exclude-mapping path="/**.css"/>
        <!--将静态资源都放在某一文件夹下可这样处理-->
        <mvc:exclude-mapping path="/resources/**"/>
        <bean class="com.imooc.restful.interceptor.MyInterceptor"/>
    </mvc:interceptor>
</mvc:interceptors>
```

3. **application Context配置过滤地址**

```xml
<mvc:interceptors>
    <mvc:interceptor>
        <!--拦截URI-->
        <mvc:mapping path="/**"/>
        <!--拦截过滤URI-->
        <mvc:exclude-mapping path="/resources/**"/>
        <bean class="com.imooc.restful.interceptor.AccessHistoryInterceptor"/>
    </mvc:interceptor>
</mvc:interceptors>
```

## 执行顺序

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfpjf71l4nj313t0f2wlx.jpg" alt="37EDB6EC-A0F8-4126-B804-FDE317D90C19" style="zoom:45%;" align="left" />

![292B8D8B-F3B1-40F8-91EC-2892D0A850F0](https://tva1.sinaimg.cn/large/007S8ZIlly1gfpj9b1y5zj30rz0c8wjj.jpg)



# 问题记录

## 日期类型转换

```java
1. controller方法接收数据：

public String postMapping1(User user , String username ,@DateTimeFormat(pattern = "yyyy-MM-dd") Date createTime){}

2. javabean接收数据：

@DateTimeFormat(pattern = "yyyy-MM-dd")
private Date createTime;

3. 全局日期转换：

//编写日期类型转换器
public class MyDateConverter implements Converter<String, Date> {
    public Date convert(String s) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date d = sdf.parse(s);
            return d;
        } catch (ParseException e) {
            return null;}}
}

//配置applicationContext.xml日期转换器
<bean id="conversionService" class="org.springframework.format.support.FormattingConversionServiceFactoryBean">
    <property name="converters">
    	<set>
    		<bean class="com.imooc.springmvc.converter.MyDateConverter"/>
        </set>
    </property>
</bean>
                
4. 既有全局转换又有注解转换，以注解为准(以最小范围为优先)
```

## 中文乱码

Web应用的中文乱码由来

> Tomcat默认使用字符集ISO-8859-1,属于西欧字符集
>
> 解决乱码的核心思路是将IS0-8859-1转换为UTF-8
>
> Controller中请求与响应都需要设置UTF-8字符集



中文乱码的配置

> Get请求乱码-server.xml增加URIEncoding属性
>
> Post请求乱码-web.xml配置CharacterEncodingFilter
>
> Response响应乱码-Spring配置StringHttpMessageConverter

1. Get请求乱码---tomcat配置文件;tomcat8.0以后默认utf-8,不用配置

```
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" URIEncoding="UTF-8"/>
<!-- A "Connector" using the shared thread pool-->
```

2. Post请求乱码---增加过滤器

```xml
<filter>
    <filter-name>characterFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
</filter>
<filter-mapping>
    <filter-name>characterFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

3. Response响应乱码---applicationContext.xml配置StringHttpMessageConverter

```xml
<mvc:annotation-driven conversion-service="conversionService">
    <mvc:message-converters>
        <bean class="org.springframework.http.converter.StringHttpMessageConverter">
            <property name="supportedMediaTypes">
                <list>
                    <!-- response.setContentType("text/html;charset=utf-8") 
						 底层是在响应头设置ContentType -->
                    <value>text/html;charset=utf-8</value>
                </list>
            </property>
        </bean>
    </mvc:message-converters>
</mvc:annotation-driven>
```

