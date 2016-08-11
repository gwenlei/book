###windows2008r2 enterprise
1.服务器管理器－－配置---本地用户和组---用户---administrator，打开属性，对“密码永不过期”
2.“本地组策略编辑器”后选择“Windows设置”下的“安全设置”→“账户策略”→“密码策略”点击关闭密码必须符合复杂性要求（配置成启用即可）
3.不自动登录
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
"AutoAdminLogon"="0"
"DefaultUserName"="Administrator"
"DefaultPassword"="Win2008"
4.服务器管理器，点击角色，添加角色，如果安装过iis，角色摘要里面会有个Web服务器(IIS),点击后面的添加角色，滚动条拉到最后勾选FTP服务器
windows部署服务
网络策略和访问服务
web服务器iis
5.开启远程桌面
计算机属性，远程设置，允许任何版本系统连接
6.用户修改密码
控制面板，用户账户，修改用户密码
7.安装CloudInstanceManager.msi
下载地址 http://tenet.dl.sourceforge.net/project/cloudstack/Password%20Management%20Scripts/CloudInstanceManager.msi 

###vr重置密码日志
密码复杂度要保持，否则会重置成空白
vr
/var/log/messages
里要出现password sent to 10.1.1.37 才重置密码成功，windows2008登录框出现时才出现这句日志
密码保存文件
/var/cache/cloud/passwords-10.1.1.1

###重置密码
1.制作模板时不要加入dhcp网络。以iso方式加入安装文件，这样是否可以避免产生本地连接2
mkisofs test.iso test
CloudInstanceManager.msi
dotNetFx45_Full_x86_x64.exe
Onecloud.zip (可忽略)
2.去掉本地连接2
环境变量:devmgr_show_nonpresent_devices=1
start devmgmt.msc设备管理器-->查看-->显示隐藏的设备，卸载不存在的旧设备(变暗的硬件)和所有网卡驱动，重启，保证只留一个8139网卡驱动。

最后检查注册表有无多余网卡信息
\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Network\{}\Description里面前三个键删除
删除本地连接相关键

3.出现新的网卡，第一次启动需要安装驱动才能获取ip，所以密码重置无效，重启后就正常。
在xenserver里的网卡与virtualbox的网卡不一致，都会导致这种问题。上传模板后，待驱动更新后，制成模板，以后这模板的密码重置不需要重启。

###在xencenter设置网卡
源起：
因为qemu的镜像直接转vhd不能用，packer里没有sata的硬盘类型。
在xenserver里是rtl8139网卡类型（这是因为安装在kvm虚拟机上？），而virtualbox里面没有这种网卡，生成的镜像装不了这种网卡驱动，启动虚拟机要先安装驱动（系统自动安装），重置密码首次启动找不到IP所以不生效。
处理方法：
在xencenter里创建网络启动的win2008r2虚拟机，网络只选一个（避免产生多余的网卡信息,要删除默认网络，添加新的dev0的网络，反复更换网络，检查没有产生本地连接2后才能做模板），创建nfs虚拟硬盘仓库，将vhd硬盘移动到nfs虚拟硬盘仓库中,名称改成uuid形式才能被xencenter识别(可以用uuidgen生成，或者直接在旧的uuid上加1)，之前创建的虚拟机加载此硬盘，修改启动方式为硬盘启动，点击启动后，等网卡驱动安装完成后，就可以作为模板导入cloudstack测试。

