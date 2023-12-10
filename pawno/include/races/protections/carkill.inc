//Anti-CarKill Module
//Created by MadCat
//Based on DriveBy Module

forward AntiCarKill_OnGameModeInit();
forward AntiCarKill_OnPlayerDeath(playerid, killerid, reason);

new Max_CarKills = 2;
new Anti_Carkill_Enabled=1;
new Action_On_Max_CarKills=2;
new Money_For_CarKill = 10000;
new XP_For_CarKill = 1000;
new CarKill_Ban_Days = 1;

new CarKill[MAX_PLAYERS];

public AntiCarKill_OnGameModeInit(){
	AntiCarKillConfig();
	if (Anti_Carkill_Enabled == 1) WriteLog("Anti Car-Kill Loaded");
	return 0;
}

AntiCarKillConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	
	set(temp,dini_Get(SecurityDB,"Anti_Carkill_Enabled"));
	if (strlen(temp) > 0) Anti_Carkill_Enabled = strval(temp);
	else { valstr(temp,Anti_Carkill_Enabled); dini_Set(SecurityDB,"Anti_Carkill_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Max_CarKills"));
	if (strlen(temp) > 0) Max_CarKills = strval(temp);
	else { valstr(temp,Max_CarKills); dini_Set(SecurityDB,"Max_CarKills",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Money_For_CarKill"));
	if (strlen(temp) > 0) Money_For_CarKill = strval(temp);
	else { valstr(temp,Money_For_CarKill); dini_Set(SecurityDB,"Money_For_CarKill",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"XP_For_CarKill"));
	if (strlen(temp) > 0) XP_For_CarKill = strval(temp);
	else { valstr(temp,XP_For_CarKill); dini_Set(SecurityDB,"XP_For_CarKill",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_Max_CarKills"));
	if (strlen(temp) > 0) Action_On_Max_CarKills = strval(temp);
	else { valstr(temp,Action_On_Max_CarKills); dini_Set(SecurityDB,"Action_On_Max_CarKills",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"CarKill_Ban_Days"));
	if (strlen(temp) > 0) CarKill_Ban_Days = strval(temp);
	else { valstr(temp,CarKill_Ban_Days); dini_Set(SecurityDB,"CarKill_Ban_Days",temp);  }
	set(temp,nullstr);

	return;
}

public AntiCarKill_OnPlayerDeath(playerid, killerid, reason)
{
	if (Anti_Carkill_Enabled == 0) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
	if (!IsPlayerConnected(killerid)) return 0;
	if (CarKill[killerid] < 0) CarKill[killerid] = 0;
	if(IsPlayerInAnyVehicle(killerid) && (!IsPlayerInAnyVehicle(playerid)) && (reason == WEAPON_VEHICLE))
	{
		CarKill[killerid]++;
		GivePlayerXP(killerid,-XP_For_CarKill,0);
		oGivePlayerMoney(killerid,-Money_For_CarKill,0);
		GivePlayerXP(playerid,XP_For_CarKill,0);
		oGivePlayerMoney(playerid,Money_For_CarKill,0);
  		if(CarKill[killerid] < Max_CarKills)
		{
    		SendClientMessage(killerid,COLOUR_RED,lang_texts[595]);
		}
		if(CarKill[killerid] >= Max_CarKills)
		{
			CarKill[killerid]=0;
			if (Action_On_Max_CarKills == 0) return 0;
			if (Action_On_Max_CarKills == 1) Report(killerid,lang_texts[596]);
			if (Action_On_Max_CarKills == 2) KickPlayer(killerid,lang_texts[596]);
			if (Action_On_Max_CarKills == 3) BanPlayer(killerid,CarKill_Ban_Days,lang_texts[596]);
		}
	}
	else
	{
		if(CarKill[killerid] > 0)
		{
			CarKill[killerid]--;
		}
	}
	return 0;
}

