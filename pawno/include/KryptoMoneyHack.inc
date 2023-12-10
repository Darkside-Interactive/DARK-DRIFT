/*
AntiMoneyHack For SA:MP 0.3 Version's
Made By [KrYpToDeN] ©
All Rights Reserved
*/
#include a_samp
#if defined _KryptoMoneyHack_included
  #endinput
#endif
#define _KryptoMoneyHack_included
#pragma library KryptoMoneyHack

new Money[MAX_PLAYERS];

/*
stock GivePlayerKryptoMoney(playerid,amount)
{
  	CallRemoteFunction("GivePlayerKryptoMoney", "ii",playerid , amount);
  	return 1;
}

stock SetPlayerKryptoMoney(playerid, amount)
{
 	CallRemoteFunction("SetPlayerKryptoMoney", "ii",playerid , amount);
  	return 1;
}

stock ResetPlayerKryptoMoney(playerid)
{
	CallRemoteFunction("ResetPlayerKryptoMoney", "i",playerid);
  	return 1;
}

stock GetPlayerKryptoMoney(playerid)
{
    return CallRemoteFunction("GetPlayerKryptoMoney", "i",playerid);
}
*/

stock GivePlayerKryptoMoney(playerid, amount)
{
	Money[playerid] += amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, amount);
	return true;
}

stock SetPlayerKryptoMoney(playerid, amount)
{
	Money[playerid] = amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, amount);
}
stock SetRandomWeather()
{
	new rand = random(sizeof(gRandomWeatherIDs));
	SetWeather(gRandomWeatherIDs[rand]);
}
stock ResetPlayerKryptoMoney(playerid)
{
	Money[playerid] = 0;
	ResetPlayerMoney(playerid);
	return 1;
}

stock GetPlayerKryptoMoney(playerid) return Money[playerid];
#define GivePlayerMoney GivePlayerKryptoMoney
#define SetPlayerMoney SetPlayerKryptoMoney
#define ResetPlayerMoney ResetPlayerKryptoMoney
#define GetPlayerMoney GetPlayerKryptoMoney
