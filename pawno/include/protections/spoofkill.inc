//Anti-SpoofKillCheat Modules
//Created by MadCat
//Ideas from SAMP DMA+LG+PB+SR 1.0.1 by BetaMaster, FcukIt 3.0

forward AntiSpoofKill_OnGameModeInit();
forward AntiSpoofKill_OnPlayerDeath(playerid, killerid, reason);

new Anti_Spoof_Kill_Enabled = 0;
new Action_On_Spoof_Cheat=2;
new Spoof_Kill_Ban_Days=365;

public AntiSpoofKill_OnGameModeInit(){
	AntiSpoofKillConfig();
	if (Anti_Spoof_Kill_Enabled == 1) WriteLog("Anti Spoof-Kill Loaded");
	return 0;
}

AntiSpoofKillConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	
	set(temp,dini_Get(SecurityDB,"Anti_Spoof_Kill_Enabled"));
	if (strlen(temp) > 0) Anti_Spoof_Kill_Enabled = strval(temp);
	else { valstr(temp,Anti_Spoof_Kill_Enabled); dini_Set(SecurityDB,"Anti_Spoof_Kill_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_Spoof_Cheat"));
	if (strlen(temp) > 0) Action_On_Spoof_Cheat = strval(temp);
	else { valstr(temp,Action_On_Spoof_Cheat); dini_Set(SecurityDB,"Action_On_Spoof_Cheat",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Spoof_Kill_Ban_Days"));
	if (strlen(temp) > 0) Spoof_Kill_Ban_Days = strval(temp);
	else { valstr(temp,Spoof_Kill_Ban_Days); dini_Set(SecurityDB,"Spoof_Kill_Ban_Days",temp);  }
	set(temp,nullstr);

	return;
}

public AntiSpoofKill_OnPlayerDeath(playerid, killerid, reason)
{
	if (Anti_Spoof_Kill_Enabled == 0) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
	if (!IsPlayerConnected(killerid)) return 0;
	if (IsWeapon(reason)){
		new Float:px,Float:py,Float:pz,Float:kx,Float:ky,Float:kz;
		GetPlayerPos(playerid,px,py,pz);
		GetPlayerPos(killerid,kx,ky,kz);
		if((oGetPlayerHealth(playerid) > 70.0 && reason != INVALID_PLAYER_ID) || (Distance(px,py,pz,kx,ky,kz,false)>200.0 && reason!=WEAPON_FLAMETHROWER))
		{
			if (Action_On_Spoof_Cheat == 0) return 0;
			if (Action_On_Spoof_Cheat == 1){
				new string[MAX_STRING];
				format(string,sizeof(string),lang_texts[719],oGetWeaponName(reason));
				Report(killerid,string);
			}
			if (Action_On_Spoof_Cheat == 2){
				new string[MAX_STRING];
				format(string,sizeof(string),lang_texts[719],oGetWeaponName(reason));
				KickPlayer(killerid,string);
			}
			if (Action_On_Spoof_Cheat == 3){ 
				new string[MAX_STRING];
				format(string,sizeof(string),lang_texts[719],oGetWeaponName(reason));
				BanPlayer(killerid,Spoof_Kill_Ban_Days,string);
			}
		}
	}
	return 0;
}

