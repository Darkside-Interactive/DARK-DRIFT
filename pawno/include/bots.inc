//Anti-Bot module
//Created by Pixels^. Part of code from AntiBot Script by DarkByte
//Modder: MadCat

forward AntiBot_OnGameModeInit();
forward AntiBot_OnPlayerConnect(playerid);
forward BotCheck();

new Anti_Bot_Enabled = 0;
new Max_Player_Per_IP = 15;

public AntiBot_OnGameModeInit(){
	AntiBotsConfig();
	if (Anti_Bot_Enabled == 1){
		SetTimer("BotCheck",5000,1);
		WriteLog("Anti Bot Loaded");
	}
	return 0;
}

AntiBotsConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	set(temp,dini_Get(SecurityDB,"Anti_Bot_Enabled"));
	if (strlen(temp) > 0) Anti_Bot_Enabled = strval(temp);
	else { valstr(temp,Anti_Bot_Enabled); dini_Set(SecurityDB,"Anti_Bot_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Max_Player_Per_IP"));
	if (strlen(temp) > 0) Max_Player_Per_IP = strval(temp);
	else { valstr(temp,Max_Player_Per_IP); dini_Set(SecurityDB,"Max_Player_Per_IP",temp);  }
	set(temp,nullstr);

	return;
}

public BotCheck()
{
	if (Anti_Bot_Enabled == 0) return;
	for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
	{
		if(IsPlayerConnected(playerid)){
			new ping = GetPlayerPing(playerid);
  			if(ping <= 0 || ping >= 25535)	//65535
			{
				KickPlayer(playerid,lang_texts[594]);
			}
		}
	}
}

public AntiBot_OnPlayerConnect(playerid)
{
	if (Anti_Bot_Enabled == 0) return 0;
	new ip[16];
	new ip2[16];
	new cnt = 0;
	GetPlayerIp(playerid,ip2,16);
	for (new i=0; i<MAX_PLAYERS; i++){
		if ((IsPlayerConnected(i))&&(i!=playerid)) {
			GetPlayerIp(playerid,ip2,16);
			if (strcomp(ip,ip2,true)==1) cnt++;
		}
		if (cnt>=Max_Player_Per_IP) {
		    	KickPlayer(playerid,lang_texts[594]);
			return 1;
		}
	}
	return 0;
}