#qcow2 to vhd
第一种方法，直接转换。缺点是转换出来的文件太大。
```
qemu-img convert -O vpc CentOS6-7.qcow2 CentOS6-7.vhd
```
第二种方法，先转换成raw,再转换成vhd,这样转换出来的文件较小，嘻嘻。
```
qemu-img convert CentOS6-7.qcow2 -O raw CentOS6-7.raw
vboxmanage convertfromraw --format VHD CentOS6-7.raw CentOS6-7.vhd
```
