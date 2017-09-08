yum install -y sdcc*
yum install -y avr*
sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config


curl -u 'gwenlei' https://api.github.com/user/repos -d '{"name":"ubuntux86"}'
git remote add origin https://github.com/gwenlei/ubuntux86.git
git add -A
git commit -m all
git push origin master

  git config --global user.email "nomatter_lsj@163.com"
  git config --global user.name "gwenlei"



dmesg|grep usb



-lpthread
gcc two.c -o two -lpthread

apt install make
apt install gdb
apt install valgrind

root@ubuntu:/home/clouder/OneCloud# ./bin/main_daemon
./bin/monitor_client type=cabinet

Debug: read package data (socket[4]).
Debug:      [FA FA FA FA 00 00 00 00  01 00 00 00 08 00 00 00]
Debug:      [01 00 00 00 00 00 00 00  00 00 00 00 FB FB FB FB]
Info: check package from socket[4] success.
Info: write socket[64] 64 bytes
Debug: write package data (socket[4]).(64/64)
Debug:      [FA FA FA FA 00 00 00 00  01 00 01 00 28 00 00 00]
Debug:      [01 00 01 00 01 00 00 00  BB 70 BE 58 00 00 00 00]
Debug:      [00 00 F6 42 00 00 5C 43  00 00 20 40 9A 99 2D 42]
Debug:      [00 00 00 00 00 00 00 00  00 00 00 00 FB FB FB FB]
terminating current client_connection...


Info: read socket[3] 56 bytes
Debug: read package data (socket[3]).
Debug:      [FA FA FA FA 00 00 00 00  03 00 01 00 20 00 00 00]
Debug:      [07 00 01 00 00 00 00 00  DA 10 C9 58 00 00 00 00]
Debug:      [00 02 00 00 00 00 00 00  00 00 00 00 00 00 00 00]
Debug:      [00 00 00 00 FB FB FB FB  ]
Info: check package from socket[3] success.
Debug: frame->prefix = FAFAFAFA 
Debug: frame->magic = 00000000 
Debug: frame->command = 00010003 
Debug: frame->length = 00000020 
Debug: frame->data = [
Debug:      [07 00 01 00 00 00 00 00  DA 10 C9 58 00 00 00 00]
Debug:      [00 02 00 00 00 00 00 00  00 00 00 00 00 00 00 00]
Debug:               ]
Debug: frame->crc = 00000000 
Debug: frame->suffix = FBFBFBFB 
Info: result=0 

Info: A new connection occurs!
Info: waiting for new connection...
Info: read socket[5] 36 bytes
Debug: read package data (socket[5]).
Debug:      [FA FA FA FA 00 00 00 00  07 00 00 00 0C 00 00 00]
Debug:      [07 00 00 00 01 00 00 00  00 00 00 00 00 00 00 00]
Debug:      [FB FB FB FB ]
Info: check package from socket[5] success.
request->event=[1]
io_status=[512][200]
event=[1]
Info: write socket[56] 56 bytes
Debug: write package data (socket[5]).(56/56)
Debug:      [FA FA FA FA 00 00 00 00  03 00 01 00 20 00 00 00]
Debug:      [07 00 01 00 00 00 00 00  DA 10 C9 58 00 00 00 00]
Debug:      [00 02 00 00 00 00 00 00  00 00 00 00 00 00 00 00]
Debug:      [00 00 00 00 FB FB FB FB  ]
terminating current client_connection...

gcc -lpthread -lrt -o bin/gpio_daemon ./obj/gpio_daemon.o ./obj/common/protocol.o ./obj/common/net.o ./obj/common/config.o  ./obj/util/string_helper.o ./obj/util/log_helper.o ./obj/util/date_helper.o ./obj/util/thread_helper.o

gcc -lrt -o bin/gpio_daemon_test ./obj/gpio_daemon_test.o ./obj/common/protocol.o ./obj/common/net.o ./obj/common/config.o  ./obj/util/string_helper.o ./obj/util/log_helper.o ./obj/util/date_helper.o ./obj/util/thread_helper.o -lpthread 

g++ -g -O0 -Wall -fno-strict-aliasing -lpthread -lrt -I./ -I./src/ -c src/gpio_daemon_test.c -o obj/gpio_daemon_test.o


g++ -g -O0 -Wall -fno-strict-aliasing -lpthread -lrt -I./ -I./src/ -c src/common/protocol.c -o obj/common/protocol.o

g++ -g -O0 -Wall -fno-strict-aliasing -lpthread -lrt -I./ -I./src/ -c src/util/thread_helper.c -o obj/util/thread_helper.o
g++ -lpthread -lrt -o bin/main_daemon ./obj/main_daemon.o ./obj/common/protocol.o ./obj/common/net.o ./obj/common/config.o  ./obj/util/string_helper.o ./obj/util/log_helper.o ./obj/util/date_helper.o ./obj/util/thread_helper.o


scp /home/clouder/OneCloud/src/gpio.h /home/clouder/OneCloud/src/gpio_daemon.c root@192.168.0.168:/opt/onecloud/src
scp /home/clouder/Desktop/OneCloud/src/gpio.h /home/clouder/Desktop/OneCloud/src/gpio_daemon.c root@192.168.0.168:/opt/onecloud/src

nohup /opt/onecloud/bin/gpio_daemon >> /var/log/gpio_daemon.log 2>&1 &

make ./bin/gpio_daemon


[root@pc134 Desktop]# lsusb
Bus 006 Device 002: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

[root@pc134 Desktop]# lsusb
Bus 006 Device 003: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

[root@pc134 Desktop]# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

[ 8985.313911] usb 6-1: ch341-uart converter now attached to ttyUSB0


setserial -a /dev/ttyS0


root@ubuntu:~# lsusb
Bus 001 Device 004: ID 05e3:0608 Genesys Logic, Inc. Hub
Bus 001 Device 003: ID 12d1:1001 Huawei Technologies Co., Ltd. E169/E620/E800 HSDPA Modem
Bus 001 Device 002: ID 8087:07e6 Intel Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
root@ubuntu:~# lsusb
Bus 001 Device 005: ID 2a03:0043 dog hunter AG Arduino Uno Rev3
Bus 001 Device 004: ID 05e3:0608 Genesys Logic, Inc. Hub
Bus 001 Device 003: ID 12d1:1001 Huawei Technologies Co., Ltd. E169/E620/E800 HSDPA Modem
Bus 001 Device 002: ID 8087:07e6 Intel Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


[   11.981531] r8169 0000:01:00.0 enp1s0: link up
[   11.981550] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
[   33.751837] random: nonblocking pool is initialized
[21150.343327] usb 1-1.4.1: new full-speed USB device number 5 using ehci-pci
[21150.442948] usb 1-1.4.1: New USB device found, idVendor=2a03, idProduct=0043
[21150.442959] usb 1-1.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=220
[21150.442965] usb 1-1.4.1: Product: Arduino Uno
[21150.442971] usb 1-1.4.1: Manufacturer: Arduino Srl            
[21150.442976] usb 1-1.4.1: SerialNumber: 85635303233351C06201
[21150.459268] cdc_acm 1-1.4.1:1.0: ttyACM0: USB ACM device
[21150.460003] usbcore: registered new interface driver cdc_acm
[21150.460010] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters


wget -c http://download.processing.org/processing-3.3-linux64.tgz
git clone https://github.com/processing/processing.git
https://github.com/processing/processing/wiki/Build-Instructions
git clone https://github.com/processing/processing.git --depth 1

onecloud/config/onecloud.ini
onecloud/src/common/onecloud.h
onecloud/src/common/config.h
onecloud/src/common/protocol.h
onecloud/src/common/protocol.c
onecloud/src/src/temperature_daemon.c
onecloud/Makefile
onecloud/script/temperature/getusbno.sh


onecloud/config/onecloud.ini
[temperature]
debug=1
listen_port=17016


onecloud/src/common/onecloud.h
#define OC_TEMPERATURE_PORT			17016

onecloud/src/common/config.h
struct settings {
	int role;				// Daemon business role
	int main_listen_port;	// Main daemon listen port
	int watchdog_port;		// WatchDog listen port
	int sim_port;			// SIM daemon listen port
	int gpio_port;			// GPIO daemon listen port
	int script_port;		// Script daemon listen port
	int app_port;			// App service daemon listen port
	int temperature_port;	// Temperature daemon listen port

// Daemon business role
enum daemon_business_role {
	role_main = 0,
	role_watchdog = 1,
	role_sim = 2,
	role_gpio = 3,
	role_script = 4,
	role_uart_com = 5,
	role_app_service = 6,
	role_temperature = 7
};

// Daemon business role
enum daemon_device_proc {
	device_proc_main = 0,
	device_proc_watchdog = 1,
	device_proc_sim = 2,
	device_proc_gpio = 3,
	device_proc_script = 4,
	device_proc_app_service = 6,
	device_proc_uart_com0 = 7,
	device_proc_uart_com1 = 8,
	device_proc_uart_com2 = 9,
	device_proc_uart_com3 = 10,
	device_proc_uart_com4 = 11,
	device_proc_uart_com5 = 12,
	device_temperature = 13
};

#define SECTION_TEMPERATURE	"temperature"

onecloud/src/common/protocol.h
#define OC_REQ_QUERY_TEMPERATURE		0x00000010

/**
 *  Command definition : Temperature query
 *  request format:
 *    ---------------------
 *    | command |  flag   |
 *    ---------------------
 *    |4 Byte   | 4 Byte  |
 *
 *  response format:
 *    -----------------------------------------------------------------
 *    | command | result | timestamp | error no | t1      | t2        |
 *    -----------------------------------------------------------------
 *    |4 Byte   | 4 Byte |  4 Byte   | 4 Byte   | 4 Byte  | 4 Byte    |
 */

/* Request : Temperature query*/
typedef struct oc_cmd_query_temperature_req{
	uint32_t command;			//command
	uint32_t flag;			    //reserved
} OC_CMD_QUERY_TEMPERATURE_REQ;

/* Response : Temperature query*/
typedef struct oc_cmd_query_temperature_resp{
	uint32_t command;			//command
	uint32_t result;			//0: completed normal, 1: catch error.
	time_t timestamp;			//current time
	uint32_t error_no;			//error code
	float t1;			//t1
	float t2;			//t2
} OC_CMD_QUERY_TEMPERATURE_RESP;

///////////////////////////////////////////////////////////
// Command function: Temperature query
///////////////////////////////////////////////////////////

/**
 * Generate request command: Temperature query.
 */
int generate_cmd_query_temperature_req(OC_CMD_QUERY_TEMPERATURE_REQ ** out_req,	uint32_t flag);

/**
 * Generate response command: Temperature query.
 */
int generate_cmd_query_temperature_resp(OC_CMD_QUERY_TEMPERATURE_RESP ** out_resp, uint32_t exec_result, uint32_t error_no);

/**
 * Translate request command to buffer: Temperature query.
 */
int translate_cmd2buf_query_temperature_req(OC_CMD_QUERY_TEMPERATURE_REQ * req,	uint8_t** out_buf, int* out_buf_len);

/**
 * Translate response command to buffer: Temperature query.
 */
int translate_cmd2buf_query_temperature_resp(OC_CMD_QUERY_TEMPERATURE_RESP* resp, uint8_t** out_buf, int* out_buf_len);

/**
 * Translate buffer to request command: Temperature query.
 */
int translate_buf2cmd_query_temperature_req(uint8_t* in_buf, OC_CMD_QUERY_TEMPERATURE_REQ** out_req);

/**
 * Translate buffer to response command: Temperature query.
 */
int translate_buf2cmd_query_temperature_resp(uint8_t* in_buf, OC_CMD_QUERY_TEMPERATURE_RESP ** out_resp);

onecloud/src/common/protocol.c
///////////////////////////////////////////////////////////
// Command function: Temperature query
///////////////////////////////////////////////////////////

/**
 * Generate request command: Temperature query.
 */
int generate_cmd_query_temperature_req(OC_CMD_QUERY_TEMPERATURE_REQ ** out_req,
		uint32_t flag) {
	int result = OC_SUCCESS;

	OC_CMD_QUERY_TEMPERATURE_REQ* req = (OC_CMD_QUERY_TEMPERATURE_REQ*) malloc(
			sizeof(OC_CMD_QUERY_TEMPERATURE_REQ));
	req->command = OC_REQ_QUERY_TEMPERATURE;
	req->flag = flag;

	*out_req = req;

	return result;
}

/**
 * Generate response command: Temperature query.
 */
int generate_cmd_query_temperature_resp(OC_CMD_QUERY_TEMPERATURE_RESP ** out_resp,
		uint32_t exec_result, uint32_t error_no, float t1, float t2) {
	int result = OC_SUCCESS;

	OC_CMD_QUERY_TEMPERATURE_RESP* resp = (OC_CMD_QUERY_TEMPERATURE_RESP*) malloc(
			sizeof(OC_CMD_QUERY_TEMPERATURE_RESP));
	memset((void*) resp, 0, sizeof(OC_CMD_QUERY_TEMPERATURE_RESP));

	resp->command = OC_REQ_QUERY_TEMPERATURE | OC_RESPONSE_BIT;
	resp->result = exec_result;
	resp->timestamp = time(NULL);
	resp->error_no = error_no;
	resp->t1 = t1;
	resp->t2 = t2;

	*out_resp = resp;

	return result;
}

/**
 * Translate request command to buffer: Temperature query.
 */
int translate_cmd2buf_query_temperature_req(OC_CMD_QUERY_TEMPERATURE_REQ * req,
		uint8_t** out_buf, int* out_buf_len) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_TEMPERATURE_REQ);
	uint8_t* buffer = (uint8_t*) malloc(buf_len);

	memcpy((void*) buffer, (void*) req, buf_len);

	*out_buf = buffer;
	*out_buf_len = buf_len;

	return result;
}

/**
 * Translate response command to buffer: Temperature query.
 */
int translate_cmd2buf_query_temperature_resp(OC_CMD_QUERY_TEMPERATURE_RESP* resp,
		uint8_t** out_buf, int* out_buf_len) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_TEMPERATURE_RESP);
	uint8_t* buffer = (uint8_t*) malloc(buf_len);

	memcpy((void*) buffer, (void*) resp, buf_len);

	*out_buf = buffer;
	*out_buf_len = buf_len;

	return result;
}

/**
 * Translate buffer to request command: Temperature query.
 */
int translate_buf2cmd_query_temperature_req(uint8_t* in_buf,
		OC_CMD_QUERY_TEMPERATURE_REQ** out_req) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_TEMPERATURE_REQ);
	OC_CMD_QUERY_TEMPERATURE_REQ* req = (OC_CMD_QUERY_TEMPERATURE_REQ*) malloc(buf_len);

	memcpy((void*) req, (void*) in_buf, buf_len);

	*out_req = req;

	return result;
}

/**
 * Translate buffer to response command: Temperature query.
 */
int translate_buf2cmd_query_temperature_resp(uint8_t* in_buf,
		OC_CMD_QUERY_TEMPERATURE_RESP ** out_resp) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_TEMPERATURE_RESP);
	OC_CMD_QUERY_TEMPERATURE_RESP* resp = (OC_CMD_QUERY_TEMPERATURE_RESP*) malloc(
			buf_len);

	memcpy((void*) resp, (void*) in_buf, buf_len);

	*out_resp = resp;

	return result;
}


