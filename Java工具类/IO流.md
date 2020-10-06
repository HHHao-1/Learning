# 概念

![4B412703-903C-463C-A0AA-65813432F535](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjeuw5cucbj30ta0guwjc.jpg)

![ECC84071-FF09-43E3-B61A-31419A897C0E](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjeuw6moukj30vf0gsjwr.jpg)

# File类

什么是文件?

文件可认为是放在一起的数据的集合

绝对路径：是从盘符开始的路径

相对路径：是从当前路径开始的路径

# 字节流

字书输入流InputStream

字节输出流OutputStream

![image-20201005235531741](/Users/hao/Library/Application Support/typora-user-images/image-20201005235531741.png)

![image-20201005235550244](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewcat35nj30dn063gn5.jpg)

FileInputStream

从文件系统中的某个文件中获得输入字节用于读取诸如图像数据之类的原始字节流

![image-20201005235635288](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewd3107wj30f30hdwi7.jpg)

# 缓冲流

缓冲输入流BufferedInputStream

缓冲输出流BufferedOutputStream

# 字符流

字符输入流Reader

字符输出流Writer

![image-20201005235907860](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewfqbugij30lp0arwh8.jpg)

![image-20201005235843162](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjewfaq1iuj30nz0cyjty.jpg)

# 字节字符转换流

InputStreamReader

OutputStreamWriter



# 对象序列化

步骤：

-创建一个类,继承Serializable接口

-创建对象

-将对象写入文件

-从文件读取对象信息



对象序列化

对象输入流ObjectInputStream

对象输出流ObjectOutputStream