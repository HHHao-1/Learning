# 问题记录

1. 进入docker虚拟机

> screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
>
> 1. ctrl+a + k --> 按y --> kill掉这个screen了
>
> 2. 暂时退出使用ctrl+a + d，再次进入使用screen -dr，
>
> 否则使用上述原命令再进去会是无法操作情况，kill这个screen即可

2. 端口转发创建容器

```shell
$ docker run -d -h hao --name Mininet --privileged=true -p 6663:6653 -p 5003:22 --privileged=true centos-ssh /usr/sbin/init
```

3. 进入容器

```shell
$ docker exec -it mininet /bin/bash
```

