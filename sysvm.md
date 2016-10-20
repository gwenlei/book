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


 nohup bash /opt/cloud/bin/vpc_passwd_server $ip >/dev/null 2>&1 &
 python /opt/cloud/bin/passwd_server_ip.py $addr >/dev/null 2>/dev/null
  python /opt/cloud/bin/passwd_server_ip.py $ip >/dev/null 2>/dev/null
systemvm/patches/debian/config/opt/cloud/bin/vpc_guestnw.sh
core/src/com/cloud/agent/resource/virtualnetwork/VRScripts.java
/etc/init.d/cloud-early-config {start|stop}
service cloud-passwd-srvr start


root@r-4-VM:~# ps -ef|grep python
root      2391  2388  0 03:53 ?        00:00:00 python /opt/cloud/bin/passwd_server_ip.py 10.0.1.1
root      3592     1  0 03:54 ?        00:00:00 python /opt/cloud/bin/baremetal-vr.py
root      3611  3592  0 03:54 ?        00:00:00 /usr/bin/python /opt/cloud/bin/baremetal-vr.py

systemvm/patches/debian/config/opt/cloud/bin/patchsystemvm.sh:   echo "cloud cloud-passwd-srvr apache2 nfs-common portmap keepalived conntrackd" > /var/cache/cloud/disabled_svcs

