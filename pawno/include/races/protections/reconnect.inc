//Anti-Reconndect module
//Created by GTAT Dev Team
//Converted for MultiGTA by MadCat

forward Reconnect_OnGameModeInit();
forward Reconnect_OnPlayerConnect(playerid);
forward Reconnect_OnPlayerDisconnect(playerid,reason);

new PlayerIP[MAX_PLAYERS][MAX_STRING];

new AntiReconnect_Enabled=0;
new Reconnect_DB[MAX_STRING] = "GTO/Reconnects.txt";

ReconnectConfig()
{
	if (ForceOverwrite) return;

	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	new temp[MAX_STRING];
	set(temp,dini_Get(ConfigDB,"Reconnect_DB"));
	if (strlen(temp) > 0) Reconnect_DB = temp; 
	else { set(temp,Reconnect_DB); dini_Set(ConfigDB,"Reconnect_DB",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"AntiReconnect_Enabled"));
	if (strlen(temp) > 0) AntiReconnect_Enabled = strval(temp); 
	else { valstr(temp,AntiReconnect_Enabled); dini_Set(SecurityDB,"AntiReconnect_Enabled",temp);  }
	set(temp,nullstr);

	if (!dini_Exists(Reconnect_DB)) dini_Create(Reconnect_DB);

	return;
}

public Reconnect_OnGameModeInit()
{
	ReconnectConfig();
	if (AntiReconnect_Enabled == 1) WriteLog("Anti-Reconnect Loaded");
	return;
}

public Reconnect_OnPlayerConnect(playerid){
	if (AntiReconnect_Enabled == 0) return 0;
	new ip[16];
	GetPlayerIp(playerid,ip,16);
	new timeval=dini_Int(Reconnect_DB,ip);
	format(PlayerIP[playerid],MAX_STRING,"%s",ip);
	if(timeval != 0){
	    	if(Now() < timeval){
			SendPlayerFormattedText(playerid,  lang_texts[722] , 0,COLOUR_RED);
			KickPlayer(playerid,lang_texts[716]);
			return 1;
	    	} else {
			dini_Unset(Reconnect_DB,ip);
            	}
	}
	return 0;
}

public Reconnect_OnPlayerDisconnect(playerid,reason){
	if (AntiReconnect_Enabled == 0) return 0;
	new newtime = (Now()+60);
	if(reason == 0) newtime = (Now()+30);
	dini_IntSet(Reconnect_DB,PlayerIP[playerid],newtime);
	return 0;
}
