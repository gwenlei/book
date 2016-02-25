#install cloudstack4.5.2 in centos7.1
##vm setting
memory must large than 2048m
disk 64G
4 net
##vlan setting change
ifcfg-eth0
```
DEVICE=eth0
TYPE=Ethernet
IPADDR=192.168.56.11
PREFIX=24
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=none
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
NAME=MGMT
```
ifcfg-eth1
```
DEVICE=eth1
TYPE=Ethernet
IPADDR=10.0.2.11
GATEWAY=10.0.2.1
PREFIX=24
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=none
DEFROUTE=yes
PEERROUTES=yes
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
NAME=NAT
```
ifcfg-eth2
```
DEVICE=eth2
TYPE=Ethernet
IPADDR=172.30.0.11
PREFIX=24
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=none
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
NAME=PUBLIC
```
ifcfg-eth3
```
DEVICE=eth3
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
MTU=9000
USERCTL=no
IPADDR0=10.10.100.11
IPADDR1=10.10.101.11
PREFIX0=24
PREFIX1=24
```
##install mysql without yum
```
sudo rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo yum install mysql-server
sudo systemctl start mysqld
```
##install cloudstack
repo
```
[cloudstack]
name=cloudstack
baseurl=http://192.168.0.79/cloudstack452centos7
enabled=1
gpgcheck=0
``` 
```
yum install cloudstack-*
cloudstack-setup-databases cloud:engine@127.0.0.1 --deploy-as=root:engine
cloudstack-setup-management
service cloudstack-management restart
```
