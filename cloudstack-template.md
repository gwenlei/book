#install cloud-set-guest-password
[ref](http://docs.cloudstack.apache.org/projects/cloudstack-administration/en/4.8/templates/_password.html)
##centos6.7
```
# wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
# mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
# chmod +x /etc/init.d/cloud-set-guest-password
# chkconfig --add cloud-set-guest-password
```
##ubuntu14.04
```
# wget http://download.cloud.com/templates/4.2/bindir/cloud-set-guest-password.in
# sudo mv cloud-set-guest-password.in /etc/init.d/cloud-set-guest-password
# sudo chmod +x /etc/init.d/cloud-set-guest-password
# sudo update-rc.d cloud-set-guest-password defaults 98
# sudo dpkg-reconfigure dash
```
##windows2008r2
install cloudInstanceManager.msi
#patch heartbleed
##centos6.7
```
# yum update openssh*
# yum update pam
# yum install acpid
```
##ubuntu14.04
```
# sudo apt-get install openssh*
# sudo apt-get install libpam0g
# sudo apt-get install acpid
```
