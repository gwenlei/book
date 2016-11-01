### 调查背景
VR的作用：实现虚拟网络功能。每个来宾网络(客户网络)对应至少一个vRouter，当启动某个网络的第一台客户虚拟机时，vRouter会自动创建出来，若一个客户网络长时间不存在启动的虚拟机，该网络的vRouter会自动关闭。
VR服务类型：IPAM (DHCP)、DNS、NAT、Source NAT、防火墙、端口转发、负载均衡、VPN等等。
VR的问题：某生产环境里，VR经常自动重启或者假死。

### 1. 验证环境
Cloudstack4.5.1 (15G RAM).
压力测试客户端：ubuntu14.04 (3G RAM).
压力测试服务端：ubuntu14.04 In CloudStack.
监控：Collectd + Graphite + Grafana.
### 2. 验证方法
A. 更改压力测试客户端/服务端连接数限制（见附5.1）。
B. VR安装Collectd，收集和上传监测数据（见附5.2）。
C. CloudStack上启动压力测试服务端，保持其运行状态（见附5.3）。
D. 启动压力测试客户端，以每分钟数千条的频率建立与服务端的连接。观察VR负载及相关监控指标（见附5.4）。
E. 修改VR内存设置，分别设置内存128M、256M、512M，重复运行C步骤(见附5.5)。

### 3. 验证数据
配置一：VR内存设置为128M  连接数达到17万时VR内存耗尽，VR自动重启，实例网络连接断开。
![pic1](images/128M.png)
配置二: VR内存设置为256M  连接数达到40万时VR内存耗尽，VR自动重启，实例网络连接断开。
![pic2](images/256M.png)
配置三: VR内存设置为512M  由于连接数限制(100万条双向连接）,达到51万连接后，后续无法增加更多连接，VR内存消耗保持稳定，实例网络连接保持。
![pic3](images/512M.png)
VR重启前后iptables数据对比(VR异常重启 VS CloudStack重启)
![pic4](images/iptables.png)

### 4. 结论
连接数增加会导致VR内存使用增加，当VR内存耗尽后VR会自动重启。
如果是VR自动重启，虚拟机实例的iptables规则会缺失，对外连接断开。
如果由CloudStack页面重启VR，虚拟机实例的iptables规则会自动补全，恢复连接。
适当扩大VR内存，有利于提升VR性能，进而保证其在海量连接情况下的稳定性。


### 5. 附
#### 5.1 更改客户端/服务器端连接数限制
修改连接数限制两个配置文件
/etc/sysctl.conf 
```
fs.file-max=1048576
net.netfilter.nf_conntrack_max = 6553500
net.ipv4.ip_local_port_range= 1024 65535
```
/etc/security/limits.conf 
```
cloud soft nproc -1
cloud hard nproc -1
* soft nofile 1048576
* hard nofile 1048576
root - nofile 1048576
root hard nofile 1048576
root soft nofile 1048576
```
#### 5.2 VR Collectd配置
在VR上运行以下命令，安装collectd:    

```
# apt-get update && apt-get install -y collectd
```

Collectd配置:

```
$ touch /var/log/collectd.log
$ vim /etc/collectd/collectd.conf
Hostname "VRHostName"
LoadPlugin logfile
#LoadPlugin syslog

<Plugin logfile>
	LogLevel "info"
	File "/var/log/collectd.log"
	Timestamp true
	PrintSeverity false
</Plugin>

#<Plugin syslog>
#	LogLevel info
#</Plugin>

..... 

LoadPlugin conntrack
LoadPlugin uptime 
#LoadPlugin df
LoadPlugin write_graphite

<Plugin write_graphite>
	<Carbon>
		Host "192.168.x.xx"
		Port "2003"
		Prefix "collectd"
		Postfix "collectd"
		StoreRates false
		AlwaysAppendDS false
		EscapeCharacter "_"
	</Carbon>
</Plugin>

```
启动collectd系统服务:    

```
# service collectd restart
```

#### 5.3 压力测试服务器端启动方法
炸弹机服务器实例启动方法
```
cd /root/BombVR
./server
```

#### 5.4 压力测试客户端启动方法
轰炸机客户端独立用qemu启动
```
cd /home/adminubuntu/testmachine
./startmachine.sh
```
```
sudo qemu-system-x86_64 -net nic,model=virtio,macaddr=52:54:00:12:34:56,vlan=1 -net tap,vlan=1 -net nic,model=virtio,macaddr=52:54:00:12:34:57,vlan=2 -net tap,vlan=2 -net nic,model=virtio,macaddr=52:54:00:12:34:58,vlan=3 -net tap,vlan=3 -net nic,model=virtio,macaddr=52:54:00:12:34:59,vlan=4 -net tap,vlan=4 -net nic,model=virtio,macaddr=52:54:00:12:34:60,vlan=5 -net tap,vlan=5 -net nic,model=virtio,macaddr=52:54:00:12:34:61,vlan=6 -net tap,vlan=6 -net nic,model=virtio,macaddr=52:54:00:12:34:62,vlan=7 -net tap,vlan=7 -net nic,model=virtio,macaddr=52:54:00:12:34:63,vlan=8 -net tap,vlan=8 -hda ./ubuntu1404-Docker.qcow2 -m 5120 --enable-kvm
```
炸弹机客户端启动方法
```
cd /root/BombVR
./ethernet.sh
./startbomb.sh
```
#### 5.5 更改domainrouter内存大小
```
$ mysql -ucloud -pengine -e "UPDATE cloud.service_offering SET ram_size='512', speed='500' WHERE vm_type='domainrouter'"
$ service CloudStack-management restart
$ service CloudStack-agent restart
```
在CloudStack页面重启VR后，内存会变更成最新配置。

#### 5.6.client.c/server.c来源及编译方法
Server端代码下载地址:    
[https://gist.github.com/yongboy/5318930/raw/ccf8dc236da30fcf4f89567d567eaf295b363d47/server.c](https://gist.github.com/yongboy/5318930/raw/ccf8dc236da30fcf4f89567d567eaf295b363d47/server.c)   

编译方法，ubuntu下:    

```
$ sudo apt-get install -y libev-dev
$ vim server.c
注释掉ev.h那行，直接换成#include <ev.h>
$ gcc -o server server.c -lev -lm
```

Client端代码下载地址:    

[https://gist.github.com/yongboy/5324779/raw/f29c964fcd67fefc3ce66e487a44298ced611cdc/client2.c](https://gist.github.com/yongboy/5324779/raw/f29c964fcd67fefc3ce66e487a44298ced611cdc/client2.c)


