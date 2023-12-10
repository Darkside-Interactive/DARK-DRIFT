/*------------------------------------
		by .Alp. [Alpano]
	   special for PAWNO.ru
[Авторские права защищены грубой физической силой]
------------------------------------*/
#include <a_samp>
/*------------------------------------
		new's
------------------------------------*/
new bool:WeaponsClosed[MAX_PLAYERS][47];
/*------------------------------------
		forward's
------------------------------------*/
forward AntyWeaponCheck(playerid,weaponid);
forward OnPlayerWeaponCheat(playerid);
forward ac_OnPlayerStateChange(playerid,newstate,oldstate);
forward ac_OnPlayerDeath(playerid, killerid, reason);
forward ac_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
/*------------------------------------
		funktion's
------------------------------------*/
stock ac_GivePlayerWeapon(playerid, weaponid,ammo){
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
	if(!WeaponsClosed[playerid][weaponid])
 		CallLocalFunction("OnPlayerWeaponCheat", "d", playerid);
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
public OnPlayerDeath(playerid, killerid, reason){
    if(killerid != INVALID_PLAYER_ID && reason)
    	if(GetPlayerState(killerid) == PLAYER_STATE_ONFOOT || GetPlayerState(killerid) == PLAYER_STATE_PASSENGER)
    		AntyWeaponCheck(killerid,reason);
    return ac_OnPlayerDeath(playerid, killerid, reason);
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER){
		new waepon = GetPlayerWeapon(playerid);
	    if(waepon)
	    	AntyWeaponCheck(playerid,waepon);
	 }else
	    SetPlayerArmedWeapon(playerid, 0);
	return ac_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
}
/*------------------------------------
		define's
------------------------------------*/
#define ResetPlayerWeapons 		ac_ResetPlayerWeapons
#define GivePlayerWeapon 		ac_GivePlayerWeapon

#if defined ac_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define ac_OnPlayerDeath
#endif

#define OnPlayerDeath 			ac_OnPlayerDeath


#define OnPlayerStateChange 	ac_OnPlayerStateChange
#define OnPlayerKeyStateChange 	ac_OnPlayerKeyStateChange
