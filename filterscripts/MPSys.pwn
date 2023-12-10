#include <a_samp>

//==============================================================================
//                            Настройки скрипта
//==============================================================================

#define FS11INS 1 //настройка версии сервера:
//                 //FS11INS 0 - версия 0.3z и ниже
//                 //FS11INS 1 - версия 0.3.7 и выше

#define FS22INS 2 //тип сервера:
//                //FS22INS 1 - стандартный сервер
//                //FS22INS 2 - Drift + DM сервер от [Gn_R],
//                //            или реновация RDS сервера от [Gn_R]
//                //FS22INS 3 - Drift non-DM сервер от [Gn_R]


#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //максимум игроков на сервере + 1 (если 50 игроков, то пишем 51 !!!)

//   ВНИМАНИЕ !!! после изменения настроек ОБЯЗАТЕЛЬНО откомпилировать !!!

//------------------------------------------------------------------------------

//   ВНИМАНИЕ !!! Если в моде есть удаление любого транспорта, то ПЕРЕД удалением
//   любого транспорта (в моде) необходимо добавить строки:

//		new carplay = GetPlayerVehicleID(playerid);
//		if(CallRemoteFunction("mpsysvehfunc", "d", carplay) != 0)//чтение ИД транспорта из системы МП
//		{
//			SendClientMessage(playerid, 0xFF0000FF, " Нельзя ! Это транспорт системы МП !");
//			return 1;
//		}

//   что бы исключить возможность удаления транспорта системы МП !!!

//------------------------------------------------------------------------------

//   ВНИМАНИЕ !!! Что бы отключить команды мода сервера, нужно ДО отключаемых команд
//   (в моде) добавить строки:

//		if(CallRemoteFunction("mpsysplfunc", "d", playerid) != 0)//чтение статуса участника из системы МП
//		{
//			SendClientMessage(playerid, 0xFF0000FF, " В системе МП команды не работают !");
//			return 1;
//		}

//------------------------------------------------------------------------------

//   ВНИМАНИЕ !!! Что бы отключить меню мода сервера, нужно ДО функции вывода главного
//   меню "ShowPlayerDialog" (в моде, в паблике "OnPlayerKeyStateChange") добавить строки:

//		if(CallRemoteFunction("mpsysplfunc", "d", playerid) != 0)//чтение статуса участника из системы МП
//		{
//			SendClientMessage(playerid, 0xFF0000FF, " В системе МП игровое меню не работает !");
//			return 1;
//		}

//==============================================================================

//==============================================================================

#if (FS11INS < 0)
	#undef FS11INS
	#define FS11INS 0
#endif
#if (FS11INS > 1)
	#undef FS11INS
	#define FS11INS 1
#endif
#if (FS22INS < 1)
	#undef FS22INS
	#define FS22INS 1
#endif
#if (FS22INS > 3)
	#undef FS22INS
	#define FS22INS 3
#endif

#define COLOR_GREY 0xAFAFAFFF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_BIR 0x00FFFFFF

#if (FS22INS > 1)
	forward EndPlCRTp(playerid);//отключение блокировки контроля координат (только для модов от [Gn_R])
#endif
forward OneSec();//секундный таймер
forward SendMPMessage(mpid, color, string[]);//сообщения внутри МП

new dlgcont[MAX_PLAYERS];//контроль ИД диалога
new onesectimer;//переменная таймера
new mpstate[MAX_PLAYERS];//ИД МП игрока
new mpint[MAX_PLAYERS];//ИД интерьера игрока
new mpvw[MAX_PLAYERS];//ИД виртуального мира игрока
new Float:cormp[MAX_PLAYERS][3];//координаты ТП в мире МП
new permis[MAX_PLAYERS];//разрешение ТП на МП 0- не разрешать ТП, 1- разрешать ТП
new mpcount[MAX_PLAYERS];//число участников МП
new mpcount22[MAX_PLAYERS];//максимум участников МП
new mpcarid[MAX_PLAYERS];//транспорт участника МП
new mpfreez[MAX_PLAYERS];//заморозка игрока
new retint[MAX_PLAYERS];//интерьер возврата на основную карту
new Float:corpl[MAX_PLAYERS][3];//координаты возврата на основную карту
new skinpl[MAX_PLAYERS];//скин игрока
new mapcolpl[MAX_PLAYERS];//цвет маркера игрока
new countdown[MAX_PLAYERS];//переменная обратного отсчёта
new pnotice[MAX_PLAYERS];//предупреждение игроку о ТП
new anotice[MAX_PLAYERS];//предупреждение админу о ТП
new timstop[MAX_PLAYERS];//остановка таймеров объявлений (и контроль повторного /mptp для игроков)
new mpidpara1[MAX_PLAYERS];//ИД параметров (между окнами меню)
new mpidpara2[MAX_PLAYERS];
new mpidpara3[MAX_PLAYERS][64];
new paraexit;//переменная выгрузки скрипта

//---------------- замена стандартной функции SetPlayerSkin --------------------
//-------------------- на её прототип S_SetPlayerSkin --------------------------
stock S_SetPlayerSkin(const playerid, const skinid)
{
	if(paraexit == 0)//если нету выгрузки скрипта, то:
	{
		ClearAnimations(playerid);//меняем игроку скин с задержкой
		TogglePlayerControllable(playerid, 0);//заморозить игрока
		SetTimerEx("S22_SetPlayerSkin", 2000, 0, "ii", playerid, skinid);
	}
	else//иначе:
	{
		SetPlayerSkin(playerid, skinid);
	}
	return 1;
}
forward S22_SetPlayerSkin(playerid, skinid);
public S22_SetPlayerSkin(playerid, skinid)
{
	SetPlayerSkin(playerid, skinid);
	if(mpfreez[playerid] == 0)//если игрок НЕ был заморожен, то:
	{
		TogglePlayerControllable(playerid, 1);//разморозить игрока
	}
	return 1;
}
#define SetPlayerSkin S_SetPlayerSkin
//------------------------------------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("         Filterscript MPSys             ");
	print("--------------------------------------\n");

	paraexit = 0;//переменная выгрузки скрипта
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
#if (FS22INS > 1)
		SetPVarInt(i, "CComAc10", 0);
		SetPVarInt(i, "PlCRTp", 0);
		SetPVarInt(i, "PlConRep", 0);//включаем авторемонт
#endif
		mpstate[i] = -600;//очистка ИД МП игрока
		mpint[i] = -600;//очистка ИД интерьера игрока
		mpvw[i] = -600;//очистка ИД виртуального мира игрока
		permis[i] = 0;//запретить ТП на МП
		mpcount[i] = 0;//очистка числа участников МП
		mpcount22[i] = 0;//очистка максимума участников МП
		mpcarid[i] = -600;//очистка транспорта участника МП
		mpfreez[i] = 0;//очистка заморозки игрока
		countdown[i] = -1;//очистка обратного отсчёта
		pnotice[i] = 0;//очистка предупреждения игроку
		anotice[i] = 0;//очистка предупреждения админу
		timstop[i] = 0;//очистка остановки таймеров объявлений
	}
	onesectimer = SetTimer("OneSec", 987, 1);
	return 1;
}

public OnFilterScriptExit()
{
	paraexit = 1;//переменная выгрузки скрипта
	new para1 = 0;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(mpstate[i] != -600)
			{
				para1 = 1;
#if (FS22INS == 1)
	 			SetPlayerInterior(i, retint[i]);
				SetPlayerVirtualWorld(i, 0);
				SetPlayerPos(i, corpl[i][0], corpl[i][1], corpl[i][2]);
				SetCameraBehindPlayer(i);
#endif
#if (FS22INS > 1)
				if(GetPVarInt(i, "SecPris") == 0)//если игрок НЕ сидит в тюрьме, то:
				{
					SetPVarInt(i, "PlCRTp", 1);
					SetTimerEx("EndPlCRTp", 3000, 0, "i", i);
	 				SetPlayerInterior(i, retint[i]);
					SetPlayerVirtualWorld(i, 0);
					SetPlayerPos(i, corpl[i][0], corpl[i][1], corpl[i][2]);
					SetCameraBehindPlayer(i);
				}
#endif
				if(mpfreez[i] == 1)//если игрок заморожен, то:
				{
					TogglePlayerControllable(i, 1);//разморозить игрока
				}
				if(mpcarid[i] != -600)//если есть транспорт у участника МП, то:
				{
					DestroyVehicle(mpcarid[i]);//удаляем транспорт
				}
   				for(new j = 0; j < MAX_PLAYERS; j++)//возвращаем игроку цвета маркера
				{
					SetPlayerMarkerForPlayer(j, i, mapcolpl[i]);
				}
				SetPlayerSkin(i, skinpl[i]);//возвращаем игроку скин
			}
#if (FS22INS > 1)
			DeletePVar(i, "CComAc10");
			DeletePVar(i, "PlCRTp");
			DeletePVar(i, "PlConRep");//удаляем глобальную переменную авторемонта
#endif
			mpstate[i] = -600;//очистка ИД МП игрока
			mpint[i] = -600;//очистка ИД интерьера игрока
			mpvw[i] = -600;//очистка ИД виртуального мира игрока
			permis[i] = 0;//запретить ТП на МП
			mpcount[i] = 0;//очистка числа участников МП
			mpcount22[i] = 0;//очистка максимума участников МП
			mpcarid[i] = -600;//очистка транспорта участника МП
			mpfreez[i] = 0;//очистка заморозки игрока
			countdown[i] = -1;//очистка обратного отсчёта
			pnotice[i] = 0;//очистка предупреждения игроку
			anotice[i] = 0;//очистка предупреждения админу
			timstop[i] = 0;//очистка остановки таймеров объявлений
		}
	}
	if(para1 == 1)
	{
		SendClientMessageToAll(COLOR_RED, " Все мероприятия были завершены ! (выгрузка системы мероприятий) !");
		print("[MPSys] Все мероприятия были завершены ! (выгрузка скрипта) !");
	}
	KillTimer(onesectimer);
	paraexit = 0;//переменная выгрузки скрипта
	return 1;
}

public OnPlayerConnect(playerid)
{
#if (FS22INS > 1)
	SetPVarInt(playerid, "CComAc10", 0);
	SetPVarInt(playerid, "PlCRTp", 0);
	SetPVarInt(playerid, "PlConRep", 0);//включаем авторемонт
#endif
	mpstate[playerid] = -600;//очистка ИД МП игрока
	mpint[playerid] = -600;//очистка ИД интерьера игрока
	mpvw[playerid] = -600;//очистка ИД виртуального мира игрока
	permis[playerid] = 0;//запретить ТП на МП
	mpcount[playerid] = 0;//очистка числа участников МП
	mpcount22[playerid] = 0;//очистка максимума участников МП
	mpcarid[playerid] = -600;//очистка транспорта участника МП
	mpfreez[playerid] = 0;//очистка заморозки игрока
	countdown[playerid] = -1;//очистка обратного отсчёта
	pnotice[playerid] = 0;//очистка предупреждения игроку
	anotice[playerid] = 0;//очистка предупреждения админу
	timstop[playerid] = 0;//очистка остановки таймеров объявлений
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
#if (FS22INS > 1)
	DeletePVar(playerid, "CComAc10");
	DeletePVar(playerid, "PlCRTp");
	DeletePVar(playerid, "PlConRep");//удаляем глобальную переменную авторемонта
#endif
	if(mpstate[playerid] == playerid)
	{
		if(permis[playerid] == 1)//если разрешено ТП на МП, то:
		{
			permis[playerid] = 0;//запретить ТП на МП
			timstop[playerid] = 1;//активировать остановку таймеров объявлений
		}
		else
		{
			timstop[playerid] = 0;//очистка остановки таймеров объявлений
		}
		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), " Администратор %s [%d] завершил мероприятие ! (вышел с сервера) !", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		printf("[MPSys] Администратор %s [%d] завершил мероприятие (ID: %d VW: %d) (вышел с сервера)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//доработка для использования Русских ников
//		printf("[MPSys] Администратор %s [%d] завершил мероприятие (ID: %d VW: %d) (вышел с сервера)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
	}
	if(mpstate[playerid] != -600 && mpstate[playerid] != playerid)
	{
		if(mpcarid[playerid] != -600)//если есть транспорт у участника МП, то:
		{
			DestroyVehicle(mpcarid[playerid]);//удаляем транспорт
		}
		mpcount[mpstate[playerid]]--;//число участников МП -1
		timstop[playerid] = 0;//отключить контроль повторного /mptp
		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), " Игрок %s [%d] вышел из мероприятия. (вышел с сервера) !", sendername, playerid);
		SendMPMessage(mpstate[playerid], COLOR_RED, string);
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		printf("[MPSys] Игрок %s [%d] вышел из мероприятия (ID: %d VW: %d) (вышел с сервера)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//доработка для использования Русских ников
//		printf("[MPSys] Игрок %s [%d] вышел из мероприятия (ID: %d VW: %d) (вышел с сервера)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
	}
	mpstate[playerid] = -600;//очистка ИД МП игрока
	mpint[playerid] = -600;//очистка ИД интерьера игрока
	mpvw[playerid] = -600;//очистка ИД виртуального мира игрока
	permis[playerid] = 0;//запретить ТП на МП
	mpcount[playerid] = 0;//очистка числа участников МП
	mpcount22[playerid] = 0;//очистка максимума участников МП
	mpcarid[playerid] = -600;//очистка транспорта участника МП
	mpfreez[playerid] = 0;//очистка заморозки игрока
	countdown[playerid] = -1;//очистка обратного отсчёта
	pnotice[playerid] = 0;//очистка предупреждения игроку
	anotice[playerid] = 0;//очистка предупреждения админу
	return 1;
}

public SendMPMessage(mpid, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(mpstate[i] == mpid)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
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
#if (FS22INS > 1)
	SetPVarInt(playerid, "CComAc10", GetPVarInt(playerid, "CComAc10") + 1);
#endif
	new idx;
	idx = 0;
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	cmd = strtok(cmdtext, idx);
	new playvw;
	playvw = GetPlayerVirtualWorld(playerid);
	if(strcmp(cmd, "/mphelp", true) == 0)
	{
		SendClientMessage(playerid, COLOR_BIR, " -------------------------------- Команды системы МП --------------------------------");
		SendClientMessage(playerid, COLOR_BIR, "         Для участников:");
		SendClientMessage(playerid, COLOR_BIR, " /mphelp - помощь по командам системы МП   /mpc [текст] - чат МП");
		SendClientMessage(playerid, COLOR_BIR, " /mptp [ИД МП] - подключиться к МП   /mpexit - выйти из МП");
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			SendClientMessage(playerid, COLOR_BIR, "         Для организаторов:");
			SendClientMessage(playerid, COLOR_BIR, " /mpcreate [мир МП] [максимум участников] - организовать МП");
			SendClientMessage(playerid, COLOR_BIR, " /mpsend - дать повторные объявления о МП");
			SendClientMessage(playerid, COLOR_BIR, " /mpmenu - открыть меню МП");
			SendClientMessage(playerid, COLOR_BIR, " /mpkick [ИД игрока] - удалить игрока из МП");
			SendClientMessage(playerid, COLOR_BIR, " /mpret - вернуться на МП   /mpend - завершить МП");
		}
		SendClientMessage(playerid,COLOR_BIR," ---------------------------------------------------------------------------------------------------");
		return 1;
	}
	if(strcmp(cmd, "/mpc", true) == 0)
	{
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "SecMute") > 0)
		{
			SendClientMessage(playerid, COLOR_RED, " Вы не можете говорить, Вас заткнули !");
			return 1;
		}
#endif
		if(mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " Команда работает только у организаторов или участников МП !");
			return 1;
		}
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
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /mpc [текст]");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		if(mpstate[playerid] == playerid)
		{
			printf(" <MPC> Организатор %s [%d]: %s", aa333, playerid, result);//доработка для использования Русских ников
//			printf(" <MPC> Организатор %s [%d]: %s", sendername, playerid, result);
			format(string, sizeof(string), " <MPC> Организатор %s [%d]: {FFFFFF}%s", sendername, playerid, result);
		}
		else
		{
			printf(" <MPC> Участник %s [%d]: %s", aa333, playerid, result);//доработка для использования Русских ников
//			printf(" <MPC> Участник %s [%d]: %s", sendername, playerid, result);
			format(string, sizeof(string), " <MPC> Участник %s [%d]: {FFFFFF}%s", sendername, playerid, result);
		}
		SendMPMessage(mpstate[playerid], COLOR_YELLOW, string);
		return 1;
	}
	if(strcmp(cmd, "/mptp", true) == 0)
	{
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "SecPris") > 0)
		{
			SendClientMessage(playerid, COLOR_RED, " В тюрьме команда не работает !");
			return 1;
		}
#endif
//		if(GetPlayerInterior(playerid) != 0 || playvw != 0 || mpstate[playerid] == playerid)
		if(GetPlayerInterior(playerid) != 0 || playvw != 0 || mpstate[playerid] == playerid || mpstate[playerid] != -600)
		{
//			SendClientMessage(playerid, COLOR_RED, " Команда работает только на основной карте ! И только, если Вы участник МП !");
			SendClientMessage(playerid, COLOR_RED, " Команда работает только на основной карте ! И только, если Вы НЕ участник МП !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /mptp [ИД МП]");
			return 1;
		}
		new para1;
		para1 = strval(tmp);
		if(para1 < 0 || para1 > (MAX_PLAYERS - 2))
		{
			SendClientMessage(playerid, COLOR_RED, " Такого [ИД МП] на сервере не создано !");
			return 1;
		}
		if(mpstate[para1] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " Такого [ИД МП] на сервере не создано !");
			return 1;
		}
		if(mpstate[playerid] != -600 && mpstate[playerid] != para1)
		{
			SendClientMessage(playerid, COLOR_RED, " Этот [ИД МП] не Ваш ! Вернитесь на своё МП !");
			return 1;
		}
		if(mpstate[para1] == para1 && permis[para1] == 0 && mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " Такой [ИД МП] на сервере создан, но МП было начато без Вас !");
			return 1;
		}
		if(mpstate[para1] == para1 && mpcount[para1] >= mpcount22[para1] && mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " Такой [ИД МП] на сервере создан, но уже набрано необходимое");
			SendClientMessage(playerid, COLOR_RED, " количество участников МП !");
			return 1;
		}
		if(timstop[playerid] == 0)//если отключен контроль повторного /mptp , то:
		{
			mpstate[playerid] = para1;//сохранение ИД МП игрока
			mpvw[playerid] = mpvw[para1];//сохранение ИД виртуального мира игрока
			skinpl[playerid] = GetPlayerSkin(playerid);//сохранение скина игрока
			mapcolpl[playerid] = GetPlayerColor(playerid);//сохранение цвета маркера игрока
			mpcount[para1]++;//число участников МП +1
			SetPVarInt(playerid, "PlConRep", 0);//включаем авторемонт
		}
		retint[playerid] = 0;//сохранение интерьера возврата на основную карту
		GetPlayerPos(playerid, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//сохранение координат возврата на основную карту
		if(timstop[playerid] == 0)//если отключен контроль повторного /mptp , то:
		{
			new Float:cx, Float:cy, Float:cz;
			GetPlayerPos(para1, cx, cy, cz);//узнать координаты админа в мире МП
			cormp[playerid][0] = cx+3;//запомнить координаты ТП в мире МП
			cormp[playerid][1] = cy+3;
			cormp[playerid][2] = cz+1;
		}
		timstop[playerid] = 0;//отключить контроль повторного /mptp
		TPmp(playerid, mpint[para1], mpvw[playerid]+2000, cormp[playerid][0], cormp[playerid][1], cormp[playerid][2]);//ТП игрока в мир МП
		pnotice[playerid] = 0;//очистка предупреждения игроку
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(mpstate[playerid], giveplayer, sizeof(sendername));
		format(string, sizeof(string), " Вы телепортировались на мероприятие, которое организовал Администратор %s", giveplayer);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		SendClientMessage(playerid, COLOR_YELLOW, " Для выхода из мероприятия - введите {00FF00}/mpexit");
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		new aa444[64];//доработка для использования Русских ников
		format(aa444, sizeof(aa444), "%s", giveplayer);//доработка для использования Русских ников
		printf("[MPSys] Игрок %s [%d] телепортировался на мероприятие ( Администратор %s )", aa333, playerid, aa444);//доработка для использования Русских ников
//		printf("[MPSys] Игрок %s [%d] телепортировался на мероприятие ( Администратор %s )", sendername, playerid, giveplayer);
		return 1;
	}
	if(strcmp(cmd, "/mpexit", true) == 0)
	{
		if(playvw != mpvw[playerid]+2000 || mpstate[playerid] == playerid || mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " Команда работает только на МП ! И только у участников МП !");
			return 1;
		}
		new para3 = mpstate[playerid];
		mpstate[playerid] = -600;//очистка ИД МП игрока
		mpvw[playerid] = -600;//очистка ИД виртуального мира игрока
		if(countdown[playerid] != -1) { countdown[playerid] = -1; }//остановить обратный отсчёт
		mpcount[para3]--;//число участников МП -1
		SetPVarInt(playerid, "PlConRep", 0);//включаем авторемонт
		timstop[playerid] = 0;//отключить контроль повторного /mptp
		if(mpcarid[playerid] != -600)//если есть транспорт у участника МП, то:
		{
			DestroyVehicle(mpcarid[playerid]);//удаляем транспорт
			mpcarid[playerid] = -600;//очистка транспорта участника МП
		}
		if(mpfreez[playerid] == 1)//если игрок заморожен, то:
		{
			TogglePlayerControllable(playerid, 1);//разморозить игрока
			mpfreez[playerid] = 0;//очистка заморозки игрока
		}
		SetPlayerVirtualWorld(playerid, 0);//задаём игроку 0-й виртуальный мир (что бы блокировать сообщение внутри МП)
		TPmp(playerid, retint[playerid], 0, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//ТП на основную карту
		SetPlayerSkin(playerid, skinpl[playerid]);//возвращаем игроку скин
   		for(new i = 0; i < MAX_PLAYERS; i++)//возвращаем игроку цвета маркера
		{
			SetPlayerMarkerForPlayer(i, playerid, mapcolpl[playerid]);
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(para3, giveplayer, sizeof(sendername));
		format(string, sizeof(string), " Игрок %s [%d] вышел из мероприятия.", sendername, playerid);
		SendMPMessage(mpstate[playerid], COLOR_RED, string);
		SendClientMessage(playerid, COLOR_RED, " Вы вышли из мероприятия.");
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		new aa444[64];//доработка для использования Русских ников
		format(aa444, sizeof(aa444), "%s", giveplayer);//доработка для использования Русских ников
		printf("[MPSys] Игрок %s [%d] вышел из мероприятия ( Администратор %s )", aa333, playerid, aa444);//доработка для использования Русских ников
//		printf("[MPSys] Игрок %s [%d] вышел из мероприятия ( Администратор %s )", sendername, playerid, giveplayer);
		return 1;
	}
	if(strcmp(cmd, "/mpcreate", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
		{
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			if(GetPVarInt(playerid, "SecPris") > 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В тюрьме команда не работает !");
				return 1;
			}
#endif
			if(playvw != 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда работает только на основной карте !");
				return 1;
			}
			if(mpstate[playerid] == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Вы уже проводите МП ! И не можете организовать другое МП !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /mpcreate [мир МП(0-989)] [максимум участников(1-40)]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 989)
			{
				SendClientMessage(playerid, COLOR_RED, " Мир МП от 0 до 989 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /mpcreate [мир МП(0-989)] [максимум участников(1-40)] !");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 < 1 || para2 > 40)
			{
				SendClientMessage(playerid, COLOR_RED, " Максимум участников от 1 до 40 !");
				return 1;
			}
			mpstate[playerid] = playerid;//сохранение ИД МП админа
			mpint[playerid] = GetPlayerInterior(playerid);//сохранение ИД интерьера админа
			mpvw[playerid] = para1;//сохранение ИД виртуального мира админа
			skinpl[playerid] = GetPlayerSkin(playerid);//сохранение скина игрока
			mapcolpl[playerid] = GetPlayerColor(playerid);//сохранение цвета маркера игрока
			retint[playerid] = mpint[playerid];//сохранение интерьера возврата на основную карту
			GetPlayerPos(playerid, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//сохранение координат возврата на основную карту
			cormp[playerid][0] = corpl[playerid][0];//запомнить координаты ТП в мире МП
			cormp[playerid][1] = corpl[playerid][1];
			cormp[playerid][2] = corpl[playerid][2];
			TPmp(playerid, mpint[playerid], mpvw[playerid]+2000, cormp[playerid][0], cormp[playerid][1], cormp[playerid][2]);//ТП админа в мир МП
			permis[playerid] = 1;//разрешить ТП на МП
			mpcount[playerid] = 0;//очистка числа участников МП
			mpcount22[playerid] = para2;//максимум участников МП
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " Администратор %s [%d] организовал мероприятие, до начала осталось 60 секунд,", sendername, playerid);
			SendClientMessageToAll(COLOR_GREEN, string);
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			printf("[MPSys] Администратор %s [%d] организовал мероприятие (ID: %d VW: %d)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//доработка для использования Русских ников
//			printf("[MPSys] Администратор %s [%d] организовал мероприятие (ID: %d VW: %d)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
			format(string, sizeof(string), " что бы телепортироваться на мероприятие - введите {FFFF00}/mptp %d", mpstate[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
			SetTimerEx("MPStart1", 20000, 0, "d", playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpsend", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда работает только в организованном Вами МП !");
				return 1;
			}
			if(permis[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
				return 1;
			}
			if(mpcount[playerid] >= mpcount22[playerid])
			{
				SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Уже набрано необходимое количество");
				SendClientMessage(playerid, COLOR_RED, " участников МП !");
				return 1;
			}
			permis[playerid] = 1;//разрешить ТП на МП
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " Администратор %s [%d] организовал мероприятие, до начала осталось 60 секунд,", sendername, playerid);
			SendClientMessageToAll(COLOR_GREEN, string);
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			printf("[MPSys] Администратор %s [%d] дал повторные объявления о мероприятии (ID: %d VW: %d)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//доработка для использования Русских ников
//			printf("[MPSys] Администратор %s [%d] дал повторные объявления о мероприятии (ID: %d VW: %d)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
			format(string, sizeof(string), " что бы телепортироваться на мероприятие - введите {FFFF00}/mptp %d", mpstate[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
			SetTimerEx("MPStart1", 20000, 0, "d", playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpmenu", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда работает только в организованном Вами МП !");
				return 1;
			}
			if(permis[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
				return 1;
			}
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать предметы себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 700;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpkick", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда работает только в организованном Вами МП !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /mpkick [ИД игрока]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не можете удалить из МП самого себя !");
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ИД игрока] на сервере нет !");
				return 1;
			}
			if(mpstate[para1] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Такой [ИД игрока] не участвует в Вашем МП !");
				return 1;
			}
			mpstate[para1] = -600;//очистка ИД МП игрока
			mpvw[para1] = -600;//очистка ИД виртуального мира игрока
			if(countdown[para1] != -1) { countdown[para1] = -1; }//остановить обратный отсчёт
			mpcount[mpstate[playerid]]--;//число участников МП -1
			SetPVarInt(para1, "PlConRep", 0);//включаем авторемонт
			timstop[para1] = 0;//отключить контроль повторного /mptp
			if(mpcarid[para1] != -600)//если есть транспорт у участника МП, то:
			{
				DestroyVehicle(mpcarid[para1]);//удаляем транспорт
				mpcarid[para1] = -600;//очистка транспорта участника МП
			}
			if(mpfreez[para1] == 1)//если игрок заморожен, то:
			{
				TogglePlayerControllable(para1, 1);//разморозить игрока
				mpfreez[para1] = 0;//очистка заморозки игрока
			}
			if(GetPlayerVirtualWorld(para1) == mpvw[playerid]+2000)//если игрок находится в мире МП, то:
			{
				SetPlayerVirtualWorld(para1, 0);//задаём игроку 0-й виртуальный мир (что бы блокировать сообщение внутри МП)
				TPmp(para1, retint[para1], 0, corpl[para1][0], corpl[para1][1], corpl[para1][2]);//ТП на основную карту
			}
			SetPlayerSkin(para1, skinpl[para1]);//возвращаем игроку скин
   			for(new i = 0; i < MAX_PLAYERS; i++)//возвращаем игроку цвета маркера
			{
				SetPlayerMarkerForPlayer(i, para1, mapcolpl[para1]);
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(para1, giveplayer, sizeof(sendername));
			format(string, sizeof(string), " Администратор %s [%d] удалил игрока %s [%d] из мероприятия !", sendername, playerid, giveplayer, para1);
			SendMPMessage(mpstate[playerid], COLOR_RED, string);
			SendClientMessage(para1, COLOR_RED, string);
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			new aa444[64];//доработка для использования Русских ников
			format(aa444, sizeof(aa444), "%s", giveplayer);//доработка для использования Русских ников
			printf("[MPSys] Администратор %s [%d] удалил игрока %s [%d] из мероприятия (ID: %d VW: %d)", aa333, playerid, aa444, para1, mpstate[playerid], mpvw[playerid]);//доработка для использования Русских ников
//			printf("[MPSys] Администратор %s [%d] удалил игрока %s [%d] из мероприятия (ID: %d VW: %d)", sendername, playerid, giveplayer, para1, mpstate[playerid], mpvw[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpret", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
		{
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			if(GetPVarInt(playerid, "SecPris") > 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В тюрьме команда не работает !");
				return 1;
			}
#endif
			if(playvw != 0 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда работает только на основной карте !");
				SendClientMessage(playerid, COLOR_RED, " И только, если Вы организатор МП !");
				return 1;
			}
			retint[playerid] = GetPlayerInterior(playerid);//сохранение интерьера возврата на основную карту
			GetPlayerPos(playerid, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//сохранение координат возврата на основную карту
			TPmp(playerid, mpint[playerid], mpvw[playerid]+2000, cormp[playerid][0], cormp[playerid][1], cormp[playerid][2]);//ТП Админа в мир МП
			anotice[playerid] = 0;//очистка предупреждения админу
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " Администратор %s [%d] вернулся на мероприятие.", sendername, playerid);
			SendMPMessage(mpstate[playerid], COLOR_YELLOW, string);
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			printf("[MPSys] Администратор %s [%d] вернулся на мероприятие (ID: %d VW: %d)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//доработка для использования Русских ников
//			printf("[MPSys] Администратор %s [%d] вернулся на мероприятие (ID: %d VW: %d)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpend", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Команда работает только в организованном Вами МП !");
				return 1;
			}
			if(permis[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
				return 1;
			}
			new para3 = mpstate[playerid];
			new para4 = mpvw[playerid];
			mpstate[playerid] = -600;//очистка ИД МП админа
			mpvw[playerid] = -600;//очистка ИД виртуального мира админа
			if(countdown[playerid] != -1) { countdown[playerid] = -1; }//остановить обратный отсчёт
			mpcount[playerid] = 0;//очистка числа участников МП
			mpcount22[playerid] = 0;//очистка максимума участников МП
			TPmp(playerid, retint[playerid], 0, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//ТП на основную карту
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " Администратор %s [%d] завершил мероприятие !", sendername, playerid);
			SendClientMessageToAll(COLOR_RED, string);
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			printf("[MPSys] Администратор %s [%d] завершил мероприятие (ID: %d VW: %d)", aa333, playerid, para3, para4);//доработка для использования Русских ников
//			printf("[MPSys] Администратор %s [%d] завершил мероприятие (ID: %d VW: %d)", sendername, playerid, para3, para4);
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
	if(dialogid == 700)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
/*
			if(listitem == 0)//Дать предмет
			{
				ShowPlayerDialog(playerid, 701, 2, "Дать предмет.", "Кастет\nКлюшка для гольфа\nРезиновая дубинка\nНож\
				\nБейсбольная бита\nЛопата\nКий\nКатана\nБензопила\nБукет цветов\nТрость\nБаллончик с краской\nОгнетушитель\
				\nФотоаппарат\nПарашют", "ОК", "Отмена");
				dlgcont[playerid] = 701;
				return 1;
			}
*/
#if (FS22INS < 3)
			if(listitem == 0)//Дать предмет или оружие
			{
				ShowPlayerDialog(playerid, 702, 2, "Дать предмет или оружие.", "Бейсбольная бита\nЛопата\nКатана\nБензопила\
				\nГраната\nСлезоточивый газ\nКоктейль Молотова\nПистолет\nПистолет с глушителем\nДезерт иигл\nДробовик\nОбрез\
				\nSPAZ 12\nУзи\nMP5\nАК-47\nМ4\nTes9\nВинтовка\nСнайперская винтовка\nВзрывчатка", "Выбор", "Отмена");
				dlgcont[playerid] = 702;
				return 1;
			}
			if(listitem == 1)//Дать оружие себе)))
			{
				GivePlayerWeapon(playerid, 38, 1000);//даём набор оружия
				GivePlayerWeapon(playerid, 28, 500);
				GivePlayerWeapon(playerid, 26, 500);
				GivePlayerWeapon(playerid, 24, 500);
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SendClientMessage(playerid, COLOR_GREEN, " Вы выдали себе оружие.");
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] выдал себе оружие.", aa333, playerid);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] выдал себе оружие.", sendername, playerid);
				return 1;
			}
#endif
#if (FS22INS == 3)
			if(listitem == 0)//Дать предмет
			{
				ShowPlayerDialog(playerid, 702, 2, "Дать предмет.", "Фотоаппарат\nБукет цветов\nПарашют", "Выбор", "Отмена");
				dlgcont[playerid] = 702;
				return 1;
			}
			if(listitem == 1)//Дать предметы себе)))
			{
				GivePlayerWeapon(playerid, 43, 1000);//даём набор предметов
				GivePlayerWeapon(playerid, 14, 1000);
				GivePlayerWeapon(playerid, 46, 1000);
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SendClientMessage(playerid, COLOR_GREEN, " Вы выдали себе предметы.");
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] выдал себе предметы.", aa333, playerid);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] выдал себе предметы.", sendername, playerid);
				return 1;
			}
#endif
			if(listitem == 2)//Пополнить жизнь и броню
			{
				new para1 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
						GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
							SetPlayerHealth(i,100);//пополняем жизнь и броню
							SetPlayerArmour(i,100);
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] пополнил участникам мероприятия жизнь и броню.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] пополнил участникам мероприятия жизнь и броню.", aa333, playerid);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] пополнил участникам мероприятия жизнь и броню.", sendername, playerid);
				}
				return 1;
			}
			if(listitem == 3)//Пополнить жизнь и броню себе)))
			{
				SetPlayerHealth(playerid,255);//пополняем жизнь и броню
				SetPlayerArmour(playerid,255);
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SendClientMessage(playerid, COLOR_GREEN, " Вы пополнили себе жизнь и броню.");
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] пополнил себе жизнь и броню.", aa333, playerid);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] пополнил себе жизнь и броню.", sendername, playerid);
				return 1;
			}
			if(listitem == 4)//Отобрать предметы и оружие (у всех)
			{
				new para1 = 0;
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
							ResetPlayerWeapons(i);//отбираем оружие и предметы
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Нет ни одного участника мероприятия !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] отобрал у участников мероприятия предметы и оружие.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] отобрал у участников мероприятия предметы и оружие.", aa333, playerid);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] отобрал у участников мероприятия предметы и оружие.", sendername, playerid);
				}
				return 1;
			}
			if(listitem == 5)//Дать транспорт
			{
#if (FS22INS < 3)
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Введите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Внимание !!!\n\nМодели транспорта: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ЗАПРЕЩЕНЫ !!!\n\nВведите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
				dlgcont[playerid] = 704;
				return 1;
			}
			if(listitem == 6)//Отобрать транспорт (у всех)
			{
				new para1 = 0;
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpcarid[i] != -600)//если есть транспорт у участника МП, то:
							{
								para1 = 1;
								DestroyVehicle(mpcarid[i]);//удаляем транспорт
								mpcarid[i] = -600;
							}
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Ни у одного участника мероприятия нет транспорта !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] отобрал у участников мероприятия транспорт.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] отобрал у участников мероприятия транспорт.", aa333, playerid);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] отобрал у участников мероприятия транспорт.", sendername, playerid);
				}
				return 1;
			}
#if (FS22INS > 1)
			if(listitem == 7)//Отключить авторемонт (всем)
			{
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpcarid[i] != -600)//если есть транспорт у участника МП, то:
							{
								SetPVarInt(i, "PlConRep", 1);//отключаем авторемонт
							}
						}
					}
				}
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " Администратор %s [%d] отключил участникам мероприятия авторемонт.", sendername, playerid);
				SendMPMessage(mpstate[playerid], COLOR_RED, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] отключил участникам мероприятия авторемонт.", aa333, playerid);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] отключил участникам мероприятия авторемонт.", sendername, playerid);
				return 1;
			}
			if(listitem == 8)//Включить авторемонт (всем)
			{
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpcarid[i] != -600)//если есть транспорт у участника МП, то:
							{
								SetPVarInt(i, "PlConRep", 0);//включаем авторемонт
							}
						}
					}
				}
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " Администратор %s [%d] включил участникам мероприятия авторемонт.", sendername, playerid);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] включил участникам мероприятия авторемонт.", aa333, playerid);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] включил участникам мероприятия авторемонт.", sendername, playerid);
				return 1;
			}
#endif
#if (FS22INS == 1)
			if(listitem == 7)//Запустить обратный отсчёт
#endif
#if (FS22INS > 1)
			if(listitem == 9)//Запустить обратный отсчёт
#endif
			{
				ShowPlayerDialog(playerid, 707, 1, "Запустить обратный отсчёт.", "Введите число секунд (от 2 до 12):", "ОК", "Отмена");
				dlgcont[playerid] = 707;
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 8)//Сменить скин
#endif
#if (FS22INS > 1)
			if(listitem == 10)//Сменить скин
#endif
			{
#if (FS11INS == 0)
				ShowPlayerDialog(playerid, 708, 1, "Сменить скин.", "Введите ИД скина (от 0 до 299):", "ОК", "Отмена");
#endif
#if (FS11INS == 1)
				ShowPlayerDialog(playerid, 708, 1, "Сменить скин.", "Введите ИД скина (от 0 до 311):", "ОК", "Отмена");
#endif
				dlgcont[playerid] = 708;
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 9)//Сменить цвет маркера
#endif
#if (FS22INS > 1)
			if(listitem == 11)//Сменить цвет маркера
#endif
			{
				ShowPlayerDialog(playerid, 709, 2, "Сменить цвет маркера.", "{FF0000}Красный\n{BF3F00}Коричневый\
				\n{FF7F00}Оранжевый\n{FFFF00}Жёлтый\n{00FF00}Зелёный\n{00FFFF}Бирюзовый\n{00BFFF}Голубой\n{0000FF}Синий\
				\n{7F00FF}Фиолетовый\n{FF00FF}Сиреневый\n{7F7F7F}Серый", "ОК", "Отмена");
				dlgcont[playerid] = 709;
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 10)//Заморозить
#endif
#if (FS22INS > 1)
			if(listitem == 12)//Заморозить
#endif
			{
				new para1 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
						GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
							TogglePlayerControllable(i, 0);//заморозить игрока
							mpfreez[i] = 1;
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] заморозил участников мероприятия.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] заморозил участников мероприятия.", aa333, playerid);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] заморозил участников мероприятия.", sendername, playerid);
				}
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 11)//Разморозить (всех)
#endif
#if (FS22INS > 1)
			if(listitem == 13)//Разморозить (всех)
#endif
			{
				new para1 = 0;
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpfreez[i] == 1)//если участник МП был заморожен, то:
							{
								para1 = 1;
								TogglePlayerControllable(i, 1);//разморозить игрока
								mpfreez[i] = 0;
							}
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Ни один участник мероприятия не был заморожен !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] разморозил участников мероприятия.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] разморозил участников мероприятия.", aa333, playerid);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] разморозил участников мероприятия.", sendername, playerid);
				}
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 12)//ТП к себе (с любого расстояния)
#endif
#if (FS22INS > 1)
			if(listitem == 14)//ТП к себе (с любого расстояния)
#endif
			{
				new para1 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
#if (FS22INS == 1)
							SetPlayerInterior(i, playint);
							SetPlayerVirtualWorld(i, playvw);
							SetPlayerPos(i, X+3, Y+3, Z+1);
							SetCameraBehindPlayer(i);
#endif
#if (FS22INS > 1)
							if(GetPVarInt(i, "SecPris") == 0)//если игрок НЕ сидит в тюрьме, то:
							{
								SetPVarInt(i, "PlCRTp", 1);
								SetTimerEx("EndPlCRTp", 3000, 0, "i", i);
								SetPlayerInterior(i, playint);
								SetPlayerVirtualWorld(i, playvw);
								SetPlayerPos(i, X+3, Y+3, Z+1);
								SetCameraBehindPlayer(i);
							}
#endif
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Нет ни одного участника мероприятия !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] телепортировал к себе всех участников мероприятия.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] телепортировал к себе всех участников мероприятия.", aa333, playerid);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] телепортировал к себе всех участников мероприятия.", sendername, playerid);
				}
			}
		}
		return 1;
	}
/*
	if(dialogid == 701)//Дать предмет
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			new para1;
			if(listitem == 0) { para1 = 1; }
			if(listitem == 1) { para1 = 2; }
			if(listitem == 2) { para1 = 3; }
			if(listitem == 3) { para1 = 4; }
			if(listitem == 4) { para1 = 5; }
			if(listitem == 5) { para1 = 6; }
			if(listitem == 6) { para1 = 7; }
			if(listitem == 7) { para1 = 8; }
			if(listitem == 8) { para1 = 9; }
			if(listitem == 9) { para1 = 14; }
			if(listitem == 10) { para1 = 15; }
			if(listitem == 11) { para1 = 41; }
			if(listitem == 12) { para1 = 42; }
			if(listitem == 13) { para1 = 43; }
			if(listitem == 14) { para1 = 46; }
			new para2[256];
			switch(para1)
			{
				case 1: format(para2, sizeof(para2), "Кастет");
				case 2: format(para2, sizeof(para2), "Клюшку для гольфа");
				case 3: format(para2, sizeof(para2), "Резиновую дубинку");
				case 4: format(para2, sizeof(para2), "Нож");
				case 5: format(para2, sizeof(para2), "Бейсбольную биту");
				case 6: format(para2, sizeof(para2), "Лопату");
				case 7: format(para2, sizeof(para2), "Кий");
				case 8: format(para2, sizeof(para2), "Катану");
				case 9: format(para2, sizeof(para2), "Бензопилу");
				case 14: format(para2, sizeof(para2), "Букет цветов");
				case 15: format(para2, sizeof(para2), "Трость");
				case 41: format(para2, sizeof(para2), "Баллончик с краской");
				case 42: format(para2, sizeof(para2), "Огнетушитель");
				case 43: format(para2, sizeof(para2), "Фотоаппарат");
				case 46: format(para2, sizeof(para2), "Парашют");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
						GivePlayerWeapon(i, para1, 1000);//даём предмет или оружие
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " Админ %s [%d] дал участникам мероприятия %s .", sendername, playerid, para2);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Админ %s [%d] дал участникам мероприятия %s .", aa333, playerid, para2);//доработка для использования Русских ников
//				printf("[MPSys] Админ %s [%d] дал участникам мероприятия %s .", sendername, playerid, para2);
			}
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать оружие\nПополнить жизнь и броню\
			\nОтобрать предметы и оружие (у всех)\nДать транспорт\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать оружие\nПополнить жизнь и броню\
			\nОтобрать предметы и оружие (у всех)\nДать транспорт\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\
			\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nПополнить жизнь и броню\
			\nОтобрать предметы (у всех)\nДать транспорт\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\
			\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
*/
#if (FS22INS < 3)
	if(dialogid == 702)//Дать предмет или оружие (1)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			if(listitem == 0) { mpidpara1[playerid] = 5; }
			if(listitem == 1) { mpidpara1[playerid] = 6; }
			if(listitem == 2) { mpidpara1[playerid] = 8; }
			if(listitem == 3) { mpidpara1[playerid] = 9; }

			if(listitem == 4) { mpidpara1[playerid] = 16; }
			if(listitem == 5) { mpidpara1[playerid] = 17; }
			if(listitem == 6) { mpidpara1[playerid] = 18; }
			if(listitem == 7) { mpidpara1[playerid] = 22; }
			if(listitem == 8) { mpidpara1[playerid] = 23; }
			if(listitem == 9) { mpidpara1[playerid] = 24; }
			if(listitem == 10) { mpidpara1[playerid] = 25; }
			if(listitem == 11) { mpidpara1[playerid] = 26; }
			if(listitem == 12) { mpidpara1[playerid] = 27; }
			if(listitem == 13) { mpidpara1[playerid] = 28; }
			if(listitem == 14) { mpidpara1[playerid] = 29; }
			if(listitem == 15) { mpidpara1[playerid] = 30; }
			if(listitem == 16) { mpidpara1[playerid] = 31; }
			if(listitem == 17) { mpidpara1[playerid] = 32; }
			if(listitem == 18) { mpidpara1[playerid] = 33; }
			if(listitem == 19) { mpidpara1[playerid] = 34; }
			if(listitem == 20) { mpidpara1[playerid] = 39; }
			switch(mpidpara1[playerid])
			{
				case 5: format(mpidpara3[playerid], 64, "Бейсбольной бите");
				case 6: format(mpidpara3[playerid], 64, "Лопате");
				case 8: format(mpidpara3[playerid], 64, "Катане");
				case 9: format(mpidpara3[playerid], 64, "Бензопиле");

				case 16: format(mpidpara3[playerid], 64, "Граната");
				case 17: format(mpidpara3[playerid], 64, "Слезоточивый газ");
				case 18: format(mpidpara3[playerid], 64, "Коктейль Молотова");
				case 22: format(mpidpara3[playerid], 64, "Пистолет");
				case 23: format(mpidpara3[playerid], 64, "Пистолет с глушителем");
				case 24: format(mpidpara3[playerid], 64, "Дезерт иигл");
				case 25: format(mpidpara3[playerid], 64, "Дробовик");
				case 26: format(mpidpara3[playerid], 64, "Обрез");
				case 27: format(mpidpara3[playerid], 64, "SPAZ 12");
				case 28: format(mpidpara3[playerid], 64, "Узи");
				case 29: format(mpidpara3[playerid], 64, "MP5");
				case 30: format(mpidpara3[playerid], 64, "АК-47");
				case 31: format(mpidpara3[playerid], 64, "М4");
				case 32: format(mpidpara3[playerid], 64, "Tes9");
				case 33: format(mpidpara3[playerid], 64, "Винтовка");
				case 34: format(mpidpara3[playerid], 64, "Снайперскую винтовка");
				case 39: format(mpidpara3[playerid], 64, "Взрывчатка");
			}
			if(mpidpara1[playerid] < 16)
			{
				new para3 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
						GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para3 = 1;
							GivePlayerWeapon(i, mpidpara1[playerid], 1000);//даём предмет или оружие
						}
					}
				}
				if(para3 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " Администратор %s [%d] раздал участникам мероприятия по %s .", sendername, playerid, mpidpara3[playerid]);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					new aa333[64];//доработка для использования Русских ников
					format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s .", aa333, playerid, mpidpara3[playerid]);//доработка для использования Русских ников
//					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s .", sendername, playerid, para2);
				}
			}
			else
			{
				new string[256];
				format(string, sizeof(string), "Оружие: %s .", mpidpara3[playerid]);
				ShowPlayerDialog(playerid, 703, 1, string, "Введите число штук (зарядов или патронов)\n(от 1 до 50000):", "ОК", "Отмена");
				dlgcont[playerid] = 703;
			}
		}
#endif
#if (FS22INS == 1)
		else
		{
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
			dlgcont[playerid] = 700;
		}
		return 1;
	}
#endif
#if (FS22INS == 2)
		else
		{
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
			dlgcont[playerid] = 700;
		}
		return 1;
	}
#endif
#if (FS22INS == 3)
	if(dialogid == 702)//Дать предмет
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			if(listitem == 0) { mpidpara1[playerid] = 43; }
			if(listitem == 1) { mpidpara1[playerid] = 14; }
			if(listitem == 2) { mpidpara1[playerid] = 46; }
			switch(mpidpara1[playerid])
			{
				case 43: format(mpidpara3[playerid], 64, "Фотоаппарату");
				case 14: format(mpidpara3[playerid], 64, "Букету цветов");
				case 46: format(mpidpara3[playerid], 64, "Парашюту");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
						GivePlayerWeapon(i, mpidpara1[playerid], 1000);//даём предмет или оружие
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " Администратор %s [%d] раздал участникам мероприятия по %s .", sendername, playerid, mpidpara3[playerid]);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s .", aa333, playerid, mpidpara3[playerid]);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s .", sendername, playerid, para2);
			}
		}
		else
		{
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать предметы себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
			dlgcont[playerid] = 700;
		}
		return 1;
	}
#endif
#if (FS22INS < 3)
	if(dialogid == 703)//Дать предмет или оружие (2)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			new string[256];
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Ошибка, недопустимый символ:");
				SendClientMessage(playerid, COLOR_RED, "коды меньше 20h , или код A0h , или знак процентов, или ~ !!!");
				format(string, sizeof(string), "Оружие: %s .", mpidpara3[playerid]);
				ShowPlayerDialog(playerid, 703, 1, string, "Введите число штук (зарядов или патронов)\n(от 1 до 50000):", "ОК", "Отмена");
				dlgcont[playerid] = 703;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
		    if(para1 < 1 || para1 > 50000)
			{
				SendClientMessage(playerid, COLOR_RED, " число штук (зарядов или патронов) от 1 до 50000 !");
				format(string, sizeof(string), "Оружие: %s .", mpidpara3[playerid]);
				ShowPlayerDialog(playerid, 703, 1, string, "Введите число штук (зарядов или патронов)\n(от 1 до 50000):", "ОК", "Отмена");
				dlgcont[playerid] = 703;
				return 1;
			}
			new para2[256];
			switch(mpidpara1[playerid])
			{
				case 16: format(para2, sizeof(para2), "Гранате");
				case 17: format(para2, sizeof(para2), "Слезоточивому газу");
				case 18: format(para2, sizeof(para2), "Коктейлю Молотова");
				case 22: format(para2, sizeof(para2), "Пистолету");
				case 23: format(para2, sizeof(para2), "Пистолету с глушителем");
				case 24: format(para2, sizeof(para2), "Дезерт иигл");
				case 25: format(para2, sizeof(para2), "Дробовику");
				case 26: format(para2, sizeof(para2), "Обрезу");
				case 27: format(para2, sizeof(para2), "SPAZ 12");
				case 28: format(para2, sizeof(para2), "Узи");
				case 29: format(para2, sizeof(para2), "MP5");
				case 30: format(para2, sizeof(para2), "АК-47");
				case 31: format(para2, sizeof(para2), "М4");
				case 32: format(para2, sizeof(para2), "Tes9");
				case 33: format(para2, sizeof(para2), "Винтовке");
				case 34: format(para2, sizeof(para2), "Снайперской винтовке");
				case 39: format(para2, sizeof(para2), "Взрывчатке");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
						GivePlayerWeapon(i, mpidpara1[playerid], para1);//даём предмет или оружие
						if(mpidpara1[playerid] == 39) { GivePlayerWeapon(i, 40, 10); }
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				if(mpidpara1[playerid] >= 16 && mpidpara1[playerid] <= 18)
				{
					format(string, sizeof(string), " Администратор %s [%d] раздал участникам мероприятия по %s ( по %d штук ) .", sendername, playerid, para2, para1);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s ( по %d штук ) .", aa333, playerid, para2, para1);
//					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s ( по %d штук ) .", sendername, playerid, para2, para1);
				}
				if(mpidpara1[playerid] >= 22 && mpidpara1[playerid] <= 34)
				{
					format(string, sizeof(string), " Администратор %s [%d] раздал участникам мероприятия по %s , и по %d патронов.", sendername, playerid, para2, para1);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s , и по %d патронов.", aa333, playerid, para2, para1);
//					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s , и по %d патронов.", sendername, playerid, para2, para1);
				}
				if(mpidpara1[playerid] == 39)
				{
					format(string, sizeof(string), " Администратор %s [%d] раздал участникам мероприятия по %s , и по %d зарядов.", sendername, playerid, para2, para1);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s , и по %d зарядов.", aa333, playerid, para2, para1);
//					printf("[MPSys] Администратор %s [%d] раздал участникам мероприятия по %s , и по %d зарядов.", sendername, playerid, para2, para1);
				}
			}
		}
		else
		{
			ShowPlayerDialog(playerid, 702, 2, "Дать предмет или оружие.", "Бейсбольная бита\nЛопата\nКатана\nБензопила\
			\nГраната\nСлезоточивый газ\nКоктейль Молотова\nПистолет\nПистолет с глушителем\nДезерт иигл\nДробовик\nОбрез\
			\nSPAZ 12\nУзи\nMP5\nАК-47\nМ4\nTes9\nВинтовка\nСнайперская винтовка\nВзрывчатка", "Выбор", "Отмена");
			dlgcont[playerid] = 702;
		}
		return 1;
	}
#endif
	if(dialogid == 704)//Дать транспорт (1)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Ошибка, недопустимый символ:");
				SendClientMessage(playerid, COLOR_RED, "коды меньше 20h , или код A0h , или знак процентов, или ~ !!!");
#if (FS22INS < 3)
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Введите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Внимание !!!\n\nМодели транспорта: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ЗАПРЕЩЕНЫ !!!\n\nВведите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
				dlgcont[playerid] = 704;
				return 1;
			}
			mpidpara1[playerid] = strval(inputtext);
		    if(mpidpara1[playerid] < 400 || mpidpara1[playerid] > 611)
			{
				SendClientMessage(playerid, COLOR_RED, " ИД модели транспорта от 400 до 611 !");
#if (FS22INS < 3)
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Введите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Внимание !!!\n\nМодели транспорта: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ЗАПРЕЩЕНЫ !!!\n\nВведите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
				dlgcont[playerid] = 704;
				return 1;
			}
#if (FS22INS == 3)
			if(mpidpara1[playerid] == 432 || mpidpara1[playerid] == 425 || mpidpara1[playerid] == 476 || mpidpara1[playerid] == 447 ||
			mpidpara1[playerid] == 520 || mpidpara1[playerid] == 430 || mpidpara1[playerid] == 464)
			{
				SendClientMessage(playerid, COLOR_RED, " Вы ввели запрещённую модель транспорта !");
				ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Внимание !!!\n\nМодели транспорта: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ЗАПРЕЩЕНЫ !!!\n\nВведите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
				dlgcont[playerid] = 704;
				return 1;
			}
#endif
			new string[256];
			format(string, sizeof(string), " Модель: %d .", mpidpara1[playerid]);
			ShowPlayerDialog(playerid, 705, 1, string, "Введите цвет 1 транспорта (от 0 до 255):", "Выбор", "Отмена");
			dlgcont[playerid] = 705;
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать предметы себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	if(dialogid == 705)//Дать транспорт (2)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			new string[256];
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Ошибка, недопустимый символ:");
				SendClientMessage(playerid, COLOR_RED, "коды меньше 20h , или код A0h , или знак процентов, или ~ !!!");
				format(string, sizeof(string), " Модель: %d .", mpidpara1[playerid]);
				ShowPlayerDialog(playerid, 705, 1, string, "Введите цвет 1 транспорта (от 0 до 255):", "Выбор", "Отмена");
				dlgcont[playerid] = 705;
				return 1;
			}
			mpidpara2[playerid] = strval(inputtext);
		    if(mpidpara2[playerid] < 0 || mpidpara2[playerid] > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " Цвет 1 транспорта от 0 до 255 !");
				format(string, sizeof(string), " Модель: %d .", mpidpara1[playerid]);
				ShowPlayerDialog(playerid, 705, 1, string, "Введите цвет 1 транспорта (от 0 до 255):", "Выбор", "Отмена");
				dlgcont[playerid] = 705;
				return 1;
			}
			format(string, sizeof(string), " Модель: %d , Цвет 1: %d .", mpidpara1[playerid], mpidpara2[playerid]);
			ShowPlayerDialog(playerid, 706, 1, string, "Введите цвет 2 транспорта (от 0 до 255):", "ОК", "Отмена");
			dlgcont[playerid] = 706;
		}
		else
		{
#if (FS22INS < 3)
			ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Введите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 704, 1, "Дать транспорт.", "Внимание !!!\n\nМодели транспорта: 432 , 425 , 476 ,\
			\n447 , 520 , 430 , 464 - ЗАПРЕЩЕНЫ !!!\n\nВведите модель транспорта (от 400 до 611):", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 704;
			return 1;
		}
		return 1;
	}
	if(dialogid == 706)//Дать транспорт (3)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
		new string[256];
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Ошибка, недопустимый символ:");
				SendClientMessage(playerid, COLOR_RED, "коды меньше 20h , или код A0h , или знак процентов, или ~ !!!");
				format(string, sizeof(string), " Модель: %d , Цвет 1: %d .", mpidpara1[playerid], mpidpara2[playerid]);
				ShowPlayerDialog(playerid, 706, 1, string, "Введите цвет 2 транспорта (от 0 до 255):", "ОК", "Отмена");
				dlgcont[playerid] = 706;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
		    if(para1 < 0 || para1 > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " Цвет 2 транспорта от 0 до 255 !");
				format(string, sizeof(string), " Модель: %d , Цвет 1: %d .", mpidpara1[playerid], mpidpara2[playerid]);
				ShowPlayerDialog(playerid, 706, 1, string, "Введите цвет 2 транспорта (от 0 до 255):", "ОК", "Отмена");
				dlgcont[playerid] = 706;
				return 1;
			}
			new para2 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para2 = 1;
						if(mpcarid[i] != -600)//если есть транспорт у участника МП, то:
						{
							DestroyVehicle(mpcarid[i]);//удаляем транспорт
						}
						new Float:locX, Float:locY, Float:locZ;
						GetPlayerPos(i, locX, locY, locZ);
						mpcarid[i] = CreateVehicle(mpidpara1[playerid], locX, locY, locZ+3,
						0.0, mpidpara2[playerid], para1, 90000);//даём транспорт игроку
						LinkVehicleToInterior(mpcarid[i], GetPlayerInterior(i));//подключить транспорт к интерьеру игрока
						SetVehicleVirtualWorld(mpcarid[i], GetPlayerVirtualWorld(i));//установить транспорту виртуальный мир игрока
						PutPlayerInVehicle(i, mpcarid[i], 0);
					}
				}
			}
			if(para2 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " Администратор %s [%d] дал участникам мероприятия по модели транспорта ИД: %d .", sendername, playerid, mpidpara1[playerid]);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] дал участникам мероприятия по модели транспорта ИД: %d .", aa333, playerid, mpidpara1[playerid]);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] дал участникам мероприятия по модели транспорта ИД: %d .", sendername, playerid, mpidpara1[playerid]);
			}
		}
		else
		{
			format(string, sizeof(string), " Модель: %d .", mpidpara1[playerid]);
			ShowPlayerDialog(playerid, 705, 1, string, "Введите цвет 1 транспорта (от 0 до 255):", "Выбор", "Отмена");
			dlgcont[playerid] = 705;
			return 1;
		}
		return 1;
	}
	if(dialogid == 707)//Запустить обратный отсчёт
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Ошибка, недопустимый символ:");
				SendClientMessage(playerid, COLOR_RED, "коды меньше 20h , или код A0h , или знак процентов, или ~ !!!");
				ShowPlayerDialog(playerid, 707, 1, "Запустить обратный отсчёт.", "Введите число секунд (от 2 до 12):", "ОК", "Отмена");
				dlgcont[playerid] = 707;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
		    if(para1 < 2 || para1 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " Число секунд от 2 до 12 !");
				ShowPlayerDialog(playerid, 707, 1, "Запустить обратный отсчёт.", "Введите число секунд (от 2 до 12):", "ОК", "Отмена");
				dlgcont[playerid] = 707;
				return 1;
			}
			new para2 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			para1++;
			countdown[playerid] = para1;
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw)
					{
						para2 = 1;
						if(countdown[i] == -1) { countdown[i] = para1; }//запускаем обратный отсчёт
					}
				}
			}
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(para2 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new string[256];
				format(string, sizeof(string), " Администратор %s [%d] запустил отсчёт от %d секунд.", sendername, playerid, para1-1);
				SendMPMessage(mpstate[playerid], 0xC2A2DAFF, string);
			}
			new aa333[64];//доработка для использования Русских ников
			format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
			printf("[MPSys] Администратор %s [%d] запустил отсчёт от %d секунд.", aa333, playerid, para1-1);//доработка для использования Русских ников
//			printf("[MPSys] Администратор %s [%d] запустил отсчёт от %d секунд.", sendername, playerid, para1-1);
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать предметы себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	if(dialogid == 708)//Сменить скин
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Ошибка, недопустимый символ:");
				SendClientMessage(playerid, COLOR_RED, "коды меньше 20h , или код A0h , или знак процентов, или ~ !!!");
#if (FS11INS == 0)
				ShowPlayerDialog(playerid, 708, 1, "Сменить скин.", "Введите ИД скина (от 0 до 299):", "ОК", "Отмена");
#endif
#if (FS11INS == 1)
				ShowPlayerDialog(playerid, 708, 1, "Сменить скин.", "Введите ИД скина (от 0 до 311):", "ОК", "Отмена");
#endif
				dlgcont[playerid] = 708;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
#if (FS11INS == 0)
		    if(para1 < 0 || para1 > 299)
			{
				SendClientMessage(playerid, COLOR_RED, " ИД скина от 0 до 299 !");
				ShowPlayerDialog(playerid, 708, 1, "Сменить скин.", "Введите ИД скина (от 0 до 299):", "ОК", "Отмена");
				dlgcont[playerid] = 708;
				return 1;
			}
#endif
#if (FS11INS == 1)
		    if(para1 < 0 || para1 > 311)
			{
				SendClientMessage(playerid, COLOR_RED, " ИД скина от 0 до 311 !");
				ShowPlayerDialog(playerid, 708, 1, "Сменить скин.", "Введите ИД скина (от 0 до 311):", "ОК", "Отмена");
				dlgcont[playerid] = 708;
				return 1;
			}
#endif
			new para2 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para2 = 1;
						SetPlayerSkin(i, para1);//меняем скин игроку
					}
				}
			}
			if(para2 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия скин на ИД: %d .", sendername, playerid, para1);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] сменил участникам мероприятия скин на ИД: %d .", aa333, playerid, para1);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] сменил участникам мероприятия скин на ИД: %d .", sendername, playerid, para1);
			}
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать предметы себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	if(dialogid == 709)//Сменить цвет маркера
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Меню работает только в организованном Вами МП !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " Сейчас нельзя ! Дождитесь окончания объявления о МП !");
			return 1;
		}
        if(response)
		{
			new para1;
			new para2;
			para2 = -600;
			if(listitem == 0)//Красный
			{
				para1 = 0xFF0000FF;
				para2 = 0;
				format(mpidpara3[playerid], 64, "Красный");
			}
			if(listitem == 1)//Коричневый
			{
				para1 = 0xBF3F00FF;
				para2 = 1;
				format(mpidpara3[playerid], 64, "Коричневый");
			}
			if(listitem == 2)//Оранжевый
			{
				para1 = 0xFF7F00FF;
				para2 = 2;
				format(mpidpara3[playerid], 64, "Оранжевый");
			}
			if(listitem == 3)//Жёлтый
			{
				para1 = 0xFFFF00FF;
				para2 = 3;
				format(mpidpara3[playerid], 64, "Жёлтый");
			}
			if(listitem == 4)//Зелёный
			{
				para1 = 0x00FF00FF;
				para2 = 4;
				format(mpidpara3[playerid], 64, "Зелёный");
			}
			if(listitem == 5)//Бирюзовый
			{
				para1 = 0x00FFFFFF;
				para2 = 5;
				format(mpidpara3[playerid], 64, "Бирюзовый");
			}
			if(listitem == 6)//Голубой
			{
				para1 = 0x00BFFFFF;
				para2 = 6;
				format(mpidpara3[playerid], 64, "Голубой");
			}
			if(listitem == 7)//Синий
			{
				para1 = 0x0000FFFF;
				para2 = 7;
				format(mpidpara3[playerid], 64, "Синий");
			}
			if(listitem == 8)//Фиолетовый
			{
				para1 = 0x7F00FFFF;
				para2 = 8;
				format(mpidpara3[playerid], 64, "Фиолетовый");
			}
			if(listitem == 9)//Сиреневый
			{
				para1 = 0xFF00FFFF;
				para2 = 9;
				format(mpidpara3[playerid], 64, "Сиреневый");
			}
			if(listitem == 10)//Серый
			{
				para1 = 0x7F7F7FFF;
				para2 = 10;
				format(mpidpara3[playerid], 64, "Серый");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
			    		for(new j = 0; j < MAX_PLAYERS; j++)
						{
							SetPlayerMarkerForPlayer(j, i, para1);//меняем цвет маркера игроку
						}
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " В радиусе 50 к.е. нет ни одного участника мероприятия !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				switch(para2)
				{
					case 0: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {FF0000}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 1: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {BF3F00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 2: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {FF7F00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 3: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {FFFF00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 4: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {00FF00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 5: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {00FFFF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 6: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {00BFFF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 7: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {0000FF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 8: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {7F00FF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 9: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {FF00FF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 10: format(string, sizeof(string), " Администратор %s [%d] сменил участникам мероприятия цвет маркера на {7F7F7F}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
				}
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//доработка для использования Русских ников
				format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
				printf("[MPSys] Администратор %s [%d] сменил участникам мероприятия цвет маркера на %s .", aa333, playerid, mpidpara3[playerid]);//доработка для использования Русских ников
//				printf("[MPSys] Администратор %s [%d] сменил участникам мероприятия цвет маркера на %s .", sendername, playerid, mpidpara3[playerid]);
			}
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nЗапустить обратный отсчёт\nСменить скин\nСменить цвет маркера\nЗаморозить\
			\nРазморозить (всех)\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет или оружие\nДать оружие себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы и оружие (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "Меню МП (в радиусе 50 к.е.)", "Дать предмет\nДать предметы себе)))\
			\nПополнить жизнь и броню\nПополнить жизнь и броню себе)))\nОтобрать предметы (у всех)\nДать транспорт\
			\nОтобрать транспорт (у всех)\nОтключить авторемонт (всем)\nВключить авторемонт (всем)\nЗапустить обратный отсчёт\
			\nСменить скин\nСменить цвет маркера\nЗаморозить\nРазморозить (всех)\
			\nТП к себе всех (с любого расстояния)", "Выбор", "Отмена");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	return 0;
}

forward InpTxtControl(string[]);
public InpTxtControl(string[])//контроль вводимого текста на посторонние символы
{
	new dln, dopper;
	dln = strlen(string);
	dopper = 1;
	for(new i = 0; i < dln; i++)
	{
		if(string[i] < 32 || string[i] == 37 ||
		string[i] == 126 || string[i] == 160) { dopper = 0; }
	}
	return dopper;
}

#if (FS22INS > 1)
	public EndPlCRTp(playerid)
	{
		SetPVarInt(playerid, "PlCRTp", 0);
		return 1;
	}
#endif

forward mpsysvehfunc(carplay);
public mpsysvehfunc(carplay)
{
	new para1 = 0;
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))//дальнейшее выполняем если игрок в коннекте
		{
			if(mpstate[i] != -600 && mpcarid[i] != -600)//если игрок находится в МП, И у него есть транспорт, то:
			{
				if(mpcarid[i] == carplay)//если ИД удаляемого транспорта есть в МП, то:
				{
					para1 = 1;//возвращаем 1 (иначе, возвращаем 0)
				}
			}
		}
	}
    return para1;
}

forward mpsysplfunc(playerid);
public mpsysplfunc(playerid)
{
	new para1 = 0;
	if(mpstate[playerid] != -600 && mpstate[playerid] != playerid)//если игрок находится в МП, И он НЕ организатор МП, то:
	{
		para1 = 1;//возвращаем 1 (иначе, возвращаем 0)
	}
    return para1;
}

forward TPmp(playerid, plint, plvw, Float:corx, Float:cory, Float:corz);
public TPmp(playerid, plint, plvw, Float:corx, Float:cory, Float:corz)
{
#if (FS22INS == 1)
	SetPlayerInterior(playerid, plint);
	SetPlayerVirtualWorld(playerid, plvw);
	SetPlayerPos(playerid, corx, cory, corz);
	SetCameraBehindPlayer(playerid);
#endif
#if (FS22INS > 1)
	if(GetPVarInt(playerid, "SecPris") == 0)//если игрок НЕ сидит в тюрьме, то:
	{
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
	 	SetPlayerInterior(playerid, plint);
		SetPlayerVirtualWorld(playerid, plvw);
		SetPlayerPos(playerid, corx, cory, corz);
		SetCameraBehindPlayer(playerid);
	}
#endif
	return 1;
}

forward MPStart1(playerid);
public MPStart1(playerid)
{
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
		return 1;
	}
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600)
		{
			format(string, sizeof(string), " Администратор ID: %d не смог начать мероприятие, вышел с сервера (((...", playerid);
			SendClientMessageToAll(COLOR_RED, string);
			return 1;
		}
	}
	else
	{
		format(string, sizeof(string), " Администратор ID: %d не смог начать мероприятие, вышел с сервера (((...", playerid);
		SendClientMessageToAll(COLOR_RED, string);
		return 1;
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(mpcount[playerid] >= mpcount22[playerid])
	{
		format(string, sizeof(string), " Администратор %s [%d] начал мероприятие без Вас (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_YELLOW, string);
		SendClientMessageToAll(COLOR_YELLOW, " ( было набрано необходимое количество участников мероприятия )");
		if(timstop[playerid] == 1)
		{
			timstop[playerid] = 0;
		}
		permis[playerid] = 0;//запретить ТП на МП
		return 1;
	}
	else
	{
		format(string, sizeof(string), " Администратор %s [%d] организовал мероприятие, до начала осталось 40 секунд,", sendername, playerid);
		SendClientMessageToAll(COLOR_GREEN, string);
		if(mpcount[playerid] > 0)
		{
			format(string, sizeof(string), " число участников мероприятия - %d игроков, торопитесь,", mpcount[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		format(string, sizeof(string), " что бы телепортироваться на мероприятие - введите {FFFF00}/mptp %d", mpstate[playerid]);
		SendClientMessageToAll(COLOR_GREEN, string);
		SetTimerEx("MPStart2", 20000, 0, "d", playerid);
	}
	return 1;
}

forward MPStart2(playerid);
public MPStart2(playerid)
{
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
		return 1;
	}
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600)
		{
			format(string, sizeof(string), " Администратор ID: %d не смог начать мероприятие, вышел с сервера (((...", playerid);
			SendClientMessageToAll(COLOR_RED, string);
			return 1;
		}
	}
	else
	{
		format(string, sizeof(string), " Администратор ID: %d не смог начать мероприятие, вышел с сервера (((...", playerid);
		SendClientMessageToAll(COLOR_RED, string);
		return 1;
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(mpcount[playerid] >= mpcount22[playerid])
	{
		format(string, sizeof(string), " Администратор %s [%d] начал мероприятие без Вас (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_YELLOW, string);
		SendClientMessageToAll(COLOR_YELLOW, " ( было набрано необходимое количество участников мероприятия )");
		if(timstop[playerid] == 1)
		{
			timstop[playerid] = 0;
		}
		permis[playerid] = 0;//запретить ТП на МП
		return 1;
	}
	else
	{
		format(string, sizeof(string), " Администратор %s [%d] организовал мероприятие, до начала осталось 20 секунд,", sendername, playerid);
		SendClientMessageToAll(COLOR_GREEN, string);
		if(mpcount[playerid] > 0)
		{
			format(string, sizeof(string), " число участников мероприятия - %d игроков, торопитесь,", mpcount[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		format(string, sizeof(string), " что бы телепортироваться на мероприятие - введите {FFFF00}/mptp %d", mpstate[playerid]);
		SendClientMessageToAll(COLOR_GREEN, string);
		SetTimerEx("MPStart3", 20000, 0, "d", playerid);
	}
	return 1;
}

forward MPStart3(playerid);
public MPStart3(playerid)
{
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
		return 1;
	}
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600)
		{
			format(string, sizeof(string), " Администратор ID: %d не смог начать мероприятие, вышел с сервера (((...", playerid);
			SendClientMessageToAll(COLOR_RED, string);
			return 1;
		}
	}
	else
	{
		format(string, sizeof(string), " Администратор ID: %d не смог начать мероприятие, вышел с сервера (((...", playerid);
		SendClientMessageToAll(COLOR_RED, string);
		return 1;
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(mpcount[playerid] >= mpcount22[playerid])
	{
		format(string, sizeof(string), " Администратор %s [%d] начал мероприятие без Вас (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_YELLOW, string);
	}
	if(mpcount[playerid] < mpcount22[playerid])
	{
		format(string, sizeof(string), " Администратор %s [%d] начал мероприятие без Вас (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		SendClientMessageToAll(COLOR_RED, " ( с недостаточным количеством участников мероприятия ) (((...");
	}
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
	}
	permis[playerid] = 0;//запретить ТП на МП
	return 1;
}

forward PNotice(playerid);
public PNotice(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600) { return 1; }
	}
	else
	{
		return 1;
	}
	new playvw;
	playvw = GetPlayerVirtualWorld(playerid);
	if(mpstate[playerid] != -600 && mpstate[playerid] != playerid && mpvw[playerid] != (playvw - 2000))
	{//удаление игрока из МП
		new para3 = mpstate[playerid];
		mpstate[playerid] = -600;//очистка ИД МП игрока
		mpvw[playerid] = -600;//очистка ИД виртуального мира игрока
		mpcount[para3]--;//число участников МП -1
		SetPVarInt(playerid, "PlConRep", 0);//включаем авторемонт
		timstop[playerid] = 0;//отключить контроль повторного /mptp
		if(mpcarid[playerid] != -600)//если есть транспорт у участника МП, то:
		{
			DestroyVehicle(mpcarid[playerid]);//удаляем транспорт
			mpcarid[playerid] = -600;//очистка транспорта участника МП
		}
		if(mpfreez[playerid] == 1)//если игрок заморожен, то:
		{
			TogglePlayerControllable(playerid, 1);//разморозить игрока
			mpfreez[playerid] = 0;//очистка заморозки игрока
		}
		SetPlayerSkin(playerid, skinpl[playerid]);//возвращаем игроку скин
   		for(new i = 0; i < MAX_PLAYERS; i++)//возвращаем игроку цвета маркера
		{
			SetPlayerMarkerForPlayer(i, playerid, mapcolpl[playerid]);
		}

		new string[256];
		new sendername[MAX_PLAYER_NAME];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(para3, giveplayer, sizeof(sendername));
//		format(string, sizeof(string), " Игрок %s [%d] был удалён из мероприятия ! (по таймеру)", sendername, playerid);
		format(string, sizeof(string), " Игрок %s [%d] был удалён из мероприятия ! (ТП в другой мир)", sendername, playerid);
		SendMPMessage(para3, COLOR_RED, string);
//		SendClientMessage(playerid, COLOR_RED, " Вы были удалены из мероприятия ! (по таймеру)");
		SendClientMessage(playerid, COLOR_RED, " Вы были удалены из мероприятия ! (ТП в другой мир)");
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		new aa444[64];//доработка для использования Русских ников
		format(aa444, sizeof(aa444), "%s", giveplayer);//доработка для использования Русских ников
//		printf("[MPSys] Игрок %s [%d] был удалён из мероприятия ( Администратор %s ) (по таймеру)", aa333, playerid, aa444);//доработка для использования Русских ников
		printf("[MPSys] Игрок %s [%d] был удалён из мероприятия ( Администратор %s ) (ТП в другой мир)", aa333, playerid, aa444);//доработка для использования Русских ников
//		printf("[MPSys] Игрок %s [%d] был удалён из мероприятия ( Администратор %s ) (по таймеру)", sendername, playerid, giveplayer);
//		printf("[MPSys] Игрок %s [%d] был удалён из мероприятия ( Администратор %s ) (ТП в другой мир)", sendername, playerid, giveplayer);
	}
	else//иначе:
	{
		pnotice[playerid] = 0;//очистка предупреждения игроку
	}
	return 1;
}

forward ANotice(playerid);
public ANotice(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600) { return 1; }
	}
	else
	{
		return 1;
	}
	new playvw;
	playvw = GetPlayerVirtualWorld(playerid);
	if(mpstate[playerid] != -600 && mpstate[playerid] == playerid && mpvw[playerid] != (playvw - 2000))
	{//удаление админа из МП (завершение МП)
		new para3 = mpstate[playerid];
		new para4 = mpvw[playerid];
		mpstate[playerid] = -600;//очистка ИД МП админа
		mpvw[playerid] = -600;//очистка ИД виртуального мира админа
		if(permis[playerid] == 1)//если разрешено ТП на МП, то:
		{
			permis[playerid] = 0;//запретить ТП на МП
			timstop[playerid] = 1;//активировать остановку таймеров объявлений
		}
		mpcount[playerid] = 0;//очистка числа участников МП
		mpcount22[playerid] = 0;//очистка максимума участников МП

		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), " Администратор %s [%d] был удалён из мероприятия ! (по таймеру)", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		format(string, sizeof(string), " Мероприятие Администратора %s [%d] завершено !", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		new aa333[64];//доработка для использования Русских ников
		format(aa333, sizeof(aa333), "%s", sendername);//доработка для использования Русских ников
		printf("[MPSys] Администратор %s [%d] был удалён из мероприятия (ID: %d VW: %d) (по таймеру)", aa333, playerid, para3, para4);//доработка для использования Русских ников
		printf("[MPSys] Мероприятие Администратора %s [%d] (ID: %d VW: %d) завершено !", aa333, playerid, para3, para4);//доработка для использования Русских ников
//		printf("[MPSys] Администратор %s [%d] был удалён из мероприятия (ID: %d VW: %d) (по таймеру)", sendername, playerid, para3, para4);
//		printf("[MPSys] Мероприятие Администратора %s [%d] (ID: %d VW: %d) завершено !", sendername, playerid, para3, para4);
	}
	else//иначе:
	{
		anotice[playerid] = 0;//очистка предупреждения админу
	}
	return 1;
}

public OneSec()
{
	for(new i = 0; i < MAX_PLAYERS; i++)//цикл для всех игроков
	{
		if(IsPlayerConnected(i))//дальнейшее выполняем если игрок в коннекте
		{
			if(countdown[i] > 0)//если админ запустил обратный отсчёт, то:
			{
				countdown[i]-=1;
				new str[6];
				format(str,6,"...%d",countdown[i]);
				GameTextForPlayer(i,str,950,4);
				PlayerPlaySound(i,1056,0.0,0.0,0.0);
				if(countdown[i]<4)TogglePlayerControllable(i,0);
			}
			if(countdown[i] == 0)
			{
				TogglePlayerControllable(i,1);
				GameTextForPlayer(i,"~b~GO GO GO !",700,4);
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				countdown[i]=-1;
			}
			if(mpstate[i] != -600 && mpstate[mpstate[i]] == -600)
			{//возврат игроков на основную карту (если админ завершил МП ИЛИ не вернулся на МП ИЛИ вышел с сервера)
				mpstate[i] = -600;//очистка ИД МП игрока
				mpvw[i] = -600;//очистка ИД виртуального мира игрока
				SetPVarInt(i, "PlConRep", 0);//включаем авторемонт
				if(countdown[i] != -1) { countdown[i] = -1; }//остановить обратный отсчёт
				timstop[i] = 0;//отключить контроль повторного /mptp
				if(mpcarid[i] != -600)//если есть транспорт у участника МП, то:
				{
					DestroyVehicle(mpcarid[i]);//удаляем транспорт
					mpcarid[i] = -600;//очистка транспорта участника МП
				}
				if(mpfreez[i] == 1)//если игрок заморожен, то:
				{
					TogglePlayerControllable(i, 1);//разморозить игрока
					mpfreez[i] = 0;//очистка заморозки игрока
				}
				TPmp(i, retint[i], 0, corpl[i][0], corpl[i][1], corpl[i][2]);//ТП на основную карту
				SetPlayerSkin(i, skinpl[i]);//возвращаем игроку скин
   				for(new j = 0; j < MAX_PLAYERS; j++)//возвращаем игроку цвета маркера
				{
					SetPlayerMarkerForPlayer(j, i, mapcolpl[i]);
				}
			}
			new playvw;
			playvw = GetPlayerVirtualWorld(i);
			if(mpstate[i] != -600 && mpstate[i] != i && mpvw[i] != (playvw - 2000))
			{//предупреждение (если игрок ТП с МП)
				if(pnotice[i] == 1)
				{
					if(countdown[i] != -1) { countdown[i] = -1; }//остановить обратный отсчёт
//					new string[256];
//					SendClientMessage(i, COLOR_RED, " У Вас есть 30 секунд что бы вернуться на мероприятие !");
//					format(string, sizeof(string), " что бы вернуться на мероприятие - введите {FFFF00}/mptp %d", mpstate[i]);
//					SendClientMessage(i, COLOR_RED, string);
//					SetTimerEx("PNotice", 30000, 0, "d", i);
					SetTimerEx("PNotice", 300, 0, "d", i);
					pnotice[i] = 2;
					timstop[i] = 1;//включить контроль повторного /mptp
				}
				if(pnotice[i] == 0) { pnotice[i] = 1; }
			}
			else
			{
				pnotice[i] = 0;
			}
			if(mpstate[i] != -600 && mpstate[i] == i && mpvw[i] != (playvw - 2000))
			{//предупреждение (если админ ТП с МП)
				if(anotice[i] == 1)
				{
					if(countdown[i] != -1) { countdown[i] = -1; }//остановить обратный отсчёт
					SendClientMessage(i, COLOR_RED, " У Вас есть 30 секунд что бы вернуться на мероприятие !");
					SendClientMessage(i, COLOR_RED, " что бы вернуться на мероприятие - введите {FFFF00}/mpret");
					SetTimerEx("ANotice", 30000, 0, "d", i);
					anotice[i] = 2;
				}
				if(anotice[i] == 0) { anotice[i] = 1; }
			}
			else
			{
				anotice[i] = 0;
			}
		}
	}
	return 1;
}

