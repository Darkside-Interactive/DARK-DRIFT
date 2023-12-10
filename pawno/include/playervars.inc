forward PlayerSet(playerid, param[], value);
public PlayerSet(playerid, param[], value) {
	if(!dini_Exists(udb_encode(GetName(playerid)))) {
		dini_Create(udb_encode(GetName(playerid)));
	}
	new tmp[256];
	format(tmp, sizeof(tmp), "%d", value);
	dini_Set(udb_encode(GetName(playerid)), param, tmp);
	return 1;
}

forward PlayerSetFloat(playerid, param[], Float:value);
public PlayerSetFloat(playerid, param[], Float:value) {
	if(!dini_Exists(udb_encode(GetName(playerid)))) {
		dini_Create(udb_encode(GetName(playerid)));
	}
	new tmp[256];
	format(tmp, sizeof(tmp), "%f", value);
	dini_Set(udb_encode(GetName(playerid)), param, tmp);
	return 1;
}

forward SavePlayerPos(playerid);
public SavePlayerPos(playerid) {
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	PlayerSetFloat(playerid, "posX", x);
	PlayerSetFloat(playerid, "posY", y);
	PlayerSetFloat(playerid, "posZ", z);
	return 1;
}

forward LoadPlayerPos(playerid);
public LoadPlayerPos(playerid) {
	new Float:x, Float:y, Float:z;
	x = PlayerGet(playerid, "posX");
	y = PlayerGet(playerid, "posY");
	z = PlayerGet(playerid, "posZ");
	SetPlayerPos(playerid, x, y, z);
	return 1;
}




forward PlayerGet(playerid, param[]);
public PlayerGet(playerid, param[]) {
	if(!dini_Exists(udb_encode(GetName(playerid)))) {
		return 0;
	}
	return strval(dini_Get(udb_encode(GetName(playerid)), param));
}

stock GetName(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	return playername;
}
