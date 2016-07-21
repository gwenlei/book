cloudstack模板制作注意事项
##install cloud-set-guest-password
密码重置参考网站 http://docs.cloudstack.apache.org/projects/cloudstack-administration/en/4.8/templates/_password.html
##centos
安装密码重置模块
```
# yum install -y -q wget
# yum install -y -q expect
# wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
# mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
# chmod +x /etc/init.d/cloud-set-guest-password
# chkconfig --add cloud-set-guest-password
```
centos7.0\7.2要关闭NetworkManager，使重置密码生效。
```
# chkconfig NetworkManager off
```
修复心脏出血漏洞
```
# yum update openssh*
# yum update pam
```
安装电源管理
```
# yum install -y acpid
```
安装qemu-guest-agent
```
# yum install -y qemu-guest-agent
```
centos7.0要添加qemu-guest-agent自动启动
```
ln -s /usr/lib/systemd/system/qemu-guest-agent.service /etc/systemd/system/multi-user.target.wants
```
清理网卡绑定文件
```
# sed -i "s/^HWADDR.*$//g" /etc/sysconfig/network-scripts/ifcfg-eth0
# cd /etc/udev/rules.d
# rm -f 70-persistent-net.rules
# rm -f 75-persistent-net-generator.rules
# echo "# " > 75-persistent-net-generator.rules
```
删除历史操作记录
```
# history -c
```

##ubuntu
安装密码重置模块
```
# wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
# sudo mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
# sudo chmod +x /etc/init.d/cloud-set-guest-password
# sudo update-rc.d cloud-set-guest-password defaults 98
# sudo rm -f /bin/sh
# sudo ln -s /bin/bash /bin/sh
# sudo apt-get install --no-install-recommends -q -y --force-yes wget
# sudo apt-get install --no-install-recommends -q -y --force-yes whois
```
修复心脏出血漏洞
```
# sudo apt-get install openssh*
# sudo apt-get install libpam0g
```
安装电源管理模块
```
# sudo apt-get install acpid
```
安装qemu-guest-agent
ubuntu12.04
```
wget http://archive.ubuntu.com/ubuntu/pool/universe/q/qemu/qemu-guest-agent_2.0.0~rc1+dfsg-0ubuntu3_amd64.deb
sudo dpkg -i qemu-guest-agent_2.0.0~rc1+dfsg-0ubuntu3_amd64.deb
```
ubuntu14.04
```
# sudo apt-get install qemu-guest-agent
```
删除安装时使用的clouder用户，允许root登录。
```
# userdel -r clouder
# sudo sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
# service sshd restart
```
删除历史操作记录
```
# history -c
```
##windows2008r2
1.安装qemu-guest-agent
将http://192.168.0.236/repo/iso/virtio-win-0.1.96.iso 以cdrom形式加载到vm中，在vm的设备管理器中更新其他通讯设置里有问号的设备驱动(只能手动更新设备管理器里有问号的设备驱动)
virtio-win-0.1.96.iso目录guest-agent中双击安装qemu-ga-x64.msi

2.安装密码重置模块cloudInstanceManager.msi
下载地址https://sourceforge.net/projects/cloudstack/files/Password%20Management%20Scripts/CloudInstanceManager.msi/download
设置开机启动脚本，老模板配置的脚本。
执行C:\Windows\Onecloud\dhcp.fix\del.bat 删除dhcp
执行C:\Windows\Onecloud\dhcp.fix\chk.bat 检查dhcp是否完全删除。
执行C:\Windows\Onecloud\dhcp.fix\add.bat 添加开机启动脚本。

3.设置允许远程桌面
“开始”-->“程序”-->“管理工具”-->“服务器管理器”选项-->“服务器管理”节点选项-->单击“服务器摘要”设置区域中的“配置远程桌面”-->将“允许运行任意版本远程桌面的计算机连接”功能选项选中。

4.停止windows licensing monitoring service
PSTOOLS（下载地址http://dl.pconline.com.cn/download/55657.html）
命令格式：pstools\psexec.exe -d -i -s regedit.exe 后，注册表操作进入特权模式
注册表项：
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WLMS]
将启动类型由02（自动）改为04（禁用）

##opensuse13.2
修复心脏出血漏洞
```
# zypper mr -d openSUSE-13.2-0
# zypper ar -f -c http://download.opensuse.org/tumbleweed/repo/oss repo-oss
# zypper ar -f -c http://download.opensuse.org/tumbleweed/repo/non-oss repo-non-oss
# zypper -n in --no-recommends   openssh*
# zypper -n in --no-recommends   pam
```
安装电源管理模块
```
# zypper -n in --no-recommends  acpid
```
安装密码重置
```
# zypper -n in --no-recommends   wget
# zypper -n in --no-recommends  whois
# wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
# mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
# chmod +x /etc/init.d/cloud-set-guest-password
# chkconfig --add cloud-set-guest-password
```
安装qemu-guest-agent
```
# cd /root
# wget -c http://mirrors.ustc.edu.cn/opensuse/update/13.2/x86_64/qemu-guest-agent-2.1.3-7.2.x86_64.rpm
# rpm -ivh /root/qemu-guest-agent-2.1.3-7.2.x86_64.rpm
# echo ""qemu-ga -v -p /dev/virtio-ports/org.qemu.guest_agent.0"" >> /etc/init.d/after.local"
# history -c

```
dhcp文件位置有变，要修改官方脚本cloud-set-guest-password.in。
```
#vi /etc/init.d/cloud-set-guest-password
DHCP_FOLDERS="/var/lib/wicked/* /var/lib/dhclient/* /var/lib/dhcp3/* /var/lib/dhcp/*"
...
		#PASSWORD_SERVER_IP=$(grep dhcp-server-identifier $DHCP_FILE | tail -1 | awk '{print $NF}' | tr -d '\;')
		PASSWORD_SERVER_IP=$(grep server-id $DHCP_FILE|sed -e "s/<server-id>//g" -e "s/<\/server-id>//g" -e "s/ //g")```

#内网模板地址
```
#0423上传的模板
http://192.168.215.15/uploads/xinkedu0423
#0530修复了centos7.0和ubuntu12.04的qemu-guest-agent安装问题的模板
http://192.168.215.15/uploads/xkd-fix
```



