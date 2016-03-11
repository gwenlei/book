#centos6.6 centos6.7
scp 192.168.0.82:/home/html/iso/xs-tools-6.2.0-7.iso /root
mount -o loop xs-tools-6.2.0-7.iso /mnt
cd /mnt/Linux/
./install.sh
#centos7.1
scp 192.168.0.82:/home/html/iso/xs-tools-6.2.0-7.iso /root
mount -o loop xs-tools-6.2.0-7.iso /mnt
cd /mnt/Linux/
yum install xe-guest-utilities.x86_64.rpm xe-guest-utilities-xenstore.x86_64.rpm
#opensuse132
scp 192.168.0.82:/home/html/iso/xs-tools-6.2.0-7.iso /root
mount -o loop xs-tools-6.2.0-7.iso /mnt
cd /mnt/Linux/
rpm -ivh xe-guest-utilities.x86_64.rpm xe-guest-utilities-xenstore.x86_64.rpm
#ubuntu12.04
scp 192.168.0.82:/home/html/iso/xs-tools-6.2.0-7.iso /root
mount -o loop xs-tools-6.2.0-7.iso /mnt
cd /mnt/Linux/
./install.sh
#ubuntu14.04
scp 192.168.0.82:/home/html/iso/xs-tools-6.2.0-7.iso /root
mount -o loop xs-tools-6.2.0-7.iso /mnt
cd /mnt/Linux/
dpkg -i xe-guest-utilities_6.2.0-1159_amd64.deb
#win7
虚拟机光盘添加xs-tools-6.2.0-7.iso
双击installwizard.exe开始安装。
