#虚拟机要求
支持嵌套虚拟化
2CPU
4G 内存
200G硬盘
#install qemu
```
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
scp 192.168.0.82:/etc/yum.repos.d/mrepo7.repo /etc/yum.repos.d
yum install qemu-*
yum install nginx
yum install golang
yum install rsync
yum install iproute net-tools tree
yum install ansible
yum install cloud-utils
yum install python-pip
pip install cloudmonkey
mkdir /root/mypackerui
mkdir /root/packer
scp 192.168.0.82:/home/packerdir/* /root/packer
```
同步程序
```
rsync -avP /home/code/mycode/go/src/main --exclude "static/result" --exclude "packer_cache" root@192.168.122.195:/root/mypackerui
```
启动程序
```
cd /root/mypackerui/static/data
rm -f reportlog.json
rm -f log/*
cp reportlog.json.sample reportlog.json
cd /root/mypackerui
go run build.go
```
登录页面
https://192.168.122.195:9090/
虚拟机嵌套安装，只能使用headless模式，不能自动弹出窗口。
观察安装进展要用vnc连接虚拟机。
```
ps -ef|grep qemu-system  
#找出端口号/usr/bin/qemu-system-x86_64 -vnc 0.0.0.0:47
vncviewer 192.168.122.195:47
```

下载cloudinit安装包
```
str=("nfs-utils" "expect" "nginx" "golang" "rsync" "net-tools" "tree" "ansible" "yum-utils" "cloud-utils" "cloud-init" "python-jsonpatch" "dracut-modules-growroot" "cloud-utils-growpart") 
for i in ${str[@]} 
do 
 echo $i 
yumdownloader --resolve $i --destdir /usr/share/nginx/html/repo/centos71-repo/packages  
 
done 
 
createrepo /usr/share/nginx/html/repo/centos71-repo 
```
一些安装包
xs-tools-6.2.0-7.iso
gparted-live-0.21.0-1-i586.iso
CloudInstanceManager.msi
cloud-set-guest-password
cloud-set-guest-password-centos
cloud-set-guest-password-ubuntu
