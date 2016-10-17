# cstemplate 用法
```
#模板列表
cstemplate list -k centos -c id,name
#注册模板
cstemplate register test http://192.168.1.69/tiny.qcow2 -o centos -p true
#删除模板
cstempalte delete templateid
```
# 默认配置
默认配置文件/etc/cstemplate.ini，配置cloudstack的apikey,secretkey等信息。
可以另外指定配置文件
```
cstemplate -i other.ini list
```
配置文件内容分三部分:
main:cloudstack的信息。
register:要注册的模板名字和url，可写多个。(命令行cstemplate register不加参数时取此处值)
delete:要删除的模板id，可写多个。(命令行cstemplate delete不加参数时取此处值)
list:标注要显示的列名，true为显示，false为不显示，命令行cstemplate list -c有指定列名时此处无效。keyword=all时显示全部，设为其他值时只显示名字匹配的模板列表，-k 选项可以修改此值。
```
[main]
endpoint = http://192.168.10.2:8080/client/api
apikey = ji2f2JVLM2hGd6pydLg6vHI80h-xELg3yFGxfCGQiXQEXHhT56yGji5l_FEa40ITdVJvzekuX4yK9oBZYD8XDw
secretkey = _7wEyHx7ifBleJNV-Y9Tmr4FlsRNNTRZlDvMpxj1aMEGXQfn8ywaJx_E8PtEwSfbVGgupG2veMTFccARv2_Kpg
username = admin
password = password
zonename = firstzone
format = QCOW2
hypervisor = KVM
ostype = centos%6.5%64
passwordenabled = true

[register]
#name1 = http://192.168.1.69/tiny.qcow2

[delete]
#id1 = c243445a-a77d-41f5-899e-e869f69173c0

[list]
keyword = all
account = false
accountid = false
bootable = false
checksum = false
created = false
crosszones = false
details = false
displaytext = false
domain = false
domainid = false
format = false
hostid = false
hostname = false
hypervisor = false
id = true
isdynamicallyscalable = false
isextractable = false
isfeatured = false
ispublic = false
isready = false
name = true
ostypeid = false
ostypename = false
passwordenabled = false
project = false
projectid = false
removed = false
size = false
sourcetemplateid = false
sshkeyenabled = false
status = false
tags = false
templatetag = false
templatetype = false
zoneid = false
zonename = false
```
