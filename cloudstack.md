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
nfs添加参数
```
MOUNTD_NFS_V3="yes"
RQUOTAD_PORT=875
MOUNTD_PORT=892
STATD_PORT=662
STATD_OUTGOING_PORT=2020


LOCKD_TCPPORT=32803
LOCKD_UDPPORT=32769
```


xenserver分vlan不能连接，暂不知原因。
改成不用vlan的二级存储。
  553  ifconfig eth3.100 10.10.100.11/24
  554  ifconfig eth3.101 10.10.101.11/24
  519  vconfig add eth3 100
  520  vconfig add eth3 101
  516  modprobe 8021q

they are not HVM enabled
update cloud.vm_template set hvm=0 where name='c66';

##下载模版时要设置文件可读权限，不要勾选hvm

yum -y install mariadb*  
systemctl start mariadb.service
systemctl enable mariadb.service
mysql_secure_installation
mysql -u root -p  (enter password when prompted)
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
mysql> quit
cloudstack-setup-databases cloud:engine@127.0.0.1 --deploy-as=root:engine
cloudstack-setup-management

cd /usr/share/cloudstack-common/scripts/vm/hypervisor/xenserver/
wget http://download.cloud.com.s3.amazonaws.com/tools/vhd-util
chmod 755 /usr/share/cloudstack-common/scripts/vm/hypervisor/xenserver/vhd-util

/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /exports/secondary -u http://192.168.56.11/systemvm64template-4.5-xen.vhd.bz2 -h xenserver -F

数据库出错修复
/usr/bin/myisamchk -c -r /var/lib/mysql/mysql/proc.MYI

nfs,nginx自动启动
systemctl enable nfs-server.service
systemctl enable nginx
