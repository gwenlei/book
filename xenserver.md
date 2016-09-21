in basic zone, Security group is enabled by default. Security group doesn't work with OVS, bridge is required for Security group.

mount 192.168.1.69:/home/igw/img/leisj/xensec /root/temp
/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /root/temp -u http://192.168.0.82/downloads/systemvm64template-4.5-xen.vhd.bz2 -h xenserver -F


xe pbd-unplug uuid=f06bbbe3-ac42-1608-d412-f12d2cda4757
xe sr-forget uuid=9be98e9b-395d-0f4b-f339-dbc9b9ce8e75

http://docs.cloudstack.apache.org/projects/cloudstack-installation/en/4.6/hypervisor/xenserver.html
xe-switch-network-backend bridge

update sysctl.conf with the following

net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-arptables = 1

$ sysctl -p /etc/sysctl.conf

For XenServer 6.0.2, 6.0, 5.6 SP2:

    Download the CSP software onto the XenServer host from one of the following links:

    For XenServer 6.0.2:

    http://download.cloud.com/releases/3.0.1/XS-6.0.2/xenserver-cloud-supp.tgz

    For XenServer 5.6 SP2:

    http://download.cloud.com/releases/2.2.0/xenserver-cloud-supp.tgz

    For XenServer 6.0:

    http://download.cloud.com/releases/3.0/xenserver-cloud-supp.tgz


https://cloudstore.interoute.com/knowledge-centre/library/vdc-saas-application-multizone


2016-09-13 04:13:00,444 DEBUG [c.c.c.ConsoleProxyManagerImpl] (Work-Job-Executor-4:ctx-0fb8c09d job-47/job-52 ctx-3edf371f) Boot Args for VM[ConsoleProxy|v-2-VM]:  template=domP type=consoleproxy host=192.168.10.123 port=8250 name=v-2-VM zone=1 pod=1 guid=Proxy.2 proxy_vm=2 disable_rp_filter=true eth2ip=192.168.10.81 eth2mask=255.255.0.0 gateway=192.168.0.176 eth0ip=169.254.2.238 eth0mask=255.255.0.0 eth1ip=192.168.10.93 eth1mask=255.255.0.0 mgmtcidr=192.168.0.0/16 localgw=192.168.0.176 internaldns1=192.168.10.2 dns1=8.8.8.8

在XenServer主机的/opt/xensource/packages/iso下有个systemvm.iso文件，这个文件应该是由 CloudStack从管理机复制过来的，在CloudStack的管理机上的/usr/share/cloudstack-common/vms目录下 有该文件，可能是由于XenServer主机多次重复使用，没有重新安装，造成了这个文件没有正确复制。 解决： 1.进入XenServer主机 2.执行xe host-param-clear param-name=tags uuid=<uuid of the XS host> 3.重启CloudStack 4.销毁ssvm 

xe host-emergency-ha-disable --force
xe pool-ha-disable

UPDATE cloud.configuration SET value='192.168.10.2' WHERE name='host';--是管理服务器的ip


ssh -i ~/.ssh/id_rsa.cloud -p3922 169.254.2.5
/usr/local/cloud/sysvm


mv /home/tmp/win2008r2.vhd /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8898.vhd
mv /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8898.vhd /home/tmp/win2008r2-0919.vhd 


delete from cloud.image_store where data_center_id=2;
delete from cloud.vlan where data_center_id=2;
delete from cloud.physical_network where data_center_id=2;
delete from cloud.physical_network_isolation_methods where physical_network_id=202;
delete from cloud.physical_network_service_providers where physical_network_id=202;
delete from cloud.physical_network_traffic_types where physical_network_id=202;
delete from cloud.storage_pool where data_center_id=2;
delete from cloud.storage_pool_host_ref where host_id=4;
delete from cloud.template_zone_ref where zone_id=2;
delete from cloud.host where id=4;
delete from cloud.host_details where host_id=4;
delete from cloud.host_gpu_groups where host_id=4;
delete from cloud.cluster where id=2;
delete from cloud.dc_storage_network_ip_range where data_center_id=2;
delete from cloud.host_pod_ref where id=2;
delete from cloud.host_tags where host_id=4;
delete from cloud.nics where network_id in (207,208,209,210);
delete from cloud.networks where data_center_id=2;
delete from cloud.data_center where id=2;

默认使用本地存储
system.vm.use.local.storage=true

delete from cloud.image_store where data_center_id=3;
delete from cloud.vlan where data_center_id=3;
delete from cloud.physical_network_isolation_methods where physical_network_id in (select id from cloud.physical_network where data_center_id=3);
delete from cloud.physical_network_service_providers where physical_network_id in (select id from cloud.physical_network where data_center_id=3);
delete from cloud.physical_network_traffic_types where physical_network_id in (select id from cloud.physical_network where data_center_id=3);
delete from cloud.physical_network where data_center_id=3;
delete from cloud.storage_pool where data_center_id=3;
delete from cloud.storage_pool_host_ref where host_id in (select id from cloud.host where data_center_id=3);
delete from cloud.template_zone_ref where zone_id=3;
delete from cloud.host_details where host_id in (select id from cloud.host where data_center_id=3);
delete from cloud.host_gpu_groups where host_id in (select id from cloud.host where data_center_id=3);
delete from cloud.host where data_center_id=3;
delete from cloud.cluster where data_center_id=3;
delete from cloud.dc_storage_network_ip_range where data_center_id=3;
delete from cloud.host_pod_ref where data_center_id=3;
delete from cloud.host_tags where host_id in (select id from cloud.host where data_center_id=3);
delete from cloud.nics where network_id in (select id from cloud.networks where data_center_id=3);
delete from cloud.networks where data_center_id=3;
delete from cloud.data_center where id=3;


https://github.com/schubergphilis/cloudstack-utility-scripts/blob/master/devcloud/setup-xen-server.sh
http://support.citrix.com/article/CTX121313
http://greg.porter.name/wiki/HowTo:XenServer#Add_a_new_storage_repository_on_local_disk
http://www.linuxidc.com/Linux/2013-11/92282.htm

首先要确定xenserver里有设置本地存储，cloudstack创建zone的时候勾选Enable local storage for user vms和Enable local storage for system vms，后面就不用配置主存，自动识别本地存储。

 cat /proc/partitions
ll /dev/disk/by-id
 xe sr-create host-uuid=554db3b4-4aa1-4d45-8fb1-9af9c3815e2e content-type=user name-label="localstorage" shared=false device-config:device=/dev/sda3 type=ext

xe host-param-clear param-name=tags uuid=554db3b4-4aa1-4d45-8fb1-9af9c3815e2e

root@kspc002:/home/dash# showmount -e
Export list for kspc002:
/home/igw/img/leisj/pri     *
/home/igw/img/leisj/xensec3 *
/home/igw/img/leisj/xenpri3 *
/home/igw/img/leisj/xensec2 *
/home/igw/img/leisj/xenpri2 *
/home/igw/img/leisj/xensec  *
/home/igw/img/leisj/xenpri  *


192.168.1.69:/home/dash/AllInOneCentOS48
/home/dash/Code/purplepalmdash.github.io/content/post
