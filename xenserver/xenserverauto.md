sed -i "s/10.1.6.203/172.28.101.203/g" /etc/sysconfig/network-scripts/ifcfg-ens3
sed -i "s/10.1.6.203/172.28.101.203/g" /var/lib/tftpboot/pxelinux.cfg/default
sed -i "s/10.1.6.203/172.28.101.203/g" /var/www/html/answerfile65.xml
sed -i "s/10.1.6.203/172.28.101.203/g" /var/www/html/xs65ps.sh
sed -i "s#10.1.6.0/24#172.28.101.0/24#g" /etc/dhcp/dhcpd.conf

cd /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html
sed -i "s/10.1.6.203/172.28.101.203/g" xs_patcher/patches/creedence
sed -i "s/10.1.6.203/172.28.101.203/g" xen-script/auto-deploy.sh
tar cvf all.tar xen-script xs_patcher
tar cvf local.tar local
scp local.tar all.tar xs65ps.sh root@172.28.101.203:/var/www/html
scp /home/img/testvm/testvm.qcow2 root@192.168.10.123:/home/clouder/img/xspxe/testvmpxe4.qcow2

xe network-param-set name-label="testlabel" uuid=57caa1c8-ab37-7369-844a-7fb1f5e56616
网络标签不能重复cloudbr0 bond后要修改标签

xe pif-reconfigure-ip uuid=7ccfdf42-339b-ad44-4058-5ee0b8430244 mode=static IP=172.28.101.11 netmask=255.255.255.0 gateway=172.28.101.1
xe host-set-hostname-live host-uuid=41c11c35-5a7e-45e3-a5f7-9089a18e6996 host-name=xenserver-host11
xe host-param-set name-label=xenserver-host11 uuid=41c11c35-5a7e-45e3-a5f7-9089a18e6996

Password has been reset to kH9ism

python -mSimpleHTTPServer 80
http://192.168.173.101/file/centos72.vhd
http://192.168.173.82/index/xenservertemplate/centos72.vhd
cloudmonkey register template hypervisor=XenServer zoneid=9abe5610-e9e2-41d7-9523-5869f88070e6 format=vhd name=centos7 displaytext=test1 ispublic=true ostypeid=f0d26901-a57b-11e6-bae0-6ed00c427d9f url=http://192.168.173.101/centos72.vhd passwordenabled=true

git clone https://github.com/lzh9102/python-file-server.git
nohup /home/local/python-file-server/hfs.py -p 80 /home/local/python-file-server/*.vhd >/home/local/python-file-server/log 2>&1 &

virsh autostart --disable TestServer

xe bond-create network-uuid=<network_uuid> pif-uuids=<pif_uuid_1,pif_uuid_2,...>

bash shell变量不能有减号，只能用下划线

scp -r /var/lib/tftpboot root@10.1.6.1:/home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy
scp -r /var/www/html root@10.1.6.1:/home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy

scp -r /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/tftpboot/* root@10.1.6.203:/var/lib/tftpboot 
scp -r /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/* root@10.1.6.203:/var/www/html

scp -r /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/xs_patcher/xs_patcher.sh root@10.1.6.203:/var/www/html/xs_patcher
scp -r /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/xen-script/* root@10.1.6.203:/var/www/html/xen-script

tar cvf all.tar  xs_patcher xen-script
tar cvf local.tar  local
scp /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/all.tar root@10.1.6.203:/var/www/html
scp /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/local.tar root@10.1.6.203:/var/www/html
scp /home/clouder/Cloudstack_Xenserver_auto_deploy/script-and-template/cent71-csmanager-custom-xentool.xva root@10.1.6.203:/var/www/html

scp /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/xs65ps.sh root@10.1.6.203:/var/www/html/
scp /home/img/testvm/testvm.qcow2 root@192.168.10.123:/home/clouder/img/xspxe/testvmpxe4.qcow2

在创建zone时勾选”use local storage”；全局设置中将“system.vm.use.local.storage”置为true；创建允许使用本地存储的Service Offering。
UPDATE cloud.configuration SET value='192.168.173.0/24' WHERE name='management.network.cidr';
UPDATE cloud.configuration SET value='192.168.173.101' WHERE name='host';
UPDATE cloud.configuration SET value='192.168.173.0/24' WHERE name='secstorage.allowed.internal.sites';


mysql -ucloud -pengine -e "use cloud; update configuration set value='$IP' where name='host' and component='ApiServiceConfiguration';"

cloudmonkey list serviceofferings filter=id|grep id| awk -F ' = ' {'print $2'}


for i in $(cloudmonkey list serviceofferings filter=id|grep id| awk -F ' = ' {'print $2'})
do
cloudmonkey delete serviceoffering id=$i
done

http://192.168.173.82/index/xenservertemplate/Centos64_aug19.vhd
Password of new VM Centos64 is  nJ6sgb
Password of new VM c1c512m is  uJ9kya

[root@cs-mgr ~]# cat update-db.sh 
#!/bin/bash

IP=`ifconfig |grep -w "inet"|grep -v "127.0.0.1"|awk '{print $2}'`

sed -i 's/cluster.node.IP=\(.*\)'/cluster.node.IP=$IP/ /etc/cloudstack/management/db.properties


mysql -ucloud -pengine -e "use cloud; update configuration set value='$IP' where name='host' and component='ApiServiceConfiguration';"
mysql -ucloud -pengine -e "use cloud; select * from configuration where name='host' and component='ApiServiceConfiguration';"


systemctl stop firewalld.service
systemctl disable firewalld.service
systemctl enable cloudstack-management
systemctl start cloudstack-management

默认network_backend: openvswitch,简单网络时设置xenserver使用bridge
xe host-list params=software-version
xe-switch-network-backend bridge

dd if=/home/html/iso/XenServer-7.0.0-main.iso of=/dev/sdb bs=1M
dd if=/home/html/iso/CentOS-7-x86_64-Minimal-1611.iso of=/dev/sdb bs=1M

qemu-img convert -O vmdk /home/img/testvm/testvm.qcow2 /home/img/testvm/testvmpxe.vmdk
scp /home/img/testvm/testvm.qcow2 root@192.168.10.123:/home/clouder/img/xspxe/testvmpxe.qcow2

ip a add 192.168.1.195-196-194/24
route add -net 172.28.96.0/19 gw 192.168.1.147

ip a add 192.168.1.194/24 dev ens3
ip route del default via 192.168.173.1
ip route add default via 192.168.1.1 dev ens3
ip route add  172.28.96.0/19 via 192.168.1.147 dev ens3

vhd-util scan -f -m "VHD-*" -l VG_XenStorage-<UUID_of_StorageRepository> -p

for i in `vgs --noheadings -o vg_name`; do vhd-util scan -p -l $i -f 'VHD-*' ; done

for i in `lvs| awk -F ' ' {'print $1'}|sed -e "s/VHD-//g"`; do xe vdi-list uuid=$i; done

lvs

ls -l /dev/mapper
xentop
iostat
vhd-util scan -f -m "VHD-*" -l VG_XenStorage--fd7eedd2--035e--c27d--35a9--f19289f50e39-MGT -p
cat /sys/block/tdd/dev
tap-ctl list -m 3
xe vdi-list uuid=bba407f7-c916-4c47-9c42-26acb0b827f0
xe vdi-list

xe host-call-plugin host-uuid=40e317bc-18eb-4c81-a383-28733a2c5de6 \
plugin=coalesce-leaf fn=leaf-coalesce args:vm_uuid=9bad4022-2c2d-dee6-abf5-1b6195b1dad5


 python /opt/xensource/sm/cleanup.py -u <SR_UUID> -g -f

xe diagnostic-vdi-status

先禁用virt-manager内部虚拟网桥，再连接外部同网段的虚拟机

#安装cobbler
yum install -y epel-release
yum install -y cobbler cobbler-web
yum install -y nfs-utils vim
yum install -y xinetd dhcp
yum install cobbler cobbler-web dhcp tftp-server pykickstart httpd xinetd -y
yum install tftp-server pykickstart httpd -y
systemctl start xinetd.service
systemctl enable xinetd.service
systemctl start httpd
systemctl enable httpd
systemctl start cobblerd.service
systemctl enable cobblerd.service

vim /etc/cobbler/settings
vim /etc/xinetd.d/tftp
vim /etc/cobbler/dhcp.template

#安装pxe环境
yum install -y tftp-server tftp xinetd
yum install httpd -y
systemctl enable httpd

/etc/xinetd.d/tftp
systemctl enable xinetd.service
 systemctl restart xinetd.service

yum install -y dhcp
/etc/dhcp/dhcpd.conf
systemctl enable dhcpd.service
systemctl restart dhcpd.service

yum install -y ansible httpd

配置 TFTP 服务器:
1. 在 /var/lib/tftpboot 目录中,创建一个名为 xenserver 的新目录。
2. 将 mboot.c32 和 pxelinux.0 文件从 /home/mnt（也就是XenServer的iso文件夹里面） 目录复制到 /var/lib/tftpboot 目录。
注意:
Citrix 强烈建议您使用来自同一个来源(例如,来自同一个 XenServer ISO)的
mboot.c32 和 pxelinux.0 文件。
3. 从 XenServer 安装介质上,将文件 install.img(位于根目录)、vmlinuz 和 xen.gz(位于
/boot 目录)复制到 TFTP 服务器上的新 /var/lib/tftpboot/xenserver 目录。
4. 在 /var/lib/tftpboot 目录中,创建名为 pxelinux.cfg 的新目录。
5. 在 pxelinux.cfg 目录中,创建名为 default 的新配置文件。


mount XenServer-6.5.0-xenserver.org-install-cd.iso /mnt
cp -r /mnt /var/www/html/xs65
mkdir /var/lib/tftpboot/xenserver
cp /mnt/boot/pxelinux/* /var/lib/tftpboot
cp /mnt/boot/vmlinuz /var/lib/tftpboot/xenserver
cp /mnt/boot/xen.gz /var/lib/tftpboot/xenserver
cp /mnt/boot/install.img /var/lib/tftpboot/xenserver
mkdir /var/lib/tftpboot/pxelinux.cfg
cat << EOF > /var/lib/tftpboot/pxelinux.cfg/default
default menu.c32
prompt 10
timeout 60

label xenserver-auto
kernel mboot.c32
append xenserver/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- xenserver/vmlinuz xencons=hvc console=hvc0 console=tty0 answerfile=http://172.28.101.203/answerfile65.xml install --- xenserver/install.img

label xenserver-manual
kernel mboot.c32
append xenserver/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- xenserver/vmlinuz xencons=hvc console=hvc0 console=tty0 install --- xenserver/install.img

label local
LOCALBOOT -1

EOF

cat << EOF > /var/www/html/answerfile65.xml
<?xml version="1.0"?>
<installation srtype="ext">
<primary-disk>sdb</primary-disk>
<guest-disk>sda</guest-disk>
<guest-disk>sdc</guest-disk>
<keymap>us</keymap>
<root-password>engine</root-password>
<source type="url">http://172.28.101.203/xs65</source>
<script stage="filesystem-populated" type="url">http://172.28.101.203/xs65ps.sh</script>
<admin-interface name="eth0" proto="dhcp"/>
<timezone>Asia/Shanghai</timezone>
</installation>

EOF

scp menu.c32 root@10.1.6.203:/var/lib/tftpboot


answerfile.xml为
[root@centos71-pxe pxelinux.cfg]# cat /home/nfs/answerfile.xml 
<?xml version="1.0"?>
<installation srtype="ext">
<primary-disk>sda</primary-disk>
<keymap>us</keymap>
<root-password>engine</root-password>
<source type="nfs">192.168.1.71:/home/mnt</source>
<admin-interface name="eth0" proto="dhcp"/>
<timezone>Asia/Shanghai</timezone>
</installation>


<?xml version="1.0"?>
<installation srtype="ext">
<primary-disk>sda</primary-disk>
<guest-disk>sdb</guest-disk>
<guest-disk>sdc</guest-disk>
<keymap>us</keymap>
<root-password>mypassword</root-password>
<source type="url">http://pxehost.example.com/XenServer/</source>
<post-install-script type="url">
http://pxehost.example.com/myscripts/post-install-script
</post-install-script>
<admin-interface name="eth0" proto="dhcp" />
<timezone>Europe/London</timezone>
</installation>

##修改install.img
cd /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy
mount /home/html/iso/XenServer-6.5.0-xenserver.org-install-cd.iso /mnt
mkdir tmp
cp /mnt/install.img tmp
cd tmp
gunzip -S install.img
cpio -ivcdu < install
sed -i "s/root_size = 4096/root_size = 20480/g" tmp/opt/xensource/installer/constants.py
rm -f install
find ./ |cpio -ocvB > install
gzip install
mv install.gz install.img
scp install.img root@10.1.6.203:/var/lib/tftpboot/xenserver
scp install.img root@10.1.6.203:/var/www/html/xs65
####
mkdir -p /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/tmp
cp /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/html/xs65/install.img.bak /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/tmp/install.img
cd /home/clouder/Cloudstack_Xenserver_auto_deploy/localdeploy/tmp
mv install.img install.gz
gunzip install.gz 
cpio -ivcdu < install
sed -i "s/root_size = 4096/root_size = 51200/g" ./opt/xensource/installer/constants.py
rm -f install
find ./ ! -name install |cpio -ocvB > install
gzip install
mv install.gz install.img
scp install.img root@10.1.6.203:/var/lib/tftpboot/xenserver
scp install.img root@10.1.6.203:/var/www/html/xs65


You can enable multipath using Xen center or by using Xen CLI (xe). Following steps list out the procedure using Xen CLI (xe):

    Enter maintenance mode: xe host-disable uuid=<host UUID>
    Enable multipath: xe host-param-set other-config:multipathing=true uuid=host_uuid
##    xe host-param-set other-config: multipathhandle=dmp uuid=host_uuid
    Release maintenance mode: # xe host-enable uuid=<host UUID>


xe pool-param-list uuid=0c9c20cc-6895-86c1-6039-32e91046813a
xe pool-param-set name-label="newpool" uuid=0c9c20cc-6895-86c1-6039-32e91046813a

xe pool-join master-address=192.168.173.107 master-password=engine master-username=root

#自动安装xenserver
vim /etc/cobbler/distro_signatures.json
vim /var/lib/cobbler/distro_signatures.json
   "xenserver650": {
    "signatures":["packages.xenserver"],
    "version_file":"^XS-REPOSITORY$",
    "version_file_regex":"^.*product=\"XenServer\" version=\"6\\.5\\.([0-9]+)\".*$",
    "kernel_arch":"xen\\.gz",
    "kernel_arch_regex":"^.*(x86_64).*$",
    "supported_arches":["x86_64"],
    "supported_repo_breeds":[],
    "kernel_file":"mboot\\.c32",
    "initrd_file":"xen\\.gz",
    "isolinux_ok":false,
    "default_kickstart":"",
    "kernel_options":"",
    "kernel_options_post":"",
    "boot_files":["install.img"]
   }
  },
mount 192.168.173.82:/home/html/iso /mnt
mount -t iso9660 -o loop /mnt/XenServer-6.5.0-xenserver.org-install-cd.iso /opt
cobbler import --name=XenServer-6.5.0 --arch=x86_64 --path=/opt

mount 192.168.173.82:/home/html/iso /mnt
mount -t iso9660 -o loop /mnt/XenServer-6.2.0-install-cd.iso /opt
cobbler import --name=XenServer-6.2.0 --arch=x86_64 --path=/opt
mkdir /var/www/cobbler/images/XenServer-6.2.0-x86_64
ln -s /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64 /var/www/cobbler/links

cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/install.img /var/www/cobbler/images/XenServer-6.2.0-x86_64
cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/vmlinuz /var/www/cobbler/images/XenServer-6.2.0-x86_64
cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/xen.gz /var/www/cobbler/images/XenServer-6.2.0-x86_64
cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/pxelinux/mboot.c32 /var/www/cobbler/images/XenServer-6.2.0-x86_64
cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/pxelinux/pxelinux.0 /var/www/cobbler/images/XenServer-6.2.0-x86_64


cobbler distro add \
--name=XenServer-6.2.0-x86_64 \
--kernel=/var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/vmlinuz \
--initrd=/var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/xen.gz \
--arch=x86_64 \
--breed=xen \
--ksmeta="tree=http://@@http_server@@/cblr/links/XenServer-6.2.0-x86_64"

cobbler distro add \
--name=XenServer-6.2.0-x86_64 \
--kernel=/var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/mboot.c32 \
--initrd=/var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/xen.gz \
--arch=x86_64 \
--breed=xen \
--ksmeta="tree=http://@@http_server@@/cblr/links/XenServer-6.2.0-x86_64"

cobbler profile add \
--name=XenServer-6.2.0-x86_64 \
--distro=XenServer-6.2.0-x86_64 \
--kickstart=/var/lib/cobbler/kickstarts/answerfile.xml


vim /var/lib/tftpboot/pxelinux.cfg/default
cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/install.img  /var/lib/tftpboot/images/XenServer-6.2.0-x86_64
cp /var/www/cobbler/ks_mirror/XenServer-6.2.0-x86_64/boot/pxelinux/mboot.c32  /var/lib/tftpboot/images/XenServer-6.2.0-x86_64
cp /var/lib/tftpboot/images/XenServer-6.2.0-x86_64/xs62.xml /var/www/cobbler/images/XenServer-6.2.0-x86_64

LABEL CentOS-7-x86_64
        kernel /images/CentOS-7-x86_64/vmlinuz
        MENU LABEL CentOS-7-x86_64
        append initrd=/images/CentOS-7-x86_64/initrd.img ksdevice=bootif lang=  kssendmac text  ks=http://10.1.6.202/cblr/svc/op/ks/profile/CentOS-7-x86_64
        ipappend 2

LABEL XenServer-6.2.0-x86_64
        kernel /images/XenServer-6.2.0-x86_64/mboot.c32
        MENU LABEL XenServer-6.2.0-x86_64
        append /images/XenServer-6.2.0-x86_64/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- /images/XenServer-6.2.0-x86_64/vmlinuz xencons=hvc console=hvc0 console=tty0 answerfile=http://10.1.6.202/images/XenServer-6.2.0-x86_64/xs62.xml -answerfile install --- /images/XenServer-6.2.0-x86_64/install.img
        ipappend 2


default XenServer-6.2.0-x86_64
label XenServer-6.2.0-x86_64
kernel mboot.c32
append xenserver/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- xenserver/vmlinuz xencons=hvc console=hvc0 console=tty0 answerfile=nfs://192.168.1.71:/home/nfs/answerfile.xml install --- xenserver/install.img


default XenServer-6.2.0-x86_64
label XenServer-6.2.0-x86_64
kernel mboot.c32
append images/XenServer-6.2.0-x86_64/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- images/XenServer-6.2.0-x86_64/vmlinuz xencons=hvc console=hvc0 console=tty0 answerfile=nfs://192.168.1.71:/home/nfs/answerfile.xml install --- images/XenServer-6.2.0-x86_64/install.img


LABEL XenServer 6.2 Manual Install
kernel mboot.c32
append xenserver62/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- xenserver62/vmlinuz xencons=hvc console=hvc0 console=tty0 --- xenserver62/install.img

LABEL XS62CN1 Xen 6.2 
kernel mboot.c32
append xenserver62/xen.gz dom0_max_vcpus=1-2 dom0_mem=752M,max:752M com1=115200,8n1 console=com1,vga --- xenserver62/vmlinuz xencons=hvc console=hvc0 console=tty0 answerfile=http://192.168.0.100/xs62cn1.xml -answerfile install --- xenserver62/install.img


<?xml version="1.0"?>
<installation srtype="ext">
        <primary-disk>sda</primary-disk>
        <keymap>uk</keymap>
        <root-password>engine</root-password>
        <source type="url">http://10.1.6.202/cblr/ks_mirror/XenServer-6.2.0-x86_64/</source>
        <admin-interface name="eth0" proto="dhcp" />
        <timezone>Etc/UTC</timezone>
        <hostname>xs62cn1.mylab.local</hostname>
</installation>


#自动部署本地存储




[root@xenserver-domhnefp ~]# yum repolist all
Loaded plugins: fastestmirror
repo id                                    repo name                    status
base/7-2.1511.el7.centos.2.10/x86_64       CentOS-7-2.1511.el7.centos.2 disabled
base-debuginfo/x86_64                      CentOS-7 - Debuginfo         disabled
base-source/7-2.1511.el7.centos.2.10       CentOS-7-2.1511.el7.centos.2 disabled
centosplus/7-2.1511.el7.centos.2.10/x86_64 CentOS-7-2.1511.el7.centos.2 disabled
centosplus-source/7-2.1511.el7.centos.2.10 CentOS-7-2.1511.el7.centos.2 disabled
extras/7-2.1511.el7.centos.2.10/x86_64     CentOS-7-2.1511.el7.centos.2 disabled
extras-source/7-2.1511.el7.centos.2.10     CentOS-7-2.1511.el7.centos.2 disabled
updates/7-2.1511.el7.centos.2.10/x86_64    CentOS-7-2.1511.el7.centos.2 disabled
updates-source/7-2.1511.el7.centos.2.10    CentOS-7-2.1511.el7.centos.2 disabled
repolist: 0


sed -i "s/$releasever/7/g" /etc/yum.repos.d/CentOS7-Base-163.repo
yum install python-simplejson
xe host-list params=software-version
xe-switch-network-backend bridge

ip a add 192.168.173.1/24 dev mybr0
iptables -t nat -A POSTROUTING -s 192.168.173.0/255.255.255.0 -o cloudbr0 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 192.168.173.0/255.255.255.0 -o cloudbr0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.173.0/255.255.255.0 -o mybr0 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 192.168.173.0/255.255.255.0 -o mybr0 -j MASQUERADE

/var/lib/cobbler/distro_signatures.json


[root@localhost network-scripts]# openssl passwd -1
Password: 
Verifying - Password: 
$1$atUjN4Z4$EY1fNEqC8VkkMJpaaj45..


systemctl stop firewalld 
systemctl disable firewalld
systemctl start tftp
systemctl start dhcpd
mount 192.168.173.82:/home/html/iso /opt
mount -t iso9660 -o loop /opt/XenServer-6.5.0-xenserver.org-install-cd.iso /mnt/
cobbler import --name=XenServer-6.5.0 --arch=x86_64 --path=/mnt
mount -t iso9660 -o loop /opt/CentOS-7-x86_64-Everything-1611.iso /mnt/
cobbler import --name=CentOS-7 --arch=x86_64 --path=/mnt


[root@localhost ~]# xe host-list params=all
uuid ( RO)                                 : 760a1e5e-c439-42f9-bf5a-480e2bb2b959
                           name-label ( RW): localhost.localdomain
                     name-description ( RW): Default install of XenServer
                   allowed-operations (SRO): VM.migrate; evacuate; provision; VM.resume; VM.start
                   current-operations (SRO): 
                              enabled ( RO): true
                    API-version-major ( RO): 2
                    API-version-minor ( RO): 3
                   API-version-vendor ( RO): XenSource
    API-version-vendor-implementation (MRO): 
                              logging (MRW): 
                suspend-image-sr-uuid ( RW): 4f26ff1b-e1f0-9670-8664-7eb085693617
                   crash-dump-sr-uuid ( RW): 4f26ff1b-e1f0-9670-8664-7eb085693617
                     software-version (MRO): product_version: 6.5.0; product_version_text: 6.5; product_version_text_short: 6.5; platform_name: XCP; platform_version: 1.9.0; product_brand: XenServer; build_number: 90233c; hostname: rivvidu-2; date: 2014-12-09; dbv: 2015.0101; xapi: 1.3; xen: 4.4.1-xs90192; linux: 3.10.0+2; xencenter_min: 2.3; xencenter_max: 2.3; network_backend: openvswitch; xs:main: XenServer Pack, version 6.5.0, build 90233c; xcp:main: Base Pack, version 1.9.0, build 90233c; xs:xenserver-transfer-vm: XenServer Transfer VM, version 6.5.0, build 90158c
                         capabilities (SRO): xen-3.0-x86_64; xen-3.0-x86_32p; hvm-3.0-x86_32; hvm-3.0-x86_32p; hvm-3.0-x86_64; 
                         other-config (MRW): iscsi_iqn: iqn.2017-11.com.example:84d11aab; agent_start_time: 1510282797.; boot_time: 1510282722.
                             cpu_info (MRO): cpu_count: 1; socket_count: 1; vendor: GenuineIntel; speed: 3067.054; modelname: Intel Core i7 9xx (Nehalem Class Core i7); family: 6; model: 26; stepping: 3; flags: fpu de tsc msr pae mce cx8 apic sep mca cmov pat clflush mmx fxsr sse sse2 ss syscall nx lm constant_tsc rep_good nopl pni vmx ssse3 cx16 sse4_1 sse4_2 popcnt hypervisor lahf_lm tpr_shadow vnmi flexpriority ept; features: 80ba2221-0f8bfbff-00000001-28100800; features_after_reboot: 80ba2221-0f8bfbff-00000001-28100800; physical_features: 80ba2221-0f8bfbff-00000001-28100800; maskable: full
                         chipset-info (MRO): iommu: false
                             hostname ( RO): localhost.localdomain
                              address ( RO): 10.1.6.125
                supported-bootloaders (SRO): pygrub; eliloader
                                blobs ( RO): 
                      memory-overhead ( RO): 158556160
                         memory-total ( RO): 1073336320
                          memory-free ( RO): 135045120
                 memory-free-computed ( RO): <expensive field>
                    host-metrics-live ( RO): true
                              patches (SRO): 
                        ha-statefiles ( RO): 
                     ha-network-peers ( RO): 
                   external-auth-type ( RO): 
           external-auth-service-name ( RO): 
          external-auth-configuration (MRO): 
                              edition ( RO): free
                       license-server (MRO): address: localhost; port: 27000
                        power-on-mode ( RO): 
                      power-on-config (MRO): 
                       local-cache-sr ( RO): 4f26ff1b-e1f0-9670-8664-7eb085693617
                                 tags (SRW): 
                   guest_VCPUs_params (MRW): 


cloudmonkey register template hypervisor=XenServer zoneid=9abe5610-e9e2-41d7-9523-5869f88070e6 format=vhd name=centos7 displaytext=test1 ispublic=true ostypeid=f0d26901-a57b-11e6-bae0-6ed00c427d9f url=http://192.168.173.82/index/xenservertemplate/centos72.vhd passwordenabled=true
