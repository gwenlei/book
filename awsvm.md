centos72
cloudinit

virtualbox 选错网卡导致不能连网

virt-manager 要支持嵌套虚拟化才能用xenserver6.5创建虚拟机
Create/Edit file /etc/modprobe.d/kvm-nested.conf with contents

options kvm_intel nested=1

Unload and reload the module

modprobe -r kvm_intel
modprobe kvm_intel

The output of this command is

cat /sys/module/kvm_intel/parameters/nested

should show

Y


echo MOUNTD_NFS_V3="yes" >> /etc/sysconfig/nfs
echo RQUOTAD_PORT=875 >> /etc/sysconfig/nfs
echo LOCKD_TCPPORT=32803 >> /etc/sysconfig/nfs
echo LOCKD_UDPPORT=32769 >> /etc/sysconfig/nfs
echo MOUNTD_PORT=892 >> /etc/sysconfig/nfs
echo STATD_PORT=662 >> /etc/sysconfig/nfs
echo STATD_OUTGOING_PORT=2020 >> /etc/sysconfig/nfs
systemctl start nfs-server.service
systemctl enable nfs-server.service

[root@localhost tmp]# cat ip.sh
ip route add default via 192.168.122.1 dev eth0
ip address add 192.168.122.162/24 dev eth0
echo "search localdomain" >/etc/resolv.conf
echo "nameserver 223.5.5.5" >>/etc/resolv.conf
echo "nameserver 180.76.76.76" >>/etc/resolv.conf

192.168.0.169
cp /home/clouder/img/vhd/6343a8bd-f779-5ca5-4063-c2a022bb7331/1c7004a1-fbc4-4871-9c23-b312994f899a.vhd /home/clouder/img/vhd/centos72aws.vhd
scp /home/clouder/img/vhd/centos72aws.vhd root@192.168.0.82:/home/img/aws

/devcloud/template/centos72aws.vhd

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.65-3.b17.el7.x86_64/jre
export EC2_HOME=/home/html/awsupload/ec2-api-tools-1.7.5.1
export AWS_ACCESS_KEY=your-aws-access-key-id
export AWS_SECRET_KEY=your-aws-secret-key
cd /home/html/awsupload/ec2-api-tools-1.7.5.1/bin
./ec2-describe-regions



从S3导入Image

   Linux XenServer模板要安装Cloud-Init, 用以下命令：
      #yum install cloud-init python-jsonpatch dracut-modules-growroot cloud-utils-growpart
      #dracut --force

  然后通过AWS console 的S3服务上传VHD格式的模板，再使用aws-shell导入到EC2中。


  完整的配置和操作如下, 仅供参考。

   AWS操作按照此文档执行的，
       http://docs.aws.amazon.com/vm-import/latest/userguide/import-vm-image.html
       http://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html

   执行以下步骤前，image文件要先上传到S3上。

步骤：
  1. 创建vmimport角色
     新建文件trust-policy.json, 内容如下：
     {
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Principal": { "Service": "vmie.amazonaws.com" },
         "Action": "sts:AssumeRole",
         "Condition": {
            "StringEquals":{
               "sts:Externalid": "vmimport"
            }
         }
      }
   ]
}

   在aws-shell中执行,(用管理员)
      aws> iam create-role --role-name vmimport --assume-role-policy-document file://trust-policy.json


   2. 设置vmimport角色的权限策略
      新建文件role-policy.json, 内容如下：
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:DeleteObject",
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws-cn:s3:::devcloud",
                "arn:aws-cn:s3:::devcloud/*",
                "arn:aws-cn:s3:::devcloud/template/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CancelConversionTask",
                "ec2:CancelExportTask",
                "ec2:CreateImage",
                "ec2:CreateInstanceExportTask",
                "ec2:CreateTags",
                "ec2:DeleteTags",
                "ec2:DescribeConversionTasks",
                "ec2:DescribeExportTasks",
                "ec2:DescribeInstanceAttribute",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeInstances",
                "ec2:DescribeTags",
                "ec2:ImportInstance",
                "ec2:ImportVolume",
                "ec2:StartInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances",
                "ec2:ImportImage",
                "ec2:ImportSnapshot",
                "ec2:DescribeImportImageTasks",
                "ec2:DescribeImportSnapshotTasks",
                "ec2:CancelImportTask"
            ],
            "Resource": "*"
        }
    ]
}

      在aws-shell中执行,(用管理员)
       aws> iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document file://role-policy.json
      同时以管理员登录AWS console，在IAM服务中，为vmimport角色添加“AmazonEC2FullAccess”策略。

   4. 在AWS consoleIAM服务中添加一新用户，名称自定，如imageuser，赋予与role-policy.json一样的权限。


   5. 导入image.
      新建文件xen-test.json, 内容如下：
[
  {
    "Description": "CentOS7 test vhd",
    "Format": "vhd",
    "UserBucket": {
        "S3Bucket": "devcloud",
        "S3Key": "template/centos72aws.vhd"          (此文件要先上传到S3上)
    }
}]

      在aws-shell中执行,(用imageuser账号)
      aws> ec2 import-image --description "CentOS test vhd" --disk-containers file:///home/clouder/aws/xen-test.json --debug

   5. 检查导入image进度.
      在aws-shell中执行,(用imageuser账号)
      aws>ec2 describe-import-image-tasks --import-task-ids import-ami-ffory8je     (import-ami-ffory8je从上一步中得到)


list_domains
xe vm-reboot uuid=UUIDOfYourVM --force
#xe vbd-list vm-uuid=<uuid of the Control Domain>
#xe vbd-unplug uuid=<uuid of the vbd> 
#xe vbd-destroy uuid=<uuid of the vbd>

xe sr-list
xe sr-scan uuid=2d094569-eb38-03cb-3725-52fb42513519
xe vdi-list sr-uuid=2d094569-eb38-03cb-3725-52fb42513519
xe vdi-param-set name-label=centos72aws uuid=1c7004a1-fbc4-4871-9c23-b312994f899b
xe vm-install new-name-label=centos72awstest sr-uuid=2d094569-eb38-03cb-3725-52fb42513519 template=CentOS\ 7
xe network-list
xe vif-create vm-uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9 network-uuid=9a5b1964-055e-060f-d47d-2f173b7eb314 mac=random device=0
xe vm-disk-list uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9
xe vm-disk-remove device=0 uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9
xe vbd-create vm-uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9 vdi-uuid=1c7004a1-fbc4-4871-9c23-b312994f899b device=0 bootable=true
xe vm-memory-limits-set uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9 dynamic-min=1GiB dynamic-max=1GiB static-min=1GiB static-max=1GiB
xe vm-start uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9

xe vm-disk-add uuid=69c2177e-1b19-3445-c60a-a4af8b9933d9 sr-uuid=2d094569-eb38-03cb-3725-52fb42513519 device=0 disk-size=2GiB

xe vm-disk-add uuid=${vm_uuid} sr-uuid=${sr_uuid} device=0 disk-size=${disk_size}iB
vbd_uuid=$(xe vbd-list vm-uuid=${vm_uuid} userdevice=0 params=uuid --minimal)
xe vbd-param-set bootable=true uuid=${vbd_uuid}
