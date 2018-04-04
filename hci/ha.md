https://blog.csdn.net/qooer_tech/article/details/72898802
https://blog.csdn.net/jiangshouzhuang/article/details/62461883

service cloudstack-management stop
systemctl disable cloudstack-management



grant replication slave on *.* to 'slaver'@'192.168.173.9' identified by 'engine';
flush privileges;


grant replication slave on *.* to 'slaver'@'192.168.173.10' identified by 'engine';
flush privileges;


###master配置
```
[root@cs-mgr ~]# cat /etc/my.cnf
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
```
###slave 配置

```
[root@cs-mgr-slave management]# cat /etc/my.cnf
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

rpl_semi_sync_slave_enabled =1
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

###主从设置命令
master执行的命令
```
mysql -uroot -padmin -e "GRANT REPLICATION SLAVE,REPLICATION CLIENT ON  *.* TO  'repluser'@'%'  IDENTIFIED BY '123456'"
service mysqld restart
```
查询master的position位置
```
mysql -uroot -padmin -e "show master status"
```
slave执行的命令
```
mysql -uroot -padmin -e "GRANT REPLICATION SLAVE,REPLICATION CLIENT ON  *.* TO  'repluser'@'%'  IDENTIFIED BY '123456'"
mysql -uroot -padmin -e "CHANGE MASTER TO MASTER_HOST='192.168.173.10', MASTER_USER='repluser', MASTER_PASSWORD='123456', MASTER_PORT=3306, MASTER_LOG_FILE='master-bin.000001', MASTER_LOG_POS=4"
service mysqld restart
mysql -uroot -padmin -e "show slave status\G"
```
slave出错时尝试必改position位置.
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
