# 概念

![ECC84071-FF09-43E3-B61A-31419A897C0E](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjeuw6moukj30vf0gsjwr.jpg)

![4B412703-903C-463C-A0AA-65813432F535](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjeuw5cucbj30ta0guwjc.jpg)

# File类

- 简介

> 什么是文件?
>
> 文件可认为是放在一起的数据的集合
>
> 绝对路径：是从盘符开始的路径
>
> 相对路径：是从当前目录开始的路径
>

- 作用

> 创建文件、目录
>
> 删除文件、目录
>
> 查看文件、目录路径信息、文件描述信息、权限信息
>
> 判断文件权限、信息
>
> 设置权限、最后一次修改时间
>
> 类型转换：toPath()、toString() 、toURI、toURL(）

- 构造方法

| 构造方法                          |
| --------------------------------- |
| File(File parent, String child)   |
| File(String pathname)             |
| File(String parent, String child) |
| File(URI uri)                     |

```java
File file1=new File("src/com/a.txt");
File file1=new File("src/com","a.txt");
File file=new File("src/com");
File file1=new File(file,"a.txt");
File file = new File("src");
File file2 = new File(file.toURI());
System.out.println(file2.toURI());// file:/Users/hao/Desktop/测试/untitled/src/
```

# Path

> Path接口，以Paths类和Files工具类为核心，替代File类，**用于来表示文件路径和文件**。

- 获取Path对象

```java
1）Paths：
Path path = Paths.get("C:/", "Xmp");
Path path2 = Paths.get("C:/Xmp");

URI u = URI.create("file:///C:/Xmp/dd");        
Path p = Paths.get(u);

2）FileSystems构造：
Path path3 = FileSystems.getDefault().getPath("C:/", "access.log");

3）File和Path之间的转换：
File file = new File("C:/my.ini");
Path p1 = file.toPath();
p1.toFile();
file.toURI();
```

# Paths

- 此类仅由静态方法组成，通过转换路径字符串返回`Path`或`URI`。

| 类型和参数    | 方法和描述                                                   |
| :------------ | :----------------------------------------------------------- |
| `static Path` | `get(String first, String... more)`<br />将路径字符串或连接到路径字符串的字符串序列转换为 `Path` 。 |
| `static Path` | `get(URI uri)`<br />将给定的URI转换为`Path`对象。            |

# Files

该类只包含对文件，目录或其他类型文件进行操作的静态方法。

在大多数情况下，这里定义的方法将委托给相关的文件系统提供程序来执行文件操作。

| 返回类型                        | 方法和描述                                                   | 分类 |
| ------------------------------- | ------------------------------------------------------------ | ---- |
| long                            | copy(InputStream in, Path target, CopyOption... options)     | 复制 |
|                                 | 将输入流中的所有字节复制到文件。                             |      |
| long                            | copy(Path source, OutputStream out)                          |      |
|                                 | 将文件中的所有字节复制到输出流。                             |      |
| Path                            | copy(Path source, Path target, CopyOption... options)        |      |
|                                 | 将文件复制到目标文件。                                       |      |
| Path                            | createDirectories(Path dir, FileAttribute<?>... attrs)       | 创建 |
|                                 | 首先创建所有不存在的父目录来创建目录。                       |      |
| Path                            | createDirectory(Path dir, FileAttribute<?>... attrs)         |      |
|                                 | 创建一个新的目录。                                           |      |
| Path                            | createFile(Path path, FileAttribute<?>... attrs)             |      |
|                                 | 创建一个新的和空的文件，如果该文件已存在失败。               |      |
| Path                            | createLink(Path link, Path existing)                         |      |
|                                 | 为现有文件创建新的链接（目录条目） （可选操作） 。           |      |
| Path                            | createSymbolicLink(Path link, Path target, FileAttribute<?>... attrs) |      |
|                                 | 创建到目标的符号链接 （可选操作） 。                         |      |
| Path                            | createTempDirectory(Path dir, String prefix, FileAttribute<?>... attrs) |      |
|                                 | 在指定的目录中创建一个新目录，使用给定的前缀生成其名称。     |      |
| Path                            | createTempDirectory(String prefix, FileAttribute<?>... attrs) |      |
|                                 | 在默认临时文件目录中创建一个新目录，使用给定的前缀生成其名称。 |      |
| Path                            | createTempFile(Path dir, String prefix, String suffix, FileAttribute<?>... attrs) |      |
|                                 | 在指定的目录中创建一个新的空文件，使用给定的前缀和后缀字符串生成其名称。 |      |
| Path                            | createTempFile(String prefix, String suffix, FileAttribute<?>... attrs) |      |
|                                 | 在默认临时文件目录中创建一个空文件，使用给定的前缀和后缀生成其名称。 |      |
| void                            | delete(Path path)                                            | 删除 |
|                                 | 删除文件。                                                   |      |
| boolean                         | deleteIfExists(Path path)                                    |      |
|                                 | 删除文件（如果存在）。                                       |      |
| Stream\<Path>                   | find(Path start, int maxDepth, BiPredicate<Path,BasicFileAttributes> matcher, FileVisitOption... options) | 查找 |
|                                 | 返回一个 Stream ，它通过搜索基于给定起始文件的文件树中的文件来懒惰地填充 Path 。 |      |
| Object                          | getAttribute(Path path, String attribute, LinkOption... options) |      |
|                                 | 读取文件属性的值。                                           |      |
| V                               | getFileAttributeView(Path path, 类<V> type, LinkOption... options) |      |
|                                 | 返回给定类型的文件属性视图。                                 |      |
| FileStore                       | getFileStore(Path path)                                      |      |
|                                 | 返回表示文件所在文件存储区的 FileStore。                     |      |
| FileTime                        | getLastModifiedTime(Path path, LinkOption... options)        |      |
|                                 | 返回文件的上次修改时间。                                     |      |
| UserPrincipal                   | getOwner(Path path, LinkOption... options)                   |      |
|                                 | 返回文件的所有者。                                           |      |
| Set<br />\<PosixFilePermission> | getPosixFilePermissions(Path path, LinkOption... options)    |      |
|                                 | 返回文件的POSIX文件权限。                                    |      |
| boolean                         | exists(Path path, LinkOption... options)                     | 测试 |
|                                 | 测试文件是否存在。                                           |      |
| boolean                         | isDirectory(Path path, LinkOption... options)                |      |
|                                 | 测试文件是否是目录。                                         |      |
| boolean                         | isExecutable(Path path)                                      |      |
|                                 | 测试文件是否可执行。                                         |      |
| boolean                         | isHidden(Path path)                                          |      |
|                                 | 测试文件是否被隐藏 。                                        |      |
| boolean                         | isReadable(Path path)                                        |      |
|                                 | 测试文件是否可读。                                           |      |
| boolean                         | isRegularFile(Path path, LinkOption... options)              |      |
|                                 | 测试文件是否是具有不透明内容的常规文件。                     |      |
| boolean                         | isSameFile(Path path, Path path2)                            |      |
|                                 | 测试两个路径是否找到相同的文件。                             |      |
| boolean                         | isSymbolicLink(Path path)                                    |      |
|                                 | 测试文件是否是符号链接。                                     |      |
| boolean                         | isWritable(Path path)                                        |      |
|                                 | 测试文件是否可写。                                           |      |
| Stream\<String>                 | lines(Path path)                                             | 操作 |
|                                 | 从 Stream读取文件中的所有行。                                |      |
| Stream\<String>                 | lines(Path path, Charset cs)                                 |      |
|                                 | 从文件中读取所有行作为 Stream 。                             |      |
| Stream\<Path>                   | list(Path dir)                                               |      |
|                                 | 返回一个懒惰的填充 Stream ，其元素是 Stream中的条目。        |      |
| Path                            | move(Path source, Path target, CopyOption... options)        |      |
|                                 | 将文件移动或重命名为目标文件。                               |      |
| BufferedReader                  | newBufferedReader(Path path)                                 |      |
|                                 | 打开一个文件进行阅读，返回一个 BufferedReader以高效的方式从文件读取文本。 |      |
| BufferedReader                  | newBufferedReader(Path path, Charset cs)                     |      |
|                                 | 打开一个文件进行阅读，返回一个 BufferedReader ，可以用来以有效的方式从文件读取文本。 |      |
| BufferedWriter                  | newBufferedWriter(Path path, Charset cs, OpenOption... options) |      |
|                                 | 打开或创建一个写入文件，返回一个 BufferedWriter ，可以用来以有效的方式将文本写入文件。 |      |
| BufferedWriter                  | newBufferedWriter(Path path, OpenOption... options)          |      |
|                                 | 打开或创建一个写入文件，返回一个 BufferedWriter以高效的方式写入文件。 |      |
| SeekableByteChannel             | newByteChannel(Path path, OpenOption... options)             |      |
|                                 | 打开或创建文件，返回可访问的字节通道以访问该文件。           |      |
| SeekableByteChannel             | newByteChannel(Path path, Set<? extends OpenOption> options, FileAttribute<?>... attrs) |      |
|                                 | 打开或创建文件，返回可访问的字节通道以访问该文件。           |      |
| DirectoryStream \<Path>         | newDirectoryStream(Path dir)                                 |      |
|                                 | 打开一个目录，返回一个DirectoryStream以遍历目录中的所有条目。 |      |
| DirectoryStream \<Path>         | newDirectoryStream(Path dir, DirectoryStream.Filter<? super Path> filter) |      |
|                                 | 打开一个目录，返回一个DirectoryStream来迭代目录中的条目。    |      |
| DirectoryStream \<Path>         | newDirectoryStream(Path dir, String glob)                    |      |
|                                 | 打开一个目录，返回一个DirectoryStream来迭代目录中的条目。    |      |
| InputStream                     | newInputStream(Path path, OpenOption... options)             |      |
|                                 | 打开一个文件，返回输入流以从文件中读取。                     |      |
| OutputStream                    | newOutputStream(Path path, OpenOption... options)            |      |
|                                 | 打开或创建文件，返回可用于向文件写入字节的输出流。           |      |
| boolean                         | notExists(Path path, LinkOption... options)                  |      |
|                                 | 测试此路径所在的文件是否不存在。                             |      |
| String                          | probeContentType(Path path)                                  |      |
|                                 | 探测文件的内容类型。                                         |      |
| byte[]                          | readAllBytes(Path path)                                      |      |
|                                 | 读取文件中的所有字节。                                       |      |
| List\<String>                   | readAllLines(Path path)                                      |      |
|                                 | 从文件中读取所有行。                                         |      |
| List\<String>                   | readAllLines(Path path, Charset cs)                          |      |
|                                 | 从文件中读取所有行。                                         |      |
| A                               | readAttributes(Path path, 类<A> type, LinkOption... options) |      |
|                                 | 读取文件的属性作为批量操作。                                 |      |
| Map<String,Object>              | readAttributes(Path path, String attributes, LinkOption... options) |      |
|                                 | 读取一组文件属性作为批量操作。                               |      |
| Path                            | readSymbolicLink(Path link)                                  |      |
|                                 | 读取符号链接的目标 （可选操作） 。                           |      |
| Path                            | setAttribute(Path path, String attribute, Object value, LinkOption... options) |      |
|                                 | 设置文件属性的值。                                           |      |
| Path                            | setLastModifiedTime(Path path, FileTime time)                |      |
|                                 | 更新文件上次修改的时间属性。                                 |      |
| Path                            | setOwner(Path path, UserPrincipal owner)                     |      |
|                                 | 更新文件所有者。                                             |      |
| Path                            | setPosixFilePermissions(Path path, Set<PosixFilePermission> perms) |      |
|                                 | 设置文件的POSIX权限。                                        |      |
| long                            | size(Path path)                                              |      |
|                                 | 返回文件的大小（以字节为单位）。                             |      |
| Stream\<Path>                   | walk(Path start, FileVisitOption... options)                 |      |
|                                 | 返回一个 Stream ，它通过 Path根据给定的起始文件的文件树懒惰地填充 Path 。 |      |
| Stream\<Path>                   | walk(Path start, int maxDepth, FileVisitOption... options)   |      |
|                                 | 返回一个 Stream ，它是通过走根据给定的起始文件的文件树懒惰地填充 Path 。 |      |
| Path                            | walkFileTree(Path start, FileVisitor<? super Path> visitor)  |      |
|                                 | 遍历目录文件。                                               |      |
| Path                            | walkFileTree(Path start, Set<FileVisitOption> options, int maxDepth, FileVisitor<? super Path> visitor) |      |
|                                 | 遍历一个目录文件。                                           |      |
| Path                            | write(Path path, byte[] bytes, OpenOption... options)        |      |
|                                 | 将字节写入文件。                                             |      |
| Path                            | write(Path path, Iterable<? extends CharSequence> lines, Charset cs, OpenOption... options) |      |
|                                 | 将文本行写入文件。                                           |      |
| Path                            | write(Path path, Iterable<? extends CharSequence> lines, OpenOption... options) |      |
|                                 | 将文本行写入文件。                                           |      |

# 字节流

> 从文件系统中的某个文件中获得输入字节用于读取诸如图像数据之类的原始字节流

![image-20201005235531741](/Users/hao/Library/Application Support/typora-user-images/image-20201005235531741.png)

![image-20201005235550244](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewcat35nj30dn063gn5.jpg)

- InputStream

  **如果返回值为-1,则表示已经达到文件末尾!**

| 方法                                       | 描述                                                   |
| ------------------------------------------ | ------------------------------------------------------ |
| public int read()                          | 从输入流中读取一个数据字节                             |
| public int read(byte[ ] b)                 | 人输入流中将最多b.length个字节的数据读入一个byte数组中 |
| public int read(byte[ ] b,int off,int len) | 从输入流中将最多len个字节的数据读入byte数组中          |
| public void close()                        | 关闭此文件输入流并放与此流有关的所有系统资源           |

- OutputStream

| 方法名                                      | 描述                                                       |
| ------------------------------------------- | ---------------------------------------------------------- |
| public void write(int b)                    | 将指定字节写入此文件输出流,b是ascii码                      |
| public void write(byte[] b)                 | 将b.length个字节从指定byte数组写入此文件输出流中           |
| public void write(byte[] b,int off,int len) | 将指定byte数组中从偏移量off开始的len个字节写入此文件输出流 |
| public void close()                         | 关闭此文件输出流并释放与此流有关的所有系统资源             |
| flush void（）                              | 刷新缓冲区                                                 |

注意：close（）方法默认调用了flush（）方法，但是flush（）方法只刷新缓冲区，而close（）还会关闭IO流

- 示例

```java
//true为追加，不写或false为覆盖
fos = new FileOutputStream("imooc.txt",true);
fis=new FileInputStream("imooc.txt");
fos.write(50);
fos.write('a');
fos.close();
fis.close();

//文件拷贝
FileInputStream fis=new FileInputStream("happy.gif");
FileOutputStream fos=new FileOutputStream("happycopy.gif");
int n=0;
byte[] b=new byte[1024];
while((n=fis.read(b))!=-1){
    fos.write(b,0,n);
}
fis.close();
fos.close();
```

# 字符流

> 字符流：就是在字节流的基础上，加上编码，形成的数据流
>
> 字符流出现的意义：因为字节流在操作字符时，可能会有中文导致的乱码，所以由字节流引申出了字符流。

![image-20201005235907860](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewfqbugij30lp0arwh8.jpg)

![image-20201005235843162](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewfaq1iuj30nz0cyjty.jpg)

- Reader
- Writer

> 用法与字节流基本相同，write(int) 在这里是 writer（string）

# 字节字符转换流

- InputStreamReader、OutputStreamWriter

```java
FileInputStream fis=new FileInputStream("imooc.txt");
//这里输入输出编码要一致，不写则是默认编码
InputStreamReader isr=new InputStreamReader(fis,"GBK");
BufferedReader br=new BufferedReader(isr);

FileOutputStream fos=new FileOutputStream("imooc1.txt");
OutputStreamWriter osw=new OutputStreamWriter(fos,"GBK");
BufferedWriter bw=new BufferedWriter(osw);

int n=0;
char[] cbuf=new char[10];
while((n=isr.read(cbuf))!=-1){
    System.out.print(n);
    String s=new String(cbuf,0,n);
    System.out.print(s);
}
```

# 缓冲流

> In/OutputStream：每次从硬盘读入一个字节到中转站， 再写入目的文件（硬盘）
>
> BufferedIn/OutputStream：一次读入n个字节到输入缓冲区，接着经中转站一个个写入到输出缓冲区，输入缓冲区为空时再次从硬盘读入批量数据，同理输出缓冲区满了以后再批量写入到目的文件（硬盘）。
>
> 如此使用BufferedStream可以减少访问硬盘的次数，速度大幅提升。
>
> 其内置缓冲数组`byte buf[8192]`,也可指定大小。
>
> 这里也可以是字符缓冲流。

![image-20201007195458649](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjh0mb9p9zj30ot07dtb2.jpg)

```java
FileOutputStream fos=new FileOutputStream("imooc.txt");
BufferedOutputStream bos=new BufferedOutputStream(fos);
FileInputStream fis=new FileInputStream("imooc.txt");
BufferedInputStream bis=new BufferedInputStream(fis);
long startTime=System.currentTimeMillis();
bos.write(50);
bos.write('a');
bos.flush();
System.out.println(bis.read());
System.out.println((char)bis.read());
long endTime=System.currentTimeMillis();
System.out.println(bis.read());
```

# 对象序列化

- ObjectInputStream、ObjectOutputStream

> 步骤：
>
> 创建一个类,继承Serializable接口
>
> 创建对象
>
> 将对象写入文件
>
> 从文件读取对象信息

```java
Goods goods1 = new Goods("gd001", "电脑", 3000);

FileOutputStream fos = new FileOutputStream("imooc.txt");
ObjectOutputStream oos = new ObjectOutputStream(fos);
FileInputStream fis = new FileInputStream("imooc.txt");
ObjectInputStream ois = new ObjectInputStream(fis);
// 将Goods对象信息写入文件
oos.writeObject(goods1);
oos.writeBoolean(true);//写入一个boolean类型变量true
oos.flush();
// 读对象信息
Goods goods = (Goods) ois.readObject();
System.out.println(goods);

close...
```

# 实际应用

## 创建及读写文件

1. `Files.newBufferedWriter`(Java8)
2. `Files.write`(Java 7 推荐)
3. `PrintWriter`
4. `File.createNewFile`
5. `FileOutputStream.write(byte[] b)` 管道流

### Files.newBufferedWriter

java8 提供的newBufferedWriter可以创建文件，并向文件内写入数据。可以通过追加写模式，向文件内追加内容。

```java
@Test
void testCreateFile1() throws IOException {
    String fileName = "D:\data\test\newFile.txt";
    Path path = Paths.get(fileName);
    // 使用newBufferedWriter创建文件并写文件
    // 这里使用了try-with-resources方法来关闭流，不用手动关闭
    try (BufferedWriter writer =
         Files.newBufferedWriter(path, StandardCharsets.UTF_8)) {
        writer.write("Hello World -创建文件!!");
    }

    //追加写模式
    try (BufferedWriter writer =
         Files.newBufferedWriter(path,
                                 StandardCharsets.UTF_8,
                                 StandardOpenOption.APPEND)){
        writer.write("Hello World -字母哥!!");
    }
}
```

### Files.write

下面的这种方式`Files.write`，是笔者推荐的方式，语法简单，而且底层是使用Java NIO实现的。同样提供追加写模式向已经存在的文件种追加数据。这种方式是实现文本文件简单读写最方便快捷的方式。

```java
@Test
void testCreateFile2() throws IOException {
   String fileName = "D:\data\test\newFile2.txt";

   // 从JDK1.7开始提供的方法
   // 使用Files.write创建一个文件并写入
   Files.write(Paths.get(fileName),
               "Hello World -创建文件!!".getBytes(StandardCharsets.UTF_8));

   // 追加写模式
   Files.write(
         Paths.get(fileName),
         "Hello World -字母哥!!".getBytes(StandardCharsets.UTF_8),
         StandardOpenOption.APPEND);
}
```

### PrintWriter

PrintWriter是一个比较古老的文件创建及写入方式，从JDK1.5就已经存在了，比较有特点的是：PrintWriter的println方法，**可以实现一行一行的写文件。**

```java
@Test
void testCreateFile3() throws IOException {
   String fileName = "D:\data\test\newFile3.txt";

   // JSD 1.5开始就已经存在的方法
   try (PrintWriter writer = new PrintWriter(fileName, "UTF-8")) {
      writer.println("Hello World -创建文件!!");
      writer.println("Hello World -字母哥!!");
   }

   // Java 10进行了改进，支持使用StandardCharsets指定字符集
   /*try (PrintWriter writer = new PrintWriter(fileName, StandardCharsets.UTF_8)) {

      writer.println("first line!");
      writer.println("second line!");

   } */

}
```

### File.createNewFile()

createNewFile()方法的功能相对就比较纯粹，只是创建文件不做文件写入操作。 返回true表示文件成功，返回 false表示文件已经存在.可以配合FileWriter 来完成文件的写操作。

```java
@Test
void testCreateFile4() throws IOException {
   String fileName = "D:\data\test\newFile4.txt";

   File file = new File(fileName);

   // 返回true表示文件成功
   // false 表示文件已经存在
   if (file.createNewFile()) {
      System.out.println("创建文件成功！");
   } else {
      System.out.println("文件已经存在不需要重复创建");
   }

   // 使用FileWriter写文件
   try (FileWriter writer = new FileWriter(file)) {
      writer.write("Hello World -创建文件!!");
   }

}
```

### 最原始的管道流方法

最原始的方式就是使用管道流嵌套的方法，但是笔者觉得这种方法历久弥新，使用起来非常灵活。你想去加上Buffer缓冲，你就嵌套一个BufferedWriter，你想去向文件中写java对象你就嵌套一个ObjectOutputStream。但归根结底要用到FileOutputStream。

```java
@Test
void testCreateFile5() throws IOException {
   String fileName = "D:\data\test\newFile5.txt";
   try(FileOutputStream fos = new FileOutputStream(fileName);
      OutputStreamWriter osw = new OutputStreamWriter(fos);
      BufferedWriter bw = new BufferedWriter(osw);){
      bw.write("Hello World -创建文件!!");
      bw.flush();
   }
}
```

## 从文件中读取数据

- `Scanner`(Java 1.5) 按行读数据及String、Int类型等按分隔符读数据。
- `Files.lines`, 返回`Stream`(Java8)流式数据处理，按行读取
- `Files.readAllLines`, 返回`List<String>`(Java8)
- `Files.readString`, 读取`String`(Java 11), 文件最大 2G.
- `Files.readAllBytes`, 读取`byte[]`(Java 7), 文件最大 2G.
- `BufferedReader`, 经典方式 (Java 1.1 -> forever)

可以说，每一种方法都有自己的适用场景，下文中为大家来一一介绍。

### Scanner

第一种方式是Scanner，从JDK1.5开始提供的API，特点是可以按行读取、按分割符去读取文件数据，既可以读取String类型，也可以读取Int类型、Long类型等基础数据类型的数据。

```java
@Test
void testReadFile1() throws IOException {
   //文件内容：Hello World|Hello Zimug
   String fileName = "D:\data\test\newFile4.txt";

   try (Scanner sc = new Scanner(new FileReader(fileName))) {
      while (sc.hasNextLine()) {  //按行读取字符串
         String line = sc.nextLine();
         System.out.println(line);
      }
   }

   try (Scanner sc = new Scanner(new FileReader(fileName))) {
      sc.useDelimiter("\|");  //分隔符
      while (sc.hasNext()) {   //按分隔符读取字符串
         String str = sc.next();
         System.out.println(str);
      }
   }

   //sc.hasNextInt() 、hasNextFloat() 、基础数据类型等等等等。
   //文件内容：1|2
   fileName = "D:\data\test\newFile5.txt";
   try (Scanner sc = new Scanner(new FileReader(fileName))) {
      sc.useDelimiter("\|");  //分隔符
      while (sc.hasNextInt()) {   //按分隔符读取Int
          int intValue = sc.nextInt();
         System.out.println(intValue);
      }
   }
}
```

上面的方法输出结果如下：

```
Hello World|Hello Zimug
Hello World
Hello Zimug
1
2
```

### Files.lines 

如果你是需要按行去处理数据文件的内容，这种方式是我推荐大家去使用的一种方式，代码简洁，使用java8的Stream流将文件读取与文件处理有机融合。

```java
@Test
void testReadFile2() throws IOException {
   String fileName = "D:\data\test\newFile.txt";

   // 读取文件内容到Stream流中，按行读取
   Stream<String> lines = Files.lines(Paths.get(fileName));

   // 随机行顺序进行数据处理
   lines.forEach(ele -> {
      System.out.println(ele);
   });
}
```

forEach获取Stream流中的行数据不能保证顺序，但速度快。如果你想按顺序去处理文件中的行数据，可以使用forEachOrdered，但处理效率会下降。

```java
// 按文件行顺序进行处理
lines.forEachOrdered(System.out::println);
```

或者利用CPU多核的能力，进行数据的并行处理parallel()，适合比较大的文件。

```java
// 按文件行顺序进行处理
lines.parallel().forEachOrdered(System.out::println);
```

也可以把`Stream<String>`转换成`List<String>`,但是要注意这意味着你要将所有的数据一次性加载到内存，要注意java.lang.OutOfMemoryError

```java
// 转换成List<String>, 要注意java.lang.OutOfMemoryError: Java heap space
List<String> collect = lines.collect(Collectors.toList());
```

### Files.readAllLines

这种方法仍然是java8 为我们提供的，如果我们不需要`Stream<String>`,我们想直接按行读取文件获取到一个`List<String>`，就采用下面的方法。同样的问题：这意味着你要将所有的数据一次性加载到内存，要注意java.lang.OutOfMemoryError

```java
@Test
void testReadFile3() throws IOException {
   String fileName = "D:\data\test\newFile3.txt";

   // 转换成List<String>, 要注意java.lang.OutOfMemoryError: Java heap space
   List<String> lines = Files.readAllLines(Paths.get(fileName),
               StandardCharsets.UTF_8);
   lines.forEach(System.out::println);

}
```

### Files.readString(JDK 11)

从 java11开始，为我们提供了一次性读取一个文件的方法。文件不能超过2G，同时要注意你的服务器及JVM内存。**这种方法适合快速读取小文本文件。**

```java
@Test
void testReadFile4() throws IOException {
   String fileName = "D:\data\test\newFile3.txt";

   // java 11 开始提供的方法，读取文件不能超过2G，与你的内存息息相关
   //String s = Files.readString(Paths.get(fileName));
}
```

### Files.readAllBytes()

如果你没有JDK11（readAllBytes()始于JDK7）,仍然想一次性的快速读取一个文件的内容转为String，该怎么办？先将数据读取为二进制数组，然后转换成String内容。**这种方法适合在没有JDK11的请开给你下，快速读取小文本文件。**

```java
@Test
void testReadFile5() throws IOException {
   String fileName = "D:\data\test\newFile3.txt";

   //如果是JDK11用上面的方法，如果不是用这个方法也很容易
   byte[] bytes = Files.readAllBytes(Paths.get(fileName));

   String content = new String(bytes, StandardCharsets.UTF_8);
   System.out.println(content);
}
```

### 经典管道流的方式

最后一种就是经典的管道流的方式

```java
@Test
void testReadFile6() throws IOException {
   String fileName = "D:\data\test\newFile3.txt";

   // 带缓冲的流读取，默认缓冲区8k
   try (BufferedReader br = new BufferedReader(new FileReader(fileName))){
      String line;
      while ((line = br.readLine()) != null) {
         System.out.println(line);
      }
   }

   //java 8中这样写也可以
   try (BufferedReader br = Files.newBufferedReader(Paths.get(fileName))){
      String line;
      while ((line = br.readLine()) != null) {
         System.out.println(line);
      }
   }

}
```

这种方式可以通过管道流嵌套的方式，组合使用，比较灵活。比如我们想从文件中读取java Object就可以使用下面的代码，前提是文件中的数据是ObjectOutputStream写入的数据，才可以用ObjectInputStream来读取。

```java
try (FileInputStream fis = new FileInputStream(fileName);
     ObjectInputStream ois = new ObjectInputStream(fis)){
    ois.readObject();
}
```

## 创建文件夹 

> 创建文件夹的四种方法，及其优缺点的解析

### File类创建

Java传统的IO API种使用`java.io.File`类中的`file.mkdir()`和`file.mkdirs()`方法创建文件夹

1. `file.mkdir()`创建文件夹成功返回true，失败返回false。如果被创建文件夹的父文件夹不存在也返回false.没有异常抛出。

2. `file.mkdirs()`创建文件夹连同该文件夹的父文件夹，如果创建成功返回true，创建失败返回false。创建失败同样没有异常抛出。

```java
@Test
void testCreateDir1() {
   //“D:\data111”目录现在不存在
   String dirStr = "D:\data111\test";
   File directory = new File(dirStr);

   //mkdir
   boolean hasSucceeded = directory.mkdir();
   System.out.println("创建文件夹结果（不含父文件夹）：" + hasSucceeded);

   //mkdirs
   hasSucceeded = directory.mkdirs();
   System.out.println("创建文件夹结果（包含父文件夹）：" + hasSucceeded);

}
```

输出结果如下：使用mkdir创建失败，使用mkdirs创建成功。

```java
创建文件夹结果（不含父文件夹）：false
创建文件夹结果（包含父文件夹）：true
```

大家可以看到，mkdir和mkdirs虽然可以创建文件，但是它们在异常处理的环节做的非常不友好。创建失败之后统一返回false，创建失败的原因没有说明。是父文件夹不存在所以创建失败？还是文件夹已经存在所以创建失败？还是因为磁盘IO原因导致创建文件夹失败？

### NIO创建

为解决传统IO创建文件夹中异常失败处理问题不明的问题，在Java的NIO进行了改进。

1. `Files.createDirectory`创建文件夹

- 如果被创建文件夹的父文件夹不存在，则抛出`NoSuchFileException`.
- 如果被创建的文件夹已经存在，则抛出`FileAlreadyExistsException`.
- 如果因为磁盘IO出现异常，则抛出`IOException`.

```java
Path path = Paths.get("D:\data222\test");
Path pathCreate = Files.createDirectory(path);
```

2. `Files.createDirectories`创建文件夹及其父文件夹

- 如果被创建文件夹的父文件夹不存在，就创建它
- 如果被创建的文件夹已经存在，就是用已经存在的文件夹，不会重复创建，没有异常抛出
- 如果因为磁盘IO出现异常，则抛出`IOException`.

```java
Path path = Paths.get("D:\data222\test");
Path pathCreate = Files.createDirectorys(path);
```

**注意：NIO的API创建的文件夹返回值是Path，这样方便我们在创建完成文件夹之后继续向文件夹里面写入文件数据等操作。比传统IO只返回一个boolean值要好得多。**

## 删除文件

### 四种基础方法

下面的四个方法都可以删除文件或文件夹，它们的共同点是：**当文件夹中包含子文件的时候都会删除失败，也就是说这四个方法只能删除空文件夹**。

> 注意：传统IO中的File类和NIO中的Path类既可以代表文件，也可以代表文件夹。

- File类的delete()：不建议
- File类的deleteOnExit()：不建议
- Files.delete(Path path)：建议使用
- Files.deleteIfExists(Path path)：建议使用

```java
//false只能告诉你失败了 ，但是没有给出任何失败的原因
@Test
void testDeleteFileDir1()  {
   File file = new File("D:\data\test");
   boolean deleted = file.delete();
   System.out.println(deleted);
}

//void ,删除失败没有任何提示，应避免使用这个方法，就是个坑
@Test
void testDeleteFileDir2()  {
   File file = new File("D:\data\test1");
   file.deleteOnExit();
}

//如果文件不存在，抛出NoSuchFileException
//如果文件夹里面包含文件，抛出DirectoryNotEmptyException
@Test
void testDeleteFileDir3() throws IOException {
   Path path = Paths.get("D:\data\test1");
   Files.delete(path);   //返回值void
}

//如果文件不存在，返回false，表示删除失败(文件不存在)
//如果文件夹里面包含文件，抛出DirectoryNotEmptyException
@Test
void testDeleteFileDir4() throws IOException {
   Path path = Paths.get("D:\data\test1");
   boolean result = Files.deleteIfExists(path);
   System.out.println(result);
}
```

### 删除包含文件的目录

> 删除整个目录或者目录中的部分文件

- 准备文件夹

![img](http://cdn.zimug.com/7ab55b2d64e702b163632079b1d217e2)

使用代面的代码进行创建：

```java
private  void createMoreFiles() throws IOException {
   Files.createDirectories(Paths.get("D:\data\test1\test2\test3\test4\test5\"));
   Files.write(Paths.get("D:\data\test1\test2\test2.log"), "hello".getBytes());
   Files.write(Paths.get("D:\data\test1\test2\test3\test3.log"), "hello".getBytes());
}
```

- walkFileTree与FileVisitor

> 使用walkFileTree方法遍历整个文件目录树，使用FileVisitor处理遍历出来的每一项文件或文件夹
>
> FileVisitor的visitFile方法用来处理遍历结果中的“文件”，所以我们可以在这个方法里面删除文件
>
> FileVisitor的postVisitDirectory方法，注意方法中的“post”表示“后去做……”的意思，所以用来**文件都处理完成之后再去处理文件夹**，所以使用这个方法删除文件夹就可以有效避免文件夹内容不为空的异常，因为在去删除文件夹之前，该文件夹里面的文件已经被删除了。

```java
@Test
void testDeleteFileDir5() throws IOException {
   createMoreFiles();
   Path path = Paths.get("D:\data\test1\test2");

   Files.walkFileTree(path,
      new SimpleFileVisitor<Path>() {
         // 先去遍历删除文件
         @Override
         public FileVisitResult visitFile(Path file,
                                  BasicFileAttributes attrs) throws IOException {
            Files.delete(file);
            System.out.printf("文件被删除 : %s%n", file);
            return FileVisitResult.CONTINUE;
         }
         // 再去遍历删除目录
         @Override
         public FileVisitResult postVisitDirectory(Path dir,
                                         IOException exc) throws IOException {
            Files.delete(dir);
            System.out.printf("文件夹被删除: %s%n", dir);
            return FileVisitResult.CONTINUE;
         }

      }
   );

}
```

下面的输出体现了文件的删除顺序

```java
文件被删除 : D:\data\test1\test2\test2.log
文件被删除 : D:\data\test1\test2\test3\test3.log
文件夹被删除 : D:\data\test1\test2\test3\test4\test5
文件夹被删除 : D:\data\test1\test2\test3\test4
文件夹被删除 : D:\data\test1\test2\test3
文件夹被删除 : D:\data\test1\test2
```

我们既然可以遍历出文件夹或者文件，我们就可以在处理的过程中进行过滤。比如：

- 按文件名删除文件或文件夹，参数Path里面含有文件或文件夹名称
- 按文件创建时间、修改时间、文件大小等信息去删除文件，参数BasicFileAttributes 里面包含了这些文件信息。

### Files.walk

如果你对Stream流语法不太熟悉的话，这种方法稍微难理解一点，但是说实话也非常简单。

- 使用Files.walk遍历文件夹（包含子文件夹及子其文件），遍历结果是一个`Stream<Path>`
- 对每一个遍历出来的结果进行处理，调用Files.delete就可以了。

```java
@Test
void testDeleteFileDir6() throws IOException {
   createMoreFiles();
   Path path = Paths.get("D:\data\test1\test2");

   try (Stream<Path> walk = Files.walk(path)) {
      walk.sorted(Comparator.reverseOrder())
         .forEach(DeleteFileDir::deleteDirectoryStream);
   }

}

private static void deleteDirectoryStream(Path path) {
   try {
      Files.delete(path);
      System.out.printf("删除文件成功：%s%n",path.toString());
   } catch (IOException e) {
      System.err.printf("无法删除的路径 %s%n%s", path, e);
   }
}
```

问题：**怎么能做到先去删除文件，再去删除文件夹？** 。 利用的是字符串的排序规则，从字符串排序规则上讲，“D:\data\test1\test2”一定在“D:\data\test1\test2\test2.log”的前面。所以我们使用“sorted(Comparator.reverseOrder())”把Stream顺序颠倒一下，就达到了先删除文件，再删除文件夹的目的。

下面的输出，是最终执行结果的删除顺序。

```java
删除文件成功：D:\data\test1\test2\test3\test4\test5
删除文件成功：D:\data\test1\test2\test3\test4
删除文件成功：D:\data\test1\test2\test3\test3.log
删除文件成功：D:\data\test1\test2\test3
删除文件成功：D:\data\test1\test2\test2.log
删除文件成功：D:\data\test1\test2
```

### 递归删除

 传统IO-递归遍历删除文件夹

传统的通过递归去删除文件或文件夹的方法就比较经典了

```java
//传统IO递归删除
@Test
void testDeleteFileDir7() throws IOException {
   createMoreFiles();
   File file = new File("D:\data\test1\test2");
   deleteDirectoryLegacyIO(file);

}

private void deleteDirectoryLegacyIO(File file) {

   File[] list = file.listFiles();  //无法做到list多层文件夹数据
   if (list != null) {
      for (File temp : list) {     //先去递归删除子文件夹及子文件
         deleteDirectoryLegacyIO(temp);   //注意这里是递归调用
      }
   }

   if (file.delete()) {     //再删除自己本身的文件夹
      System.out.printf("删除成功 : %s%n", file);
   } else {
      System.err.printf("删除失败 : %s%n", file);
   }
}
```

需要注意的是：

- `listFiles()`方法只能列出文件夹下面的一层文件或文件夹，不能列出子文件夹及其子文件。
- 先去递归删除子文件夹，再去删除文件夹自己本身

## 拷贝(重命名)与剪切

**文件拷贝（重命名）与剪切的5种方法**:

- 文件拷贝：将文件从一个文件夹复制到另一个文件夹
- 文件剪切：将文件从当前文件夹，移动到另一个文件夹
- 文件重命名：将文件在当前文件夹下面改名（也可以理解为将文件剪切为当前文件夹下面的另一个文件）

### 文件拷贝

传统IO中的文件copy的方法，使用输入输出流，实际上就是重新创建并写入一个文件。如果目标文件已经存在，就覆盖掉它，重新创建一个文件并写入数据。这种方式不够友好，**覆盖掉原有文件没有给出任何提示，有可能导致原有数据的丢失**。

```java
@Test
void testCopyFile1() throws IOException {
  File fromFile = new File("D:\data\test\newFile.txt");
  File toFile = new File("D:\data\test2\copyedFile.txt");

  try(InputStream inStream = new FileInputStream(fromFile);
      OutputStream outStream = new FileOutputStream(toFile);) {

    byte[] buffer = new byte[1024];

    int length;
    while ((length = inStream.read(buffer)) > 0) {
      outStream.write(buffer, 0, length);
      outStream.flush();
    }
  }
}
```

Java NIO中文件copy的方法，使用方式简单。当目标文件已经存在的时候会抛出FileAlreadyExistsException ，当源文件不存在的时候抛出NoSuchFileException，针对不同的异常场景给出不同的Exception，更有利于我们写出健壮性更好的程序。

```java
@Test
void testCopyFile2() throws IOException {
  Path fromFile = Paths.get("D:\data\test\newFile.txt");
  Path toFile = Paths.get("D:\data\test2\copyedFile.txt");

  Files.copy(fromFile, toFile);
}
```

如果在目标文件已经存在的情况下，你不想抛出FileAlreadyExistsException ，而是去覆盖它，也可以灵活的选择使用下面的选项

- StandardCopyOption.REPLACE_EXISTING 来忽略文件已经存在的异常，如果存在就去覆盖掉它

```java
//如果目标文件存在就替换它
Files.copy(fromFile, toFile, StandardCopyOption.REPLACE_EXISTING);
```

- StandardCopyOption.COPY_ATTRIBUTES copy文件的属性，最近修改时间，最近访问时间等信息，不仅copy文件的内容，连文件附带的属性一并复制

```java
CopyOption[] options = { StandardCopyOption.REPLACE_EXISTING,
      StandardCopyOption.COPY_ATTRIBUTES //copy文件的属性，最近修改时间，最近访问时间等
          //StandardCopyOption.COPY_ATTRIBUTES：文件的原子操作，既操作不能被其他线程、进程打断
};
Files.copy(fromFile, toFile, options);
```

### 文件重命名

NIO 中可以使用Files.move方法在同一个文件夹内移动文件，并更换名字。当目标文件已经存在的时候，同样会有FileAlreadyExistsException，也同样可以使用StandardCopyOption去处理该异常。

```java
@Test
void testRenameFile() throws IOException {
  Path source = Paths.get("D:\data\test\newFile.txt");
  Path target = Paths.get("D:\data\test\renameFile.txt");

  //REPLACE_EXISTING文件存在就替换它
  Files.move(source, target,StandardCopyOption.REPLACE_EXISTING);
}
```

下文中的实现方法和上面代码的效果是一样的，resolveSibling作用是将source文件的父路径与参数文件名合并为一个新的文件路径。

> resolve系列函数在windows和linux等各种系统处理路径分隔符号、路径与文件名合并等，比自己手写代码去处理不同操作系统的路径分隔符号、路径与文件名合并有更好的操作系统兼容性。

```java
@Test
void testRenameFile2() throws IOException {
  Path source = Paths.get("D:\data\test\newFile.txt");

  //这种写法就更加简单，兼容性更好
  Files.move(source, source.resolveSibling("renameFile.txt"));
}
```

传统IO中使用File类的renameTo方法重命名，失败了就返回false，没有任何异常抛出。你不会知道你失败的原因是什么，是因为源文件不存在导致失败？还是因为目标文件已经存在导致失败？所以这种方法笔者不建议使用。

```java
@Test
void testRenameFile3() throws IOException {

  File source = new File("D:\data\test\newFile.txt");
  boolean succeeded = source.renameTo(new File("D:\data\test\renameFile.txt"));
  System.out.println(succeeded);  //失败了false，没有异常
}
```

### 文件剪切

文件剪切实际上仍然是Files.move，如果move的目标文件夹不存在或源文件不存在，都会抛出NoSuchFileException

```java
@Test
void testMoveFile() throws IOException {

  Path fromFile = Paths.get("D:\data\test\newFile.txt"); //文件
  Path anotherDir = Paths.get("D:\data\test\anotherDir"); //目标文件夹

  Files.createDirectories(anotherDir);
  Files.move(fromFile, anotherDir.resolve(fromFile.getFileName()),
          StandardCopyOption.REPLACE_EXISTING);
}
```

resolve函数是解析anotherDir路径与参数文件名进行合并为一个新的文件路径。