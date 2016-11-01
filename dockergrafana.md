root@192.168.1.79:/lib/systemd/system

cat /home/export.tar | sudo docker import - busybox-1-export:latest

Save命令用于持久化镜像（不是容器）。所以，我们就需要通过以下方法得到镜像名称：
sudo docker images
sudo docker save busybox-1 > /home/save.tar
docker load < /home/save.tar
docker rmi busybox


Export命令用于持久化容器（不是镜像）。所以，我们就需要通过以下方法得到容器ID：
sudo docker ps -a
sudo docker export <CONTAINER ID> > /home/export.tar
cat /home/export.tar | sudo docker import - busybox-1-export:latest

docker save andreasjansson/collectd-write-graphite > /home/clouder/leisj/collectd-write-graphite.tar
docker save sitespeedio/graphite > /home/clouder/leisj/graphite.tar
docker save grafana/grafana > /home/clouder/leisj/grafana.tar


docker load < /home/img/dockergrafana/collectd-write-graphite.tar
docker load < /home/img/dockergrafana/graphite.tar
docker load < /home/img/dockergrafana/grafana.tar

➜  leisj docker ps
CONTAINER ID        IMAGE                                    COMMAND                  CREATED             STATUS              PORTS                                                   NAMES
de231c85f451        sameersbn/squid:3.3.8-16                 "/sbin/entrypoint.sh"    12 weeks ago        Up 12 days          0.0.0.0:3128->3128/tcp                                  squid
62abf18fe98b        sameersbn/gitlab:8.9.6                   "/sbin/entrypoint.sh "   3 months ago        Up 12 days          443/tcp, 0.0.0.0:10022->22/tcp, 0.0.0.0:10080->80/tcp   gitlab
65d1e36c9748        sameersbn/redis:latest                   "/sbin/entrypoint.sh"    3 months ago        Up 12 days          6379/tcp                                                gitlab-redis
323ec569a861        sameersbn/postgresql:9.4-22              "/sbin/entrypoint.sh"    3 months ago        Up 12 days          5432/tcp                                                gitlab-postgresql
46e06d8b463a        sitespeedio/graphite                     "/sbin/my_init"          4 months ago        Up 12 days          0.0.0.0:2003->2003/tcp, 0.0.0.0:8080->80/tcp            graphite
6541049c627b        andreasjansson/collectd-write-graphite   "/bin/sh -c start_con"   4 months ago        Up 12 days                                                                  collectd
a7be1847fbc3        grafana/grafana                          "/run.sh"                4 months ago        Up 12 days          0.0.0.0:3000->3000/tcp                                  grafana


root@kspc-01:/# ps -efl
F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
4 S root         1     0  0  80   0 -  1119 wait   01:15 ?        00:00:00 /bin/sh -c start_container
0 S root         7     1  0  80   0 -  4503 wait   01:15 ?        00:00:00 /bin/bash /usr/bin/start_container
0 S root        11     7  0  80   0 - 192247 hrtime 01:16 ?       00:00:04 collectd -f
4 S root        22     0  0  80   0 -  4501 pipe_w 02:41 ?        00:00:00 bash
4 S root        28     0  0  80   0 -  4548 wait   02:43 ?        00:00:00 bash
0 R root        42    28  0  80   0 -  8599 -      02:44 ?        00:00:00 ps -efl


root@a7be1847fbc3:/# ps -efl
F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
4 S grafana      1     0  0  80   0 - 198158 -     01:15 ?        00:00:01 /usr/sbin/grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafan
4 S root        26     0  0  80   0 -  5055 wait   02:48 ?        00:00:00 bash
0 R root        32    26  0  80   0 -  4375 -      02:48 ?        00:00:00 ps -efl


sudo docker run -d -p 3000:3000 --name grafana grafana/grafana
sudo docker run -d -p 2003:2003 -p 8080:80 --name graphite sitespeedio/graphite /sbin/my_init
sudo docker run -d --name collectd andreasjansson/collectd-write-graphite /bin/sh -c start_container


sudo docker run -it andreasjansson/collectd-write-graphite /bin/sh

sudo docker exec -it 6541049c627b bash
sudo docker exec graphite cat /sbin/my_init

http://192.168.1.79:3000/


curl -u 'gwenlei' https://api.github.com/user/repos -d '{"name":"docker-grafana"}'
git clone https://github.com/gwenlei/docker-grafana.git
ansible-galaxy init docker-grafana --force


vagrant@vagrant:/lib/systemd/system$ sudo systemctl enable collectddocker.service
Created symlink from /etc/systemd/system/multi-user.target.wants/collectddocker.service to /lib/systemd/system/collectddocker.service.

rename .json .jsonwait *.json
mv ubuntu.jsonwait ubuntu.json
mv ubuntu1604_Docker-grafana.jsonwait ubuntu1604_Docker-grafana.json

ln -s /home/img/dockergrafana /home/html

cp -r /home/Oneclick/OnecloudPlaybooks/Docker-grafana /home/BuildOneClick_1404final/OnecloudPlaybooks

qemu-img convert -f qcow2 -c -O qcow2 /home/BuildOneClick_1404final/CloudStackTemplate-Docker-grafana/ubuntu1604-Docker-grafana.qcow2 /home/BuildOneClick_1404final/CloudStackTemplate-Docker-grafana/ubuntu1604-Docker-grafana2.qcow2


/root/.cloudmonkey

