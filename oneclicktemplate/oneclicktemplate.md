
模板市场预研计划

### one-click模板 vs 传统模板
cloudstack传统模版是用iso安装完系统后，再手工安装软件，过程耗时长，操作不规范容易出错。
oneclick模板提供已经各种类型部署好软件的模板，只要选择就可以使用。
digitalocean模版市场图
![pic1](images/2016_06_20_11_44_09_1049x770.jpg)
![pic2](images/2016_06_20_11_44_30_1017x973.jpg)

### 部署基础要求

| 名称	|cpu	| mem	|应用场景	| 
|--------|-------|-------|----------| 
|Docker |Linux 64bit  |     |应用容器引擎|
| LAMP  |Linux 32bit/64bit |256M  |Web应用程序平台|

### 实现技术
packer + ansible(playbook)
前提条件是在镜像已安装ansible，所以需要先用shell脚本安装ansible。
packer ansible-local负责上传playbook，生成hosts文件并执行ansible-playbook命令。
例子:
```
{
  "provisioners": [
      {
      "type": "shell",
      "execute_command": "echo 'SSH_PASSWORD' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
          "scripts": [
            "template/script/centos6-6/ansible.sh"
          ]
    },
    {
      "type": "ansible-local",
      "playbook_file": "/home/code/mycode/go/src/main/template/ansible/installtomcatmysql/roles.yml",
      "role_paths": [
        "/home/code/mycode/go/src/main/template/ansible/installtomcatmysql/roles/mysql",
        "/home/code/mycode/go/src/main/template/ansible/installtomcatmysql/roles/tomcat"
      ]
    }
  ],
  "builders":
  [
    {
      "type": "qemu",
      "iso_url":"/home/html/iso/CentOS-6.6-x86_64-bin-DVD1.iso",
      "iso_checksum": "7b1fb1a11499b31271ded79da6af8584",
      "iso_checksum_type": "md5",
      "output_directory": "static/result/20160620150220/output/",
      "ssh_wait_timeout": "30s",
      "shutdown_command": "shutdown -P now",
      "disk_size": 6144,
      "format": "qcow2",
      "headless": false,
      "accelerator": "kvm",
      "http_directory": "httpdir",
      "http_port_min": 10082,
      "http_port_max": 10089,
      "ssh_host_port_min": 2222,
      "ssh_host_port_max": 2229,
      "ssh_username": "root",
      "ssh_password": "engine",
      "ssh_port": 22,
      "ssh_wait_timeout": "90m",
      "vm_name": "CentOS6-6.qcow2",
      "net_device": "virtio-net",
      "disk_interface": "virtio",
      "qemuargs": [
         [ "-m", "1024M" ]
      ],
      "boot_wait": "5s",
      "floppy_files": [
          "static/result/20160620150220/cfg/centos6-6.cfg"
      ],
      "boot_command":
      [
        "<tab> text ks=floppy:/centos6-6.cfg <enter><wait>"
      ]
    }
  ]
}
```
```
packer build centos6-6.json
```
下载iso--> packer创建标准化模板(ubuntu 20G) --> packer调用ansible实现应用模板
的分发(ubuntu+docker[docker installation playbook]) --> 测试  --> 发布

### 研发计划
1. 调研发行版的应用支持情况
2. 可行性分析
首选ubuntu14.04来调研，然后再向其他系统（centos,opensuse,windows等）扩展。
批量下载ansible-galaxy的应用安装脚本，并测试安装情况。
3. playbook编写
4. packer + playbook批量编译（开发/调试/）
将packer与ansible合并测试自动化模板制作。
5. 制件demo
用简单页面展示应用选择和模板制作过程。
6. 发布平台构建（cloudstack/openstack? ），是否引入QA？ 
7. bug-fix(随机密码)
