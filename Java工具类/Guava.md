# 集合

## 集合的创建

```java
// 普通Collection的创建
List<String> list = Lists.newArrayList();
Set<String> set = Sets.newHashSet();
Map<String, String> map = Maps.newHashMap();
 
// 不变Collection的创建
ImmutableList<String> iList = ImmutableList.of("a", "b", "c");
ImmutableSet<String> iSet = ImmutableSet.of("e1", "e2");
ImmutableMap<String, String> iMap = ImmutableMap.of("k1", "v1", "k2", "v2");
```

```java
//创建Map<String,List<Integer>>
//JDK
Map<String,List<Integer>> map = new HashMap<String,List<Integer>>();
List<Integer> list = new ArrayList<Integer>();
list.add(1);
list.add(2);
map.put("aa", list);
System.out.println(map.get("aa"));//[1, 2]
//Guava
Multimap<String,Integer> map = ArrayListMultimap.create();		
map.put("aa", 1);
map.put("aa", 2);
System.out.println(map.get("aa"));  //[1, 2]
```

## 非基本集合类型

```java
//MultiSet: 无序+可重复   count()方法获取单词的次数  增强了可读性+操作简单
Multiset<String> set = HashMultiset.create();
 
//Multimap: key-value  key可以重复  
Multimap<String, String> teachers = ArrayListMultimap.create();
 
//BiMap: 双向Map(Bidirectional Map) 键与值都不能重复
BiMap<String, String> biMap = HashBiMap.create();
 
//Table: 双键的Map rowKey+columnKey+value  
//和sql中的联合主键有点像
Table<String, String, Integer> tables = HashBasedTable.create();
```

## 集合的过滤

- 条件过滤

```java
//按照条件过滤
ImmutableList<String> names = ImmutableList.of("begin", "code", "Guava", "Java");
Iterable<String> fitered = Iterables.filter(names, Predicates.or(Predicates.equalTo("Guava"), Predicates.equalTo("Java")));
System.out.println(fitered); // [Guava, Java]

//自定义过滤条件   使用自定义回调方法对Map的每个Value进行操作
ImmutableMap<String, Integer> m = ImmutableMap.of("begin", 12, "code", 15);
// Function<F, T> F表示apply()方法input的类型，T表示apply()方法返回类型
Map<String, Integer> m2 = Maps.transformValues(m, new Function<Integer, Integer>() {
    public Integer apply(Integer input) {
        if(input>12){
            return input;
        }else{
            return input+1;
        }
    }
});
System.out.println(m2);   //{begin=13, code=15}
```

- set的交集, 并集, 差集

```java
HashSet setA = newHashSet(1, 2, 3, 4, 5);  
HashSet setB = newHashSet(4, 5, 6, 7, 8);  

SetView union = Sets.union(setA, setB);  
System.out.println("union:");  
for (Integer integer : union)  
    System.out.println(integer);           //union:12345867

SetView difference = Sets.difference(setA, setB);  
System.out.println("difference:");  
for (Integer integer : difference)  
    System.out.println(integer);        //difference:123

SetView intersection = Sets.intersection(setA, setB);  
System.out.println("intersection:");  
for (Integer integer : intersection)  
    System.out.println(integer);  //intersection:45
```

- map的交集，并集，差集

```java
MapDifference differenceMap = Maps.difference(mapA, mapB);  
differenceMap.areEqual();  
Map entriesDiffering = differenceMap.entriesDiffering();  
Map entriesOnlyOnLeft = differenceMap.entriesOnlyOnLeft();  
Map entriesOnlyOnRight = differenceMap.entriesOnlyOnRight();  
Map entriesInCommon = differenceMap.entriesInCommon();  
```

# 字符串

## 正则切分

```java
String input = "aa.dd,,ff,,.";
List<String> result = Splitter.onPattern("[.|,]").omitEmptyStrings().splitToList(input);
```

```java
// 判断匹配结果
boolean result = CharMatcher.inRange('a', 'z').or(CharMatcher.inRange('A', 'Z')).matches('K'); //true
// 保留数字文本
String s1 = CharMatcher.digit().retainFrom("abc 123 efg"); //123
// 删除数字文本
String s2 = CharMatcher.digit().removeFrom("abc 123 efg");    //abc  efg
```

## 集合转换字符串

```java
//use java
List<String> list = new ArrayList<String>();
list.add("aa");
list.add("bb");
list.add("cc");
String str = "";
for(int i=0; i<list.size(); i++){
	str = str + "-" +list.get(i);
}
//str 为-aa-bb-cc
 
//use guava
List<String> list = Lists.newArrayList();
list.add("aa");
list.add("bb");
list.add("cc");
String result = Joiner.on("-").join(list);
//result为  aa-bb-cc
```

## map集合转换字符串

```java
Map<String, Integer> map = Maps.newHashMap();
map.put("xiaoming", 12);
map.put("xiaohong",13);
String result = Joiner.on(",").withKeyValueSeparator("=").join(map);
// result为 xiaoming=12,xiaohong=13
```

## String转换集合

```java
//use java
List<String> list = new ArrayList<String>();
String a = "1-2-3-4-5-6";
String[] strs = a.split("-");
for(int i=0; i<strs.length; i++){
	list.add(strs[i]);
}
 
//use guava
String str = "1-2-3-4-5-6";
List<String> list = Splitter.on("-").splitToList(str);
//list为  [1, 2, 3, 4, 5, 6]
```

如果

```java
str="1-2-3-4- 5-  6  ";
```

guava还可以使用 "-" 切分字符串并去除空串与空格

omitEmptyStrings().trimResults() 去除空串与空格

```java
String str = "1-2-3-4-  5-  6   ";  
List<String> list = Splitter.on("-").omitEmptyStrings().trimResults().splitToList(str);
System.out.println(list);
```

## String转换map

```java
String str = "xiaoming=11,xiaohong=23";
Map<String,String> map = Splitter.on(",").withKeyValueSeparator("=").split(str);
```

# 检查参数

```JAVA
//use java
if(list!=null && list.size()>0)
'''
if(str!=null && str.length()>0)
'''
if(str !=null && !str.isEmpty())
 
//use guava
if(!Strings.isNullOrEmpty(str))
 
//use java
if (count <= 0) {                                                                                           
    throw new IllegalArgumentException("must be positive: " + count);         
}    
 
//use guava
Preconditions.checkArgument(count > 0, "must be positive: %s", count);  
```

检查是否为空,不仅仅是字符串类型，其他类型的判断 全部都封装在 Preconditions类里 里面的方法全为静态。

| 方法声明（不包括额外参数）                         | 描述                                                         | 检查失败时抛出的异常      |
| :------------------------------------------------- | :----------------------------------------------------------- | :------------------------ |
| checkArgument(boolean)                             | 检查boolean是否为true，用来检查传递给方法的参数。            | IllegalArgumentException  |
| checkNotNull(T)                                    | 检查value是否为null，该方法直接返回value，因此可以内嵌使用checkNotNull。 | NullPointerException      |
| checkState(boolean)                                | 用来检查对象的某些状态。                                     | IllegalStateException     |
| checkElementIndex(int index, int size)             | 检查index作为索引值对某个列表、字符串或数组是否有效。index>=0 && index<size * | IndexOutOfBoundsException |
| checkPositionIndexes(int start, int end, int size) | 检查[start, end]表示的位置范围对某个列表、字符串或数组是否有效* | IndexOutOfBoundsException |

# MoreObjects

这个方法是在Objects过期后 官方推荐使用的替代品，该类最大的好处就是不用大量的重写toString，用一种很优雅的方式实现重写，或者在某个场景定制使用。

```JAVA
Person person = new Person("aa",11);
String str = MoreObjects.toStringHelper("Person").add("age", person.getAge()).toString();
System.out.println(str);  
//输出Person{age=11}
```

# Ordering排序器

排序器[Ordering]是Guava流畅风格比较器[Comparator]的实现，它可以用来为构建复杂的比较器，以完成集合排序的功能。

```java
natural()	对可排序类型做自然排序，如数字按大小，日期按先后排序
usingToString()	按对象的字符串形式做字典排序[lexicographical ordering]
from(Comparator)	把给定的Comparator转化为排序器
reverse()	获取语义相反的排序器
nullsFirst()	使用当前排序器，但额外把null值排到最前面。
nullsLast()	使用当前排序器，但额外把null值排到最后面。
compound(Comparator)	合成另一个比较器，以处理当前排序器中的相等情况。
lexicographical()	基于处理类型T的排序器，返回该类型的可迭代对象Iterable<T>的排序器。
onResultOf(Function)	对集合中元素调用Function，再按返回值用当前排序器排序。
```

```java
Person person = new Person("aa",14);  //String name  ,Integer age
Person ps = new Person("bb",13);
Ordering<Person> byOrdering = Ordering.natural().nullsFirst().onResultOf(new Function<Person,String>(){
	public String apply(Person person){
		return person.age.toString();
	}
});
byOrdering.compare(person, ps);
System.out.println(byOrdering.compare(person, ps)); //1      person的年龄比ps大 所以输出1
```

# 中间代码运行时间

```java
Stopwatch stopwatch = Stopwatch.createStarted();
for(int i=0; i<100000; i++){
	
}
long nanos = stopwatch.elapsed(TimeUnit.MILLISECONDS);
System.out.println(nanos);
```

TimeUnit 可以指定时间输出精确到多少时间

# 文件操作

以前我们写文件读取的时候要定义缓冲区，各种条件判断

```java
File file = new File("/test.txt");
List<String> list = null;
try {
	list = Files.readLines(file, Charsets.UTF_8);
} catch (Exception e) {
}

Files.copy(from,to);  //复制文件
Files.deleteDirectoryContents(File directory); //删除文件夹下的内容(包括文件与子文件夹)  
Files.deleteRecursively(File file); //删除文件或者文件夹  
Files.move(File from, File to); //移动文件
URL url = Resources.getResource("abc.xml"); //获取classpath根下的abc.xml文件url
```

Files类中还有许多方法可以用，可以多多翻阅。

# guava缓存

guava的缓存设计的比较巧妙，可以很精巧的使用。guava缓存创建分为两种，一种是CacheLoader,另一种则是callback方式

- CacheLoader:

```java
LoadingCache<String,String> cahceBuilder=CacheBuilder
    .newBuilder()
    .build(new CacheLoader<String, String>(){
        @Override
        public String load(String key) throws Exception {        
            String strProValue="hello "+key+"!";                
            return strProValue;
        }
    });        
System.out.println(cahceBuilder.get("begincode")); //hello begincode!
System.out.println(cahceBuilder.get("wen")); //hello wen!
cahceBuilder.put("begin", "code");
System.out.println(cahceBuilder.get("begin")); //code
```

- callback方式:

```java
Cache<String, String> cache = CacheBuilder.newBuilder().maximumSize(1000).build();  
String resultVal = cache.get("code", new Callable<String>() {  
    public String call() {  
        String strProValue="begin "+"code"+"!";                
        return strProValue;
    }  
});  
System.out.println("value : " + resultVal); //value : begin code!
```
