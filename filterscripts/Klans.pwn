#include <a_samp>
#include <mxINI>
#include <sscanf2>
//=====================================
#define MAX_KLANS 50 // Максимальное кол-во кланов.
#define KLAN_MENU 1 // Меняйте на свободный ид диалога.
#define KLAN_CREATE 2 // Меняйте на свободный ид диалога.
#define KLAN_COLOR 3 // Меняйте на свободный ид диалога.
#define KLAN_INVITE 4 // Меняйте на свободный ид диалога.
#define KLAN_UNINVITE 5 // Меняйте на свободный ид диалога.
#define KLAN_ZAM 6 // Меняйте на свободный ид диалога.
#define KLAN_COLOR2 7 // Меняйте на свободный ид диалога.
#define KLAN_DELETE 8 // Меняйте на свободный ид диалога.
#define KLAN_SELECT 10 // Меняйте на свободный ид диалога.
#define KLAN_UNZAM 11 // Меняйте на свободный ид диалога.
new ID_KLANS;
static BIGSTR[1000];
static STR[256];
enum klans
{
	kOwner[32],
	kName[35],
	kParty,
	kRang[32],
	kColor
};
new KlanInfo[MAX_KLANS][klans];
static const KLN0[4][] =
{
	{"{006400}Добро пожаловать в меню создания нового клана!\n\n"},
	{"{FF8C00}С созданием клана для Вас буду открыты новые возможности, а именно:\n"},
	{"{FF0000}---> {FFFFFF}Приглашать и выгонять игроков из клана!\n{FF0000}---> {FFFFFF}Назначать заместителя клана!\n{FF0000}---> {FFFFFF}Изменять цвет клана!\n{FF0000}---> {FFFFFF}Для Вашего клана будет отдельный чат!\n\n"},
	{"{FFFF00}Введите название Вашего клана:"}
};
static KLN1[7][1] =
{
 	{0xFF0000FF}, // Красный
 	{0xFFFF00FF}, // Желтый
 	{0x006400FF}, // Зеленый
 	{0x0000FFFF}, // Синий
 	{0xFF8C00FF}, // Оранжевый
 	{0xFFFFFFFF}, // Белый
 	{0x800080FF} // Фиолетовый
};

//====
enum pInfo
{
	pKlan
};
new PlayerInfo[MAX_PLAYERS][pInfo];
//====
main(){}
public OnGameModeInit()
{
	print ("Clans Loading");
    LoadKlans();
	SetTimer("AntiTeleportNew", 1000,true);
	AddPlayerClass(307, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}
public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[128]; // Если у вас есть эти переменные, то удалите их.
    new string[256]; // Если у вас есть эти переменные, то удалите их.
	new idx; // Если у вас есть эти переменные, то удалите их.
    cmd = strtok(cmdtext, idx); // Если у вас есть эти переменные, то удалите их.
	if(strcmp(cmd,"/mklan", true) == 0)
	{
		if(PlayerInfo[playerid][pKlan] == 0) return SendClientMessage(playerid, -1, "У вас нет клана!");
		if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]],pName(playerid),true))
		{
			format(string,sizeof(string), "Меню клана - {1DE3CB}%s",KlanInfo[PlayerInfo[playerid][pKlan]][kName]);
 			ShowPlayerDialog(playerid, KLAN_MENU, DIALOG_STYLE_LIST,string,"Пригласить в клан\nВыгнать из клана\nНазначить заместителя\nСнять заместителя\nИзменить цвет клана\nУдалить клан\nСтатистика клана","Выбрать","Отмена");
		}
		return 1;
	}
	else if(strcmp(cmd,"/cklan", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 1) return SendClientMessage(playerid, -1, "У вас уже есть клан!");
	    format(BIGSTR,sizeof(BIGSTR), "%s%s%s%s", KLN0[0],KLN0[1],KLN0[2],KLN0[3]);
	    ShowPlayerDialog(playerid, KLAN_CREATE, DIALOG_STYLE_INPUT,"Создание клана",BIGSTR,"Далее","Отмена");
	    return 1;
	}
	else if(strcmp(cmd,"/klancolor", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 0) return 1;
	    new id = PlayerInfo[playerid][pKlan];
	    SetPlayerColor(playerid, KLN1[KlanInfo[id][kColor]][0]),SendClientMessage(playerid,KLN1[KlanInfo[id][kColor]][0], "Вы включили цвет Вашего клана");
	    return 1;
	}
	else if(strcmp(cmd,"/klanoff", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 0) return SendClientMessage(playerid, -1, "Вы не состоите в клане!");
	    if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kOwner],pName(playerid),true)) return SendClientMessage(playerid, -1, "Вы не можете уйти со своего клана!");
		if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],pName(playerid),true))
		{
		    strmid(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],"None",0,24,24);
		    KlanInfo[PlayerInfo[playerid][pKlan]][kParty]--;
			SaveClan(PlayerInfo[playerid][pKlan]);
			format(string, sizeof(string), "%s покинул клан!", pName(playerid));
	  		KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
	  		SaveClan(PlayerInfo[playerid][pKlan]);
			PlayerInfo[playerid][pKlan] = 0;
			SendClientMessage(playerid, -1, "Вы покинули клан!");
			//SavePlayer(playerid) // Меняем на свою функцию сохранения игрока.
		}
		else
		{
		    KlanInfo[PlayerInfo[playerid][pKlan]][kParty]--;
			SaveClan(PlayerInfo[playerid][pKlan]);
			format(string, sizeof(string), "%s покинул клан!", pName(playerid));
	  		KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
			PlayerInfo[playerid][pKlan] = 0;
			SendClientMessage(playerid, -1, "Вы покинули клан!");
		    //SavePlayer(playerid) // Меняем на свою функцию сохранения игрока.
		}
		return 1;
	}
	else if(strcmp(cmd,"/klanchat", true) == 0 || strcmp(cmd,"/kc", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 0) return SendClientMessage(playerid, -1, "Вы не состоите в клане!");
	    if(strcmp(KlanInfo[PlayerInfo[playerid][pKlan]],"None",false))
		{
		    new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kOwner],pName(playerid),true))
			{
				format(string, sizeof(string), "Создатель клана - %s[%d]: {FFFFFF}%s", pName(playerid), playerid, result);
				KlanMsg(KLN1[KlanInfo[PlayerInfo[playerid][pKlan]][kColor]][0], string, PlayerInfo[playerid][pKlan]);
				return 1;
			}
			else if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],pName(playerid),true))
			{
			    format(string, sizeof(string), "Заместитель - %s[%d]: {FFFFFF}%s", pName(playerid), playerid, result);
				KlanMsg(KLN1[KlanInfo[PlayerInfo[playerid][pKlan]][kColor]][0], string, PlayerInfo[playerid][pKlan]);
				return 1;
			}
			else
			{
			    format(string, sizeof(string), "Учасник - %s[%d]: {FFFFFF}%s", pName(playerid), playerid, result);
				KlanMsg(KLN1[KlanInfo[PlayerInfo[playerid][pKlan]][kColor]][0], string, PlayerInfo[playerid][pKlan]);
				return 1;
			}
		}
		return 1;
	}
	else if(strcmp(cmd,"/give", true) == 0)
	{
		PlayerInfo[playerid][pKlan] = 1;
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
 	SetPlayerPos(playerid, fX,fY,fZ);
  	SetPlayerInterior(playerid, 0);
    return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	                                      
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new string[258];
	switch(dialogid)
	{
	    case KLAN_MENU:
	    {
	        if(!response) return 1;
	        switch(listitem)
	        {
	            case 0: ShowPlayerDialog(playerid, KLAN_INVITE,DIALOG_STYLE_INPUT,"Пригласить игрока в клан","Введите ID игрока, которого хотите пригласить:","Пригласить","Отмена");
	            case 1: ShowPlayerDialog(playerid, KLAN_UNINVITE,DIALOG_STYLE_INPUT,"Выгнать из клана","Введите ID игрока, которого хотите выгнать:","Выгнать","Отмена");
	            case 2: ShowPlayerDialog(playerid, KLAN_ZAM,DIALOG_STYLE_INPUT,"Заместитель","Введите ID игрока, которого хотите назначить заместителем:","Готово","Отмена");
	            case 3: ShowPlayerDialog(playerid, KLAN_UNZAM,DIALOG_STYLE_INPUT,"Заместитель","Введите ID игрока, которого хотите снять с заместителя:","Готово","Отмена");
	            case 4: ShowPlayerDialog(playerid, KLAN_COLOR2,DIALOG_STYLE_LIST,"Цвет клана","{FF0000}Красный\n{FFFF00}Желтый\n{006400}Зеленый\n{0000FF}Синий\n{FF8C00}Оранжевый\n{FFFFFF}Белый\n{800080}Фиолетовый","Готово","Отмена");
	            case 5: ShowPlayerDialog(playerid, KLAN_DELETE,DIALOG_STYLE_MSGBOX,"Удаление клана","Вы действительно хотите удалить клан?","Да","Нет");
	            case 6:
				{
				    new color[100];
        			if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 0) {color = "{FF0000}Красный";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 1) {color = "{FFFF00}Желтый";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 2) {color = "{006400}Зеленый";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 3) {color = "{0000FF}Синий";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 4) {color = "{FF8C00}Оранжевый";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 5) {color = "{FFFFFF}Белый";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 6) {color = "{800080}Фиолетовый";}
					format(string,sizeof(string), "{FFFFFF}Цвет клана: %s\n{FFFFFF}Заместитель: {FF8C00}%s\n{FFFFFF}Участников: {FF8C00}%d", color,KlanInfo[PlayerInfo[playerid][pKlan]][kRang],KlanInfo[PlayerInfo[playerid][pKlan]][kParty]);
					ShowPlayerDialog(playerid, 0,DIALOG_STYLE_MSGBOX,"Статистика клана.",string,"Готово","");
				}
	        }
	    }
	    case KLAN_CREATE:
	    {
	        if(!response) return SendClientMessage(playerid, -1, "Вы отказались от создания клана!");
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid,KLAN_CREATE,DIALOG_STYLE_INPUT, "{FF0000}Ошибка!", "{FFFFFF}Длинна названия не должна быть меньше 6-и и больше 35-и символов!\nВведите название еще раз:", "Далее", "Закрыть");
	        if(strlen(inputtext) > 35) return ShowPlayerDialog(playerid,KLAN_CREATE,DIALOG_STYLE_INPUT, "{FF0000}Ошибка!", "{FFFFFF}Длинна названия не должна быть меньше 6-и и больше 35-и символов!\nВведите название еще раз:", "Далее", "Закрыть");
	        if(strlen(inputtext) < 6) return ShowPlayerDialog(playerid,KLAN_CREATE,DIALOG_STYLE_INPUT, "{FF0000}Ошибка!", "{FFFFFF}Длинна названия не должна быть меньше 6-и и больше 35-и символов!\nВведите название еще раз:", "Далее", "Закрыть");
	        for(new k; k <= ID_KLANS; k++)
	        {
	            if(!strcmp(KlanInfo[k][kName],"None",true))
		    	{
		    	    SetPVarString(playerid, "KLAN_NAME",inputtext);
		    	    ShowPlayerDialog(playerid, KLAN_COLOR,DIALOG_STYLE_LIST, "Выберите цвет клана:",
					"{FF0000}Красный\n{FFFF00}Желтый\n{006400}Зеленый\n{0000FF}Синий\n{FF8C00}Оранжевый\n{FFFFFF}Белый\n{800080}Фиолетовый","Выбрать","Отмена");
				}
				else SendClientMessage(playerid, -1, "Клан с таким названием уже существует!");
			}
	    }
	    case KLAN_COLOR:
	    {
	        if(!response) return SendClientMessage(playerid, -1, "Вы отказались от создания клана!"),DeletePVar(playerid,"KLAN_NAME");
	        switch(listitem)
	        {
	            case 0: SetPVarInt(playerid, "KLAN_COLOR", 0);
	            case 1: SetPVarInt(playerid, "KLAN_COLOR", 1);
	            case 2: SetPVarInt(playerid, "KLAN_COLOR", 2);
	            case 3: SetPVarInt(playerid, "KLAN_COLOR", 3);
	            case 4: SetPVarInt(playerid, "KLAN_COLOR", 4);
	            case 5: SetPVarInt(playerid, "KLAN_COLOR", 5);
	            case 6: SetPVarInt(playerid, "KLAN_COLOR", 6);
	        }
	        SendClientMessage(playerid, -1, "Клан успешно создан! Управление кланом - {FFFF00}(/mklan)");
	        new NAME[35];
		 	ID_KLANS++,Save_ID_KLANS();
	        GetPVarString(playerid, "KLAN_NAME", NAME,sizeof(NAME));
	        strmid(KlanInfo[ID_KLANS][kOwner],pName(playerid),0,24,24);
		 	strmid(KlanInfo[ID_KLANS][kName],NAME,0,35,35);
			strmid(KlanInfo[ID_KLANS][kRang],"None",0,24,24);
			KlanInfo[ID_KLANS][kParty] = 0;
			KlanInfo[ID_KLANS][kColor] = GetPVarInt(playerid, "KLAN_COLOR");
			SaveClan(ID_KLANS),PlayerInfo[playerid][pKlan] = ID_KLANS;
			//SavePlayer(playerid) // Меняем на свою функцию сохранения игрока.
	    }
		case KLAN_INVITE:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_INVITE,DIALOG_STYLE_INPUT,"Пригласить игрока в клан","Введите ID игрока, которого хотите пригласить:","Пригласить","Отмена");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "Игрока нет в сети!");
			if(PlayerInfo[strval(inputtext)][pKlan] == PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"Этот игрок состоит в Вашем клане!");
		    SetPVarInt(strval(inputtext), "KLANS_IDS", PlayerInfo[playerid][pKlan]);
		    SetPVarInt(strval(inputtext), "INV_PLAYERID", playerid);
			format(string,sizeof(string), "Игрок %s приглашает вступить в клан %s", pName(playerid), KlanInfo[PlayerInfo[playerid][pKlan]][kName]);
		    ShowPlayerDialog(strval(inputtext), KLAN_SELECT, DIALOG_STYLE_MSGBOX, "Приглашение в клан!", string, "Принять", "Отмена");
			SendClientMessage(playerid, -1, "Приглашение игроку успешно отправленно! Ожидайте ответа игрока.");
		}
		case KLAN_SELECT:
		{
			if(!response) return SendClientMessage(GetPVarInt(playerid, "INV_PLAYERID"), -1, "Игрок отказался вступить в Ваш клан!");
			SendClientMessage(GetPVarInt(playerid, "INV_PLAYERID"), -1, "Игрок согласился вступить в Ваш клан!");
			format(string, sizeof(string), "Новый учасник клана - %s!", pName(playerid));
			PlayerInfo[playerid][pKlan] = GetPVarInt(playerid, "KLANS_IDS");
			KlanMsg(0x006400FF,string,GetPVarInt(playerid, "KLANS_IDS"));
			KlanInfo[GetPVarInt(playerid, "KLANS_IDS")][kParty]++;
			SaveClan(GetPVarInt(playerid, "KLANS_IDS"));
			//SavePlayer(playerid) // Ваша функция сохранения.
		}
		case KLAN_UNINVITE:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_UNINVITE,DIALOG_STYLE_INPUT,"Выгнать из клана","Введите ID игрока, которого хотите выгнать:","Выгнать","Отмена");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "Игрока нет в сети!");
		    if(PlayerInfo[strval(inputtext)][pKlan] != PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"Этот игрок не состоит в Вашем клане!");
		    format(string, sizeof(string), "%s больше не состоит в Вашем клане!", pName(playerid));
		    KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
			SendClientMessage(strval(inputtext),-1, "Вас выгнали из клана!");
			PlayerInfo[strval(inputtext)][pKlan] = 0;
			//SavePlayer(playerid) // Ваша функция сохранения.
			KlanInfo[PlayerInfo[playerid][pKlan]][kParty]--;
			SaveClan(PlayerInfo[playerid][pKlan]);
		}
		case KLAN_ZAM:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_ZAM,DIALOG_STYLE_INPUT,"Заместитель","Введите ID игрока, которого хотите назначить заместителем:","Готово","Отмена");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "Игрока нет в сети!");
		    if(PlayerInfo[strval(inputtext)][pKlan] != PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"Этот игрок не состоит в Вашем клане!");
		    if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]],"None",true))
		    {
			    format(string, sizeof(string), "%s назначан заместителем!", pName(playerid));
			    KlanMsg(0x006400FF,string,PlayerInfo[playerid][pKlan]);
				SendClientMessage(strval(inputtext),-1, "Вас назначали заместителем!");
	            strmid(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],pName(strval(inputtext)),0,24,24);
				SaveClan(PlayerInfo[playerid][pKlan]);
			}
		}
		case KLAN_UNZAM:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_ZAM,DIALOG_STYLE_INPUT,"Заместитель","Введите ID игрока, которого хотите назначить заместителем:","Готово","Отмена");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "Игрока нет в сети!");
		    if(PlayerInfo[strval(inputtext)][pKlan] != PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"Этот игрок не состоит в Вашем клане!");
		    format(string, sizeof(string), "%s снят с должности заместителя!", pName(playerid));
		    KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
  			strmid(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],"None",0,24,24);
			SaveClan(PlayerInfo[playerid][pKlan]);
		}
		case KLAN_COLOR2:
		{
		    if(!response) return 1;
		    switch(listitem)
		    {
		        case 0: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 0;
		        case 1: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 1;
		        case 2: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 2;
		        case 3: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 3;
		        case 4: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 4;
		        case 5: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 5;
		        case 6: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 6;
		    }
		}
		case KLAN_DELETE:
		{
		    if(!response) return 1;
		    new ID_KLANS2 = PlayerInfo[playerid][pKlan];
		    SendClientMessage(playerid, -1, "Клан успешно удален!");
	        strmid(KlanInfo[ID_KLANS2][kOwner],"None",0,24,24);
		 	strmid(KlanInfo[ID_KLANS2][kName],"None",0,35,35);
			strmid(KlanInfo[ID_KLANS2][kRang],"None",0,24,24);
			KlanInfo[ID_KLANS2][kParty] = 0;
			KlanInfo[ID_KLANS2][kColor] = 0;
			SaveClan(ID_KLANS2),PlayerInfo[playerid][pKlan] = 0;
			//SavePlayer(playerid) // Ваша функция сохранения.
		}
	}
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
stock LoadKlans()
{
    if(!fexist("Klans/ID_KLANS.ini")) return print("File ID_KLANS.ini not found!");
    new file=ini_openFile("Klans/ID_KLANS.ini");
    ini_getInteger(file,"ID",ID_KLANS);
    ini_closeFile(file);
    if(!fexist("Klans/Klans.ini"))return print("File Klans.ini not found!");
    file = ini_openFile("Klans/Klans.ini");
    new str[50];
    for(new k = 1; k <= ID_KLANS; k++)
    {
        format(str,sizeof(str),"Number %d",k);
        ini_getString(file,str,STR);
       	sscanf(STR,"p<|>s[32]s[35]s[32]ii",KlanInfo[k][kOwner],KlanInfo[k][kName],KlanInfo[k][kRang],KlanInfo[k][kParty],KlanInfo[k][kColor]);
    }
    ini_closeFile(file);
    return printf("Loaded %d Klans\n",ID_KLANS);
}
stock SaveClan(k)
{
    new file=ini_openFile("Klans/Klans.ini");
	new str[50];
	format(str,sizeof(str),"Number %d",k);
	format(STR,sizeof(STR),"%s|%s|%s|%d|%d",KlanInfo[k][kOwner],KlanInfo[k][kName],KlanInfo[k][kRang],KlanInfo[k][kParty],KlanInfo[k][kColor]);
  	ini_setString(file,str,STR);
  	ini_closeFile(file);
}
stock KlanMsg(color,const string[],id_klans)
{
	for(new i = MAX_PLAYERS; i >= 0; i--)
	{
		if(!IsPlayerConnected(i)) continue;
		if(PlayerInfo[i][pKlan] == id_klans) SendClientMessage(i, color, string);
	}
	return true;
}
stock Save_ID_KLANS()
{
    new file = ini_openFile("Klans/ID_KLANS.ini");
    ini_setInteger(file,"ID",ID_KLANS);
    return ini_closeFile(file);
}
stock pName(playerid)
{
	new Nm[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Nm,24);
	return Nm;
}
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
