#include a_samp

#if defined _WeaponAC_included
	#endinput
#endif
#define _WeaponAC_included
#pragma library WeaponAC

new PlayerWeapons[MAX_PLAYERS][2][12];
new PlayerCurrentWeapons[MAX_PLAYERS][2][12];
new bool:WeaponFalseReaction[MAX_PLAYERS] = false;

stock bResetPlayerWeapons(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	ResetPlayerWeapons(playerid);
	for(new a = 0; a < 2; a++)
	{
		for(new b = 0; b < 12; b++)
		{
			PlayerWeapons[playerid][a][b] = -1;
			PlayerCurrentWeapons[playerid][a][b] = -1;
		}
	}
	PlayerWeapons[playerid][0][0] = 0;
	PlayerCurrentWeapons[playerid][0][0] = 0;
	PlayerWeapons[playerid][1][0] = 1;
	PlayerCurrentWeapons[playerid][1][0] = 1;
	return 1;
}

stock GetWeaponSlot(weaponid)
{
	new slot = -1;
	switch(weaponid)
	{
		case 0,1: slot = 0;
		case 2..9: slot = 1;
		case 22..24: slot = 2;
		case 25..27: slot = 3;
		case 28,29,32: slot = 4;
		case 30,31: slot = 5;
		case 33,34: slot = 6;
		case 35..38: slot = 7;
		case 16..18, 39: slot = 8;
		case 41..43: slot = 9;
		case 10..15: slot = 10;
		case 44..46: slot = 11;
		case 40: slot = 12;
		default: slot = -1;
	}
	return slot;
}

stock bool:IsValidWeapon(weaponid)
{
	switch(weaponid)
	{
		case 0..18: return true;
		case 22..46: return true;
		default: return false;
	}
	return false;
}
		

stock bGivePlayerWeapon(playerid,weaponid,ammo)
{
	if(!IsPlayerConnected(playerid) || !IsValidWeapon(weaponid) || ammo > 999999999) return 1;
	new Slot = GetWeaponSlot(weaponid);
	WeaponFalseReaction[playerid] = true;
	PlayerCurrentWeapons[playerid][0][Slot] = weaponid;
	PlayerWeapons[playerid][0][Slot] = weaponid;
	PlayerCurrentWeapons[playerid][1][Slot] += ammo;
	PlayerWeapons[playerid][1][Slot] += ammo;
	GivePlayerWeapon(playerid,weaponid,ammo);
	WeaponFalseReaction[playerid] = false;
	return 1;
}

stock bSetPlayerArmedWeapon(playerid,weaponid)
{
	if(!IsPlayerConnected(playerid) || !IsValidWeapon(weaponid) || ammo > 999999999) return 1;
	new Slot = GetWeaponSlot(weaponid);
	WeaponFalseReaction[playerid] = true;
	for(new a = 0; a < 2; a++)
	{
		for(new b = 0; b != Slot, b < 12; b++)
		{
			PlayerWeapons[playerid][a][b] = -1;
			PlayerCurrentWeapons[playerid][a][b] = -1;
		}
	}
	PlayerWeapons[playerid][0][Slot] = weaponid;
	PlayerCurrentWeapons[playerid][0][Slot] = weaponid;
	PlayerWeapons[playerid][1][Slot] = 999999999;
	PlayerCurrentWeapons[playerid][1][Slot] = 999999999;
	SetPlayerArmedWeapon(playerid,weaponid);
	WeaponFalseReaction[playerid] = false;
	return 1;
}

stock bConnect_Disconnect_(playerid)
{
	WeaponFalseReaction[playerid] = true;
	ResetPlayerWeapons(playerid);
	for(new a = 0; a < 2; a++)
	{
		for(new b = 0; b < 12; b++)
		{
			PlayerWeapons[playerid][a][b] = -1;
			PlayerCurrentWeapons[playerid][a][b] = -1;
		}
	}
	PlayerWeapons[playerid][0][0] = 0;
	PlayerCurrentWeapons[playerid][0][0] = 0;
	PlayerWeapons[playerid][1][0] = 1;
	PlayerCurrentWeapons[playerid][1][0] = 1;
	return 1;
}

stock bOnPlayerDeath_(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	WeaponFalseReaction[playerid] = true;
	ResetPlayerWeapons(playerid);
	for(new a = 0; a < 2; a++)
	{
		for(new b = 0; b < 12; b++)
		{
			PlayerWeapons[playerid][a][b] = -1;
			PlayerCurrentWeapons[playerid][a][b] = -1;
		}
	}
	PlayerWeapons[playerid][0][0] = 0;
	PlayerCurrentWeapons[playerid][0][0] = 0;
	PlayerWeapons[playerid][1][0] = 1;
	PlayerCurrentWeapons[playerid][1][0] = 1;
	return 1;
}

stock bOnPlayerSpawn_(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	SetTimerEx("ResetFalseDetect",1000,false,"d",playerid);
	return 1;
}

stock bUpdate_(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	for(new a = 0; a < 12; a++) 
	{
		GetPlayerWeaponData(playerid,a,PlayerCurrentWeapons[playerid][0][a],PlayerCurrentWeapons[playerid][1][a]);
		if((PlayerWeapons[playerid][0][a] == PlayerCurrentWeapons[playerid][0][a]) && !WeaponFalseReaction[playerid] && (PlayerWeapons[playerid][1][a] < PlayerCurrentWeapons[playerid][1][a]))
		{
			SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (Оружие)");
			return 1;
		}
		else if((PlayerWeapons[playerid][0][a] != PlayerCurrentWeapons[playerid][0][a]) && !WeaponFalseReaction[playerid])
		{
			SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (Оружие)");
			return 1;
		}
		for(new b = 0; b < 2; b++) PlayerWeapons[playerid][b][a] = PlayerCurrentWeapons[playerid][b][a];
	}
	return 1;
}

forward ResetFalseDetect(playerid);
public ResetFalseDetect(playerid) return WeaponFalseReaction[playerid] = false;

#define GivePlayerWeapon bGivePlayerWeapon
#define ResetPlayerWeapons bResetPlayerWeapons
#define SetPlayerArmedWeapon bSetPlayerArmedWeapon