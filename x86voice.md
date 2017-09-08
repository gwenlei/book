onecloud/config/onecloud.ini
onecloud/script/voice/getusbno.sh


onecloud/src/voice_daemon.c
onecloud/src/common/config.h
onecloud/src/common/onecloud.h
onecloud/src/common/protocol.h
onecloud/src/common/protocol.c
onecloud/Makefile
onecloud/config/onecloud.ini
onecloud/src/watch_dog.c
onecloud/src/watch_dog.h
onecloud/script/startup_one_control.sh
onecloud/script/shutdown_one_control.sh
onecloud/script/watchdog/restart_voice_daemon.sh

onecloud/src/common/protocol.h
/**
 *  Command definition : Voice query
 *  request format:
 *    ---------------------
 *    | command |  flag   |
 *    ---------------------
 *    |4 Byte   | 4 Byte  |
 *
 *  response format:
 *    -----------------------------------------------------
 *    | command | result | timestamp | error no | db      |
 *    -----------------------------------------------------
 *    |4 Byte   | 4 Byte |  8 Byte   | 4 Byte   | 4 Byte  |
 */

/* Request : Voice query*/
typedef struct oc_cmd_query_voice_req{
	uint32_t command;			//command
	uint32_t flag;			    //reserved
} OC_CMD_QUERY_VOICE_REQ;

/* Response : Voice query*/
typedef struct oc_cmd_query_voice_resp{
	uint32_t command;			//command
	uint32_t result;			//0: completed normal, 1: catch error.
	time_t timestamp;			//current time
	uint32_t error_no;			//error code
	float db;			//db
} OC_CMD_QUERY_VOICE_RESP;



///////////////////////////////////////////////////////////
// Command function: Voice query
///////////////////////////////////////////////////////////

/**
 * Generate request command: Voice query.
 */
int generate_cmd_query_voice_req(OC_CMD_QUERY_VOICE_REQ ** out_req,	uint32_t flag);

/**
 * Generate response command: Voice query.
 */
int generate_cmd_query_voice_resp(OC_CMD_QUERY_VOICE_RESP ** out_resp, uint32_t exec_result, uint32_t error_no, float db);

/**
 * Translate request command to buffer: Voice query.
 */
int translate_cmd2buf_query_voice_req(OC_CMD_QUERY_VOICE_REQ * req,	uint8_t** out_buf, int* out_buf_len);

/**
 * Translate response command to buffer: Voice query.
 */
int translate_cmd2buf_query_voice_resp(OC_CMD_QUERY_VOICE_RESP* resp, uint8_t** out_buf, int* out_buf_len);

/**
 * Translate buffer to request command: Voice query.
 */
int translate_buf2cmd_query_voice_req(uint8_t* in_buf, OC_CMD_QUERY_VOICE_REQ** out_req);

/**
 * Translate buffer to response command: Voice query.
 */
int translate_buf2cmd_query_voice_resp(uint8_t* in_buf, OC_CMD_QUERY_VOICE_RESP ** out_resp);




onecloud/src/common/protocol.c
///////////////////////////////////////////////////////////
// Command function: Voice query
///////////////////////////////////////////////////////////

/**
 * Generate request command: Voice query.
 */
int generate_cmd_query_voice_req(OC_CMD_QUERY_VOICE_REQ ** out_req, uint32_t flag) {
	int result = OC_SUCCESS;

	OC_CMD_QUERY_VOICE_REQ* req = (OC_CMD_QUERY_VOICE_REQ*) malloc(
			sizeof(OC_CMD_QUERY_VOICE_REQ));
	req->command = OC_REQ_QUERY_VOICE;
	req->flag = flag;

	*out_req = req;

	return result;
}

/**
 * Generate response command: Voice query.
 */
int generate_cmd_query_voice_resp(OC_CMD_QUERY_VOICE_RESP ** out_resp,
		uint32_t exec_result, uint32_t error_no, float db) {
	int result = OC_SUCCESS;

	OC_CMD_QUERY_VOICE_RESP* resp = (OC_CMD_QUERY_VOICE_RESP*) malloc(
			sizeof(OC_CMD_QUERY_VOICE_RESP));
	memset((void*) resp, 0, sizeof(OC_CMD_QUERY_VOICE_RESP));

	resp->command = OC_REQ_QUERY_VOICE | OC_RESPONSE_BIT;
	resp->result = exec_result;
	resp->timestamp = time(NULL);
	resp->error_no = error_no;
	resp->db = db;

	*out_resp = resp;

	return result;
}

/**
 * Translate request command to buffer: Voice query.
 */
int translate_cmd2buf_query_voice_req(OC_CMD_QUERY_VOICE_REQ * req, uint8_t** out_buf,
		int* out_buf_len) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_VOICE_REQ);
	uint8_t* buffer = (uint8_t*) malloc(buf_len);

	memcpy((void*) buffer, (void*) req, buf_len);

	*out_buf = buffer;
	*out_buf_len = buf_len;

	return result;
}

/**
 * Translate response command to buffer: Voice query.
 */
int translate_cmd2buf_query_voice_resp(OC_CMD_QUERY_VOICE_RESP* resp, uint8_t** out_buf,
		int* out_buf_len) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_VOICE_RESP);
	uint8_t* buffer = (uint8_t*) malloc(buf_len);

	memcpy((void*) buffer, (void*) resp, buf_len);

	*out_buf = buffer;
	*out_buf_len = buf_len;

	return result;
}

/**
 * Translate buffer to request command: Voice query.
 */
int translate_buf2cmd_query_voice_req(uint8_t* in_buf, OC_CMD_QUERY_VOICE_REQ** out_req) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_VOICE_REQ);
	OC_CMD_QUERY_VOICE_REQ* req = (OC_CMD_QUERY_VOICE_REQ*) malloc(buf_len);

	memcpy((void*) req, (void*) in_buf, buf_len);

	*out_req = req;

	return result;
}

/**
 * Translate buffer to response command: Voice query.
 */
int translate_buf2cmd_query_voice_resp(uint8_t* in_buf,
		OC_CMD_QUERY_VOICE_RESP ** out_resp) {
	int result = OC_SUCCESS;

	int buf_len = sizeof(OC_CMD_QUERY_VOICE_RESP);
	OC_CMD_QUERY_VOICE_RESP* resp = (OC_CMD_QUERY_VOICE_RESP*) malloc(buf_len);

	memcpy((void*) resp, (void*) in_buf, buf_len);

	*out_resp = resp;

	return result;
}

onecloud/Makefile

VOICE_DAEMON_PROG = voice_daemon
VOICE_DAEMON_SRC = ${DIR_SRC}/voice_daemon.c
VOICE_DAEMON_BIN = ${DIR_BIN}/${VOICE_DAEMON_PROG}
VOICE_DAEMON_TGT = $(DIR_OBJ)/voice_daemon.o


all:$(MAIN_DAEMON_BIN) $(MONITOR_CLIENT_BIN) $(SCRIPT_DAEMON_BIN) $(GPIO_DAEMON_BIN) $(SIM_DAEMON_BIN) $(COM_DAEMON_BIN) $(WATCH_DOG_BIN) $(APP_SERVICE_BIN) $(HTTP_SIGN_BIN) $(TEMPERATURE_DAEMON_BIN) $(ELECTRICITY_DAEMON_BIN) $(ELECTRICITY_CTRL_BIN) $(VOICE_DAEMON_BIN)

$(VOICE_DAEMON_BIN):$(VOICE_DAEMON_TGT) $(COMMON_TGT) $(UTIL_TGT)
	$(CC) $(LIB_FLAG) -o $@ $(VOICE_DAEMON_TGT) $(COMMON_TGT) $(UTIL_TGT)


onecloud/config/onecloud.ini
[voice]
debug=4
listen_port=17017



