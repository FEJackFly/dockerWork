#!/bin/bash

#/usr/sbin/service sshd start
#/usr/sbin/service nginx start
/etc/init.d/ssh start
/etc/init.d/nginx start
tail -f /dev/null
