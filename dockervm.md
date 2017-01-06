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
cp /home/img/dockervm/centos72docker.vhd  /home/html/downloads/eef391d2-e726-fc28-fe1f-98f4d88be76d/1c7004a1-fbc4-4871-9c23-b312994f8999.vhd
cp /home/html/downloads/eef391d2-e726-fc28-fe1f-98f4d88be76d/1c7004a1-fbc4-4871-9c23-b312994f8999.vhd /home/img/dockervm/centos72docker-1104.vhd
cp /home/html/downloads/eef391d2-e726-fc28-fe1f-98f4d88be76d/611bb242-952e-4b17-828c-7503d493bd24.vhd /home/img/dockervm/centos72docker-1104w.vhd
cp /home/html/downloads/eef391d2-e726-fc28-fe1f-98f4d88be76d/611bb242-952e-4b17-828c-7503d493bd24.vhd /home/img/dockervm/centos72docker-1111.vhd

scp /home/html/downloads/eef391d2-e726-fc28-fe1f-98f4d88be76d/611bb242-952e-4b17-828c-7503d493bd24.vhd root@192.168.0.169:/home/clouder/img/vhd/6343a8bd-f779-5ca5-4063-c2a022bb7331
scp root@192.168.0.169:/home/clouder/img/vhd/6343a8bd-f779-5ca5-4063-c2a022bb7331/611bb242-952e-4b17-828c-7503d493bd24.vhd /home/img/dockervm/centos72docker-1221.vhd

host=$(xe vm-list params=resident-on name-label=${vm} | grep resident-on | awk '{print $NF}')
dom=$(xe vm-list params=dom-id name-label=${vm} | grep dom-id | awk '{print $NF}')
port=$(xenstore-read /local/domain/${dom}/console/vnc-port)
ip=$(xe pif-list management=true params=IP host-uuid=${host} | awk '{print $NF}')
 
echo "run this on laptop and connect via vnc to localhost:${port}"
echo "--> ssh -L ${port}:localhost:${port} root@${ip}"

vhd直接转换成qcow2
qemu-img convert -O qcow2 /home/img/dockervm/centos72docker-1111.vhd /home/img/dockervm/centos72docker-1111.qcow2
用virt-manager启动修改启动文件
sed -i "s/vmlinuz.*/& net.ifnames=0/g" /boot/grub2/grub.cfg

cd /home/code/cstemplate-0.1/src/main  
./cstemplate -i cstemplate.ini register centos72docker http://192.168.0.82/dockervm/centos72docker-1104.vhd
Password of new VM centos72dockervm is  rE3uaw
go run cstemplate.go -i cstemplate.ini register centos72base http://192.168.0.82/dockervm/centos72base210.vhd

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
route add default gw 192.168.0.176
ifconfig eth0 up 
vi /etc/sysconfig/network-scripts/ifcfg-eth0
ONBOOT=yes

route add -net 172.16.0.0 netmask 255.255.0.0 gw 192.168.0.200
route add -net 172.16.0.0/16 gw 192.168.0.200

vi /etc/resolv.conf
search localdomain
nameserver 223.5.5.5
nameserver 180.76.76.76



docker pull docker.io/registry

systemctl list-unit-files

只能用手工制作镜像，packer制作的centos72 vhd不能启动
windows2008r2用virtualbox来做镜像再转vhd
其他系统要用qemu来做镜像再转vhd


ubuntu16.04 install docker-engine 1.12.0 experimental
### 1.12.0~rc2? 
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/experimental/internet | sh



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

##查询xenserver虚机IP
ssh root@192.168.0.169
virsh start xenserver65
virsh net-dhcp-leases default
##登陆xenserver启动dockervm,查询终端号
ssh root@192.168.122.161
xe vm-start uuid=41b606b0-63e4-65ff-c2a2-5f6277e83b8b
xe vm-list uuid=41b606b0-63e4-65ff-c2a2-5f6277e83b8b params=all
xenstore-read /local/domain/1/console/vnc-port
##设置ssh转发端口
ssh -L 5902:localhost:5902 root@192.168.122.161
##vnc打开终端
ssh root@192.168.0.169 -X
vncviewer localhost:5902
