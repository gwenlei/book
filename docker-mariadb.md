docker run -it centos7 bash
yum install -y mariadb*
mysql_install_db --user=mysql --ldata=/var/lib/mysql/ --basedir=/usr > /dev/null 2>&1
/usr/bin/mysqld_safe > /dev/null 2>&1 &
