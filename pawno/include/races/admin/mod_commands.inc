//
// Created: 18.12.2007
// Aurthor: Dmitry Frolov (FP)
//

#if defined _mod_commands_included
#endinput
#endif

#define _mod_commands_included
#pragma library mod_commands
#include "base"
#include "player"

forward ModCommandHandler(playerid,text[]);
forward ModSpecialCommandHandler(playerid,text[]);
forward countdown();

public ModCommandHandler(playerid,text[])
{
if (!IsPlayerConnected(playerid)) return 0;
if ( !IsPlayerMod(playerid) && !IsPlayerAdmin(playerid) && !IsPlayerAdm(playerid) ) return 0;
new cmd[20];
new idx;
set(cmd,strcharsplit(text, idx,strchar(" ")));
//------------------------------------------------------------------------------
if(strcomp(cmd, "/cmdlist", true) == 1)
{
  SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_LIGHTGREEN, "M: '/countdown', '/carresp', '/carresparound', '/remcar <ID>', '/kick <ID>'");
  SendClientMessage(playerid, COLOUR_LIGHTGREEN, "M: '/cmdlist', '/about', '/mute <ID>', '/unmute <ID>', '/jail <ID> <Time>', '/unjail <ID>', '/plist'");
  SendClientMessage(playerid, COLOUR_LIGHTGREEN, "M: '/carshelp' /cc");
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/about", true) == 1)
{
  SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[605]);
  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[606]);
  SendClientMessage(playerid, COLOUR_LIGHTRED, lang_texts[607]);
  SendClientMessage(playerid, COLOUR_LIGHTRED, lang_texts[608]);
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/clr", true) == 1)
		{
			{
				new var10 = 1;
				while(++var10 <= 160)
				{
					SendClientMessageToAll(0xFFFF00AA, "\n");
				}
			}
			return 1;
		}
//------------------------------------------------------------------------------

//тачки******************************************************************************************************CAR
//Cars370
if (strcmp(text, "/carshelp", true)==0)
	{
    SendClientMessage(playerid, 0x0000BBAA,"Cars Help");
   	SendClientMessage(playerid, 0x46BBAA00,"/bikes - список байков");
   	SendClientMessage(playerid, 0x46BBAA00,"/airs - самолеты и верталеты");
   	SendClientMessage(playerid, 0x46BBAA00,"/fast - быстрые тачки");
	SendClientMessage(playerid, 0x46BBAA00,"/srace - Гоночный авто");
	SendClientMessage(playerid, 0x46BBAA00,"/other - другие");
	SendClientMessage(playerid, 0x46BBAAAA,"/tst - трап;");
    return 1;
}

if (strcmp(text, "/bikes", true)==0)
	{
    SendClientMessage(playerid, 0x0000BBAA,"Cars Help");
   	SendClientMessage(playerid, 0x46BBAA00,"/nrg500;/sanchez;/bmx;/mountain");
    return 1;
}

if (strcmp(text, "/airs", true)==0)
	{
    SendClientMessage(playerid, 0x0000BBAA,"Cars Help");
   	SendClientMessage(playerid, 0x46BBAA00,"/nevada;/at400;/andromada;/hydra;/hunter");
    return 1;
}

if (strcmp(text, "/fast", true)==0)
	{
    SendClientMessage(playerid, 0x0000BBAA,"Cars Help");
   	SendClientMessage(playerid, 0x46BBAA00,"/supergt;/bullet;/phoenix;/hotknife;/turismo");
    return 1;
}

if (strcmp(text, "/srace", true)==0)
	{
    SendClientMessage(playerid, 0x0000BBAA,"Cars Help");
   	SendClientMessage(playerid, 0x46BBAA00,"/sandking;/hotring1;/hotring2;/hotring3;/dune;/bloodring");
    return 1;
}

if (strcmp(text, "/other", true)==0)
	{
    SendClientMessage(playerid, 0x0000BBAA,"Cars Help");
   	SendClientMessage(playerid, 0x46BBAA00,"/uranus/hustler;/mesa;/rcb;/monsterb;/monstera;/jetmax;/blista;/rhino");
    return 1;
}


if (strcmp(text, "/tst",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(608,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/at400",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(577,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/nevada",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(553,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hustler",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(545,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/mountain",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(510,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/bloodring",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(504,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/mesa",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(500,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/blista",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(496,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/sandking",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(495,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/rcb",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(441,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/bmx",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(481,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/andromada",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(592,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/rhino",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(432,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/monsterb",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(557,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/monstera",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(556,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/uranus",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(558,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/phoenix",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(603,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/bullet",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	mashinka[o++] = CreateVehicle(541,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/supergt",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(506,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/jetmax",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в лодке");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	mashinka[o++] = CreateVehicle(493,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/turismo",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	mashinka[o++] = CreateVehicle(451,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/infernus",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(411,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/dune",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(573,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hotknife",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "YВы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(434,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hotring1",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(494,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hotring2",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(502,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hotring3",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(503,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/nrg500",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(522,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/sanchez",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(468,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hunter",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(425,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if (strcmp(text, "/hydra",true)==0)
{
	if(IsPlayerInAnyVehicle(playerid)) return
	SendClientMessage(playerid, 0x33AA33AA, "Вы уже в автомобиле");
	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	DestroyVehicle(mashinka[o]);
	mashinka[o++] = CreateVehicle(520,x+5,y+5,z+1,a,-1,-1,10000);
	if( o > N-1) o=0;
   	return 1;
}

if(strcomp(cmd, "/plist", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[610]);
new ccount;

for (new id = 0; id < MAX_PLAYERS; id++)
{
if ( IsPlayerConnected(id) && Player[id][Jailed] ==1 )
	{
	new string[MAX_STRING];
	if ( Player[id][JailTime] >0 ) {format(string,sizeof(string), lang_texts[704] ,oGetPlayerName(id), id, Player[id][JailTime]);}
	else  {format(string,sizeof(string), lang_texts[705] ,oGetPlayerName(id), id);}
	SendClientMessage(playerid, COLOUR_LIGHTRED, string);
	ccount++;
	}
	if ( IsPlayerConnected(id) && Player[id][Muted] ==1 )
	{
	new string[MAX_STRING];
	if ( Player[id][MuteTime] >0 ) {format(string,sizeof(string), lang_texts[706] ,oGetPlayerName(id), id, Player[id][MuteTime]);}
	else  {format(string,sizeof(string), lang_texts[707] ,oGetPlayerName(id), id);}
	SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
	ccount++;
	}
}
if (ccount==0) { SendClientMessage(playerid, COLOUR_XP_GOOD, lang_texts[708] );}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/remcar", true) == 1)
{
SendMessageToAdmins(playerid, COLOUR_LIGHTGREEN, text);
new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || IsPlayerAdmin(receiverid) )
{
SendPlayerFormattedText(playerid, lang_texts[438] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[439] , 0,COLOUR_RED);
return 1;
}
if(IsPlayerInAnyVehicle(receiverid))
{
RemovePlayerFromVehicle(receiverid);
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[500] ,oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[501] ,oGetPlayerName(playerid));
SendPlayerFormattedText(receiverid,string, 0,COLOUR_XP_GOOD);
return 1;
} else {
	new string[MAX_STRING];
	format(string,sizeof(string), lang_texts[509] ,oGetPlayerName(receiverid),receiverid);
	SendPlayerFormattedText(playerid,string, 0,COLOUR_RED);
	return 1;
	}
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/kick", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) || (IsPlayerAdm(receiverid) && !IsPlayerAdmin(playerid)))
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
format(string,sizeof(string), lang_texts[496] ,oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), lang_texts[497] ,oGetPlayerName(receiverid),receiverid);
SendClientMessageToAll(COLOUR_WHITE, string);
Kick(receiverid);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/ban111", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new receiverid;
receiverid = strval(strcharsplit(text, idx,strchar(" ")));
if ((receiverid < 0) || (receiverid >= MAX_PLAYERS) || (IsPlayerAdmin(receiverid) && !IsPlayerAdmin(playerid)) || (IsPlayerAdm(receiverid) && !IsPlayerAdmin(playerid)))
{
SendClientMessage(playerid, COLOUR_RED, "Неверный ид игрока");
return 1;
}
if (IsPlayerConnected(receiverid) == 0)
{
SendClientMessage(playerid, COLOUR_RED, "Неверный ид игрока. Игрок  в оффлайн.");
return 1;
}
new string[MAX_STRING];
format(string,sizeof(string), "Вы забанили игрока %s(%d)",oGetPlayerName(receiverid),receiverid);
SendPlayerFormattedText(playerid,string, 0,COLOUR_XP_GOOD);
format(string,sizeof(string), "%s(%d) был забанен на сервере" ,oGetPlayerName(receiverid),receiverid);
SendClientMessageToAll(COLOUR_WHITE, string);
Ban(receiverid);
return 1;
}
//------------------------------------------------------------------------------
if ((strcomp(cmd, "/carresp", true) == 1) && IsPlayerInAnyVehicle(playerid) )
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
FuelRefill2(GetPlayerVehicleID(playerid));
SetVehicleToRespawn(GetPlayerVehicleID(playerid));
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[527], GetPlayerVehicleID(playerid) );
SendPlayerFormattedText(playerid,string, 0,COLOUR_WHITE);
}
//------------------------------------------------------------------------------

if (strcomp(cmd, "/mute", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new muteid;
muteid = strval(strcharsplit(text, idx,strchar(" ")));
if ((muteid < 0) || (muteid >= MAX_PLAYERS))
{
SendPlayerFormattedText(playerid, lang_texts[458] , 0,COLOUR_RED);
return 1;
}
new mutetime;
mutetime = strval(strcharsplit(text, idx,strchar(" ")));
if (IsPlayerConnected(muteid) == 1)
{
new string[MAX_STRING];
format(string, sizeof(string),"%s заткнут на %d минут",oGetPlayerName(muteid),mutetime);
SendClientMessageToAll(COLOUR_RED,string);
}
if (mutetime < 1)
{
SendPlayerFormattedText(playerid, "Применение: '/mute <ид> <минут>'", 0,COLOUR_RED);
return 1;
}
Player[muteid][MuteTime] = mutetime;
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[460] ,oGetPlayerName(playerid));
SendPlayerFormattedText(muteid,string, 0,COLOUR_RED);
return 1;
}

//------------------------------------------------------------------------------
if (strcomp(cmd, "/unmute", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new unmuteid;
unmuteid = strval(strcharsplit(text, idx,strchar(" ")));
if ((unmuteid < 0) || (unmuteid >= MAX_PLAYERS))
{
SendPlayerFormattedText(playerid, lang_texts[461] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(unmuteid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[462] , 0,COLOUR_RED);
return 1;
}
Player[unmuteid][MuteTime] = 0;
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[463] ,oGetPlayerName(playerid));
SendPlayerFormattedText(unmuteid,string, 0,COLOUR_GREEN);
//GIVE UNMUTE INFO
format(string,sizeof(string), lang_texts[487], oGetPlayerName(unmuteid));
//GameTextForAll(string,5000,4);
SendClientMessageToAll(COLOUR_WHITE, string);
printf("SERVER : %s Has Been UNMuted by %s",oGetPlayerName(unmuteid),oGetPlayerName(playerid));

return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/jail", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new jailid;
jailid = strval(strcharsplit(text, idx,strchar(" ")));



if ((jailid < 0) || (jailid >= MAX_PLAYERS) || (IsPlayerAdmin(jailid) && !IsPlayerAdmin(playerid)) || (IsPlayerAdm(jailid) && IsPlayerMod(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[452] , 0,COLOUR_RED);
return 1;
}

if (IsPlayerConnected(jailid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[453] , 0,COLOUR_RED);
return 1;
}

static jailt=4320;
jailt = strval(strcharsplit(text, idx,strchar(" ")));
if ( (jailt>1) && (jailt<=4320) )
	{
	Player[jailid][JailTime] = jailt;
	}
Player[jailid][Jailed] = 1;
if (Player[jailid][JailTime]==0) {Player[jailid][Jaileds]++;}

//GIVE JAIL INFO
//SetPlayerHealth(jailid, 10);
//ResetPlayerMoney(jailid);
//ResetPlayerWeapons(jailid);
//ADMDropAmmo(jailid);

new string[MAX_STRING];
format(string,sizeof(string), lang_texts[454] ,oGetPlayerName(playerid));
SendPlayerFormattedText(jailid,string, 0,COLOUR_RED);
PlaySoundForPlayer(jailid,1082);
format(string,sizeof(string), "~r~%s ~w~has been Jailed", oGetPlayerName(jailid));
GameTextForAll(string,5000,4);
printf("SERVER : %s Has Been Jailed by %s",oGetPlayerName(jailid),oGetPlayerName(playerid));
	new string2[40];
	if (jailt>1 && jailt<=4320) {format(string2,sizeof(string2), lang_texts[710], jailt);}
	else {format(string2,sizeof(string2), lang_texts[711]);}

format(string,sizeof(string), lang_texts[488], oGetPlayerName(jailid), string2);
SendClientMessageToAll(COLOUR_WHITE, string);

JailPlayer(jailid);
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/unjail", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new unjailid;
unjailid = strval(strcharsplit(text, idx,strchar(" ")));
if ((unjailid < 0) || (unjailid >= MAX_PLAYERS) || (IsPlayerAdmin(unjailid) && !IsPlayerAdmin(playerid)) || (IsPlayerAdm(unjailid) && IsPlayerMod(playerid)) )
{
SendPlayerFormattedText(playerid, lang_texts[455] , 0,COLOUR_RED);
return 1;
}
if (IsPlayerConnected(unjailid) == 0)
{
SendPlayerFormattedText(playerid, lang_texts[456] , 0,COLOUR_RED);
return 1;
}
Player[unjailid][Jailed] = 0;
Player[unjailid][JailTime] = 0;
new string[MAX_STRING];
format(string,sizeof(string), lang_texts[457] ,oGetPlayerName(playerid));
SendPlayerFormattedText(unjailid,string, 0,COLOUR_GREEN);
printf("SERVER : %s Has Been UNJailed by %s",oGetPlayerName(unjailid),oGetPlayerName(playerid));
UnJailPlayer(unjailid);
return 1;
}
return 0;
}
public ModSpecialCommandHandler(playerid,text[])
{
if (!IsPlayerConnected(playerid)) return 0;
	if(text[0] == '#')
	{
	new string[MAX_STRING];
	strmid(string,text,1,strlen(text));

	if(!strlen(string))
	{
	SendClientMessage(playerid, COLOUR_RED, "USAGE: /# <text>");
	return 0;
	}
	new mcount;
	for (new id=0; id<MAX_PLAYERS;id++)
	{
		if (IsPlayerConnected(id))
		{
			if ( IsPlayerMod(id) || IsPlayerAdm(id) || IsPlayerAdmin(id))
				{
				new message[MAX_STRING];
				format(message,sizeof(message), lang_texts[515] ,oGetPlayerName(playerid),string);
				SendPlayerFormattedText(id,message, 0,COLOUR_LIGHTGREEN);
				mcount++;
				}
		}
	}
	if (mcount == 0)
		{
		SendPlayerFormattedText(playerid, lang_texts[516] , 0,COLOUR_RED);
		return 0;
		} else {
			new message[MAX_STRING];
			format(message,sizeof(message), lang_texts[517] ,string);
			SendPlayerFormattedText(playerid,message, 0,COLOUR_GREEN);
			}
	}
return 1;
}
public countdown()
{
	static loops = 5;
	if (loops)
	{
		new cdtimer = SetTimer("countdown", 1000, 0);
		#pragma unused cdtimer
		new str[256];
		format(str, sizeof (str), "~y~%d", loops);

GameTextForAll(str, 999, 6);

		for(new i=0; i<MAX_PLAYERS; i++) {

			if (IsPlayerConnected(i))
			{
				PlaySoundForPlayer(i,1056);
			}
		}
		loops--;
	}
	else
	{
GameTextForAll("~w~GO GO GO !!!", 1999, 6);

		for(new i=0; i<MAX_PLAYERS; i++) {
		{
			if (IsPlayerConnected(i))
			{
				PlaySoundForPlayer(i,1057);
			}
		}
		loops = 5;
	}
}
}
