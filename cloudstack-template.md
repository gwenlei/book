#install cloud-set-guest-password
[ref](http://docs.cloudstack.apache.org/projects/cloudstack-administration/en/4.8/templates/_password.html)
##centos
安装密码重置模块
```
# wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
# mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
# chmod +x /etc/init.d/cloud-set-guest-password
# chkconfig --add cloud-set-guest-password
# yum install -y -q wget
# yum install -y -q expect
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
centos7.0\7.2操作同上，另外要关闭NetworkManager，使重置密码生效。
```
# chkconfig NetworkManager off
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
```
# sudo apt-get install qemu-guest-agent
```
删除安装时使用的clouder用户，允许root登录。
```
# userdel -r clouder
# sudo sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
```
删除历史操作记录
```
# history -c
```
##windows2008r2
安装密码重置模块cloudInstanceManager.msi
下载地址https://sourceforge.net/projects/cloudstack/files/Password%20Management%20Scripts/CloudInstanceManager.msi/download
设置开机启动脚本
执行C:\Windows\Onecloud\dhcp.fix\del.bat 删除dhcp
执行C:\Windows\Onecloud\dhcp.fix\chk.bat 检查dhcp是否完全删除。
执行C:\Windows\Onecloud\dhcp.fix\add.bat 添加开机启动脚本。
设置允许远程桌面

停止windows licensing monitoring service
PSTOOLS（下载地址http://dl.pconline.com.cn/download/55657.html）
命令格式：pstools\psexec.exe -d -i -s regedit.exe 后，注册表操作进入特权模式
注册表项：
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WLMS]
将启动类型由02（自动）改为04（禁用）



