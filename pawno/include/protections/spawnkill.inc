//Anti-SpawnKill Module
//Created by... Sorry, forgot
//Converted by: MadCat

#include "a_samp" 			
#include <core> 			
#include "base"
#include "player"

#define MIN_SPAWNTIME 10
new SpawnKill[MAX_PLAYERS];
new Anti_Spawnkill_Enabled = 1;
new Max_Spawn_Kills = 2;
new Money_For_Spawn_Kill = 1000;
new XP_For_Spawn_Kill = 350;
new Action_On_Max_Spawn_Kills = 2;
new Spawnkills_Ban_Days = 1;

forward SpawnKill_OnGameModeInit();

forward AntiSpawnKill_OnPlayerDeath(playerid, killerid, reason);

public SpawnKill_OnGameModeInit(){
	AntiSpawnkillConfig();
	if (Anti_Spawnkill_Enabled == 1) WriteLog("Anti Spawn-Kill Loaded");
	return 0;
}

AntiSpawnkillConfig()
{
	new temp[MAX_STRING];
	
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	set(temp,dini_Get(SecurityDB,"Anti_Spawnkill_Enabled"));
	if (strlen(temp) > 0) Anti_Spawnkill_Enabled = strval(temp);
	else { valstr(temp,Anti_Spawnkill_Enabled); dini_Set(SecurityDB,"Anti_Spawnkill_Enabled",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Anti_Spawnkill_Max_Spawnkill"));
	if (strlen(temp) > 0) Max_Spawn_Kills = strval(temp);
	else { valstr(temp,Max_Spawn_Kills); dini_Set(SecurityDB,"Anti_Spawnkill_Max_Spawnkill",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Money_For_Spawn_Kill"));
	if (strlen(temp) > 0) Money_For_Spawn_Kill = strval(temp);
	else { valstr(temp,Money_For_Spawn_Kill); dini_Set(SecurityDB,"Money_For_Spawn_Kill",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"XP_For_Spawn_Kill"));
	if (strlen(temp) > 0) XP_For_Spawn_Kill = strval(temp);
	else { valstr(temp,XP_For_Spawn_Kill); dini_Set(SecurityDB,"XP_For_Spawn_Kill",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_Max_Spawn_Kills"));
	if (strlen(temp) > 0) Action_On_Max_Spawn_Kills = strval(temp);
	else { valstr(temp,Action_On_Max_Spawn_Kills); dini_Set(SecurityDB,"Action_On_Max_Spawn_Kills",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Spawnkills_Ban_Days"));
	if (strlen(temp) > 0) Spawnkills_Ban_Days = strval(temp);
	else { valstr(temp,Spawnkills_Ban_Days); dini_Set(SecurityDB,"Spawnkills_Ban_Days",temp); }
	set(temp,nullstr);

	return;
}

// anti spawn kill
public AntiSpawnKill_OnPlayerDeath(playerid, killerid, reason)
{
	if (Anti_Spawnkill_Enabled == 0) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
	if (!IsPlayerConnected(killerid)) return 0;
	if (SpawnKill[playerid] > 0) SpawnKill[playerid] = 0;

	if (GetPlayerDM(playerid) != INVALID_DM_ID) return 0;

	if(SpawnTime[playerid] < MIN_SPAWNTIME)
	{
		SpawnKill[killerid]++;
		GivePlayerXP(killerid,-XP_For_Spawn_Kill,0);
		oGivePlayerMoney(killerid,-Money_For_Spawn_Kill,0);
		GivePlayerXP(playerid,XP_For_Spawn_Kill,0);
		oGivePlayerMoney(playerid,Money_For_Spawn_Kill,0);
  		if((SpawnKill[killerid] < Max_Spawn_Kills) && (SpawnKill[killerid] > 0))
		{
    		SendClientMessage(killerid,COLOUR_RED,lang_texts[717]);
		}
		if(SpawnKill[killerid] >= Max_Spawn_Kills)
		{
			SpawnKill[killerid]=0;
			if (Action_On_Max_Spawn_Kills == 0) return 0;
			if (Action_On_Max_Spawn_Kills == 1) Report(killerid,lang_texts[718]);
			if (Action_On_Max_Spawn_Kills == 2) KickPlayer(killerid,lang_texts[718]);
			if (Action_On_Max_Spawn_Kills == 3) BanPlayer(killerid,Spawnkills_Ban_Days,lang_texts[718]);
		}
	}
	else
	{
		if(SpawnKill[killerid] > 0)
		{
			SpawnKill[killerid]--;
		}
	}
	return 0;
}

