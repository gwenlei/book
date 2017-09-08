tar cvf onecloud20170629.tar onecloud --exclude log

onecloud/src/lbs_daemon.c
onecloud/src/common/config.h
onecloud/src/common/onecloud.h
onecloud/src/common/protocol.h
onecloud/src/common/protocol.c
onecloud/Makefile
onecloud/config/onecloud.ini
onecloud/script/lbs/getusbno.sh

onecloud/src/monitor_client.c
onecloud/src/watch_dog.c
onecloud/src/watch_dog.h
onecloud/script/startup_one_control.sh
onecloud/script/shutdown_one_control.sh
onecloud/script/watchdog/restart_lbs_daemon.sh


onecloud/src/common/config.h 配置太多要修改最大值
#define MAX_SECTION_NUM 20

Debug: uart receive [

+CREG: 2,1, A656, 252F



OK

]
Debug: uart receive +CREG!!
Debug: lac [42582] ci[9519]

http://api.cellocation.com/cell/?mcc=460&mnc=1&lac=42582&ci=9519&output=xml
<response><errcode>0</errcode><lat>23.098095</lat><lon>113.284004</lon><radius>381</radius><address>广东省广州市海珠区新港街道中山大学园西区756号楼;怡乐路与金禧路路口东南125米</address></response>
http://api.cellocation.com/cell/?mcc=460&mnc=1&lac=42582&ci=17938&output=xml
<response><errcode>0</errcode><lat>23.096020</lat><lon>113.283127</lon><radius>134</radius><address>广东省广州市海珠区新港街道A520(怡乐路总店);怡乐路与金禧路路口南295米</address></response>




In AT Command Interface Specification, Huawei mention that ^BOOT unsolicited command only for the Huawei specified client, nothing specific.

You can disable all unsolicited result by the following AT command:

AT^CURC=0

To enable it back just change 0 to 1:

AT^CURC=1


