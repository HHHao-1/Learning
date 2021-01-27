# JSON

## 简介

JSON(JavaScript Object Notation：JavaScript对象表示法)一种轻量级的数据交换格式，具有良好的可读和便于快速编写的特性。可在不同平台之间进行数据交换。JSON采用兼容性很高的、完全独立于语言的一种文本格式，并且可读性很高。这些特性使JSON成为理想的数据交换语言。**存储、传输数据**

### JSON与JS对象的区别

```js
//js对象的字面量表示法： 
var people1={ 
    name:'hehe', 
    age:18 
}; 
//json的格式是： 
var people1={ 
    "name":'hehe', 
    "age":18 
}; 

相同点：看起来都是数据，而且恰巧又都是文本。
不同点：JS字面量的文本是被脚本引擎直接解析的，而JSON的文本要转化为JS对象。

JSON.parse定义对象要比对象自变量定义快。
const data = { foo: 42, bar: 1337 }; //   这是蜗牛速度
const data = JSON.parse('{"foo":42,"bar":1337}'); //   这是飞机速度
```

| **区别** | **JSON**                                                     | **Javascript**                                               |
| -------- | :----------------------------------------------------------- | ------------------------------------------------------------ |
| 含义     | 仅仅是一种数据格式                                           | 表示类的实例                                                 |
| 传输     | 可以跨平台数据传输，速度快                                   | 不能传输                                                     |
| 表现     | 1.简直对方式，键必须加双引号<br />2.值不能是方法函数，不能是undefined/NaN | 1.键值对方式，键不加引号<br />2.值可以是函数、对象、字符串、数字、boolean 等 |
| 相互转换 | 1.JSON.parse(JsonStr);(不兼容IE7)<br />2.eval("("+jsonStr+")");(兼容所有浏览器，但不安全，会执行json里面的表达式) | js对象转换JsonJSON.stringify(jsObj);                         |
| 其他    | 调用JSON官网的JS,实现parse和stringify在各个浏览器的兼容：   ||

## 应用

### 语法

键/值都需双引号引起来

双引号才是json 的标准，单引号是不规范的（虽然在js 中是行的通的）

对于*数字*,布尔值都是不需要双*引号*的

**一个json对象**

```json
{
  "students": [
    { "firstName": "san", "lastName": "zhang" },
    { "firstName": "si", "lastName": "li" },
  ]
}
```

**多个json对象**

```json
[
  {"students_1class": { "firstName": "san", "lastName": "zhang" }},
  {"students_2class": { "firstName": "si", "lastName": "li" }}
]

注意：key--value都要用双引号
```

**json对象与字符串互相转换**

JSON.parse( )方法将字符串转换为JSON对象

JSON.stringifyo)方法将JSON对象转换为字符串

```js
var str = '{"name":"小李"}';
var json = JSON.parse(str);
var json1 = { "name": "小王" };
var str1 = JSON.stringify(json1);
var json2 = {};
json2.name = "小周"
```

# XML

##  简介

扩展标记语言 (Extensible Markup Language, XML) ，用于标记电子文件使其具有结构性的标记语言，可以用来标记数据、定义数据类型，是一种允许用户对自己的标记语言进行定义的源语言。 编写XML就是编写标签,与HTML非常类似，具有良好的人机可读性。**存储、传输数据**

## 语法

1. 第一行必须是XML声明

```css
XML声明说明XML文档的基本信息,包括版本号与字符集。
<?xml version="1.0" encoding="UTF-8"?>
```

2. 只有一个根节点，各个节点可增添属性

```xml
<shop-cart>
	<item sn="771938" category="电器">
		<name>XX空调</name>
		<price> 2000.00</price>
		<num>1</num>
	</item>
	<item sn="890321" category="食品"><name>法式面包</name>
		<price>10.00</price>
		<num>5</num>
	</item>
</shop-cart>
```

3. 有序的子元素

   在XML多层嵌套的子元素中,标签前后顺序应保持一致。

```xml
<shop-cart>
	<item sn="771938" category="电器"><name>XX空调</name>
		<price> 2000.00</price>
		<num>1</num>
	</item>
	<item sn="890321" category="食品"><name>法式面包</name>
		<price> 10.00</price>
		<num>5</num>
	</item>
</shop-cart>
```

4. 处理特殊字符

标签体中,出现"<"、">"特殊字符,会破坏文档结构

```xml
无效的XML :
<exam>
    <question>1+4<3是否正确? </question>
    <question>3+5>8是否正确? </question>
</exam>
```

解决方案1:使用实体引用

| \&lt;   | <    | 小于   |
| ------- | ---- | ------ |
| \&gt;   | >    | 大于   |
| \&amp;  | &    | 和号   |
| \&apos; | '    | 省略号 |
| \&quot; | "    | 引号   |

解决方案2 :使用CDATA标签

CDATA指的是不应由XML解析器进行解析的文本数据，从"<![CDATA[忽略检查的文本]]> "结束

```xml
在CDATA中将文本的内容写入，那么这段文本内容会被忽略检查，无论里面是否包含XML敏感内容，全部被当作普通的文本去看待。例如：
<content>
    <![ CDATA [
        <script language="javascript">
            function sayhello(){ alert("hello!"); }
        </script>
    ] ] >  
</content>
```

5. XML语义约束

XML文档结构正确，但可能不是有效的。例如,员工档案XML中绝不允许出现"植物品种"标签。XML语义约束就是用于规定XML文档中允许出现哪些元素。

**XML语义约束有两种定义方式:DTD与XML Schema**

① DTD(Document Type Definition ,文档类型定义)是一种简单易用的语义约束方式，扩展名为.dtd。

```dtd
<!--DTD中的<!ELEMENT>标签,可以定义XML文档中允许出现的节点及数量-->
定义hr节点下只允许出现1个employee子节点
<!ELEMENT hr (employee)>
employee节点下必须包含以下四个节点,且按顺序出现。
<!ELEMENT employee (name,age,salary,department)>
定义name标签体只能是文本, #PCDATA代表文本元素。
<!ELEMENT name (#PCDATA)>

<!--DTD定义节点数量-->
<!--如某个子节点需要多次重复出现,则需要在子节点后增加相应的描述符-->
hr节点下最少出现1个employee子节点。
<!ELEMENT hr (employee+)>
hr节点下可出现0..n个employee子节点。
<!ELEMENT hr (employee*)>
hr节点下最多出现1个emplovee子节点。
<!ELEMENT hr (employee?)>

<!--XML引用DTD文件-->
在XML中使用<!DOCTYPE>标签来引用DTD文件
<!DOCTYPE 根节点 SYSTEM "dtd文件路径">
如：<!DOCTYPE hr SYSTEM "hr.dtd">
```

② XML Schema比DTD更为复杂,提供了更多功能

提供了数据类型、格式限定、数据范围等特性；是W3C标准；扩展名.xsd

```xml
<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://www.w3.org/2001/XMLSchema">
	<element name="hr">
		<!-- complexType标签含义是复杂节点，包含子节点时必须使用这个标签 -->
		<complexType>
			<!--sequence序列，子节点必须按顺序前后严格书写-->
			<sequence>
				<!--minOccurs节点最少出现次数，maxOccurs节点最多出现次数-->
				<element name="employee" minOccurs="1" maxOccurs="9999">
					<complexType>
						<sequence>
							<element name="name" type="string"></element>
							<element name="age">
								<!--节点类型详细限制-->
								<simpleType>
									<restriction base="integer">
										<minInclusive value="18"></minInclusive>
										<maxInclusive value="60"></maxInclusive>
									</restriction>
								</simpleType>
							</element>
							<element name="salary" type="integer"></element>
							<element name="department">
								<complexType>
									<sequence>
										<element name="dname" type="string"></element>
										<element name="address" type="string"></element>
									</sequence>
								</complexType>
							</element>
						</sequence>
						<!--attribute定义属性，required表示在任意此节点下这个属性必须存在-->
						<attribute name="no" type="string" use="required"></attribute>	
					</complexType>
				</element>
			</sequence>
		</complexType>
	</element>	
</schema>


<!--xml引用xsd文件-->
<hr xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="hr.xsd">
    
xmlns:xsi ---是指xml文件遵守xml规范，xsi全名：xml schema instance
xsi:schemaLocation——是指具du体用到的schema资源。
xmlns:xsi 定义了一个命名空间前缀"http://www.w3.org/2001/XMLSchema-instance"。这个 xmlns:xsi 已经成为了一个业界默认的用于 XSD(（XML Schema Definition) 文件的命名空间。 
```

6. DOM文档对象模型

<img src="https://tva1.sinaimg.cn/large/007S8ZIlly1gfffquniqvj30ye0e6wiq.jpg" alt="image-20200603214551959"  />

## XML解析

**Dom4j简介**

Dom4j是一个易用的、开源的库，用于解析XML；

Dom4j将XML视为Document对象；

XML标签被Dom4j定义为Element对象；

**Dom4j遍历xml**

```java
public void readXml(){
    String file = "d:/workspace/xml/src/hr.xml";
    //SAXReader类是读取XML文件的核心类,用于将XML解析后以“树”的形式保存在内存中
    SAXReader reader = new SAXReader();
    try {
        Document document = reader.read(file);
        //获取XML文档的根节点,即hr标签
        Element root = document.getRootElement();
        //elements方法用于获取指定的标签集合
        List<Element> employees =  root.elements("employee");
        for(Element employee : employees){
            //element方法用于获取唯一的子节点对象
            Element name = employee.element("name");
            String empName = name.getText();//getText()方法用于获取标签文本
            System.out.println(empName);
            System.out.println(employee.elementText("age"));
            Element department = employee.element("department");
            System.out.println(department.element("dname").getText());
            Attribute att = employee.attribute("no");
            System.out.println(att.getText());
        }
    } 
}
```

**Dom4j更新xml**

```java
public void writeXml(){
		String file = "d:/workspace/xml/src/hr.xml";
		SAXReader reader = new SAXReader();
		try {
			Document document = reader.read(file);
			Element root = document.getRootElement();
			Element employee = root.addElement("employee");
			employee.addAttribute("no", "3311");
			Element name = employee.addElement("name");
			name.setText("李铁柱");
			employee.addElement("age").setText("37");
			employee.addElement("salary").setText("3600");
			Element department = employee.addElement("department");
			department.addElement("dname").setText("人事部");
			department.addElement("address").setText("XX大厦-B105");
            //将在内存中对xml的更新写入到xml文件
			Writer writer = new OutputStreamWriter(new FileOutputStream(file) , "UTF-8");
			document.write(writer);
			writer.close();
		} 
	}
```

## XPath

XPath路径表达式是XML文档中查找数据的语言

**最常用的基本表达式**

| 表达式   | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| nodename | 选取此节点的所有子节点。                                     |
| /        | 从根节点选取。                                               |
| //       | 从匹配选择的当前节点选择文档中的节点,<br />而不考虑它们的位置。 |
| .        | 选取当前节点。                                               |
| ..       | 选取当前节点的父节点。                                       |
| @        | 选取属性。                                                   |

示例

| 路径表达式      | 结果                                                         |
| --------------- | ------------------------------------------------------------ |
| bookstore       | 选取bookstore元素的所有子节点。                              |
| /bookstore      | 选取根元素bookstore.<br/>注释:假如路径起始于正斜杠(/),则此路径始终代表到某元素的绝对路径! |
| bookstore/book  | 选取属于bookstore的子元素的所有book元素。                    |
| //book          | 选取所有book子元素,而不管它们在文档中的位置。                |
| bookstore//book | 选择属于bookstore元素的后代的所有book元素,而不管它们位于bookstore之下的什么位置。 |
| //@lang         | 选取名为lang的所有属性。                                     |

**XPath谓语表达式**

| 路径表达式                         | 结果                                                         |
| ---------------------------------- | ------------------------------------------------------------ |
| /bookstore/book[1]                 | 选取属于bookstore子元素的第一个book元素。                    |
| /bookstore/book[last()]            | 选取属于bookstore子元素的最后一个book元素。                  |
| /bookstore/book[last()-1]          | 选取属于bookstore子元素的倒数第二个book元素。                |
| /bookstore/books[position()<3]     | 选取最前面的两个属于bookstore元素的子元素的book元素          |
| //title[@lang]                     | 选取所有拥有名为lang的属性的title元素。                      |
| //title[@lang='eng']               | 选取所有title元素,且这些元素拥有值为eng的lang属性。          |
| /bookstore/book[price>35.00]       | 选取bookstore元素的所有book元素,且其中的price元素的值须大于35.00 |
| /bookstore/book[price>35.00]/title | 选取bookstore元素中的book元素的所有title元素,且其中的price元素的值须大于35.00 |

**XPath应用**

```java
public class XPathTestor {
   public void xpath(String xpathExp){
      String file = "E:/lianxi/xml/hr.xml";
      SAXReader reader = new SAXReader();
      try {
         Document document = reader.read(file);
         //Node是Element和Attribute的父类，在需要出进行类型转换
         List<Node> nodes = document.selectNodes(xpathExp);
         for(Node node : nodes){
            Element emp = (Element)node;
            System.out.println(emp.attributeValue("no"));
            System.out.println(emp.elementText("salary"));
         }      
      } catch (DocumentException e) {
         e.printStackTrace();
      }
   }   
   public static void main(String[] args) {
      XPathTestor testor = new XPathTestor();
//    testor.xpath("/hr/employee");
//    testor.xpath("//employee[salary<4000]");
//    testor.xpath("//employee[@no=3304]");
      testor.xpath("//employee[3] | //employee[8]");     
   }
}
```

# 工具

## Jackson

### 依赖

```xml
<dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId> -->数据绑定依赖于下面两个包
        <version>2.8.7</version>
</dependency>
<dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-annotations</artifactId> -->注解包
        <version>2.8.0</version>
</dependency>
<dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-core</artifactId> -->核心包
        <version>2.8.7</version>
</dependency>

<!--返回xml数据还需导入此依赖-->
<dependency>
 <groupId>com.fasterxml.jackson.dataformat</groupId>
     <artifactId>jackson-dataformat-xml</artifactId>
     <!--spring boot中不需要version-->
     <version>2.9.8</version> 
</dependency>
```

### 应用

**返回客户端**

> @*GetMapping*(value *=* "/xml", produces *=* "application/json")
>
> *@GetMapping(value = "/xml", produces = "application/xml")*

**JAVA对象转JSON/XML**

> ```
> objectMapping.writeValueAsString(obj)
> ```

**XML/JSON转JAVA对象**

> ```
> objectMapping.readValue(str, ojb.class)
> ```

**说明**

> 1. json字符串中的key应该与java对象的属性名相同
>
> 2. java对象中属性如果为private，则需要显示生成getter/setter方法；如果属性为public，则可以不必写getter/setter方法
>
> 3.  java对象如果有自定义的构造方法，json字符串转换为java对象时会出错
>
> 4. 如果json字符串中的属性个数小于java对象中的属性个数，可以顺利转换，java中多的那个属性为null
>
> 5. 如果json字符串中出现java对象中没有的属性，则在将json转换为java对象时会报错：Unrecognized field, not marked as ignorable，解决方法：
>
>    > 在目标对象的类级别上添加注解：`@JsonIgnoreProperties(ignoreUnknown = true)`；
>
> 6. java对象名和json中名不一致时解决方法：
>
>    > 在目标对象的字段级别上添加注解：`@JsonProperty(value = "name")`

**json示例**

```java
User user = new User(); 
user.setName("小民");  
....
ObjectMapper mapper = new ObjectMapper(); 
//User对象转JSON字符串 
//输出结果：{"name":"小民","age":20,"birusery":844099200000,"email":"xiaomin@sina.com"} 
String json = mapper.writeValueAsString(user); 
System.out.println(json); 

//User对象集合转JSON字符串 
//输出结果：[{"name":"小民","age":20,"birthday":844099200000,"email":"xiaomin@sina.com"}] 
List<User> users = new ArrayList<User>(); 
users.add(user); 
String jsonlist = mapper.writeValueAsString(users); 
System.out.println(jsonlist); 

//JSON字符串转User对象 
User user1 = mapper.readValue(json，User.class); 
System.out.println(user.toString); 
```

**xml示例**

```java
//在对实体类定义节点时JSON注解也可以用，xml注解用来控制生成的xml效果
@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonRootName("Person")
public class Person {
    @JsonProperty("Name")
    private String name;
    @JsonProperty("NickName")
    //@JacksonXmlText
    private String nickname;
    @JsonProperty("Age")
    private int age;
    @JsonProperty("IdentityCode")
    @JacksonXmlCData
    private String identityCode;
    @JsonProperty("Birthday")
    //@JacksonXmlProperty(isAttribute = true)
    @JsonFormat(pattern = "yyyy/MM/DD")
    private LocalDate birthday;

}
```

```java
Person p1 = new Person("yitian", "易天", 25, "10000", LocalDate.of(1994, 1, 1));
XmlMapper mapper = new XmlMapper();
mapper.findAndRegisterModules();
mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
mapper.enable(SerializationFeature.INDENT_OUTPUT);
String text = mapper.writeValueAsString(p1);
System.out.println(text);

Person p2 = mapper.readValue(text, Person.class);
System.out.println(p2);
```

```xml
运行结果：

<Person>
  <Name>yitian</Name>
  <NickName>易天</NickName>
  <Age>25</Age>
  <IdentityCode><![CDATA[10000]]></IdentityCode>
  <Birthday>1994/01/01</Birthday>
</Person>
Person(name=yitian, nickname=易天, age=25, identityCode=10000, birthday=1994-01-01)

取消那两行注释，运行结果：

<Person birthday="1994/01/01">
  <Name>yitian</Name>易天
  <Age>25</Age>
  <IdentityCode><![CDATA[10000]]></IdentityCode>
</Person>
Person(name=yitian, nickname=null, age=25, identityCode=10000, birthday=1994-01-01)
```

### 注解

#### JSON

> - 属性命名
>
> @JsonProperty注解指定一个属性用于JSON映射，默认情况下映射的JSON属性与注解的属性名称相同，不过可以使用该注解的value值修改JSON属性名，该注解还有一个index属性指定生成JSON属性的顺序，如果有必要的话。
>
> - 属性包含
>
> @JsonIgnore注解用于排除某个属性，这样该属性就不会被Jackson序列化和反序列化。
>
> @JsonIgnoreProperties注解是类注解。在序列化为JSON的时候，
>
> @JsonIgnoreProperties({"prop1", "prop2"})会忽略pro1和pro2两个属性。在从JSON反序列化为Java类的时候，@JsonIgnoreProperties(ignoreUnknown=true)会忽略所有没有Getter和Setter的属性。该注解在Java类和JSON不完全匹配的时候很有用。
>
> @JsonIgnoreType也是类注解，会排除所有指定类型的属性。
>
> - 序列化相关
>
> @JsonPropertyOrder和@JsonProperty的index属性类似，指定属性序列化时的顺序。
>
> @JsonRootName注解用于指定JSON根属性的名称。
>
> - 日期格式化
>
>  @JsonFormat(pattern = "yyyy-MM-DD") 后台Date传到前台展示时转换为String
>
> @DateTimeFormat(pattern = "yyyy-MM-dd") 前台传来字符串格式日期转换为Date格式

#### XML

> @JacksonXmlProperty注解有三个属性，namespace和localname属性用于指定XML命名空间的名称，isAttribute指定该属性作为XML的属性（）还是作为子标签（）.
>
> @JacksonXmlRootElement注解有两个属性，namespace和localname属性用于指定XML根元素命名空间的名称。
>
> @JacksonXmlText注解将属性直接作为未被标签包裹的普通文本表现。
>
> @JacksonXmlCData将属性包裹在CDATA标签中。

### 配置

```java
// 美化输出
mapper.enable(SerializationFeature.INDENT_OUTPUT);
// 允许序列化空的POJO类
// （否则会抛出异常）
mapper.disable(SerializationFeature.FAIL_ON_EMPTY_BEANS);
// 把java.util.Date, Calendar输出为数字（时间戳）
mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

// 在遇到未知属性的时候不抛出异常
mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
// 强制JSON 空字符串("")转换为null对象值:
mapper.enable(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);

// 在JSON中允许C/C++ 样式的注释(非标准，默认禁用)
mapper.configure(JsonParser.Feature.ALLOW_COMMENTS, true);
// 允许没有引号的字段名（非标准）
mapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
// 允许单引号（非标准）
mapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
// 强制转义非ASCII字符
mapper.configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
// 将内容包裹为一个JSON属性，属性名由@JsonRootName注解指定
mapper.configure(SerializationFeature.WRAP_ROOT_VALUE, true);
```

## FastJson

**json与java交互**：序列化与反序列化

```java
//@JSONField(format="yyyy-MM-dd HH:mm:ss SSS")
@JSONField(name = "hiredate" , format="yyyy-MM-dd")
private Date hdate;
@JSONField(serialize = false)
private String dname;

//java对象序列化为json字符串
//序列化自动忽略为null的对象属性
String json = JSON.toJSONString(employee);
//json字符串序列化为java对象
//反序列化不忽略json字符串中的null值
Employee emp = JSON.parseObject(json, Employee.class);

//java数组对象的序列化与反序列化
List emplist = new ArrayList();
for (int i = 1 ; i <= 100 ; i++) {
	Employee employee = new Employee();
	employee.setEmpno(4488 + i);
	emplist.add(employee);
}
String json = JSON.toJSONString(emplist);
List<Employee> emps = JSON.parseArray(json , Employee.class);
```

