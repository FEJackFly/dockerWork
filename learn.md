<!--
 * @Author: JackFly
 * @since: 2020-06-10 10:25:02
 * @lastTime: 2020-06-28 17:44:12
 * @FilePath: /docker/learn.md
 * @message:docker学习
-->

# docker

## docker images

docker rmi -f \$(docker images -aq) //删除所有镜像

## docker run [参数] image

--name="Name" 容器名称 区分容器

-d 后台运行

-it 使用交互方式运行没进入容器查看内容

-p, 指定容器端口 （小 p）

-p 主机 ip 主机端口：容器端口
-p 主机端口：容器端口 （常用）
-p 容器端口
容器端口

-P, 随机指定端口 (大 p)

启动并进入
docker run -it centos /bin/bash

## docker ps 命令

     列出当前

-a 列出历史
-n=？ 列出最近

-q 只显示编号

## 删除容器

docker rm id 删除指定容器，不能删除正在运行的容器

docker rm -f \$(docker ps -aq) 删除所有容器

## 启动停止重启容器

docker start id 启动容器

docker restart id 重启容器

docker stop id 停止当前运行的容器

docker kill id 强制停止当前运行容器

# docker 常用其他命令

## 后台启动

docker run -it 容器

## 查看日志

docker logs Options:
--details Show extra details provided to logs
-f, --follow Follow log output
--since string Show logs since timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)
--tail string Number of lines to show from the end of the logs (default "all")
-t, --timestamps Show timestamps
--until string Show logs before a timestamp (e.g. 2013-01-02T13:23:37) or relative (e.g. 42m for 42 minutes)

## 查看容器中的进程信息

top

## 查看容器的基本信息

docker inspect 容器 id

## 进入当前正在运行的容器

通常容器都是后台方式运行的 需要进去进入容器 修改一些配置

docker exec -it 容器 id /bin/bash 新开启命令行

docker attach 重启 id 打开当前命令行

## 退出容器

exit 直接退出

control + p + q 退出不停止

## 从容器拷贝到本机

docker cp 容器 id:文件路径 本机路径 //容器拷贝内容到本机

# 可视化

docker 图形化管理工具

## portainer

docker run -d -p 9000:9000 --restart=always --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v /Users/luofei/learn/docker_file/portainer/data:/data docker.io/portainer/portainer

docker 可视化管理 全英文界面的 还是拉倒吧

## Rancher

# 制作一个镜像

docker commit -m="提交的描述信息" -a="作者" 容器 id 目标镜像名:[TAG]

# 数据卷

docker run -it -v 主机目录:容器目录
docker run -it --name jack -v /Users/luofei/学习/docker/data:/haha myubuntu /bin/bash

容器删除后 本地数据依旧保存

## 具名和匿名挂载

查看所有 volume 的情况
docker volume ls

### 匿名挂载

-v
docker run -d -P --name XXX -v /ect/nginx nginx

### 具名挂载

docker run -d -P --name XXX -v 主机路径:/ect/nginx nginx

# DockerFile

面向开发，发布项目，做镜像，就需要编写 dockerFile 文件，这个文件十分简单

`
FROM centos

VOLUME ["volume01","volume02"]

CMD echo "-----end-----"

CMD /bin/bash
`

docker build -f dockerfile -t jack .

注意后面的. !!!!

Docker：镜像之间成为企业交付的标准，必须掌握
步骤：开发,部署，运维 缺一不可
DockerFile：构建文件，定义了一切的步骤，源代码
DockerImages：通过 DockerFile 构建生成的镜像，最终发布和运行产品！
Docker 容器：容器就像是镜像运行起来的提供服务器

## DockerFile 指令

通过 DockerFile 练习自己发布一个镜像

FROM：这个镜像的妈妈是谁（基础镜像）

MAINTAINER：这个镜像是谁写的（维护者的信息）

RUN：构建镜像需要运行的命令

ADD：步骤：copu 文件，会自动解压

WORKDIR：设置当前工作目录

VOLUME：设置券，挂载主机目录

EXPOSE： 暴露端口

CMD：指定这个容器启动的时候要运行的命令 只有最后一个会生效，可被替代

ENTRYPOINT：指定这个容器启动的时候要运行的命令，可以追加命令

ONBUILD：当构建一个被继承 DockerFile 这个时候就会运行 ONBUILD 的命令，触发指令

COPY：类似 ADD 将我们的文件拷贝到镜像中

ENV：构建镜像的时候设置环境变量

## 实战练习：DockerFile

1.编写 dockerfile 文件

2.构建镜像

3.启动镜像

4.访问测试

5.发布项目

# 发布自己的镜像

## DockerHub

images 打 tag

docker push image/tag

## 阿里云

容器镜像服务

命名空间

镜像仓库

1. 登录阿里云 Docker Registry
   \$ sudo docker login --username=骆飞 web registry.cn-hangzhou.aliyuncs.com
   用于登录的用户名为阿里云账号全名，密码为开通服务时设置的密码。

您可以在访问凭证页面修改凭证密码。

2. 从 Registry 中拉取镜像
   \$ sudo docker pull registry.cn-hangzhou.aliyuncs.com/jackfly/mywork:[镜像版本号]
3. 将镜像推送到 Registry
   $ sudo docker login --username=骆飞web registry.cn-hangzhou.aliyuncs.com
$ sudo docker tag [ImageId] registry.cn-hangzhou.aliyuncs.com/jackfly/mywork:[镜像版本号]
   \$ sudo docker push registry.cn-hangzhou.aliyuncs.com/jackfly/mywork:[镜像版本号]
   请根据实际镜像信息替换示例中的[ImageId]和[镜像版本号]参数。

4. 选择合适的镜像仓库地址
   从 ECS 推送镜像时，可以选择使用镜像仓库内网地址。推送速度将得到提升并且将不会损耗您的公网流量。

如果您使用的机器位于 VPC 网络，请使用 registry-vpc.cn-hangzhou.aliyuncs.com 作为 Registry 的域名登录，并作为镜像命名空间前缀。

5. 示例
   使用"docker tag"命令重命名镜像，并将它通过专有网络地址推送至 Registry。

$ sudo docker images
REPOSITORY                                                         TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
registry.aliyuncs.com/acs/agent                                    0.7-dfb6816         37bb9c63c8b2        7 days ago          37.89 MB
$ sudo docker tag 37bb9c63c8b2 registry-vpc.cn-hangzhou.aliyuncs.com/acs/agent:0.7-dfb6816
使用"docker images"命令找到镜像，将该镜像名称中的域名部分变更为 Registry 专有网络地址。

\$ sudo docker push registry-vpc.cn-hangzhou.aliyuncs.com/acs/agent:0.7-dfb6816

# docker 网络

bridge:桥接 docker（默认）

none:不配置网络

host:主机模式 和宿主机共享网络

container:容器网络联通（用的少！局限性大）

docker network create --driver bridge --subnet 192.168.3.0/16 --gateway 192.168.3.1 mynet

## 查看当前网络

docker network ls

## 启动自定义网络配置

docker run -i -P --name jack --net mynet mywork:v1
