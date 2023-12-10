//==============================================================================
//                            Основные настройки
//==============================================================================

#define MOD55INS 1 //настройка команд /ipban и /ipunban:
//                 //MOD55INS 1 - команды доступны админам 9 и 10 lvl.
//                 //MOD55INS 2 - команды доступны ТОЛЬКО админу (админам) 10 lvl.

//   ВНИМАНИЕ !!! после изменения настроек ОБЯЗАТЕЛЬНО откомпилировать !!!
//==============================================================================
#if (MOD55INS < 1)
	#undef MOD55INS
	#define MOD55INS 1
#endif
#if (MOD55INS > 2)
	#undef MOD55INS
	#define MOD55INS 2
#endif

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 141 //максимум игроков на сервере + 1 (если 50 игроков, то пишем 51 !!!)

#if (MAX_PLAYERS > 501)
	#undef MAX_PLAYERS
	#define MAX_PLAYERS 501
#endif

#define COLOR_GREY 0xAFAFAFFF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00FF

forward DatCor();//коррекция даты
forward TimCor();//коррекция времени
forward ReadCorTime();//чтение файла cortime.ini
forward dopfunction(per);//функция дальнего вызова для чтения коррекции времени
forward ini_GetKey( line[] );
forward ini_GetValue( line[] );
forward FPing2(playerid, para1, para2);
forward FPing3(playerid, para1, para2);
forward Prov1(playerid, para1, para2);
forward Prov2(playerid, para1, para2);
forward Prov3(playerid, para1, para2);
forward Prov4(playerid, para1, para2);
forward Prov5(playerid, para1, para2);
forward Prov6(playerid, para1, para2);
forward ReadData();//чтение файла keyscan.ini
forward SaveData();//запись файла keyscan.ini
forward EndPlCRTp(playerid);

forward SendAdminMessage(para1, para2, color, string[]);

new ipper[MAX_PLAYERS][4][32];//массив для команд /ipban и /ipunban
new timecor[8];//переменная коррекции времени 2
new CorTime[5];//переменная коррекции времени 1
new spectate[MAX_PLAYERS];
new mnhp;
new mnon;
new obj[4];
new razresh;
new Float:plarm, Float:plhp;
new pping1, pping2, pping3;
new pler1, pler2;
new plgl;
new plgldist;
new plloc[MAX_PLAYERS];
new pllocdist[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("         Filterscript Keyscan          ");
	print("--------------------------------------\n");
	ReadCorTime();//чтение коррекции времени

	obj[0] = CreateObject(10826, 0.00, 0.00, 19500.00,   0.00, 0.00, 0.00);
	obj[1] = CreateObject(10826, 1543.85, -1353.98, 14500.00,   0.00, 0.00, 0.00);
	obj[2] = CreateObject(10826, -1981.03, 443.81, 9500.00,   0.00, 0.00, 0.00);
	obj[3] = CreateObject(10826, 2169.05, 1676.22, 4500.00,   0.00, 0.00, 0.00);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPVarInt(i, "CComAc1", 0);
		SetPVarInt(i, "PlCRTp", 0);
		spectate[i] = 600;//отключаем ВСЕМ админам (и игрокам) функцию слежения
		plloc[i] = 0;//отключаем ВСЕМ админам (и игрокам) функцию краш-монитора
	}
	ReadData();//чтение файла keyscan.ini
	mnhp = 0;
	mnon = 0;
	razresh = 0;
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			DeletePVar(i, "CComAc1");
			DeletePVar(i, "PlCRTp");
		}
	}
	DestroyObject(obj[0]);
	DestroyObject(obj[1]);
	DestroyObject(obj[2]);
	DestroyObject(obj[3]);
	razresh = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "CComAc1", 0);
	SetPVarInt(playerid, "PlCRTp", 0);
	spectate[playerid] = 600;//отключаем админу (игроку) функцию слежения
	plloc[playerid] = 0;//отключаем админу (игроку) функцию краш-монитора
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[256];
    new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
	new Float:X, Float:Y, Float:Z;
	new Float:Xc, Float:Yc, Float:Zc, Float:ras1, Float:ras2;
	GetPlayerPos(playerid, X, Y, Z);
	for(new i = 0; i < MAX_PLAYERS; i++)//отключаем от keyscan игрока, за которым следили
	{
		if(spectate[i] == playerid)
		{
			spectate[i] = 600;//отключаем от админа игрока, за которым следил админ
			SendClientMessage(i, COLOR_RED, " Игрок, за клавиатурой которого Вы следили,");
			SendClientMessage(i, COLOR_RED, " вышел с сервера, и был отключен от слежения.");
			GetPlayerName(i, sendername, sizeof(sendername));
			format(string, sizeof(string), "* Игрок %s был отключен от слежения за своей клавиатурой со стороны админа %s", giveplayer, sendername);
			print(string);
		}
		GetPlayerPos(i, Xc, Yc, Zc);
		if(IsPlayerConnected(i) && reason == 0 && playerid != i && (-1000<(X-Xc)<1000 && -1000<(Y-Yc)<1000 && -1000<(Z-Zc)<1000))
		{
			ras1 = floatsqroot(floatmul((X-Xc), (X-Xc)) + floatmul((Y-Yc), (Y-Yc)));
			ras2 = floatsqroot(floatmul(ras1, ras1) + floatmul((Z-Zc), (Z-Zc)));
			format(string, sizeof(string), "%f", ras2);
			new dop1;
			dop1 = strval(string);
			GetPlayerName(i, sendername, sizeof(sendername));
			format(string, sizeof(string), "* Краш-монитор - игрок ''вылетел'': %s [%d] , игрок рядом: %s [%d] , расстояние: %d", giveplayer, playerid, sendername, i, dop1);
			if(plgl == 1 && plgldist >= dop1) { print(string); }
			SendAdminMessage(1, dop1, 0xFF6347FF, string);
		}
	}
	DeletePVar(playerid, "CComAc1");
	DeletePVar(playerid, "PlCRTp");
	spectate[playerid] = 600;//отключаем админу (игроку) функцию слежения
	plloc[playerid] = 0;//отключаем админу (игроку) функцию краш-монитора
	return 1;
}

public SendAdminMessage(para1, para2, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(GetPVarInt(i, "AdmLvl") >= 1 || IsPlayerAdmin(i))
		    {
				if(para1 == 0)
				{
					SendClientMessage(i, color, string);
				}
				if(para1 == 1 && plloc[i] == 1 && pllocdist[i] >= para2)
				{
					SendClientMessage(i, color, string);
				}
			}
		}
	}
	return 1;
}

stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[30];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnPlayerText(playerid, text[])
{
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), " Игрок: %s [%d] (чат) - %s", giveplayer, playerid, text);
			SendClientMessage(i, COLOR_GREEN, string);
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	SetPVarInt(playerid, "CComAc1", GetPVarInt(playerid, "CComAc1") + 1);
	new idx;
	idx = 0;
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	cmd = strtok(cmdtext, idx);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), " Игрок: %s [%d] (команда) - %s", giveplayer, playerid, cmdtext);
			SendClientMessage(i, COLOR_GREEN, string);
		}
	}
	if(strcmp(cmd, "/a2help", true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid,COLOR_GREY," -------------------------- Дополнительные команды -------------------------- ");
			if (GetPVarInt(playerid, "AdmLvl") >= 1)
			{
				SendClientMessage(playerid, COLOR_GREY, " 1 левел: /a2help, /lctp[1-3], /grtp[1-4], /allonline [0- чат], /cc,");
				SendClientMessage(playerid, COLOR_GREY, "     /plcmon [0- чат] [0- выкл., 1- вкл., 2- просмотреть настройки]");
				SendClientMessage(playerid, COLOR_GREY, "     ( дополнительно [дальность определения(10-1000)] )");
			}
			if (GetPVarInt(playerid, "AdmLvl") >= 2)
			{
				SendClientMessage(playerid, COLOR_GREY, " 2 левел: /keyon [ид игрока], /keyoff,");
				SendClientMessage(playerid, COLOR_GREY, "     /tshp [ид игрока] ( дополнительно [корректор пинга(10-1000)]");
			}
#if (MOD55INS == 1)
			if (GetPVarInt(playerid, "AdmLvl") >= 9)
			{
				SendClientMessage(playerid, COLOR_GREY, " 9 левел: /ipban [IP-адрес], /ipunban [IP-адрес]");
			}
			if (GetPVarInt(playerid, "AdmLvl") >= 10)
			{
				SendClientMessage(playerid, COLOR_GREY, " 10 левел: /allonline [0- чат, 1- сервер-лог], /scan [0- выкл., 1- вкл.],");
				SendClientMessage(playerid, COLOR_GREY, "     /plcmon [0- чат, 1- сервер-лог] [0- выкл., 1- вкл., 2- просмотреть настройки]");
				SendClientMessage(playerid, COLOR_GREY, "     ( дополнительно [дальность определения(10-1000)] )");
			}
#endif
#if (MOD55INS == 2)
			if (GetPVarInt(playerid, "AdmLvl") >= 10)
			{
				SendClientMessage(playerid, COLOR_GREY, " 10 левел: /allonline [0- чат, 1- сервер-лог], /scan [0- выкл., 1- вкл.],");
				SendClientMessage(playerid, COLOR_GREY, "     /ipban [IP-адрес], /ipunban [IP-адрес]");
				SendClientMessage(playerid, COLOR_GREY, "     /plcmon [0- чат, 1- сервер-лог] [0- выкл., 1- вкл., 2- просмотреть настройки]");
				SendClientMessage(playerid, COLOR_GREY, "     ( дополнительно [дальность определения(10-1000)] )");
			}
#endif
			SendClientMessage(playerid,COLOR_GREY," ---------------------------------------------------------------------------------------------- ");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	
///*МенюТелепорта
	if(strcmp(cmd, "/helptp", true) == 0)
	{
		SendClientMessage(playerid,COLOR_RED," -------------------------- Дополнительные телепорты -------------------------- ");
		SendClientMessage(playerid, COLOR_GREEN, "Разное: /clubdark /topband");
		SendClientMessage(playerid, COLOR_GREEN, "Спавны: /spawnls /spawnsf /spawnlv");
		SendClientMessage(playerid, COLOR_GREEN, "ДМ Зоны: /dm13 /dm14");
		SendClientMessage(playerid, COLOR_GREEN, "Развлечения: /bdsm /samolet /parksf /bardel ");
		SendClientMessage(playerid,COLOR_RED," ---------------------------------------------------------------------------------------------- ");
		return 1;
	}
///*самолет
	if (strcmp(cmd,"/samolet",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1.5786,25.1747,1199.5938+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро Пожловать В Самолет");
		return 1;
	}
///*самолет
///*бдсм
	if (strcmp(cmd,"/bdsm",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 6);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 345.5856,306.4812,999.1484+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро Пожловать В Комнату БДСМ");
		return 1;
	}
///*бдсм
///*ПаркСФ
	if (strcmp(cmd,"/parksf",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, -2201.8979,1619.7367,4.5558+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро Пожловать В Парк Города Сан Фиеро");
		return 1;
	}
///*Парк СФ
///*dm14
	if (strcmp(cmd,"/dm14",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 2);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2546.0718,-1297.4779,1044.1250+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро Пожловать На ДМ Зону 14");
		return 1;
	}
///*dm14
///*dm13
	if (strcmp(cmd,"/dm13",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 18);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1288.5935,-14.4722,1001.0156+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро Пожловать На ДМ Зону 13");
		return 1;
	}
///*dm13
///*topband
	if (strcmp(cmd,"/topband",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1247.9266,-1636.5559,27.3750+1);
		SendClientMessage(playerid, COLOR_GREEN, " Топ Кланы сервера");
		return 1;
	}
///*topband
///*spawnsf
	if (strcmp(cmd,"/spawnsf",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, -2914.8237,464.1307,4.9141+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на Спавн СФ");
		return 1;
	}
///*spawnsf
///*spawnlv
	if (strcmp(cmd,"/spawnlv",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1084.9733,1086.3578,10.8359+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на Спавн ЛВ");
		return 1;
	}
///*spawnlv
///*spawnls
	if (strcmp(cmd,"/spawnls",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1266.5657,-1648.5308,13.5469+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на Спавн ЛС");
		return 1;
	}
///*spawnls
///*leimanclub
	if (strcmp(cmd,"/clubdark",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2467.8826,-631.9252,8.2979+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать В Club Dark");
		return 1;
	}
///*leimanclub
///*Бардель
	if (strcmp(cmd,"/bardel",true) == 0)
	{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2219.6941,-1145.0464,25.7891+1);
		SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать В Бoрдель");
		return 1;
	}
///*Бардель
	if (strcmp(cmd,"/lctp1",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
			SetPVarInt(playerid, "PlCRTp", 1);
			SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -737.78, 486.74, 1371.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать в Либерти Сити - 1 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/lctp2",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
			SetPVarInt(playerid, "PlCRTp", 1);
			SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -785.24, 495.22, 1376.20+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать в Либерти Сити - 2 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/lctp3",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
//------------------------------------------------------------------------------
//эти строки должны использоваться для телепортов обычных игроков (НЕ админов) -
//- для блокировки FLY-античита (или телепорт-античита) !!! (именно здесь -
//- эти строки используются в качестве примера !!!)
			SetPVarInt(playerid, "PlCRTp", 1);
			SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -834.33, 503.97, 1358.30+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать в Либерти Сити - 3 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp1",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 0.00, 0.00, 19516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на площадку - 1 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp2",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 1543.85, -1353.98, 14516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на площадку - 2 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp3",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -1981.03, 443.81, 9516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на площадку - 3 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp4",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 2169.05, 1676.22, 4516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " Добро пожаловать на площадку - 4 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/keyon",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 2 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /keyon [ид игрока]");
				return 1;
			}
			new para1 = strval(tmp);
			if(GetPVarInt(playerid, "AdmLvl") <= 9 && GetPVarInt(para1, "AdmLvl") >= 10)
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не можете следить за клавиатурой админа 10-го уровня !");
				return 1;
			}
			if(IsPlayerConnected(para1))
			{
				if(spectate[playerid] == para1)
				{
					SendClientMessage(playerid, COLOR_RED, " Вы уже следите за клавиатурой выбранного игрока !");
					return 1;
				}
				spectate[playerid] = para1;
				GetPlayerName(playerid, sendername, sizeof(sendername));
				GetPlayerName(para1, giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), " *** Админ %s включил слежение за клавиатурой игрока %s .", sendername, giveplayer);
				print(string);
				SendAdminMessage(0, 0, COLOR_YELLOW, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/keyoff",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 2 || IsPlayerAdmin(playerid))
		{
			spectate[playerid] = 600;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " *** Админ %s отключил слежение за клавиатурой.", sendername);
			print(string);
			SendAdminMessage(0, 0, COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/tshp",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 2 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /tshp [ид игрока] ( дополнительно [корректор пинга(10-1000)] )");
				return 1;
			}
			new para1 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new para2;
			if(!strlen(tmp))
			{
				para2 = 50;
			}
			else
			{
				para2 = strval(tmp);
			}
			if(para2 < 10 || para2 > 1000)
			{
				SendClientMessage(playerid, COLOR_RED, " Корректор пинга от 10 до 1000 !");
				return 1;
			}
			if(IsPlayerConnected(para1))
			{
				if(mnhp == 1)
				{
					SendClientMessage(playerid, COLOR_RED, " Команда занята другим админом !");
					return 1;
				}
				mnhp = 1;
				pler1 = 0;
				pler2 = 0;
				SendClientMessage(playerid, COLOR_GREEN, " Начало теста...");
				GetPlayerArmour(para1, plarm);
				GetPlayerHealth(para1, plhp);
				pping1 = GetPlayerPing(para1);
				SetTimerEx("FPing2", 500, 0, "iii", playerid, para1, para2);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/allonline",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /allonline [0- чат, 1- сервер-лог]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- чат, 1- сервер-лог !");
				return 1;
			}
			if (para1 == 1 && (GetPVarInt(playerid, "AdmLvl") >= 1 && GetPVarInt(playerid, "AdmLvl") <= 9))
			{
				SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой опции !");
				return 1;
			}
			if(mnon == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда занята другим админом !");
				return 1;
			}
			mnon = 1;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(para1 == 0)
					{
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), " *** ID: [%d] - %s", i, giveplayer);
						SendClientMessage(playerid, COLOR_GREEN, string);
					}
					else
					{
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						new aa333[64];//доработка для использования Русских ников
						format(aa333, sizeof(aa333), "%s", giveplayer);//доработка для использования Русских ников
						printf(" *** ID: [%d] - %s", i, aa333);//доработка для использования Русских ников
//						printf(" *** ID: [%d] - %s", i, giveplayer);
					}
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(para1 == 0)
			{
				format(string, sizeof(string), " *** Админ %s создал список on-line игроков в собственном чате.", sendername);
			}
			else
			{
				format(string, sizeof(string), " *** Админ %s создал список on-line игроков в сервер-логе.", sendername);
			}
			print(string);
			SendAdminMessage(0, 0, COLOR_GREEN, string);
			mnon = 0;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/scan",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 10 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /scan [0- выкл., 1- вкл.]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- выкл., 1- вкл. !");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			if(para1 == 0)
			{
			    if(razresh == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Скан функций уже выключен !");
					return 1;
				}
				else
				{
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					printf("[KeyScan] *** Админ %s выключил скан функций.", aa333);//доработка для использования Русских ников
//					printf("[KeyScan] *** Админ %s выключил скан функций.", sendername);
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					SendClientMessage(playerid, COLOR_RED, " Вы выключили скан функций.");
					razresh = 0;
				}
			}
			if(para1 == 1)
			{
			    if(razresh == 1)
				{
					SendClientMessage(playerid, COLOR_RED, " Скан функций уже включен !");
					return 1;
				}
				else
				{
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					printf("[KeyScan] *** Админ %s выключил скан функций.", aa333);//доработка для использования Русских ников
//					printf("[KeyScan] *** Админ %s выключил скан функций.", sendername);
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					SendClientMessage(playerid, COLOR_GREEN, " Вы включили скан функций.");
					razresh = 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/ipban",true) == 0)
	{
#if (MOD55INS == 1)
		if (GetPVarInt(playerid, "AdmLvl") >= 9 || IsPlayerAdmin(playerid))
#endif
#if (MOD55INS == 2)
		if (GetPVarInt(playerid, "AdmLvl") >= 10 || IsPlayerAdmin(playerid))
#endif
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /ipban [IP-адрес]");
				return 1;
			}
			new dltmp;
			dltmp = strlen(tmp);
			if(dltmp < 7 || dltmp > 15)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина IP-адреса должна быть от 7 до 15 символов !");
				return 1;
			}
			new dopper111 = 0;
			new dopper222 = 0;
			for(new i = 0; i < dltmp; i++)
			{
				if((tmp[i] < 48 || tmp[i] > 57) && tmp[i] != '.' && tmp[i] != '*') {dopper111 = 1;}
				if(tmp[i] == '.') {dopper222++;}
			}
			if(dopper111 == 1 || dopper222 != 3)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
			for(new i = 0; i < 4; i++)//очистка локальной части массива ipper
			{
				for(new j = 0; j < 32; j++)
				{
					ipper[playerid][i][j] = 0;
				}
			}
			new ind1, ind2;//разделение IP-адреса
			ind1 = -1;
			for(new i = 0; i < 4; i++)
			{
				ind1++;
				ind2 = 0;
				while(tmp[ind1] != '.')
				{
					if(ind1 > dltmp)
					{
						break;
					}
					ipper[playerid][i][ind2] = tmp[ind1];
					ind1++;
					ind2++;
				}
			}
			dopper111 = 0;
			for(new i = 0; i < 4; i++)
			{
				if(strlen(ipper[playerid][i]) < 1 || strlen(ipper[playerid][i]) > 3) {dopper111 = 1;}
			}
    		if(dopper111 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
    		if(strfind(ipper[playerid][0], "*", true) != -1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   IP-адрес НЕ может начинаться с шаблона !");
				return 1;
			}
    		if(strval(ipper[playerid][0]) > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
			new ind3 = 1;//проверка местоположения "*" в каждой из групп цифр,
			new ind4 = 0;//И проверка каждой группы цифр на максимально допустимый адрес
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
					if(ipper[playerid][ind3][2] == '*')
					{
    					if(strval(ipper[playerid][ind3]) > 25) {ind4 = 1;}
					}
					if(ipper[playerid][ind3][2] != '*')
					{
    					if(strval(ipper[playerid][ind3]) > 255) {ind4 = 2;}
					}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
    		if(ind4 == 2)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
			for(new i = 1; i < 4; i++)//замена символов "*" на символы "C"
			{
				new mm;
				mm = strlen(ipper[playerid][i]);
				for(new j = 0; j < mm; j++)
				{
					if(ipper[playerid][i][j] == '*') {ipper[playerid][i][j] = 'C';}
				}
			}
			new ip333[128];//сборка имени файла
			format(ip333, sizeof(ip333), "%s_%s_%s_%s", ipper[playerid][0], ipper[playerid][1], ipper[playerid][2], ipper[playerid][3]);

			new string222[256];
			new reason[128];//запись в бан-лист
			format(reason, 128, "(команда /ipban) --- Админ: [ %s ]", sendername);//формируем метку админа
			gettime(timecor[0], timecor[1]);
			getdate(timecor[2], timecor[3], timecor[4]);
			TimCor();//коррекция времени
			DatCor();//коррекция даты
			new stringdop[256];
			format(stringdop,256,"[%02d:%02d | %02d/%02d/%04d] - %s",timecor[0],timecor[1],timecor[4],timecor[3],timecor[2],reason);
			format(string222,sizeof(string222),"banlist/ipadr/%s.ini",ip333);
			new File: hFile = fopen(string222, io_write);//запись файла
			if (hFile)
			{
				new var[256];
				format(var, 256, "Data=%s\n",stringdop);fwrite(hFile, var);
				fclose(hFile);
			}

			new dopper33[256];//бан IP-адреса
			strdel(dopper33, 0, 256);
			strcat(dopper33, "banip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			format(string, sizeof(string), " *** Админ %s забанил IP адрес: [%s]", sendername, tmp);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/ipunban",true) == 0)
	{
#if (MOD55INS == 1)
		if (GetPVarInt(playerid, "AdmLvl") >= 9 || IsPlayerAdmin(playerid))
#endif
#if (MOD55INS == 2)
		if (GetPVarInt(playerid, "AdmLvl") >= 10 || IsPlayerAdmin(playerid))
#endif
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /ipunban [IP-адрес]");
				return 1;
			}
			new dltmp;
			dltmp = strlen(tmp);
			if(dltmp < 7 || dltmp > 15)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина IP-адреса должна быть от 7 до 15 символов !");
				return 1;
			}
			new dopper111 = 0;
			new dopper222 = 0;
			for(new i = 0; i < dltmp; i++)
			{
				if((tmp[i] < 48 || tmp[i] > 57) && tmp[i] != '.' && tmp[i] != '*') {dopper111 = 1;}
				if(tmp[i] == '.') {dopper222++;}
			}
			if(dopper111 == 1 || dopper222 != 3)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
			for(new i = 0; i < 4; i++)//очистка локальной части массива ipper
			{
				for(new j = 0; j < 32; j++)
				{
					ipper[playerid][i][j] = 0;
				}
			}
			new ind1, ind2;//разделение IP-адреса
			ind1 = -1;
			for(new i = 0; i < 4; i++)
			{
				ind1++;
				ind2 = 0;
				while(tmp[ind1] != '.')
				{
					if(ind1 > dltmp)
					{
						break;
					}
					ipper[playerid][i][ind2] = tmp[ind1];
					ind1++;
					ind2++;
				}
			}
			dopper111 = 0;
			for(new i = 0; i < 4; i++)
			{
				if(strlen(ipper[playerid][i]) < 1 || strlen(ipper[playerid][i]) > 3) {dopper111 = 1;}
			}
    		if(dopper111 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
    		if(strfind(ipper[playerid][0], "*", true) != -1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   IP-адрес НЕ может начинаться с шаблона !");
				return 1;
			}
    		if(strval(ipper[playerid][0]) > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
			new ind3 = 1;//проверка местоположения "*" в каждой из групп цифр,
			new ind4 = 0;//И проверка каждой группы цифр на максимально допустимый адрес
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
					if(ipper[playerid][ind3][2] == '*')
					{
    					if(strval(ipper[playerid][ind3]) > 25) {ind4 = 1;}
					}
					if(ipper[playerid][ind3][2] != '*')
					{
    					if(strval(ipper[playerid][ind3]) > 255) {ind4 = 2;}
					}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
    		if(ind4 == 2)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
			for(new i = 1; i < 4; i++)//замена символов "*" на символы "C"
			{
				new mm;
				mm = strlen(ipper[playerid][i]);
				for(new j = 0; j < mm; j++)
				{
					if(ipper[playerid][i][j] == '*') {ipper[playerid][i][j] = 'C';}
				}
			}
			new ip333[128];//сборка имени файла
			format(ip333, sizeof(ip333), "%s_%s_%s_%s", ipper[playerid][0], ipper[playerid][1], ipper[playerid][2], ipper[playerid][3]);
			new dopper33[256];//разбан IP-адреса
			strdel(dopper33, 0, 256);
			strcat(dopper33, "unbanip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " *** Админ %s разбанил IP адрес: [%s]", sendername, tmp);
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);

			new string222[256];
			format(string222,sizeof(string222),"banlist/ipadr/%s.ini",ip333);
			if(fexist(string222))
			{
				fremove(string222);//удаляем IP-адрес из бан-листа
				format(string,sizeof(string)," ( IP-адрес [%s] был удалён из бан-листа ) !", tmp);
				print(string);
				SendClientMessage(playerid, COLOR_GREEN, string);
			}

		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/cc",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			for(new i=0; i<150; i++)
			{
				SendClientMessageToAll(0xFFFFFFFF, " ");
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " *** Админ %s очистил чат сервера !", sendername);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if (strcmp(cmd,"/plcmon",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /plcmon [0- чат, 1- сервер-лог] [0- выкл., 1- вкл.,");
				SendClientMessage(playerid, COLOR_GRAD2, " 2- просмотреть настройки] ( дополнительно [дальность определения(10-1000)] )");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- чат, 1- сервер-лог !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new para2;
			para2 = strval(tmp);
			if(para2 < 0 || para2 > 2)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- выкл., 1- вкл., 2- просмотреть настройки] !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new para3;
			new para4;
			if(!strlen(tmp))
			{
				para3 = 500;
				para4 = 0;
			}
			else
			{
				para3 = strval(tmp);
				para4 = 1;
			}
			if(para3 < 10 || para3 > 1000)
			{
				SendClientMessage(playerid, COLOR_RED, " Дальность определения от 10 до 1000 !");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			if(para1 == 0)
			{
				if(para2 == 0)
				{
					if(plloc[playerid] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Краш-монитор в чате уже отключен !");
						return 1;
					}
					else
					{
						plloc[playerid] = 0;
						format(string, sizeof(string), " *** Админ %s отключил краш-монитор в чате.", aa333);
						print(string);
						SendAdminMessage(0, 0, COLOR_RED, string);
						return 1;
					}
				}
				if(para2 == 1)
				{
					if(plloc[playerid] == 1 && para4 == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Вы не задали дальность определения !");
						return 1;
					}
					if(plloc[playerid] == 1 && para4 == 1 && pllocdist[playerid] == para3)
					{
						SendClientMessage(playerid, COLOR_RED, " Вы задали старую дальность определения !");
						return 1;
					}
					if(plloc[playerid] == 1 && para4 == 1 && pllocdist[playerid] != para3)
					{
						pllocdist[playerid] = para3;
						format(string, sizeof(string), " *** Админ %s изменил дальность определения для краш-монитора в чате на %d", aa333, pllocdist[playerid]);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
					if(plloc[playerid] == 0)
					{
						plloc[playerid] = 1;
						pllocdist[playerid] = para3;
						format(string, sizeof(string), " *** Админ %s включил краш-монитор в чате, с дальностью определения %d", aa333, pllocdist[playerid]);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
				}
				if(para2 == 2)
				{
					if(plloc[playerid] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Краш-монитор в чате отключен.");
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						SendClientMessage(playerid, COLOR_GREEN, " Краш-монитор в чате включен.");
						format(string, sizeof(string), " Дальность определения: {FFFF00}%d .", pllocdist[playerid]);
						SendClientMessage(playerid, COLOR_GREEN, string);
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						printf(" *** Админ %s просмотрел настройки краш-монитора в чате.", aa333);
						return 1;
					}
				}
			}
			if(para1 == 1)
			{
				if(GetPVarInt(playerid, "AdmLvl") <= 9)
				{
					SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой опции !");
					return 1;
				}
				if(para2 == 0)
				{
					if(plgl == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Краш-монитор в сервер-логе уже отключен !");
						return 1;
					}
					else
					{
						plgl = 0;
						SaveData();//запись файла keyscan.ini
						format(string, sizeof(string), " *** Админ %s отключил краш-монитор в сервер-логе.", aa333);
						print(string);
						SendAdminMessage(0, 0, COLOR_RED, string);
						return 1;
					}
				}
				if(para2 == 1)
				{
					if(plgl == 1 && para4 == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Вы не задали дальность определения !");
						return 1;
					}
					if(plgl == 1 && para4 == 1 && plgldist == para3)
					{
						SendClientMessage(playerid, COLOR_RED, " Вы задали старую дальность определения !");
						return 1;
					}
					if(plgl == 1 && para4 == 1 && plgldist != para3)
					{
						plgldist = para3;
						SaveData();//запись файла keyscan.ini
						format(string, sizeof(string), " *** Админ %s изменил дальность определения для краш-монитора в сервер-логе на %d", aa333, plgldist);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
					if(plgl == 0)
					{
						plgl = 1;
						plgldist = para3;
						SaveData();//запись файла keyscan.ini
						format(string, sizeof(string), " *** Админ %s включил краш-монитор в сервер-логе, с дальностью определения %d", aa333, plgldist);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
				}
				if(para2 == 2)
				{
					if(plgl == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Краш-монитор в сервер-логе отключен.");
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						SendClientMessage(playerid, COLOR_GREEN, " Краш-монитор в сервер-логе включен.");
						format(string, sizeof(string), " Дальность определения: {FFFF00}%d .", plgldist);
						SendClientMessage(playerid, COLOR_GREEN, string);
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						printf(" *** Админ %s просмотрел настройки краш-монитора в сервер-логе.", aa333);
						return 1;
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	return 0;
}

public EndPlCRTp(playerid)
{
	SetPVarInt(playerid, "PlCRTp", 0);
	return 1;
}

public FPing2(playerid, para1, para2)
{
	pping2 = GetPlayerPing(para1);
	SetTimerEx("FPing3", 500, 0, "iii", playerid, para1, para2);
	return 1;
}

public FPing3(playerid, para1, para2)
{
	pping3 = GetPlayerPing(para1);
	new string[256];
	new dopper;
	dopper = (((pping1 + pping2 + pping3) / 3) * 2) + para2;
	format(string, sizeof(string), " Средний пинг: %d (при тесте: %d)", (dopper - para2) / 2, dopper);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	SetPlayerArmour(para1, 90.00);
	SetTimerEx("Prov1", dopper, 0, "iii", playerid, para1, dopper);
	return 1;
}

public Prov1(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerArmour(para1, dopper);
	if(dopper <= 87.00 || dopper >= 93.00)
	{
		pler1 = 1;
	}
	SetPlayerArmour(para1, 60.00);
	SetTimerEx("Prov2", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov2(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerArmour(para1, dopper);
	if(dopper <= 57.00 || dopper >= 63.00)
	{
		pler1 = 1;
	}
	SetPlayerArmour(para1, 30.00);
	SetTimerEx("Prov3", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov3(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerArmour(para1, dopper);
	if(dopper <= 27.00 || dopper >= 33.00)
	{
		pler1 = 1;
	}
	SetPlayerHealth(para1, 90.00);
	SetTimerEx("Prov4", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov4(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerHealth(para1, dopper);
	if(dopper <= 87.00 || dopper >= 93.00)
	{
		pler2 = 1;
	}
	SetPlayerHealth(para1, 60.00);
	SetTimerEx("Prov5", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov5(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerHealth(para1, dopper);
	if(dopper <= 57.00 || dopper >= 63.00)
	{
		pler2 = 1;
	}
	SetPlayerHealth(para1, 30.00);
	SetTimerEx("Prov6", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov6(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerHealth(para1, dopper);
	if(dopper <= 27.00 || dopper >= 33.00)
	{
		pler2 = 1;
	}
	SetPlayerArmour(para1, plarm);
	SetPlayerHealth(para1, plhp);
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	format(string, sizeof(string), " *** Админ %s протестировал игрока %s на hp.", sendername, giveplayer);
	print(string);
	SendAdminMessage(0, 0, COLOR_YELLOW, string);
	if(pler1 == 0 && pler2 == 0)
	{
		format(string, sizeof(string), " Игрок %s [%d]: {00FF00}броня - ок, жизнь - ок", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	if(pler1 == 1 && pler2 == 0)
	{
		format(string, sizeof(string), " Игрок %s [%d]: {FF0000}броня - ошибка, {00FF00}жизнь - ок", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	if(pler1 == 0 && pler2 == 1)
	{
		format(string, sizeof(string), " Игрок %s [%d]: {00FF00}броня - ок, {FF0000}жизнь - ошибка", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	if(pler1 == 1 && pler2 == 1)
	{
		format(string, sizeof(string), " Игрок %s [%d]: {FF0000}броня - ошибка, жизнь - ошибка", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(razresh == 1)
	{
    	new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		printf("[KeyScan][key] %s [%d] - %d ... %d", aa333, playerid, newkeys, oldkeys);//доработка для использования Русских ников
//		printf("[KeyScan][key] %s [%d] - %d ... %d", sendername, playerid, newkeys, oldkeys);
	}
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			new data;
			data = newkeys - oldkeys;
			if (data > 0)
			{
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				switch(data)
				{
					case 1: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Действие", giveplayer, playerid);
					case 2: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Присесть", giveplayer, playerid);
					case 4: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Огонь", giveplayer, playerid);
					case 8: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Бежать", giveplayer, playerid);
					case 16: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Вторичная атака", giveplayer, playerid);
					case 32: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Прыжок", giveplayer, playerid);
					case 64: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Смотреть вправо", giveplayer, playerid);
					case 128: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Ручной тормоз, (назад или вправо)", giveplayer, playerid);
					case 132: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - {FFFF00}Ручной тормоз-2", giveplayer, playerid);
					case 256: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Смотреть влево", giveplayer, playerid);
					case 512: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Субмиссия или смотреть назад", giveplayer, playerid);
					case 1024: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Идти шагом", giveplayer, playerid);
					case 2048: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Вверх (цифр. клав.)", giveplayer, playerid);
					case 4096: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Вниз (цифр. клав.)", giveplayer, playerid);
					case 8192: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Влево (цифр. клав.)", giveplayer, playerid);
					case 16384: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Вправо (цифр. клав.)", giveplayer, playerid);
					case 65408: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Вперёд или влево", giveplayer, playerid);
					case 65536: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - {FFFF00}Ответ: ДА", giveplayer, playerid);
					case 131072: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - {FFFF00}Ответ: НЕТ", giveplayer, playerid);
					case 262144: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - Контроль группы", giveplayer, playerid);
					case 264192: format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - {FFFF00}Радио вниз", giveplayer, playerid);
				}
				if (data == 1 || data == 2 || data == 4 || data == 8 || data == 16 || data == 32 || data == 64 || data == 128 ||
				data == 132 || data == 256 || data == 512 || data == 1024 || data == 2048 || data == 4096 || data == 8192 ||
				data == 16384 || data == 65408 || data == 65536 || data == 131072 || data == 262144 || data == 264192)
				{
					SendClientMessage(i, COLOR_GREEN, string);
				}
				if (data != 1 && data != 2 && data != 4 && data != 8 && data != 16 && data != 32 && data != 64 && data != 128 &&
				data != 132 && data != 256 && data != 512 && data != 1024 && data != 2048 && data != 4096 && data != 8192 &&
				data != 16384 && data != 65408 && data != 65536 && data != 131072 && data != 262144 && data != 264192 &&
				(data > 0 && data < 8192))
				{
					format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - {FFFF00}Совмещённый код (%d)", giveplayer, playerid, data);
					SendClientMessage(i, COLOR_GREEN, string);
				}
				if (data != 1 && data != 2 && data != 4 && data != 8 && data != 16 && data != 32 && data != 64 && data != 128 &&
				data != 132 && data != 256 && data != 512 && data != 1024 && data != 2048 && data != 4096 && data != 8192 &&
				data != 16384 && data != 65408 && data != 65536 && data != 131072 && data != 262144 && data != 264192 &&
				data > 8192)
				{
					format(string, sizeof(string), " Игрок: %s [%d] (клавиатура) - {FF0000}Неопределённый код (%d)", giveplayer, playerid, data);
					SendClientMessage(i, COLOR_GREEN, string);
				}
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(razresh == 1)
	{
    	new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		printf("[KeyScan][click] %s [%d] - %d ... %d", aa333, playerid, clickedplayerid, source);//доработка для использования Русских ников
//		printf("[KeyScan][click] %s [%d] - %d ... %d", sendername, playerid, clickedplayerid, source);
	}
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new targetname[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(clickedplayerid, targetname, sizeof(targetname));
			format(string, sizeof(string), " Игрок: %s [%d] {FF0000}(клик по игроку){00FF00} - %s [%d]", giveplayer, playerid, targetname, clickedplayerid);
			SendClientMessage(i, COLOR_GREEN, string);
		}
	}
	return 1;
}

public DatCor()
{
	new Float:flyear;
	timecor[3] = timecor[3] + CorTime[3];//обработка месяца
	timecor[5] = 0;//перенос на год
	if(timecor[3] < 1)
	{
		timecor[3] = 12 + timecor[3];
		timecor[5] = -1;//перенос на год
	}
	if(timecor[3] > 12)
	{
		timecor[3] = timecor[3] - 12;
		timecor[5] = 1;//перенос на год
	}
	timecor[2] = timecor[2] + CorTime[4] + timecor[5];//обработка года
	flyear = float(timecor[2]);
	flyear = floatdiv(flyear, 4);
	flyear = floatfract(flyear);
	if(flyear != 0){timecor[7] = 0;}//НЕ високосный год
	if(flyear == 0){timecor[7] = 1;}//високосный год
	timecor[4] = timecor[4] + CorTime[2] + timecor[6];//обработка числа
	timecor[5] = 0;//перенос на месяц
	if(timecor[4] < 1 && timecor[3] == 3 && timecor[7] == 0)
	{
		timecor[4] = 28 + timecor[4];
		timecor[5] = -1;//перенос на месяц
	}
	if(timecor[4] < 1 && timecor[3] == 3 && timecor[7] == 1)
	{
		timecor[4] = 29 + timecor[4];
		timecor[5] = -1;//перенос на месяц
	}
	if(timecor[4] < 1 && (timecor[3] == 5 || timecor[3] == 7 || timecor[3] == 10 || timecor[3] == 12))
	{
		timecor[4] = 30 + timecor[4];
		timecor[5] = -1;//перенос на месяц
	}
	if(timecor[4] < 1 && (timecor[3] == 2 || timecor[3] == 4 || timecor[3] == 6 || timecor[3] == 8 || timecor[3] == 9 || timecor[3] == 11 || timecor[3] == 1))
	{
		timecor[4] = 31 + timecor[4];
		timecor[5] = -1;//перенос на месяц
	}
	if(timecor[4] > 28 && timecor[3] == 2 && timecor[7] == 0)
	{
		timecor[4] = timecor[4] - 28;
		timecor[5] = 1;//перенос на месяц
	}
	if(timecor[4] > 29 && timecor[3] == 2 && timecor[7] == 1)
	{
		timecor[4] = timecor[4] - 29;
		timecor[5] = 1;//перенос на месяц
	}
	if(timecor[4] > 30 && (timecor[3] == 4 || timecor[3] == 6 || timecor[3] == 9 || timecor[3] == 11))
	{
		timecor[4] = timecor[4] - 30;
		timecor[5] = 1;//перенос на месяц
	}
	if(timecor[4] > 31 && (timecor[3] == 1 || timecor[3] == 3 || timecor[3] == 5 || timecor[3] == 7 || timecor[3] == 8 || timecor[3] == 10 || timecor[3] == 12))
	{
		timecor[4] = timecor[4] - 31;
		timecor[5] = 1;//перенос на месяц
	}
	timecor[3] = timecor[3] + timecor[5];//коррекция месяца
	timecor[5] = 0;//перенос на год
	if(timecor[3] < 1)
	{
		timecor[3] = 12 + timecor[3];
		timecor[5] = -1;//перенос на год
	}
	if(timecor[3] > 12)
	{
		timecor[3] = timecor[3] - 12;
		timecor[5] = 1;//перенос на год
	}
	timecor[2] = timecor[2] + timecor[5];//коррекция года
	return 1;
}

public TimCor()
{
	timecor[1] = timecor[1] + CorTime[1];//обработка минут
	timecor[5] = 0;//перенос на час
	if(timecor[1] < 0)
	{
		timecor[1] = 60 + timecor[1];
		timecor[5] = -1;//перенос на час
	}
	if(timecor[1] > 59)
	{
		timecor[1] = timecor[1] - 60;
		timecor[5] = 1;//перенос на час
	}
	timecor[0] = timecor[0] + CorTime[0] + timecor[5];//обработка часов
	timecor[6] = 0;//перенос на день
	if(timecor[0] < 0)
	{
		timecor[0] = 24 + timecor[0];
		timecor[6] = -1;//перенос на день
	}
	if(timecor[0] > 23)
	{
		timecor[0] = timecor[0] - 24;
		timecor[6] = 1;//перенос на день
	}
	return 1;
}

public ReadCorTime()
{
	new string[256];
	format(string,sizeof(string),"data/cortime.ini");
	new File: UserFile = fopen(string, io_read);//чтение файла
	new key[ 256 ] , val[ 256 ];
	new Data[ 256 ];
	while ( fread( UserFile , Data , sizeof( Data ) ) )
	{
		key = ini_GetKey( Data );
		if( strcmp( key , "hour" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[0] = strval( val ); }
		if( strcmp( key , "minute" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[1] = strval( val ); }
		if( strcmp( key , "day" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[2] = strval( val ); }
		if( strcmp( key , "month" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[3] = strval( val ); }
		if( strcmp( key , "year" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[4] = strval( val ); }
	}
	fclose(UserFile);
	return 1;
}

public dopfunction(per)
{
	ReadCorTime();
	return 1;
}

public ReadData()
{
	new string[256];
	format(string,sizeof(string),"data/keyscan.ini");
	new File: UserFile = fopen(string, io_read);//чтение файла
	new key[ 256 ] , val[ 256 ];
	new Data[ 256 ];
	while ( fread( UserFile , Data , sizeof( Data ) ) )
	{
		key = ini_GetKey( Data );
		if( strcmp( key , "SLMon" , true ) == 0 ) { val = ini_GetValue( Data ); plgl = strval( val ); }
		if( strcmp( key , "SLMonDist" , true ) == 0 ) { val = ini_GetValue( Data ); plgldist = strval( val ); }
	}
	fclose(UserFile);
	return 1;
}

public SaveData()
{
	new string[256];
	format(string,sizeof(string),"data/keyscan.ini");
	new File: hFile = fopen(string, io_write);//запись файла
	if (hFile)
	{
		new var[32];
		format(var, 32, "SLMon=%d\n",plgl);fwrite(hFile, var);
		format(var, 32, "SLMonDist=%d\n",plgldist);fwrite(hFile, var);
		fclose(hFile);
	}
	return 1;
}

