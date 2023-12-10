/*------------------------------------
		by .Alp. [Alpano]
	   special for PAWNO.ru
[Авторские права защищены грубой физической силой]
------------------------------------*/
#include <a_samp>
/*------------------------------------
		new's
------------------------------------*/
new bool:WeaponsClosed[MAX_PLAYERS][55];
/*------------------------------------
		forward's
------------------------------------*/
forward AntyWeaponCheck(playerid,weaponid);
forward ac_OnPlayerStateChange(playerid,newstate,oldstate);
forward ac_OnPlayerDeath(playerid, killerid, reason);
forward ac_OnPlayerStateChange(playerid,newstate,oldstate);
forward ac_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
/*------------------------------------
		funktion's
------------------------------------*/
stock ac_GivePlayerWeapon(playerid, weaponid,ammo){
	if(weaponid > 46) return true;
	WeaponsClosed[playerid][weaponid] = true;
	return GivePlayerWeapon(playerid, weaponid,ammo);
}
stock ac_ResetPlayerWeapons(playerid){
	for(new w; w < 47; w++)
	    WeaponsClosed[playerid][w] = false;
	return ResetPlayerWeapons(playerid);
}
/*------------------------------------
		public's
------------------------------------*/
public AntyWeaponCheck(playerid,weaponid)
{
	if(weaponid > 46) return true;
	if(!WeaponsClosed[playerid][weaponid])
 		CallLocalFunction("OnPlayerWeaponCht", "dd", playerid,weaponid);
    return 1;
}
public OnPlayerStateChange(playerid,newstate,oldstate){
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER){
 		new model = GetVehicleModel(GetPlayerVehicleID(playerid));
   		switch(model){
    		case 592,577,511,512,520,593,553,476,519,460,513,548,425,417,487,488,497,563,447,469: WeaponsClosed[playerid][46] = true;
   			case 596,597,598,599: WeaponsClosed[playerid][25] = true;
			case 457: WeaponsClosed[playerid][2] = true;
    	}
	}
	return ac_OnPlayerStateChange(playerid,newstate,oldstate);
}
forward OnPlayerDeath_ch(playerid, killerid, reason);
public OnPlayerDeath_ch(playerid, killerid, reason){
    if(killerid != INVALID_PLAYER_ID && reason)
    	AntyWeaponCheck(killerid,reason);
	CallLocalFunction("ac_OnPlayerDeath","ddd",playerid, killerid, reason);
    return true;
}

forward OnPlayerTakeDamage_as(playerid, issuerid, Float: amount, weaponid);
public OnPlayerTakeDamage_as(playerid, issuerid, Float: amount, weaponid){
    if(issuerid != INVALID_PLAYER_ID && weaponid)
    	AntyWeaponCheck(issuerid,weaponid);
    return true;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER){
		new waepon = GetPlayerWeapon(playerid);
	    if(waepon)
	    	AntyWeaponCheck(playerid,waepon);
	 }else
	    SetPlayerArmedWeapon(playerid, 0);
	CallLocalFunction("ac_OnPlayerKeyStateChange","ddd",playerid, newkeys, oldkeys);
	return true;
}
/*------------------------------------
		define's
------------------------------------*/
#define ResetPlayerWeapons 		ac_ResetPlayerWeapons
#define GivePlayerWeapon 		ac_GivePlayerWeapon
#define OnPlayerStateChange 	ac_OnPlayerStateChange
#define OnPlayerKeyStateChange 	ac_OnPlayerKeyStateChange
