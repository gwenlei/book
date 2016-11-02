### 1. 验证环境

### 2. 验证方法

### 3. 验证数据
128M  VR   17W链接。。。。。
192M  VR   30W链接。。。。。
256M  VR   40W链接。。。。。
320M  VR   31W链接。。。。。
384M  VR   25W链接。。。。。
448M  VR   24W链接。。。。。
512M  VR   51W链接。。。。。

79: root/Engine@Onecloud42
root/engine123

passwd: engine
mysql -u cloud -p<password>
UPDATE cloud.service_offering SET ram_size='128', speed='128' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='128', speed='128' WHERE vm_type='elasticloadbalancervm';
UPDATE cloud.service_offering SET ram_size='128', speed='128' WHERE vm_type='secondarystoragevm';
UPDATE cloud.service_offering SET ram_size='128', speed='128' WHERE vm_type='internalloadbalancervm';
UPDATE cloud.service_offering SET ram_size='128', speed='128' WHERE vm_type='consoleproxy';
quit

256/512/1G


 cat 2016-10-24-VRMonitoringViaCollectd.md
+++
categories = ["Linux"]
date = "2016-10-24T16:36:24+08:00"
description = "Monitoring cloudstack VR via collectd"
keywords = ["Linux"]
title = "VRMonitoringViaCollectd"

+++
### Environment
The VR's information is listed as following:

![/images/2016_10_24_16_35_58_501x547.jpg](/images/2016_10_24_16_35_58_501x547.jpg)
Now login the VR in CloudStack Agent Node via:

```
# ssh -i /root/.ssh/id_rsa.cloud -p3922 169.254.0.129
```
Modify its `/etc/apt/sources.list` like following:

```
# cat /etc/apt/sources.list
#

# deb cdrom:[Debian GNU/Linux 7.8.0 _Wheezy_ - Official amd64 NETINST Binary-1
20150110-14:41]/ wheezy main

#deb cdrom:[Debian GNU/Linux 7.8.0 _Wheezy_ - Official amd64 NETINST Binary-1
20150110-14:41]/ wheezy main


deb http://mirrors.aliyun.com/debian wheezy main
deb-src http://mirrors.aliyun.com/debian wheezy main

deb http://mirrors.aliyun.com/ wheezy/updates main
deb-src http://mirrors.aliyun.com/ wheezy/updates main

# wheezy-updates, previously known as 'volatile'
deb http://mirrors.aliyun.com/debian wheezy-updates main
deb-src http://mirrors.aliyun.com/debian wheezy-updates main
deb http://mirrors.aliyun.com/debian/ wheezy-backports main
```
Then `apt-get update && apt-get install -y collectd`, for installing collectd.

### Collectd
Configuration of collectd:

```
$ touch /var/log/collectd.log
$ vim /etc/collectd/collectd.conf
Hostname "WeiLan"
LoadPlugin logfile
#LoadPlugin syslog

<Plugin logfile>
    LogLevel "info"
    File "/var/log/collectd.log"
    Timestamp true
    PrintSeverity false
</Plugin>

#<Plugin syslog>
#    LogLevel info
#</Plugin>

.....

LoadPlugin conntrack
LoadPlugin uptime
#LoadPlugin df
LoadPlugin write_graphite

<Plugin write_graphite>
    <Carbon>
        Host "192.168.1.79"
        Port "2003"
        Prefix "collectd"
        Postfix "collectd"
        StoreRates false
        AlwaysAppendDS false
        EscapeCharacter "_"
    </Carbon>
</Plugin>

```
Start the collectd service via:

```
# service collectd restart
```



### Later
1. VM(graphite+grafana).
2. Collectd(Ansible<id_pub.cloud, 3922, automatically install.>).
Collectd-> VM
Ansible+package(VR -> graphite).

smplayer VRPerformance.mkv 
vncviewer 192.168.1.79:1     engine123
http://10.17.17.2:8080/client

ssh root@10.17.17.248
    1  ls
    2  cd /home/adminubuntu/
    3  ls
    4  cd BombVR/
    5  ls
    6  rm -f client2
    7  gcc -o client2 client2.c -levent
    8  ls
    9  ./startbomb.sh 
   10  modprobe nf_conntrack
   11  sysctl -p /etc/sysctl.conf 
   12  ./startbomb.sh 
   13  dmesg
   14  ulimit -Sn
   15  vim /etc/security/limits.conf 
   16  ulimit -Sn
   17  ulimit -Hn
   18  vim /etc/security/limits.conf 
   19  reboot
   20  ifconfig
   21  ulimit -Sn
   22  ulimit -Hn
   23  vim /etc/security/limits.conf 
   24  reboot
   25  ulimit -Sn
   26  ulimit -Hn
   27  uname -a
   28  modprobe nf_conntrack
   29  sysctl -p /etc/sysctl.conf 
   30  ulimit -n
   31  ulimit -Sn
   32  vi /etc/pam.d/login 
   33  ulimit -a
   34  cat /proc/sys/fs/file-max
   35  cd /
   36  find / -name pam_limits.so
   37  vim /etc/pam.d/login 
   38  reboot
   39  ulimit -Sn
   40  ulimit -Hn
   41  vim /etc/security/limits.conf 
   42  sudo sysctl -a|grep file
   43  cat /proc/sys/fs/file-max
   44  cat /proc/sys/fs/file-nr
   45  vim /etc/security/limits.conf 
   46  reboot
   47  ulimit -n
   48  ulimit -Sn
   49  ls
   50  sysctl -p /etc/sysctl.conf 
   51  modprobe nf_conntrack
   52  sysctl -p /etc/sysctl.conf 
   53  ls
   54  cd /home/adminubuntu/
   55  ls
   56  cd BombVR/
   57  ls
   58  ./ethernet.sh 
   59  ifconfig
   60  ls
   61  cat startbomb.sh 
   62  ./startbomb.sh 
   63  ./client2 -h 10.17.17.6 -p 8000 -m 64000 -o 10.17.17.190
   64  cat /etc/security/limits.conf 
   65  ls
   66  ./startbomb.sh 
   67  cat /etc/security/limits.conf 
   68  shutdown -h now
   69  vim /etc/rc.local 
   70  reboot
   71  ls
   72  cd 
   73  ls
   74  cd /home/adminubuntu/
   75  ls
   76  cd /root/
   77  ls
   78  pwd
   79  mv /home/adminubuntu/* ./
   80  ls
   81  cd BombVR/
   82  ls
   83  ./ethernet.sh 
   84  ls
   85  ifconfig
   86  exit
   87  ls
   88  cd BombVR/
   89  ls
   90  ifconfig
   91  ls
   92  ./startbomb.sh 


sudo qemu-system-x86_64 -net nic,model=virtio,macaddr=52:54:00:12:34:56,vlan=1 -net tap,vlan=1 -net nic,model=virtio,macaddr=52:54:00:12:34:57,vlan=2 -net tap,vlan=2 -net nic,model=virtio,macaddr=52:54:00:12:34:58,vlan=3 -net tap,vlan=3 -net nic,model=virtio,macaddr=52:54:00:12:34:59,vlan=4 -net tap,vlan=4 -net nic,model=virtio,macaddr=52:54:00:12:34:60,vlan=5 -net tap,vlan=5 -net nic,model=virtio,macaddr=52:54:00:12:34:61,vlan=6 -net tap,vlan=6 -net nic,model=virtio,macaddr=52:54:00:12:34:62,vlan=7 -net tap,vlan=7 -net nic,model=virtio,macaddr=52:54:00:12:34:63,vlan=8 -net tap,vlan=8 -hda ./ubuntu1404-Docker.qcow2 -m 5120 --enable-kvm

 ssh -i /root/.ssh/id_rsa.cloud -p3922 169.254.3.219

UPDATE cloud.service_offering SET ram_size='128', speed='500' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='192', speed='500' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='256', speed='500' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='320', speed='500' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='384', speed='500' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='448', speed='500' WHERE vm_type='domainrouter';
UPDATE cloud.service_offering SET ram_size='512', speed='500' WHERE vm_type='domainrouter';

mysql -ucloud -pengine -e "UPDATE cloud.service_offering SET ram_size='512', speed='500' WHERE vm_type='domainrouter'"
select * from cloud.service_offering WHERE vm_type='domainrouter';

service cloudstack-management restart
service cloudstack-agent restart
重启vr
重启cloudstack不成功，内存溢出，要重启整个虚拟机
virsh reboot BombVR1017172
重新启动测试虚拟机BombSever
ssh root@10.17.17.2
cd /home/adminubuntu/testmachine
./startmachine.sh

cat /etc/sysctl.conf 
net.bridge.bridge-nf-call-arptables=1
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
fs.file-max=1048576
net.netfilter.nf_conntrack_max = 6553500
net.ipv4.ip_local_port_range= 1024 65535

cat /etc/security/limits.conf 
cloud soft nproc -1
cloud hard nproc -1
* soft nofile 1048576
* hard nofile 1048576
root - nofile 1048576
root hard nofile 1048576
root soft nofile 1048576


root@packer-ubuntu-1404-server:~/BombVR# free -h
             total       used       free     shared    buffers     cached
Mem:          2.9G       116M       2.8G       388K        12M        44M
-/+ buffers/cache:        59M       2.9G
Swap:         511M         0B       511M


root@CS:/# free -h
             total       used       free     shared    buffers     cached
Mem:           15G       6.6G       9.0G       608K        64M       416M
-/+ buffers/cache:       6.1G       9.5G
Swap:         511M         0B       511M





