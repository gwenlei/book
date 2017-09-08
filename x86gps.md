onecloud/src/gps_daemon.c
onecloud/src/common/config.h
onecloud/src/common/onecloud.h
onecloud/src/common/protocol.h
onecloud/src/common/protocol.c
onecloud/Makefile
onecloud/config/onecloud.ini
onecloud/script/gps/getusbno.sh
onecloud/src/monitor_client.c
onecloud/src/watch_dog.c
onecloud/src/watch_dog.h
onecloud/script/startup_one_control.sh
onecloud/script/shutdown_one_control.sh
onecloud/script/watchdog/restart_gps_daemon.sh

chmod +x /opt/onecloud/script/gps/getusbno.sh

onecloud/src/gpsusb_daemon.c
onecloud/script/gpsusb/getusbno.sh
onecloud/script/watchdog/restart_gpsusb_daemon.sh

tar cvf onecloud20170614.tar onecloud --exclude log

 设备管理 - 找到 - " HUAWEIMobile Connect - Control Inter face (com X) " X是端口自己记好 点击PuTTY，进入 PuTTY Configuration 界面， 选择"Serial"，在"Serialline" 中输入 COM X , 然后点击"Open"，之后有新的对话窗口自动打开 输入AT 命令 AT^WPDGP 为激活 GPS AT^WPEND 为关闭 GPS 2：安装AT指令调试精灵的朋友 直接运行修改端口为设备管理 - " HUAWEIMobile Connect - Control Inter face (com X) " X的端口号 点连接 AT指令 填写 AT^WPDGP 或者 AT^WPEND 开关GPS


 推荐定位信息(RMC)

$GPRMC,<1>,<2>,<3>,<4>,<5>,<6>,<7>,<8>,<9>,<10>,<11>,<12>*hh

<1> UTC时间，hhmmss(时分秒)格式 //好像还有毫秒。
<2> 定位状态，A=有效定位，V=无效定位
<3> 纬度ddmm.mmmm(度分)格式(前面的0也将被传输)
<4> 纬度半球N(北半球)或S(南半球)
<5> 经度dddmm.mmmm(度分)格式(前面的0也将被传输)
<6> 经度半球E(东经)或W(西经)
<7> 地面速率(000.0~999.9节，前面的0也将被传输)
<8> 地面航向(000.0~359.9度，以真北为参考基准，前面的0也将被传输)
<9> UTC日期，ddmmyy(日月年)格式
<10> 磁偏角(000.0~180.0度，前面的0也将被传输)
<11> 磁偏角方向，E(东)或W(西)
<12> 模式指示(仅NMEA0183 3.00版本输出，A=自主定位，D=差分，E=估算，N=数据无效)

例：

 

$GPRMC

格式为：
$GPRMC,010101.130, A, 3606.6834,  N,  12021.7778,   E,   0.0,   238.3,  010807,,,A*6C
$GPRMC,   <1>,    <2>,   <3>,    <4>,     <5>,     <6>,  <7>,    <8>,     <9>,

$ pos=0

<1> 当前位置的格林尼治时间，即世界时间，与北京时间差8个小时，格式为hhmmss.ms [pos+6]

<2> 状态, A 为有效位置, V为非有效接收警告，即当前天线视野上方的卫星个数少于3颗。 [pos+17]

注意几点：
1、当GPS数据有效时第17位（一般情况下，程序里最好是找第二个逗号在取下一位判断）为“A”，无效时为“V”；
2、GPS有效时，当速度为0时显示0.0（两位数），当速度不为0时小数点前面数据根据情况变化，最大为三位，此处速度单位为节（海里），需要做处理才能得到我们习惯的单位（公里/小时）；
3、GPS无效时，除了第17位显示V以外，不输入速度，角度数据；
4、当给GPS复位时第17位为V，不输出速度，角度，时间数据。

小结：通过对GPRMC关键字字符串的分析可以后的，经纬度，速度，运动方向角和时间（可以作为数据库存储的依据）等又有信息，但是缺少一个海拔信息（三维拟合包括经纬度确定的平面和加入海拔高度后的空间信息）。海拔信息应该是可以算的，应该用卫星的高度和方向角就可以。

 GPS固定数据输出语句($GPGGA)

 

这是一帧GPS定位的主要数据，也是使用最广的数据。
$GPGGA 语句包括17个字段：语句标识头，世界时间，纬度，纬度半球，经度，经度半球，定位质量指示，使用卫星数量，水平精确度，海拔高度，高度单位，大地水准面高度，高度单位，差分GPS数据期限，差分参考基站标号，校验和结束标记(用回车符<CR>和换行符<LF>)，分别用14个逗号进行分隔。该数据帧的结构及各字段释义如下：

$GPGGA,<1>,<2>,<3>,<4>,<5>,<6>,<7>,<8>,<9>,M,<10>,M,<11>,<12>*xx<CR><LF>

$GPGGA：起始引导符及语句格式说明(本句为GPS定位数据)；

<1>  UTC时间，格式为hhmmss.sss；
<2>  纬度，格式为ddmm.mmmm(第一位是零也将传送)；
<3>  纬度半球，N或S(北纬或南纬)
<4>  经度，格式为dddmm.mmmm(第一位零也将传送)；
<5>  经度半球，E或W(东经或西经)
<6>  定位质量指示，0=定位无效，1=定位有效；
<7>  使用卫星数量，从00到12(第一个零也将传送)
<8>  水平精确度，0.5到99.9
<9>  天线离海平面的高度，-9999.9到9999.9米
M    指单位米
<10> 大地水准面高度，-9999.9到9999.9米
M    指单位米
<11> 差分GPS数据期限(RTCM SC-104)，最后设立RTCM传送的秒数量

<12>  差分参考基站标号，从0000到1023(首位0也将传送)。

*    语句结束标志符
xx    从$开始到*之间的所有ASCII码的异或校验和
<CR>   回车
<LF>   换行


 

可视卫星状态输出语句($GPGSV) 　 　　
例2：$GPGSV，2，1，08，06，33，240，45，10，36，074，47，16，21，078，44，17，36，313，42*78 　　
标准格式： 　　$GPGSV，(1)，(2)，(3)，(4)，(5)，(6)，(7)，…(4),(5)，(6)，(7)*hh(CR)(LF) 　　
各部分含义为： 　　
(1)总的GSV语句电文数；2;
(2)当前GSV语句号:1; 　　
(3)可视卫星总数:08; 　　
(4)卫星号:06; 　　
(5)仰角(00～90度):33度; 　　
(6)方位角(000～359度):240度; 　　
(7)信噪比(00～99dB):45dB(后面依次为第10，16，17号卫星的信息); 　　
*总和校验域；　　
hh 总和校验数:78; 　　
(CR)(LF)回车，换行。 　　
注：每条语句最多包括四颗卫星的信息，每颗卫星的信息有四个数据项，即：　　
(4)－卫星号，(5)－仰角，(6)－方位角，(7)－信噪比。

当前卫星信息($GSA)
$GPGSA,<1>,<2>,<3>,<3>,,,,,<3>,<3>,<3>,<4>,<5>,<6>,<7>

<1>模式 ：M = 手动， A = 自动。
<2>定位型式 1 = 未定位， 2 = 二维定位， 3 = 三维定位。
<3>PRN 数字：01 至 32 表天空使用中的卫星编号，最多可接收12颗卫星信息。
<4> PDOP位置精度因子(0.5~99.9)
<5> HDOP水平精度因子(0.5~99.9)
<6> VDOP垂直精度因子(0.5~99.9)
<7> Checksum.(检查位).


地面速度信息(VTG)
$GPVTG,<1>,T,<2>,M,<3>,N,<4>,K,<5>*hh
<1> 以真北为参考基准的地面航向(000~359度，前面的0也将被传输)
<2> 以磁北为参考基准的地面航向(000~359度，前面的0也将被传输)
<3> 地面速率(000.0~999.9节，前面的0也将被传输)
<4> 地面速率(0000.0~1851.8公里/小时，前面的0也将被传输)
<5> 模式指示(仅NMEA0183 3.00版本输出，A=自主定位，D=差分，E=估算，N=数据无效)

 
[14:42:58.978] $GPGSV,1,1,00*79

[14:42:58.978] $GPGGA,,,,,,0,,,,,,,,*66

[14:42:58.978] $GPRMC,,V,,,,,,,,,,N*53

[14:42:58.978] $GPGSA,A,1,,,,,,,,,,,,,,,*1E

[14:42:58.978] $GPVTG,,T,,M,,N,,K*4E



[17:17:14.912] $GPGSV,4,1,13,08,35,278,,02,31,282,,19,30,310,31,04,33,035,*7C

[17:17:14.912] $GPGSV,4,2,13,29,26,061,,07,20,189,,28,34,171,,32,46,132,*79

[17:17:14.912] $GPGSV,4,3,13,22,23,052,43,17,42,336,43,11,10,054,37,03,42,075,37*7B

[17:17:14.912] $GPGSV,4,4,13,01,20,037,36*49

[17:17:14.912] $GPGGA,091728.0,2305.756895,N,11317.125675,E,1,06,5.2,34.0,M,,,,*3F

[17:17:14.912] $GPRMC,091728.0,A,2305.756895,N,11317.125675,E,,,310517,,,A*69

[17:17:14.912] $GPGSA,A,3,01,03,11,17,19,22,,,,,,,7.5,5.2,5.4*3A

[17:17:14.912] $GPVTG,,T,,M,0.0,N,0.0,K*4E




[root@bogon onecloud]# ls -rtlh src
total 344K
-rw-r--r--. 1 root root  483 Apr 27 09:26 script.h
-rw-r--r--. 1 root root  129 Apr 27 09:26 uart.h
-rw-r--r--. 1 root root  149 Apr 27 09:26 http_sign.h
drwxrwxr-x. 2 root root 4.0K Apr 27 09:26 util
-rw-r--r--. 1 root root  125 Apr 27 09:26 sim.h
-rw-r--r--. 1 root root 1.4K Apr 27 09:26 watch_dog.h
-rw-r--r--. 1 root root 2.3K Apr 27 09:26 gpio.h
-rw-r--r--. 1 root root 1.3K Apr 27 09:26 app.h
-rw-r--r--. 1 root root  141 Apr 27 09:26 monitor.h
drwxrwxr-x. 2 root root 4.0K May  2 09:32 common
-rw-r--r--. 1 root root 2.7K May  2 11:22 http_sign.c
-rw-r--r--. 1 root root 5.6K May  2 11:22 monitor_client.c
-rw-r--r--. 1 root root  25K May  4 09:57 watch_dog.c
-rw-r--r--. 1 root root 8.2K May 10 11:47 electricity_ctrl.c
-rw-r--r--. 1 root root  63K May 11 17:33 app_service.cpp
-rw-r--r--. 1 root root  12K May 16 09:35 com_daemon.c
-rw-r--r--. 1 root root  29K May 16 09:35 electricity_daemon.c
-rw-r--r--. 1 root root  28K May 16 09:35 gpio_daemon.c
-rw-r--r--. 1 root root  46K May 16 09:35 main_daemon.c
-rw-r--r--. 1 root root  34K May 16 09:35 script_daemon.c
-rw-r--r--. 1 root root  12K May 16 09:35 sim_daemon.c
-rw-r--r--. 1 root root  17K May 16 09:35 temperature_daemon.c

/opt/onecloud
scp -r src root@192.168.0.240:/opt/onecloud
scp -r script root@192.168.0.240:/opt/onecloud



[    7.287273] usbcore: registered new interface driver option
[    7.287302] usbserial: USB Serial support registered for GSM modem (1-port)
[    7.287361] option 1-1.1:1.0: GSM modem (1-port) converter detected
[    7.292214] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB0
[    7.292250] option 1-1.1:1.1: GSM modem (1-port) converter detected
[    7.302760] alg: No test for crc32 (crc32-pclmul)
[    7.321408] EXT4-fs (sda1): re-mounted. Opts: (null)
[    7.325308] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB1
[    7.325345] option 1-1.1:1.2: GSM modem (1-port) converter detected
[    7.325583] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB2
[    7.325609] option 1-1.1:1.3: GSM modem (1-port) converter detected
[    7.325732] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB3
[    7.325750] option 1-1.1:1.4: GSM modem (1-port) converter detected
[    7.325868] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB4
[    7.325886] option 1-1.1:1.5: GSM modem (1-port) converter detected
[    7.326003] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB5




[    7.354316] usbserial: USB Serial support registered for GSM modem (1-port)
[    7.354367] option 1-1.1:1.0: GSM modem (1-port) converter detected
[    7.354625] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB0
[    7.354655] option 1-1.1:1.1: GSM modem (1-port) converter detected
[    7.355623] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB1
[    7.355657] option 1-1.1:1.2: GSM modem (1-port) converter detected
[    7.356272] usb 1-1.4.1: pl2303 converter now attached to ttyUSB3
[    7.356348] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB2
[    7.371505] usbcore: registered new interface driver ch341
[    7.371543] usbserial: USB Serial support registered for ch341-uart
[    7.371564] ch341 1-1.4.4:1.0: ch341-uart converter detected
[    7.375760] usb 1-1.4.4: ch341-uart converter now attached to ttyUSB4


[    5.274137] usb 1-1.1: New USB device found, idVendor=12d1, idProduct=1001
[    5.274143] usb 1-1.1: New USB device strings: Mfr=3, Product=2, SerialNumber=0
[    5.274147] usb 1-1.1: Product: HUAWEI MOBILE WCDMA EM770


Jun  6 22:42:43 localhost kernel: PPP generic driver version 2.4.2
Jun  6 22:42:43 localhost pppd[1190]: pppd 2.4.5 started by root, uid 0
Jun  6 22:42:43 localhost pppd[1190]: Using interface ppp0
Jun  6 22:42:43 localhost pppd[1190]: Connect: ppp0 <--> /dev/ttyUSB0
Jun  6 22:42:43 localhost pppd[1190]: CHAP authentication succeeded
Jun  6 22:42:43 localhost pppd[1190]: CHAP authentication succeeded
Jun  6 22:42:43 localhost kernel: PPP BSD Compression module registered
Jun  6 22:42:43 localhost kernel: PPP Deflate Compression module registered
Jun  6 22:42:45 localhost pppd[1190]: Could not determine remote IP address: defaulting to 10.64.64.64
Jun  6 22:42:45 localhost pppd[1190]: local  IP address 10.129.209.75
Jun  6 22:42:45 localhost pppd[1190]: remote IP address 10.64.64.64
Jun  6 22:42:45 localhost pppd[1190]: primary   DNS address 210.21.4.130
Jun  6 22:42:45 localhost pppd[1190]: secondary DNS address 221.5.88.88





[root@localhost tmp]# ./send 0
test size=8.
Target device is /dev/ttyUSB0.
Initialize /dev/ttyUSB0 success.
ret = 0
select: Resource temporarily unavailable
uart receive 
^CSIGINT handled.
Info: Now stop COM send demo.
[root@localhost tmp]# ./send 1
test size=8.
Target device is /dev/ttyUSB1.
Initialize /dev/ttyUSB1 success.
send 28 byte data
ret = 0
select: Success
uart receive 
ret = 0
select: Success
uart receive 
^CSIGINT handled.
Info: Now stop COM send demo.
[root@localhost tmp]# ./send 2
test size=8.
Target device is /dev/ttyUSB2.
Initialize /dev/ttyUSB2 success.
send 28 byte data
ret = 1
len = 28
uart receive AT^WPDGP\r\n
ret = 0
select: Success
uart receive 
ret = 1
len = 11
uart receive 
^RSSI:9

ret = 1
len = 27
uart receive 
^BOOT:26417135,0,0,0,20

ret = 0
select: Success
uart receive 
^CSIGINT handled.
Info: Now stop COM send demo.


[root@localhost tmp]# ./send 3
test size=8.
Target device is /dev/ttyUSB3.
Initialize /dev/ttyUSB3 success.
send 28 byte data
ret = 0
select: Success
uart receive 
ret = 0
select: Success
uart receive 
^CSIGINT handled.
Info: Now stop COM send demo.
^C
^C^C^C[root@localhost tmp]# ./send 4
test size=8.
Target device is /dev/ttyUSB4.
Initialize /dev/ttyUSB4 success.
send 28 byte data
ret = 0
select: Success
uart receive 
ret = 0
select: Success
uart receive 
^CSIGINT handled.
Info: Now stop COM send demo.
[root@localhost tmp]# ./send 5
test size=8.
Target device is /dev/ttyUSB5.
Initialize /dev/ttyUSB5 success.
send 28 byte data
ret = 0
select: Success
uart receive 
^CSIGINT handled.
Info: Now stop COM send demo.

