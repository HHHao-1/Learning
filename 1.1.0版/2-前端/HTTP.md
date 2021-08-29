# Content-type

请求/响应的数据格式，在HTTP请求头中使用Content-type来指定不同的类型

1. 常见的媒体类型：
   - text/plain ： 纯文本格式
   - text/html ：html格式
   - text/xml ：  xml格式
   - text/css ：  css格式
   - image/gif ：gif图片格式
   - image/jpeg ：jpg图片格式 
   - image/png ：png图片格式
2. 以applicaton开头的媒体类型：
   - **application/json（常用）：**
     - *JSON数据格式，序列化后的 JSON 字符串*
   - **application/x-www-form-urlencoded（常用）：**
     - *form表单默认的数据格式，以key1=val1&key2=val2 方式进行URL字符串编码*
   - **multipart/form-data（常用） ： **
     - *form表单上传文件时使用，也可以上传普通数据*
   - application/xhtml+xml：XHTML格式
   - application/xml： XML数据格式
   - application/atom+xml：Atom XML聚合格式    
   - application/pdf：pdf格式  
   - application/javascript：js格式
   - application/msword： Word文档格式
   - application/octet-stream： 二进制流数据（如常见的文件下载）
3. postman请求数据格式：
   - form-data：multipart/form-data
   - raw：text/plain
   - x-www-form-urlencoded：application/x-www-form-urlencoded
   - binary：application/octet-stream
     - 只可以上传二进制数据，用来上传文件；没有键值，一次只能上传一个文件

   - GraphQL
     - 一种用于 API 的查询语言；请求所需要的数据，可以不请求多余字段
     - GraphQL是一种新的API标准，它提供了一种RestAPI的替代方案