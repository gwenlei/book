###参考网站
https://blog.csdn.net/qooer_tech/article/details/72898802
https://blog.csdn.net/jiangshouzhuang/article/details/62461883
https://blog.csdn.net/dennis_hui/article/details/24706295
http://docs.cloudstack.apache.org/projects/cloudstack-administration/en/4.8/reliability.html

###环境
CloudStack管理服务器部署两个虚拟机(相同的基础镜像派生的两个虚拟机)，Mysql数据库设置双主备份。
master 192.168.173.10
slave  192.168.173.9
修改slave的虚拟网卡mac，避免重复。
修改slave的IP
```
sed -i 's/192.168.173.10/192.168.173.9/g'  /etc/sysconfig/network-scripts/ifcfg-eth0
reboot
```
修改配置之前停止cloudstack-management服务。
```
service cloudstack-management stop
```
###master配置/etc/my.cnf
```
#
# This group is read both both by the client and the server
# use it for options that affect everything
#
[client-server]

#
# include all files from the config directory
#
!includedir /etc/my.cnf.d
[mysqld]
skip_name_resolve = ON
innodb_file_per_table = ON
server-id = 100
log-bin=master-bin
log-bin-index=master-bin.index
rpl_semi_sync_master_enabled=1    #只有安装过半同步复制插件后才可以配置这些参数
rpl_semi_sync_master_timeout=1000
expire_logs_days = 5
binlog_format = row
binlog_row_image = minimal

auto_increment_increment=2
auto_increment_offset=1

```
改完配置重启
```
service mysqld restart
```
###slave 配置/etc/my.cnf

```
#
# This group is read both both by the client and the server
# use it for options that affect everything
#
[client-server]
#
# include all files from the config directory
#
!includedir /etc/my.cnf.d
[mysqld]
skip_name_resolve = ON
innodb_file_per_table = ON
server_id=101
relay_log_index = slave_relay_bin.index
relay_log = slave_relay_bin
#rpl_semi_sync_slave_enabled =1

log-bin=slave-bin
log-bin-index=slave-bin.index
rpl_semi_sync_master_enabled=1    #只有安装过半同步复制插件后才可以配置这些参数
rpl_semi_sync_master_timeout=1000
expire_logs_days = 5
binlog_format = row
binlog_row_image = minimal

auto_increment_increment=2
auto_increment_offset=2

```
改完配置重启
```
service mysqld restart
```
###全量导出master数据库
```
mysqldump -uroot -padmin -q --single-transaction --master-data=2 -A > alldata.sql
```
###数据导入slave
```
mysql -uroot -padmin < alldata.sql
```
或者
```
mysql -uroot -padmin -e "source alldata.sql"
```

###双主设置命令
master执行的命令
```
mysql -uroot -padmin -e "GRANT REPLICATION SLAVE,REPLICATION CLIENT ON  *.* TO  'repluser'@'%'  IDENTIFIED BY '123456'"
mysql -uroot -padmin -e "CHANGE MASTER TO MASTER_HOST='192.168.173.9', MASTER_USER='repluser', MASTER_PASSWORD='123456', MASTER_PORT=3306, MASTER_LOG_FILE='slave-bin.000001', MASTER_LOG_POS=4"
mysql -uroot -padmin -e "show slave status\G"
```
查询master的position位置
```
mysql -uroot -padmin -e "show master status"
```
slave执行的命令
```
mysql -uroot -padmin -e "GRANT REPLICATION SLAVE,REPLICATION CLIENT ON  *.* TO  'repluser'@'%'  IDENTIFIED BY '123456'"
mysql -uroot -padmin -e "CHANGE MASTER TO MASTER_HOST='192.168.173.10', MASTER_USER='repluser', MASTER_PASSWORD='123456', MASTER_PORT=3306, MASTER_LOG_FILE='master-bin.000001', MASTER_LOG_POS=4"
mysql -uroot -padmin -e "show slave status\G"
service cloudstack-management stop
systemctl disable cloudstack-management
```
slave出错时尝试改position位置.
```
mysql -uroot -padmin -e "stop slave"
mysql -uroot -padmin -e "change master to master_log_file='master-bin.000001',master_log_pos=4"
mysql -uroot -padmin -e "start slave"
```
检查状态命令
```
mysql -uroot -padmin -e "show global status like 'rp%'"
mysql -uroot -padmin -e "show processlist"
```
slave启动cloudstack-management服务
```
cloudstack-setup-databases cloud:engine@192.168.173.9
cloudstack-setup-management
```
