# Enum特征

- 不能有public的构造函数，保证单例安全，不能new

  可以有其他构造函数，有参构造函数枚举变量要加参数

> 解决单例模式可通过反射获取实例问题，enum是jvm帮助我们保证单例实现

- 默认是final的，不能被继承、实现

- 所有枚举值都是`public  static  final`的

  必须放在第一行、必须有注释、一般都大写

> 这一点只是针对于枚举值
>
> 除特定语法外，其他变量、方法的声明使用和普通类一样

- 类名.枚举变量 — 创建枚举类型实例

# Enum类方法

> 枚举类型默认实现Enum类，不能显式继承，可以实现接口

- compareTo

  Enum实现了java.lang.Comparable接口。

- toString

  Enum覆载了了toString方法，因此我们如果调用Color.Blue.toString()默认返回字符串"Blue"

- valueOf

  Enum提供了一个valueOf方法，这个方法和toString方法是相对应的。调用valueOf("Blue")将返回 Color.Blue

- values

  Enum还提供了values方法，这个方法使你能够方便的遍历所有的枚举值

- oridinal

  Enum还有一个oridinal的方法，这个方法返回枚举值在枚举类中的顺序，这个顺序根据枚举值声明的顺序而定。

- *构造方法不能由程序员调用，它由编译器根据枚举类型声明发出的代码使用*

# 示例

## 创建

```java
public enum EnumTest {
    //这里要有注释
    ONE,TWO;
}
```

```java
public enum EnumTest {
    //这里要有注释
    ONE("1"), TWO("2");

    private EnumTest(String s) {
        say = s;
    }

    public String say = "欢迎";

    private String hi = "欢迎";

    public String getSay() {
        return hi;
    }
}
```

```java
public enum EnumTest {
    //这里要有注释
    ONE("1"){
        @Override
        public String getSay() {
            return this.say;
        }
    }, TWO("2") {
        @Override
        public String getSay() {
            return this.hi;//拿不到，私有的
        }
    };

    private EnumTest(String s) {
        say = s;
    }

    public String say = "欢迎";

    private String hi = "欢迎";

    public abstract String getSay();
}
```

## 使用

```java
public static void main(String[] args){
  
  EnumTest enumTest1 = EnumTest.ONE;//获取EnumTest实例ONE
  
  EnumTest enumTest2 = EnumTest.valueOf("ONE");//获取EnumTest实例ONE
  
  List enumTest3 = Arrays.stream(EnumTest.values())
    .limit(2).collect(Collectors.toList());
  System.out.println(enumTest3);//[ONE, TWO]
  
  Arrays.stream(EnumTest.values()).forEach(System.out::println);//ONE TWO
  
  System.out.println( EnumTest.TWO.compareTo(EnumTest.ONE) );//1,比较实例的序号
  
  System.out.println( EnumTest.ONE.name() );//ONE
  
  System.out.println(EnumTest.ONE.ordinal());//0；获取索引，从0开始
  
  System.out.println(EnumTest.ONE.getDeclaringClass());//class EnumTest
  
  System.out.println(EnumTest.ONE.getDeclaringClass());//class EnumTest
  
  System.out.println(EnumTest.class);//class EnumTest
  
  Enum one =  Enum.valueOf(EnumTest.class,"ONE");//ONE
}
```

```JAVA
//swtch条件语句
public static void choice(EnumTest e) iv
switch(e) {
case ONE: System.out.println("one");
break;
case TWo: System.out.println("two");
break;
default : System.out.println("no");
```

