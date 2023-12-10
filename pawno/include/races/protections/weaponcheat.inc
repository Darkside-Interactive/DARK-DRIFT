//Anti-WeaponCheat Modules
//Created by MadCat

forward AntiWeapon_OnGameModeInit();
forward AntiWeapon_OnPlayerDeath(playerid, killerid, reason);

new Anti_Weapon_Cheat_Enabled = 0;
new Action_On_Weapon_Cheat=2;
new WeaponCheat_Ban_Days=365;

public AntiWeapon_OnGameModeInit(){
	AntiWeaponCheatConfig();
	if (Anti_Weapon_Cheat_Enabled == 1) WriteLog("Anti-Weapon-Cheat Loaded");
	return 0;
}

AntiWeaponCheatConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	
	set(temp,dini_Get(SecurityDB,"Anti_Weapon_Cheat_Enabled"));
	if (strlen(temp) > 0) Anti_Weapon_Cheat_Enabled = strval(temp);
	else { valstr(temp,Anti_Weapon_Cheat_Enabled); dini_Set(SecurityDB,"Anti_Weapon_Cheat_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_Weapon_Cheat"));
	if (strlen(temp) > 0) Action_On_Weapon_Cheat = strval(temp);
	else { valstr(temp,Action_On_Weapon_Cheat); dini_Set(SecurityDB,"Action_On_Weapon_Cheat",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"WeaponCheat_Ban_Days"));
	if (strlen(temp) > 0) WeaponCheat_Ban_Days = strval(temp);
	else { valstr(temp,WeaponCheat_Ban_Days); dini_Set(SecurityDB,"WeaponCheat_Ban_Days",temp);  }
	set(temp,nullstr);

	return;
}

public AntiWeapon_OnPlayerDeath(playerid, killerid, reason)
{
	if (Anti_Weapon_Cheat_Enabled == 0) return 0;
	if (!IsWeapon(reason)) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
	if (!IsPlayerConnected(killerid)) return 0;
	new killermodel = GetVehicleModel(GetPlayerVehicleID(killerid));
	if ((IsPlayerInAnyVehicle(killerid)) && (killermodel == V_RUSTLER || killermodel == V_SEASPAR) && (reason == WEAPON_M4)) return 0;
	if (reason == WEAPON_FLAMETHROWER) return 0; // SA-MP некорректно обрабатывает это оружие
	if (IsPlayerInAnyDM(killerid)) {
		new dmid = GetPlayerDM(playerid);
		if (!IsWeaponAllowedInDM(reason,dmid))
		{
			new punishreason[MAX_STRING];
			format(punishreason,MAX_STRING,lang_texts[720],oGetWeaponName(reason),Deathmatch[dmid][dm_name]);
			if (Action_On_Weapon_Cheat == 0) return 0;
			if (Action_On_Weapon_Cheat == 1){
				Report(killerid,punishreason);
				return 1;
			}
			if (Action_On_Weapon_Cheat == 2){
				KickPlayer(killerid,punishreason);
				return 1;
			}
			if (Action_On_Weapon_Cheat == 3){ 
				BanPlayer(killerid,WeaponCheat_Ban_Days,punishreason);
				return 1;
			}
			return 1;
		}
	} else {
		if (!IsPlayerAllowedWeapon(killerid,reason)){
			new punishreason[MAX_STRING];
			format(punishreason,sizeof(punishreason),lang_texts[721],oGetWeaponName(reason));
			if (Action_On_Weapon_Cheat == 0) return 0;
			if (Action_On_Weapon_Cheat == 1){
				Report(killerid,punishreason);
				return 1;
			}
			if (Action_On_Weapon_Cheat == 2){
				KickPlayer(killerid,punishreason);
				return 1;
			}
			if (Action_On_Weapon_Cheat == 3){ 
				BanPlayer(killerid,WeaponCheat_Ban_Days,punishreason);
				return 1;
			}
		}
	}
	return 0;
}