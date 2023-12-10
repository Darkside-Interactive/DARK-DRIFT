#define FN_NAME_SIZE 256
#define CMD_SIZE 256
#define PARAMS_SIZE 256

#define COMMAND (playerid, params[PARAMS_SIZE])
#define command(%1) forward %1 COMMAND; public %1 COMMAND

public OnPlayerCommandText(playerid, cmdtext[]) {

	new tmp[FN_NAME_SIZE],
		cmd[CMD_SIZE],
		params[PARAMS_SIZE],
		idx;
 	//
	cmd = strtok(cmdtext, idx);
	params = strrest(cmdtext, idx);

	strmid(cmd, cmd, 1, strlen(cmd));

	if(!strlen(params)) {
	    format(params, sizeof(params), " ");
	}

	format(tmp, sizeof(tmp), "_%s", cmd);
	if(!CallLocalFunction(tmp, "is", playerid, params)) return 0;

	return 1;
}



stock strrest(const string[], &index) {
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')) {
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1))) {
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
