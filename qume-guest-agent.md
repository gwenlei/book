#win7 vm配置
安装好win7的vm，通过virt-manager修改vm配置，修改channel为unix,相关的path、name要设置好。
```
...
    <channel type='unix'>
      <source mode='bind' path='/var/lib/libvirt/qemu/test.org.qemu.ga.0'/>
      <target type='virtio' name='org.qemu.ga.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>
```
#qemu-guest-agent安装配置流程
##win7 vm安装virtio驱动
下载virtio驱动
```
wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo -O /etc/yum.repos.d/virtio-win.repo
yum install virtio-win
```
将稳定版/usr/share/virtio-win/virtio-win-0.1.102.iso以cdrom形式加载到vm中，在vm的设备管理器中更新其他通讯设置里有问号的设备驱动(只能手动更新设备管理器里有问号的设备驱动)
virtio-win-0.1.102.iso目录guest-agent中双击安装qume-ga.msi
从西西软件园下载mingw-w64.zip，解压到D:\
http://www.cr173.com/soft/132367.html
```
copy D:\mingw-w64\msys\glib_2.18.4-1_win32\bin C:\Program Files\qemu-ga 
copy D:\mingw-w64\mingw-w64\x86_64-4.9.2-posix-seh-rt_v3-rev1\mingw64\x86_64-w64-mingw32\libssp-0.dll
```
csdn下载intl.dll
http://download.csdn.net/download/ftdy1/4358253
复制到C:\Program Files\qemu-ga
#验证
win7 vm命令行中运行，要用管理员权限运行。
```
qemu-ga -p \\.\Global\org.qemu.ga.0
```
centos7 host运行
```
socat /var/lib/libvirt/qemu/test.org.qemu.ga.0 -
{"execute":"guest-info"}
```
host收到返回信息
```
{"return": {"version": "0.12.1", "supported_commands": [{"enabled": true, "name": "guest-set-vcpus"}, {"enabled": true, "name": "guest-get-vcpus"}, {"enabled": true, "name": "guest-network-get-interfaces"}, {"enabled": true, "name": "guest-suspend-hybrid"}, {"enabled": true, "name": "guest-suspend-ram"}, {"enabled": true, "name": "guest-suspend-disk"}, {"enabled": true, "name": "guest-fstrim"}, {"enabled": true, "name": "guest-fsfreeze-thaw"}, {"enabled": true, "name": "guest-fsfreeze-freeze"}, {"enabled": true, "name": "guest-fsfreeze-status"}, {"enabled": true, "name": "guest-file-flush"}, {"enabled": true, "name": "guest-file-seek"}, {"enabled": true, "name": "guest-file-write"}, {"enabled": true, "name": "guest-file-read"}, {"enabled": true, "name": "guest-file-close"}, {"enabled": true, "name": "guest-file-open"}, {"enabled": true, "name": "guest-shutdown"}, {"enabled": true, "name": "guest-info"}, {"enabled": true, "name": "guest-set-time"}, {"enabled": true, "name": "guest-get-time"}, {"enabled": true, "name": "guest-ping"}, {"enabled": true, "name": "guest-sync"}, {"enabled": true, "name": "guest-sync-delimited"}]}}
```
#centos安装qemu-guest-agent
```
yum install qemu-guest-agent
```
安装完软件不用设置自动启动，libvirt自动连接。
#ubuntu14.04安装qemu-guest-agent
```
sudo apt-get install qemu-guest-agent
```
#ubuntu12.04没有对应的安装包,下载后安装。
```
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/q/qemu/qemu-guest-agent_2.0.0~rc1+dfsg-0ubuntu3_amd64.deb
dpkg -i qemu-guest-agent_2.0.0~rc1+dfsg-0ubuntu3_amd64.deb
```
安装完软件不用设置自动启动，libvirt自动连接。
#opensuse安装qemu-guest-agent
http://pkgs.org/download/qemu-guest-agent下载rpm包
设置开机启动
```
cd /root
wget -c http://192.168.0.82/qemu-guest-agent-2.1.3-7.2.x86_64.rpm
rpm -ivh /root/qemu-guest-agent-2.1.3-7.2.x86_64.rpm
echo "qemu-ga -v -p /dev/virtio-ports/org.qemu.guest_agent.0" >> /etc/init.d/after.local
```
#win7\win8\win2008安装后会自动启动进程，win2012r2安装后没有自动启动进程，但手工运行一次qemu-ga后，以后就自动启动。
#默认设置和验证方法
虚拟机添加设备。
```
     <channel type='unix'>
       <source mode='bind' path='/var/lib/libvirt/qemu/test7.agent'/>
        <target type='virtio' name='org.qemu.guest_agent.0'/>
     </channel>
```
虚拟机启动后在命令行运行命令，能成功重启的即安装完成。
```
virsh reboot --mode agent XXX
```

