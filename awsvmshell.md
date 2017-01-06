https://blog.hackroad.com/operations-engineer/virtualization/10185.html

自动化安装初始VM
https://github.com/mcsrainbow/shell-scripts/blob/master/scripts/xcp_ksinstvm/ksinstvm.sh

#!/bin/bash
# Dong Guo
# Last Modified: 2013/11/28
 
# Note:
# The IP address configs in "ks_args" and "remote kickstart file" should be same
# And the IP address should be in the same subnet as the current xenserver,
# otherwise it failed if through the gateway
 
vm_name=t_c64_min
repo_url=http://10.100.1.2/repo/centos/6/
ks_args="ip=10.100.1.254 netmask=255.255.255.0 gateway=10.100.1.1 ns=10.100.1.10 noipv6 ks=http://10.100.1.2/repo/ks/centos-6.4-x86_64-minimal.ks ksdevice=eth0"
cpu_cores=4
mem_size=8G
disk_size=20G
 
echo "Creating an empty vm:${vm_name}..."
hostname=$(hostname -s)
sr_uuid=$(xe sr-list | grep -A 2 -B 1 "Local storage" | grep -B 3 -w "${hostname}" | grep uuid | awk -F ": " '{print $2}')
vm_uuid=$(xe vm-install new-name-label=${vm_name} sr-uuid=${sr_uuid} template=Other\ install\ media)
 
echo "Setting up the bootloader,cpu,memory..."
xe vm-param-set VCPUs-max=${cpu_cores} uuid=${vm_uuid}
xe vm-param-set VCPUs-at-startup=${cpu_cores} uuid=${vm_uuid}
xe vm-memory-limits-set uuid=${vm_uuid} dynamic-min=${mem_size}iB dynamic-max=${mem_size}iB static-min=${mem_size}iB static-max=${mem_size}iB
xe vm-param-set HVM-boot-policy="" uuid=${vm_uuid}
xe vm-param-set PV-bootloader="eliloader" uuid=${vm_uuid}
 
echo "Setting up the kickstart..."
xe vm-param-set other-config:install-repository="${repo_url}" uuid=${vm_uuid}
xe vm-param-set PV-args="${ks_args}" uuid=${vm_uuid}
 
echo "Setting up the disk..."
xe vm-disk-add uuid=${vm_uuid} sr-uuid=${sr_uuid} device=0 disk-size=${disk_size}iB
vbd_uuid=$(xe vbd-list vm-uuid=${vm_uuid} userdevice=0 params=uuid --minimal)
xe vbd-param-set bootable=true uuid=${vbd_uuid}
 
echo "Setting up the network..."
network_uuid=$(xe network-list bridge=xenbr0 --minimal)
xe vif-create vm-uuid=${vm_uuid} network-uuid=${network_uuid} mac=random device=0
 
echo "Starting the vm:${vm_name}" 
xe vm-start vm=${vm_name}


自动化批量创建VM
https://github.com/mcsrainbow/python-demos/blob/master/scripts/xenserver.py

#!/usr/bin/env python
#-*- coding:utf-8 -*-
 
# Author: Dong Guo
# Last Modified: 2013/12/9
 
import os
import sys
import fileinput
 
# import fabric api to run commands remotely
try:
    from fabric.api import env, execute, cd, sudo, run, hide, settings
except ImportError:
    sys.stderr.write("ERROR: Requires Fabric, try 'pip install fabric'.\n")
    sys.exit(1)
 
def parse_opts():
    """Help messages (-h, --help)"""
 
    import textwrap
    import argparse
 
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent(
        '''
        examples:
          {0} -s idc1-server3 -f idc1-server3.list
          {0} -s idc1-server3 -t t_c64_min -n idc2-server21 -i 10.100.1.65 -e 255.255.252.0 -g 10.100.1.1 -c 4 -m 8G -d 50G
 
          idc1-server3.list:
            t_c64_min,idc2-server21,10.100.1.65,255.255.252.0,10.100.1.1,4,8G,50G,
            t_c64_min,idc2-server41,10.100.1.66,255.255.252.0,10.100.1.1,4,8G,50G,
            ...
        '''.format(__file__)
        ))
 
    exclusion = parser.add_mutually_exclusive_group(required=True)
 
    parser.add_argument('-s', metavar='server', type=str, required=True, help='hostname of xenserver')
    exclusion.add_argument('-f', metavar='filename', type=str, help='filename of list')
    exclusion.add_argument('-t', metavar='template', type=str, help='template of vm')
    parser.add_argument('-n', metavar='hostname', type=str, help='hostname of vm')
    parser.add_argument('-i', metavar='ipaddr', type=str, help='ipaddress of vm')
    parser.add_argument('-e', metavar='netmask', type=str, help='netmask of vm')
    parser.add_argument('-g', metavar='gateway', type=str, help='gateway of vm')
    parser.add_argument('-c', metavar='cpu', type=int, help='cpu cores of vm')
    parser.add_argument('-m', metavar='memory', type=str, help='memory size of vm')
    parser.add_argument('-d', metavar='disk', type=str, help='disk size of vm')
 
    args = parser.parse_args()
    return {'server':args.s, 'filename':args.f, 'template':args.t, 'hostname':args.n, 'ipaddr':args.i, 
            'netmask':args.e, 'gateway':args.g, 'cpu':args.c, 'memory':args.m, 'disk':args.d}
 
def isup(host):
    """Check if host is up"""
 
    import socket
 
    conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    conn.settimeout(1)
    try:
        conn.connect((host,22))
        conn.close()
    except:
        print "Connect to host {0} port 22: Network is unreachable".format(host)
        sys.exit(1)
 
def fab_execute(host,task):
    """Execute the task in class FabricSupport."""
 
    user = "heydevops"
    keyfile = "/home/heydevops/.ssh/id_rsa"
 
    myfab = FabricSupport()
    return myfab.execute(host,task,user,keyfile)
 
class FabricSupport(object):
    """Remotely get information about servers"""
 
    def __init__(self):
        self.server = opts['server']
        self.template = opts['template']
        self.hostname = opts['hostname']
        self.ipaddr = opts['ipaddr']
        self.netmask = opts['netmask']
        self.gateway = opts['gateway']
        self.cpu = opts['cpu']
        self.memory = opts['memory']
        self.disk = opts['disk']
 
    def execute(self,host,task,user,keyfile):
        env.parallel = False
        env.user = user
        env.key_filename = keyfile
 
        get_task = "task = self.{0}".format(task)
        exec get_task
 
        with settings(warn_only=True):
            return execute(task,host=host)[host]
 
    def clone(self):
        print "Choosing the storage has most available spaces..."
        sr_items = sudo("""xe sr-list |grep -A2 -B3 -w %s |grep -A1 -B4 -Ew 'lvm|ext' |grep -w name-label |awk -F ": " '{print $2}'""" % (self.server))
        sr_disk = 0
        for item in sr_items.splitlines():
            item_uuid = sudo("""xe sr-list |grep -A2 -B3 -w %s |grep -B1 -w '%s' |grep -w uuid |awk -F ": " '{print $2}'""" % (self.server,item))
            t_disk = sudo("""xe sr-param-list uuid={0} |grep physical-size |cut -d: -f2""".format(item_uuid))
            u_disk = sudo("""xe sr-param-list uuid={0} |grep physical-utilisation |cut -d: -f2""".format(item_uuid))
            f_disk = int(t_disk) - int(u_disk)
            if f_disk > sr_disk:
                sr_disk = f_disk
                sr_name = item
                sr_uuid = item_uuid
 
        print "Copying the vm:{0} from template:{1} on storage:'{2}'...".format(self.hostname,self.template,sr_name)
        vm_uuid = sudo("""xe vm-copy new-name-label={0} vm={1} sr-uuid={2}""".format(self.hostname,self.template,sr_uuid))
        if vm_uuid.failed:
            print "Failed to copy vm:{0}".format(self.hostname)
            return False
 
        print "Setting up the bootloader,vcpus,memory of vm:{0}...".format(self.hostname)
        sudo('''xe vm-param-set uuid={0} HVM-boot-policy=""'''.format(vm_uuid))
        sudo('''xe vm-param-set uuid={0} PV-bootloader="pygrub"'''.format(vm_uuid))
 
        sudo('''xe vm-param-set VCPUs-max={0} uuid={1}'''.format(self.cpu,vm_uuid))
        sudo('''xe vm-param-set VCPUs-at-startup={0} uuid={1}'''.format(self.cpu,vm_uuid))
 
        sudo('''xe vm-memory-limits-set uuid={0} dynamic-min={1}iB dynamic-max={1}iB static-min={1}iB static-max={1}iB'''.format(vm_uuid,self.memory))
 
        print "Setting up the disk size of vm:{0}...".format(self.hostname)
        vdi_uuid = sudo("""xe vm-disk-list vm=%s |grep -B2 '%s' |grep -w uuid |awk '{print $5}'""" % (self.hostname,sr_name))
        sudo('''xe vdi-resize uuid={0} disk-size={1}iB'''.format(vdi_uuid,self.disk))
 
        print "Setting up the network of vm:{0}...".format(self.hostname)
        sudo('''xe vm-param-set uuid={0} PV-args="_hostname={1} _ipaddr={2} _netmask={3} _gateway={4}"'''.format(vm_uuid,self.hostname,self.ipaddr,self.netmask,self.gateway))
 
        print "Starting vm:{0}...".format(self.hostname)
        vm_start = sudo('''xe vm-start uuid={0}'''.format(vm_uuid))
        if vm_start.failed:
            print "Failed to start vm:{0}".format(self.hostname)
            return False
        return True
 
if __name__=='__main__':
    argv_len = len(sys.argv)
    if argv_len < 2:
        os.system(__file__ + " -h")
        sys.exit(1)
    opts = parse_opts()
 
    # check if host is up
    isup(opts['server'])
 
    # clone
    if opts['filename']:
        for i in fileinput.input(opts['filename']):
            a = i.split(',')
            opts = {'server':opts['server'], 'template':a[0], 'hostname':a[1], 'ipaddr':a[2], 
                    'netmask':a[3], 'gateway':a[4], 'cpu':a[5], 'memory':a[6], 'disk':a[7]}
            fab_execute(opts['server'],"clone")
        sys.exit(0)
    fab_execute(opts['server'],"clone")

自动化VM网络配置
https://github.com/mcsrainbow/shell-scripts/blob/master/scripts/xcp_bootstrap/bootstrap.sh

#!/bin/bash
# 
# Bootstrap Script for Hostname,Network...
# 
# Author: Dong Guo
# Last Modified: 2013/10/24 by Dong Guo
 
options=$(cat /proc/cmdline|sed 's/.*rhgb quiet  //g')
config=/etc/sysconfig/network-scripts/ifcfg-eth0
failed=/root/bootstrap.failed
 
function check_root(){
  if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
  fi
}
 
function configure_os(){
  echo "DEVICE=eth0" > $config
  echo "ONBOOT=yes" >> $config
  echo "BOOTPROTO=none" >> $config
 
  for i in $options
  do
    option=$(echo $i|cut -d "=" -f 1)
    value=$(echo $i|cut -d "=" -f 2)
    if [ "${option:0:1}" = "_" ]; then
      case "$option" in
        _hostname)
         oldname=$(hostname)
         newname=$value
         sed -i s/"$oldname"/"$newname"/g /etc/sysconfig/network
         hostname $newname
        ;;
        _ipaddr)
         echo "IPADDR=$value" >> $config
        ;;
        _netmask)
         echo "NETMASK=$value" >> $config
        ;;
        _gateway)
         echo "GATEWAY=$value" >> $config
        ;;
      esac
    fi
  done
}
 
function restart_network(){
  /etc/init.d/network restart
}
 
function check_status(){
  gateway=$(grep -w GATEWAY $config|cut -d "=" -f 2)
  route -n | grep -wq $gateway
  if [ $? -eq 0 ]; then
    sed -i /bootstrap/d /etc/rc.local
    if [ -a $failed ]; then
      rm -f $failed
    fi
  else
    touch $failed
  fi
}
 
check_root
configure_os
restart_network
check_status

自动化VM磁盘扩容
https://github.com/mcsrainbow/shell-scripts/blob/master/scripts/xcp_extendlv/extendlv.sh

#!/bin/sh
 
disk=/dev/xvda
num=3
oldsize=12G
failed=/root/extendlv.failed
rebooted=/root/extendlv.rebooted
 
function check_root(){
  if [ $EUID -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
  fi
}
 
function extend_lv(){
  echo "root filesystem:"
  df -hP / | grep -v Filesystem
 
  if [ ! -f ${rebooted} ]; then
    echo -e "n
p
${num}
\n
\n
w
q"|fdisk ${disk}
    touch ${rebooted}
    reboot
    exit 1
  fi
 
  vg=$(df -h  | grep root | cut -d/ -f4 | cut -d- -f1)
  lv=$(df -h  | grep root | cut -d/ -f4 | cut -d- -f2)
 
  echo "resizing ${vg}-${lv}"
  pvresize ${disk}${num}
  vgextend ${vg} ${disk}${num}
  free=$(vgdisplay | grep Free | awk '{print $5}')
  lvextend -l +${free} /dev/${vg}/${lv}
  resize2fs /dev/mapper/${vg}-${lv}
 
  echo "new root filesystem:"
  df -hP / | grep -v Filesystem
}
 
function check_status(){
  root_size=$(df -hP / |grep -v Filesystem |awk '{print $2}')
  if [ ${root_size} != "${oldsize}" ]; then
    sed -i /extendlv/d /etc/rc.local
    if [ -f ${failed} ]; then
      rm -f ${failed}
    fi
  else
    touch ${failed}
  fi
}
 
check_root
extend_lv
check_status

获取指定VM的VNC终端，用于脚本故障时连接到本地终端进行调试（效果相当于Windows上XenCenter Console）
https://github.com/mcsrainbow/shell-scripts/blob/master/scripts/xcp_getvnc/getvnc.sh

#!/bin/bash
 
vm=$1
if [ -z ${vm} ]; then
  echo "Usage: $0 vm_name"
  echo "VMs found:"
  xl list-vm | awk '{print $3}' | grep -vw name
  exit 1
fi
 
xe vm-list params=name-label name-label=${vm} | grep ${vm} > /dev/null
if [ $? -gt 0 ]; then
  echo "Error: invalid VM name"
  exit 1
fi
 
host=$(xe vm-list params=resident-on name-label=${vm} | grep resident-on | awk '{print $NF}')
dom=$(xe vm-list params=dom-id name-label=${vm} | grep dom-id | awk '{print $NF}')
port=$(xenstore-read /local/domain/${dom}/console/vnc-port)
ip=$(xe pif-list management=true params=IP host-uuid=${host} | awk '{print $NF}')
 
echo "run this on laptop and connect via vnc to localhost:${port}"
echo "--> ssh -L ${port}:localhost:${port} root@${ip}"
