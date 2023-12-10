#define BUFFER 128
#define ARRAY_LENGTH 16
#define CLEAR_DELAY 1000

new ips[ARRAY_LENGTH][BUFFER],
	iterator,
	needClear = 1;

fpublic OnGameModeInit() {
	return ClearArray();
}

public OnPlayerConnect(playerid) {
	new currentIp[BUFFER];
	currentIp = GetIp(playerid);
	if(CheckIp(currentIp)) {
		OnDetected(playerid, currentIp);		
	}
	AddIpToArray(currentIp);
	
	if(needClear) {
		SetTimer("ClearArray", CLEAR_DELAY, 0);
		needClear = 0;
	}

	return 1;
}

stock AddIpToArray(ip[BUFFER]) {
 	return	iterator + 1 < ARRAY_LENGTH ?
	 		(ips[iterator ++] = ip) : ClearArray();
}

stock CheckIp(ip[]) {
    new tmp[BUFFER], i;
	while(i < ARRAY_LENGTH) {
		tmp = ips[ i ++ ];
		if(!strcmp(tmp, ip)) return true;
	}
	return false;
}

stock ClearArray() {
	new i;
	while(i < ARRAY_LENGTH) {
	    format(ips[ i ++], BUFFER, " ");
	}
	iterator = (needClear = 1) -1;
	return true;
}

stock GetName(playerid) {
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	return playername;
}

stock GetIp(playerid) {
	new ip[32];
	GetPlayerIp(playerid, ip, 32);
	return ip;
}













