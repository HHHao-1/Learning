# 注解

## 传参

| HTTP协议组成         | 协议内容示例                                     | 对应Spring注解 |
| :------------------- | :----------------------------------------------- | :------------- |
| path info传参        | /articles/12 (查询id为12的文章，12是参数)        | @PathVariable  |
| URL Query String传参 | /articles?id=12                                  | @RequestParam  |
| Body 传参            | Content-Type: multipart/form-data                | @RequestParam  |
| Body 传参            | Content-Type: application/json，或其他自定义格式 | @RequestBody   |
| Headers 传参         |                                                  | @RequestHeader |

@RequestParam写与不写的区别：

```java
// 没传name参数不会报错
test(String name) 
// 没传name参数会报错
test(@RequestParam String name) 
// 1.转换参数名 2.参数化默认值 3.参数是否必须
test(@RequestParam("userName") String name)
test(@RequestParam(value = "Aname", defaultValue = "0", required = false) String name)
```

## 依赖注入

**@Resource和@Autowired**：

1. @Autowired与@Resource都可以用来装配bean. 都可以写在字段上,或写在setter方法上。

2. @Autowired是由Spring提供，@Resource是由J2EE提供。

> 推荐使用@Resource：易用且减少了与spring的耦合

3. @AutoWried按by Type自动注入，@Resource默认按by Name自动注入。

> **@AutoWried注入**：接口的实现类有多个时，可使用@Qualifier("className")注解，指定注入的实现类
>
> ```java
> public class UserServiceImpl implements UserService {
>   @Autowired // 从spring容器中获取返回类型为UserDao的实现类（默认byType获取），注入到该属性中
>   @Qualifier("userDaoTest") // 指定注入bean的名称
>   private UserDao userDao;
> 
>   @Autowired   
>   public void setUserDao(@Qualifier("userDao") UserDao userDao) {   
>     this.userDao = userDao;   
>   }
> 
>   //可能不存在UserDao实例
>   @Autowired(required = false)   
>   public IUserService userService;
> }
> ```
>
> **@Resource注入**：但是@Resource还提供了name和type2个属性，可以自定义自己想要的。
>
> - 若不指定属性，默认按byName匹配注入；若按byName找不到，则继续自动按byType来找
> - 若指定了name属性，则按byName匹配注入，找不到则抛出异常
> - 若指定了type属性，则按byType匹配注入，找不到则抛出异常
> - 若同时指定了name和type，这是没必要的
>
> ```java
> public class UserServiceImpl implements UserService {
>   @Resource
>   //@Resource(name="userDaoTest") // 从spring容器中获取名称为UserDaoTest的实现类匹配
>   //@Resource(type=UserDaoTest.class) 
>   private UserDao userDao;
> 
>   //注入UserDao
>   @resource
>   public void setUserDao(UserDao userDao)
> }
> ```
>
> ```java
> @Resource(name="bucket")
> private String bucketName;
> @Resource(name="style")
> private String styleName;
> 
> <bean name="bucket" class="java.lang.String"> 
>   <constructor-arg value="${oos.bucketName}"/> 
> </bean> 
> <bean name="style" class="java.lang.String"> 
> 	<constructor-arg value="${oos.styleName}" typr="int"/> 
> </bean>
> ```

## @Value

### @Value(“#{}”) 

用SpEl（Spring Expression Language）表达式来获取bean的属性、方法，表示常量

```java
@Value("#{1}")  
private int number; //获取数字 1  

@Value("#{'Spring Expression Language'}") //获取字符串常量  
private String str;  

@Value("#{dataSource.url}") //获取bean的属性  
private String jdbcUrl;  
```

### @Value(“${}”)

从配置文件中读取值

```java
@Value("${init.password}")  
private String initPwd;    
```

## @PostConstruct

> 静态方法*调用Spring容器*bean

```java
@SpringBootApplication
public class NodeLogApplication {

  @Resource private ParseLog parseLog;

  private static NodeLogApplication nodeLogApplication;

  @PostConstruct
  public void init() {
    nodeLogApplication = this;
    nodeLogApplication.parseLog = this.parseLog;
  }

  public static void main(String[] args) {
    SpringApplication.run(NodeLogApplication.class, args);
    try {
      nodeLogApplication.parseLog.parse();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
```

