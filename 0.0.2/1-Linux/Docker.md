# 容器

## 进入容器

### 语法

`docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`

| options | 作用                          |
| ------- | ----------------------------- |
| -d      | 在后台运行命令                |
| -i      | 即使没有附加也保持 STDIN 打开 |
| -t      | 进入容器的 CLI 模式           |
| -e      | 设置环境变量                  |
| -w      | 需要执行命令的目录            |
| -u      | 指定访问容器的用户名          |

### 示例

`docker exec -it tomcat7 startup.sh`

`docker exec -it tomcat7 bash 或者 /bin/bash`

`docker exec -it tomcat7 pwd`

`docker exec -it -uroot jenkins1 bash 以root用户身份进入容器`