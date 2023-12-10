//Anti-HeliKill Module
//Created by Iain Gilbert
//Modder: MadCat

forward AntiHeliKill_OnGameModeInit();
forward AntiHeliKill_OnPlayerDeath(playerid, killerid, reason);

new Anti_Helikill_Enabled = 1;
new Action_On_HeliKills=2;
new HeliKill_Ban_Days = 1;


public AntiHeliKill_OnGameModeInit(){
	AntiHeliKillConfig();
	if (Anti_Helikill_Enabled == 1)	WriteLog("Anti Heli-Kill Loaded");
	return 0;
}

AntiHeliKillConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	
	set(temp,dini_Get(SecurityDB,"Anti_Helikill_Enabled"));
	if (strlen(temp) > 0) Anti_Helikill_Enabled = strval(temp);
	else { valstr(temp,Anti_Helikill_Enabled); dini_Set(SecurityDB,"Anti_Helikill_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_HeliKills"));
	if (strlen(temp) > 0) Action_On_HeliKills = strval(temp);
	else { valstr(temp,Action_On_HeliKills); dini_Set(SecurityDB,"Action_On_HeliKills",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"HeliKill_Ban_Days"));
	if (strlen(temp) > 0) HeliKill_Ban_Days = strval(temp);
	else { valstr(temp,HeliKill_Ban_Days); dini_Set(SecurityDB,"HeliKill_Ban_Days",temp);  }
	set(temp,nullstr);

	return;
}

public AntiHeliKill_OnPlayerDeath(playerid, killerid, reason)
{
	if (Anti_Helikill_Enabled == 0) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
	if (!IsPlayerConnected(killerid)) return 0;
	if(IsPlayerInAnyVehicle(killerid) && (!IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(killerid) == PLAYER_STATE_DRIVER) && (reason == 50))
	{
		if (Action_On_HeliKills == 0) return 0;
		if (Action_On_HeliKills == 1) Report(killerid,lang_texts[614]);
		if (Action_On_HeliKills == 2) KickPlayer(killerid,lang_texts[614]);
		if (Action_On_HeliKills == 3) BanPlayer(killerid,HeliKill_Ban_Days,lang_texts[614]);
	}
	return 0;
}

