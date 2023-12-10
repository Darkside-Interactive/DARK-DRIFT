#include <a_samp>

#pragma dynamic 8000

#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //максимум игроков на сервере + 1 (если 50 игроков, то пишем 51 !!!)

#define OBRAD 13 //число радио +1

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA

new NRadio[MAX_PLAYERS];//переменная номера подключенного радио
new STRadio[OBRAD][128];//массив URL-ссылок на радио-потоки
new NMRadio[OBRAD][64];//массив названий радио

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("        Filterscript Radio - 3         ");
	print("--------------------------------------\n");

	STRadio[1] = "http://www.zaycev.fm:9001/ZaycevFM(128).m3u";
	STRadio[2] = "http://ep128server.streamr.ru:8030/ep128";
	STRadio[3] = "http://air.radiorecord.ru:8102/sd90_128";
	STRadio[4] = "http://online.nashipesni.ru:8000/nashipesni";
	STRadio[5] = "http://stream05.akaver.com/russkoeradio_hi.mp3";
	STRadio[6] = "http://cast.radiogroup.com.ua:8000/avtoradio";
	STRadio[7] = "http://air.radiorecord.ru:8101/rr_128";
	STRadio[8] = "http://air.radiorecord.ru:8102/dub_128";
	STRadio[9] = "http://air.radiorecord.ru:8102/club_128";
	STRadio[10] = "http://air.radiorecord.ru:8102/mdl_128";
	STRadio[11] = "http://aska.ru-hoster.com:2199/tunein/marseli.pls";
	STRadio[12] = "http://streaming.radionomy.com/radio-xtreme---sensation-tubes-garantie";

	NMRadio[1] = "Zaycev-FM";
	NMRadio[2] = "Европа +";
	NMRadio[3] = "Супердискотека 90-х";
	NMRadio[4] = "Наши песни";
	NMRadio[5] = "Русское радио";
	NMRadio[6] = "Авторадио";
	NMRadio[7] = "Radio Record";
	NMRadio[8] = "Dubstep";
	NMRadio[9] = "Club";
	NMRadio[10] = "Медляк FM";
	NMRadio[11] = "LeimaN";
	NMRadio[12] = "Radio Xtreme";

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPVarInt(i, "CComAc2", 0);
	}
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{//отключение потоков для всех подключенных игороков
		if(IsPlayerConnected(i))
		{
			DeletePVar(i, "CComAc2");
			StopAudioStreamForPlayer(i);
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "CComAc2", 0);
	NRadio[playerid] = 0;//задаём игроку несуществующий номер подключенного радио
	StopAudioStreamForPlayer(playerid);//отключим любой поток
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	NRadio[playerid] = 0;//задаём игроку несуществующий номер подключенного радио
	StopAudioStreamForPlayer(playerid);//отключим любой поток
	DeletePVar(playerid, "CComAc2");
	return 1;
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

public OnPlayerCommandText(playerid, cmdtext[])
{
	SetPVarInt(playerid, "CComAc2", GetPVarInt(playerid, "CComAc2") + 1);
	new string[256];
	new cmd[256];
	new tmp[256];
	new idx;
    new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	new aa333[64];//доработка для использования Русских ников
	format(aa333, sizeof(aa333), "%s", pname);//доработка для использования Русских ников
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd,"/radon",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, " Используйте: /radon [радио(1-12)]");
			return 1;
		}
		new para1 = strval(tmp);
		if(para1 < 1 || para1 > 12)
		{
			SendClientMessage(playerid, COLOR_RED, " Такого радио нет !");
			return 1;
		}
		if(NRadio[playerid] != para1)
		{
			NRadio[playerid] = para1;//номер подключаемого радио
			StopAudioStreamForPlayer(playerid);//отключим любой другой поток
			PlayAudioStreamForPlayer(playerid, STRadio[para1]);//подключим поток с музыкой
			format(string, sizeof(string), " Вы включили радио %s", NMRadio[para1]);
			SendClientMessage(playerid, COLOR_GREY, string);
			printf("[radio] Игрок %s включил радио %s .", aa333, NMRadio[para1]);//доработка для использования Русских ников
//			printf("[radio] Игрок %s включил радио %s .", pname, NMRadio[para1]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " Нельзя, у Вас уже включено это радио !");
		}
	    return 1;
	}
	if (strcmp(cmd,"/radoff",true) == 0)
	{
		if(NRadio[playerid] != 0)
		{
			NRadio[playerid] = 0;//несуществующее радио
			StopAudioStreamForPlayer(playerid);//отключим любой поток
			SendClientMessage(playerid, COLOR_GREY, " Вы выключили радио");
			printf("[radio] Игрок %s выключил радио.", aa333);//доработка для использования Русских ников
//			printf("[radio] Игрок %s выключил радио.", pname);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " Нельзя, у Вас выключено радио !");
		}
	    return 1;
	}
	if(strcmp(cmd, "/radhelp", true) == 0)
	{
		SendClientMessage(playerid,COLOR_GREY," -------------------------- Помощь по радио -------------------------- ");
		SendClientMessage(playerid,COLOR_GREY,"               /radhelp   /radon [радио(1-12)]   /radoff");
		SendClientMessage(playerid,COLOR_GREY,"   /radall [радио(1-12)]   /radpl [ид игрока] [радио(1-12)]");
		SendClientMessage(playerid,COLOR_GREY," -------------------------------------------------------------------------------- ");

		new soob11[512];
		format(soob11, sizeof(soob11), "/radhelp - Помощь по радио\
		\n/radon [радио(1-12)] - Включить радио\
		\n/radoff - Выключить радио\
		\n/radall [радио(1-12)] - Включить радио всем игрокам");
		new soob12[512];
		format(soob12, sizeof(soob12), "\n/radpl [ид игрока] [радио(1-12)] - Включить радио отдельному игроку\
		\n\
		\n	Список радио:\
		\n1 - Zaycev-FM");
		new soob13[512];
		format(soob13, sizeof(soob13), "\n2 - Европа +\
		\n3 - Супердискотека 90-х\
		\n4 - Наши песни\
		\n5 - Русское радио");
		new soob14[512];
		format(soob14, sizeof(soob14), "\n6 - Авторадио\
		\n7 - Radio Record\
		\n8 - Dubstep\
		\n9 - Club");
		new soob15[512];
		format(soob15, sizeof(soob15), "\n10 - Медляк FM\
		\n11 - Гоп FM\
		\n12 - Radio Xtreme");
		new soob[2560];
		format(soob, sizeof(soob), "%s%s%s%s%s", soob11, soob12, soob13, soob14, soob15);
		ShowPlayerDialog(playerid, 2, 0, "Помощь по радио", soob, "OK", "");

    	return 1;
	}
	if (strcmp(cmd,"/radall",true) == 0)
    {
		if(GetPVarInt(playerid, "AdmLvl") >= 3 || IsPlayerAdmin(playerid))
        {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " Используйте: /radall [радио(1-12)]");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 < 1 || para1 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого радио нет !");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if((GetPVarInt(playerid, "AdmLvl") == 3 && GetPVarInt(i, "AdmLvl") <= 3) || GetPVarInt(playerid, "AdmLvl") >= 4)
					{
						NRadio[i] = para1;//номер подключаемого радио
						StopAudioStreamForPlayer(i);//отключим любой другой поток
						PlayAudioStreamForPlayer(i, STRadio[para1]);//подключим поток с музыкой
						format(string, sizeof(string), " *** Администратор %s включил всем радио %s ( для выключения введите /radoff )", pname, NMRadio[para1]);
						SendClientMessage(i, COLOR_GREY, string);
					}
					if(GetPVarInt(i, "AdmLvl") >= 4 && i != playerid)
					{
						format(string, sizeof(string), " *** Администратор %s включил всем радио %s", pname, NMRadio[para1]);
						SendClientMessage(i, COLOR_GREY, string);
					}
				}
			}
			printf("[radio] Aдмин %s включил всем радио %s .", aa333, NMRadio[para1]);//доработка для использования Русских ников
//			printf("[radio] Aдмин %s включил всем радио %s .", pname, NMRadio[para1]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
	    return 1;
    }
	if (strcmp(cmd,"/radpl",true) == 0)
    {
		if(GetPVarInt(playerid, "AdmLvl") >= 3 || IsPlayerAdmin(playerid))
        {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " Используйте: /radpl [ид игрока] [радио(1-12)]");
				return 1;
			}
			new para1 = strval(tmp);
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
				return 1;
			}
			if(para1 == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Чтобы включить радио самому себе, используйте: /radon !");
				return 1;
			}
			if(GetPVarInt(playerid, "AdmLvl") == 3 && GetPVarInt(para1, "AdmLvl") >= 4)
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не можете включить радио админу 4-го уровня !");
				return 1;
			}
    		new targetname[MAX_PLAYER_NAME];
			GetPlayerName(para1,targetname,sizeof(pname));
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Радио(1-12) !");
				return 1;
			}
			new para2 = strval(tmp);
			if(para2 < 1 || para2 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого радио нет !");
				return 1;
			}
			NRadio[para1] = para2;//номер подключаемого радио
			StopAudioStreamForPlayer(para1);//отключим любой другой поток
			PlayAudioStreamForPlayer(para1, STRadio[para2]);//подключим поток с музыкой
			format(string, sizeof(string), " *** Администратор %s включил Вам радио %s ( для выключения введите /radoff )", pname, NMRadio[para2]);
			SendClientMessage(para1, COLOR_GREY, string);
			format(string, sizeof(string), " *** Администратор %s включил игроку %s радио %s", pname, targetname, NMRadio[para2]);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
 					if((GetPVarInt(i, "AdmLvl") >= 1 || IsPlayerAdmin(i)) && i != para1)
   					{
						SendClientMessage(i, COLOR_GREY, string);
					}
				}
			}
			new aa222[64];//доработка для использования Русских ников
			format(aa222, sizeof(aa222), "%s", targetname);//доработка для использования Русских ников
			printf("[radio] Aдмин %s включил игроку %s радио %s .", aa333, aa222, NMRadio[para2]);//доработка для использования Русских ников
//			printf("[radio] Aдмин %s включил игроку %s радио %s .", pname, targetname, NMRadio[para2]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
	    return 1;
    }
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 2)
    {
		return 1;
	}
	return 0;
}

