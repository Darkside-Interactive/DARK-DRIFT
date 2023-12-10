//
// Created: 18.12.2007
// Aurthor: Dmitry Frolov (FP)
//

#if defined _adm_commands_included
#endinput
#endif

#define _adm_commands_included
#pragma library adm_commands
#include "base"
#include "utils\gtoutils"
#include "player"
#include "account"
#include "race"

forward AdmCommandHandler(playerid,text[]);

public AdmCommandHandler(playerid,text[]) // process player commands
{
if (!IsPlayerConnected(playerid)) return 0;
if ( (!IsPlayerAdmin(playerid)) && (!IsPlayerAdm(playerid)) )return 0;

new cmd[20];
new idx;

set(cmd,strcharsplit(text, idx,strchar(" ")));

if(strcomp(cmd, "/cmdlist", true) == 1)
{
//SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, "A: '/say <text>', '/pinfo <ID>', '/weather <ID>'(0-20)");
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, "A: '/akill <ID>', '/paralyze <ID>', '/deparalyze <ID>'");
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, "A: '/tele-set', '/tele-loc', '/tele-to <ID>', '/tele-here<ID>', '/tele-hereall', '/tele-do <ID> <ID>'");
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, "A: '/sethealth <ID>', '/setarm <ID>'");
}


if(strcomp(cmd, "/about", true) == 1)
{
//SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, lang_texts[611]);
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, lang_texts[612]);
  SendClientMessage(playerid, COLOUR_LIGHTBLUE, lang_texts[613]);
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/say", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
set(string,text);
strdel(string, 0, idx);
format(string,sizeof(string), lang_texts[473] ,string);
SendClientMessageToAll(COLOUR_BLUE, string);
return 1;
}
//--------------------------------------------------------
if(strcomp(cmd, "/pinfo", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid > MAX_PLAYERS))
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[470] ,oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_YELLOW);


new sid=Player[receiverid][Status];
if (sid>0 && sid<10) {format(string,sizeof(string),lang_texts[523],sid);}
else if (sid>10) {format(string,sizeof(string),lang_texts[522],sid);}
else {format(string,sizeof(string),lang_texts[524]);}
//Status
SendPlayerFormattedText(playerid,string, 0,COLOUR_LIGHTRED);

new PIP[16];
GetPlayerIp(receiverid, PIP, sizeof(PIP));
format(string,sizeof(string), lang_texts[508] ,GetPlayerPing(receiverid), PIP );
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);

format(string,sizeof(string), lang_texts[471] ,Player[receiverid][Level],Player[receiverid][XP],GetXPToLevel(receiverid,Player[receiverid][Level] + 1));	//Level, XP, to level
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);

format(string, sizeof(string),  lang_texts[601] , GetLevelName(Player[receiverid][Level]), PlayerGangName[receiverid] );
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);

format(string,sizeof(string), lang_texts[472] ,Player[receiverid][Money],Player[receiverid][Bank]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
format(string,sizeof(string), lang_texts[538] ,Player[receiverid][Health], Player[receiverid][SkinModel]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
format(string,sizeof(string), lang_texts[474] ,Player[receiverid][Deaths],Player[receiverid][Kills]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
format(string,sizeof(string), lang_texts[507] ,Player[receiverid][Jaileds],Player[receiverid][Muted]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);


format(string,sizeof(string), lang_texts[539] ,Player[receiverid][CB] );
SendPlayerFormattedText(playerid,string, 0,COLOUR_LIGHTBLUE);

format(string,sizeof(string), lang_texts[540] );
SendPlayerFormattedText(playerid,string, 0,COLOUR_LIGHTBLUE);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/weather", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
if (sysweath>0)
	{
	SendClientMessage(playerid, COLOUR_RED, "Ошибка сервер использует скрипт автосмены погоды");
	return 0;
	}
new tmpw;
tmpw = strval(strcharsplit(text, idx,strchar(" ")));
if ( (tmpw < 0) || (tmpw > 20) )
	{
	SendClientMessage(playerid, COLOUR_RED, "Применение: /weather <IDWeather> (0-20)");
	return 0;
	} else 
		{
		SetWeather(tmpw);
		new string[MAX_STRING];
		format(string, sizeof(string),lang_texts[532], tmpw);
		SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
   		printf("Weather has been changed to [%d]",tmpw);
		}
return 1;
}

//------------------------------------------------------------------------------
if(strcomp(cmd, "/akill", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid=INACTIVE_PLAYER_ID;

receiverid = strval(strcharsplit(text, idx,strchar(" ")));


if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)))
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
SetPlayerHealth(receiverid, 0);
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[498] ,oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[499] ,oGetPlayerName(playerid));
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/tele-set", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

GetPlayerPos(playerid, LocX[playerid], LocY[playerid], LocZ[playerid] );
GetPlayerFacingAngle(playerid, Ang[playerid] );
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[504] ,LocX[playerid],LocY[playerid],LocZ[playerid],Ang[playerid]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if (strcomp(cmd, "/tele-loc", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, cmd);
if(LocX[playerid] == 0.0 && LocY[playerid] == 0.0 && LocZ[playerid] == 0.0) {
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[505]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_RED);
} else {
	if(IsPlayerInAnyVehicle(playerid)) {
		new VehicleID;
		VehicleID = GetPlayerVehicleID(playerid);
		SetVehiclePos(VehicleID, LocX[playerid], LocY[playerid], LocZ[playerid] );
		SetPlayerFacingAngle(playerid, Ang[playerid] );
		} else {
			SetPlayerPos(playerid, LocX[playerid], LocY[playerid], LocZ[playerid] );
			SetPlayerFacingAngle(playerid, Ang[playerid] );
			}
	new string[MAX_STRING];
	format(string,sizeof(string), lang_texts[506]);
	SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
	}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/tele-to", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS))
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new Float:X;
new Float:Y;
new Float:Z;
new Float:Angle;
if(IsPlayerInAnyVehicle(playerid)) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
GetPlayerPos(receiverid,X,Y,Z);
GetPlayerFacingAngle(receiverid,Angle);
SetVehiclePos(VehicleID, X + 3.01, Y + 3.01, Z + 1);
SetPlayerFacingAngle(playerid,Angle);
} else {
	GetPlayerPos(receiverid,X,Y,Z);
	GetPlayerFacingAngle(receiverid,Angle);
	SetPlayerFacingAngle(playerid,Angle);
	X=X+(random(2)-random(4));Y=Y+(random(2)-random(4));	
	SetPlayerPos(playerid, X, Y, Z + 1);
	}
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[502] ,oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/tele-here", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));


if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if ( (IsPlayerConnected(receiverid) == 0) && !IsPlayerInAnyDM(receiverid) )
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new Float:X;
new Float:Y;
new Float:Z;
new Float:Angle;
if(IsPlayerInAnyVehicle(receiverid)) {
new VehicleID;
GetPlayerPos(playerid,X,Y,Z);
VehicleID = GetPlayerVehicleID(receiverid);
SetVehiclePos(VehicleID, X + 3.01, Y + 3.01, Z + 1);
GetPlayerFacingAngle(playerid,Angle);
SetPlayerFacingAngle(receiverid,Angle);
} else {
	GetPlayerPos(playerid,X,Y,Z);
	GetPlayerFacingAngle(playerid,Angle);
	SetPlayerFacingAngle(receiverid,Angle);
	X=X+(random(2)-random(4));Y=Y+(random(2)-random(4));	
	SetPlayerPos(receiverid, X, Y, Z + 1);
	}
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[502] ,oGetPlayerName(playerid),playerid);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[503] ,oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/tele-hereall", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new Float:X;
new Float:Y;
new Float:Z;
new Float:Angle;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle(playerid,Angle);
new string[MAX_STRING];

for (new id = 0; id < MAX_PLAYERS; id++)
{
if ( (id < playerid) || (id > playerid))
	{
	if (IsPlayerConnected(id) && (Player[id][Jailed] == 0) && !IsPlayerAdmin(id)  && !IsPlayerInAnyDM(id) )
		{
		if (IsPlayerConnected(id) == 0) { return 0; }
		SetPlayerFacingAngle(id,Angle);
		X=X+(random(2)-random(4));Y=Y+(random(2)-random(4));	
		SetPlayerPos(id, X, Y, Z);
		format(string,sizeof(string), lang_texts[502] ,oGetPlayerName(playerid),playerid);
		SendPlayerFormattedText(id,string, 0,COLOUR_XP_GOOD);
		}
	}
}
format(string,sizeof(string), lang_texts[510]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/tele-do", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));

if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new receiverid2;
receiverid2 = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid2 < 0) || (receiverid2 >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid2) && !IsPlayerAdmin(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid2) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new Float:X;
new Float:Y;
new Float:Z;
new Float:Angle;
if(IsPlayerInAnyVehicle(receiverid)) {
new VehicleID;
VehicleID = GetPlayerVehicleID(receiverid);
GetPlayerPos(receiverid2,X,Y,Z);
GetPlayerFacingAngle(receiverid2,Angle);
SetVehiclePos(VehicleID, X + 3.01, Y + 3.01, Z + 1);
SetPlayerFacingAngle(receiverid,Angle);
} else {
	GetPlayerPos(receiverid2,X,Y,Z);
	GetPlayerFacingAngle(receiverid2,Angle);
	SetPlayerFacingAngle(receiverid,Angle);
	X=X+(random(2)-random(4));Y=Y+(random(2)-random(4));	
	SetPlayerPos(receiverid, X, Y, Z + 1);
	}
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[726] ,oGetPlayerName(receiverid),receiverid,oGetPlayerName(receiverid2),receiverid2);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/sethealth", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)))
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new hltamount;
hltamount = strval(strcharsplit(text, idx,strchar(" ")));
if ((hltamount < 10) || (hltamount > 300))
{
SendPlayerFormattedText(playerid, lang_texts[480] , 0,COLOUR_RED);
return 1;
}
SetPlayerHealth(receiverid, hltamount);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/setarm", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));


if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)))
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
new armamount;
armamount = strval(strcharsplit(text, idx,strchar(" ")));
if ((armamount < 0) || (armamount > 500))
{
SendPlayerFormattedText(playerid, lang_texts[480] , 0,COLOUR_RED);
return 1;
}
SetPlayerArmour(receiverid, armamount);
return 1;
}
//------------------------------------------------------------------------------
if (strcomp(cmd, "/paralyze", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paraid;
paraid = strval(strcharsplit(text, idx,strchar(" ")));
if ((paraid < 0) || (paraid >= MAX_PLAYERS))
{
SendPlayerFormattedText(playerid, lang_texts[458] , 0,COLOUR_RED);
return 1;
}
new paratime;
paratime = strval(strcharsplit(text, idx,strchar(" ")));
if (IsPlayerConnected(paraid) == 1)
{
new string[MAX_STRING];
format(string, sizeof(string),"%s парализован админом на %d минут",oGetPlayerName(paraid),paratime);
SendClientMessageToAll(COLOUR_YELLOW,string);
}
if (paratime < 1)
{
SendPlayerFormattedText(playerid, "Применение '/paralyze <ид> <минут>'", 0,COLOUR_RED);
return 1;
}
Player[paraid][paraTime] = paratime;
TogglePlayerControllable(paraid,0);
return 1;
}

//------------------------------------------------------------------------------
if(strcomp(cmd, "/deparalyze", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[445] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[446] , 0,COLOUR_RED);
return 1;
}
TogglePlayerControllable(receiverid,1);
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[492] ,oGetPlayerName(playerid));		
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[493] ,oGetPlayerName(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
return 0;
}
