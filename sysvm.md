#build host ubuntu with virtual box
```
root:'engine!@#'@192.168.1.69
http://bhaisaab.org/logs/building-systemvms/
```
## Prepare environment and necessary software packages
```
sudo apt-get install curl bzip2 python-dev gcc g++ build-essential libssl-dev uuid-dev zlib1g-dev libncurses5-dev libx11-dev python-dev iasl bin86 bcc gettext libglib2.0-dev libyajl-dev libc6-dev-i386 virtualbox faketime openjdk-7-jdk git
mkdir -p /root/sysvm
cd /root/sysvm
wget -q http://bits.xensource.com/oss-xen/release/4.2.0/xen-4.2.0.tar.gz
tar -xzf xen-4.2.0.tar.gz
cd xen-4.2.0/tools/
wget https://github.com/citrix-openstack/xenserver-utils/raw/master/blktap2.patch -qO - | patch -p0
./configure --disable-monitors --disable-ocamltools --disable-rombios --disable-seabios
cd blktap2/vhd
make -j 8
sudo make install
```

## Prepare RVM / bundle / bundler
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
export PATH=~/.rvm/bin:$PATH
mkdir -p ~/.rvm/bin
rvm requirements run
rvm install 1.9.3
rvm use ruby-1.9.3
gem sources --remove https://rubygems.org/
gem sources -a https://ruby.taobao.org/
gem install bundler
gem install bundle
```
## Prepare build scripts from cloudstack source code
```
cd /root/sysvm
wget http://apache.arvixe.com//cloudstack/releases/4.5.1/apache-cloudstack-4.5.1-src.tar.bz2
bzip2 -d apache-cloudstack-4.5.1-src.tar.bz2
tar xf apache-cloudstack-4.5.1-src.tar
```
copy Gemfile to /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/
```
source 'http://ruby.taobao.org' 
gem 'veewee', :git => 'https://github.com/jedi4ever/veewee.git' 
gem 'em-winrm' 
require 'rubygems' 
require 'bundler' 
gem 'net-ssh',  '=2.9.2' 
gem 'fog-google',  '=0.1.0'
```
copy geminstall.sh to /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/
```
gem install CFPropertyList -v '2.3.2' 
gem install Platform -v '0.4.0' 
gem install ansi -v '1.3.0' 
gem install builder -v '3.2.2' 
gem install ffi -v '1.9.10' 
gem install childprocess -v '0.5.7' 
gem install diff-lcs -v '1.2.5' 
gem install eventmachine -v '1.0.8' 
gem install mixlib-log -v '1.6.0' 
gem install uuidtools -v '2.1.5' 
gem install gssapi -v '1.2.0' 
gem install gyoku -v '1.3.1' 
gem install httpclient -v '2.6.0.1' 
gem install little-plugger -v '1.1.4' 
gem install multi_json -v '1.11.2' 
gem install logging -v '1.8.2' 
gem install nori -v '2.6.0' 
gem install rubyntlm -v '0.4.0' 
gem install winrm -v '1.3.4' 
gem install em-winrm -v '0.7.0' 
gem install excon -v '0.45.4' 
gem install fission -v '0.5.0' 
gem install formatador -v '0.2.5' 
gem install mime-types -v '1.25.1' 
gem install net-ssh -v 2.9.2 
gem install net-scp -v '1.2.1' 
gem install fog-core -v '1.32.1' 
gem install fog-json -v '1.0.2' 
gem install ipaddress -v '0.8.0' 
gem install xml-simple -v '1.1.5' 
gem install fog-aliyun -v '0.0.10' 
gem install mini_portile -v '0.6.2' 
gem install nokogiri -v '1.6.6.2' 
gem install fog-xml -v '0.1.2' 
gem install fog-atmos -v '0.1.0' 
gem install fog-aws -v '0.7.6' 
gem install inflecto -v '0.0.2' 
gem install fog-brightbox -v '0.9.0' 
gem install fog-dynect -v '0.0.2' 
gem install fog-ecloud -v '0.3.0' 

gem install fog-google -v '0.1.0' 
gem install fog-local -v '0.2.1' 
gem install fog-powerdns -v '0.1.1' 
gem install fog-profitbricks -v '0.0.5' 
gem install fog-radosgw -v '0.0.4' 
gem install fog-riakcs -v '0.1.0' 
gem install fog-sakuracloud -v '1.3.3' 
gem install fog-serverlove -v '0.1.2' 
gem install fog-softlayer -v '1.0.0' 
gem install fog-storm_on_demand -v '0.1.1' 
gem install fog-terremark -v '0.1.0' 
gem install fog-vmfusion -v '0.1.0' 
gem install fog-voxel -v '0.1.0' 
gem install fog -v '1.34.0' 
gem install gem-content -v '1.0.0' 
gem install posix-spawn -v '0.3.11' 
gem install grit -v '2.5.0' 

gem install highline -v 1.7.8 
gem install i18n -v  0.7.0 
gem install json -v  1.8.3 
gem install open4 -v  1.3.4 
gem install os -v  0.9.6 
gem install popen4 -v 0.1.2 
gem install progressbar -v  0.21.0 
gem install ruby-vnc -v  1.0.1 
gem install thor 0.19.1 
gem install to_slug 1.0.8
```
```
cd /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/ [press y]
mkdir -p /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/iso
copy VBoxGuestAdditions_4.3.10.iso debian-7.8.0-amd64-netinst.iso debian-7.5.0-i386-netinst.iso  VBoxGuestAdditions_4.3.26.iso to /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/iso
--- http://debian.mirror.exetel.com.au/debian-cd/7.5.0/i386/iso-cd/debian-7.5.0-i386-netinst.iso
--- http://download.virtualbox.org/virtualbox/4.3.26/VBoxGuestAdditions_4.3.26.iso
--- http://cdimage.debian.org/cdimage/archive/7.8.0/amd64/iso-cd/debian-7.8.0-amd64-netinst.iso
--- http://download.virtualbox.org/virtualbox/4.3.10/VBoxGuestAdditions_4.3.10.iso
```
## fix the bug of Convert.java and compile it
```
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
cd /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/convert
vi Convert.java # add this line into the file "import javax.xml.transform.TransformerException;"
javac Convert.java
cd /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/
sed -i 's/https:\/\/rubygems.org/http:\/\/ruby.taobao.org/g' /root/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/Gemfile
```
## Start building the system vm template
```
sh build.sh systemvm64template
```

## Enhancement
最终镜像在/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/dist


##注意事项：
virtualbox版本相关的iso先拷贝到相关目录，可以避免重复下载。
cp /usr/share/virtualbox/VBoxGuestAdditions.iso /home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/iso/VBoxGuestAdditions_5.0.14.iso

##最后的格式转换命令跟新版的virtualbox不一样，要手工转换。
vboxmanage internalcommands converttoraw -format vdi /home/img/systemvm64template/systemvm64template1.vdi raw.img
qemu-img convert -o compat=0.10 -f raw -c -O qcow2 raw.img systemvm64template-unknown-kvm.qcow2
bzip2 systemvm64template-unknown-kvm.qcow2

##windows密码重置修改脚本
只要更新cloudstack-agent的/usr/share/cloudstack-common/vms/systemvm.iso,不需要更新模版。
需要修改的文件/home/sysvm/apache-cloudstack-4.5.1-src/systemvm/patches/debian/config/opt/cloud/bin/passwd_server_ip.py
```
120         elif requestType == 'saved_password':
121             #removePassword(clientAddress)
122             savePasswordFile()
```
重新制作systemvm.iso
将cloudstack-agent的/usr/share/cloudstack-common/vms/systemvm.iso下载到本地，挂载到某空目录，修改相关脚本后，重新制成iso,放回cloudstack-agent重新启动，systemvms全部destroy，重启cloudstack-agent即可。
```
mount -o loop systemvm.iso /mnt/test
mkdir /home/systemvmiso
cp /mnt/test/* /home/systemvmiso
mkdir /home/systemvmscript
cp /mnt/test/cloud-scripts.tgz /home/systemvmscript
cd /home/systemvmscript
tar xvf cloud-scripts.tgz
sed -i "s/removePassword(clientAddress)/#removePassword(clientAddress)/g" /home/systemvmscript/opt/cloud/bin/passwd_server_ip.py
tar cvf cloud-scripts.tar *
gzip -c cloud-scripts.tar > cloud-scripts.tgz
mv -f cloud-scripts.tgz /home/systemvmiso/
mkisofs -o systemvm.iso /home/systemvmiso/*
scp systemvm.iso root@10.1.6.30:/usr/share/cloudstack-common/vms
scp systemvm.iso root@10.1.6.20:/usr/share/cloudstack-common/vms
```
登录vr，检查文件是否已经改变。
```
ssh -i ~/.ssh/id_rsa.cloud -p3922 169.254.2.5
vi /opt/cloud/bin/passwd_server_ip.py
```
安装faketime
```
yum install -y libfaketime
```

### VR热备会造成eth0有两个IP，同时产生两个密码进程，竞争侦听8080端口导致报文丢失。(杀掉非网关进程，只保留一个)
### vr 服务类型勾选sourcenat 选择redundancy 热备每个网络会产生两个vr
 nohup bash /opt/cloud/bin/vpc_passwd_server $ip >/dev/null 2>&1 &
 python /opt/cloud/bin/passwd_server_ip.py $addr >/dev/null 2>/dev/null
  python /opt/cloud/bin/passwd_server_ip.py $ip >/dev/null 2>/dev/null
systemvm/patches/debian/config/opt/cloud/bin/vpc_guestnw.sh
core/src/com/cloud/agent/resource/virtualnetwork/VRScripts.java
systemvm/patches/debian/config/opt/cloud/bin/vpc_passwd_server
/etc/init.d/cloud-early-config {start|stop}
service cloud-passwd-srvr start

日志文件
/var/log/messages : password
密码文件
/var/cache/cloud/password*

root@r-4-VM:~# ps -ef|grep python
root      2391  2388  0 03:53 ?        00:00:00 python /opt/cloud/bin/passwd_server_ip.py 10.0.1.1
root      3592     1  0 03:54 ?        00:00:00 python /opt/cloud/bin/baremetal-vr.py
root      3611  3592  0 03:54 ?        00:00:00 /usr/bin/python /opt/cloud/bin/baremetal-vr.py

systemvm/patches/debian/config/opt/cloud/bin/patchsystemvm.sh:   echo "cloud cloud-passwd-srvr apache2 nfs-common portmap keepalived conntrackd" > /var/cache/cloud/disabled_svcs


cp /usr/share/virtualbox/VBoxGuestAdditions.iso /home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/iso/VBoxGuestAdditions_5.1.4.iso


++ sed -i 's/removePassword(clientAddress)/#removePassword(clientAddress)/g' /opt/cloudstack-4.5-e731c70/systemvm/patches/debian/config/opt/cloud/bin/passwd_server_ip.py

代码是从网上下载到虚拟机，修改脚本要用命令修改或者直接下载
/home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/definitions/systemvm64template/postinstall.sh
configure_services() {
...
  wget --no-check-certificate $snapshot_url -O cloudstack.tar.gz
  tar -zxvf cloudstack.tar.gz --wildcards cloudstack*/systemvm
  sed -i "s/removePassword(clientAddress)/#removePassword(clientAddress)/g" $snapshot_dir/systemvm/patches/debian/config/opt/cloud/bin/passwd_server_ip.py
  wget http://192.168.0.82/downloads/ipsectunnel.sh -O $snapshot_dir/systemvm/patches/debian/config/opt/cloud/bin/ipsectunnel.sh
  chmod 777 $snapshot_dir/systemvm/patches/debian/config/opt/cloud/bin/ipsectunnel.sh




[root@pc134 bin]# diff ipsectunnel.sh ipsectunnel.sh.bak
161,175d160
<     if [ $vpnmodel -eq 1 ]
<     then
<         sudo echo "  aggrmode=yes" >> $vpnconffile
<     fi
< 
<     if [ $hflag -eq 1 ]
<     then
<         sudo echo "  leftid=$lefthostid" >> $vpnconffile
<     fi
< 
<     if [ $Hflag -eq 1 ]
<     then
<         sudo echo "  rightid=$righthostid" >> $vpnconffile
<     fi
< 
235,237d219
< Mflag=0
< hflag=0
< Hflag=0
239c221
< while getopts 'ADSpcl:M:h:H:n:g:r:N:e:i:t:T:s:d:' OPTION
---
> while getopts 'ADSpcl:n:g:r:N:e:i:t:T:s:d:' OPTION
242,250d223
<   M)    Mflag=1
<         vpnmodel="$OPTARG"
<         ;;
<   h)    hflag=1
<         lefthostid="$OPTARG"
<         ;;
<   H)    Hflag=1
<         righthostid="$OPTARG"
<         ;;


    mount -o loop systemvm.iso /mnt/test
    mkdir /home/systemvmiso
    cp /mnt/test/* /home/systemvmiso
    mkdir /home/systemvmscript
    cp /mnt/test/cloud-scripts.tgz /home/systemvmscript
    cd /home/systemvmscript
    tar xvf cloud-scripts.tgz
    ###
    修改相应的脚本例子
    sed -i
    "s/removePassword(clientAddress)/#removePassword(clientAddress)/g"
    /home/systemvmscript/opt/cloud/bin/passwd_server_ip.py
    ###
    tar cvf cloud-scripts.tar *
    gzip -c cloud-scripts.tar > cloud-scripts.tgz
    mv -f cloud-scripts.tgz /home/systemvmiso/
    mkisofs -o systemvm.iso /home/systemvmiso/*
    scp systemvm.iso root@cloudstackmanagement:/usr/share/cloudstack-common/vms
    scp systemvm.iso root@cloudstackagent:/usr/share/cloudstack-common/vms

在XenServer主机的/opt/xensource/packages/iso下有个systemvm.iso文件，这个文件应该是由 CloudStack从管理机复制过来的，在CloudStack的管理机上的/usr/share/cloudstack-common/vms目录下 有该文件，可能是由于XenServer主机多次重复使用，没有重新安装，造成了这个文件没有正确复制。 解决： 1.进入XenServer主机 2.执行xe host-param-clear param-name=tags uuid=<uuid of the XS host> 3.重启CloudStack 4.销毁ssvm

##20170426 bundle迷之失踪，重装
```
cd /home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance
gem install bundler 
gem install bundle 
sh build.sh systemvm64template

##网站源码迷之失踪，修改脚本下载本地源码。
/home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/definitions/systemvm64template/postinstall.sh
/home/sysvm/apache-cloudstack-4.5.1-src/systemvm/patches/debian/config/opt/cloud/bin/passwd_server_ip.py

ln -s /home/sysvm/apache-cloudstack-4.5.1-src.tar /home/html
gzip apache-cloudstack-4.5.1-src.tar
wget http://192.168.0.82/apache-cloudstack-4.5.1-src.tar

wget --no-check-certificate http://192.168.0.82/apache-cloudstack-4.5.1-src.tar.gz -O cloudstack.tar.gz

++ mkdir -p /root/.ssh
++ mkdir -p /var/lib/haproxy
++ snapshot_url='https://git-wip-us.apache.org/repos/asf?p=cloudstack.git;a=snapshot;h=refs/heads/4.5;sf=tgz'
++ snapshot_dir='/opt/cloudstack*'
++ cd /opt
++ wget --no-check-certificate 'https://git-wip-us.apache.org/repos/asf?p=cloudstack.git;a=snapshot;h=refs/heads/4.5;sf=tgz' -O cloudstack.tar.gz
--2017-04-26 02:32:52--  https://git-wip-us.apache.org/repos/asf?p=cloudstack.git;a=snapshot;h=refs/heads/4.5;sf=tgz
Resolving git-wip-us.apache.org (git-wip-us.apache.org)... 140.211.11.23
Connecting to git-wip-us.apache.org (git-wip-us.apache.org)|140.211.11.23|:443... connected.
HTTP request sent, awaiting response... 404 Not Found
2017-04-26 02:32:57 ERROR 404: Not Found.



wget --no-check-certificate 'https://git-wip-us.apache.org/repos/asf?p=cloudstack.git;a=snapshot;h=refs/heads/4.5;sf=tgz' -O cloudstack.tar.gz

https://github.com/apache/cloudstack.git

wget --no-check-certificate 'https://github.com/apache/cloudstack.git;a=snapshot;h=refs/heads/4.5;sf=tgz' -O cloudstack.tar.gz

```
  ##snapshot_url="https://git-wip-us.apache.org/repos/asf?p=cloudstack.git;a=snapshot;h=refs/heads/4.5;sf=tgz"
  ##snapshot_dir="/opt/cloudstack*"
  ##cd /opt
  ##wget --no-check-certificate $snapshot_url -O cloudstack.tar.gz
  ##tar -zxvf cloudstack.tar.gz --wildcards cloudstack*/systemvm


  snapshot_url="http://192.168.0.82/apache-cloudstack-4.5.1-src.tar.gz"
  snapshot_dir="/opt/apache-cloudstack*"
  cd /opt
  wget --no-check-certificate $snapshot_url -O cloudstack.tar.gz
  tar -zxvf cloudstack.tar.gz --wildcards apache-cloudstack*/systemvm
```

+ vboxmanage sharedfolder remove systemvm64template --name veewee-validation
VBoxManage: error: The machine 'systemvm64template' is already locked for a session (or being unlocked)
VBoxManage: error: Details: code VBOX_E_INVALID_OBJECT_STATE (0x80bb0007), component MachineWrap, interface IMachine, callee nsISupports
VBoxManage: error: Context: "LockMachine(a->session, LockType_Write)" at line 1080 of file VBoxManageMisc.cpp

+ vboxmanage clonehd 3c537193-1d14-4f85-9740-7e337e8d8b53 systemvm64template-unknown-vmware.vmdk --format VMDK
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...
Progress state: NS_ERROR_INVALID_ARG
VBoxManage: error: Failed to clone medium
VBoxManage: error: Cannot register the hard disk '/home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/systemvm64template-unknown-vmware.vmdk' {e9c26ec2-b822-4387-bd4d-6edd2c645674} because a hard disk '/home/sysvm/apache-cloudstack-4.5.1-src/tools/appliance/systemvm64template-unknown-vmware.vmdk' with UUID {58b2ecd3-163a-48d6-9ad7-5cf2603c8179} already exists
VBoxManage: error: Details: code NS_ERROR_INVALID_ARG (0x80070057), component VirtualBoxWrap, interface IVirtualBox
VBoxManage: error: Context: "RTEXITCODE handleCloneMedium(HandlerArg*)" at line 928 of file VBoxManageDisk.cpp

```


select max(id) from cloud.vm_template where type = 'SYSTEM' and hypervisor_type = 'XenServer' and removed is null;


#在线更新systemvm template
## 1.systemvm模板放在内网http://192.168.215.15/uploads/iaastest20160819/systemvm64template-4.5-xen-20170426.vhd.bz2
## 2.登陆cloudstack-management后台执行以下命令
```
service cloudstack-management stop
mount /mnt <二级存储的nfsip:dir>
/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /mnt -u http://192.168.215.15/uploads/iaastest20160819/systemvm64template-4.5-xen-20170426.vhd.bz2 -h xenserver -F
service cloudstack-management start
umount /mnt
```
## 3.登陆cloudstack页面删除二级存储系统虚拟机，等待新的二级存储系统虚拟机自动创建。
## 4.创建新的网络，新的实例，检查重置密码功能是否正常使用，用户修改密码重启能用自己设置的密码正常登陆。
## 5.更新前已存在的网络VR，手工更新脚本，页面重启VR，再重启实例。
```
ssh -i ~/.ssh/id_rsa.cloud -p3922 <VR的ip:169.254.x.x>
sed -i "s/#removePassword(clientAddress)/removePassword(clientAddress)/g" /opt/cloud/bin/passwd_server_ip.py
```
## 6.手工修改数据库触发自动更新缓存
参考网站http://cloud.kelceydamage.com/cloudfire/blog/2013/10/08/conquering-the-cloudstack-4-2-dragon-kvm/
https://wenku.baidu.com/view/c8d882da6294dd88d0d26b39.html


UPDATE template_store_ref SET install_path='更新后的路径' WHERE template_id='3';

UPDATE template_spool_ref SET download_pct='0',download_state='NOT_DOWNLOADED',state='NULL',local_path='NULL',install_path='NULL',template_size='0' WHERE template_id='3';
service cloudstack-management restart

##更新systemvm.iso
```
mount -o loop /home/code/book/sysvm/0503iso/systemvm.iso /mnt
mkdir /home/code/book/sysvm/systemvmiso0511
cp /mnt/* /home/code/book/sysvm/systemvmiso0511
mkdir /home/code/book/sysvm/systemvmscript0511
cp /mnt/cloud-scripts.tgz /home/code/book/sysvm/systemvmscript0511
cd /home/code/book/sysvm/systemvmscript0511
tar xvf cloud-scripts.tgz
sed -i "s/#removePassword(clientAddress)/removePassword(clientAddress)/g" /home/code/book/sysvm/systemvmscript0511/opt/cloud/bin/passwd_server_ip.py
rm -f cloud-scripts.tgz
tar cvf cloud-scripts.tar *
gzip -c cloud-scripts.tar > cloud-scripts.tgz
mv -f cloud-scripts.tgz /home/code/book/sysvm/systemvmiso0511/
mkdir /home/code/book/sysvm/newiso0511
mkisofs -o /home/code/book/sysvm/newiso0511/systemvm.iso /home/code/book/sysvm/systemvmiso0511/*
scp systemvm.iso root@10.1.6.30:/usr/share/cloudstack-common/vms
scp systemvm.iso root@10.1.6.20:/usr/share/cloudstack-common/vms
umount /mnt
```
在XenServer主机的/opt/xensource/packages/iso下有个systemvm.iso文件，这个文件应该是由 CloudStack从管理机复制过来的，在CloudStack的管理机上的/usr/share/cloudstack-common/vms目录下 有该文件，可能是由于XenServer主机多次重复使用，没有重新安装，造成了这个文件没有正确复制。 解决： 1.进入XenServer主机 2.执行xe host-param-clear param-name=tags uuid=<uuid of the XS host> 3.重启CloudStack 4.销毁ssvm





##vmware
系统虚拟机中jar包位置
/usr/local/cloud/systemvm
cloud-plugin-hypervisor-vmware-4.5.1.jar vmware-vim25-5.1.jar cloud-vmware-base-4.5.1.jar
