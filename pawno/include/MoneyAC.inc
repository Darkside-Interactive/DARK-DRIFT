#include a_samp

#if defined _MoneyAC_included
	#endinput
#endif
#define _MoneyAC_included
#pragma library MoneyAC

/*
	Money Anti-Cheat
	for PROAdmin Adminscript
	BJIADOKC (c) 2011
*/

new PlayerMoneyVar[MAX_PLAYERS];
new bool:MoneyFalseReaction[MAX_PLAYERS] = false;

stock bGetPlayerMoney(playerid) return PlayerMoneyVar[playerid];

stock bSetPlayerMoney(playerid,amount)
{
	if(!IsPlayerConnected(playerid)) return 1;
	MoneyFalseReaction[playerid] = true;
	bResetPlayerMoney(playerid);
	bGivePlayerMoney(playerid,amount);
	SetTimerEx("ResetFalseReaction",500,false,"d",playerid);
	return 1;
}

stock bResetPlayerMoney(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	ResetPlayerMoney(playerid);
	return 1;
}

stock bGivePlayerMoney(playerid,amount)
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(amount < 0) return 1;
	MoneyFalseReaction[playerid] = true;
	PlayerMoneyVar[playerid] += amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,PlayerMoneyVar[playerid]-GetPlayerMoney(playerid));
	SetTimerEx("ResetFalseReaction",100,false,"d",playerid);
	return 1;
}

stock bConnect_Disconnect(playerid)
{
	ResetPlayerMoney(playerid);
	PlayerMoneyVar[playerid] = 0;
	MoneyFalseReaction[playerid] = true;
	return 1;
}

stock bOnPlayerSpawn(playerid)
{
	MoneyFalseReaction[playerid] = false;
	bSetPlayerMoney(playerid,PlayerMoneyVar[playerid]);
	return 1;
}

stock bOnPlayerDeath(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	MoneyFalseReaction[playerid] = true;
	return 1;
}

stock SetMoneyWithoutGive(playerid,amount)
{
	if(!IsPlayerConnected(playerid)) return 1;
	PlayerMoneyVar[playerid] = amount;
	return 1;
}

stock bUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(GetPlayerMoney(playerid) > PlayerMoneyVar[playerid] && !MoneyFalseReaction[playerid])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid,PlayerMoneyVar[playerid]);
		SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (Деньги)");
		return 1;
	}
	else if(GetPlayerMoney(playerid) <= PlayerMoneyVar[playerid] && !MoneyFalseReaction[playerid])
	{
		PlayerMoneyVar[playerid] = GetPlayerMoney(playerid);
		return 1;
	}
	return 1;
}

forward ResetFalseReaction(playerid);
public ResetFalseReaction(playerid) return MoneyFalseReaction[playerid] = false;

#define GivePlayerMoney bGivePlayerMoney
#define ResetPlayerMoney bResetPlayerMoney
#define SetPlayerMoney bSetPlayerMoney