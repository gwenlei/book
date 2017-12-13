samba
http://www.linuxidc.com/Linux/2017-03/141390.htm
smb
https://technet.microsoft.com/en-us/library/jj134187.aspx#BKMK_Step3
https://technet.microsoft.com/en-us/library/jj134187.aspx

http://docs.cloudstack.apache.org/projects/cloudstack-installation/en/4.5/hypervisor/hyperv.html
http://bbs.51cto.com/thread-1152245-1.html

cobbler system add --name=host17 --profile=CentOS-7.1-x86_64 --mac=b0:83:fe:e3:74:3c --interface=eth0 --ip-address=192.168.173.17 --hostname=host17 --gateway=192.168.173.1 --dns-name=host17 --static=1 --ip-address=192.168.173.17

xshost18 192.168.173.18

服务器MAC
b8:2a:72:d0:4c:2a
b0:83:fe:e3:74:3c

cobbler system add --name=host17 --profile=CentOS-7.1-x86_64
cobbler system edit --name=host17 --interface=eth0 --mac=b0:83:fe:e3:74:3c \
--interface-type=bond_slave --interface-master=bond0
cobbler system edit --name=host17 --interface=eth1 --mac=b0:83:fe:e3:74:3d \
--interface-type=bond_slave --interface-master=bond0
cobbler system edit --name=host17 --interface=bond0 --interface-type=bonded_bridge_slave \
--bonding-opts="miimon=100 mode=1" --interface-master=cloudbr0
cobbler system edit --name=host17 --interface=cloudbr0 --interface-type=bridge \
--bridge-opts="stp=no" --ip-address=192.168.173.17 \
--hostname=host17 --gateway=192.168.173.1 --dns-name=host17 \
--netmask=255.255.255.0 --static=1


scp /home/clouder/Cloudstack_Xenserver_auto_deploy/script-and-template/ansible-cs451/systemvm64template-4.5-xen.vhd.bz2 root@192.168.173.10:/root
mkdir -p /root/tmp
mount 192.168.173.11:/home/exports/xssec /root/tmp
/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m /root/tmp -f /root/systemvm64template-4.5-xen.vhd.bz2 -h xenserver -F

scp /home/code/sambarpm.tar root@192.168.173.10:/root
scp /home/img/cifrpm.tar root@192.168.173.10:/root
vim /etc/samba/smb.conf
[global]
        workgroup = WORKGROUP
        netbios name = smbserver
        server string = smbserver

        security = user
        map to guest = Bad User

[csshare]
        comment = Cloudstack sec storage
        path = /export/csshare
        browseable = yes
        writeable = yes
        public = yes
        guest ok = yes
[cspri]
        comment = Cloudstack pri storage
        path = /export/cspri
        browseable = yes
        writeable = yes
        public = yes
        guest ok = yes


systemctl enable smb
systemctl start smb

chown nobody:nobody /export/csshare

mount  -t cifs //192.168.173.10/csshare testmount
file://192.168.173.10/csshare

mount  -t cifs //192.168.173.15/pri testmount

/pri?user=administrator&domain=WORKGROUP


/usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt \
-m /export/csshare \
-f /root/systemvm64template-4.5-hyperv.vhd.zip \
-h hyperv \
-F
