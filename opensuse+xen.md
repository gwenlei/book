#增加安装源。
```
zypper ar -f -c http://mirror.yandex.ru/opensuse/distribution/13.2/repo/oss/ repo-oss
```
#安装xen，并修改启动顺序。
```
zypper install kernel-xen xen xen-libs xen-tools
mv /etc/grub.d/20_linux_xen /etc/grub.d/01_linux_xen
mv /boot/grub2/grub.cfg /boot/grub2/grub.cfg.bak
grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
```
