//
// Created: 05.09.06
// Aurthor: Iain Gilbert
//

#if defined _commandhandler_included
#endinput
#endif


#define _commandhandler_included
#pragma library commandhandler
#include "base"
#include "utils\gtoutils"
#include "player"
#include "account"
#include <a_samp>

#define MONEY_CMD1 50000;		//SkyDiving
#define MONEY_CMD2 100000;		//RepairCar

forward CommandHandler(playerid,text[]);
new arrayA[MAX_PLAYERS][2];

public CommandHandler(playerid,text[]) // process player commands
{
	if (!IsPlayerConnected(playerid)) return 0;
	new cmd[20];
	new idx;
	set(cmd,strcharsplit(text, idx,strchar(" ")));
	
//
	if(strcmp(cmd,"/repair",true)==0)
	{
    if (GetPlayerMoney(playerid) >=100) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	SendClientMessage(playerid,COLOUR_RED,"Ты должен быть в тачке!");
 	return 1;
 	}
    GivePlayerMoney(playerid, -1000);
    RepairVehicle(GetPlayerVehicleID(playerid));
    SendClientMessage(playerid,COLOUR_YELLOW, "Вы отдали 1000$ за ремонт тачки");
    }
    else
	{
    SendClientMessage(playerid,COLOUR_RED, "Ты должен иметь 1000$ на кармане!");
    }
	return 1;
	}
	if(strcmp(cmd, "/flip", true) == 0) {
    if(IsPlayerInAnyVehicle(playerid))
    {
	new vehicleid = (GetPlayerVehicleID(playerid));
	new Float:x,Float:y,Float:z,Float:angle;
	GetVehiclePos(vehicleid,x,y,z);
	GetVehicleZAngle(vehicleid,angle);
	SetVehiclePos(vehicleid,x,y,z+1);
	SetVehicleZAngle(vehicleid,angle);
	}
	else
	{
	SendClientMessage(playerid,COLOUR_RED,"Ты должен быть в тачке!");
	}
 	return 1;
	}
//------------------------------------------------------------------------------
//-----------------------------------------------------------------------
if(strcmp(cmd, "/drunk", true) == 0)
{
        SetPlayerDrunkLevel (playerid, 3000);
        SendClientMessage(playerid, 0xFFFFFFAA, "Ты нажрался свинья,не садись за руль!");
        return 1;
}
if(strcomp(cmd, "/count", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new string[MAX_STRING];
format(string, sizeof(string),lang_texts[531]);
SendClientMessageToAll(COLOUR_LIGHTGREEN, string);
SetTimer("countdown",999,0);
}
	if(strcomp(cmd, "/dropammo", true) == 1)
	{
	ADMDropAmmo(playerid);
	SendPlayerFormattedText(playerid, lang_texts[33] , 0,COLOUR_WHITE);
	CheckPlayerLevel(playerid);
	return 1;
	}

	if(strcomp(cmd, "/help", true) == 1)
	{
	  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[566]);
	  SendClientMessage(playerid, COLOUR_LIGHTRED, lang_texts[567]);
	  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[568]);
	  SendClientMessage(playerid, COLOUR_WHITE, lang_texts[569]);
	  return 1;
	}

	if( (strcomp(cmd, "/about", true) == 1) || (strcomp(cmd, "/gtohelp", true) == 1) )
	{
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[570]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[571]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[572]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[573]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[574]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[575]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[576]);
	  SendClientMessage(playerid, COLOUR_LIGHTGREEN, lang_texts[577]);


		return 1;
	}


//lang_texts[579]-lang_texts[593]
	if(strcomp(cmd, "/commands", true) == 1)
	{
	  SendClientMessage(playerid, COLOUR_WHITE, "Важное:'/help', '/register <пароль>', '/login <пароль>'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Текст: '/pm <ID> <текст>', '@ <текст>', '# <текст>'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Игрок: '/commands', '/gtohelp', '/version', '/stat', '/level'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Деньги:'/givecash <ID> <money>'  Только в банке: '/bank <кол-во>', '/withdraw <кол-во>'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Банды: '/gang help', '/gang commands', '/gang create <colour> <имя банды>', '/gang colours'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Банды: '/gang quit', '/gang accept', '/gang stats', '/gang members',! <message>");
	  SendClientMessage(playerid, COLOUR_WHITE, "Банды: '/gang invite <ID>', '/gang kick <ID>', '/gang colour <цвет>'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Оружие:'/weapons', '/wl', '/wb <ID> <патроны>'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Гонки: '/races', '/race join <ID>', '/race quit'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Дезматчи: '/dms', '/dm join <ID>', '/dm quit'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Машины:'/repair','flip, '/taxi', '/call taxi'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Раное: '/kill', '/time', '/admins', '/dropammo', '/box', '/boxlom'");
	  SendClientMessage(playerid, COLOUR_WHITE, "Разное: '/skydive'','/teles', '/dance[1-3]' '/handsup' '/piss'");
	return 1;
	}

	if((strcomp(cmd, "/stats", true) == 1) || (strcomp(cmd, "/status", true) == 1) || (strcomp(cmd, "/stat", true) == 1))
	{
		new string[MAX_STRING];
		SendClientMessage(playerid,COLOUR_GREEN,  lang_texts[599] );

		new sid;
		sid=Player[playerid][Status];
		if (sid>=1 && sid<=10) {format(string,sizeof(string),lang_texts[523],sid);}
		else if (sid>10) {format(string,sizeof(string),lang_texts[522],sid);}
		else {format(string,sizeof(string),lang_texts[524]);}
		//Status
		SendClientMessage(playerid,COLOUR_LIGHTRED,string);

		format(string, sizeof(string),  lang_texts[601] , GetLevelName(Player[playerid][Level]), PlayerGangName[playerid] );
		SendClientMessage(playerid,COLOUR_LIGHTBLUE,string);
		format(string, sizeof(string),  lang_texts[602] , Player[playerid][Level], Player[playerid][XP], Player[playerid][Money], Player[playerid][Bank], GetPlayerTotalMoney(playerid) );
		SendClientMessage(playerid,COLOUR_LIGHTBLUE,string);
		format(string, sizeof(string),  lang_texts[603] , Player[playerid][Deaths], Player[playerid][Kills], Player[playerid][Jaileds], Player[playerid][Muted] );
		SendClientMessage(playerid,COLOUR_LIGHTRED,string);
		format(string,sizeof(string), lang_texts[539] ,Player[playerid][CB] );
		SendClientMessage(playerid,COLOUR_WHITE,string);
		return 1;
	}
	if(strcomp(cmd, "/level", true) == 1)
	{
		CheckPlayerLevel(playerid);
		new string[256];
		SendClientMessage(playerid,COLOUR_GREEN,  lang_texts[634] );
		format(string, sizeof(string),  lang_texts[635] , Player[playerid][Level]);
		SendClientMessage(playerid,COLOUR_XP_GOOD, string);
		format(string, sizeof(string),  lang_texts[636] , Player[playerid][XP]);
		SendClientMessage(playerid,COLOUR_XP_GOOD, string);
		format(string, sizeof(string),  lang_texts[637] , GetXPToLevel(playerid, Player[playerid][Level] + 1));
		SendClientMessage(playerid,COLOUR_XP_BAD, string);
		return 1;
	}

	if(strcomp(cmd, "/version", true) == 1)
	{
		new string[MAX_STRING];
		SendClientMessage(playerid, COLOUR_MISC,  lang_texts[638] );
		format(string, sizeof(string),  lang_texts[639] , VERSION);
		SendClientMessage(playerid, COLOUR_GREEN,string);
		SendClientMessage(playerid, COLOUR_MISC,  lang_texts[640] );
		return 1;
	}
	if(strcomp(cmd, "/handsup", true) == 1)
	{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
  	  	return 1;
		}
	}

 	if(strcomp(cmd, "/dance", true) == 1)
	{
	new dancestyle;
	dancestyle = strval(strcharsplit(text, idx,strchar(" ")));
	if ((dancestyle < 1) || (dancestyle > 3))
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	SendPlayerFormattedText(playerid, lang_texts[647] , 0,COLOUR_RED);
	return 1;
	}

	if(dancestyle == 1) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		} else if(dancestyle == 2) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		} else if(dancestyle == 3) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		}
	return 1;
	}
if(strcomp(cmd, "/admins", true) == 1)
{
new string[MAX_STRING];
new idsa=0;
SendClientMessage(playerid, COLOUR_WHITE, lang_texts[28]);

	for (new id = 0; id < MAX_PLAYERS; id++)
	{
		if ( (IsPlayerConnected(id) && IsPlayerAdm(id)) || (IsPlayerConnected(id) && IsPlayerAdm(id)) )
		{
		format(string, sizeof(string), lang_texts[29] , oGetPlayerName(id), id);
		SendClientMessage(playerid, COLOUR_LIGHTBLUE,string);
		format(string, sizeof(string), " %s посмотрел список администраторов онлайн",oGetPlayerName(playerid));
		SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
		idsa++;
		}
	}
	for (new id = 0; id < MAX_PLAYERS; id++)
	{
		if ( IsPlayerConnected(id) && IsPlayerMod(id) )
		{
		format(string, sizeof(string), lang_texts[30] , oGetPlayerName(id), id);
		SendClientMessage(playerid, COLOUR_LIGHTGREEN,string);
		idsa++;
		}
	}

	if (idsa==0)
	{
	SendClientMessage(playerid, COLOUR_GREY,lang_texts[31]);
	}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "/time", true) == 1)
{
GameTextForPlayer(playerid,GetStringGettime(),999,1);
return 1;
}
//------------------------------------------------------------------------------
	if(strcomp(cmd, "/givecash", true) == 1)
	{
		new string[256];
		new giveplayerid, moneys;
		new sendername[MAX_PLAYER_NAME];
		new playermoney;
		new giveplayer[MAX_PLAYER_NAME];
		new tmp[256];
		tmp = strcharsplit(text, idx,strchar(" "));

		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOUR_MISC,  lang_texts[641] );
			return 1;
		}
		giveplayerid = strval(tmp);

		tmp = strcharsplit(text, idx,strchar(" "));
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOUR_MISC,  lang_texts[642] );
			return 1;
		}
		moneys = strval(tmp);

		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = oGetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
				oGivePlayerMoney(playerid, (0 - moneys),1);
				oGivePlayerMoney(giveplayerid, moneys,1);
				format(string, sizeof(string),  lang_texts[643] , giveplayer,giveplayerid, moneys);
				SendClientMessage(playerid, COLOUR_MONEY_GOOD, string);
				format(string, sizeof(string),  lang_texts[644] , moneys, sendername, playerid);
				SendClientMessage(giveplayerid, COLOUR_MONEY_GOOD, string);

				new logstring[256];
				format(logstring, sizeof (logstring), "%s(playerid:%d) has transfered %d to %s(playerid:%d)",sendername, playerid, moneys, giveplayer, giveplayerid);
				WriteLog(logstring);
			}
			else
			{
				SendClientMessage(playerid, COLOUR_MISC,  lang_texts[645] );
			}
		}
		else
		{
			format(string, sizeof(string),  lang_texts[646] , giveplayerid);
			SendClientMessage(playerid, COLOUR_MISC, string);
	}
	return 1;
	}
//------------------------------------------------------------------------------
      if(strcmp(cmd, "/piss", true) == 0) {
      SetPlayerSpecialAction(playerid, 68);
      SendClientMessage(playerid, COLOUR_GREEN,"Эй харошь ссать заеп,и так воняет без тебя! ");
      return 1;
}
//------------------------------------------------------------------------------
 	if(strcmp(cmd, "/rules", true) == 0) {
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать читы, трейнеры, моды или любые другие способы получения нечестного превосходства над противником");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено убивать игроков на спавне (на месте, где они появляются в игре");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать <ESC> в целях спасения от оппонента");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено стоять на паузе в игре длительное время (более 10мин)");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено убивать союзников в командных режимах");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено материться");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено оскорблять игроков и темболее администрацию сервера");
    SendClientMessage(playerid,COLOUR_RED,"Запрещены угрозы игрокам (не относящиеся к игровому процессу)");
	SendClientMessage(playerid,COLOUR_GREEN,"ПРОДОЛЖЕНИЕ ПРАВИЛ - ПИШИТЕ /rules2");
	return 1;
	}
//------------------------------------------------------------------------------
 	if(strcmp(cmd, "/rules2", true) == 0) {
	SendClientMessage(playerid,COLOUR_RED,"Запрещено обсуждать/критиковать действия администрации");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено препятствовать администрации в работе");
	SendClientMessage(playerid,COLOUR_RED,"Необходимо сообщать администрации сервера о любых случаях нарушения данных правил");
	SendClientMessage(playerid,COLOUR_RED,"Запрещена прокачка игроков по договорности");
	SendClientMessage(playerid,COLOUR_RED,"Решение администрации является окончательным и не подлежит обсуждению");
	SendClientMessage(playerid,COLOUR_RED,"Штрафные санкции могут применяться как непосредственно после нарушения, так и через некоторое время (например впоследствии поступления жалобы)");
	SendClientMessage(playerid,COLOUR_RED,"Предусмотрены следующие штрафные санкции: предупреждение, кик (отключение от сервера), временный бан (временный запрет на посещение сервера), вечный бан");
    SendClientMessage(playerid,COLOUR_RED,"Если вы полагаете, что штрафная санкция была применена к вам ошибочно, свяжитесь с администрацией сервера");
    SendClientMessage(playerid,COLOUR_GREEN,"ПРОДОЛЖЕНИЕ ПРАВИЛ - ПИШИИЕ /rules3");
	return 1;
	}
//------------------------------------------------------------------------------
 	if(strcmp(cmd, "/rules3", true) == 0) {
	SendClientMessage(playerid,COLOUR_RED,"Запрещено рекламировать что-либо (сайты, форумы, сервера)");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено флудить (часто повторять одинаковые фразы, или фразы не содержащие смысловой нагрузки");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать чужие (уже кем-то занятые) ники");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать бессмысленные ники (asdfgh, 124gsv, [[]]], admin35 и т. п.)");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать ники, содержащие оскорбительные и/или нецензурные слова");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать ники, содержащие рекламу (IP сервера или адрес сайта)");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать в никах тэги кланов, в которых вы официально не состоите");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено использовать любые баги сервера");
	SendClientMessage(playerid,COLOUR_RED,"Запрещено просить у администратора деньги,хп и левелы");
    SendClientMessage(playerid,COLOUR_GREEN,"ПОЛНУЮ ВЕРСИЮ ПРАВИЛ ЧИТАЙТЕ НА САЙТЕ");
	return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmd, "/teles", true) == 0) {
	SendClientMessage(playerid,COLOUR_GREEN,"/sumo - площадка сумо");
	SendClientMessage(playerid,COLOUR_GREEN,"/jumping - прыжок с парашутом");
	SendClientMessage(playerid,COLOUR_GREEN,"/ministunt - Mini StuntPark");
	SendClientMessage(playerid,COLOUR_GREEN,"/underwater - Mini StuntPark");
	return 1;
	}
//------------------------------------------------------------------------------
	if(strcmp(cmd,"/kill",true)==0)
	{
    SetPlayerArmour(playerid,0.0);
    SetPlayerHealth(playerid,0.0);
    SendClientMessage(playerid,COLOUR_RED, "Вы откинулись!");
 	return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp("/underwater", cmd, true, 10) == 0)
	{
	if(IsPlayerInAnyVehicle(playerid))
	{
	SetVehiclePos(GetPlayerVehicleID(playerid),2385.0830,474.7048,-59.6641);
	}
	else
	SetPlayerPos(playerid,2385.0830,474.7048,-59.6641);
	SetPlayerFacingAngle(playerid,274.7000);
	SetPlayerInterior(playerid, 0);
	GivePlayerMoney(playerid, -2000);
	new PlayerName[30];
	new string[256];
	GetPlayerName(playerid, PlayerName,30);
	format(string,256,"%s телепортировался под воду - /underwater",PlayerName);
	SendClientMessage(playerid,COLOUR_YELLOW,"Ты отдал 2000$ своих наличных");
	SendClientMessageToAll(COLOUR_GREEN,string);
	return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp("/pt", cmd, true, 10) == 0)
	{
	if(arrayA[playerid][0] == 1) return 0;
	arrayA[playerid][0] = 1;
	new string[256];
	format(string,sizeof(string),"%s приветствует всех игроков !",oGetPlayerName(playerid));
	SendClientMessageToAll(COLOUR_YELLOW,string);
	return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp("/pk", cmd, true, 10) == 0)
 	{
	if(arrayA[playerid][1] == 1) return 0;
	arrayA[playerid][1] = 1;
	new string[256];
    format(string,sizeof(string),"%s говорит всем пока !",oGetPlayerName(playerid));
	SendClientMessageToAll(COLOUR_YELLOW,string);
	return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp("/jumping", cmd, true, 10) == 0)
	{
	if(IsPlayerInAnyVehicle(playerid))
	{
	SetVehiclePos(GetPlayerVehicleID(playerid),2242.981,1073.684,323.955);
	}
	else
	SetPlayerPos(playerid,2242.981,1073.684,323.955);
	GivePlayerMoney(playerid, -2000);
	SetPlayerFacingAngle(playerid,0.0);
	GivePlayerWeapon(playerid,46,0);
	new PlayerName[30];
	new string[256];
	GetPlayerName(playerid, PlayerName,30);
	format(string,256,"%s заплатив 2000$ собрался прыгнуть с крыши небоскрёба - /jumping",PlayerName);
	SendClientMessageToAll(COLOUR_PINK,string);
    SendClientMessage(playerid,COLOUR_YELLOW,"Вы отдали 2000$ собственных наличных за прыжок");
	return 1;
	}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
	if (strcmp("/ministunt", cmd, true, 10) == 0)
	{
	if(IsPlayerInAnyVehicle(playerid))
	{
	SetVehiclePos(GetPlayerVehicleID(playerid),1914.735,-1442.444,14.849);
	}
	else
	SetPlayerPos(playerid,1914.735,-1442.444,14.849);
	SetPlayerFacingAngle(playerid,0.0);
	SetPlayerInterior(playerid, 0);
	GivePlayerWeapon(playerid,46,0);
	new PlayerName[30];
	new string[256];
	GetPlayerName(playerid, PlayerName,30);
	format(string,256,"%s телепортировался в мини стант парк - /ministunt",PlayerName);
	SendClientMessageToAll(COLOUR_GREEN,string);
	return 1;
	}
//------------------------------------------------------------------------------
	if (strcmp("/sumo", cmd, true, 10) == 0)
	{
	if(IsPlayerInAnyVehicle(playerid))
	{
	SetVehiclePos(GetPlayerVehicleID(playerid),-429.922394, 2506.329834,128.333527);
	}
	else
	SetPlayerPos(playerid,-429.922394, 2506.329834,128.333527);
	GivePlayerWeapon(playerid,46,0);
	SetPlayerFacingAngle(playerid,274.7000);
	SetPlayerInterior(playerid, 0);
	new PlayerName[30];
	new string[256];
	GetPlayerName(playerid, PlayerName,30);
	format(string,256,"%s телепортировался на /sumo",PlayerName);
	SendClientMessageToAll(COLOUR_GREEN,string);
	return 1;
	}
//------------------------------------------------------------------------------

	if ( (strcomp(cmd, "/skydive", true) == 1) && !IsPlayerInAnyDM(playerid) )
	{
	if (Player[playerid][Jailed] == 1) {return 0;}
	new string[MAX_STRING];
	SendPlayerFormattedText(playerid, lang_texts[19] , 0,COLOUR_WHITE);
	new Float:playerx,Float:playery,Float:playerz;
	GivePlayerWeapon(playerid,46,1);
	GetPlayerPos(playerid,playerx,playery,playerz);
	PlaySoundForPlayer(playerid,1057);
	SetPlayerPos(playerid,playerx,playery,playerz+1200);
	format(string,sizeof(string), lang_texts[20]);
	GameTextForPlayer(playerid,string,4000,5);
	format(string,sizeof(string), lang_texts[21] ,oGetPlayerName(playerid),playerid);
	SendClientMessageToRegistered(COLOUR_GREY, string);
	PlaySoundForPlayer(playerid,1039);
	return 1;
	}
	
	if (strcmp("/minfo", cmd, true, 10) == 0)
	{
	new s[255];
	format(s,sizeof(s),"До разтыка осталось %d минут.",Player[playerid][MuteTime]);
	SendClientMessage(playerid,COLOUR_GREY,s);
	return 1;
	}
	if (strcmp("/painfo", cmd, true, 10) == 0)
	{
	new s[255];
	format(s,sizeof(s),"До разморозки осталось %d минут.",Player[playerid][paraTime]);
	SendClientMessage(playerid,COLOUR_GREY,s);
	return 1;
	}
	
//	cmd = strtok(cmdtext, idx);
	if (strcmp("/pm", cmd, true, 3) == 0)
	{
		new	tmp[256];
		tmp = strtok(text,idx);
		new Message[256];
		new gMessage[256];
		new pName[MAX_PLAYER_NAME+1];
		new iName[MAX_PLAYER_NAME+1];
		if(!strlen(tmp) || strlen(tmp) > 5) return SendClientMessage(playerid,COLOUR_RED,"Применение: /pm (id) (message)");
		new id = strval(tmp);
        gMessage = strrest(text,idx);
		if(!strlen(gMessage)) return SendClientMessage(playerid,COLOUR_RED,"Применение: /pm (id) (message)");
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid,COLOUR_RED,"Игрок оффлайн !");

		if(playerid != id)
		 {
			GetPlayerName(id,iName,sizeof(iName));
			GetPlayerName(playerid,pName,sizeof(pName));
			format(Message,sizeof(Message),">> %s(%d): %s",iName,id,gMessage);
			SendClientMessage(playerid,COLOUR_WHITE,Message);
			format(Message,sizeof(Message),"** %s(%d): %s",pName,playerid,gMessage);
			SendClientMessage(id,COLOUR_YELLOW,Message);
			PlayerPlaySound(id,1085,0.0,0.0,0.0);
		}
		else SendClientMessage(playerid,COLOUR_YELLOW,"Вы не можете отправлять ЛС Себе");
		return 1;
	}

return 0;
}

stock strrest(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

