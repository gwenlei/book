/home/code/git/packer-centos-7
/home/newpackerdir/packer build --only=virtualbox-iso centos72.json
vagrant box add centos72 /home/code/git/packer-centos-7/builds/virtualbox-centos72.box


curl -u 'gwenlei' https://api.github.com/user/repos -d '{"name":"docker-vm"}'
git clone https://github.com/gwenlei/docker-vm.git
ansible-galaxy init docker-vm --force


ssh vagrant@127.0.0.1 -p2222

http://mirrors.aliyun.com/docker-engine/yum/repo/main/centos/7/Packages/
https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.12.2-1.el7.centos.noarch.rpm
https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.12.2-1.el7.centos.x86_64.rpm
wget http://192.168.0.82/downloads/docker-1.12.2.tgz
wget http://192.168.0.82/downloads/docker.service
tar cvf docker-1.12.2.tgz
mv -f docker.service /usr/lib/systemd/system/docker.service
cd docker && mv -f * /usr/bin/

ifconfig enp0s8 192.168.123.2/24


ansible-playbook -i host main.yml
ansible-playbook -i host2 main.yml


https://yum.dockerproject.org/repo/main/centos/7/Packages/


echo "==> Disabling selinux"
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
sed -i s/SELINUX=permissive/SELINUX=disabled/g /etc/selinux/config


yum install /tmp/docker-engine-1.12.2-1.el7.centos.x86_64.rpm /tmp/docker-engine-selinux-1.12.2-1.el7.centos.noarch.rpm


wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u11-b12/jdk-8u11-linux-x64.tar.gz
# tar -zxvf jdk-8u11-linux-x64.tar.gz
 
#  mv jdk1.8.0_11/ /usr/
# /usr/sbin/alternatives --install /usr/bin/java java /usr/jdk1.8.0_11/bin/java 2
 
# /usr/sbin/alternatives --config java

# export JAVA_HOME=/usr/jdk1.8.0_11
# export JRE_HOME=/usr/jdk1.8.0_11/jre
# export PATH=$JAVA_HOME/bin:$PATH

/etc/profile.d/jdk18.sh
scp -p2222 jdk18.sh root@127.0.0.1:/etc/profile.d/jdk18.sh 

scp root@192.168.0.82:/home/Oneclick/OnecloudPlaybooks/Docker-vm/docker-vm/templates/jdk18.sh /etc/profile.d/

/opt/jdk1.8.0_74/jre

java –version

http://www.itzgeek.com/how-tos/linux/centos-how-tos/how-to-install-java-sdk-1-8-on-rhel-7-centos-7.html


cp -r /home/Oneclick/OnecloudPlaybooks/Docker-vm /home/CleanBuildXenServer/OnecloudPlaybooks



service nfs-server start

http://192.168.0.82/static/result/20161028174753/output/CentOS7-2.vhd
cp /home/html/downloads/CentOS7-2.vhd   /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8992.vhd
cp /home/html/downloads/CentOS7-2.vhd   /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8995.vhd
cp /home/html/downloads/CentOS7-2\(1\).vhd   /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8993.vhd
cp /home/img/centos72docker.vhd  /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8994.vhd
cp /home/tmp/Centos64_aug19.vhd  /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8996.vhd

cp /home/CleanBuildXenServer/box/vhd/centos72-nocm-2.0.15  /home/html/downloads/c646e6b8-5b3c-6fc7-8aee-d787041b8d9f/1c7004a1-fbc4-4871-9c23-b312994f8997.vhd

cp /home/CleanBuildXenServer/box/vhd/centos72-nocm-2.0.15  /home/html/downloads/eef391d2-e726-fc28-fe1f-98f4d88be76d/1c7004a1-fbc4-4871-9c23-b312994f8998.vhd

qemu-img create -f qcow2 /home/img/centos72docker.qcow2 -b /home/code/mycode/go/src/main/static/result/20161031160006/output/CentOS7-2
qemu-img convert -O vpc /home/img/centos72docker.qcow2 /home/img/centos72docker.vhd

10.0.2.15

to install easy_install:

    sudo yum install python-setuptools python-setuptools-devel

to install pip:

    sudo easy_install pip

yum install -y openssl-devel
yum install gcc python-devel
pip install -U setuptools 
pip install ansible==2.1.0.0

ansible 192.168.0.82 -i host -m ping


systemctl disable firewalld.service
systemctl stop firewalld.service

yum install vim wget

ln -s /etc/yum.repos.d /home/html
wget http://192.168.0.82/yum.repos.d/epel.repo
yum install sshpass
yum install -y ansible


wget http://192.168.0.82/iso/xs-tools-6.2.0-7.iso
mount -o loop xs-tools-6.2.0-7.iso /mnt
yum install xe-guest-utilities-6.2.0-1159.x86_64.rpm xe-guest-utilities-xenstore-6.2.0-1159.x86_64.rpm


yum install -y -q wget
yum install -y -q expect
#wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
wget http://192.168.0.82/downloads/cloud-set-guest-password.in
mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
chmod +x /etc/init.d/cloud-set-guest-password
chkconfig --add cloud-set-guest-password
yum update openssh*
yum update pam
yum install -y acpid

yum upgrade
yum update

ssh root@127.0.0.1 -p2222

chkconfig NetworkManager off

/home/html/downloads/CentOS7-2.vhd

ln -s /root/rpmbuild/RPMS /home/html

yum install /root/rpmbuild/RPMS/x86_64/cstemplate-0.1-1.el7.centos.x86_64.rpm
http://192.168.0.82/RPMS/x86_64/cstemplate-0.1-1.el7.centos.x86_64.rpm

cstemplate register centos72docker http://192.168.0.82/downloads/CentOS7-2.vhd -o centos%7

vim /etc/ssh/sshd_config
UseDNS no
service sshd restart

xenserver虚拟机网络设置
ip address add 192.168.10.124/16 dev eth0
 ip route add default via  192.168.0.176  dev eth0
ip route del default 

vi /etc/resolv.conf
search localdomain
nameserver 223.5.5.5
nameserver 180.76.76.76


windows2008r2用virtualbox来做镜像再转vhd
其他系统要用qemu来做镜像再转vhd


https://wiki.centos.org/HowTos/Xen/InstallingCentOSDomU
install
url --url http://mirror.centos.org/centos/5/os/i386
lang en_US.UTF-8
network --device eth0 --bootproto dhcp
# Bogus password, change to something sensible!
rootpw bogus
firewall --enabled --port=
authconfig --enableshadow --enablemd5
selinux --enforcing −−port=22:tcp
timezone --utc Europe/Amsterdam
bootloader --location=mbr --driveorder=xvda --append="console=xvc0"
reboot

# Partitioning
clearpart --all --initlabel --drives=xvda
part /boot --fstype ext3 --size=100 --ondisk=xvda
part pv.2 --size=0 --grow --ondisk=xvda
volgroup VolGroup00 --pesize=32768 pv.2
logvol / --fstype ext3 --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=256 --grow --maxsize=512

%packages
@core
