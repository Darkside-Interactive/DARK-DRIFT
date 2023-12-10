//
// Created: 04.11.06
// Aurthor: Iain Gilbert, represent by Dmitry Frolov (FP)
//

#if defined _admin_commands_included
#endinput
#endif

#define _admin_commands_included
#pragma library admin_commands
#include "base"
#include "utils\gtoutils"
#include "player"
#include "account"
#include "race"
#include "payday"

#define COLOR_INVIS 0xFFFFAFAA
const N=10;
new mashinka[N];
new o=0;

forward AdminCommandHandler(playerid,text[]);
forward AdminSpecialCommandHandler(playerid,text[]);
forward SendMessageToAdmins(playerid, color, text[]);

stock IsSkinValid(SkinID) return ((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 267) ||(SkinID >= 269 && SkinID <= 271)|| (SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) ? true:false;

new Float:LocX[MAX_PLAYERS] = 0.0;
new Float:LocY[MAX_PLAYERS] = 0.0;
new Float:LocZ[MAX_PLAYERS] = 0.0;
new Float:Ang[MAX_PLAYERS];

#define POINTSHOMES 31
new Float:PointsH[POINTSHOMES][CoordInfo] = {
{2647.597656,-2003.409667,13.382812},
{1044.264282,-1048.066284,31.700469},
{-2689.126220,212.037155,4.328125},
{-1910.156005,210.557525,35.156250},
{2401.584472,1026.608032,10.812986},

{-1346.315307,492.034332,11.202690},	
{2832.146972,-2529.524658,17.919458},		
{1738.811523,-2543.253173,13.546875},
{-1282.327880,-166.490951,14.148437},
{1432.760986,1490.453857,10.820312},

{364.079864,2504.678222,16.484375},
{1116.208496,-2021.855346,74.429687},
{2737.499023,-1760.086181,44.143890},
{1223.016357,-1791.427124,33.635219},
{1544.125122,-1353.947753,329.473236},

{914.587585,-1021.723815,111.054687},
{-2233.071289,-1736.994506,480.829284},
{1976.502441,1916.305297,130.934509},
{302.717712,-1623.151123,114.416259},
{2065.416503,2366.291992,150.476562},

{2729.579833,2686.808349,59.023437},
{-1818.642211,581.224853,234.890625},
{2658.831054,-1532.073120,47.054687},
{-341.302612,-172.889511,57.487934},
{1832.951538,-1315.967773,131.734375},

{-1941.218261,134.969512,41.000000},
{-2824.375488,2176.859375,180.767562},
{1481.328125,-1790.289794,156.753326},
{1103.387573,-836.532775,112.982246},
{-2667.522460,1595.073852,217.273895},

{268.5101,1883.2794,-30.0937}
};


public AdminCommandHandler(playerid,text[])
{
if (!IsPlayerConnected(playerid)) return 0;
if ( !IsPlayerAdmin(playerid) )return 0;

new cmd[20];
new idx;
set(cmd,strcharsplit(text, idx,strchar(" ")));

if(strcomp(cmd, "/cmdlist", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

  SendClientMessage(playerid, COLOUR_GREEN, "Комманды для Rcon Администратора");
  SendClientMessage(playerid, COLOUR_WHITE, "R: '/givexp <ID> <xp>', '/agivecash <ID> <cash>', '/givegun <ID> <IDgun> <Bullets>'");
  SendClientMessage(playerid, COLOUR_WHITE, "R: '/ssay <text>', '/an <type> <LATtext>', '/setlvl <ID> <lvl>', '/setstatus <ID> <status> (0,1-10,11-256)'");
  SendClientMessage(playerid, COLOUR_WHITE, "R: '/disarm <ID>', '/disarmall', '/skydiveall', '/paralyzeall', '/deparalyzeall', '/remcash <ID>', '/remcashall'");
  SendClientMessage(playerid, COLOUR_WHITE, "R: '/payday', /go <point> (0,1, 2-4(tune) - 30)', '/allowport <ID> <allow>', '/setskin <ID> <IDskin>'");
  SendClientMessage(playerid, COLOUR_WHITE, "R: '/int', '/boom <IDboom>', '/admincnn <LATtext>'");
  SendClientMessage(playerid, COLOUR_WHITE, "R: '/boxstart', '/boxstop'");
}


if(strcomp(cmd, "/int", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
format(string,sizeof(string), "SYSTEM>> INT: %d, STAT: %s (%d)" ,GetPlayerInterior(playerid), GetPlayerState(playerid), GetPlayerState(playerid) );
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
}

/*
if(strcomp(cmd, "/hay", true) == 1)
{
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[530]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
	NettoyerTourDePaille();
	InitialiserTourPaille();
}
*/

if(strcomp(cmd, "/admincnn", true) == 1)
{
new string[MAX_STRING];
set(string,text);
strdel(string, 0, idx);
format(string,sizeof(string), "%s" ,string);
GameTextForAll(string,4000,6);
return 1;
}
//------------------------------------------------------------------------------
if (strcomp(cmd, "/go", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new pointt;
pointt = strval(strcharsplit(text, idx,strchar(" ")));
if ((pointt < 0) || (pointt >= POINTSHOMES) ) 
	{
	SendClientMessage(playerid, COLOUR_RED, "Применение: /go <ID>");
	return 0;
	}

if( IsPlayerInAnyVehicle(playerid) ) {
new VehicleID;
VehicleID = GetPlayerVehicleID(playerid);
SetVehiclePos(VehicleID, PointsH[pointt][Coord_X], PointsH[pointt][Coord_Y], PointsH[pointt][Coord_Z] );
} else {
	SetPlayerPos(playerid, PointsH[pointt][Coord_X], PointsH[pointt][Coord_Y], PointsH[pointt][Coord_Z]);
	}

new string[MAX_STRING];
format(string,sizeof(string), lang_texts[529] , pointt );
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/an", true) == 1)
{
new mtype;
mtype=0;
mtype = strval(strcharsplit(text, idx,strchar(" ")));
if ((mtype < 0) || (mtype==2) || (mtype > 9)) {return 1;}
new string[MAX_STRING];
set(string,text);
strdel(string, 0, idx);
format(string,sizeof(string), "%s" ,string);
GameTextForAll(string, 4999, mtype);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/payday", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

admpayday=256;
PayDay();
  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[526]);
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/about", true) == 1)
{
  SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_GREEN, "Для Rcon Администратора");
  SendClientMessage(playerid, COLOUR_LIGHTRED, lang_texts[615]);
  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[616]);
  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[617]);
  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[618]);
  SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[619]);
}
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
if(strcomp(cmd, "/boom", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new bomamount;
bomamount = strval(strcharsplit(text, idx,strchar(" ")));
new Float:X;
new Float:Y;
new Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateExplosion((X+20), Y, (Z+2), bomamount, 30);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/setskin", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid=INACTIVE_PLAYER_ID;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));

if ( (receiverid < 0) || (receiverid >= MAX_PLAYERS)  || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);	// не тот ИД
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);	//игрок в офф
return 1;
}
new sknamount;
sknamount = strval(strcharsplit(text, idx,strchar(" ")));
if(!IsSkinValid(sknamount))
{
SendPlayerFormattedText(playerid, lang_texts[477] , 0,COLOUR_RED);	//Не тот скин!
return 1;
}
new sknkeep;
sknkeep = GetPlayerSkin(receiverid);
SetPlayerSkin(receiverid, sknamount);
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[478] ,sknamount);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[479] ,oGetPlayerName(receiverid),sknamount,sknkeep);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);

Player[playerid][SkinModel]=sknamount;
player_save_db_dini(receiverid);

return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/ssay", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
set(string,text);
strdel(string, 0, idx);
format(string,sizeof(string), lang_texts[437] ,string);
SendClientMessageToAll(COLOUR_YELLOW, string);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/skydiveall", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
new Float:playerx,Float:playery,Float:playerz;

for (new id = 0; id < MAX_PLAYERS; id++)
{
if (IsPlayerConnected(id) && (Player[id][Jailed] == 0) && !IsPlayerInAnyDM(id) )
	{
	GivePlayerWeapon(id,46,1);
	GetPlayerPos(id,playerx,playery,playerz);
	PlaySoundForPlayer(id,1058);
	SetPlayerPos(id,playerx,playery,playerz+1200);
	}
if (Player[id][Jailed] == 1)
	{
	SendPlayerFormattedText(id, lang_texts[22], 0,COLOUR_LIGHTRED);
	}
}
SendClientMessageToAll(COLOUR_WHITE,lang_texts[19]);
format(string,sizeof(string), lang_texts[20]);
GameTextForAll(string,5000,6);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/disarm", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS))
{
SendPlayerFormattedText(playerid, lang_texts[445] , 0,COLOUR_RED);
return 1;
}
if ( (IsPlayerConnected(receiverid) == 0) && !IsPlayerInAnyDM(receiverid) )
{
SendPlayerFormattedText(playerid, lang_texts[446] , 0,COLOUR_RED);
return 1;
}
ResetPlayerWeapons(receiverid);

ADMDropAmmo(receiverid);

new string[MAX_STRING];
format(string,sizeof(string), lang_texts[484]);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[485] ,oGetPlayerName(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/disarmall", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
for (new id = 0; id < MAX_PLAYERS; id++)
{
if ( (id < playerid) || (id > playerid) )
	{
	if (IsPlayerConnected(id) && (Player[id][Jailed] == 0) && !IsPlayerInAnyDM(id) )
		{
		if (IsPlayerConnected(id) == 0) { return 0; }
		if (IsPlayerAdmin(id) == 1) { return 0; }
		ResetPlayerWeapons(id);
		ADMDropAmmo(id);
		format(string,sizeof(string), lang_texts[484] ,oGetPlayerName(playerid));	//игроку
		SendPlayerFormattedText(id,string, 0,COLOUR_XP_GOOD);
		}
	}
}
format(string,sizeof(string), lang_texts[511]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/paralyzeall", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
for (new id = 0; id < MAX_PLAYERS; id++)
{
if ( (id < playerid) || (id > playerid) )
	{
	if (IsPlayerConnected(id) && (Player[id][Jailed] == 0) && !IsPlayerInAnyDM(id) )
		{
		if (IsPlayerConnected(id) == 0) { return 0; }
		if (IsPlayerAdmin(id) == 1) { return 0; }
		TogglePlayerControllable(id,0);
		format(string,sizeof(string), lang_texts[490]);//игроку
		SendPlayerFormattedText(id,string, 0,COLOUR_XP_GOOD);
		}
	}
}
format(string,sizeof(string), lang_texts[512]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/deparalyzeall", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
for (new id = 0; id < MAX_PLAYERS; id++)
{
if ( (id < playerid) || (id > playerid) )
	{
	if (IsPlayerConnected(id) && (Player[id][Jailed] == 0) && !IsPlayerInAnyDM(id) )
		{
		if (IsPlayerConnected(id) == 0) { return 0; }
		if (IsPlayerAdmin(id) == 1) { return 0; }
		TogglePlayerControllable(id,1);
		format(string,sizeof(string), lang_texts[492]);//игроку
		SendPlayerFormattedText(id,string, 0,COLOUR_XP_GOOD);
		}
	}
}
format(string,sizeof(string), lang_texts[513]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/remcash", true) == 1)
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
ResetPlayerMoney(receiverid);

new string[MAX_STRING];
format(string,sizeof(string), lang_texts[494] ,oGetPlayerName(playerid));			//игроку
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[495] ,oGetPlayerName(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/remcashall", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new string[MAX_STRING];
for (new id = 0; id < MAX_PLAYERS; id++)
{
if ( (id < playerid) || (id > playerid) )
	{
	if (IsPlayerConnected(id) && (Player[id][Jailed] == 0))
		{
		if (IsPlayerConnected(id) == 0) { return 0; }
		if (IsPlayerAdmin(id) == 1) { return 0; }
		ResetPlayerMoney(id);
		format(string,sizeof(string), lang_texts[494] ,oGetPlayerName(playerid));//игроку
		SendPlayerFormattedText(id,string, 0,COLOUR_XP_GOOD);
		}
	}
}
format(string,sizeof(string), lang_texts[514]);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/setlvl", true) == 1)
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

new lvlamount;
lvlamount = strval(strcharsplit(text, idx,strchar(" ")));
if ((lvlamount < 0) || (lvlamount > MAX_LEVEL))
{
SendPlayerFormattedText(playerid, lang_texts[469] , 0,COLOUR_RED);
return 1;
}

if (!IsPlayerAdmin(receiverid) && (lvlamount >MAX_LEVEL-1))
{
SendPlayerFormattedText(playerid, lang_texts[475] , 0,COLOUR_RED);
return 1;
}
new lvlthisday;
lvlthisday = CalculatePlayerLevel(receiverid);
//SetPlayerXP(receiverid,0);
SetPlayerXP(receiverid, LevelList[lvlamount][level_xp]);
CheckPlayerLevel(receiverid);

new string[MAX_STRING];
format(string,sizeof(string), lang_texts[467] ,oGetPlayerName(playerid),lvlamount);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);

format(string,sizeof(string), lang_texts[468] ,oGetPlayerName(receiverid),lvlamount,lvlthisday);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/setstatus", true) == 1)
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
new sid;
sid = strval(strcharsplit(text, idx,strchar(" ")));
if ((sid < 0) || (sid > 255))
{
SendPlayerFormattedText(playerid, lang_texts[480] , 0,COLOUR_RED);
return 1;
}
if (sid<255 && IsPlayerAdmin(receiverid))
	{
	SendPlayerFormattedText(playerid, lang_texts[525] , 0,COLOUR_RED);
	return 1;
	}
new string[MAX_STRING];
new sidstring[MAX_STRING];
if (sid>10) {format(sidstring,sizeof(sidstring),lang_texts[522],sid);}
else if ( (sid>=1) && (sid<=10) ) {format(sidstring,sizeof(sidstring),lang_texts[523],sid);}
else {format(sidstring,sizeof(sidstring),lang_texts[524]);}

if (sid>1)
{
format(string,sizeof(string), lang_texts[518] ,oGetPlayerName(playerid), playerid, sidstring);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_WHITE);
format(string,sizeof(string), lang_texts[519] ,oGetPlayerName(receiverid), receiverid, sidstring);
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
} else {
	format(string,sizeof(string), lang_texts[520] ,oGetPlayerName(playerid), playerid);
	SendPlayerFormattedText(receiverid,string, 0,COLOUR_WHITE);
	format(string,sizeof(string), lang_texts[521] ,oGetPlayerName(receiverid), receiverid);
	SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
	}
Player[receiverid][Status]=sid;
player_save_db_dini(receiverid);
return 1;
}
//------------------------------------------------------------------------------
// ТЕЛЕПОРТ ИГРОКУ 0 - Запрет, 1 - Разрешить
if(strcomp(cmd, "/allowport", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ( (receiverid < 0) || (receiverid >= MAX_PLAYERS)  || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);	// не тот ИД
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);	//игрок в офф
return 1;
}
new setport;
setport = strval(strcharsplit(text, idx,strchar(" ")));
if ((setport < 0) || (setport > 1)) {return 0;}

AllowPlayerTeleport(receiverid, setport);
new string[MAX_STRING];
format(string,sizeof(string), "*** Вы разрешили %s(%d) телепорт по карте", oGetPlayerName(receiverid), receiverid );
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);

return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/givexp", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ( (receiverid < 0) || (receiverid >= MAX_PLAYERS) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}

if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}

new xpamount;
xpamount = strval(strcharsplit(text, idx,strchar(" ")));

if ((xpamount == 0) || (xpamount > 999999))
{
SendPlayerFormattedText(playerid, lang_texts[440] , 0,COLOUR_RED);
return 1;
}
if ( (GetPlayerXP(receiverid)+xpamount > MAX_LVLXP) && !IsPlayerAdmin(receiverid) )
{
    SendPlayerFormattedText(playerid, lang_texts[476] , 0,COLOUR_RED);
	xpamount = MAX_LVLXP;
} else if ( (GetPlayerXP(receiverid)+xpamount > MAX_XP) && IsPlayerAdmin(receiverid) )
	{
	SendPlayerFormattedText(playerid, lang_texts[476] , 0,COLOUR_RED);
	xpamount = MAX_XP;
	}
GivePlayerXP(receiverid,xpamount,1);
Player[receiverid][XP]=GetPlayerXP(receiverid);

CheckPlayerLevel(receiverid);
new string[MAX_STRING];
if (xpamount > 0)
{
format(string,sizeof(string), lang_texts[441] ,xpamount);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);

format(string,sizeof(string), lang_texts[442] ,oGetPlayerName(receiverid),xpamount,GetPlayerXP(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
}
else
{
format(string,sizeof(string), lang_texts[443],xpamount);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);

format(string,sizeof(string), lang_texts[444] ,oGetPlayerName(receiverid),xpamount,GetPlayerXP(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/agivecash", true) == 1)
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

new cashamount;
cashamount = strval(strcharsplit(text, idx,strchar(" ")));

if ((cashamount < -50000000) || (cashamount == 0) || (cashamount > 50000000))
{
SendPlayerFormattedText(playerid, lang_texts[447] , 0,COLOUR_RED);
return 1;
}

oGivePlayerMoney(receiverid,cashamount,1);

new string[MAX_STRING];

if (cashamount > 0)
{
format(string,sizeof(string), lang_texts[448] ,cashamount);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);

format(string,sizeof(string), lang_texts[449] ,oGetPlayerName(receiverid),cashamount,GetPlayerMoney(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
}
else
{
format(string,sizeof(string), lang_texts[450] ,cashamount);
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);

format(string,sizeof(string), lang_texts[451] ,oGetPlayerName(receiverid),cashamount,GetPlayerMoney(receiverid));
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/givegun", true) == 1)
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
new ammamount;
ammamount = strval(strcharsplit(text, idx,strchar(" ")));

if ((ammamount < 0) || (ammamount > 46))
{
SendPlayerFormattedText(playerid, lang_texts[481] , 0,COLOUR_RED);
return 1;
}
new ammbull;
ammbull = strval(strcharsplit(text, idx,strchar(" ")));
if ((ammbull <= 0) || (ammbull > 3000)) ammbull=1;
GivePlayerWeapon(receiverid,ammamount,ammbull);
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[482] ,oGetWeaponName(ammamount), ammamount, ammbull);			//игроку
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[483] ,oGetPlayerName(receiverid),receiverid,oGetWeaponName(ammamount) ,ammamount, ammbull);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
return 1;
}
//------------------------------------------------------------------------------
return 0;
}

public AdminSpecialCommandHandler(playerid,text[])
{
if (!IsPlayerConnected(playerid)) return 0;

	if(text[0] == '@')
	{
	new string[MAX_STRING];
	strmid(string,text,1,strlen(text));

	if(!strlen(string))
		{
		SendClientMessage(playerid, COLOUR_RED, "USAGE: /@ <text>");
		return 0;
		}

	new count = 0;
	for (new id=0; id<MAX_PLAYERS; id++)
	{
		if (IsPlayerConnected(id))
		{
			if ( IsPlayerAdmin(id) || IsPlayerAdm(id) )
			{
				new message[MAX_STRING];
				format(message,sizeof(message), lang_texts[464] ,oGetPlayerName(playerid), string);
				SendPlayerFormattedText(id,message, 0,COLOUR_RED);
				count++;
			}
		}
	}
	if (count == 0)
	{
		SendPlayerFormattedText(playerid, lang_texts[465] , 0,COLOUR_RED);
		return 0;
		} else {
			new message[MAX_STRING];
			format(message,sizeof(message), lang_texts[466] ,string);
			SendPlayerFormattedText(playerid,message, 0,COLOUR_GREEN);
			}
	}
return 1;
}


SendMessageToAdmins(playerid, color, text[])
{
new string[MAX_STRING];
new message[MAX_STRING];
strmid(string,text,0,strlen(text));

format(message,sizeof(message), lang_texts[24] ,oGetPlayerName(playerid), playerid, string);
printf("%s",message);

for (new aid=0; aid<MAX_PLAYERS;aid++)
{
	if (IsPlayerConnected(aid))
	{
		if ( IsPlayerAdmin(aid) && (aid!=playerid)  )
			{
			format(message,sizeof(message), lang_texts[23] ,oGetPlayerName(playerid), playerid, Player[playerid][Status], string);
			SendPlayerFormattedText(aid,message, 0,color);
			}
	}
}
return 1;
}
