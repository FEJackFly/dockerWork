<!--
 * @Author: JackFly
 * @since: 2020-06-29 14:00:33
 * @lastTime: 2020-07-01 14:24:50
 * @FilePath: /docker/TrunkOS.md
 * @message:TrunkOS docker
-->

# 镜像清单
## 镜像底包：Ubuntu16.04
## net-tools
## node:v12.18.1
## npm:6.14.5
## pm2:4.4.0
## git:2.7.4
## zsh:5.1.1
## zsh_plugs:(git,zsh-autosuggestions, zsh-syntax-highlighting)
## Nginx



# 使用方法

## 拉取镜像

```
$ sudo docker pull registry.cn-hangzhou.aliyuncs.com/jackfly/mywork:v1
```

## 启动容器
``` ssh
docker run -it --name trunkos -v /Users/luofei/docker:/home/TrunkOS/dise_electron -p 6555:22  trunkos:v1 /bin/zsh

```
## 进入容器
```
docker attach trunkos /bin/bash
```
## 打包程序

```
cd /home/TrunkOS

npm run electron:build
```


# 提交镜像



# 开启ssh
## 安装
`apt-get install openssh-server`
## 设置开机启动

### 开机自动启动ssh命令
`sudo systemctl enable ssh`

### 关闭ssh开机自动启动命令
`sudo systemctl disable ssh`

 
### 单次开启ssh
`sudo systemctl start ssh`

### 单次关闭ssh
`sudo systemctl stop ssh`
### 设置好后重启系统
`reboot`
 
### 查看ssh是否启动，看到Active: active (running)即表示成功
`sudo systemctl status ssh`


