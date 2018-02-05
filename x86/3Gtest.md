#### 测试目标
以下测试物联卡在工控机的联网情况，包括信号、时延、网速、流量。
#### 工控机安装网络监测工具
```
yum install -y epel-release
yum install -y iftop nethogs python2-speedtest-cli iptraf-ng tcpdump wireshark
```
#### 检测方法
抓包内容
```
tcpdump -n -i ppp0
```
检测时延
```
ping www.baidu.com
```
检测网速
```
speedtest-cli
```
检测网卡流量
```
iftop -i ppp0
```
检测进程流量
```
nethogs
```
检测网卡、协议、端口流量
```
iptraf-ng
```
#### 检测结果

||上传|下载|频率|
|------|---------|--------|--------|
|操作请求|111B|265B|偶尔|
|上报数据|674B|469B|1分钟|
|其他|0.1KB|0.1KB|1秒|
|汇总|8MB|8MB|1天|
其他是指拨号程序、域名解析、时间同步等消耗流量的程序。数据均为估算值。
1. 贴片天线的时延(500ms)比普通天线(350ms)稍长，都超过300ms。
2. 物联卡上传速度1.15Mbit/s 下载速度0.9Mbit/s，不同时段不一样(下午较快，早上较慢)，不是很稳定。
3. 后附测试截图。

#### 抓包内容
![pic01](newdata/tcpdump2.png)
![pic02](newdata/tcpdump1.png)
#### 贴片天线数据
![pic1](newdata/ping2.png)
![pic2](newdata/nethogs2.png)
![pic3](newdata/iftop2.png)
![pic4](newdata/iptrafinter2.png)
![pic5](newdata/iptrafport.png)
![pic6](newdata/iptrafproto.png)
#### 普通3G天线数据
![pic11](newdata/ping.png)
![pic12](newdata/nethogs.png)
![pic13](newdata/iftop.png)
![pic14](newdata/iptrafinter2.png)
![pic15](newdata/iptraf2.png)
![pic16](newdata/iptrafproto2.png)


