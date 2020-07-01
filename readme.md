![](https://user-gold-cdn.xitu.io/2020/7/1/17308fae96e1e302?w=1000&h=526&f=jpeg&s=36185)

# 前言

## Docker 安装

- 官网注册账号
- mac win：直接下载客户端运行
- linux 安装：https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux

## Docker 基础

### images

- `docekr pull [images] #拉取镜像`
- `docekr imgaes #查看所有镜像`
- `docker rmi [imagesID] #删除指定镜像`
- `docker rmi -f \$(docker images -aq) #！小技巧删除所有镜像`

### container

- `docekr ps #查看运行容器`
  - `-a 列出历史`
  - `-n 列出最近`
  - `-q 只显示编号`
- `docker rm [containerID] #删除指定容器`
- `docker rmi -f \$(docker ps -aq) #！小技巧删除所有容器`
- `docker start id #启动容器`
- `docker restart id #重启容器`
- `docker stop id #停止当前运行的容器`
- `docker kill id #强制停止当前运行容器`

### network

- bridge:桥接 docker（默认）
- none:不配置网络
- host:主机模式 和宿主机共享网络
- container:容器网络联通（用的少！局限性大）
- 自定义网络 create
  - `docker network create --driver bridge --subnet 192.168.3.0/16 --gateway 192.168.3.1 mynet`
- 查看网络列表
  - `docker network ls`
- 删除网络
  - `docker network rm ID`

### 创建启动容器

- docekr run [参数] imagesID #创建一个容器并启动
  - `-it 使用交互方式运行没进入容器查看内容`
  - `-d 后台运行`
  - `--name="Name" 容器名称 区分容器`
- 端口映射：将容器服务端口映射到主机端口
  - `-p [主机端口]:[容器端口]`
  - `-P 随机端口`
- 数据卷：主机与容器数据共享
  - `-v [容器路径] 匿名挂载`
  - `-v [主机路径]:[容器路径] 具名挂载`
- 网络：选择网络模式

  - `-net [name]`

- 实例：`docker run -itd -p 9000:9000 --name demo -v /var/run/docker.sock:/var/run/docker.sock -v /Users/luofei/learn/docker_file/portainer/data:/data docker.io/portainer/portainer /bin/bash`

### 查看容器的基本信息

`docker inspect 容器id`

### 查看容器日志

`docker logs 容器id`

### 从容器拷贝到本机

- 'docker cp 本机路径 容器 id:文件路径 //主机内容拷贝到容器'
- 'docker cp 容器 id:文件路径 本机路径 //容器拷贝内容到主机'

### 进入一个容器

- `docker exec -it [container] /bin/bash` 在已运行的容器中执行命令，不创建和启动新的容器，退出 shell 不会导致容器停止运行
- `docker attach [container]` 本机的输入直接输到容器中，容器的输出会直接显示在本机的屏幕上，如果退出容器的 shell，容器会停止运行

### 退出容器

- exit 直接退出
- Ctrl + p + q 退出不停止

### 制作一个镜像

docker commit -m="提交的描述信息" -a="作者" 容器 id 目标镜像名:[TAG]

## DockerFile

- FROM：这个镜像的妈妈是谁（基础镜像）
- MAINTAINER：这个镜像是谁写的（维护者的信息）
- RUN：构建镜像需要运行的命令
- ADD：步骤：copu 文件，会自动解压
- WORKDIR：设置当前工作目录
- VOLUME：设置券，挂载主机目录
- EXPOSE： 暴露端口
- CMD：指定这个容器启动的时候要运行的命令 只有最后一个会生效，可被替代
- ENTRYPOINT：指定这个容器启动的时候要运行的命令，可以追加命令
- ONBUILD：当构建一个被继承 DockerFile 这个时候就会运行 ONBUILD 的命令，触发指令
- COPY：类似 ADD 将我们的文件拷贝到镜像中
- ENV：构建镜像的时候设置环境变量

## 发布镜像

### Docker hub

- `docker login` 登录
- `docker tag [imageID] [message]`镜像标签
- `docker push [image]`上传镜像

### 阿里云

- 登录阿里云
- 进入容器镜像服务
- 创建命名空间
- 创建镜像仓库
  ![](https://user-gold-cdn.xitu.io/2020/7/1/1730901cec8695b7?w=3570&h=1912&f=png&s=262882)

      ```ssh
      $ sudo docker login --username=username registry.cn-hangzhou.aliyuncs.com
      $ sudo docker tag [ImageId] registry.cn-hangzhou.aliyuncs.com/jackfly/jackfly:[镜像版本号]
      $ sudo docker push registry.cn-hangzhou.aliyuncs.com/jackfly/jackfly:[镜像版本号]
      ```

### 制作专属系统镜像

缺什么补什么，作为前端下面这些已经够用了。

- 选择底包 ubuntu16.04（看个人喜好）
- net-tools
- ssh 服务 （通过 shell 工具连接 docker 容器内）
- node:v12.18.1
- npm:6.14.5
- pm2:4.4.0
- git:2.7.4
- zsh:5.1.1
- zsh_plugs:(git,zsh-autosuggestions, zsh-syntax-highlighting)
- Nginx

dockerfile 实例

![](https://user-gold-cdn.xitu.io/2020/7/1/17309129caea338e?w=1394&h=2140&f=png&s=340488)

### 生成镜像

```
docker build -f dockerfile -t [imageName] .
```

注意！！！后面那个 "." 了没有一定要加上！

### 镜像使用

```
docker run -itd --name mywork -v /Users/jackfly/docker:/home/work -p 6555:22 -p 8080:80 mywork
```

- 使用 oh-my-zsh，这东西真是爱不释手啊。

```
docker exec -it mywork /bin/zsh
```

- shell 连接 docker 容器
  run 的时候咱们映射了两个端口，22 是 ssh 服务的端口，那么通过主机映射的 6555 就可以连接到 docker 内部了。默认密码是：root

![](https://user-gold-cdn.xitu.io/2020/7/1/173092a40ae7c1ff?w=1170&h=1070&f=png&s=131960)

连接成功！这就是你的专属服务器，想怎么造怎么造，比 docker 数据卷共享更自由。

![](https://user-gold-cdn.xitu.io/2020/7/1/17309316c91164cc?w=3318&h=1782&f=png&s=491876)
