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
