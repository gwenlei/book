yum upgrade -y 
yum update -y 

yum install -y -q wget
yum install -y -q expect
#wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
wget http://192.168.0.82/downloads/cloud-set-guest-password.in -O /etc/init.d/cloud-set-guest-password
chmod +x /etc/init.d/cloud-set-guest-password
chkconfig --add cloud-set-guest-password
yum update -y openssh*
yum update -y pam
yum install -y acpid
yum install -y vim net-tools

sed -i "s/^.*UseDNS.*/UseDNS no/" /etc/ssh/sshd_config


echo "==> Disabling selinux"
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
sed -i s/SELINUX=permissive/SELINUX=disabled/g /etc/selinux/config

systemctl disable firewalld.service
systemctl stop firewalld.service
chkconfig NetworkManager off

wget http://192.168.0.82/yum.repos.d/epel.repo -O /etc/yum.repos.d/epel.repo
yum install -y sshpass

wget http://192.168.0.82/iso/xs-tools-6.2.0-7.iso -O /tmp/xs-tools-6.2.0-7.iso
mount -o loop /tmp/xs-tools-6.2.0-7.iso /mnt
yum install -y /mnt/Linux/xe-guest-utilities-6.2.0-1159.x86_64.rpm /mnt/Linux/xe-guest-utilities-xenstore-6.2.0-1159.x86_64.rpm

yum install -y ansible


wget http://192.168.0.82/downloads/docker-engine-1.12.2-1.el7.centos.x86_64.rpm -O /tmp/docker-engine-1.12.2-1.el7.centos.x86_64.rpm
wget http://192.168.0.82/downloads/docker-engine-selinux-1.12.2-1.el7.centos.noarch.rpm -O /tmp/docker-engine-selinux-1.12.2-1.el7.centos.noarch.rpm
yum install -y /tmp/docker-engine-selinux-1.12.2-1.el7.centos.noarch.rpm /tmp/docker-engine-1.12.2-1.el7.centos.x86_64.rpm
wget http://192.168.0.82/downloads/docker-1.12.2.tgz -O /tmp/docker-1.12.2.tgz 
tar xvf /tmp/docker-1.12.2.tgz -C /tmp
mv -f /tmp/docker/* /usr/bin/
wget http://192.168.0.82/downloads/docker.service -O /usr/lib/systemd/system/docker.service
systemctl enable docker.service
systemctl start docker.service
wget http://192.168.0.82/downloads/jdk-8u74-linux-x64.tar.gz -O /opt/jdk-8u74-linux-x64.tar.gz
tar xvf /opt/jdk-8u74-linux-x64.tar.gz -C /opt
wget http://192.168.0.82/downloads/jdk18.sh -O /etc/profile.d/jdk18.sh


