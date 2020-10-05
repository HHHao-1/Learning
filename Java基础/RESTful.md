# 简介

传统mvc是向客户端响应html页面，像微信小程序、app是不支持html的，但我们希望服务端和各个客户端都可以通信，于是restful开发风格出现了

## REST

> REST-是一种设计理念，一种架构风格
>
> REST-表现层状态转换，既资源在网络中以某种表现形式进行状态转移
>
> 「表现层」其实指的是「资源」的「表现层」。
>
> 既：资源的表现形式，通过HTTP协议提供的对数据操作形式，进行状态转移。分解开来：
>
> - Resource：资源，即数据。由URI来指定，比如usenames/users/friends/menu/order等
> - Representational：表现层。某种数据表现形式，比如用JSON，XML等
> - State Transfer：状态转移。通过HTTP动作实现，既Get、Post、Put、Delete
>
> 面向资源的架构（Resource-Oriented Architecture，ROA）:是一种具体的REST式架构

## RESTful

> RESTful-是基于REST理念的一套开发风格,是具体的开发规则
>
> 既：在web环境下以url的形式进行资源传递；
>
> 在web环境下，如果要获取某个图片，js，网页等这些资源的时候，就要以URI的形式进行指定，
>
> 访问一个图片的网址，那么这个资源返回的就是一个图片

## RESTful传输数据

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfoslpgv7xj30t70gvaf9.jpg" alt="42B18F5E-A3E3-4286-ABD1-5163035592C5" style="zoom:67%;" align="left"/>

> 服务器返回的不再是html文本，而是json或xml这样的数组；上述例子是json结构的数组，服务器端只返回数据，这种数据以json或xml的方式进行体现，同时要求返回的数据不包含任何与展现相关的内容。
>
> 当数据被送回客户端，再由客户端对这些数据进行渲染和展现。
>
> 这里前端工程师和后端工程师可以同步进行开发，只要约定好中间数据传输格式和URL。
>



## RESTful开发规范

**RESTful开发风格具体的要求**

> 1. 所有资源都使用URL作为用户交互入口
>
> 2. 明确的语义规范(GET I POST I PUT I DELETE)
>
>    "看到请求类型，就知道是做增删改查的哪一种了"
>
> 3. 只返回数据(JSON I XML),不包含任何展现

**RESTful命名要求**

> 可以把路径变量附加到URI后，如id：
>
> 第二行：查询id为1 的学生；第四行：资源由最后一个名字决定，查询id为1的作者

![776FE3BD-A458-45AE-A75D-395E244894D6](https://tva1.sinaimg.cn/large/007S8ZIlly1gfpbymwx6bj30yl0dg47o.jpg)

> 扩展：
>
> uri：url去掉域名，后面的部分；统一资源标识符
>
> url最大一般达到几千的长度，但是url的单个参数最长只能255，如果你带10个255长度的参数，那么你的url长度就达到了 2550左右，，一样是没问题的，重点值单个参数长度不能超过255。



# 应用

1. **Restcontroller** 

   默认return的是数据，而不是页面，所以不用写responsebody

2. **乱码问题**

   返回json、xml等信息需要添加响应头的编码格式

```xml
<mvc:message-converters>
    <bean class="org.springframework.http.converter.StringHttpMessageConverter">
        <property name="supportedMediaTypes">
            <list>
                <!-- response.setContentType("text/html;charset=utf-8") -->
                <value>text/html;charset=utf-8</value>
                <value>application/json;charset=utf-8</value>
            </list>
        </property>
    </bean>
</mvc:message-converters>
```

3. **路径变量**

```java
/*  /request/100  
	这个100就是路径变量，可以获取路径变量  */
@PostMapping("/request/{rid}")
public String doPostRequest(@PathVariable("rid") Integer requestId, Person person){
    System.out.println(person.getName() + ":" + person.getAge());
    return "{\"message\":\"数据新建成功\",\"id\":" + requestId + "}";
}
```

```JS
$(function () {
    $("#btnPost").click(function () {
        $.ajax({
            url: "/restful/request/100",
            type: "post",
            data: "name=lily&age=23",
            dataType: "json",
            success: function (json) {
                $("#message").text(json.message + ":" + json.id);}} )});})
```

4. **简单请求与非简单请求** 

> 简单请求--是指标准结构的HTTP请求对应GET/POST请求 
>
> 非简单请求--是复杂要求的HTP请求指PUT/ DELETE、扩展标准请求 
>
> ​		-  扩展标准请求：自定了额外的请求头
>
> 两者最大区别是非简单请求发送前需要发送预检请求

​	预检请求

> 预检请求使服务器将不符合要求的请求挡在外面，不会发送实际请求，减轻服务器压力
>
> 非简单请求会先发起一次空body的OPTIONS请求，称为"预检"请求，用于向服务器请求权限信息，等预检请求被成功响应后，才发起真正的http请求。
>
> 浏览器的预检请求结果可以通过设置Access-Control-Max-Age进行缓存

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfpch8igrmj30rq0a9n1g.jpg" alt="6868460B-6907-4588-B63C-41798F405AA2" style="zoom:55%;" align="left"/>

**springMVC中的非简单请求put、delete接收数据，需要添加内容过滤器：**

```java
@DeleteMapping("/request")
//@ResponseBody
public String doDeleteRequest(){
    return "{\"message\":\"数据删除成功\"}";
}
```

```xml
<filter>
    <filter-name>formContentFilter</filter-name>
    <filter-class>org.springframework.web.filter.FormContentFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>formContentFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

5. **对象序列化**

springMVC引入依赖，spring boot默认集成Jackson

> json序列化：由jackson自动完成，也可以对对象进行设置；
>
> xml序列化：由jackson自动完成，也可以对对象进行设置；

```xml
<dependency>
     <groupId>com.fasterxml.jackson.dataformat</groupId>
     <artifactId>jackson-dataformat-xml</artifactId>
     <!--spring boot中不需要version-->
     <version>2.9.8</version> 
</dependency>
```

```java 
@JacksonXmlRootElement(localName = "abc")
public class Person {
    @JacksonXmlProperty
    private String name;
    @JacksonXmlProperty
    private Integer age;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @JacksonXmlProperty
    private Date birthday;
    getter...setter
}
```

```java
@GetMapping(value="/persons", produces="application/xml")//返回xml,既响应头content-type
//@GetMapping("/persons") 
//@GetMapping(value = "/persons", produces = "application/json") 
//这里produces可设置多类型：produces = {APPLICATION_JSON_VALUE, APPLICATION_XML_VALUE})
public List<Person> findPersons(){
    List<Person> list= new ArrayList<Person>();
    Person p1 = new Person();
    p1.setName("lily");
    p1.setAge(23);
    p1.setBirthday(new Date());
    
    Person p2 = new Person();
    p2.setName("smith");
    p2.setAge(22);
    p2.setBirthday(new Date());
    list.add(p1);
    list.add(p2);
    return list;
}
```

6. **浏览器跨域访问**

- 浏览器的同源策略

> 同源策略阻止从一个域加载的脚本去获取另一个域上的资源 
>
> 只要协议、域名、端口有任何一个不同,都被当作是不同的域 
>
> 浏览器 Console会看到 Access- Control- Allow- Origini就代表跨域了

- 同源策略示例

![6CD7693F-ECD2-42F7-8B05-BDC23852323E](https://tva1.sinaimg.cn/large/007S8ZIlly1gfpdn2x7dkj30xi0b9ajz.jpg)

- HTML中允许跨域的标签

> \<img\>-显示远程图片
>
> \<script\>-加载远程JS 
>
> \<link\>-加载远程CSS

- CORS跨域姿源访向

> CORS是一种机制：使用额外的HTTP头通知浏览器可以访问其他域
>
> URL响应头包含 Access- Control-*指明请求允许跨域

- Spring MVC解决跨域访问

> @ Crossorigin- Controller跨域注解 
>
> \<mvc:cors\> - Spring MVC:全局跨域配置
>
> 如果两种同时配置，cotroller以注解的配置为准 (最小范围原则)

```java
@RestController
@RequestMapping("/restful")
//@CrossOrigin(origins = {"http://localhost:8080","http://www.imooc.com"})
//@CrossOrigin(origins = "*",maxAge = 3600)
//设置预检请求的缓存时间为3600秒（1小时）
//在缓存时间内同样的put、delete请求不再进行预检请求处理，降低服务器压力
public class controller {}
```

```xml
<mvc:cors>
    <mvc:mapping path="/restful/**"
                 allowed-origins="http://localhost:8080,http://www.imooc.com"
                 max-age="3600"/>
</mvc:cors>
```