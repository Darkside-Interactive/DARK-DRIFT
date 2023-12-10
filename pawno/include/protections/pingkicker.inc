//Anti-HighPing Module
//Created by MadCat

forward PingKicker_OnGameModeInit();
forward PingKickerConfig();
forward pinglimit_timer();
forward pingkicker_OnPlayerConnect(playerid);
forward pingkicker_OnPlayerDisconnect(playerid);

new PingKicker_Enabled = 0;
new Max_Ping = 700;
new Max_HighPingTime = 10;

new HighPing[MAX_PLAYERS];

public PingKicker_OnGameModeInit(){
	PingKickerConfig();
	if (PingKicker_Enabled == 1){
		SetTimer("pinglimit_timer",1000,1);
		WriteLog("Anti High-Ping Loaded");
	}
	return 0;
}

public PingKickerConfig()
{
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	new temp[MAX_STRING];
	
	set(temp,dini_Get(SecurityDB,"PingKicker_Enabled"));
	if (strlen(temp) > 0) PingKicker_Enabled = strval(temp); 
	else { valstr(temp,PingKicker_Enabled); dini_Set(SecurityDB,"PingKicker_Enabled",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Max_Ping"));
	if (strlen(temp) > 0) Max_Ping = strval(temp); 
	else { valstr(temp,Max_Ping); dini_Set(SecurityDB,"Max_Ping",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Max_HighPingTime"));
	if (strlen(temp) > 0) Max_HighPingTime = strval(temp); 
	else { valstr(temp,Max_HighPingTime); dini_Set(SecurityDB,"Max_HighPingTime",temp);  }
	set(temp,nullstr);

}

public pinglimit_timer(){
	if (PingKicker_Enabled == 0) return;
	for(new i=0;i<MAX_PLAYERS;i++){
		if(IsPlayerConnected(i)){
			if(GetPlayerPing(i) > Max_Ping){
				HighPing[i]++;
			} else {
				HighPing[i]=0;
			}
			if(HighPing[i] >= Max_HighPingTime){
				SendClientMessage(i,COLOUR_RED,lang_texts[633]);
				HighPing[i]=0;
				KickPlayer(i,lang_texts[715]);
			}
		}
	}
}

public pingkicker_OnPlayerConnect(playerid){
	HighPing[playerid]=0;
	return 0;
}

public pingkicker_OnPlayerDisconnect(playerid){
	HighPing[playerid]=0;
	return 0;
}
