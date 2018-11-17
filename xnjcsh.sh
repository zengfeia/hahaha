#!/bin/bash
#开机挂载光盘
echo mount /dev/sr0 /mnt >>/etc/rc.d/rc.local
chmod 777 /etc/rc.d/rc.local
mount /dev/sr0 /mnt
#安装本地YUM源
mkdir /etc/yum.repos.d/repo
mv /etc/yum.repos.d/*.repo  /etc/yum.repos.d/repo
touch /etc/yum.repos.d/Centos7.repo
echo [centos7] >> /etc/yum.repos.d/Centos7.repo
echo name=centos7 >>/etc/yum.repos.d/Centos7.repo
echo baseurl=file:///mnt >>/etc/yum.repos.d/Centos7.repo
echo enabled=1  >>/etc/yum.repos.d/Centos7.repo
echo gpgcheck=0 >>/etc/yum.repos.d/Centos7.repo
#安装vim编辑器
yum install -y vim &>/dev/null
#关闭防火墙 selinux
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
#vim编辑器宽度设置
echo set ts=4 >>/etc/vimrc
#配置主机名
hostname $1
echo "$1".qf.com >  /etc/hostname
#配置IP
echo BOOTPROTO=none >/etc/sysconfig/network-scripts/ifcfg-eth0
cat <<EOF >>/etc/sysconfig/network-scripts/ifcfg-eth0
NAME="eth0"
DEVICE="eth0"
ONBOOT="yes"
TYPE="Ethernet"
IPADDR=172.16.37.$2
PREFIX="24"
EOF
ifdown eth0 &>/dev/null ;ifup eth0 &>/dev/null


