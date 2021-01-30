# 发送请求

## 请求方式

1. a便签的href属性

   > - 动态url及添加get方法参数，使用vue数据绑定

2. form表单（get请求urlencoded编码拼在url?后，post封装在http body）

   enctype属性: 规定在发送表单数据之前如何对其进行编码。有三种设置类型：

   > - **默认为application/x-www-form-urlencoded**：发送前编码所有字符
   >
   >   - 可以上传键值对，不可以上传文件
   >   - 键值对都是间隔分开的
   >
   >   ```js
   >   // 参数编码
   >   name1=value1&name2=value2（
   >   ```
   >
   > - multipart/form-data：不对字符编码，包含文件上传控件的表单时，必须使用该值
   >
   >   - 既可以上传键值对，也可以上传文件
   >   - 后会转化为一条信息
   >   - 在springmvc中可以使用MultipartHttpServletRequest接收，通过api根据"name"获取不同的键值，也可以通过MulTipartFile数组接收多个文件
   >
   >   ```js
   >   // 参数编码
   >   ------WebKitFormBoundaryO40ObCwjBZj1Ll0t
   >   Content-Disposition: form-data; name="name"
   >   
   >   Mickey
   >   ------WebKitFormBoundaryO40ObCwjBZj1Ll0t
   >   Content-Disposition: form-data; name="age"
   >   
   >   20
   >   ------WebKitFormBoundaryO40ObCwjBZj1Ll0t--
   >   
   >   // 图片编码
   >   Content-Disposition: form-data; name=12,filename=240077a0gif gif
   >   Content-type: Image/gif
   >   ```
   >
   > - text/plain：纯文本传输
   >
   >   - post方法无法获取此参数，它是无格式的，需要在后台设置自行解析结果串
   >
   >   ```js
   >   // 参数编码
   >   name=Mickey
   >   age=20
   >   ```

3. ajax请求

   > - **默认编码格式：application/x-www-form-urlencoded**
   >
   > - qs：
   >   - qs.stringify()将对象序列化成URL的形式，以&进行拼接
   >
   >   - qs.parse()将URL解析成对象的形式
   >
   >   - 传递数组
   >
   >     ```js
   >     qs.stringify({ a: ['b', 'c', 'd'] });
   >     // 'a[0]=b&a[1]=c&a[2]=d'
   >     
   >     qs.stringify({ a: ['b', 'c', 'd'] }, { indices: false });
   >     // 'a=b&a=c&a=d'
   >     ```
   >
   > - JSON.stringify()
   >
   >   - 与qs.stringify()区别
   >
   >     ```js
   >     // JSON.stringify(),格式化为JSON对象字符串
   >     {"uid":"cs11","pwd":"000000als","username":"cs11","password":"000000als"}
   >     
   >     //qs.stringify()
   >     uid=cs11&pwd=000000als&username=cs11&password=000000als
   >     ```

## Postman

- form-data
  - multipart/form-data
- raw
  - text/plain
- x-www-form-urlencoded
  - application/x-www-form-urlencoded
- binary
  - application/octet-stream
  - 只可以上传二进制数据，通常用来上传文件，由于没有键值，所以，一次只能上传一个文件

- GraphQL
  - 一种用于 API 的查询语言，请求你所要的数据 不多不少（无冗余字段）
  - GraphQL是一种新的API标准，它提供了一种比REST更有效、更强大和更灵活的替代方案

