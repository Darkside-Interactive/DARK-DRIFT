//Anti-DriveBy Module
//Created by Iain Gilbert
//Modder: MadCat

forward AntiDriveBy_OnGameModeInit();
forward AntiDriveBy_OnPlayerDeath(playerid, killerid, reason);

new Max_DriveBy = 2;
new Anti_Driveby_Enabled=1;
new Action_On_Max_DriveBy=2;
new Money_For_DriveBy = 10000;
new XP_For_DriveBy = 1000;
new Driveby_Ban_Days = 1;

new DriveBy[MAX_PLAYERS];

public AntiDriveBy_OnGameModeInit(){
	AntiDrivebyConfig();
	if (Anti_Driveby_Enabled == 1) WriteLog("Anti Drive-By Loaded");
	return 0;
}

AntiDrivebyConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	
	set(temp,dini_Get(SecurityDB,"Anti_Driveby_Enabled"));
	if (strlen(temp) > 0) Anti_Driveby_Enabled = strval(temp);
	else { valstr(temp,Anti_Driveby_Enabled); dini_Set(SecurityDB,"Anti_Driveby_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Max_DriveBy"));
	if (strlen(temp) > 0) Max_DriveBy = strval(temp);
	else { valstr(temp,Max_DriveBy); dini_Set(SecurityDB,"Max_DriveBy",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Money_For_DriveBy"));
	if (strlen(temp) > 0) Money_For_DriveBy = strval(temp);
	else { valstr(temp,Money_For_DriveBy); dini_Set(SecurityDB,"Money_For_DriveBy",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"XP_For_DriveBy"));
	if (strlen(temp) > 0) XP_For_DriveBy = strval(temp);
	else { valstr(temp,XP_For_DriveBy); dini_Set(SecurityDB,"XP_For_DriveBy",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_Max_DriveBy"));
	if (strlen(temp) > 0) Action_On_Max_DriveBy = strval(temp);
	else { valstr(temp,Action_On_Max_DriveBy); dini_Set(SecurityDB,"Action_On_Max_DriveBy",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Driveby_Ban_Days"));
	if (strlen(temp) > 0) Driveby_Ban_Days = strval(temp);
	else { valstr(temp,Driveby_Ban_Days); dini_Set(SecurityDB,"Driveby_Ban_Days",temp);  }
	set(temp,nullstr);

	return;
}

public AntiDriveBy_OnPlayerDeath(playerid, killerid, reason)
{
	if (Anti_Driveby_Enabled == 0) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
	if (!IsPlayerConnected(killerid)) return 0;
	if (DriveBy[killerid] < 0) DriveBy[killerid] = 0;
	if(IsPlayerInAnyVehicle(killerid) && (!IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(killerid) == PLAYER_STATE_DRIVER) && (reason != WEAPON_VEHICLE))
	{
		DriveBy[killerid]++;
		GivePlayerXP(killerid,-XP_For_DriveBy,0);
		oGivePlayerMoney(killerid,-Money_For_DriveBy,0);
		GivePlayerXP(playerid,XP_For_DriveBy,0);
		oGivePlayerMoney(playerid,Money_For_DriveBy,0);
  		if(DriveBy[killerid] < Max_DriveBy)
		{
    		SendClientMessage(killerid,COLOUR_RED,lang_texts[597]);
		}
		if(DriveBy[killerid] >= Max_DriveBy)
		{
			DriveBy[killerid]=0;
			if (Action_On_Max_DriveBy == 0) return 0;
			if (Action_On_Max_DriveBy == 1) Report(killerid,lang_texts[598]);
			if (Action_On_Max_DriveBy == 2) KickPlayer(killerid,lang_texts[598]);
			if (Action_On_Max_DriveBy == 3) BanPlayer(killerid,Driveby_Ban_Days,lang_texts[598]);
		}
	}
	else
	{
		if(DriveBy[killerid] > 0)
		{
			DriveBy[killerid]--;
		}
	}
	return 0;
}

