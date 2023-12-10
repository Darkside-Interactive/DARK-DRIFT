/*******************************************************************************
 *                                                                             *
 *                         AntiCheat Powered by Kazon                          *
 *                            All rights reserved                              *
 *                              AntiCheat v3.5                                 *
 *                                                                             *
 *******************************************************************************/

#include <a_samp>
#include <mxINI>

#define COLOR_LIGHTREDL 	0xFF6347AA

#define SendDig         	"[A] Игрок %s [ID %d] Подозревается в зломе Диалога!"
#define SendRcon        	"[A] Игрок %s [ID %d] Подозревается в зломе Rcon!"
#define SendAdm         	"[A] Игрок %s [ID %d] Подозревается в читерстве!"
#define SendConnect     	"[A] Игрок %s [ID %d] авторизировался(ась) на сервере!"
#define SendDisConnect  	"[A] Игрок %s [ID %d] отсоеденился(ась) от сервера [%s]"

enum LInfo {
	Float:LHeal,
	Float:LArm,
	LCash
};
new LifeInfo[MAX_PLAYERS][LInfo];

new AntiCheat[3], Slap[2], Message[2][144];
new strl[144];

forward Updats();
//================================[Public]======================================
public OnGameModeInit()
{
	SetTimer("Updats",1000,1);
	LoadCfg(), LoadSlap(), LoadMes();
	return CallLocalFunction("Life_OnGameModeInit", "");
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(strfind(inputtext, "%", true) != -1) return true;
	if(AntiCheat[1] == 1)
	{
	    if(IsPlayerAdmin(playerid)) return true;
		if(GetPVarInt(playerid,"USEDIALOGID") != dialogid)
		{
			switch(Slap[1])
   			{
      			case 0: return true;
			    case 1: SendMessage(playerid, COLOR_LIGHTREDL, "%s",Message[0]), Kick(playerid);
		        case 2: SendMessage(playerid, COLOR_LIGHTREDL, "%s",Message[1]), Ban(playerid);
		        case 3: { format(strl, 70, SendDig ,GetName(playerid), playerid); return SendAdminMes(COLOR_LIGHTREDL, strl); }
			}
			return true;
		}
	}
	return CallLocalFunction("Life_OnDialogResponse", "iiiis",playerid, dialogid, response, listitem, inputtext);
}

public OnPlayerSpawn(playerid)
{
    SetPVarInt(playerid, "AntiBreik", 3);
    SetLifeHeal(playerid, 100.0);
	return CallLocalFunction("Life_OnPlayerSpawn", "i",playerid);
}

public OnPlayerConnect(playerid)
{
    SetPVarInt(playerid, "AntiBreik", 500);
    return CallLocalFunction("Life_OnPlayerConnect", "i", playerid);
}

public Updats()
{
    HealthCheckL(), ArmourCheckL(), MoneyCheckL();
	for(new i = GetMaxPlayers() - 1; i != -1; i--)
	{
	    AirBrk(i), CarFlood(i), AntiCrash(i);
	    if(GetPVarInt(i, "AntiBreik") > 0) SetPVarInt(i, "AntiBreik", GetPVarInt(i, "AntiBreik") - 1);
	}
	return true;
}
//===============================[Stock]========================================
stock GetName(playerid) { new name[MAX_PLAYER_NAME]; GetPlayerName(playerid, name, sizeof(name)); return name; }

stock ShowDialog(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
	return SetPVarInt(playerid, "USEDIALOGID", dialogid);
}

stock SetLifePos(playerid, Float:x, Float:y, Float:z)
{
    SetPlayerPos(playerid, x, y, z); SetPVarFloat(playerid, "PosX", x), SetPVarFloat(playerid, "PosY", y), SetPVarFloat(playerid, "PosZ", z);
	return SetPVarInt(playerid, "AntiBreik", 3);
}

stock SetLifeHeal(playerid, Float:Heal)
{
	LifeInfo[playerid][LHeal] = Heal;
	return SetPlayerHealth(playerid, Heal);
}

stock SetLifeArmour(playerid, Float: Arm)
{
	LifeInfo[playerid][LArm] = Arm;
	return SetPlayerArmour(playerid, Arm);
}

stock GiveLifeMoney(playerid, amount) LifeInfo[playerid][LCash] += amount, GivePlayerMoney(playerid, amount);

stock SetLifeMoney(playerid, amount) { LifeInfo[playerid][LCash] = amount; ResetPlayerMoney(playerid); GivePlayerMoney(playerid, amount); }

stock ResetLifeMoney(playerid) LifeInfo[playerid][LCash] = 0, ResetPlayerMoney(playerid);

stock GetLifeMoney(playerid) return LifeInfo[playerid][LCash];

stock HealthCheckL()
{
	new Float:Heal;
    for(new i = GetMaxPlayers() - 1; i != -1; i--)
    {
        if(!IsPlayerConnected(i)) continue;
        GetPlayerHealth(i, Heal);
        if(LifeInfo[i][LHeal] < Heal) SetPlayerHealth(i, LifeInfo[i][LHeal]);
        else LifeInfo[i][LHeal] = Heal;
    }
}

stock ArmourCheckL()
{
	new Float:Arm;
    for(new i = GetMaxPlayers() - 1; i != -1; i--)
    {
        if(!IsPlayerConnected(i)) continue;
        GetPlayerArmour(i, Arm);
        if(LifeInfo[i][LArm] < Arm) SetPlayerArmour(i, LifeInfo[i][LArm]);
        else LifeInfo[i][LArm] = Arm;
    }
}

stock MoneyCheckL()
{
    for(new i = GetMaxPlayers() - 1; i != -1; i--)
    {
        if(!IsPlayerConnected(i)) continue;
     	if(GetPlayerMoney(i) > LifeInfo[i][LCash]) { if((GetPlayerMoney(i) - LifeInfo[i][LCash]) > 1) SetLifeMoney(i,LifeInfo[i][LCash]); }
    }
}

stock SendAdminMes(color, str[])
{
    for(new i = GetMaxPlayers() - 1; i != -1; i--)
	{
	    if(!IsPlayerConnected(i)) continue;
		if(IsPlayerAdmin(i)) SendClientMessage(i, color, str);
	}
	return true;
}

stock SendMessage(playerid, color, fstring[], {Float, _}:...)
{
    static const STATIC_ARGS = 3;
    new n = (numargs() - STATIC_ARGS) * (cellbits / 8);
    if (n)
    {
        new message[128], arg_start, arg_end;
        #emit CONST.alt         fstring
        #emit LCTRL          	5
        #emit ADD
        #emit STOR.S.pri        arg_start
        #emit LOAD.S.alt        n
        #emit ADD
        #emit STOR.S.pri        arg_end
        do
        {
            #emit LOAD.I
            #emit PUSH.pri
            arg_end -= (cellbits / 8);
            #emit LOAD.S.pri   arg_end
        }
        while (arg_end > arg_start);
        #emit PUSH.S          fstring
        #emit PUSH.C          128
        #emit PUSH.ADR        message
        n += (cellbits / 8) * 3;
        #emit PUSH.S          n
        #emit SYSREQ.C        format
        n += (cellbits / 8);
        #emit LCTRL          4
        #emit LOAD.S.alt     n
        #emit ADD
        #emit SCTRL          4
        return SendClientMessage(playerid, color, message);
    }
    else return SendClientMessage(playerid, color, fstring);
}

stock AirBrk(playerid)
{
	if(AntiCheat[0] == 1)
	{
	   	new Float:Pos[4];
	    GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	    Pos[3] = floatround(GetPlayerDistanceFromPoint(playerid, GetPVarFloat(playerid, "PosX"), GetPVarFloat(playerid, "PosY"), GetPVarFloat(playerid, "PosZ")));
		if(GetPVarInt(playerid, "AntiBreik") == 0)
		{
			if(GetPVarInt(playerid, "Air") > 1)
			{
                if(AntiCheat[2] == 1 && IsPlayerAdmin(playerid)) return true;
				switch(Slap[0])
	   			{
	      			case 0: return true;
				    case 1: SendMessage(playerid, COLOR_LIGHTREDL, "%s",Message[0]), Kick(playerid);
			        case 2: SendMessage(playerid, COLOR_LIGHTREDL, "%s",Message[1]), Ban(playerid);
					case 3: { format(strl, 70, SendAdm, GetName(playerid), playerid); return SendAdminMes(COLOR_LIGHTREDL, strl); }
				}
			}
			if(Pos[3] > 100)
			{
                if(AntiCheat[2] == 1 && IsPlayerAdmin(playerid)) return true;
	 			switch(Slap[0])
	   			{
	      			case 0: return true;
				    case 1: SendMessage(playerid, COLOR_LIGHTREDL, "%s",Message[0]), Kick(playerid);
			        case 2: SendMessage(playerid, COLOR_LIGHTREDL, "%s",Message[1]), Ban(playerid);
					case 3: { format(strl, 70, SendAdm, GetName(playerid), playerid); return SendAdminMes(COLOR_LIGHTREDL, strl); }
				}
			}
		   	else if(Pos[3] < 100 && Pos[3] > 70) { SetPVarInt(playerid,"Air",GetPVarInt(playerid,"Air") +1); format(strl, 70, SendAdm, GetName(playerid), playerid); return SendAdminMes(COLOR_LIGHTREDL, strl); }
		}
		SetPVarFloat(playerid, "PosX", Pos[0]), SetPVarFloat(playerid, "PosY", Pos[1]), SetPVarFloat(playerid, "PosZ", Pos[2]);
	}
	return true;
}

stock AntiCrash(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return true;
	new Float:CatHeal, panel, door, light, tire;
	GetVehicleDamageStatus(GetPlayerVehicleID(playerid), panel, door, light, tire);
	GetVehicleHealth(GetPlayerVehicleID(playerid), CatHeal);
	if(CatHeal == 250.0 && door == 67372036)
	{
		new Float:Pos[3];
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		SetVehicleHealth(GetPlayerVehicleID(playerid), 0);
		SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]+5);
		SetPlayerHealth(playerid, 0);
	}
	return true;
}

stock CarFlood(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return true;
	new panel, door, light, tire;
	GetVehicleDamageStatus(GetPlayerVehicleID(playerid),panel,door,light,tire);
	if(panel == 858993459 && door == 67372036 && light == 69)
	{
		new Float:Pos[3];
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]+5);
		SetPlayerHealth(playerid, 0);
	}
	return true;
}

stock LoadCfg()
{
	new File = ini_openFile("Life-Guard/Config.cfg");
	ini_getInteger(File, "Dia", AntiCheat[1]);
	ini_getInteger(File, "Air", AntiCheat[0]);
	ini_getInteger(File, "Adm", AntiCheat[2]);
	ini_closeFile(File);
}
stock LoadSlap()
{
	new File = ini_openFile("Life-Guard/Slap.cfg");
	ini_getInteger(File, "Dia", Slap[1]);
    ini_getInteger(File, "Air", Slap[0]);
    ini_closeFile(File);
}

stock LoadMes()
{
	new File = ini_openFile("Life-Guard/Message.cfg");
	ini_getString(File, "Kik", Message[0]);
	ini_getString(File, "Ban", Message[1]);
	ini_closeFile(File);
}
//=============================[UnDefines]======================================
#if defined _ALS_OnGameModeInit
#undef OnGameModeInit
#else
#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Life_OnGameModeInit

#if defined _ALS_OnDialogResponse
#undef OnDialogResponse
#else
#define _ALS_OnDialogResponse
#endif
#define OnDialogResponse Life_OnDialogResponse

#if defined _ALS_OnPlayerSpawn
#undef OnPlayerSpawn
#else
#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn Life_OnPlayerSpawn

#if defined _ALS_OnPlayerConnect
#undef OnPlayerConnect
#else
#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Life_OnPlayerConnect
//===============================[Defines]======================================
#define ShowPlayerDialog ShowDialog
#define SPD ShowDialog
#define SetPlayerHealth SetLifeHeal
#define SetPlayerArmour SetLifeArmour
#define SetPlayerPos SetLifePos
#define GetPlayerMoney GetLifeMoney
#define GivePlayerMoney GiveLifeMoney
#define ResetPlayerMoney ResetLifeMoney
//==============================[Forwards]======================================
forward Life_OnGameModeInit();
forward Life_OnPlayerSpawn(playerid);
forward Life_OnPlayerConnect(playerid);
forward Life_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
