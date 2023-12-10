//Anti-flood Module
//Created by MadCat

new AntiFlood_Enabled = 1;
new AntiFlood_Max_Messages = 6;
new Action_On_MaxFlood = 1;
new Flood_Ban_Days = 1;

new TimeLastMsg[MAX_PLAYERS];
new FloodCount[MAX_PLAYERS];

forward AntiFlood_OnGameModeInit();
forward AntiFlood_OnPlayerText(playerid,text[]);

public AntiFlood_OnGameModeInit(){
	AntiFloodConfig();
	if (AntiFlood_Enabled == 1) WriteLog("AntiFlood Loaded");
	return 0;
}

AntiFloodConfig()
{
//	Debug("protections/flood.inc > AntiFloodConfig - Start");
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	set(temp,dini_Get(SecurityDB,"AntiFlood_Enabled"));
	if (strlen(temp) > 0) AntiFlood_Enabled = strval(temp);
	else { valstr(temp,AntiFlood_Enabled); dini_Set(SecurityDB,"AntiFlood_Enabled",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"AntiFlood_Max_Messages"));
	if (strlen(temp) > 0) AntiFlood_Max_Messages = strval(temp);
	else { valstr(temp,AntiFlood_Max_Messages); dini_Set(SecurityDB,"AntiFlood_Max_Messages",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_MaxFlood"));
	if (strlen(temp) > 0) Action_On_MaxFlood = strval(temp);
	else { valstr(temp,Action_On_MaxFlood); dini_Set(SecurityDB,"Action_On_MaxFlood",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Flood_Ban_Days"));
	if (strlen(temp) > 0) Flood_Ban_Days = strval(temp);
	else { valstr(temp,Flood_Ban_Days); dini_Set(SecurityDB,"Flood_Ban_Days",temp); }
	set(temp,nullstr);

//	Debug("protections/flood.inc > AntiFloodConfig - Stop");
	return;
}

public AntiFlood_OnPlayerText(playerid,text[])
{
	#pragma unused text
	if (!IsPlayerConnected(playerid)) return;
	if (AntiFlood_Enabled == 0) return;
//	Debug("protections/flood.inc > AntiFlood_OnPlayerText - Start");
	if((GetTickCount()/1000) - TimeLastMsg[playerid] > 8){
		FloodCount[playerid] = 0;
	}
	else{
		FloodCount[playerid]++;
	}
	if(FloodCount[playerid] >= AntiFlood_Max_Messages){
		FloodCount[playerid] = 0;
		if (Action_On_MaxFlood == 0) return;
		if (Action_On_MaxFlood == 1) Report(playerid, lang_texts[725]);
		if (Action_On_MaxFlood == 2) KickPlayer(playerid, lang_texts[725]);
		if (Action_On_MaxFlood == 3) BanPlayer(playerid,Flood_Ban_Days,lang_texts[725]);
//		if (Action_On_MaxFlood == 4) Mute(playerid);
	}
	TimeLastMsg[playerid] = (GetTickCount()/1000);
//	Debug("protections/flood.inc > AntiFlood_OnPlayerText - Stop");
}