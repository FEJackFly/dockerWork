# @Author: JackFly
# @since: 2020-06-24 17:30:03
# @lastTime: 2020-06-30 11:19:16
# @FilePath: /docker/dockerfile
# @message: TrunkOS 基础镜像


FROM       ubuntu:16.04

MAINTAINER JackFly


RUN apt-get update

RUN apt-get install -y wget 

RUN  apt-get install -y curl 

RUN apt-get install --assume-yes apt-utils




#tool
RUN apt-get install -y vim
RUN apt-get install -y net-tools
RUN apt-get install -y inetutils-ping  

#node
RUN  apt-get install -y npm
RUN npm config set registry https://registry.npm.taobao.org

RUN npm install n -g

RUN n lts

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

RUN npm install -g pm2

#git

RUN apt-get install -y git

#zsh
RUN apt-get install -y zsh

RUN git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

RUN chsh -s /bin/zsh

# nginx

RUN apt-get install -y nginx


# ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
