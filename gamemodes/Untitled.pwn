public OnPlayerCommandText(playerid, cmdtext[])
{
	if(chatcon[playerid] < 0)//если счётчик секунд меньше нуля, то:
	{
		new dopcis, sstr[256];
		dopcis = FCislit(chatcon[playerid]);
		switch(dopcis)
		{
			case 0: format(sstr, sizeof(sstr), " Спам в чате (или в командах) !   Попробуйте через %d секунд !", chatcon[playerid] * -1);
			case 1: format(sstr, sizeof(sstr), " Спам в чате (или в командах) !   Попробуйте через %d секунду !", chatcon[playerid] * -1);
			case 2: format(sstr, sizeof(sstr), " Спам в чате (или в командах) !   Попробуйте через %d секунды !", chatcon[playerid] * -1);
		}
		SendClientMessage(playerid, COLOR_RED, sstr);
		return 1;//завершаем функцию
	}
	chatcon[playerid]++;//прибавляем 1 к контрольной переменной чата
	new idx;
	idx = 0;
	new string[256];
	new strdln[5000];
	new akk[64], ssss[256], igkey[64], tdreg[64], adrip[64];
	new cmd[256];
	new tmp[256];
	new cartype = GetPlayerVehicleID(playerid);
	new string2[256];//используем везде
	new gid,pname[MAX_PLAYER_NAME],gname[MAX_PLAYER_NAME];
	new playermoney;
	new PlayerName=GetPlayerName(playerid);
	new State=GetPlayerState(playerid);
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new giveplayerid, moneys;
	cmd = strtok(cmdtext, idx);
	if(playspa[playerid] == 0)//игрок НЕ заспавнился
	{
		printf("-----[Игрок не заспавнился] %s [%d]: ввёл команду %s .", RealName[playerid], playerid, cmdtext);//Отправляем команду в сервер-лог
		SendClientMessage(playerid, COLOR_RED, " Вы ещё не заспавнились ! введите команду /help !");
		return 1;
	}
	if(PlayerInfo[playerid][pMutedsec] == 0)
	{
		printf(" Игрок %s [%d] ввёл команду %s .", RealName[playerid], playerid, cmdtext);
	}
	if(PlayerInfo[playerid][pMutedsec] > 0)
	{
		printf(" Игрок %s [%d] (заткнут) ввёл команду: %s .", RealName[playerid], playerid, cmdtext);
	}
//-------------- команды, если игрок не заспавнился (начало) -------------------
	if(strcmp(cmd, "/help", true) == 0 && playspa[playerid] == 0)
	{//если игрок НЕ заспавнился
		SendClientMessage(playerid,COLOR_GRAD1," ----------------------------- Помощь ----------------------------- ");
		SendClientMessage(playerid,COLOR_GREEN,"   Если нет возможности выбора скина и спавна,");
		SendClientMessage(playerid,COLOR_GREEN,"                  используйте команду   /spawn");
		SendClientMessage(playerid,COLOR_GRAD1," ------------------------------------------------------------------------ ");
    	return 1;
}
	if(strcmp(cmd, "/spawn", true) == 0 && playspa[playerid] == 0)
	{//если игрок НЕ заспавнился
		SendClientMessage(playerid,COLOR_GREEN," Вы заспавнились !");
		if(IsPlayerInAnyVehicle(playerid))
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid,x,y,z);
			SetPlayerPos(playerid,x,y,z+5);
			SetTimerEx("SecSpaDop", 300, 0, "i", playerid);
		}
		else
		{
			SpawnPlayer(playerid);
		}
    	return 1;
    }
	if(strcmp("/lay", cmdtext, true) == 0) {
	      ApplyAnimation(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
		  return 1;
	}
	if(strcmp(cmd, "/fuck", true) == 0) {
		 ApplyAnimation(playerid,"PED","fucku",4.0,1,0,0,0,0);
	     return 1;
	}
	if(strcmp(cmd, "/stop", true) == 0) {
		 ClearAnimations(playerid);
	     return 1;
	}

//-------------- команды, если игрок не заспавнился (конец) --------------------
//---------- команды игроков, разрешённые в любых случаях (начало) -------------
            if(!strcmp(cmd, "/korova", true))
        {
          new Float:X,Float:Y,Float:Z;
          GetPlayerPos(playerid, X,Y,Z);
          new tachka;
          tachka = CreateVehicle(462, X,Y,Z, 0.0, 1, 1, 60000);
          PutPlayerInVehicle(playerid, tachka, 0);
          new korova = CreateObject(11470, 0.42020, 1.13840, 0.58070,   0.00000, 0.00000, 0.00000);
          AttachObjectToVehicle(korova, tachka, 0.42020, 1.13840, 0.58070,   0.00000, 0.00000, 0.00000);
          return true;
}
	if(strcmp(cmd, "/cmd", true) == 0)
    {
        new String[2048];
        strins(String,"|>>>| Здесь вы можете посмотреть какие есть команды на сервере.\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"1. {FFFF00}/hh - {FFFFFF}Сказать всем привет.\n",strlen(String));
        strins(String,"2. {FFFF00}/bb  - {FFFFFF}Сказать всем пока.\n",strlen(String));
        strins(String,"3. {FFFF00}/commands - {FFFFFF}Другие команды сервера.\n",strlen(String));
	    strins(String,"4. {FFFF00}/pm - {FFFFFF}Написать игроку в личку.\n",strlen(String));
	    strins(String,"5. {FFFF00}/menu - {FFFFFF}Игровое меню сервера.\n",strlen(String));
	    strins(String,"6. {FFFF00}/em - {FFFFFF}Перевернуть машину.\n",strlen(String));
        strins(String,"7. {FFFF00}/adminka | /админка - {FFFFFF}Стоимость административных прав.\n",strlen(String));
        strins(String,"8. {FFFF00}/count - {FFFFFF}Отсчет (в машине).\n",strlen(String));
        strins(String,"9. {FFFF00}/rules - {FFFFFF}Помощь\n",strlen(String));
        strins(String,"10. {FFFF00}/vers - {FFFFFF}Просмотреть версию мода\n",strlen(String));
        strins(String,"11. {FFFF00}/korova - {FFFFFF}Кататься на корове\n",strlen(String));
        strins(String,"12. {FFFF00}/getid - {FFFFFF}Просмотреть ID транспорта его модель\n",strlen(String));
        strins(String,"13. {FFFF00}/report - {FFFFFF}[ид нарушителя] [жалоба]\n",strlen(String));
        strins(String,"14. {FFFF00}/cmchat - {FFFFFF}Очистить свой чат\n",strlen(String));
        strins(String,"15. {FFFF00}/s - {FFFFFF}Сохранить временную точку телепорта\n",strlen(String));
        strins(String,"16. {FFFF00}/dt [виртуальный мир] - {FFFFFF}Режим для дрифт тренинга\n",strlen(String));
        strins(String,"17. {FFFF00}/givecash | /pay [ид] [сумма] - {FFFFFF}Передать деньги другому игроку\n",strlen(String));
        strins(String,"18. {FFFF00}/dmcount - {FFFFFF}Запустить обратный-DM отсчёт\n",strlen(String));
        strins(String,"19. {FFFF00}/spawn - {FFFFFF}Заспавниться\n",strlen(String));
        strins(String,"20. {FFFF00}/admins - {FFFFFF}Просмотреть On-Line админов\n",strlen(String));
        strins(String,"21. {FFFF00}/statpl 600 - {FFFFFF}Просмотреть свою частичную статистику\n",strlen(String));
        strins(String,"22. {FFFF00}/obnul - {FFFFFF}Обнулить все свои очки\n",strlen(String));
        strins(String,"23. {FFFF00}/r - {FFFFFF}Телепортироваться на сохранённую позицию\n",strlen(String));
        strins(String,"24. {FFFF00}/lic - {FFFFFF}Включить вид от первого лица\n",strlen(String));
        strins(String,"25. {FFFF00}/offlic - {FFFFFF}Выключить вид от первого лица\n",strlen(String));
        strins(String,"26. {FFFF00}/vipinfo - {FFFFFF}Узнать цены на вип\n",strlen(String));
        strins(String,"27. {FFFF00}/vips - {FFFFFF}Просмотреть On-Line вип игроков\n",strlen(String));
        strins(String,"28. {FFFF00}/w | /t - {FFFFFF}Смена погоды и времени\n",strlen(String));
		strins(String,"29. {FFFF00}/r | /s - {FFFFFF}Сохранение позиции и телепорт к ней\n",strlen(String));
		strins(String,"30. {FFFF00}/cs - {FFFFFF}Телепорт на ДМ-зону\n",strlen(String));
		strins(String,"31. {FFFF00}/df(1-9) - {FFFFFF}Дрифт Зоны (от 1 до 9)\n",strlen(String));
		strins(String,"32. {FFFF00}/radio - {FFFFFF}Включить у себя радио\n",strlen(String));
		strins(String,"33. {FFFF00}/da - {FFFFFF}Согласиться с чем-либо\n",strlen(String));
		strins(String,"34. {FFFF00}/net - {FFFFFF}Отрицать что либо\n",strlen(String));
		strins(String,"35. {FFFF00}/xe - {FFFFFF}Смеяться\n",strlen(String));
		strins(String,"36. {FFFF00}/xd - {FFFFFF}Валяться от смеха\n",strlen(String));
		strins(String,"37. {FFFF00}/ogur - {FFFFFF}Взять огурец и обосраться\n",strlen(String));
		strins(String,"38. {FFFF00}/ex - {FFFFFF}Грустить\n",strlen(String));
		strins(String,"39. {FFFF00}/fire - {FFFFFF}Включить огонь под колесами\n",strlen(String));
		strins(String,"40. {FFFF00}/ice - {FFFFFF}Включить лед под колесами\n",strlen(String));
		strins(String,"41. {FFFF00}/puk - {FFFFFF}Пукнуть\n",strlen(String));
		strins(String,"42. {FFFF00}/movie | /movieoff - {FFFFFF}Включить/выключить режим мувика\n",strlen(String));
		strins(String,"Все команды можно отключить повторным их вводом",strlen(String));
		strins(String,"\n",strlen(String));
	    ShowPlayerDialog(playerid,3005, DIALOG_STYLE_MSGBOX, "{FFFFFF}Команды сервера.", String, "Ок", "");
        return 1;
}
        if(strcmp(cmd, "/rules", true) == 0)
        {
        new String[2048];
        strins(String," {99CCFF}Здравствуйте уважаемые игроки моего сервера. {6600FF}Я сделал этот раздел для {FF0000}тех кто не разбирается в командах\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"{FFFFFF}Итак, приступим\n",strlen(String));
        strins(String,"{FF0000}|>>>|>>>| {FFFF00}На сервере {FF0000}ЗАПРЕЩЕНО:\n",strlen(String));
        strins(String,"{FF3300}1. {33FF00}Не использовать читы,клео скрипты на нашем сервере\n",strlen(String));
        strins(String,"{FF3300}2. {33FF00}Не обзывать других игроков словами нуб,бот и не использовать ненормативную лексику\n",strlen(String));
        strins(String,"{FF3300}3. {33FF00}Администрация сервера всегда права в любых случаях\n",strlen(String));
        strins(String,"{FF3300}4. {33FF00}Давайте жить дружно и не мешать друг другу играть на нашем сервере\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"{FF0000}|>>>|>>>| {99FF00}Помощь по игре:\n",strlen(String));
     	strins(String,"{FFFFFF}1.{99FF00}Если радио не работает, попробуйте прибавить громкости в меню игры {FFFFFF}(ESC)\n",strlen(String));
        strins(String,"{FFFFFF}2.{99FF00}Если не загружаются текстуры (дороги), выйдите из машины\n",strlen(String));
        strins(String,"\n",strlen(String));
	    ShowPlayerDialog(playerid,1002, DIALOG_STYLE_MSGBOX, "{FFFFFF}Помощь", String, "Ок", "");
        return 1;
    }
    if(strcmp(cmd, "/line", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /line 0 , или");
				SendClientMessage(playerid, COLOR_GRAD2, " /line [трасса(1-5)] [0-отключить, 1-подключить]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if (para1 < 0 || para1 > 5)
			{
				SendClientMessage(playerid, COLOR_RED, " Номер трассы от 1 до 5 , или 0 !");
				return 1;
			}
			if (para1 == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, " --- Статистика трасс ---");
				format(string,sizeof(string)," Тр.1-[%d] Тр.2-[%d] Тр.3-[%d] Тр.4-[%d] Тр.5-[%d]", LineStat[1], LineStat[2],
				LineStat[3], LineStat[4], LineStat[5]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				printf(" Администратор %s просмотрел статистику трасс.", RealName[playerid]);
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [0-отключить, 1-подключить] !");
				return 1;
			}
			new stat;
			stat = strval(tmp);
			if (stat < 0 || stat > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0-отключить, 1-подключить !");
				return 1;
			}
			if (stat == LineStat[para1] && stat == 0)
			{
				format(string,sizeof(string)," Трасса %d уже отключена !", para1);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			if (stat == LineStat[para1] && stat == 1)
			{
				format(string,sizeof(string)," Трасса %d уже подключена !", para1);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			if (stat == 0)
			{
				LineStat[para1] = stat;
				SaveLine();//запись статуса трасс
				format(string,sizeof(string)," Администратор %s отключил трассу %d .", RealName[playerid], para1);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
				if(para1 == 1) { LineOff1(); }
				if(para1 == 2) { LineOff2(); }
				if(para1 == 3) { LineOff3(); }
				if(para1 == 4) { LineOff4(); }
				if(para1 == 5) { LineOff5(); }
				return 1;
			}
			if (stat == 1)
			{
				LineStat[para1] = stat;
				SaveLine();//запись статуса трасс
				format(string,sizeof(string)," Администратор %s подключил трассу %d .", RealName[playerid], para1);
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
				if(para1 == 1) { LineOn1(); }
				if(para1 == 2) { LineOn2(); }
				if(para1 == 3) { LineOn3(); }
				if(para1 == 4) { LineOn4(); }
				if(para1 == 5) { LineOn5(); }
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
	if (strcmp("/untouch", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			if(PlayerInfo[playerid][pAdmin] == 17)
			{
				SendClientMessage(playerid, COLOR_RED, " У Вас уже есть уровень главного (неприкасаемого) админа сервера !");
				return 1;
			}
			new dopper;
			format(string, sizeof(string), " *** Игрок %s [%d] сделал себя главным (неприкасаемым) админом на сервере.", RealName[playerid], playerid);
			print(string);
			SendClientMessage(playerid,COLOR_GREY," *** Вы сделали себя главным (неприкасаемым) админом на сервере.");
			PlayerInfo[playerid][pVIP] = 0;//убрать VIP
			dopper = PlayerInfo[playerid][pAdmin];
			PlayerInfo[playerid][pAdmin] = 17;
			AdmUpdate(RealName[playerid], PlayerInfo[playerid][pAdmin], 1);
			new twenlim = 0;
			new restlim = 0;
			Fmadmins(1, RealName[playerid], 0, twenlim, restlim);
			if (dopper <= 2)
			{
				PlayerInfo[playerid][pAdmlive] = 1;//установить бессмертие
				SendClientMessage(playerid, COLOR_GREEN, " Бессмертие включено.");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}

    	if(strcmp(cmdtext, "/commands", true) == 0)
	    {
		SendClientMessage(playerid,0xFF8000AA,"Чтобы получить авто:");
		SendClientMessage(playerid,0x00FF00AA,"			Нажать кнопку ALT(если вы пешком) или 2(если вы в машине);");
		SendClientMessage(playerid,0x00FF00AA,"     	Выбрать пункт 'Транспорт, и перейти во вкладку 'Тип транспорта'.");
		SendClientMessage(playerid,0xFF8000AA,"Телепортация:");
		SendClientMessage(playerid,0x00FF00AA,"     	Нажать кнопку ALT(если вы пешком) или 2(если вы в машине);");
		SendClientMessage(playerid,0x00FF00AA,"     	1.Выбрать пункт 'Телепорты';");
		SendClientMessage(playerid,0x00FF00AA,"     	2.Drift-трассы: '/df(1-9)'(без пробела);");
		SendClientMessage(playerid,0x00FF00AA,"     	2.Drag-трассы: '/drag1-3'(без пробела);");
		SendClientMessage(playerid,0xFF8000AA,"Тюнинг:");
		SendClientMessage(playerid,0x00FF00AA,"     	Нажать кнопку 2;");
		SendClientMessage(playerid,0x00FF00AA,"     	Выбрать пункт 'Транспорт';");
		SendClientMessage(playerid,0x00FF00AA,"         Выбрать пункт 'Тюнинг';");
		SendClientMessage(playerid,0x00FF00AA,"     	Далее выбираете ту деталь, которая вам нужна.");
		SendClientMessage(playerid,0xFF8000AA,"Сменить скин и прочее:");
		SendClientMessage(playerid,0x00FF00AA,"     	Нажать кнопку ALT(если вы пешком) или 2(если вы в машине);");
		SendClientMessage(playerid,0x00FF00AA,"     	Выбрать пункт 'Управление персонажем';");
		SendClientMessage(playerid,0x00FF00AA,"     	Далее выбираете то, что вам нужно, или же вы можете написать команду /skin");
		SendClientMessage(playerid,0xFF8000AA,"Дополнительно:");
		SendClientMessage(playerid,0x00FF00AA,"     	'/отсчет' - вызвать отсчёт;");
		SendClientMessage(playerid,0x00FF00AA,"     	'/dt [id]*' - режим дрифт-тренировки;");
		SendClientMessage(playerid,0x00FF00AA,"     	'/pm [id] [message]' - отправить личное сообщение;");
		SendClientMessage(playerid,0xFFFF00AA,"     	0 - общий мир. Далее - ваши отдельные.");
		return 1;
    }
    if(!strcmp(cmd, "/gang", true))
 	{
		ShowPlayerDialog(playerid, 1011, DIALOG_STYLE_LIST, "{0000FF}Банда{0000FF}","{00FFFF}Создать Банду\n{0000FF}Назначить скины\n{00FFFF}Назначить место спавна\n{0000FF}Назначить уровень\n{00FFFF}Пригласить в Банду\n{0000FF}Кикнуть из Банды\n{00FFFF}Изменить цвет Банды\n{0000FF}Уйти из банды", "Выбрать", "Отмена");
		return 1;
  	}
  	if(strcmp(cmd, "/fight", true) == 0 || strcmp(cmd, "/борьба", true) == 0)
	{
		ShowPlayerDialog(playerid, 789, DIALOG_STYLE_LIST, "Стиль борьбы", "{00ffff}Normal\n{00ffff}Boxing\n{0000ff}Kungfu\n{00ffff}KickBoxing\n{0000ff}Grabkick\n{00ffff}Elbow", "Выбор", "Отмена");
		return 1;
	}
    if (strcmp(cmdtext, "/em", true)==0)
    {
    new VehicleID, Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    VehicleID = GetPlayerVehicleID(playerid);
    SetVehiclePos(VehicleID, X, Y, Z);
    SetVehicleZAngle(VehicleID, 0);
    return 1;
    }
        if(strcmp(cmdtext,"/lic",true)==0)
	    {
			testka[playerid] = 1;
			SendClientMessage(playerid, COLOR_GREEN, "Вы включили вид от 1 лица (Только для Авто, но не для всех видов) | /offlic - выключить");
			new Float:x, Float:y, Float:z, vehicleid = GetPlayerVehicleID(playerid), vehmodel = GetVehicleModel(vehicleid), bool:found;
			for( new i;i<sizeof(DashBoards);i++ )
            	{
                if( vehmodel == DashBoards[i][modelidd] )
                {
                    x = DashBoards[i][cam_x];
                    y = DashBoards[i][cam_y];
                    z = DashBoards[i][cam_z];
                    found = true;
                    break;
                }
            }

            if( found )
            {
                PlayerInfo[playerid][camobj] = CreateObject(19254,x,y,z,0.0,0.0,0.0,200.0);
                AttachObjectToVehicle( PlayerInfo[playerid][camobj], vehicleid, x,y,z, 0, 0, 0);
                AttachCameraToObject(playerid, PlayerInfo[playerid][camobj]);
            }
            return 1;
		}
 	if(strcmp(cmdtext,"/offlic",true)==0)
	{
	   	 testka[playerid] = 0;
	   	 SendClientMessage(playerid, COLOR_GREEN, "Вы выключили вид от 1 лица");
	   	 SetCameraBehindPlayer( playerid );
     	 DestroyObject( PlayerInfo[playerid][camobj] );
	     return 1;
	}
        if(strcmp(cmd, "/adminka", true) == 0)
        {
        new String[2048];
        strins(String,"{00FF00}Вы зашли в раздел {FF0000}'Цены на административные права'\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"> {FFFF00}Стоимость административных прав {00FFFF}на три месяца:\n",strlen(String));
        strins(String,">> {0000FF}1 левел - {FF0000}10 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}2 левел - {FF0000}20 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}3 левел - {FF0000}30 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}4 левел - {FF0000}40 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}5 левел - {FF0000}50 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}6 левел - {FF0000}60 {FFFFFF}рублей\n",strlen(String));
     	strins(String,">> {0000FF}7 левел - {FF0000}70 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}8 левел - {FF0000}80 {FFFFFF}рублей\n",strlen(String));
        strins(String,">> {0000FF}9 левел - {FF0000}90 {FFFFFF}рублей\n",strlen(String));
	    strins(String,">> {0000FF}10 левел - {FF0000}100 {FFFFFF}рублей\n",strlen(String));
	    strins(String,">> {0000FF}11 левел - {FF0000}150 {FFFFFF}рублей\n",strlen(String));
		strins(String,">> {0000FF}12 левел - {FF0000}200 {FFFFFF}рублей\n",strlen(String));
		strins(String,">> {0000FF}13 левел - {FF0000}300 {FFFFFF}рублей\n",strlen(String));
		strins(String,">> {0000FF}14 левел - {FF0000}400 {FFFFFF}рублей\n",strlen(String));
		strins(String,">> {0000FF}Остальные уровни предназначены для властей сервера, и они не продаются",strlen(String));
	    strins(String,"\n",strlen(String));
        strins(String,"{FF0000}[Внимание]: {FFFFFF}Мы принимаем любые платежные системы, но{99FF00}мы принимаем только русский рубль.\n",strlen(String));
        strins(String,"{00FFFF}Чтобы приобрести административные права {FF0000}вам необходимо {00FFFF}связаться со мной в дискорде:{FF00FF}SethDisquaro#4442\n",strlen(String));
        strins(String,"\n",strlen(String));
	    ShowPlayerDialog(playerid,5002, DIALOG_STYLE_MSGBOX, "{FFFFFF}Админка", String, "Ок", "");
        return 1;
}
    if(strcmp(cmd, "/cs", true) == 0)
    {
       if(dzona[playerid] == 1)return SendClientMessage(playerid, COLOR_RED,"Вы уже находитесь в CS зоне, что-бы выйти /exitcs");
       {
           new rand = random(sizeof(DMZona));
           rand = random(sizeof(DMZona));
           SetPlayerPos(playerid, DMZona[rand][0], DMZona[rand][1], DMZona[rand][2]);
           GivePlayerWeapon(playerid,24,950);
           GivePlayerWeapon(playerid,31, 950);
           GivePlayerWeapon(playerid,34, 950);
           GivePlayerWeapon(playerid,28, 950);
           SetPlayerHealth(playerid, 100);
		   SetPlayerArmour(playerid,100);
           dzona[playerid] = 1;
           GetPlayerName(playerid, sendername, sizeof(sendername));
  		   format(string, sizeof(string), "{0066CC}%s(%d) {b22222}зашел в Соuntеr Strikе {0066CC}( /cs )", sendername, playerid);
		   SendClientMessageToAll(0xb22222FF, string);
           SendClientMessage(playerid, COLOR_REDRACE,"Вы в CS зоне | {999999}Что-бы выйти введите /exitcs");
	   }
       return 1;
    }
    if(strcmp(cmd, "/exitcs", true) == 0)
    {
       if(dzona[playerid] == 0)return SendClientMessage(playerid, COLOR_WHITE,"Вы не в CS зоне");
       dzona[playerid] = 0;
       SpawnPlayer(playerid);
       SendClientMessage(playerid, COLOR_RED,"Вы покинули CS зону");
       return 1;
    }
    if( strcmp(cmd, "/radio", true) == 0)
 {
     if(IsPlayerConnected(playerid))
     {
            ShowPlayerDialog(playerid, RADIO, DIALOG_STYLE_LIST, "Выберите Радио волну:","1.Zaycev FM\n2.Radio Record\n3.Record Teodor\n4.Record Dancecore\n5.Русский шансон\n6.Retro FM\n7.Record DubStep\n8.Record Дискотека 90-x\n9.Record Club\n10.Hip-Hop\n11.Европа +\n12.RAP\n13.Zaycev FM Классика\n14.Fox FM\n15.Казантип-FM\n16.Россия-FM\n17.MЕГА-FM\n{FF3300}Выключить радио", "Ok", "Выход");
        }
        return 1;
    }
    if(strcmp("/az", cmdtext, true, 10) == 0)
    {
      if(PlayerInfo[playerid][pAdmin] < 1) return 1;
      SetPlayerPos(playerid,1282.70, -801.78, 1089.94); // "-120.3881,1210.0604,1080.2694" - ставим свои координаты.
      SendClientMessage(playerid, COLOR_WHITE,"Вы телепортировались на собеседование"); // заменяем на свой текст
      SetPlayerInterior(playerid, 5);
      return 1;
}
    if (0 == strcmp(cmd, "/bonus"))
    {
        GivePlayerMoney(playerid, 150000);
        SendClientMessage(playerid, -1, "Вы получили 150000$.");
        return 1;
    }

    if (0 == strcmp(cmd, "/restore"))
    {
        if (0 == strcmp(params, "health") || 0 == strcmp(params, "hp"))
        {
            SetPlayerHealth(playerid, 100.0);
            return SendClientMessage(playerid, -1, "Здоровье восстановлено.");
        }
        // В английском языке есть 2 варианта написания: "armor" (в британском английском)
        // и "armour" (в американском английском) - учтём оба варианта.
        if (0 == strcmp(params, "armor") || 0 == strcmp(params, "armour"))
        {
            SetPlayerArmour(playerid, 100.0);
            return SendClientMessage(playerid, -1, "Броня восстановлена.");
        }
        return SendClientMessage(playerid, -1, "Использование: /restore [health/hp/armor/armour]");
}
    if (strcmp("/movie", cmdtext, true, 10) == 0)
    {
		   TextDrawHideForPlayer(playerid,Datum);
		   TextDrawHideForPlayer(playerid,Vrijeme);
           TextDrawHideForPlayer(playerid,VD);
           TextDrawHideForPlayer(playerid,VD1);
           TextDrawHideForPlayer(playerid,VD2);
           TextDrawHideForPlayer(playerid,VD3);
           SendClientMessage(playerid, -1, "Режим мувика включен!");
           return 1;
}
    if (strcmp("/movieoff", cmdtext, true, 10) == 0)
    {
            TextDrawShowForPlayer(playerid,Datum);
			TextDrawShowForPlayer(playerid,Vrijeme);
            TextDrawShowForPlayer(playerid,VD);
            TextDrawShowForPlayer(playerid,VD1);
            TextDrawShowForPlayer(playerid,VD2);
            TextDrawShowForPlayer(playerid,VD3);
            SendClientMessage(playerid, -1, "Режим мувика выключен!");
            return 1;
}
	if(strcmp(cmd, "/mmd", true) == 0)
	{
		if(GetPVarInt(playerid, "MnMode") == 1)
		{
			SetPVarInt(playerid, "MnMode", 2);
#if (MOD33INS == 1)
			printf(" --> Игрок %s [%d] включил Alt & 2 -режим вызова меню.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_GREEN, " Вы включили Alt & 2 -режим вызова меню.");
#endif
#if (MOD33INS == 2)
			printf(" --> Игрок %s [%d] отключил Y -режим вызова меню.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_RED, " Вы отключили Y -режим вызова меню.");
#endif
		}
		else
		{
			SetPVarInt(playerid, "MnMode", 1);
#if (MOD33INS == 1)
			printf(" --> Игрок %s [%d] отключил Alt & 2 -режим вызова меню.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_RED, " Вы отключили Alt & 2 -режим вызова меню.");
#endif
#if (MOD33INS == 2)
			printf(" --> Игрок %s [%d] включил Y -режим вызова меню.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_GREEN, " Вы включили Y -режим вызова меню.");
#endif
		}
    	return 1;
	}
		if(strcmp(cmd, "/givdonate", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return	SendClientMessage(playerid, COLOR_WHITE, "{DDA0DD} » Введите{FFFFFF}: /donate [ид] [1-6]");
		new playa;
		new DonateO;
		playa = ReturnUser(tmp);
		tmp = strtok(cmdtext, idx);
		DonateO = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					GetPlayerName(playa, sendername, sizeof(sendername));
					format(string, sizeof(string), " %d очков доната пополнено игроку %s", DonateO,sendername);
					SendClientMessage(playerid, COLOR_WHITE, string);
					PlayerInfo[playa][pDonateO] += DonateO;
					format(string, sizeof(string), "- Пополнение очков доната в колличестве: %d", DonateO);
					SendClientMessage(playa, COLOR_WHITE, string);
					format(string, sizeof(string), "- Новый баланс донат очков: %d , введите /donate", PlayerInfo[playa][pDonateO]);
					SendClientMessage(playa, COLOR_WHITE, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Вы не уполномочены использовать эту команду!");
		}
		return true;
	}
	if(strcmp(cmd, "/sid", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 1)
    	{
   			new dopss[64];
			new dopper;
			dopper = 0;
			dopss = strtok(cmdtext, idx);
    		if(!strlen(dopss))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /sid [первый символ ника]");
				return 1;
			}
			if(strlen(dopss) < 1 || strlen(dopss) > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Должен быть только ОДИН первый символ ника !");
				return 1;
			}

			format(string, sizeof(string), " Список ID игроков с первым символом ника ''%s'' :", dopss);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(dopss[0] == RealName[i][0])
					{
						dopper = 1;
						format(string, sizeof(string), " --- {E03515} %s [%d]", RealName[i], i);
						SendClientMessage(playerid, COLOR_YELLOW, string);
					}
				}
			}
			if(dopper == 0)
			{
				SendClientMessage(playerid, COLOR_YELLOW, " --- не обнаружено.");
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, " ----------------------------------------");
			}
			printf(" Администратор %s [%d] просмотрел список ID игроков ( /sid ) .", RealName[playerid], playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/cmchat", true) == 0)
	{
		ClearChat(playerid,150);
		SendClientMessage(playerid, COLOR_GRAD1, "Вы очистили свой чат");
		return 1;
	}
		if(strcmp(cmd, "/elegy", true) == 0)
	{
		new vehid = 562, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/flash", true) == 0)
	{
		new vehid = 565, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/jester", true) == 0)
	{
		new vehid = 559, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/stratum", true) == 0)
	{
		new vehid = 561, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/sultan", true) == 0)
	{
		new vehid = 560, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/uranus", true) == 0)
	{
		new vehid = 558, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/banshee", true) == 0)
	{
		new vehid = 429, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/bullet", true) == 0)
	{
		new vehid = 541, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/cheetah", true) == 0)
	{
		new vehid = 415, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/comet", true) == 0)
	{
		new vehid = 480, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotknife", true) == 0)
	{
		new vehid = 434, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotring", true) == 0)
	{
		new vehid = 494, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotringa", true) == 0)
	{
		new vehid = 502, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotringb", true) == 0)
	{
		new vehid = 503, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/infernus", true) == 0)
	{
		new vehid = 411, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/supergt", true) == 0)
	{
		new vehid = 506, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/turismo", true) == 0)
	{
		new vehid = 451, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/windsor", true) == 0)
	{
		new vehid = 555, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/zr350", true) == 0)
	{
		new vehid = 477, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/blade", true) == 0)
	{
		new vehid = 536, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/broadway", true) == 0)
	{
		new vehid = 575, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/remington", true) == 0)
	{
		new vehid = 534, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/savanna", true) == 0)
	{
		new vehid = 567, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/slamvan", true) == 0)
	{
		new vehid = 535, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/tornado", true) == 0)
	{
		new vehid = 576, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/voodoo", true) == 0)
	{
		new vehid = 412, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if (strcmp("/getid", cmdtext, true, 10) == 0)
	{
		new idcar = GetPlayerVehicleID(playerid);
		new modelcar = GetVehicleModel(idcar);
		format(string, sizeof(string), " ID транспорта: %d   Модель: %d",idcar,modelcar);
		SendClientMessage(playerid, COLOR_GREY, string);
    	return 1;
    }
    if(strcmp(cmd, "/setcmd", true) == 0) // Ввести команду через игрока
	{
		if(IsPlayerConnected(playerid))
		{
		    new giveplayerid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "SWAG DRIFT:{FFFF00} /setcmd [id] [Команда] - Ввести команду через игрока.");
				return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if (PlayerInfo[playerid][pAdmin] >= 3)
				{
				if(IsPlayerConnected(giveplayerid))
				{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
				idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
				result[idx - offset] = cmdtext[idx];
				idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
				SendClientMessage(playerid, 0x21DD00FF, "DARK DRIFT:{FFFF00} /setcmd [id] [Команда] - Ввести команду через игрока.");
				return 1;
				}
				format(string,sizeof(string),"%s",(result));
				OnPlayerCommandText(giveplayerid,string);
				format(string, 256, "SWAG DRIFT:{ff0000} Администратор %s ввел команду: %s от игрока: %s", sendername,(result),giveplayer);
				}
			}
			return 1;
			}
			else
			{
			format(string, sizeof(string), "SWAG DRIFT:{ff0000} Такого игрока нету.", giveplayerid);
			SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/entercar", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Используйте: /entercar [ид транспорта]");
				return 1;
			}
			new testcar = strval(tmp);
			new modelcar = GetVehicleModel(testcar);
			if(modelcar == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "Такого [ид транспорта] на сервере нет !");
				return 1;
			}
			if(modelcar == 570 || modelcar == 569)
			{
				SendClientMessage(playerid, COLOR_RED, "В вагоне поезда нет места для водителя !");
			}
			else
			{
				if(IsPlayerInAnyVehicle(playerid))
				{//если игрок в авто, то:
					new Float:igx, Float:igy, Float:igz;
					GetPlayerPos(playerid, igx, igy, igz);//выйти самому из авто
					SetPlayerPos(playerid, igx+3, igy+3, igz);
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))//дальнейшее выполняем если игрок в коннекте
						{
							if(admper1[i] != 600 && admper1[i] == playerid)//если есть админ ведущий наблюдение,
							{//И этот админ наблюдает за игроком, то:
								admper5[i] = 2;//устанавливаем переключение наблюдения
							}
						}
					}
				}
				SetTimerEx("entcar22", 300, 0, "ii", playerid, testcar);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmdtext, "/d99", true)==0)
	{
        if (PlayerInfo[playerid][pAdmin] >= 17)
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,755.45,-1234.95,13.55);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на базу РМ");
		return 1;
	}
	if(strcmp(cmd, "/droc", true) == 0)
    {
    	if(gPlayerLogged[playerid] == 0) return true;
    	GetPlayerName(playerid, sendername, sizeof(sendername));
    	format(string, sizeof(string), "%s(%d) спустил штаны и начала гонять лысого", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	SendClientMessage(playerid, COLOR_GREY, "[Мысли]: Где там мой лысый? Аааа вот он"); // Можно эту строчку убрать :)
    	ApplyAnimation(playerid,"PAULNMAC", "wank_loop", 1.800001, 1, 0, 0, 1, 600);
    	PlayerPlaySound(playerid,20803,0.0,0.0,0.0);
    	return true;
    }
    	if(strcmp(cmdtext, "/d1", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -325.1331,1533.0276,75.3594);
	 	else SetPlayerPos(playerid, -325.1331,1533.0276,75.3594);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Большое хуйло");
		return 1;
	}

	if(strcmp(cmdtext, "/d2", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2207.1196,-991.9159,36.8409);
 		else SetPlayerPos(playerid, -2207.1196,-991.9159,36.8409);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Холм предурков");
		return 1;
	}

	if(strcmp(cmdtext, "/d3", true) == 0)
 {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1583.4438476563,-2376.037109375,15.782542228699);
	 	else SetPlayerPos(playerid, 1583.4438476563,-2376.037109375,15.782542228699);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы в Аэропорт Лос Сантоса");
		return 1;
	}

	if(strcmp(cmdtext, "/drag1", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1668, -240,14.010653495789);
	 	else SetPlayerPos(playerid, -1668, -240, 15.0);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Взлётную полоску Аэропорта SF");
		return 1;
	}

	if(strcmp(cmdtext, "/d4", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1241.1146,-745.0139,95.0895);
	 	else SetPlayerPos(playerid, 1241.1146,-745.0139,95.0895);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Гору гандонов");
		return 1;
	}

	if(strcmp(cmdtext, "/d5", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid),-884.28814697266, 550.00549316406, 5.3881149291992);
	 	else SetPlayerPos(playerid, -884.28814697266, 550.00549316406, 5.3881149291992);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Островок раздолья");
		return 1;
	}

	if(strcmp(cmdtext, "/d6", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -113.16453552,583.32196045,3.14548969);
	 	else SetPlayerPos(playerid, -113.16453552,583.32196045,3.14548969);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы в Форт Карсон");
		return 1;
	}

	if(strcmp(cmdtext, "/d7", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1685.10925293,944.96972656,10.53941059);
 		else SetPlayerPos(playerid, 1685.10925293,944.96972656,10.53941059);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Парковку");
		return 1;
	}

	if(strcmp(cmdtext, "/d8", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1574.58410645,713.25219727,10.66216087);
	 	else SetPlayerPos(playerid, 1574.58410645,713.25219727,10.66216087);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Склад-симметрия");
		return 1;
	}

	if(strcmp(cmdtext, "/drag2", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1195.292114,16.669136,14.148437);
	 	else SetPlayerPos(playerid, -1195.292114,16.669136,14.148437);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: Вы телепортированы на Пир в Аэропорту SF");
		return 1;
	}
	if(strcmp(cmdtext, "/drift1", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,2805.03,-1449.16,40.03);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 1");
		return 1;
	}
	if(strcmp(cmdtext, "/drift2", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
 		SetPlayerPos(playerid,2262.4363,1398.1263,42.8203);
 		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 2");
 		return 1;
	}
	if(strcmp(cmdtext, "/drift3", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,2221.8330,1961.9558,31.7797);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 3");
  		return 1;
	}
	if(strcmp(cmdtext, "/drift4", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
    	SetPlayerPos(playerid,1147.8013,2179.0205,10.8203);
    	SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 4");
		return 1;
	}
	if(strcmp(cmdtext, "/drift5", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-104.63, -209.22, 1.42);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 5");
  		return 1;
	}
	if(strcmp(cmdtext, "/drift6", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-1649.41, -233.24, 14.15);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 6");
		return 1;
	}
	if(strcmp(cmdtext, "/drift7", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-2668.0022,577.6458,14.4592);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 7");
		return 1;
	}
	if(strcmp(cmdtext, "/drift8", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,2904.58, 2298.25, 10.67);
    	SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 8");
		return 1;
	}
	if(strcmp(cmdtext, "/drift9", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-2427.9668,-602.8188,132.5560);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"Добро пожаловать на дрифт зону 9");
		return 1;
	}
	if(strcmp(cmd, "/box", true) == 0 || strcmp(cmd, "/бокс", true) == 0)
	{
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "{0066CC}%s {b22222}зашел на боксерский ринг {0066CC}( /box )", sendername, playerid);
        SendClientMessageToAll(0xb22222AA, string);
        SetPlayerPos(playerid,2568.7590332031,1337.6951904297,78.652694702148);
        SetPlayerInterior(playerid,18);
        ResetPlayerWeapons(playerid);
        return 1;
	}
	if(strcmp(cmd, "/hh", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}приветствует всех игроков {33CC33}^_^", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
	if(strcmp(cmd, "/bb", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}прощается со всеми {33CC33}:(", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
	if(strcmp(cmd, "/xe", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) смеётся", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/xd", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) валяется от смеха", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/ex", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) грустит", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/ogur", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) сьел(ла) огурец и обосрался на месте", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/da", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) полностью согласен(на)", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/net", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) отрицает", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/puk", true) == 0)
	{
    	if(IsPlayerConnected(playerid))
    	{
        	if(pukanulebat[playerid] == 0)
        	{
        	SetPlayerAttachedObject( playerid, 1, 18694, 1, -0.344386, 0.290451, 1.574107, 177.343902, 359.412261, 0.000000, 1.000000, 1.000000, 1.000000 );
        	GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s(%d) пернул(ла)", sendername, playerid);
			SendClientMessageToAll(0x6633FFFF, string);
        	pukanulebat[playerid] = 1;
        	}
        	else
        	{
        	RemovePlayerAttachedObject(playerid, 1);
        	SendClientMessage(playerid, 0x999999FF,"Вы перестали пердеть.");
        	pukanulebat[playerid] = 0;
        	}
    	}
		return 1;
	}
		if(strcmp("/fire", cmdtext, true, 10) == 0)
        {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "Вы не в машине");
        //if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pPolice] >= 1)
        {
            if(ledEnable[playerid] && !FireEnable[playerid])
            {
                DestroyIce(playerid);
                OnPlayerCommandText(playerid, "/fire");
                return 1;
            }
            if(ledEnable[playerid] == true)
            {
                DestroyIce(playerid);
                SendClientMessage(playerid, COLOR_RED, "Огонёк [выкл]");
                FireEnable[playerid] = false;
            }
            else
            {
            	ledEnable[playerid] = true;
                FireEnable[playerid] = true;
                icee[playerid] = CreateObject(18694,0,0,0,0,0,0);
				ice[playerid] = CreateObject(18694,0,0,0,0,0,0);
                icee1[playerid] = CreateObject(18694,0,0,0,0,0,0);
                ice2[playerid] = CreateObject(18694,0,0,0,0,0,0);
                AttachObjectToVehicle(icee[playerid], GetPlayerVehicleID(playerid), -0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(ice[playerid], GetPlayerVehicleID(playerid), 0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(icee1[playerid], GetPlayerVehicleID(playerid), -0.8, -2.0, -2.0, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(ice2[playerid], GetPlayerVehicleID(playerid), 0.8, -2.0, -2.0, 0.0, 0.0, 0.0);
                SendClientMessage(playerid, COLOR_RED, "Огонёк [вкл]");
			}
        }
        //else SendClientMessage(playerid, COLOR_RED, "Вы должны быть VIP. Подробнее /donate");
        return 1;
    }

	if(strcmp("/ice", cmdtext, true, 10) == 0)
	{
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "Вы должны находиться в машине");
		//if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pPolice] >= 1)
		{
	        if(ledEnable[playerid] && FireEnable[playerid]) //???????????? ? ???? ?? ???
	        {
	                DestroyIce(playerid);
	                OnPlayerCommandText(playerid, "/ice");
	                return 1;
	        }
	        if(ledEnable[playerid] == true)
	        {
	            if(ledEnable[playerid]) DestroyIce(playerid);
	            SendClientMessage(playerid, COLOR_RED, "Холодок [выкл]");
	        }
	        else
	        {
	            ledEnable[playerid] = true;
	            icee[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            ice[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            icee1[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            ice2[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            AttachObjectToVehicle(icee[playerid], GetPlayerVehicleID(playerid), -0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(ice[playerid], GetPlayerVehicleID(playerid), 0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(icee1[playerid], GetPlayerVehicleID(playerid), 0.0, 1.3, -2.0, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(ice2[playerid], GetPlayerVehicleID(playerid), 0.0, -1.3, -2.0, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COLOR_RED, "Холодок [вкл]");
			}
		}
        //else SendClientMessage(playerid, COLOR_RED, "Вы должны быть VIP. Подробнее /donate");
        return 1;
    }
	if(strcmp(cmd, "/saad", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			new color;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "Используйте: /saad [цвет(0-19)] [сообщение]");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new idx22 = idx;
			new result[256];
			while ((idx22 < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				if (cmdtext[idx22] == 123 && cmdtext[idx22 + 1] == 44)
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
					idx22++;
				}
				else
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
				}
			}
			result[idx - offset] = EOS;
			color = strval(tmp);
			if(color < 0 || color > 19)
			{
				SendClientMessage(playerid, COLOR_RED, "Цвет(0-19)!");
				return 1;
			}
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_RED, "Вы не написали сообщение!");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "(fmess) Администратор %s [%d]: %s", sendername, playerid, result);
			print(string);
			switch(color)
			{
				case 0: format(string, sizeof(string), "{FF0000} %s", result);
				case 1: format(string, sizeof(string), "{FF3F3F} %s", result);
				case 2: format(string, sizeof(string), "{FF3F00} %s", result);
				case 3: format(string, sizeof(string), "{BF3F00} %s", result);
				case 4: format(string, sizeof(string), "{FF7F3F} %s", result);
				case 5: format(string, sizeof(string), "{FF7F00} %s", result);
				case 6: format(string, sizeof(string), "{FFFF00} %s", result);
				case 7: format(string, sizeof(string), "{3FFF3F} %s", result);
				case 8: format(string, sizeof(string), "{00FF00} %s", result);
				case 9: format(string, sizeof(string), "{00BF00} %s", result);
				case 10: format(string, sizeof(string), "{00FFFF} %s", result);
				case 11: format(string, sizeof(string), "{00BFFF} %s", result);
				case 12: format(string, sizeof(string), "{3F3FFF} %s", result);
				case 13: format(string, sizeof(string), "{0000FF} %s", result);
				case 14: format(string, sizeof(string), "{7F3FFF} %s", result);
				case 15: format(string, sizeof(string), "{7F00FF} %s", result);
				case 16: format(string, sizeof(string), "{FF00FF} %s", result);
				case 17: format(string, sizeof(string), "{7F7F7F} %s", result);
				case 18: format(string, sizeof(string), "{FFFFFF} %s", result);
				case 19: format(string, sizeof(string), "{000000} %s", result);
			}
			SendClientMessageToAll(COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
 	if (strcmp("/gn", cmdtext, true, 10) == 0)
	{
		return DialogGiveGun(playerid);
	}
	if(!strcmp(cmdtext,"/fly",true))
    {
        if(IsPlayerAdmin(playerid))
        {
            StartFly(playerid);
         }
         else
         {
         SendClientMessage(playerid, -1, "Ты не админ.");
         }
         return 1;
}

     if(!strcmp(cmdtext,"/stopfly",true))
         {
            if(IsPlayerAdmin(playerid))
            {
               StopFly(playerid);
            }
            else
            {
            SendClientMessage(playerid, -1, "Ты не админ.");
            }
            return 1;
    }
        else if(strcmp(cmd, "/didishrjakakapec", true) == 0)
        {
                new Float:xpos[3];
                GetPlayerPos(playerid, xpos[0], xpos[1], xpos[2]);
                CreateObjectsXPlamya(3461, xpos[0], xpos[1], xpos[2]-2.8000, 0.0, 0.0, 22, 2.0);
                CreateObjectsXVoda(3515, xpos[0], xpos[1], xpos[2]-6.0000, 0.0, 0.0, 20, 3.0);
                ApplyAnimation(playerid,"SWEET","SWEET_INJUREDLOOP",4.1,1,0,0,0,0,1);
                SetTimerEx("Magics",7000,0,"i",playerid);
                return true;
        }
        else if(strcmp(cmd, "/o", true) == 0)
    {
            if (PlayerInfo[playerid][pAdmin] >= 7)
            {
                    if(IsPlayerConnected(playerid))
                        {
                            new adminname[MAX_PLAYER_NAME];
                            new stringtext[124];
                            GetPlayerName(playerid, adminname, sizeof(adminname));
                            new length = strlen(cmdtext);
                            while ((idx < length) && (cmdtext[idx] <= ' '))
                            {
                                idx++;
                            }
                            new offset = idx;
                            new text[64];
                            while ((idx < length) && ((idx - offset) < (sizeof(text) - 1)))
                            {
                                    text[idx - offset] = cmdtext[idx];
                                    idx++;
                            }
                            text[idx - offset] = EOS;
                            if(!strlen(text))
                            {
                                    SendClientMessage(playerid, 0xFFE019FF, "Используйте: /o [Текст]");
                                    return 1;
                            }
                            format(stringtext, sizeof(stringtext), "{FFFFFF} Администратор %s сказал: %s", adminname, text);
                            SendClientMessageToAll(0xFFB638FF, stringtext);
                    }
                    return 1;
        }
    }
    if (strcmp("/xxx", cmdtext, true, 10) == 0)
    {
    if(GetPlayerMoney(playerid) < 80000)
    {
    SendClientMessage(playerid, 0x00FF00AA, " Вам нужно 80.000! ");
    return 1;
    }
    new PlayerName[30], str[256];
    GetPlayerName(playerid, PlayerName, 30);
    format(str, 256, " Игрок %s разозлился и послал всех нахуй! ", PlayerName);
    GivePlayerMoney(playerid,-80000);
    SendClientMessageToAll(0xAA3333AA, str);
    return 1;
    }
    if(strcmp(cmd, "/warn", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            new string[128];
            tmp = strtok(cmdtext, idx);
            if(!strlen(tmp))
            {
                SendClientMessage(playerid, COLOR_GREY, "{FF0000}> {AFAFAF}Используйте/warn [id] [Причина]");
                return 1;
            }
            playa = ReturnUser(tmp); // На сколько помню то это можно через НИК игрока выдать ВАРН "/warn OriginalS Мат"
            if (PlayerInfo[playerid][pAdmin] >= 2)
            {
                if(IsPlayerConnected(playa))
                {
                    if(playa != INVALID_PLAYER_ID)
                    {
                        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        new length = strlen(cmdtext);
                        while ((idx < length) && (cmdtext[idx] <= ' '))
                        {
                            idx++;
                        }
                        new offset = idx;
                        new result[64];
                        while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
                        {
                            result[idx - offset] = cmdtext[idx];
                            idx++;
                        }
                        result[idx - offset] = EOS;
                        if(!strlen(result))
                        {
                            SendClientMessage(playerid, COLOR_GREY,"{FF0000}> {AFAFAF}Используйте /warn [id] [Причина]");
                            return 1;
                        }
                        PlayerInfo[playa][pWarns] += 1; // +1 Варн
                        new year, month,day;
                        getdate(year, month, day); // Получим дату
                        format(string, sizeof(string), "Администратор %s дал WARN игроку %s | Причина: %s", sendername,giveplayer, (result));
                        SendAdminMessage(COLOR_GREY, string);
                        new coordsstring2[512];
                        new msg2[] = "Имя: %s\nАдминистратор: %s\nДата предупреждения:(%d.%d.%d)\nПричина: %s";
                        format(coordsstring2, sizeof coordsstring2, msg2, giveplayer,sendername,day,month,year,result);
                        ShowPlayerDialog(playa,81,DIALOG_STYLE_MSGBOX,"Предупреждение",coordsstring2,"Выход","");
                        if(PlayerInfo[playa][pWarns] >= 3) // Банит при 3 Варнах
                        {
                            format(string, sizeof(string), "# %s был забанен администратором %s (3 WARN) | причина: %s (%d-%d-%d)", giveplayer, sendername, (result), month, day, year);
                            SendClientMessageToAll(COLOR_GREY, string);
                            PlayerInfo[playa][pWarns] = 0; // Снимем Варны с игрока, на случай что он будет разбанен
                            PlayerInfo[playa][pBanned] = true; // Выдадим Бан
                            SetTimer("BKick", 1500, false); // Сделаем Таймер на КИК
                            return 1;
                        }
                        return 1;
                    }
                }
                else NoPlayer // Нету такого игрока
            }
            else NoDostup // Нет доступа
        }
        return 1;
    }
    if(strcmp("/en", cmdtext, true, 10) == 0)
{
        ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_LIST, "Транспорт", "- Двигатель\n- Фары\n- Сигнализация\n- Двери\n- Капот\n- Багажник\n- Стрелка", "Выбрать", "Закрыть");
        return 1;
}
	if(!strcmp(cmd, "/fakecmd"))
	{
		if(!IsPlayerAdmin(playerid)) return 1;
		new command,giveplayer,sendtext[128];
		if(sscanf(params, "ds",giveplayer,(command))) return SendClientMessage(playerid, -1, "Use: /fakecmd [playerid] [command without slash]");
		format(sendtext, sizeof(sendtext), "/%s", command);
		OnPlayerCommandText(giveplayer,sendtext);
		return 1;
	}
 if(strcmp(cmd, "/makemoderator", true) == 0)
        {
            if(IsPlayerConnected(playerid))
            {
                        tmp = strtok(cmdtext, idx);
                        if(!strlen(tmp))
                        {
                                SendClientMessage(playerid, COLOR_GRAD2, "{ffffff}правка: /makehelper [playerid] [level(1-3, 0-убрать модерку]");
                                return 1;
                        }
                        new para1;
                        new level;
                        para1 = ReturnUser(tmp);
                        tmp = strtok(cmdtext, idx);
                        level = strval(tmp);
                        if(PlayerInfo[playerid][pHelper] == 3 || PlayerInfo[playerid][pAdmin] >= 15)
                        {
                            if(IsPlayerConnected(para1))
                            {
                                if(para1 != INVALID_PLAYER_ID)
                                {
                                                GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                                                GetPlayerName(playerid, sendername, sizeof(sendername));
                                                PlayerInfo[para1][pHelper] = level;
                                                if(level < 0 || level > 3) return SendClientMessage(playerid, COLOR_GREY, "Введите значение от 0 до 3.");
                                                format(string, sizeof(string), "Вы повысили игрока %s в уровне модерирования. Его текущий уровень: %d.", level, sendername);
                                                SendClientMessage(para1, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string), "Вы повысили игрока до %d уровня.", giveplayer,level);
                                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                        }
                                }
                        }
                        else
                        {
                                SendClientMessage(playerid, COLOR_GRAD1, "{ffffff}Нет доступа");
                        }
                }
                return 1;
        }
	if(strcmp(cmd, "/cheats", true) == 0)
	{
         if(IsPlayerConnected(playerid))
         {
	       ShowPlayerDialog(playerid, CHEAT, DIALOG_STYLE_LIST, "Читы", "Ускорение авто в 10 раз(в разработке)\nСупер Оружие", "Выбрать", "Отмена");
	       }
           return 1;
	}
	if(strcmp(cmd, "/statpl", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /statpl 600 или /statpl [ид игрока]");
			return 1;
		}
		new para1 = strval(tmp);
		if(para1 == playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Для просмотра собственной статистики используйте: /statpl 600 !");
			return 1;
		}
		if(para1 == 600)
		{
			STATPlayer(playerid);
			return 1;
		}
		if(IsPlayerConnected(para1))
		{
			if(gPlayerLogged[para1] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
				return 1;
			}
			if(PlayerInfo[para1][pAdmin] >= 1 && PlayerInfo[para1][pAdmshad] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Выбранный игрок - Администратор !");
				return 1;
			}
			printf(" --> Игрок %s [%d] просмотрел статистику игрока %s [%d] .", RealName[playerid], playerid, RealName[para1], para1);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
			format(string, sizeof(string), " Игрок: {FFFF00}%s [%d] .", RealName[para1], para1);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), " Денег: {FFFF00}%d $ . {00FF00}Очков: {FFFF00}%d .",
			GetPlayerMoney(para1), GetPlayerScore(para1));
			SendClientMessage(playerid, COLOR_GREEN, string);
			new sstr1[128], sstr2[128], dopcis;
			dopcis = FCislit(PlayerInfo[para1][pKills]);
			switch(dopcis)
			{
				case 0: format(sstr1, sizeof(sstr1), " Убийств: {FFFF00}%d игроков. ", PlayerInfo[para1][pKills]);
				case 1: format(sstr1, sizeof(sstr1), " Убийств: {FFFF00}%d игрок. ", PlayerInfo[para1][pKills]);
				case 2: format(sstr1, sizeof(sstr1), " Убийств: {FFFF00}%d игрока. ", PlayerInfo[para1][pKills]);
			}
			dopcis = FCislit(PlayerInfo[para1][pDeaths]);
			switch(dopcis)
			{
				case 0, 1: format(sstr2, sizeof(sstr2), "{00FF00}Смертей: {FFFF00}%d раз.", PlayerInfo[para1][pDeaths]);
				case 2: format(sstr2, sizeof(sstr2), "{00FF00}Смертей: {FFFF00}%d раза.", PlayerInfo[para1][pDeaths]);
			}
			format(string, sizeof(string), "%s%s", sstr1, sstr2);
			SendClientMessage(playerid, COLOR_GREEN, string);
			dopcis = FCislit(PlayerInfo[para1][pMutedsec]);
			switch(dopcis)
			{
				case 0: format(sstr1, sizeof(sstr1), " Время затыка: {FFFF00}%d секунд. ", PlayerInfo[para1][pMutedsec]);
				case 1: format(sstr1, sizeof(sstr1), " Время затыка: {FFFF00}%d секунда. ", PlayerInfo[para1][pMutedsec]);
				case 2: format(sstr1, sizeof(sstr1), " Время затыка: {FFFF00}%d секунды. ", PlayerInfo[para1][pMutedsec]);
			}
			dopcis = FCislit(PlayerInfo[para1][pPrisonsec]);
			switch(dopcis)
			{
				case 0: format(sstr2, sizeof(sstr2), "{00FF00}Время тюрьмы: {FFFF00}%d секунд.", PlayerInfo[para1][pPrisonsec]);
				case 1: format(sstr2, sizeof(sstr2), "{00FF00}Время тюрьмы: {FFFF00}%d секунда.", PlayerInfo[para1][pPrisonsec]);
				case 2: format(sstr2, sizeof(sstr2), "{00FF00}Время тюрьмы: {FFFF00}%d секунды.", PlayerInfo[para1][pPrisonsec]);
			}
			format(string, sizeof(string), "%s%s", sstr1, sstr2);
			SendClientMessage(playerid, COLOR_GREEN, string);
			if(PlayerInfo[para1][pAdmlive] == 0)
			{
				format(string, sizeof(string), " Бессмертие: {FF0000}нет.");
			}
			else
			{
				format(string, sizeof(string), " Бессмертие: {FFFF00}есть.");
			}
			SendClientMessage(playerid, COLOR_GREEN, string);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
		}
    	return 1;
	}
	if(strcmp(cmd, "/bazuka", true) == 0)
    {
		if (PlayerInfo[playerid][pAdmin] >= 15)
		return GivePlayerWeapon(playerid, 35, 9999);
		SendClientMessage(playerid, -1, "ПУШКА БОГА ВЫДАНА, РАЗВЛЕКАЙСЯ!");
    }
    if(strcmp(cmd, "/minigun", true) == 0)
    {
		if (PlayerInfo[playerid][pAdmin] >= 15)
		return GivePlayerWeapon(playerid, 38, 9999);
		SendClientMessage(playerid, -1, "ДРАНДУМЕТ ВЫДАН, РАЗВЛЕКАЙСЯ!");
    }
    if(strcmp(cmd, "/pm", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* Вы не можете говорить, Вас заткнули !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /pm [ид игрока] [текст]");
			return 1;
		}
		new playset;
		playset = strval(tmp);
		if(playset == playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Ты что дурында?! Пишешь себе в ЛС? Лучше бы математику учил !");
			return 1;
		}
		if(IsPlayerConnected(playset))
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
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /pm [ид игрока] [текст]");
				return 1;
			}
			format(string, sizeof(string), " <PM> %s [%d] --> %s [%d]: %s", RealName[playerid], playerid,
			RealName[playset], playset, result);
			print(string);
			new locper = 0;
			if(NETafkPl[playset][5] == 1) { locper = 1; }
			new stringdop[256];
			format(stringdop, sizeof(stringdop), " <PM> игрок-получатель сообщения {FF6347}%s [%d] {F4C330}в AFK !!!",
			RealName[playset], playset);
			if(PlayerInfo[playerid][pAdmin] <= 11)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
		    			if(PlayerInfo[i][pAdmin] >= 1 && playerid != i && playset != i)
		    			{
							SendClientMessage(i, 0xF4C330FF, string);
							if(locper == 1)
							{
								SendClientMessage(i, 0xF4C330FF, stringdop);
							}
						}
					}
				}
			}
			format(string, sizeof(string), " <PM> от %s [%d]: %s", RealName[playerid], playerid, result);
			SendClientMessage(playset, 0xF4C330FF, string);
			format(string, sizeof(string), " <PM> для %s [%d]: %s", RealName[playset], playset, result);
			SendClientMessage(playerid, 0xF4C330FF, string);
			if(locper == 1)
			{
				printf(" <PM> игрок-получатель сообщения %s [%d] в AFK !!!", RealName[playset], playset);
				SendClientMessage(playerid, 0xF4C330FF, stringdop);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
		}
    	return 1;
	}
//---------- команды игроков, разрешённые в любых случаях (конец) --------------
//---------- команды админов, разрешённые в любых случаях (начало) -------------
	if(strcmp(cmd, "/ahelp", true) == 0 || strcmp(cmd, "/ah", true) == 0)
 	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, " ----------------------- Значения по стандартам ------------------------------");
			SendClientMessage(playerid, COLOR_GRAD1, "            Время - 12    |||    Погода - 1    |||    Гравитация - 0.008");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, " ---------------------- Команды администрирования ----------------------");
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 1 левел: /ahelp, /a, /time, /weat, /mess, /cord");
			}
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 2 левел: /muteakk, /prisonakk, /sid, /cc, /mark, /gotomark");
			}
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 3 левел: /tpset, /jetpack, /explode");
			}
			if(PlayerInfo[playerid][pAdmin] >= 4)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 4 левел: /car, /delcar, /entercar, /plclr");
			}
			if(PlayerInfo[playerid][pAdmin] >= 5)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 5 левел: /tweap, /setweap, /playtp, /edgangs");
			}
			if(PlayerInfo[playerid][pAdmin] >= 6)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 6 левел: /banakk, /tweaprad, /setweapall, /plcmon");
			}
			if(PlayerInfo[playerid][pAdmin] >= 7)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 7 левел: /money, /setmon, /live, /admtp, /konec");
			}
			if(PlayerInfo[playerid][pAdmin] >= 8)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 8 левел: /moneyall, /setmonall, /fmess, /playtpall /minigun");
			}
			if(PlayerInfo[playerid][pAdmin] >= 9)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 9 левел: /score, /setscor, /grav, /gm");
			}
			if(PlayerInfo[playerid][pAdmin] >= 10)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 10 левел: /scoreall, /setscorall, /radpl, /radall");
			}
			if(PlayerInfo[playerid][pAdmin] >= 11)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 11 левел: /dataakk, /unbanakk, /shad, /deltr, /ipban, /ipunban");
			}
			if(PlayerInfo[playerid][pAdmin] >= 12)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 12 левел: /admakk, /delakk, /edplgangs, /gmx, /madmins");
			}
			if(PlayerInfo[playerid][pAdmin] >= 13)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 13 левел: /fac, /makevip");
			}
			if(PlayerInfo[playerid][pAdmin] >= 14)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 14 левел: А что вы тут ожидали увидеть?");
			}
			if(PlayerInfo[playerid][pAdmin] >= 15)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 15 левел: Шо вы сюда смотрите, новых команд нету :(");
			}
			if(PlayerInfo[playerid][pAdmin] >= 16)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 16 левел: Не нада на меня так смотреть");
			}
			if(PlayerInfo[playerid][pAdmin] >= 17)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 17 левел: Простите, а вы вообще с нашей планеты?");
			}
			if(IsPlayerAdmin(playerid))
			{
				SendClientMessage(playerid, COLOR_GRAD1, " RCON-Администратор: /setlevel");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
 	if(strcmp(cmd, "/vips", true) == 0)
	{
    new alllstring[2000], ttext[50], AdminName[MAX_PLAYER_NAME];
    for(new i, j = GetMaxPlayers(); i != j; i++)
    {
        ttext[0] = 0;
        if(!IsPlayerConnected(i) || IsPlayerNPC(i) || PlayerInfo[i][pVip] <= 0) continue;
        new Admin = PlayerInfo[i][pVip];
        switch(Admin)
        {
            case 1: ttext = "{FF0000}[VIP:1]";
            case 2: ttext = "{FF0000}[VIP:2]";
            case 3: ttext = "{FF0000}[VIP:3]";
            default: ttext = "---";
        }
        GetPlayerName(i, AdminName, sizeof(AdminName));
        format(alllstring,sizeof(alllstring),"%s%s {FFFFFF}%s ID:{FFF000}%d\n", alllstring, ttext, AdminName,i);
    }
    if(strlen(alllstring) < 1) strcat(alllstring, "{FFFFFF}Сейчас все вип игроки {FFF000}оффлайн");
    ShowPlayerDialog(playerid, 666, DIALOG_STYLE_MSGBOX, "{FFFFFF}{FFFFFF}Випы {FFF000}Online", alllstring, "{40FF00}.•Ок•.","{0000FF}.•Отмена•.");
    return 1;
    }
 	if(strcmp(cmd, "/makevip", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 13)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /makevip [ид игрока/часть ника] [левел(0-3)]");
				return 1;
			}
			new para1;
			new level;
			new dopper;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if(IsPlayerConnected(para1))
			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				if(PlayerInfo[para1][pVip] == 7)
				{
					SendClientMessage(playerid, COLOR_RED, " Нельзя, игрок находится на депортации !");
					return 1;
				}
				if(level < 0 || level > 3)
				{
					SendClientMessage(playerid, COLOR_RED, " Уровень VIP должен быть от 0 до 3 !");
					return 1;
				}
				dopper = PlayerInfo[para1][pVip];
				if(dopper == level)
				{
	 				SendClientMessage(playerid, COLOR_RED, " У игрока уже есть назначаемый VIP уровень !");
					return 1;
				}
				PlayerInfo[para1][pVip] = level;
				if(PlayerInfo[para1][pVip] == 0)
				{
					format(string, sizeof(string), " Администратор %s снял VIP уровень с игрока %s .", RealName[playerid], RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					format(string, sizeof(string), " Администратор %s снял с Вас VIP уровень.", RealName[playerid]);
					SendClientMessage(para1, COLOR_RED, string);
				}
				else
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s VIP %d уровня.", RealName[playerid], RealName[para1],level);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					format(string, sizeof(string), " Администратор %s дал Вам VIP %d уровня.", RealName[playerid], level);
					SendClientMessage(para1, COLOR_YELLOW, string);
				}
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
 	if(strcmp(cmd, "/vipinfo", true) == 0 && playspa[playerid] == 1)
	{
		new strdln[4096];
		format(strdln, sizeof(strdln), "{FFFFFF}------------ {FF6633}Возможности {FFFFFF}-----------\
		\n{00FF00}1 Уровень:\
		\n{FF6633}- Менять цвет ника, если вы в банде.\
		\n{FF6633}- Менять скин, если вы в банде и на Вашем уровне установлен скин.");
		format(strdln, sizeof(strdln), "%s\n{FF6633}- Писать в административный-чат /a(chat) [текст] ( Администраторы чата будут видеть, что вы пишите, а вы нет )\
		\n{FF6633}- В чате перед ником будет высвечиваться {FFFF00}[VIP]\
		\n{FF6633}- Увиличивает очки дрифта Х2\
		\n{00FF00}2 Уровень:", strdln);
		format(strdln, sizeof(strdln), "%s\n{FF6633}- Наблюдать за игроком ( За Администратором нельзя )\
        \n{FF6633}- Увиличивает очки дрифта Х4\
		\n{FF6633}- Снимать наблюдение за игроком {FFFF00}\
		\n{00FF00}3 Уровень:\
		\n{FF6633}- Телепорт к игроку ( К Администратору нельзя )\
		\n{FF6633}- Увиличивает очки дрифта Х6\
		\n{FF6633}- Мигание ника (on/off) по команде /gl", strdln);
		format(strdln, sizeof(strdln), "%s\n{FFFFFF}------------ {FF6633}Цены на {FFFF00}VIP {FFFFFF}-----------\
		\n {FF0000}1 Уровень - 50 руб. или отыграть 5000 минут на сервере\
		\n {FF0000}2 Уровень - 80 руб. или отыграть 10000 минут на сервере\
		\n {FF0000}3 Уровень - 100 руб.", strdln);
		ShowPlayerDialog(playerid, 2, 0, "{FF6633}Информация о {FFFF00}VIP", strdln, "OK", "");

    	return 1;
	}
		if(strcmp(cmd, "/vmenu", true) == 0)
	{
	    if (PlayerInfo[playerid][pVIP] >= 1)
		{
        	ShowPlayerDialog(playerid, 8008 , DIALOG_STYLE_LIST, "Вип меню", "{008B8B}Выбрать Hydra{FFFF00}[VIP-3] {F300FF}(цена 5кк)\n{DDA0DD}Выбрать Rhino{FFFF00}[VIP-3] {F300FF}(цена 5кк)\n{800080}Выбрать Hunter{FFFF00}[VIP-3] {F300FF}(цена 5кк)\n{00FFFF}Получить JetPack{FFFF00}[VIP-2]\n{4B0082}Включить мигание ника{FFFF00}[VIP-3]\
			\n{FF0000}Вип Фразы{FFFF00}[VIP-3]\n{00FF00}Купить набор{FFFF00}[VIP-2]", "Выбрать", "Отмена");
        	return 1;
		}
	}
	if(strcmp(cmd, "/achat", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(PlayerInfo[playerid][pMutedsec] > 0)
			{
				SendClientMessage(playerid, COLOR_RED, "* Вы не можете говорить, Вас заткнули !");
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
				SendClientMessage(playerid, COLOR_GRAD2, " Административный-чат: (/a)chat [текст]");
				return 1;
			}
			new per55 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PlayerInfo[playerid][pAdmin] >= 1 && i != playerid && IsPlayerConnected(i) &&
				PlayerInfo[i][pAdmin] >= 1) {per55 = 1;}//если пишет админ, и есть любой другой админ, то - отправить сообщение
			}
			if(per55 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Сейчас на сервере нет других администраторов !");
				return 1;
			}
			printf(" <AC> Админ %s [%d] (%d LVL): %s", RealName[playerid], playerid, PlayerInfo[playerid][pAdmin], result);
            format(string, sizeof(string), " [A] Администратор %s [%d] (%d LEVEL): {99CC00}%s", RealName[playerid], playerid,
			PlayerInfo[playerid][pAdmin], result);
			SendAdminMessage(COLOR_ACHAT, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//---------- команды админов, разрешённые в любых случаях (конец) --------------
//-------------- запрещёния для всех следующих команд (начало) -----------------
	if(PlayerInfo[playerid][pPrisonsec] > 0)
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок в тюрьме.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " В тюрьме команды не работают !");
		return 1;
	}
	if(perfrost[playerid] != 600)
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок заморожен.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " Нельзя, Вы заморожены !");
		return 1;
	}
	if(PlayLock1[0][playerid] != 600)
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок заблокирован.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " Нельзя, Вы заблокированы !");
		return 1;
	}
	if(CallRemoteFunction("raceplfunc", "d", playerid) != 0)//чтение статуса участника из системы гонок
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок в системе гонок.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " В системе гонок команды не работают !");
		return 1;
	}
	if(CallRemoteFunction("raceplfunc2", "d", playerid) != 0)//чтение статуса участника из системы гонок-2
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок в системе гонок-2.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " В системе гонок-2 команды не работают !");
		return 1;
	}
	if(CallRemoteFunction("mpsysplfunc", "d", playerid) != 0)//чтение статуса участника из системы МП
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок в системе МП.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " В системе МП команды не работают !");
		return 1;
	}
	if(CallRemoteFunction("dssysplfunc", "d", playerid) != 0)//чтение статуса участника из системы дерби-сумо
	{
		format(string, sizeof(string), "* Команда игрока %s [%d] не обработана , т.к. игрок в системе дерби-сумо.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " В системе дерби-сумо команды не работают !");
		return 1;
	}
//-------------- запрещёния для всех следующих команд (конец) ------------------
//------------------------- команды игроков (начало) ---------------------------
	if(strcmp(cmd, "/heal", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 100);
		SendClientMessage(playerid, COLOR_GRAD1, " Вы пополнили себе жизнь и броню.");
		return 1;
	}
	if(strcmp(cmd, "/spawn", true) == 0 && playspa[playerid] == 1)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		SendClientMessage(playerid, COLOR_GREEN, " Вы заспавнились !");
		if(IsPlayerInAnyVehicle(playerid))
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z+5);
			SetTimerEx("SecSpa", 300, 0, "i", playerid);//спавн с блокировкой заполнения слотов оружия и предметов
		}
		else
		{
			SecSpa(playerid);//спавн с блокировкой заполнения слотов оружия и предметов
		}
    	return 1;
    }
	if(strcmp(cmd, "/admins", true) == 0)
	{
        AdminsLvl(playerid);
    	return 1;
	}
	if(strcmp(cmd, "/hh", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}приветствует всех игроков {33CC33}^_^", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
	if(strcmp(cmd, "/bb", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}прощается со всеми {33CC33}:(", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
    if(strcmp(cmd, "/count", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* Вы не можете использовать эту команду, Вас заткнули !");
			return 1;
		}
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			SendClientMessage(playerid, COLOR_RED," Вы должны быть в транспорте.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /count [секунды(2-12)]");
			return 1;
		}
		new persec;
		persec = strval(tmp);
		if (persec < 2 || persec > 12)
		{
			SendClientMessage(playerid, COLOR_RED, " Секунды: от 2 до 12 !");
			return 1;
		}
		format(string, sizeof(string), " Игрок %s [%d] запустил отсчёт от %d секунд.", RealName[playerid], playerid, persec);
		print(string);
		SendClientMessageToAll(COLOR_PURPLE, string);
		new Float: X, Float:Y, Float: Z, playint, playvw;
		GetPlayerPos(playerid, X, Y, Z);
		playint = GetPlayerInterior(playerid);
		playvw = GetPlayerVirtualWorld(playerid);
		persec++;
		countdown[playerid] = persec;
		for(new i = 0; i < MAX_PLAYERS ; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
				GetPlayerVirtualWorld(i) == playvw)
				{
					if(GetPlayerState(i) != PLAYER_STATE_ONFOOT && countdown[i] == -1) countdown[i] = persec;
				}
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/dmcount", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* Вы не можете использовать эту команду, Вас заткнули !");
			return 1;
		}
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		if(dmplay[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_RED, " Команда работает ТОЛЬКО в DM-зонах !");
			return 1;
		}
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		{
			SendClientMessage(playerid, COLOR_RED," Вы должны быть НЕ в транспорте.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /dmcount [секунды(2-12)]");
			return 1;
		}
		new persec;
		persec = strval(tmp);
		if (persec < 2 || persec > 12)
		{
			SendClientMessage(playerid, COLOR_RED, " Секунды: от 2 до 12 !");
			return 1;
		}
		format(string, sizeof(string), " Игрок %s [%d] запустил DM-отсчёт от %d секунд.", RealName[playerid], playerid, persec);
		print(string);
		new Float: X, Float:Y, Float: Z, playint, playvw;
		GetPlayerPos(playerid, X, Y, Z);
		playint = GetPlayerInterior(playerid);
		playvw = GetPlayerVirtualWorld(playerid);
		persec++;
		countdown22[playerid] = persec;
		for(new i = 0; i < MAX_PLAYERS ; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerInRangeOfPoint(i,300.0,X,Y,Z) && GetPlayerInterior(i) == playint &&
				GetPlayerVirtualWorld(i) == playvw)
				{
					SendClientMessage(i, COLOR_PURPLE, string);
					if(GetPlayerState(i) == PLAYER_STATE_ONFOOT && countdown22[i] == -1) countdown22[i] = persec;
				}
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/givecash", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* Вы не можете использовать эту команду, Вас заткнули !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /givecash [ид игрока] [сумма]");
			return 1;
		}
		new playset;
		playset = strval(tmp);
		if(playset == playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " Вы не можете передать деньги самому себе !");
			return 1;
		}
		if(IsPlayerConnected(playset))
		{
			if(gPlayerLogged[playset] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали сумму !");
				return 1;
			}
			new money;
			money = strval(tmp);
			if(money < 0) { SendClientMessage(playerid, COLOR_RED, " Сумма не может быть отрицательным числом !"); return 1; }
			if(GetPlayerMoney(playerid) < money) { SendClientMessage(playerid, COLOR_RED, " У Вас нет такой суммы !"); return 1; }
			new money22 = money * -1;
			new dopper44, dopper55;
			dopper44 = GetPlayerMoney(playerid);
			dopper55 = GetPlayerMoney(playset);
			SetPVarInt(playerid, "MonControl", 1);
			GivePlayerMoney(playerid, money22);
			SetPVarInt(playset, "MonControl", 1);
			GivePlayerMoney(playset, money);
			format(string, sizeof(string), " Игрок %s [%d] передал игроку %s [%d] %d $", RealName[playerid], playerid,
			RealName[playset], playset, money);
			print(string);
			SendAdminMessage(COLOR_YELLOW, string);
			if (PlayerInfo[playerid][pAdmin] == 0)
			{
				format(string, sizeof(string), " Вы передали игроку %s [%d] %d $", RealName[playset], playset, money);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
			if (PlayerInfo[playset][pAdmin] == 0)
			{
				format(string, sizeof(string), " Игрок %s [%d] передал Вам %d $", RealName[playerid], playerid, money);
				SendClientMessage(playset, COLOR_YELLOW, string);
			}
			printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[playerid], playerid, dopper44);
			printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[playset], playset, dopper55);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
		}
    	return 1;
	}
	if(strcmp(cmd, "/kill", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		SetPlayerArmour(playerid, 0);
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	if(strcmp(cmd, "/menu", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		gettime(timedata[0], timedata[1]);
		format(string, sizeof(string), "{458B74} Игровое меню | Точное время: %02d:%02d", timedata[0], timedata[1]);
		ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, string, "{40E0D0}»{FFFFFF} Транспорт\n{40E0D0}»{FFFFFF} Рукопашка\
        \n{40E0D0}»{FFFFFF} Огнестрел\n{40E0D0}»{FFFFFF} Телепорты\n{40E0D0}»{FFFFFF} ДМ арены\n{40E0D0}»{FFFFFF} Управление персонажем\n{40E0D0}»{FFFFFF} Радио\n{40E0D0}»{FFFFFF} Правила сервера\
        \n{40E0D0}»{FFFFFF} Правила для администрации\n{40E0D0}»{FFFFFF} Администрация в сети\n{40E0D0}»{FFFFFF} Инфа о сервере\n{40E0D0}»{FFFFFF} Система кланов", "Выбор", "Отмена");
		dlgcont[playerid] = 4;
    	return 1;
}
		if(strcmp(cmd, "/обнулить", true) == 0 || strcmp(cmd, "/obnul", true) == 0)
        {
      SetPlayerScore(playerid, 0);
      ResetPlayerMoney(playerid);
      SendClientMessage(playerid, 0x00FF00AA, "Вы обнулили очки");
      return 1;
 }
	if(strcmp(cmd, "/dt", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		if(GetPlayerInterior(playerid) != 0)//если игрок в доме или другом интерьере, то:
		{
			SendClientMessage(playerid, COLOR_RED, " В домах и других интерьерах эта команда не работает !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /dt [виртуальный мир (0-9999)]");
			return 1;
		}
		new ii = strval(tmp);
		if(ii < 0 || ii > 9999)
		{
			SendClientMessage(playerid, COLOR_RED, " /dt [виртуальный мир (0-9999)] !");
			return 1;
		}
		if(ii > 0)
		{
			if(ii == GetPlayerVirtualWorld(playerid))
			{
				format(string, sizeof(string), " Вы уже находитесь в %d виртуальном мире !!!", ii);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			SetPlayerVirtualWorld(playerid, ii);
			if(GetPlayerState(playerid) == 2)
			{//если игрок на месте водителя, то:
				new carpl;
				carpl = GetPlayerVehicleID(playerid);//получение ид авто инициатора
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(GetPlayerVehicleID(i) == carpl && playerid != i)//если игрок в авто инициатора, то:
						{//установить пассажирам интерьер и виртуальный мир игрока
							SetPlayerInterior(i, GetPlayerInterior(playerid));
							SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
							format(string, sizeof(string), " Ваш виртуальный мир был изменён на {FF0000}%d {00FF00}(Вы в режиме дрифт тренировки)", ii);
							SendClientMessage(i, COLOR_GREEN, string);
							SendClientMessage(i, COLOR_GREEN, " Для отключения режима дрифт тренировки используйте команду: {FF0000}/dt 0");
						}
					}
				}
				LinkVehicleToInterior(carpl, GetPlayerInterior(playerid));//подключить транспорт к интерьеру игрока
				SetVehicleVirtualWorld(carpl, GetPlayerVirtualWorld(playerid));//установить транспорту виртуальный мир игрока
			}
			format(string, sizeof(string), " Ваш виртуальный мир был изменён на {FF0000}%d {00FF00}(Вы в режиме дрифт тренировки)", ii);
			SendClientMessage(playerid, COLOR_GREEN, string);
			SendClientMessage(playerid, COLOR_GREEN, " Для отключения режима дрифт тренировки используйте команду: {FF0000}/dt 0");
		}
		else
		{
			if(ii == GetPlayerVirtualWorld(playerid))
			{
				SendClientMessage(playerid, COLOR_RED, " У Вас уже выключен режим дрифт тренировки !!!");
				return 1;
			}
			SetPlayerVirtualWorld(playerid, ii);
			if(GetPlayerState(playerid) == 2)
			{//если игрок на месте водителя, то:
				new carpl;
				carpl = GetPlayerVehicleID(playerid);//получение ид авто инициатора
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(GetPlayerVehicleID(i) == carpl && playerid != i)//если игрок в авто инициатора, то:
						{//установить пассажирам интерьер и виртуальный мир игрока
							SetPlayerInterior(i, GetPlayerInterior(playerid));
							SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
							SendClientMessage(i, COLOR_RED, " Режим дрифт тренировки был выключен");
						}
					}
				}
				LinkVehicleToInterior(carpl, GetPlayerInterior(playerid));//подключить транспорт к интерьеру игрока
				SetVehicleVirtualWorld(carpl, GetPlayerVirtualWorld(playerid));//установить транспорту виртуальный мир игрока
			}
			SendClientMessage(playerid, COLOR_RED, " Режим дрифт тренировки выключен");
		}
		return 1;
	}
	if(strcmp(cmd, "/s", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
 		new Float:ConX, Float:ConY, Float:ConZ;
		GetPlayerPos(playerid, ConX, ConY, ConZ);
		if(ConZ < -600 || ConZ > 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В данном месте сохранение позиции невозможно !");
			return 1;
		}
		GetPlayerPos(playerid, TpDestP[playerid][0], TpDestP[playerid][1], TpDestP[playerid][2]);
		TpPosP[playerid][0] = GetPlayerInterior(playerid);
		TpPosP[playerid][1] = GetPlayerVirtualWorld(playerid);
		if(GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
		{
			GetVehicleZAngle(GetPlayerVehicleID(playerid), TpDestP[playerid][3]);
		}
		else
		{
			GetPlayerFacingAngle(playerid, TpDestP[playerid][3]);
		}
		SendClientMessage(playerid, COLOR_YELLOW, " Вы сохранили позицию телепорта.");
		return 1;
	}
	if(strcmp(cmd, "/r", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		if(GetPlayerState(playerid) == 2)
		{
			new regm = 2, per1, per2, Float:per3;
			per1 = TpPosP[playerid][0];
			per2 = TpPosP[playerid][1];
			per3 = TpDestP[playerid][3];
			LogTelPort(playerid, regm, per1, per2, Float:per3, Float:TpDestP[playerid][0], Float:TpDestP[playerid][1],
			Float:TpDestP[playerid][2]+1);
		}
		else
		{
			SetPlayerInterior(playerid, TpPosP[playerid][0]);
			SetPlayerVirtualWorld(playerid, TpPosP[playerid][1]);
			SetPlayerPos(playerid, TpDestP[playerid][0], TpDestP[playerid][1], TpDestP[playerid][2]+1);
			SetPlayerFacingAngle(playerid, TpDestP[playerid][3]);
			SetCameraBehindPlayer(playerid);
		}
		if(TpDestP[playerid][0] > -3200 && TpDestP[playerid][0] < 3200 &&
		TpDestP[playerid][1] > -3200 && TpDestP[playerid][1] < 3200)
		{
			SendClientMessage(playerid, COLOR_GREEN, " Вы были телепортированы на сохранённую позицию.");
		}
		else
		{
			SetTimerEx("DubTlp", 1000, 0, "i", playerid);
		}
		return 1;
	}
	if(strcmp(cmd, "/cmchat", true) == 0)
	{
		ClearChat(playerid, 0);
		SendClientMessage(playerid, COLOR_GRAD1, " Вы очистили свой чат.");
		return 1;
	}
	if(strcmp(cmd, "/report", true) == 0)
	{
        if(PlayerInfo[playerid][pAdmin] >= 1)
        {
			SendClientMessage(playerid, COLOR_RED, " Администратор не может отправить репорт !");
			return 1;
		}
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* Вы не можете говорить, Вас заткнули !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /report [ид нарушителя] [жалоба]");
			return 1;
		}
		new para1;
		para1 = strval(tmp);
		if(para1 == playerid)
        {
			SendClientMessage(playerid, COLOR_RED, " Нельзя жаловаться на самого себя !");
			return 1;
		}
		if(!IsPlayerConnected(para1))
		{
			SendClientMessage(playerid, COLOR_RED, " Такого [ид нарушителя] на сервере нет !");
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
			SendClientMessage(playerid, COLOR_RED, " /report [ид нарушителя] [жалоба] !");
			return 1;
		}
		new per55 = 0;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
//				if(PlayerInfo[i][pAdmin] >= 1) {per55 = 1;}//поиск всех админов
				if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmshad] == 0) {per55 = 1;}//поиск только НЕ скрытых админов
			}
		}
		if(per55 == 0)
		{
			SendClientMessage(playerid, COLOR_RED, " Ваша жалоба не отправлена, нет админов на сервере !");
			return 1;
		}
		format(string, sizeof(string), " <Report> {FFFF00}игрок %s [%d] пожаловался на игрока %s [%d] , причина: %s",
		RealName[playerid], playerid, RealName[para1], para1, result);
		print(string);
		SendAdminMessage(COLOR_RED, string);
		SendClientMessage(playerid, COLOR_YELLOW, " Ваша жалоба отправлена админам, ожидайте её рассмотрения.");
		return 1;
	}
	if(strcmp(cmd, "/tp", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
			return 1;
		}
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SendClientMessage(playerid, COLOR_GREEN, " ...!");
		SetPlayerPos(playerid, -2067.5012, 1356.4471, 7.1016);
    	return 1;
    }
	if(strcmp(cmd, "/vers", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, " Версия мода: 1.0");
		return 1;
	}
//------------------------- команды игроков (конец) ----------------------------
//--------------------- команды админов 1 лвл (начало) -------------------------
	if(strcmp(cmd, "/time", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /time [время(0-23)]");
				return 1;
			}
			new hour1;
			hour1 = strval(tmp);
			if (hour1 < 0 || hour1 > 23)
			{
				SendClientMessage(playerid, COLOR_RED, " Время: от 0 до 23 !");
				return 1;
			}
			SetWorldTime(hour1);
			format(string, sizeof(string), " Администратор %s установил время на %d часов.", RealName[playerid], hour1);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW,string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/weat", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /weat [ид погоды]");
				return 1;
			}
			new testwea = strval(tmp);
			SetWeather(testwea);
			format(string, sizeof(string), " Администратор %s установил ID погоды на %d", RealName[playerid], testwea);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mess", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /mess [цвет(0-19)] [сообщение] , или /mess 600");
				return 1;
			}
			new color;
			color = strval(tmp);
			if(color < 0 || (color > 19 && color < 600) || color > 600)
			{
				SendClientMessage(playerid, COLOR_RED, " Цвет(0-19) , или 600 !");
				return 1;
			}
			if(color == 600)
			{
				format(strdln, sizeof(strdln), "{A9C4E4}0 - {FF0000}Красный\
				\n{A9C4E4}1 - {FF3F3F}Светло-красный\
				\n{A9C4E4}2 - {FF3F00}Кирпичный\
				\n{A9C4E4}3 - {BF3F00}Коричневый");
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}4 - {FF7F3F}Светло-коричневый\
				\n{A9C4E4}5 - {FF7F00}Оранжевый\
				\n{A9C4E4}6 - {FFFF00}Жёлтый\
				\n{A9C4E4}7 - {3FFF3F}Светло-зелёный", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}8 - {00FF00}Зелёный\
				\n{A9C4E4}9 - {00BF00}Тёмно-зелёный\
				\n{A9C4E4}10 - {00FFFF}Бирюзовый\
				\n{A9C4E4}11 - {00BFFF}Голубой", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}12 - {3F3FFF}Светло-синий\
				\n{A9C4E4}13 - {0000FF}Синий\
				\n{A9C4E4}14 - {7F3FFF}Светло-фиолетовый\
				\n{A9C4E4}15 - {7F00FF}Фиолетовый", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}16 - {FF00FF}Сиреневый\
				\n{A9C4E4}17 - {7F7F7F}Серый\
				\n{A9C4E4}18 - {FFFFFF}Белый\
				\n{A9C4E4}19 - {333333}Чёрный", strdln);
				ShowPlayerDialog(playerid, 2, 0, "Цвет:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new idx22 = idx;
			new result[256];
			while ((idx22 < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				if (cmdtext[idx22] == 123 && cmdtext[idx22 + 1] == 44)
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
					idx22++;
				}
				else
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
				}
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не написали сообщение !");
				return 1;
			}
			format(string, sizeof(string), "(/mess) Админ %s [%d]: %s", RealName[playerid], playerid, result);
			print(string);
			switch(color)
			{
				case 0: format(string, sizeof(string), "{FF0000}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 1: format(string, sizeof(string), "{FF3F3F}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 2: format(string, sizeof(string), "{FF3F00}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 3: format(string, sizeof(string), "{BF3F00}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 4: format(string, sizeof(string), "{FF7F3F}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 5: format(string, sizeof(string), "{FF7F00}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 6: format(string, sizeof(string), "{FFFF00}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 7: format(string, sizeof(string), "{3FFF3F}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 8: format(string, sizeof(string), "{00FF00}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 9: format(string, sizeof(string), "{00BF00}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 10: format(string, sizeof(string), "{00FFFF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 11: format(string, sizeof(string), "{00BFFF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 12: format(string, sizeof(string), "{3F3FFF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 13: format(string, sizeof(string), "{0000FF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 14: format(string, sizeof(string), "{7F3FFF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 15: format(string, sizeof(string), "{7F00FF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 16: format(string, sizeof(string), "{FF00FF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 17: format(string, sizeof(string), "{7F7F7F}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 18: format(string, sizeof(string), "{FFFFFF}Админ %s [%d]: %s", RealName[playerid], playerid, result);
				case 19: format(string, sizeof(string), "{333333}Админ %s [%d]: %s", RealName[playerid], playerid, result);
			}
			SendClientMessageToAll(COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/cord", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:x, Float:y, Float:z, Float:Angle;
			GetPlayerPos(playerid, x, y, z);
			if(GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
			{
				new VID = GetPlayerVehicleID(playerid);
				GetVehicleZAngle(VID, Angle);
			}
			else
			{
				GetPlayerFacingAngle(playerid, Angle);
			}
			format(string, sizeof(string), "x = %f   y = %f   z = %f   поворот = %f   интерьер = %d   виртуальный мир = %d",
			x, y, z, Angle, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			SendClientMessage(playerid, COLOR_WHITE, string);
			printf(" Администратор %s использовал команду /cord .", RealName[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//--------------------- команды админов 1 лвл (конец) --------------------------
//--------------------- команды админов 2 лвл (начало) -------------------------
	if(strcmp(cmd, "/muteakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 2)
    	{
			new data222[3], csec;
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /muteakk [имя аккаунта] [число секунд");
				SendClientMessage(playerid, COLOR_GRAD2, " (чтобы разоткнуть, введите 3 секунды)] [причина]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /muteakk [имя аккаунта] [число секунд] [причина] !");
				return 1;
			}
			csec = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			new file;//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getInteger(file, "AdminLevel", data222[0]);
				ini_getInteger(file, "Muted", data222[1]);
				ini_getInteger(file, "Mutedsec", data222[2]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//проверка аккаунта на On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data222[0] < 0)
			{
				fadm = data222[0] * -1;
			}
			else
			{
				fadm = data222[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//проверка аккаунта на админку
			{
				format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] - админ %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(csec != 3)//заткнуть игрока
			{
				if(csec < 5) {csec = 5;}
				if(data222[2] == 0)//если игрок НЕ заткнут, то:
				{
					data222[1]++;
				}
				data222[2] = csec;
			}
			else//разоткнуть игрока
			{
				if(data222[2] > 0)//если игрок заткнут, то:
				{
  					data222[1]--;
					data222[2] = 0;
				}
				else
				{
			  		SendClientMessage(playerid, COLOR_RED, " Выбранный игрок не заткнут !");
					return 1;
				}
			}
			file = ini_openFile(string);//запись изменённого аккаунта
			if(file >= 0)
			{
				ini_setInteger(file, "Muted", data222[1]);
				ini_setInteger(file, "Mutedsec", data222[2]);
				ini_closeFile(file);
			}
			if(csec != 3)//заткнуть игрока
			{
				new dopcis;
				dopcis = FCislit(csec);
				switch(dopcis)
				{
					case 0: format(ssss, sizeof(ssss), " Администратор %s заткнул аккаунт игрока %s на %d секунд , причина: %s", RealName[playerid], akk, csec, result);
					case 1: format(ssss, sizeof(ssss), " Администратор %s заткнул аккаунт игрока %s на %d секунду , причина: %s", RealName[playerid], akk, csec, result);
					case 2: format(ssss, sizeof(ssss), " Администратор %s заткнул аккаунт игрока %s на %d секунды , причина: %s", RealName[playerid], akk, csec, result);
				}
				print(ssss);
				SendClientMessageToAll(COLOR_RED, ssss);
			}
			else//разоткнуть игрока
			{
				format(ssss, sizeof(ssss), " Администратор %s разоткнул аккаунт игрока %s , причина: амнистия ;)))",
				RealName[playerid], akk);
				print(ssss);
				SendClientMessageToAll(COLOR_GREEN, ssss);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/prisonakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 2)
    	{
   			new data222[3], csec;
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /prisonakk [имя аккаунта] [число секунд");
				SendClientMessage(playerid, COLOR_GRAD2, " (чтобы освободить, введите 3 секунды)] [причина]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /prisonakk [имя аккаунта] [число секунд] [причина] !");
				return 1;
			}
			csec = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			new file;//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getInteger(file, "AdminLevel", data222[0]);
				ini_getInteger(file, "Prison", data222[1]);
				ini_getInteger(file, "Prisonsec", data222[2]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//проверка аккаунта на On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data222[0] < 0)
			{
				fadm = data222[0] * -1;
			}
			else
			{
				fadm = data222[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//проверка аккаунта на админку
			{
				format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] - админ %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(csec != 3)//посадить игрока
			{
				if(csec < 5) {csec = 5;}
				if(data222[2] == 0)//если не в тюрьме, то:
				{
					data222[1]++;
				}
				data222[2] = csec;
			}
			else//освободить игрока
			{
				if(data222[2] > 0)//если игрок в тюрьме, то:
				{
  					data222[1]--;
					data222[2] = 0;
				}
				else
				{
			  		SendClientMessage(playerid, COLOR_RED, " Выбранный игрок не сидит в тюрьме !");
					return 1;
				}
			}
			file = ini_openFile(string);//запись изменённого аккаунта
			if(file >= 0)
			{
				ini_setInteger(file, "Prison", data222[1]);
				ini_setInteger(file, "Prisonsec", data222[2]);
				ini_closeFile(file);
			}
			if(csec != 3)//посадить игрока
			{
				new dopcis;
				dopcis = FCislit(csec);
				switch(dopcis)
				{
					case 0: format(ssss, sizeof(ssss), " Администратор %s посадил аккаунт игрока %s в тюрьму на %d секунд , причина: %s", RealName[playerid], akk, csec, result);
					case 1: format(ssss, sizeof(ssss), " Администратор %s посадил аккаунт игрока %s в тюрьму на %d секунду , причина: %s", RealName[playerid], akk, csec, result);
					case 2: format(ssss, sizeof(ssss), " Администратор %s посадил аккаунт игрока %s в тюрьму на %d секунды , причина: %s", RealName[playerid], akk, csec, result);
				}
				print(ssss);
				SendClientMessageToAll(COLOR_RED, ssss);
			}
			else//освободить игрока
			{
				format(ssss, sizeof(ssss), " Администратор %s освободил аккаунт игрока %s , причина: амнистия ;)))",
				RealName[playerid], akk);
				print(ssss);
				SendClientMessageToAll(COLOR_GREEN, ssss);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/cc", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			ClearChat(playerid, 1);
			format(string, sizeof(string), " Администратор %s очистил чат сервера !", RealName[playerid]);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mark", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			TpPosA[playerid][0] = GetPlayerInterior(playerid);
			TpPosA[playerid][1] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, TpDestA[playerid][0],TpDestA[playerid][1],TpDestA[playerid][2]);
			if (GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
			{
				GetVehicleZAngle(GetPlayerVehicleID(playerid), TpDestA[playerid][3]);
			}
			else
			{
				GetPlayerFacingAngle(playerid, TpDestA[playerid][3]);
			}
			SendClientMessage(playerid, COLOR_GRAD1, " Маркер телепорта установлен.");
			printf(" Администратор %s установил телепорт ( /mark )", RealName[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotomark", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			if(GetPlayerState(playerid) == 2)//если игрок на месте водителя, то:
			{
				new regm = 2, per1, per2, Float:per3;
				per1 = TpPosA[playerid][0];
				per2 = TpPosA[playerid][1];
				per3 = TpDestA[playerid][3];
				LogTelPort(playerid, regm, per1, per2, Float:per3, Float:TpDestA[playerid][0],
				Float:TpDestA[playerid][1], Float:TpDestA[playerid][2]+1);
			}
			else//иначе:
			{
				SetPlayerInterior(playerid, TpPosA[playerid][0]);
				SetPlayerVirtualWorld(playerid, TpPosA[playerid][1]);
				SetPlayerPos(playerid, TpDestA[playerid][0], TpDestA[playerid][1], TpDestA[playerid][2]+1);
				SetPlayerFacingAngle(playerid, TpDestA[playerid][3]);
				SetCameraBehindPlayer(playerid);
			}
			SendClientMessage(playerid, COLOR_GRAD1, " Вы были телепортированы.");
			printf(" Администратор %s телепортировался ( /gotomark )", RealName[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//--------------------- команды админов 2 лвл (конец) --------------------------
//--------------------- команды админов 3 лвл (начало) -------------------------
	if(strcmp(cmd, "/tpset", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /tpset [координата X] [координата Y] [координата Z]");
				return 1;
			}
			new cor1, cor2, cor3, Float:fcor1, Float:fcor2, Float:fcor3;
			cor1 = strval(tmp);
			if(cor1 < -19500 || cor1 > 19500)
			{
				SendClientMessage(playerid, COLOR_RED, " Координата X от -19500 до 19500 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [координата Y] [координата Z] !");
				return 1;
			}
			cor2 = strval(tmp);
			if(cor2 < -19500 || cor2 > 19500)
			{
				SendClientMessage(playerid, COLOR_RED, " Координата Y от -19500 до 19500 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [координата Z] !");
				return 1;
			}
			cor3 = strval(tmp);
			if(cor3 < -500 || cor3 > 19500)
			{
				SendClientMessage(playerid, COLOR_RED, " Координата Z от -500 до 19500 !");
				return 1;
			}
			format(string, sizeof(string), "%d", cor1);
			fcor1 = floatstr(string);
			format(string, sizeof(string), "%d", cor2);
			fcor2 = floatstr(string);
			format(string, sizeof(string), "%d", cor3);
			fcor3 = floatstr(string);
			SetPlayerPos(playerid, fcor1, fcor2, fcor3);
			printf(" Администратор %s телепортировался в координаты: X = %f   Y = %f   Z = %f", RealName[playerid], fcor1, fcor2, fcor3);
			format(string, sizeof(string), " Вы телепортировались в координаты: X = %f   Y = %f   Z = %f", fcor1, fcor2, fcor3);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/jetpack", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /jetpack [ид игрока]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(IsPlayerConnected(para1))
		    {
				if(playspa[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не заспавнился !");
					return 1;
				}
				if(admper1[para1] != 600)
				{
					SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кому Вы хотите дать JetPack - в режиме наблюдения !");
					return 1;
				}
				if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[para1][pAdmin] >= 12)
				{
					SendClientMessage(playerid, COLOR_RED, " Вы не можете дать JetPack админу 12-го уровня !");
					return 1;
				}
				if(IsPlayerInAnyVehicle(para1))
				{//если игрок в авто, то:
					new Float:X, Float:Y, Float:Z;//высадить игрока из авто
					GetPlayerPos(para1, X, Y, Z);
					SetPlayerPos(para1, X+3, Y+3, Z+3);
				}
				SetPlayerSpecialAction(para1, 2);
				format(string, sizeof(string), " Администратор %s дал игроку %s JetPack .", RealName[playerid], RealName[para1]);
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
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
//------------------------------ BusSystem -------------------------------------
	if(strcmp(cmd, "/helpbiz", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, 0x00FFFFFF, " -------------------------- Система бизнесов -------------------------- ");
			SendClientMessage(playerid, 0x00FFFFFF, "   /helpbus - помощь по командам BusSystem");
			SendClientMessage(playerid, 0x00FFFFFF, "   /createbus - создать бизнес");
			SendClientMessage(playerid, 0x00FFFFFF, "   /removebus - удалить бизнес по его ID");
			SendClientMessage(playerid, 0x00FFFFFF, "   /removebusall - удалить все бизнесы");
			SendClientMessage(playerid, 0x00FFFFFF, "   /gotobus - телепортироваться к бизнесу по его ID");
			SendClientMessage(playerid, 0x00FFFFFF, "   /reloadbus - перезагрузка системы бизнесов");
			SendClientMessage(playerid, 0x00FFFFFF, " --------------------------------------------------------------------------------- ");
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
		if(strcmp(cmd, "/scrmd", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /scrmd [режим] ( 0- надпись ''Drift level'' ,");
			SendClientMessage(playerid, COLOR_GRAD2, " 1- спидометр, 2- дрифт счётчик, 3- надпись ''уровень дрифта''");
			SendClientMessage(playerid, COLOR_GRAD2, " (у себя над головой), 4- просмотр ников других игроков )");
			return 1;
		}
		new para1 = strval(tmp);
		if(para1 < 0 || para1 > 4)
		{
			SendClientMessage(playerid, COLOR_RED, " Ид настройки от 0 до 4 !");
			return 1;
		}
		if(para1 == 0)
		{
			if(scrmod[0][playerid] == 0)
			{
				scrmod[0][playerid] = 1;
				printf(" --> Игрок %s [%d] отключил надпись ''Drift level'' .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " Вы отключили надпись ''Drift level'' .");
			}
			else
			{
				scrmod[0][playerid] = 0;
				printf(" --> Игрок %s [%d] включил надпись ''Drift level'' .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " Вы включили надпись ''Drift level'' .");
			}
		}
		if(para1 == 2)
		{
			if(scrmod[2][playerid] == 0)
			{
				scrmod[2][playerid] = 1;
				printf(" --> Игрок %s [%d] отключил дрифт счётчик.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " Вы отключили дрифт счётчик.");
			}
			else
			{
				scrmod[2][playerid] = 0;
				printf(" --> Игрок %s [%d] включил дрифт счётчик.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " Вы включили дрифт счётчик.");
			}
		}
		if(para1 == 3)
		{
			if(dmplay[playerid] != 0)//если игрок в DM-зоне, то:
			{
				SendClientMessage(playerid, COLOR_RED, " В DM-зонах выбранная опция НЕ работает !");
				return 1;
			}
			if(scrmod[3][playerid] == 0)
			{
				scrmod[3][playerid] = 1;
				Delete3DTextLabel(Level3D[playerid]);
				printf(" --> Игрок %s [%d] отключил надпись ''уровень дрифта'' (у себя над головой) .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " Вы отключили надпись ''уровень дрифта'' (у себя над головой) .");
			}
			else
			{
				scrmod[3][playerid] = 0;
				Level3D[playerid] = Create3DTextLabel(" ",0xFFFFFFAA,0.000,0.000,-4.000,18.0,0,1);
				LevelStats[playerid] = 0;
				printf(" --> Игрок %s [%d] включил надпись ''уровень дрифта'' (у себя над головой) .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " Вы включили надпись ''уровень дрифта'' (у себя над головой) .");
			}
		}
		if(para1 == 4)
		{
			if(scrmod[4][playerid] == 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					ShowPlayerNameTagForPlayer(playerid, i, false);
				}
				scrmod[4][playerid] = 1;
				printf(" --> Игрок %s [%d] отключил просмотр ников других игроков.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " Вы отключили просмотр ников других игроков.");
			}
			else
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					ShowPlayerNameTagForPlayer(playerid, i, true);
				}
				scrmod[4][playerid] = 0;
				printf(" --> Игрок %s [%d] включил просмотр ников других игроков.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " Вы включили просмотр ников других игроков.");
			}
		}
    	return 1;
	}
	if(strcmp(cmd, "/createbiz", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Используйте: /createbus [стоимость(100-1000000 $)] [число минут, через");
				SendClientMessage(playerid, 0xFFFFFFFF, " которое бизнес будет приносить доход(10-120)] [доход от бизнеса");
				SendClientMessage(playerid, 0xFFFFFFFF, " за минуты он-лайн игры(100-1000000 $)] [название бизнеса(от 3 до 32 символов)]");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 < 100 || para1 > 1000000)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Стоимость от 100 $ до 1000000 $ !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " /createbus [стоимость] [число минут] [доход] [название бизнеса] !");
				return 1;
			}
			new para2 = strval(tmp);
			if(para2 < 10 || para2 > 120)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Число минут от 10 до 120 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " /createbus [стоимость] [число минут] [доход] [название бизнеса] !");
				return 1;
			}
			new para3 = strval(tmp);
			if(para3 < 100 || para3 > 1000000)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Доход от 100 $ до 1000000 $ !");
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
			if(strlen(result) < 3 || strlen(result) > 32)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Название от 3 до 32 символов !");
				return 1;
			}
			if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Бизнес можно создать только в 0-м интерьере, и на основной карте !");
				return 1;
			}
			new para4 = 0;
			new para5 = 0;
			while(para4 < BUS_MAX)
			{
				if(buscount[para4] == 0)
				{
					para5 = 1;
					break;
				}
				para4++;
			}
			if(para5 == 0)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Превышен лимит создания бизнесов !");
				SendClientMessage(playerid, 0xFFFFFFFF, " Для продолжения - увеличьте максимум бизнесов на сервере !");
				return 1;
			}
			buscount[para4] = 1;//создаём бизнес
			GetPlayerPos(playerid, buscordx[para4], buscordy[para4], buscordz[para4]);//задаём координаты бизнеса
			strdel(busname[para4], 0, 64);//задаём название бизнеса
			strcat(busname[para4], result);
			strdel(busplayname[para4], 0, MAX_PLAYER_NAME);//удаляем имя владельца бизнеса
			strcat(busplayname[para4], "*** INV_PL_ID");
		    buscost[para4] = para1;//задаём стоимость бизнеса
		    busminute[para4] = para2;//задаём, через сколько минут бизнес будет приносить доход
		    busincome[para4] = para3;//задаём доход от бизнеса
		    busday[para4] = 0;//даём бизнесу право на его перекупку (покупку)

    		new file, f[256];//запись бизнеса в файл
	    	format(f, 256, "bussystem/%i.ini", para4);
			file = ini_createFile(f);
			if(file == INI_OK)
			{
		    	ini_setString(file, "BusName", busname[para4]);
		    	ini_setString(file, "PlayName", busplayname[para4]);
		    	ini_setInteger(file, "Cost", buscost[para4]);
		    	ini_setInteger(file, "Minute", busminute[para4]);
		    	ini_setInteger(file, "Income", busincome[para4]);
		    	ini_setInteger(file, "Day", busday[para4]);
		    	ini_setFloat(file, "CordX", buscordx[para4]);
		    	ini_setFloat(file, "CordY", buscordy[para4]);
		    	ini_setFloat(file, "CordZ", buscordz[para4]);
				ini_closeFile(file);
			}

			PickupID[para4] = CreateDynamicPickup(1274, 1, buscordx[para4], buscordy[para4], buscordz[para4], 0, 0, -1, 100.0);//создаём пикап бизнеса
			MapIconID[para4] = CreateDynamicMapIcon(buscordx[para4], buscordy[para4], buscordz[para4], 52, -1, 0, 0, -1, 200.0);//создаём мап-иконку бизнеса
			format(string, sizeof(string), "Бизнес: %s\nID: %d", busname[para4], para4);
			Nbus[para4] = Create3DTextLabel(string, 0x00FF00FF, buscordx[para4], buscordy[para4], buscordz[para4]+0.70, 50, 0, 1);//создаём 3D-текст бизнеса
			GetPlayerName(playerid, sendername, sizeof(sendername));
			printf("[BusSystem] Администратор %s [%d] создал бизнес ID: %d .", sendername, playerid, para4);
			format(string, sizeof(string), " Бизнес ID: %d успешно создан.", para4);
			SendClientMessage(playerid, 0xFFFF00FF, string);
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/removebus", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " Используйте: /removebus [ID бизнеса]");
				return 1;
			}
			new para1 = strval(tmp);
			format(string, sizeof(string), "bussystem/%i.ini", para1);
			if(fexist(string) || buscount[para1] == 1)//если файл или сам бизнес существует, то:
			{
				DestroyDynamicPickup(PickupID[para1]);//удаляем пикап бизнеса
				if(busday[para1] == 0)//если есть мап-иконка бизнеса, то:
				{
					DestroyDynamicMapIcon(MapIconID[para1]);//удаляем мап-иконку бизнеса
				}
				Delete3DTextLabel(Nbus[para1]);//удаляем 3D-текст бизнеса
				if(fexist(string))//если файл существует, то:
				{
                    fremove(string);//удаляем файл
				}
				buscount[para1] = 0;//удаляем бизнес
				strdel(busplayname[para1], 0, MAX_PLAYER_NAME);//удаляем имя владельца бизнеса
				strcat(busplayname[para1], "*** INV_PL_ID");
				PickupID[para1] = -600;//задаём несуществующий ID-номер пикапа для бизнеса
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[BusSystem] Админ %s [%d] удалил бизнес ID: %d .", sendername, playerid, para1);
				format(string, sizeof(string), " Бизнес ID: %d успешно удалён.", para1);
				SendClientMessage(playerid, 0xFFFFFFFF, string);
			}
			else//если ни файл, и ни сам бизнес не существуют, то:
			{
				SendClientMessage(playerid, 0xFF0000FF, " Бизнеса с таким ID не существует !");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/removebusall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			new para1 = 0;
			for(new i; i < BUS_MAX; i++)
			{
				format(string, sizeof(string), "bussystem/%i.ini", i);
				if(fexist(string) || buscount[i] == 1)//если файл или сам бизнес существует, то:
				{
					para1 = 1;
					DestroyDynamicPickup(PickupID[i]);//удаляем пикап бизнеса
					if(busday[i] == 0)//если есть мап-иконка бизнеса, то:
					{
						DestroyDynamicMapIcon(MapIconID[i]);//удаляем мап-иконку бизнеса
					}
					Delete3DTextLabel(Nbus[i]);//удаляем 3D-текст бизнеса
					if(fexist(string))//если файл существует, то:
					{
                    	fremove(string);//удаляем файл
					}
					buscount[i] = 0;//удаляем бизнес
					strdel(busplayname[i], 0, MAX_PLAYER_NAME);//удаляем имя владельца бизнеса
					strcat(busplayname[i], "*** INV_PL_ID");
					PickupID[i] = -600;//задаём несуществующий ID-номер пикапа для бизнеса
				}
			}
			if(para1 == 1)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[BusSystem] Администратор %s [%d] удалил все бизнесы.", sendername, playerid);
				SendClientMessage(playerid, 0xFF0000FF, " Все бизнесы были успешно удалены.");
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000FF, " На сервере не создано ни одного бизнеса !");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotobus", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x00FFFFFF, " Используйте: /gotobus [ID бизнеса]");
				return 1;
			}
			new para1 = strval(tmp);
			if(buscount[para1] == 1)//если бизнес существует, то:
			{
				SetPlayerPos(playerid, buscordx[para1], buscordy[para1]+2, buscordz[para1]+1);
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[BusSystem] Администратор %s [%d] телепортировался к бизнесу ID: %d .", sendername, playerid, para1);
				format(string, sizeof(string), " Вы телепортировались к бизнесу ID: %d .", para1);
				SendClientMessage(playerid, 0x00FF00FF, string);
			}
			else//если бизнес не существуют, то:
			{
				SendClientMessage(playerid, 0xFF0000FF, " Бизнеса с таким ID не существует !");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/reloadbus", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			printf("[BusSystem] Администратор %s [%d] начал перезагрузку системы бизнесов.", sendername, playerid);
			format(string, sizeof(string), " Админ %s [%d] начал перезагрузку системы бизнесов.", sendername, playerid);
			SendClientMessageToAll(0xFF0000FF, string);
			SetTimerEx("reloadbus1", 1000, 0, "i", playerid);
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//---------------------------- End BusSystem -----------------------------------
	if(strcmp(cmd, "/explode", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /explode [ид игрока]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(IsPlayerConnected(para1))
		    {
				if(playspa[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не заспавнился !");
					return 1;
				}
				if(admper1[para1] != 600)
				{
					SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого Вы хотите взорвать - в режиме наблюдения !");
					return 1;
				}
				if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[para1][pAdmin] >= 12)
				{
					SendClientMessage(playerid, COLOR_RED, " Вы не можете взорвать админа 12-го уровня !");
					return 1;
				}
				new Float:x, Float:y, Float:z;
				GetPlayerPos(para1, x, y, z);
				CreateExplosion(x, y, z, 10, 10.0);
				CreateExplosion(x, y, z, 10, 10.0);
				format(string, sizeof(string), " Администратор %s взорвал игрока %s .", RealName[playerid], RealName[para1]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
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
//--------------------- команды админов 3 лвл (конец) --------------------------
//--------------------- команды админов 4 лвл (начало) -------------------------
    if(strcmp(cmd, "/car", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /car [ид модели авто] [цвет1] [цвет2]");
				return 1;
			}
			new car;
			car = strval(tmp);
			if(car < 400 || car > 611) { SendClientMessage(playerid, COLOR_RED, " Ид модели авто не может быть меньше 400 или больше 611 !"); return 1; }
			if(car == 537 || car == 538 || car == 569 || car == 570)
			{
				SendClientMessage(playerid, COLOR_RED, " Такой Ид модели авто создать нельзя !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали цвет1 и цвет2 !");
				return 1;
			}
			new color1;
			color1 = strval(tmp);
			if(color1 < 0 || color1 > 255) { SendClientMessage(playerid, COLOR_RED, " Номер цвета1 не может быть меньше 0 или больше 255 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали цвет2 !");
				return 1;
			}
			new color2;
			color2 = strval(tmp);
			if(color2 < 0 || color2 > 255) { SendClientMessage(playerid, COLOR_RED, " Номер цвета2 не может быть меньше 0 или больше 255 !"); return 1; }
			new carid2;
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			carid2 = CreateVehicle(car, X+3, Y+3, Z+1, 0.0, color1, color2, 90000);
			LinkVehicleToInterior(carid2, GetPlayerInterior(playerid));//подключить транспорт к интерьеру игрока
			SetVehicleVirtualWorld(carid2, GetPlayerVirtualWorld(playerid));//установить транспорту виртуальный мир игрока
			format(string, sizeof(string), " Администратор %s создал транспорт   ID: %d   Модель: %d .", RealName[playerid], carid2, car);
			print(string);
			format(string, sizeof(string), " Транспорт создан !   ID: %d   Модель: %d", carid2, car);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/delcar", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /delcar [ид авто]");
				return 1;
			}
			new carid;
			carid = strval(tmp);
			if (carid < 1 || carid > 10000)
			{
				SendClientMessage(playerid, COLOR_RED, " ИД авто: от 1 до 10000 !");
				return 1;
			}
			if(CallRemoteFunction("myobjvehfunc", "d", carid) != 0)//чтение ИД транспорта из скпипта myobj
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это отдельно созданный транспорт !");
				return 1;
			}
			if(CallRemoteFunction("garagefunction", "d", carid) != 0)//чтение ИД транспорта из системы гаражей
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это транспорт системы гаражей !");
				return 1;
			}
			if(CallRemoteFunction("mpsysvehfunc", "d", carid) != 0)//чтение ИД транспорта из системы МП
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это транспорт системы МП !");
				return 1;
			}
			if(CallRemoteFunction("dssysvehfunc", "d", carid) != 0)//чтение ИД транспорта из системы дерби-сумо
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это транспорт системы дерби-сумо !");
				return 1;
			}
			if(CallRemoteFunction("basesysvehfunc", "d", carid) != 0)//чтение ИД транспорта из системы баз
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это транспорт системы баз !");
				return 1;
			}
			if(CallRemoteFunction("vehsys3vehfunc", "d", carid) != 0)//чтение ИД транспорта из системы личного транспорта vehsys3
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это личный транспорт игрока !");
				return 1;
			}
			new locper = 0;
			new locper55 = 0;
			while(locper < MAX_PLAYERS)//уничтожить любой транспорт
			{
			 	if(carid == playcar[locper])//если уничтожаемый транспорт - личный транспорт игрока, то:
			 	{
					locper55 = 1;
					break;
			 	}
			 	if(carid == neon[locper][2])//уничтожить чужой неон на свободном транспорте
			 	{
					DestroyObject(neon[locper][0]);//убрать неон
					DestroyObject(neon[locper][1]);//убрать неон
					neon[locper][0] = 0;//присваиваем неону несуществующий номер объекта
					neon[locper][1] = 0;//присваиваем неону несуществующий номер объекта
					neon[locper][2] = 0;//несуществующий ид транспорта с неоном
			 	}
				locper++;
			}
			if(locper55 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Это личный транспорт игрока !");
				return 1;
			}
			new model, car22;
			model = GetVehicleModel(carid);
			car22 = DestroyVehicle(carid);
			if(car22 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид транспорта] на сервере нет !");
				return 1;
			}
			format(string, sizeof(string), " Администратор %s уничтожил транспорт   ID: %d   Модель: %d .",
			RealName[playerid], carid, model);
			print(string);
			format(string, sizeof(string), " Транспорт уничтожен !   ID: %d   Модель: %d", carid, model);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/entercar", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /entercar [ид транспорта]");
				return 1;
			}
			new testcar = strval(tmp);
			new modelcar = GetVehicleModel(testcar);
			if(modelcar == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид транспорта] на сервере нет !");
				return 1;
			}
			if(modelcar == 570 || modelcar == 569)
			{
				SendClientMessage(playerid, COLOR_RED, " В вагоне поезда нет места для водителя !");
			}
			else
			{
				if(IsPlayerInAnyVehicle(playerid))
				{//если игрок в авто, то:
					new Float:igx, Float:igy, Float:igz;
					GetPlayerPos(playerid, igx, igy, igz);//выйти самому из авто
					SetPlayerPos(playerid, igx+3, igy+3, igz);
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))//дальнейшее выполняем если игрок в коннекте
						{
							if(admper1[i] != 600 && admper1[i] == playerid)//если есть админ ведущий наблюдение,
							{//И этот админ наблюдает за игроком, то:
								admper5[i] = 2;//устанавливаем переключение наблюдения
							}
						}
					}
				}
				SetTimerEx("entcar22", 300, 0, "ii", playerid, testcar);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/plclr", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /plclr [ид настройки (0- узнать ники невидимых на");
				SendClientMessage(playerid, COLOR_GRAD2, " радаре полностью (или частично) игроков, 1- включить игроку");
				SendClientMessage(playerid, COLOR_GRAD2, " видимый ник (дополнительно - ид игрока), 2- включить ВСЕМ");
				SendClientMessage(playerid, COLOR_GRAD2, " невидимым полностью (или частично) игрокам видимые ники,");
				SendClientMessage(playerid, COLOR_GRAD2, " 3- установить игроку цвет ника (дополнительно - ид игрока))]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 3)
			{
				SendClientMessage(playerid, COLOR_RED, " Ид настройки от 0 до 3 !");
				return 1;
			}
			if(para1 == 0)
			{
				new dopper;
				dopper = 0;
				new locper, dop11, dop22, dop33;
				SendClientMessage(playerid, COLOR_YELLOW, " Невидимые на радаре полностью");
				SendClientMessage(playerid, COLOR_YELLOW, " (или частично) игроки:");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{//если игрок в коннекте, и заспавнен, то:
						locper = 0;
						dop11 = GetPlayerColor(i);
						dop22 = 0;
						dop33 = 268435456;
						for(new j = 0; j < 8; j++)//перевод десятичного цвет в шестнадцатиричный
						{//(корректировать старший знаковый бит (если число в отрицательном диапазоне) не будем
							dop22 = dop11 / dop33;//из-за ненадобности старших трёх байт)
							dop11 = dop11 - (dop22 * dop33);
							if(j == 6) { locper = locper + dop22 * 16; }//если обнаружен 4-й (младший) байт (7-й и 8-й ниблы), то:
							if(j == 7) { locper = locper + dop22; }//сразу переводим 4-й байт в десятичное число
							dop33 = dop33 / 16;
						}
						if(locper < 128)
						{//если игрок невидимый полностью (или частично), то:
							dopper = 1;
							format(string, sizeof(string), " --- %s [%d]", RealName[i], i);
							SendClientMessage(playerid, COLOR_YELLOW, string);
						}
					}
				}
				if(dopper == 0)
				{
					SendClientMessage(playerid, COLOR_YELLOW, " --- не обнаружено.");
				}
				else
				{
					SendClientMessage(playerid, COLOR_YELLOW, " ----------------------------------------");
				}
				printf(" Администратор %s просмотрел ники невидимых игроков.", RealName[playerid]);
				return 1;
			}
			if(para1 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " /plclr 1 [ид игрока] !");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
					return 1;
				}
				if(playspa[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Игрок ещё не заспавнился !");
					return 1;
				}
				ColorPlay[para2] = ColNick[8];//включаем игроку видимый ник
				SetPlayerColor(para2, ColorPlay[para2]);
			    for(new i=0;i<MAX_PLAYERS;i++)
				{
					SetPlayerMarkerForPlayer(i, para2, ColorPlay[para2]);
				}
				format(string, sizeof(string), " Администратор %s включил игроку %s видимый ник.", RealName[playerid], RealName[para2]);
				print(string);
				SendAdminMessage(COLOR_GREEN, string);
				return 1;
			}
			if(para1 == 2)
			{
				new dopper;
				dopper = 0;
				new locper, dop11, dop22, dop33;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{//если игрок в коннекте, и заспавнен, то:
						locper = 0;
						dop11 = GetPlayerColor(i);
						dop22 = 0;
						dop33 = 268435456;
						for(new j = 0; j < 8; j++)//перевод десятичного цвет в шестнадцатиричный
						{//(корректировать старший знаковый бит (если число в отрицательном диапазоне) не будем
							dop22 = dop11 / dop33;//из-за ненадобности старших трёх байт)
							dop11 = dop11 - (dop22 * dop33);
							if(j == 6) { locper = locper + dop22 * 16; }//если обнаружен 4-й (младший) байт (7-й и 8-й ниблы), то:
							if(j == 7) { locper = locper + dop22; }//сразу переводим 4-й байт в десятичное число
							dop33 = dop33 / 16;
						}
						if(locper < 128)
						{//если игрок невидимый полностью (или частично), то:
							dopper = 1;
							ColorPlay[i] = ColNick[8];//включаем игроку видимый ник
							SetPlayerColor(i, ColorPlay[i]);
			    			for(new k=0;k<MAX_PLAYERS;k++)
							{
								SetPlayerMarkerForPlayer(k, i, ColorPlay[i]);
							}
						}
					}
				}
				if(dopper == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Невидимых на радаре полностью (или частично) игроков не обнаружено.");
				}
				else
				{
					format(string, sizeof(string), " Администратор %s включил ВСЕМ невидимым полностью (или частично) игрокам видимые ники.",
					RealName[playerid]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
				}
				return 1;
			}
			if(para1 == 3)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " /plclr 3 [ид игрока] !");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
					return 1;
				}
				if(playspa[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Игрок ещё не заспавнился !");
					return 1;
				}
				ColorPlay[para2] = ColNick[17];//устанавливаем игроку цвет ника
				SetPlayerColor(para2, ColorPlay[para2]);
			    for(new i=0;i<MAX_PLAYERS;i++)
				{
					SetPlayerMarkerForPlayer(i, para2, ColorPlay[para2]);
				}
				format(string, sizeof(string), " Администратор %s установил игроку %s цвет ника.", RealName[playerid], RealName[para2]);
				print(string);
				SendAdminMessage(COLOR_GREEN, string);
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//--------------------- команды админов 4 лвл (конец) --------------------------
//--------------------- команды админов 5 лвл (начало) -------------------------
	if(strcmp(cmd, "/tweap", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /tweap [ид игрока/часть ника]");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
 			if(IsPlayerConnected(para1))
 			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				ResetPlayerWeapons(para1);//отбираем оружие и предметы
				format(string, sizeof(string), " Администратор %s отобрал у игрока %s все предметы и всё оружие.",
				RealName[playerid], RealName[para1]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
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
		if(strcmp(cmd, "/setweap", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setweap [ид игрока] [ид предмета или оружия(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [число патронов, зарядов, или штук(1-50000)] или /setweap 600");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 == 600)
			{
				format(strdln, sizeof(strdln), "1 - Кастет     2 - Клюшка для гольфа\
				\n3 - Резиновая дубинка     4 - Нож\
				\n5 - Бейсбольная бита     6 - Лопата\
				\n7 - Кий     8 - Катана");
				format(strdln, sizeof(strdln), "%s\n9 - Бензопила     10 - Дилдо\
				\n15 - Трость     16 - Граната\
				\n17 - Слезоточивый газ     18 - Коктейль Молотова\
				\n22 - Пистолет     23 - Пистолет с глушителем", strdln);
				format(strdln, sizeof(strdln), "%s\n24 - Дезерт иигл     25 - Дробовик\
				\n26 - Обрез     27 - SPAZ 12\
				\n28 - Узи     29 - MP5\
				\n30 - АК-47     31 - М4", strdln);
				format(strdln, sizeof(strdln), "%s\n32 - Tes9     33 - Винтовка\
				\n34 - Снайперская винтовка     35 - Ракетная установка\
				\n36 - РПГ     37 - Огнемёт\
				\n38 - Minigun     39 - Взрывчатка", strdln);
				format(strdln, sizeof(strdln), "%s\n41 - Баллончик с краской     42 - Огнетушитель\
				\n43 - Фотоаппарат     44 - Очки ночного видения\
				\n45 - Инфракрасные очки     46 - Парашют", strdln);
				ShowPlayerDialog(playerid, 2, 0, "ID предметов и оружия:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
				return 1;
			}
			if(playspa[para1] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не заспавнился !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /setweap [ид игрока] [ид предмета или оружия(1-46)]");
				SendClientMessage(playerid, COLOR_RED, " [число патронов, зарядов, или штук(1-50000)] или /setweap 600 !");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 < 1 || para2 > 46 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид предмета или оружия] нет в списке команды !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [число патронов, зарядов, или штук(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " Число патронов, зарядов, или штук - от 1 до 50000 !");
					return 1;
				}
			}
			new para4[64];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "Кастет");
				case 2: format(para4, sizeof(para4), "Клюшку для гольфа");
				case 3: format(para4, sizeof(para4), "Резиновую дубинку");
				case 4: format(para4, sizeof(para4), "Нож");
				case 5: format(para4, sizeof(para4), "Бейсбольную биту");
				case 6: format(para4, sizeof(para4), "Лопату");
				case 7: format(para4, sizeof(para4), "Кий");
				case 8: format(para4, sizeof(para4), "Катану");
				case 9: format(para4, sizeof(para4), "Бензопилу");
				case 10: format(para4, sizeof(para4), "Дилдо");
				case 15: format(para4, sizeof(para4), "Трость");
				case 16: format(para4, sizeof(para4), "Гранату");
				case 17: format(para4, sizeof(para4), "Слезоточивый газ");
				case 18: format(para4, sizeof(para4), "Коктейль Молотова");
				case 22: format(para4, sizeof(para4), "Пистолет");
				case 23: format(para4, sizeof(para4), "Пистолет с глушителем");
				case 24: format(para4, sizeof(para4), "Дезерт иигл");
				case 25: format(para4, sizeof(para4), "Дробовик");
				case 26: format(para4, sizeof(para4), "Обрез");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "Узи");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "АК-47");
				case 31: format(para4, sizeof(para4), "М4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "Винтовку");
				case 34: format(para4, sizeof(para4), "Снайперскую винтовку");
				case 35: format(para4, sizeof(para4), "Ракетную установку");
				case 36: format(para4, sizeof(para4), "РПГ");
				case 37: format(para4, sizeof(para4), "Огнемёт");
				case 38: format(para4, sizeof(para4), "Minigun");
				case 39: format(para4, sizeof(para4), "Взрывчатку");
				case 41: format(para4, sizeof(para4), "Баллончик с краской");
				case 42: format(para4, sizeof(para4), "Огнетушитель");
				case 43: format(para4, sizeof(para4), "Фотоаппарат");
				case 44: format(para4, sizeof(para4), "Очки ночного видения"), para6 = 1;
				case 45: format(para4, sizeof(para4), "Инфракрасные очки"), para6 = 1;
				case 46: format(para4, sizeof(para4), "Парашют");
			}
			if(PlayerInfo[para1][pAdmin] == 0 && para6 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Этот предмет или оружие можно дать только админу !");
				return 1;
			}
			if(para5 == 0)
			{
				GivePlayerWeapon(para1, para2, 1000);
			}
			else
			{
				if(para2 == 37)
				{
					GivePlayerWeapon(para1, para2, para3 * 10);
				}
				else
				{
					GivePlayerWeapon(para1, para2, para3);
					if(para2 == 39) { GivePlayerWeapon(para1, 40, 10); }
				}
			}
			if(para5 == 0)
			{
				format(string, sizeof(string), " Администратор %s дал игроку %s %s .", RealName[playerid], RealName[para1], para4);
			}
			else
			{
				if(para2 >= 16 && para2 <= 18)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s %s ( %d штук ) .", RealName[playerid],
					RealName[para1], para4, para3);
				}
				if((para2 >= 35 && para2 <= 37) || para2 == 39)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s %s и %d зарядов.", RealName[playerid],
					RealName[para1], para4, para3);
				}
				if((para2 >= 22 && para2 <= 34) || para2 == 38)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s %s и %d патронов.", RealName[playerid],
					RealName[para1], para4, para3);
				}
			}
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/playtp", true) == 0)
	{
   		if(PlayerInfo[playerid][pAdmin] >= 5)
    	{
        	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /playtp [ид игрока кого ТП] [ид игрока к кому ТП]");
				return 1;
			}
			new playtp1;
			playtp1 = strval(tmp);
        	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /playtp [ид игрока кого ТП] [ид игрока к кому ТП] !");
				return 1;
			}
			new playtp2;
			playtp2 = strval(tmp);
			if(!IsPlayerConnected(playtp1))
			{
				SendClientMessage(playerid, COLOR_RED, " Игрока, кого ТП, нет на сервере !");
				return 1;
			}
			if(!IsPlayerConnected(playtp2))
			{
				SendClientMessage(playerid, COLOR_RED, " Игрока, к кому ТП, нет на сервере !");
				return 1;
			}
			if(playtp1 == playtp2)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ТП игрока к самому себе !");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] < PlayerInfo[playtp1][pAdmin])
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Уровень админки игрока, кого ТП, выше Вашего !");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[playtp1][pAdmin] == 12)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП - админ 12-го уровня !");
				return 1;
			}
			if(PlayerInfo[playtp1][pAdmin] == 13)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП, защищён !");
				return 1;
			}
			if(PlayerInfo[playtp2][pAdmin] == 13)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, к кому ТП, защищён !");
				return 1;
			}
			if(PlayerInfo[playtp1][pPrisonsec] > 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП, сидит в тюрьме !");
				return 1;
			}
			if(perfrost[playtp1] != 600 && perfrost[playtp1] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП, заморожен ! ( + был заморожен НЕ Вами ! )");
				return 1;
			}
			if(PlayLock1[0][playtp1] != 600 && PlayLock1[0][playtp1] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП, заблокирован ! ( + был заблокирован НЕ Вами ! )");
				return 1;
			}
			if(admper1[playtp1] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП, занят наблюдением !");
				return 1;
			}
			if(admper1[playtp2] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, к кому ТП, занят наблюдением !");
				return 1;
			}
			if(playspa[playtp1] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, кого ТП, ещё не заспавнился !");
				return 1;
			}
			if(playspa[playtp2] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Игрок, к кому ТП, ещё не заспавнился !");
				return 1;
			}
			format(string, 256, " Администратор %s телепортировал игрока %s к игроку %s .", RealName[playerid], RealName[playtp1],
			RealName[playtp2]);
			print(string);
			SendAdminMessage(COLOR_RED,string);
			if(PlayerInfo[playtp1][pAdmin] == 0)
			{
				format(string,256," Администратор %s телепортировал Вас к игроку %s .",RealName[playerid],RealName[playtp2]);
				SendClientMessage(playtp1,COLOR_RED,string);
			}
			new Float:PosX, Float:PosY, Float:PosZ;
			new nmod = GetVehicleModel(GetPlayerVehicleID(playtp1));
			if(nmod == 538 || nmod == 537)
			{//если игрок в поезде, то высадить игрока из поезда
				GetPlayerPos(playtp1, PosX ,PosY, PosZ);
				SetPlayerPos(playtp1, PosX+3, PosY+3, PosZ+5);
			}
			if(PlayLock1[0][playtp1] != 600 && PlayLock1[0][playtp1] == playerid)
			{//если игрок заблокирован, то ТП заблокированного игрока
				PlayLock1[1][playtp1] = GetPlayerInterior(playtp2);//изменение интерьера блокировки
				PlayLock1[2][playtp1] = GetPlayerVirtualWorld(playtp2);//изменение виртуального мира блокировки
				GetPlayerPos(playtp2, PlayLock2[0][playtp1], PlayLock2[1][playtp1], PlayLock2[2][playtp1]);//изменение координат блокировки
				PlayLock2[1][playtp1] = PlayLock2[1][playtp1] + 1;
			}
			else//иначе - ТП НЕ заблокированного игрока
			{
				if(GetPlayerState(playtp1) == 2)//если игрок на месте водителя, то:
				{
					new regm = 1, per1, per2, Float:per3, Float:cor1, Float:cor2, Float:cor3;
					per1 = GetPlayerInterior(playtp2);
					per2 = GetPlayerVirtualWorld(playtp2);
					GetPlayerPos(playtp2, PosX, PosY, PosZ);
					cor1 = PosX;
					cor2 = PosY+1;
					cor3 = PosZ+1;
					LogTelPort(playtp1, regm, per1, per2, Float:per3, Float:cor1, Float:cor2, Float:cor3);
				}
				else//иначе:
				{
					SetPlayerInterior(playtp1, GetPlayerInterior(playtp2));
					SetPlayerVirtualWorld(playtp1, GetPlayerVirtualWorld(playtp2));
					GetPlayerPos(playtp2, PosX, PosY, PosZ);
					SetPlayerPos(playtp1, PosX, PosY+1, PosZ+1);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/edgangs", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /edgangs [режим (0- по ид банды, 1- по ид игрока из банды)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [ид банды или игрока] [ид настройки (0- просмотреть основную информацию");
				SendClientMessage(playerid, COLOR_GRAD2, " о банде, 1- установить название банды, 2- отменить спавн банды,");
				SendClientMessage(playerid, COLOR_GRAD2, " 3- ТП на спавн банды)]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Режим 0 или 1 !");
				return 1;
			}
			if(para1 == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [ид банды] [ид настройки (0- просмотреть основную информацию");
					SendClientMessage(playerid, COLOR_RED, " о банде, 1- установить название банды, 2- отменить спавн банды,");
					SendClientMessage(playerid, COLOR_RED, " 3- ТП на спавн банды)]");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				format(string,sizeof(string),"gangs/%i.ini",para2);
				if(!fexist(string) || para2 >= (MAX_GANGS - 1))
				{
					SendClientMessage(playerid,COLOR_RED," Такого [ид банды] не существует !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [ид настройки (0- просмотреть основную информацию");
					SendClientMessage(playerid, COLOR_RED, " о банде, 1- установить название банды, 2- отменить спавн банды,");
					SendClientMessage(playerid, COLOR_RED, " 3- ТП на спавн банды)]");
					return 1;
				}
				new para3;
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 3)
				{
					SendClientMessage(playerid, COLOR_RED, " Ид настройки от 0 до 3 !");
					return 1;
				}
				if(para3 == 0)
				{
					new dopper[16];
					strdel(dopper, 0, 16);
					strmid(dopper, GColor[para2], 0, 6, sizeof(dopper));
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					format(string, sizeof(string), " Цвет: [%s] Название: [%s]", dopper, GName[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_GRAD1, " Спавн банды:");
					format(string, sizeof(string), " x = %f   y = %f   z = %f", GSpawnX[para2], GSpawnY[para2], GSpawnZ[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " интерьер = %d   виртуальный мир = %d", GInter[para2], GWorld[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " Лидер: [%s] Число игроков: [%d]", GHead[para2], GPlayers[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " Регистрация: [ %s ] ID: [%d]", GTDReg[para2], para2);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					printf(" Администратор %s просмотрел информацию о банде [ID: %d]", RealName[playerid], para2);
					return 1;
				}
				if(para3 == 1)
				{
					new result[128];
					format(result, sizeof(result), "Default - %d", para2);
					if(strcmp(GName[para2],result,false) == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Название банды уже установлено !");
						return 1;
					}
					strdel(GName[para2], 0, 130);//очищаем назване банды
					strcat(GName[para2], result);//устанавливаем назване банды
					GangSave(para2);//запись ID банды в файл
					format(string, sizeof(string), " Администратор %s установил название банды %s [ID: %d]", RealName[playerid], GName[para2], para2);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
				if(para3 == 2)
				{
					if(GSpawnX[para2] == 0.00 && GSpawnY[para2] == 0.00 && GSpawnZ[para2] == 0.00 &&
					GInter[para2] == 0 && GWorld[para2] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Спавн банды уже отменён !");
						return 1;
					}
					GSpawnX[para2] = 0.00;//обнуляем спавн банды
					GSpawnY[para2] = 0.00;
					GSpawnZ[para2] = 0.00;
					GInter[para2] = 0;
					GWorld[para2] = 0;
					GangSave(para2);//запись ID банды в файл
					format(string, sizeof(string), " Администратор %s отменил спавн банды %s [ID: %d]", RealName[playerid], GName[para2], para2);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
				if(para3 == 3)
				{
					if(admper1[playerid] != 600)
					{
						SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта опция не работает !");
						return 1;
					}
					if(GSpawnX[para2] == 0.00 && GSpawnY[para2] == 0.00 && GSpawnZ[para2] == 0.00 &&
					GInter[para2] == 0 && GWorld[para2] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Место спавна банды не назначено !");
						return 1;
					}
					SetPlayerInterior(playerid, GInter[para2]);
					SetPlayerVirtualWorld(playerid, GWorld[para2]);
					SetPlayerPos(playerid, GSpawnX[para2], GSpawnY[para2], GSpawnZ[para2]);
					format(string, sizeof(string), " Администратор %s телепортировался на спавн банды %s [ID: %d]", RealName[playerid], GName[para2], para2);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
			}
			if(para1 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [ид игрока] [ид настройки (0- просмотреть основную информацию");
					SendClientMessage(playerid, COLOR_RED, " о банде, 1- установить название банды, 2- отменить спавн банды,");
					SendClientMessage(playerid, COLOR_RED, " 3- ТП на спавн банды)]");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
					return 1;
				}
				if(gPlayerLogged[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				if(PGang[para2] <= 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок не состоит ни в одной из банд !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [ид настройки (0- просмотреть основную информацию");
					SendClientMessage(playerid, COLOR_RED, " о банде, 1- установить название банды, 2- отменить спавн банды,");
					SendClientMessage(playerid, COLOR_RED, " 3- ТП на спавн банды)]");
					return 1;
				}
				new para3;
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 3)
				{
					SendClientMessage(playerid, COLOR_RED, " Ид настройки от 0 до 3 !");
					return 1;
				}
				if(para3 == 0)
				{
					new dopper[16];
					strdel(dopper, 0, 16);
					strmid(dopper, GColor[PGang[para2]], 0, 6, sizeof(dopper));
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					format(string, sizeof(string), " Цвет: [%s] Название: [%s]", dopper, GName[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_GRAD1, " Спавн банды:");
					format(string, sizeof(string), " x = %f   y = %f   z = %f", GSpawnX[PGang[para2]], GSpawnY[PGang[para2]], GSpawnZ[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " интерьер = %d   виртуальный мир = %d", GInter[PGang[para2]], GWorld[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " Лидер: [%s] Число игроков: [%d]", GHead[PGang[para2]], GPlayers[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " Регистрация: [ %s ] ID: [%d]", GTDReg[PGang[para2]], PGang[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					printf(" Администратор %s просмотрел информацию о банде [ID: %d]", RealName[playerid], PGang[para2]);
					return 1;
				}
				if(para3 == 1)
				{
					new result[128];
					format(result, sizeof(result), "Default - %d", PGang[para2]);
					if(strcmp(GName[PGang[para2]],result,false) == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Название банды уже установлено !");
						return 1;
					}
					strdel(GName[PGang[para2]], 0, 130);//очищаем назване банды
					strcat(GName[PGang[para2]], result);//устанавливаем назване банды
					GangSave(PGang[para2]);//запись ID банды в файл
					format(string, sizeof(string), " Администратор %s установил название банды %s [ID: %d]", RealName[playerid], GName[PGang[para2]], PGang[para2]);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
				}
				if(para3 == 2)
				{
					if(GSpawnX[PGang[para2]] == 0.00 && GSpawnY[PGang[para2]] == 0.00 && GSpawnZ[PGang[para2]] == 0.00 &&
					GInter[PGang[para2]] == 0 && GWorld[PGang[para2]] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Спавн банды уже отменён !");
						return 1;
					}
					GSpawnX[PGang[para2]] = 0.00;//обнуляем спавн банды
					GSpawnY[PGang[para2]] = 0.00;
					GSpawnZ[PGang[para2]] = 0.00;
					GInter[PGang[para2]] = 0;
					GWorld[PGang[para2]] = 0;
					GangSave(PGang[para2]);//запись ID банды в файл
					format(string, sizeof(string), " Администратор %s отменил спавн банды %s [ID: %d]", RealName[playerid], GName[PGang[para2]], PGang[para2]);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
				if(para3 == 3)
				{
					if(admper1[playerid] != 600)
					{
						SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта опция не работает !");
						return 1;
					}
					if(GSpawnX[PGang[para2]] == 0.00 && GSpawnY[PGang[para2]] == 0.00 && GSpawnZ[PGang[para2]] == 0.00 &&
					GInter[PGang[para2]] == 0 && GWorld[PGang[para2]] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Место спавна банды не назначено !");
						return 1;
					}
					SetPlayerInterior(playerid, GInter[PGang[para2]]);
					SetPlayerVirtualWorld(playerid, GWorld[PGang[para2]]);
					SetPlayerPos(playerid, GSpawnX[PGang[para2]], GSpawnY[PGang[para2]], GSpawnZ[PGang[para2]]);
					format(string, sizeof(string), " Администратор %s телепортировался на спавн банды %s [ID: %d]", RealName[playerid], GName[PGang[para2]], PGang[para2]);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
//--------------------- команды админов 5 лвл (конец) --------------------------
//--------------------- команды админов 6 лвл (начало) -------------------------
	if(strcmp(cmd, "/banakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 6)
    	{
   			new data2[2];
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /banakk [имя аккаунта] [причина]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			new file;//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "AdminLevel", data2[0]);
				ini_getInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//проверка аккаунта на On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data2[0] < 0)
			{
				fadm = data2[0] * -1;
			}
			else
			{
				fadm = data2[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//проверка аккаунта на админку
			{
				format(ssss,sizeof(ssss)," Нельзя, аккаунт игрока [%s] - админ %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(data2[1] == 1)//если аккаунт был заблокирован, то:
			{
				format(ssss,sizeof(ssss)," Аккаунт игрока [%s] уже заблокирован (забанен) !", akk);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			data2[1] = 1;//блокировка аккаунта
			strdel(ssss, 0, 256);//сборка RCON-команды бана
			strcat(ssss, "banip ");
			strcat(ssss, adrip);
			SendRconCommand(ssss);//RCON-команда бана
			SendRconCommand("reloadbans");//RCON-команда перезагрузки бан-листа
			file = ini_openFile(string);//запись изменённого аккаунта
			if(file >= 0)
			{
				ini_setInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			format(ssss,sizeof(ssss)," Администратор %s забанил аккаунт игрока [%s] ( IP: [%s] ) , причина: %s",
			RealName[playerid], akk, adrip, result);
			print(ssss);
			SendAdminMessage(COLOR_RED, ssss);
			format(ssss,sizeof(ssss)," Администратор %s забанил аккаунт игрока [%s] , причина: %s", RealName[playerid], akk, result);
			for(new i=0;i<MAX_PLAYERS;i++)//отправка сообщения НЕ админам
			{
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				{
					SendClientMessage(i, COLOR_RED, ssss);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/tweaprad", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			new Float: X, Float:Y, Float: Z, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playvw = GetPlayerVirtualWorld(playerid);
			new per55 = 0;
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 100.0, X, Y, Z) && GetPlayerVirtualWorld(i) == playvw && i != playerid)
					{
						per55 = 1;
						ResetPlayerWeapons(i);//отбираем оружие и предметы
					}
				}
			}
			if(per55 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " Игроков поблизости не обнаружено !");
			}
			else
			{
				format(string, sizeof(string), " Администратор %s отобрал у всех игроков все предметы и всё оружие",
				RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
				format(string, sizeof(string), " *** в радиусе 100 координатных единиц.");
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/setweapall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setweapall [ид предмета или оружия(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [число патронов, зарядов, или штук(1-50000)] или /setweapall 600");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 == 600)
			{
				format(strdln, sizeof(strdln), "1 - Кастет     2 - Клюшка для гольфа\
				\n3 - Резиновая дубинка     4 - Нож\
				\n5 - Бейсбольная бита     6 - Лопата\
				\n7 - Кий     8 - Катана");
				format(strdln, sizeof(strdln), "%s\n9 - Бензопила     14 - Букет цветов\
				\n15 - Трость     16 - Граната\
				\n17 - Слезоточивый газ     18 - Коктейль Молотова\
				\n22 - Пистолет     23 - Пистолет с глушителем", strdln);
				format(strdln, sizeof(strdln), "%s\n24 - Дезерт иигл     25 - Дробовик\
				\n26 - Обрез     27 - SPAZ 12\
				\n28 - Узи     29 - MP5\
				\n30 - АК-47     31 - М4", strdln);
				format(strdln, sizeof(strdln), "%s\n32 - Tes9     33 - Винтовка\
				\n34 - Снайперская винтовка     35 - Ракетная установка\
				\n36 - РПГ     37 - Огнемёт\
				\n38 - Minigun     39 - Взрывчатка", strdln);
				format(strdln, sizeof(strdln), "%s\n41 - Баллончик с краской     42 - Огнетушитель\
				\n43 - Фотоаппарат     44 - Очки ночного видения\
				\n45 - Инфракрасные очки     46 - Парашют", strdln);
				ShowPlayerDialog(playerid, 2, 0, "ID предметов и оружия:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(para2 < 1 || para2 > 46 || para2 == 10 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид предмета или оружия] нет в списке команды !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [число патронов, зарядов, или штук(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " Число патронов, зарядов, или штук - от 1 до 50000 !");
					return 1;
				}
			}
			new para4[64];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "Кастету");
				case 2: format(para4, sizeof(para4), "Клюшке для гольфа");
				case 3: format(para4, sizeof(para4), "Резиновой дубинке");
				case 4: format(para4, sizeof(para4), "Ножу");
				case 5: format(para4, sizeof(para4), "Бейсбольной бите");
				case 6: format(para4, sizeof(para4), "Лопате");
				case 7: format(para4, sizeof(para4), "Кию");
				case 8: format(para4, sizeof(para4), "Катане");
				case 9: format(para4, sizeof(para4), "Бензопиле");
				case 14: format(para4, sizeof(para4), "Букету цветов");
				case 15: format(para4, sizeof(para4), "Трости");
				case 16: format(para4, sizeof(para4), "Гранате");
				case 17: format(para4, sizeof(para4), "Слезоточивому газу");
				case 18: format(para4, sizeof(para4), "Коктейлю Молотова");
				case 22: format(para4, sizeof(para4), "Пистолету");
				case 23: format(para4, sizeof(para4), "Пистолету с глушителем");
				case 24: format(para4, sizeof(para4), "Дезерт иигл");
				case 25: format(para4, sizeof(para4), "Дробовику");
				case 26: format(para4, sizeof(para4), "Обрезу");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "Узи");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "АК-47");
				case 31: format(para4, sizeof(para4), "М4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "Винтовке");
				case 34: format(para4, sizeof(para4), "Снайперской винтовке");
				case 35: format(para4, sizeof(para4), "Ракетной установке");
				case 36: format(para4, sizeof(para4), "РПГ");
				case 37: format(para4, sizeof(para4), "Огнемёту");
				case 38: format(para4, sizeof(para4), "Minigun");
				case 39: format(para4, sizeof(para4), "Взрывчатке");
				case 41: format(para4, sizeof(para4), "Баллончику с краской");
				case 42: format(para4, sizeof(para4), "Огнетушителю");
				case 43: format(para4, sizeof(para4), "Фотоаппарату");
				case 44: format(para4, sizeof(para4), "Очкам ночного видения"), para6 = 1;
				case 45: format(para4, sizeof(para4), "Инфракрасным очкам"), para6 = 1;
				case 46: format(para4, sizeof(para4), "Парашюту");
			}
			new para777 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(playspa[i] == 1 && PlayerInfo[i][pAdmin] >= 1 && para6 == 1)
					{
						if(para5 == 0)
						{
							para777 = 1;
							GivePlayerWeapon(i, para2, 1000);
						}
						else
						{
							para777 = 1;
							if(para2 == 37)
							{
								GivePlayerWeapon(i, para2, para3 * 10);
							}
							else
							{
								GivePlayerWeapon(i, para2, para3);
								if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
							}
						}
					}
					if(playspa[i] == 1 && para6 == 0)
					{
						if(para5 == 0)
						{
							para777 = 1;
							GivePlayerWeapon(i, para2, 1000);
						}
						else
						{
							para777 = 1;
							if(para2 == 37)
							{
								GivePlayerWeapon(i, para2, para3 * 10);
							}
							else
							{
								GivePlayerWeapon(i, para2, para3);
								if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
							}
						}
					}
				}
			}
			if(para777 == 1)
			{
				if(para5 == 0)
				{
					format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s .", RealName[playerid], para4);
				}
				else
				{
					if(para2 >= 16 && para2 <= 18)
					{
						format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s ( по %d штук каждому ) .",
						RealName[playerid], para4, para3);
					}
					if((para2 >= 35 && para2 <= 37) || para2 == 39)
					{
						format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s , и по %d зарядов каждому.",
						RealName[playerid], para4, para3);
					}
					if((para2 >= 22 && para2 <= 34) || para2 == 38)
					{
						format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s , и по %d патронов каждому.",
						RealName[playerid], para4, para3);
					}
				}
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " Ни один из игроков не получил назначенный Вами ИД предмета или оружия !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/plcmon", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /plcmon [0- выкл., 1- вкл., 2- просмотреть настройки]");
				SendClientMessage(playerid, COLOR_GRAD2, " ( дополнительно [дальность определения(10-1000)] )");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 2)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- выкл., 1- вкл., 2- просмотреть настройки !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new para2;
			new para3;
			if(!strlen(tmp))
			{
				para2 = 500;
				para3 = 0;
			}
			else
			{
				para2 = strval(tmp);
				para3 = 1;
			}
			if(para2 < 10 || para2 > 1000)
			{
				SendClientMessage(playerid, COLOR_RED, " Дальность определения от 10 до 1000 !");
				return 1;
			}
			if(para1 == 0)
			{
				if(plcmonloc[playerid] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Краш-монитор в чате уже отключен !");
					return 1;
				}
				else
				{
					plcmonloc[playerid] = 0;
					format(string, sizeof(string), " Администратор %s отключил краш-монитор.", RealName[playerid]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					return 1;
				}
			}
			if(para1 == 1)
			{
				if(plcmonloc[playerid] == 1 && para3 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Вы не задали дальность определения !");
					return 1;
				}
				if(plcmonloc[playerid] == 1 && para3 == 1 && plcmondist[playerid] == para2)
				{
					SendClientMessage(playerid, COLOR_RED, " Вы задали старую дальность определения !");
					return 1;
				}
				if(plcmonloc[playerid] == 1 && para3 == 1 && plcmondist[playerid] != para2)
				{
					plcmondist[playerid] = para2;
					format(string, sizeof(string), " Администратор %s изменил дальность определения для краш-монитора на %d",
					RealName[playerid], plcmondist[playerid]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
					return 1;
				}
				if(plcmonloc[playerid] == 0)
				{
					plcmonloc[playerid] = 1;
					plcmondist[playerid] = para2;
					format(string, sizeof(string), " Администратор %s включил краш-монитор, с дальностью определения %d",
					RealName[playerid], plcmondist[playerid]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
					return 1;
				}
			}
			if(para1 == 2)
			{
				if(plcmonloc[playerid] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Краш-монитор отключен.");
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
					SendClientMessage(playerid, COLOR_GREEN, " Краш-монитор включен.");
					format(string, sizeof(string), " Дальность определения: {FFFF00}%d .", plcmondist[playerid]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
					printf(" Администратор %s просмотрел настройки краш-монитора.", RealName[playerid]);
					return 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//--------------------- команды админов 6 лвл (конец) --------------------------
//--------------------- команды админов 7 лвл (начало) -------------------------
	if(strcmp(cmd, "/money", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /money [ид игрока/часть ника] [сумма] [причина]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали сумму и причину !");
				return 1;
			}
			money = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				new dopper44;
				dopper44 = GetPlayerMoney(playa);
				if(money < 0)
				{
					SetPVarInt(playa, "MonControl", 1);
					GivePlayerMoney(playa, money);
					format(string, 256, " Администратор %s изъял у игрока %s %d $ , причина: %s", RealName[playerid], RealName[playa],
					money, result);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_RED, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_RED, string);
					}
					printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[playa], playa, dopper44);
				}
				else
				{
					new twenlim, restlim;
					if(Fmadmins(2, RealName[playerid], money, twenlim, restlim) == 1)
					{
						SetPVarInt(playa, "MonControl", 1);
						GivePlayerMoney(playa, money);
						format(string, 256, " Администратор %s дал игроку %s %d $ , причина: %s", RealName[playerid], RealName[playa],
						money, result);
						print(string);
						if (PlayerInfo[playa][pAdmin] >= 1)
						{
							SendAdminMessage(COLOR_YELLOW, string);
						}
						else
						{
							SendClientMessageToAll(COLOR_YELLOW, string);
						}
						printf(" Администратор %s >> Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", RealName[playerid],
						twenlim, restlim);
						printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[playa], playa, dopper44);
					}
					else
					{
						if(restlim == 0)
						{
							SendClientMessage(playerid, COLOR_RED, " Нельзя ! Вы израсходовали суточный денежный лимит !");
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, " Нельзя ! У Вас недостаточный остаток денежного лимита !");
						}
					}
					if(twenlim != 0)
					{
						format(string, 256, " Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", twenlim, restlim);
						SendClientMessage(playerid, COLOR_RED, string);
					}
				}
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
		if(strcmp(cmd, "/setweap", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setweap [ид игрока] [ид предмета или оружия(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [число патронов, зарядов, или штук(1-50000)] или /setweap 600");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 == 600)
			{
				new soob11[256];
				format(soob11, sizeof(soob11), "1 - Кастет     2 - Клюшка для гольфа\
				\n3 - Резиновая дубинка     4 - Нож\
				\n5 - Бейсбольная бита     6 - Лопата\
				\n7 - Кий     8 - Катана");
				new soob12[256];
				format(soob12, sizeof(soob12), "\n9 - Бензопила     14 - Букет цветов\
				\n15 - Трость     16 - Граната\
				\n17 - Слезоточивый газ     18 - Коктейль Молотова\
				\n22 - Пистолет     23 - Пистолет с глушителем");
				new soob13[256];
				format(soob13, sizeof(soob13), "\n24 - Дезерт иигл     25 - Дробовик\
				\n26 - Обрез     27 - SPAZ 12\
				\n28 - Узи     29 - MP5\
				\n30 - АК-47     31 - М4");
				new soob14[256];
				format(soob14, sizeof(soob14), "\n32 - Tes9     33 - Винтовка\
				\n34 - Снайперская винтовка     35 - Ракетная установка\
				\n36 - РПГ     37 - Огнемёт\
				\n38 - Minigun     39 - Взрывчатка");
				new soob15[256];
				format(soob15, sizeof(soob15), "\n41 - Баллончик с краской     42 - Огнетушитель\
				\n43 - Фотоаппарат     44 - Очки ночного видения\
				\n45 - Инфракрасные очки     46 - Парашют");
				new soob[1280];
				format(soob, sizeof(soob), "%s%s%s%s%s", soob11, soob12, soob13, soob14, soob15);
				ShowPlayerDialog(playerid, 2, 0, "ID предметов и оружия:", soob, "OK", "");
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
				return 1;
			}
			if(DerbyID[para1] == 2)
			{
				SendClientMessage(playerid, COLOR_RED, " Нельзя ! Выбранный игрок в зоне дерби !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /setweap [ид игрока] [ид предмета или оружия(1-46)]");
				SendClientMessage(playerid, COLOR_RED, " [число патронов, зарядов, или штук(1-50000)] или /setweap 600 !");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 < 1 || para2 > 46 || para2 == 10 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид предмета или оружия] нет в списке команды !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [число патронов, зарядов, или штук(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " Число патронов, зарядов, или штук - от 1 до 50000 !");
					return 1;
				}
			}
			new para4[256];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "Кастет");
				case 2: format(para4, sizeof(para4), "Клюшку для гольфа");
				case 3: format(para4, sizeof(para4), "Резиновую дубинку");
				case 4: format(para4, sizeof(para4), "Нож");
				case 5: format(para4, sizeof(para4), "Бейсбольную биту");
				case 6: format(para4, sizeof(para4), "Лопату");
				case 7: format(para4, sizeof(para4), "Кий");
				case 8: format(para4, sizeof(para4), "Катану");
				case 9: format(para4, sizeof(para4), "Бензопилу");
				case 14: format(para4, sizeof(para4), "Букет цветов");
				case 15: format(para4, sizeof(para4), "Трость");
				case 16: format(para4, sizeof(para4), "Гранату");
				case 17: format(para4, sizeof(para4), "Слезоточивый газ");
				case 18: format(para4, sizeof(para4), "Коктейль Молотова");
				case 22: format(para4, sizeof(para4), "Пистолет");
				case 23: format(para4, sizeof(para4), "Пистолет с глушителем");
				case 24: format(para4, sizeof(para4), "Дезерт иигл");
				case 25: format(para4, sizeof(para4), "Дробовик");
				case 26: format(para4, sizeof(para4), "Обрез");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "Узи");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "АК-47");
				case 31: format(para4, sizeof(para4), "М4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "Винтовку");
				case 34: format(para4, sizeof(para4), "Снайперскую винтовку");
				case 35: format(para4, sizeof(para4), "Ракетную установку"), para6 = 1;
				case 36: format(para4, sizeof(para4), "РПГ"), para6 = 1;
				case 37: format(para4, sizeof(para4), "Огнемёт"), para6 = 1;
				case 38: format(para4, sizeof(para4), "Minigun"), para6 = 1;
				case 39: format(para4, sizeof(para4), "Взрывчатку");
				case 41: format(para4, sizeof(para4), "Баллончик с краской");
				case 42: format(para4, sizeof(para4), "Огнетушитель");
				case 43: format(para4, sizeof(para4), "Фотоаппарат");
				case 44: format(para4, sizeof(para4), "Очки ночного видения"), para6 = 1;
				case 45: format(para4, sizeof(para4), "Инфракрасные очки"), para6 = 1;
				case 46: format(para4, sizeof(para4), "Парашют");
			}
			if(PlayerInfo[para1][pAdmin] == 0 && para6 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Этот предмет или оружие можно дать только админу !");
				return 1;
			}
			if(para5 == 0)
			{
				GivePlayerWeapon(para1, para2, 1000);
				return 1;
			}
			else
			{
				if(para2 == 37)
				{
					GivePlayerWeapon(para1, para2, para3 * 10);
				}
				else
				{
					GivePlayerWeapon(para1, para2, para3);
					if(para2 == 39) { GivePlayerWeapon(para1, 40, 10); }
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			if(para5 == 0)
			{
				format(string, sizeof(string), " Администратор %s дал игроку %s %s .", sendername, giveplayer, para4);
			}
			else
			{
				if(para2 >= 16 && para2 <= 18)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s %s ( %d штук ) .", sendername, giveplayer, para4, para3);
				}
				if((para2 >= 35 && para2 <= 37) || para2 == 39)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s %s и %d зарядов.", sendername, giveplayer, para4, para3);
				}
				if((para2 >= 22 && para2 <= 34) || para2 == 38)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s %s и %d патронов.", sendername, giveplayer, para4, para3);
				}
			}
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setweapall", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 6)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setweapall [ид предмета или оружия(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [число патронов, зарядов, или штук(1-50000)] или /setweapall 600");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 == 600)
			{
				new soob11[256];
				format(soob11, sizeof(soob11), "1 - Кастет     2 - Клюшка для гольфа\
				\n3 - Резиновая дубинка     4 - Нож\
				\n5 - Бейсбольная бита     6 - Лопата\
				\n7 - Кий     8 - Катана");
				new soob12[256];
				format(soob12, sizeof(soob12), "\n9 - Бензопила     14 - Букет цветов\
				\n15 - Трость     16 - Граната\
				\n17 - Слезоточивый газ     18 - Коктейль Молотова\
				\n22 - Пистолет     23 - Пистолет с глушителем");
				new soob13[256];
				format(soob13, sizeof(soob13), "\n24 - Дезерт иигл     25 - Дробовик\
				\n26 - Обрез     27 - SPAZ 12\
				\n28 - Узи     29 - MP5\
				\n30 - АК-47     31 - М4");
				new soob14[256];
				format(soob14, sizeof(soob14), "\n32 - Tes9     33 - Винтовка\
				\n34 - Снайперская винтовка     35 - Ракетная установка\
				\n36 - РПГ     37 - Огнемёт\
				\n38 - Minigun     39 - Взрывчатка");
				new soob15[256];
				format(soob15, sizeof(soob15), "\n41 - Баллончик с краской     42 - Огнетушитель\
				\n43 - Фотоаппарат     44 - Очки ночного видения\
				\n45 - Инфракрасные очки     46 - Парашют");
				new soob[1280];
				format(soob, sizeof(soob), "%s%s%s%s%s", soob11, soob12, soob13, soob14, soob15);
				ShowPlayerDialog(playerid, 2, 0, "ID предметов и оружия:", soob, "OK", "");
				return 1;
			}
			if(para2 < 1 || para2 > 46 || para2 == 10 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид предмета или оружия] нет в списке команды !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [число патронов, зарядов, или штук(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " Число патронов, зарядов, или штук - от 1 до 50000 !");
					return 1;
				}
			}
			new para4[256];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "Кастету");
				case 2: format(para4, sizeof(para4), "Клюшке для гольфа");
				case 3: format(para4, sizeof(para4), "Резиновой дубинке");
				case 4: format(para4, sizeof(para4), "Ножу");
				case 5: format(para4, sizeof(para4), "Бейсбольной бите");
				case 6: format(para4, sizeof(para4), "Лопате");
				case 7: format(para4, sizeof(para4), "Кию");
				case 8: format(para4, sizeof(para4), "Катане");
				case 9: format(para4, sizeof(para4), "Бензопиле");
				case 14: format(para4, sizeof(para4), "Букету цветов");
				case 15: format(para4, sizeof(para4), "Трости");
				case 16: format(para4, sizeof(para4), "Гранате");
				case 17: format(para4, sizeof(para4), "Слезоточивому газу");
				case 18: format(para4, sizeof(para4), "Коктейлю Молотова");
				case 22: format(para4, sizeof(para4), "Пистолету");
				case 23: format(para4, sizeof(para4), "Пистолету с глушителем");
				case 24: format(para4, sizeof(para4), "Дезерт иигл");
				case 25: format(para4, sizeof(para4), "Дробовику");
				case 26: format(para4, sizeof(para4), "Обрезу");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "Узи");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "АК-47");
				case 31: format(para4, sizeof(para4), "М4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "Винтовке");
				case 34: format(para4, sizeof(para4), "Снайперской винтовке");
				case 35: format(para4, sizeof(para4), "Ракетной установке"), para6 = 1;
				case 36: format(para4, sizeof(para4), "РПГ"), para6 = 1;
				case 37: format(para4, sizeof(para4), "Огнемёту"), para6 = 1;
				case 38: format(para4, sizeof(para4), "Minigun"), para6 = 1;
				case 39: format(para4, sizeof(para4), "Взрывчатке");
				case 41: format(para4, sizeof(para4), "Баллончику с краской");
				case 42: format(para4, sizeof(para4), "Огнетушителю");
				case 43: format(para4, sizeof(para4), "Фотоаппарату");
				case 44: format(para4, sizeof(para4), "Очкам ночного видения"), para6 = 1;
				case 45: format(para4, sizeof(para4), "Инфракрасным очкам"), para6 = 1;
				case 46: format(para4, sizeof(para4), "Парашюту");
			}
			new para777 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && playspa[i] == 1 && PlayerInfo[i][pAdmin] >= 1 && para6 == 1 && DerbyID[i] == 0)
				{
					if(para5 == 0)
					{
						para777 = 1;
						GivePlayerWeapon(i, para2, 1000);
					}
					else
					{
						para777 = 1;
						if(para2 == 37)
						{
							GivePlayerWeapon(i, para2, para3 * 10);
						}
						else
						{
							GivePlayerWeapon(i, para2, para3);
							if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
						}
					}
				}
				if(IsPlayerConnected(i) && playspa[i] == 1 && para6 == 0 && DerbyID[i] == 0)
				{
					if(para5 == 0)
					{
						para777 = 1;
						GivePlayerWeapon(i, para2, 1000);
					}
					else
					{
						para777 = 1;
						if(para2 == 37)
						{
							GivePlayerWeapon(i, para2, para3 * 10);
						}
						else
						{
							GivePlayerWeapon(i, para2, para3);
							if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
						}
					}
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(para777 == 1)
			{
				if(para5 == 0)
				{
					format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s .", sendername, para4);
				}
				else
				{
					if(para2 >= 16 && para2 <= 18)
					{
						format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s ( по %d штук каждому ) .", sendername, para4, para3);
					}
					if((para2 >= 35 && para2 <= 37) || para2 == 39)
					{
						format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s , и по %d зарядов каждому.", sendername, para4, para3);
					}
					if((para2 >= 22 && para2 <= 34) || para2 == 38)
					{
						format(string, sizeof(string), " Администратор %s раздал всем игрокам по %s , и по %d патронов каждому.", sendername, para4, para3);
					}
				}
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " Ни один из игроков не получил назначенный Вами ИД предмета или оружия !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
 	if(strcmp(cmd, "/setmonall", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setmonall [сумма]");
				return 1;
			}
			new money;
			money = strval(tmp);
			if(money < 0) { SendClientMessage(playerid, COLOR_RED, " Сумма не может быть отрицательным числом !"); return 1; }
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && playspa[i] == 1)
				{
					SetPVarInt(i, "PlMon", money);
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 256, " Администратор %s установил всем игрокам по %d $", sendername,money);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
 	if(strcmp(cmd, "/moneyall", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /moneyall [сумма] [причина]");
				return 1;
			}
			new money;
			money = strval(tmp);
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
			if(money < 0)
			{
				money = money * -1;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{
						SetPVarInt(i, "PlMon", GetPVarInt(i, "PlMon") - money);
					}
				}
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, 256, " Администратор %s изъял у всех игроков по %d $ , причина: %s", sendername,money,result);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{
						SetPVarInt(i, "PlMon", GetPVarInt(i, "PlMon") + money);
					}
				}
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, 256, " Администратор %s раздал всем игрокам по %d $ , причина: %s ", sendername,money,result);
				print(string);
				SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setmon", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setmon [ид игрока/часть ника] [сумма]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали сумму !");
				return 1;
			}
			money = strval(tmp);
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				if(money < 0) { SendClientMessage(playerid, COLOR_RED, " Сумма не может быть отрицательным числом !"); return 1; }
				new dopper44;
				dopper44 = GetPlayerMoney(playa);
				new twenlim, restlim;
				if(Fmadmins(2, RealName[playerid], money, twenlim, restlim) == 1)
				{
					SetPVarInt(playa, "MonControl", 1);
					ResetPlayerMoney(playa);
					GivePlayerMoney(playa, money);
					format(string, 256, " Администратор %s установил игроку %s %d $", RealName[playerid], RealName[playa], money);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_YELLOW, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_YELLOW, string);
					}
					printf(" Администратор %s >> Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", RealName[playerid],
					twenlim, restlim);
					printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[playa], playa, dopper44);
				}
				else
				{
					if(restlim == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Нельзя ! Вы израсходовали суточный денежный лимит !");
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, " Нельзя ! У Вас недостаточный остаток денежного лимита !");
					}
				}
				if(twenlim != 0)
				{
					format(string, 256, " Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", twenlim, restlim);
					SendClientMessage(playerid, COLOR_RED, string);
				}
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
	if(strcmp(cmd, "/live", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			if(PlayerInfo[playerid][pAdmlive] == 1)
			{
				PlayerInfo[playerid][pAdmlive] = 0;
				format(string, sizeof(string), " Администратор %s выключил собственное бессмертие.", RealName[playerid]);
				print(string);
				SendAdminMessage(COLOR_RED, string);
				return 1;
			}
			else
			{
				PlayerInfo[playerid][pAdmlive] = 1;
				format(string, sizeof(string), " Администратор %s включил собственное бессмертие.", RealName[playerid]);
				print(string);
				SendAdminMessage(COLOR_GREEN, string);
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/admtp", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			new dopper1 = 0;
			new Float:PosX, Float:PosY, Float:PosZ;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(playspa[i] == 1 && (PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] <= 12) && i != playerid)
					{
						dopper1 = 1;
						if(PlayerInfo[i][pPrisonsec] > 0)//если админ в тюрьме, то:
						{
							PlayerInfo[i][pPrison]--;
							PlayerInfo[i][pPrisonsec] = 0;
							weapstatplay[i] = 0;
							SpawnPlayer(i);//респавн админа
							SendClientMessage(i, COLOR_GREEN, "* Амнистия ( по команде /admtp )");
							SetTimerEx("DopAdmtp", 1000, 0, "ii", playerid, i);
						}
						else
						{
							if(PlayLock1[0][i] != 600)//если админ заблокирован, то:
							{
								PlayLock1[1][i] = GetPlayerInterior(playerid);//изменение интерьера блокировки
								PlayLock1[2][i] = GetPlayerVirtualWorld(playerid);//изменение виртуального мира блокировки
								GetPlayerPos(playerid, PlayLock2[0][i], PlayLock2[1][i], PlayLock2[2][i]);//изменение координат блокировки
								PlayLock2[1][i] = PlayLock2[1][i] + 1;
							}
							else
							{
								if(admper1[i] != 600)//если админ в наблюдении, то:
								{
									TogglePlayerSpectating(i, 0);//запретить наблюдение для админа
									admper6[i] = 0;//обнуляем отметку о переключении наблюдения
									SetTimerEx("DopAdmtp", 1000, 0, "ii", playerid, i);
								}
								else
								{
			 						SetPlayerInterior(i, GetPlayerInterior(playerid));
									SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
			   						GetPlayerPos(playerid, PosX, PosY, PosZ);
									SetPlayerPos(i, PosX, PosY+1, PosZ+1);
								}
							}
						}
					}
				}
			}
            if(dopper1 == 1)
            {
				format(string, 256, " Администратор %s телепортировал всех админов к себе.", RealName[playerid]);
				print(string);
				SendAdminMessage(COLOR_RED, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " Нет доступных админов для ТП к себе !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/konec", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			if(nucexplos == 0)
			{
				SetWeather(19);
				SetWorldTime(0);
				new Float:sx, Float:sy, Float:sz;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						SnowONOFF[i] = 1;
						SetPlayerArmour(i, 100);
						SetPlayerHealth(i, 100);
						GetPlayerCameraPos(i, sx, sy, sz);
						snowobj[i] = CreatePlayerObject(i, 18864, sx, sy, sz-5, 0.0, 0.0, 0.0, 300.0);
					}
				}
				format(string, sizeof(string), "{458B74}[NEWS]: {FF0000}Произошел ядерный взрыв! Всем срочно найти укрытие!!", RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
				nucexplos = 1;
				nucexptime = 0;
			}
			else
			{
				SetWeather(1);
				gettime(timedata[0], timedata[1]);
				SetWorldTime(timedata[0]);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						SnowONOFF[i] = 0;
						DestroyPlayerObject(i,snowobj[i]);
					}
				}
				format(string, sizeof(string), "{458B74}[NEWS]:{FF0000} Разрушительная волна прошла ", RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
				nucexplos = 0;
				nucexptime = 0;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//--------------------- команды админов 7 лвл (конец) --------------------------
//--------------------- команды админов 8 лвл (начало) -------------------------
	if(strcmp(cmd, "/moneyall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 8)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /moneyall [сумма] [причина]");
				return 1;
			}
			new money;
			money = strval(tmp);
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
			new dopper44;
			if(money < 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gPlayerLogged[i] == 1)
						{
							if(money > 1000) { dopper44 = GetPlayerMoney(i); }
							SetPVarInt(i, "MonControl", 1);
							GivePlayerMoney(i, money);
							if(money > 1000)
							{
								printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[i], i, dopper44);
							}
						}
					}
				}
				format(string, 256, " Администратор %s изъял у всех игроков по %d $ , причина: %s", RealName[playerid], money, result);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				new para22 = 0;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gPlayerLogged[i] == 1)
						{
							para22++;
						}
					}
				}
				para22 = para22 * money;
				new twenlim, restlim;
				if(Fmadmins(2, RealName[playerid], para22, twenlim, restlim) == 1)
				{
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))
						{
							if(gPlayerLogged[i] == 1)
							{
								if(money > 1000) { dopper44 = GetPlayerMoney(i); }
								SetPVarInt(i, "MonControl", 1);
								GivePlayerMoney(i, money);
								if(money > 1000)
								{
									printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[i], i, dopper44);
								}
							}
						}
					}
					format(string, 256, " Администратор %s раздал всем игрокам по %d $ , причина: %s", RealName[playerid], money, result);
					print(string);
					SendClientMessageToAll(COLOR_YELLOW, string);
					printf(" Администратор %s >> Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", RealName[playerid],
					twenlim, restlim);
				}
				else
				{
					if(restlim == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Нельзя ! Вы израсходовали суточный денежный лимит !");
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, " Нельзя ! У Вас недостаточный остаток денежного лимита !");
					}
				}
				if(twenlim != 0)
				{
					format(string, 256, " Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", twenlim, restlim);
					SendClientMessage(playerid, COLOR_RED, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setmonall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 8)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setmonall [сумма]");
				return 1;
			}
			new money;
			money = strval(tmp);
			if(money < 0) { SendClientMessage(playerid, COLOR_RED, " Сумма не может быть отрицательным числом !"); return 1; }
			new para22 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerLogged[i] == 1)
					{
						para22++;
					}
				}
			}
			para22 = para22 * money;
			new twenlim, restlim;
			if(Fmadmins(2, RealName[playerid], para22, twenlim, restlim) == 1)
			{
				new dopper44;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gPlayerLogged[i] == 1)
						{
							if(money > 1000) { dopper44 = GetPlayerMoney(i); }
							SetPVarInt(i, "MonControl", 1);
							ResetPlayerMoney(i);
							GivePlayerMoney(i, money);
							if(money > 1000)
							{
								printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[i], i, dopper44);
							}
						}
					}
				}
				format(string, 256, " Администратор %s установил всем игрокам по %d $", RealName[playerid], money);
				print(string);
				SendClientMessageToAll(COLOR_YELLOW, string);
				printf(" Администратор %s >> Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", RealName[playerid],
				twenlim, restlim);
			}
			else
			{
				if(restlim == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Нельзя ! Вы израсходовали суточный денежный лимит !");
				}
				else
				{
					SendClientMessage(playerid, COLOR_RED, " Нельзя ! У Вас недостаточный остаток денежного лимита !");
				}
			}
			if(twenlim != 0)
			{
				format(string, 256, " Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", twenlim, restlim);
				SendClientMessage(playerid, COLOR_RED, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/fmess", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 8)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /fmess [цвет(0-19)] [сообщение] , или /fmess 600");
				return 1;
			}
			new color;
			color = strval(tmp);
			if(color < 0 || (color > 19 && color < 600) || color > 600)
			{
				SendClientMessage(playerid, COLOR_RED, " Цвет(0-19) , или 600 !");
				return 1;
			}
			if(color == 600)
			{
				format(strdln, sizeof(strdln), "{A9C4E4}0 - {FF0000}Красный\
				\n{A9C4E4}1 - {FF3F3F}Светло-красный\
				\n{A9C4E4}2 - {FF3F00}Кирпичный\
				\n{A9C4E4}3 - {BF3F00}Коричневый");
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}4 - {FF7F3F}Светло-коричневый\
				\n{A9C4E4}5 - {FF7F00}Оранжевый\
				\n{A9C4E4}6 - {FFFF00}Жёлтый\
				\n{A9C4E4}7 - {3FFF3F}Светло-зелёный", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}8 - {00FF00}Зелёный\
				\n{A9C4E4}9 - {00BF00}Тёмно-зелёный\
				\n{A9C4E4}10 - {00FFFF}Бирюзовый\
				\n{A9C4E4}11 - {00BFFF}Голубой", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}12 - {3F3FFF}Светло-синий\
				\n{A9C4E4}13 - {0000FF}Синий\
				\n{A9C4E4}14 - {7F3FFF}Светло-фиолетовый\
				\n{A9C4E4}15 - {7F00FF}Фиолетовый", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}16 - {FF00FF}Сиреневый\
				\n{A9C4E4}17 - {7F7F7F}Серый\
				\n{A9C4E4}18 - {FFFFFF}Белый\
				\n{A9C4E4}19 - {333333}Чёрный", strdln);
				ShowPlayerDialog(playerid, 2, 0, "Цвет:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new idx22 = idx;
			new result[256];
			while ((idx22 < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				if (cmdtext[idx22] == 123 && cmdtext[idx22 + 1] == 44)
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
					idx22++;
				}
				else
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
				}
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не написали сообщение !");
				return 1;
			}
			format(string, sizeof(string), "(/fmess) Админ %s [%d]: %s", RealName[playerid], playerid, result);
			print(string);
			switch(color)
			{
				case 0: format(string, sizeof(string), "{FF0000}%s", result);
				case 1: format(string, sizeof(string), "{FF3F3F}%s", result);
				case 2: format(string, sizeof(string), "{FF3F00}%s", result);
				case 3: format(string, sizeof(string), "{BF3F00}%s", result);
				case 4: format(string, sizeof(string), "{FF7F3F}%s", result);
				case 5: format(string, sizeof(string), "{FF7F00}%s", result);
				case 6: format(string, sizeof(string), "{FFFF00}%s", result);
				case 7: format(string, sizeof(string), "{3FFF3F}%s", result);
				case 8: format(string, sizeof(string), "{00FF00}%s", result);
				case 9: format(string, sizeof(string), "{00BF00}%s", result);
				case 10: format(string, sizeof(string), "{00FFFF}%s", result);
				case 11: format(string, sizeof(string), "{00BFFF}%s", result);
				case 12: format(string, sizeof(string), "{3F3FFF}%s", result);
				case 13: format(string, sizeof(string), "{0000FF}%s", result);
				case 14: format(string, sizeof(string), "{7F3FFF}%s", result);
				case 15: format(string, sizeof(string), "{7F00FF}%s", result);
				case 16: format(string, sizeof(string), "{FF00FF}%s", result);
				case 17: format(string, sizeof(string), "{7F7F7F}%s", result);
				case 18: format(string, sizeof(string), "{FFFFFF}%s", result);
				case 19: format(string, sizeof(string), "{333333}%s", result);
			}
			SendClientMessageToAll(COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/playtpall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 8)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " В режиме наблюдения эта команда не работает !");
				return 1;
			}
			new dopper1 = 0;
			new Float:PosX, Float:PosY, Float:PosZ;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(playspa[i] == 1 && (PlayerInfo[i][pAdmin] >= 0 && PlayerInfo[i][pAdmin] <= 12) && i != playerid)
					{
						if(PlayerInfo[i][pPrisonsec] == 0)//если игрок (или админ) НЕ в тюрьме, то:
						{
							dopper1 = 1;
							if(PlayLock1[0][i] != 600)//если игрок заблокирован, то:
							{
								PlayLock1[1][i] = GetPlayerInterior(playerid);//изменение интерьера блокировки
								PlayLock1[2][i] = GetPlayerVirtualWorld(playerid);//изменение виртуального мира блокировки
								GetPlayerPos(playerid, PlayLock2[0][i], PlayLock2[1][i], PlayLock2[2][i]);//изменение координат блокировки
								PlayLock2[1][i] = PlayLock2[1][i] + 1;
							}
							else
							{
								if(admper1[i] != 600)//если игрок в наблюдении, то:
								{
									TogglePlayerSpectating(i, 0);//запретить наблюдение для игрока
									admper6[i] = 0;//обнуляем отметку о переключении наблюдения
									SetTimerEx("DopPlaytp", 1000, 0, "ii", playerid, i);
								}
								else
								{
			 						SetPlayerInterior(i, GetPlayerInterior(playerid));
									SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
			   						GetPlayerPos(playerid, PosX, PosY, PosZ);
									SetPlayerPos(i, PosX, PosY+1, PosZ+1);
								}
							}
						}
						if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pPrisonsec] > 0)//если админ в тюрьме, то:
						{
							dopper1 = 1;
							PlayerInfo[i][pPrison]--;
							PlayerInfo[i][pPrisonsec] = 0;
							SpawnPlayer(i);//респавн админа
							SendClientMessage(i, COLOR_GREEN, "* Амнистия ( по команде /playtpall )");
							SetTimerEx("DopAdmtp", 1000, 0, "ii", playerid, i);
						}
					}
				}
			}
            if(dopper1 == 1)
            {
				format(string,256," Администратор %s телепортировал всех игроков к себе.", RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " Нет доступных игроков (или админов) для ТП к себе !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//--------------------- команды админов 8 лвл (конец) --------------------------
//--------------------- команды админов 9 лвл (начало) -------------------------
	if(strcmp(cmd, "/score", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /score [ид игрока/часть ника] [очки] [причина]");
				return 1;
			}
			new playa;
			new score;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали очки и причину !");
				return 1;
			}
			score = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				new locper;
				locper = GetPlayerScore(playa);
				new dopper44;
				dopper44 = locper;
				locper = locper + score;
				SetPVarInt(playa, "ScorControl", 1);
				SetPlayerScore(playa, locper);
				if(score < 0)
				{
					format(string, 256, " Администратор %s изъял у игрока %s %d очков , причина: %s", RealName[playerid], RealName[playa],
					score, result);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_RED, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_RED, string);
					}
				}
				else
				{
					format(string, 256, " Администратор %s дал игроку %s %d очков , причина: %s", RealName[playerid], RealName[playa],
					score, result);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_YELLOW, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_YELLOW, string);
					}
				}
				printf("[moneysys] Предыдущие очки игрока %s [%d] : %d .", RealName[playa], playa, dopper44);
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
	if(strcmp(cmd, "/setscor", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setscor [ид игрока/часть ника] [очки]");
				return 1;
			}
			new playa;
			new score;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не указали очки !");
				return 1;
			}
			score = strval(tmp);
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				if(score < 0) { SendClientMessage(playerid, COLOR_RED, " Очки не могут быть отрицательным числом !"); return 1; }
				new dopper44;
				dopper44 = GetPlayerScore(playa);
				SetPVarInt(playa, "ScorControl", 1);
				SetPlayerScore(playa, score);
				format(string, 256, " Администратор %s установил игроку %s %d очков", RealName[playerid], RealName[playa], score);
				print(string);
				if (PlayerInfo[playa][pAdmin] >= 1)
				{
					SendAdminMessage(COLOR_YELLOW, string);
				}
				else
				{
					SendClientMessageToAll(COLOR_YELLOW, string);
				}
				printf("[moneysys] Предыдущие очки игрока %s [%d] : %d .", RealName[playa], playa, dopper44);
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
	if(strcmp(cmd, "/grav", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /grav [гравитация(0.0001-1)]");
				return 1;
			}
			new dopper, dopper22, dopper33, testgra, Float:flgra;
			dopper = strlen(tmp);
			if (dopper < 1 || dopper > 8)
			{
				SendClientMessage(playerid, COLOR_RED, " Гравитация: от 0.0001 до 1 !");
				return 1;
			}
			dopper22 = 0;
			dopper33 = 0;
			for(new i = 0; i < dopper; i++)
			{
				if(tmp[i] < 46 || tmp[i] == 47 || tmp[i] > 57)
				{
					dopper22 = 1;
				}
				if(tmp[i] == 46)
				{
					dopper33++;
				}
			}
			if (dopper22 == 1 || dopper33 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Гравитация: от 0.0001 до 1 !");
				return 1;
			}
			flgra = floatstr(tmp);
			testgra = 0;
			testgra = floatcmp(0.000100, flgra);
			if(testgra == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Гравитация: от 0.0001 до 1 !");
				return 1;
			}
			testgra = 0;
			testgra = floatcmp(flgra, 1.000000);
			if(testgra == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Гравитация: от 0.0001 до 1 !");
				return 1;
			}
			SetGravity(flgra);
			format(string, sizeof(string), " Администратор %s установил гравитацию на %f", RealName[playerid], flgra);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/gm", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /gm [ид игрока/часть ника] [0-убрать временное");
				SendClientMessage(playerid, COLOR_GRAD2, " бессмертие, 1-дать временное бессмертие]");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
			if(IsPlayerConnected(para1))
			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				if(PlayerInfo[para1][pAdmin] >= 7)
				{
					SendClientMessage(playerid, COLOR_RED, " Вы не можете изменять бессмертие админу 7 уровня и выше !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [0-убрать временное бессмертие, 1-дать временное бессмертие] !");
					return 1;
				}
				new stat;
				stat = strval(tmp);
				if(stat < 0 || stat > 1)
				{
	 				SendClientMessage(playerid, COLOR_RED, " 0-убрать временное бессмертие, 1-дать временное бессмертие !");
					return 1;
				}
				if(stat == 0 && PlayerInfo[para1][pAdmlive] == 0)
				{
	 				SendClientMessage(playerid, COLOR_RED, " У выбранного игрока уже нет бессмертия !");
					return 1;
				}
				if(stat == 1 && PlayerInfo[para1][pAdmlive] == 1)
				{
	 				SendClientMessage(playerid, COLOR_RED, " У выбранного игрока уже есть бессмертие !");
					return 1;
				}
				PlayerInfo[para1][pAdmlive] = stat;
				if(PlayerInfo[para1][pAdmlive] == 1)
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s временное бессмертие.", RealName[playerid],
					RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
					if(PlayerInfo[para1][pAdmin] == 0)
					{
						format(string, sizeof(string), " Администратор %s дал Вам временное бессмертие.", RealName[playerid]);
						SendClientMessage(para1, COLOR_GREEN, string);
					}
				}
				else
				{
					format(string, sizeof(string), " Администратор %s убрал с игрока %s временное бессмертие.", RealName[playerid],
					RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					if(PlayerInfo[para1][pAdmin] == 0)
					{
						format(string, sizeof(string), " Администратор %s убрал с Вас временное бессмертие.", RealName[playerid]);
						SendClientMessage(para1, COLOR_RED, string);
					}
				}
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
//--------------------- команды админов 9 лвл (конец) --------------------------
//-------------------- команды админов 10 лвл (начало) -------------------------
	if(strcmp(cmd, "/scoreall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /scoreall [очки] [причина]");
				return 1;
			}
			new score;
			score = strval(tmp);
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
			new locper;
			new dopper44;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerLogged[i] == 1)
					{
						locper = GetPlayerScore(i);
						if(score > 10) { dopper44 = locper; }
						locper = locper + score;
						SetPVarInt(i, "ScorControl", 1);
						SetPlayerScore(i, locper);
						if(score > 10)
						{
							printf("[moneysys] Предыдущие очки игрока %s [%d] : %d .", RealName[i], i, dopper44);
						}
					}
				}
			}
			if(score < 0)
			{
				format(string, 256, " Администратор %s изъял у всех игроков по %d очков , причина: %s", RealName[playerid], score, result);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				format(string, 256, " Администратор %s раздал всем игрокам по %d очков , причина: %s", RealName[playerid], score, result);
				print(string);
				SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setscorall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setscorall [очки]");
				return 1;
			}
			new score;
			score = strval(tmp);
			if(score < 0) { SendClientMessage(playerid, COLOR_RED, " Очки не могут быть отрицательным числом !"); return 1; }
			new dopper44;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerLogged[i] == 1)
					{
						if(score > 10) { dopper44 = GetPlayerScore(i); }
						SetPVarInt(i, "ScorControl", 1);
						SetPlayerScore(i, score);
						if(score > 10)
						{
							printf("[moneysys] Предыдущие очки игрока %s [%d] : %d .", RealName[i], i, dopper44);
						}
					}
				}
			}
			format(string, 256, " Администратор %s установил всем игрокам по %d очков", RealName[playerid], score);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/radpl", true) == 0)
    {
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " Используйте: /radpl [ид игрока] [радио(1-12)]");
				SendClientMessage(playerid, COLOR_GREY, " или /radpl 600");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 == 600)
			{
				format(strdln, sizeof(strdln), "1 - %s\n2 - %s\n3 - %s\n4 - %s\n5 - %s\n6 - %s\n7 - %s\n8 - %s\
				\n9 - %s\n10 - %s\n11 - %s\n12 - %s", NMRadio[1], NMRadio[2], NMRadio[3], NMRadio[4],
				NMRadio[5], NMRadio[6], NMRadio[7], NMRadio[8], NMRadio[9], NMRadio[10], NMRadio[11], NMRadio[12]);
				ShowPlayerDialog(playerid, 2, 0, "Список радио", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
				return 1;
			}
			if(para1 == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " Чтобы включить радио самому себе, используйте меню сервера !");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[para1][pAdmin] >= 12)
			{
				SendClientMessage(playerid, COLOR_RED, " Вы не можете включить радио админу 12-го уровня !");
				return 1;
			}
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
			format(string, sizeof(string), " Администратор %s включил Вам радио %s", RealName[playerid], NMRadio[para2]);
			SendClientMessage(para1, COLOR_GREEN, string);
			SendClientMessage(para1, COLOR_GREEN, " Для выключения используйте: {A9C4E4}Игровой меню --> {91EF03}Радио --> {027FFE}Выключить радио");
			format(string, sizeof(string), " *** Aдмин %s включил игроку %s радио %s", RealName[playerid], RealName[para1], NMRadio[para2]);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
 					if(PlayerInfo[i][pAdmin] >= 1 && i != para1)
   					{
						SendClientMessage(i, COLOR_GREEN, string);
					}
				}
			}
			printf("[radio] Aдмин %s включил игроку %s радио %s .", RealName[playerid], RealName[para1], NMRadio[para2]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
	    return 1;
    }
	if(strcmp(cmd, "/radall", true) == 0)
    {
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " Используйте: /radall [радио(1-12)]");
				SendClientMessage(playerid, COLOR_GREY, " или /radall 600");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 == 600)
			{
				format(strdln, sizeof(strdln), "1 - %s\n2 - %s\n3 - %s\n4 - %s\n5 - %s\n6 - %s\n7 - %s\n8 - %s\
				\n9 - %s\n10 - %s\n11 - %s\n12 - %s", NMRadio[1], NMRadio[2], NMRadio[3], NMRadio[4],
				NMRadio[5], NMRadio[6], NMRadio[7], NMRadio[8], NMRadio[9], NMRadio[10], NMRadio[11], NMRadio[12]);
				ShowPlayerDialog(playerid, 2, 0, "Список радио", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(para1 < 1 || (para1 > 12 && para1 != 600))
			{
				SendClientMessage(playerid, COLOR_RED, " Такого радио нет !");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if((PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[i][pAdmin] <= 11) || PlayerInfo[playerid][pAdmin] >= 12)
					{
						NRadio[i] = para1;//номер подключаемого радио
						StopAudioStreamForPlayer(i);//отключим любой другой поток
						PlayAudioStreamForPlayer(i, STRadio[para1]);//подключим поток с музыкой
						format(string, sizeof(string), " Администратор %s включил всем радио %s", RealName[playerid], NMRadio[para1]);
						SendClientMessage(i, COLOR_GREEN, string);
						SendClientMessage(i, COLOR_GREEN, " Для выключения используйте: {A9C4E4}Игровой меню --> {91EF03}Радио --> {027FFE}Выключить радио");
					}
					if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[i][pAdmin] >= 12)
					{
						format(string, sizeof(string), " Администратор %s включил всем радио %s", RealName[playerid], NMRadio[para1]);
						SendClientMessage(i, COLOR_GREEN, string);
					}
				}
			}
			printf("[radio] Aдмин %s включил всем радио %s .", RealName[playerid], NMRadio[para1]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
	    return 1;
    }
//-------------------- команды админов 10 лвл (конец) --------------------------
//-------------------- команды админов 11 лвл (начало) -------------------------
	if(strcmp(cmd, "/dataakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 11)
    	{
   			new data44[18], Float:data4444[12], FracTxt44[2][64];
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /dataakk [имя аккаунта]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			new file, locper22[64];//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "TDReg", tdreg);
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "MinLog", data44[0]);
				ini_getInteger(file, "AdminLevel", data44[1]);
				ini_getInteger(file, "AdminShadow", data44[2]);
				ini_getInteger(file, "AdminLive", data44[3]);
				ini_getInteger(file, "Prison", data44[5]);
				ini_getInteger(file, "Prisonsec", data44[6]);
				ini_getInteger(file, "Muted", data44[7]);
				ini_getInteger(file, "Mutedsec", data44[8]);
				ini_getInteger(file, "Money", data44[9]);
				ini_getInteger(file, "Score", data44[10]);
				ini_getInteger(file, "Kills", data44[11]);
				ini_getInteger(file, "Deaths", data44[12]);
				ini_getInteger(file, "Lock", data44[13]);
				ini_getFloat(file, "Cord_X", data4444[0]);
				ini_getFloat(file, "Cord_Y", data4444[1]);
				ini_getFloat(file, "Cord_Z", data4444[2]);
				ini_getFloat(file, "Angle", data4444[3]);
				ini_getInteger(file, "Frac1", data44[14]);
				ini_getInteger(file, "FracLvl1", data44[15]);
				ini_getFloat(file, "FracCord_X1", data4444[4]);
				ini_getFloat(file, "FracCord_Y1", data4444[5]);
				ini_getFloat(file, "FracCord_Z1", data4444[6]);
				ini_getFloat(file, "FracAngle1", data4444[7]);
				ini_getString(file, "FracTxt1", locper22);
				strmid(FracTxt44[0], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac2", data44[16]);
				ini_getInteger(file, "FracLvl2", data44[17]);
				ini_getFloat(file, "FracCord_X2", data4444[8]);
				ini_getFloat(file, "FracCord_Y2", data4444[9]);
				ini_getFloat(file, "FracCord_Z2", data4444[10]);
				ini_getFloat(file, "FracAngle2", data4444[11]);
				ini_getString(file, "FracTxt2", locper22);
				strmid(FracTxt44[1], locper22, 0, strlen(locper22), 64);
				ini_closeFile(file);
			}
			new fadm;
			if(data44[1] < 0)
			{
				fadm = data44[1] * -1;
			}
			else
			{
				fadm = data44[1];
			}
			if(fadm >= 12 && PlayerInfo[playerid][pAdmin] <= 11)//проверка аккаунта на админку 12-го лвл
			{
				format(ssss,sizeof(ssss)," Нельзя, аккаунт игрока [%s] - админ %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			new dopdata44;
			dopdata44 = 0;
			for(new i=0;i<MAX_PLAYERS;i++)//проверка аккаунта на On-Line
			{
	   			if(IsPlayerConnected(i))
			    {
					if(strcmp(akk, RealName[i], false) == 0) { dopdata44 = 1; }
				}
			}
			new dopdata2;
			if(data44[14] == -600)
			{
				dopdata2 = 0;
			}
			else
			{
				dopdata2 = data44[14];
			}
			printf(" Администратор %s [%d] просмотрел аккаунт игрока %s . Без пароля !", RealName[playerid], playerid, akk);

			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
			format(ssss, sizeof(ssss), "           *** Аккаунт игрока [%s] *** ( Без пароля ! )", akk);
			SendClientMessage(playerid, COLOR_WHITE, ssss);
			if(dopdata44 == 1)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, " Внимание !!! Аккаунт игрока On-Line !");
			}
			format(ssss, sizeof(ssss), " Время и дата регистрации: [ %s ]", tdreg);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " Координаты: X = %f Y = %f Z = %f Угол: %f",
			data4444[0], data4444[1], data4444[2], data4444[3]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " IP: [%s] Админ LVL: [%d] Скрытость админа: [%d]",
			adrip, fadm, data44[2]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " Посадок в тюрьму: [%d] Секунд тюрьмы: [%d] Число затыков: [%d] Секунд затыка: [%d]",
			data44[5], data44[6], data44[7], data44[8]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " Денег: [%d $] Очков: [%d] Убийств: [%d] Смертей: [%d] Блокировка аккаунта: [%d]",
			data44[9], data44[10], data44[11], data44[12], data44[13]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " Минут на сервере: [%d] Бессмертие: [%d]", data44[0], data44[3]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			if(fadm >= 7)
			{
				new twenlim, restlim;
				Fmadmins(2, akk, 0, twenlim, restlim);
				format(ssss,sizeof(ssss)," Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", twenlim, restlim);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
			}
			format(ssss, sizeof(ssss), " ID банды: [%d] Уровень в банде: [%d]", dopdata2, data44[15]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
/*
			format(ssss, sizeof(ssss), " ID Фракции-2: [%d] Уровень во фракции-2: [%d] Текст фракции-2: [ %s ]",
			data44[16], data44[17], FracTxt44[1]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " Координаты фракции-2: X = %f Y = %f Z = %f Угол фракции-2: %f",
			data4444[8], data4444[9], data4444[10], data4444[11]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
*/
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");

			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/unbanakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 11)
    	{
   			new data2[3];
			data2[2] = 0;//переменная проверки блокировки аккаунта
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /unbanakk [имя аккаунта]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			new file;//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "AdminLevel", data2[0]);
				ini_getInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//проверка аккаунта на On-Line
			{
				if(IsPlayerConnected(i))
				{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " Ошибка в имени аккаунта, аккаунт игрока [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data2[0] < 0)
			{
				fadm = data2[0] * -1;
			}
			else
			{
				fadm = data2[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//проверка аккаунта на админку
			{
				format(ssss,sizeof(ssss)," Нельзя, аккаунт игрока [%s] - админ %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(data2[1] == 0)//если аккаунт НЕ был заблокирован, то:
			{
				data2[2] = 1;//записываем в переменную проверки блокировки аккаунта 1
			}
			data2[1] = 0;//сброс блокировки аккаунта
			strdel(ssss, 0, 256);//сборка RCON-команды разбана
			strcat(ssss, "unbanip ");
			strcat(ssss, adrip);
			SendRconCommand(ssss);//RCON-команда разбана
			SendRconCommand("reloadbans");//RCON-команда перезагрузки бан-листа
			file = ini_openFile(string);//запись изменённого аккаунта
			if(file >= 0)
			{
				ini_setInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			if(data2[2] == 1)//если переменная проверки блокировки аккаунта = 1, то:
			{
				format(ssss,sizeof(ssss)," Аккаунт игрока [%s] не заблокирован (не забанен) !", akk);
				print(ssss);
				SendClientMessage(playerid, COLOR_RED, ssss);
				format(ssss,sizeof(ssss)," ( IP: [%s] был удалён из файла samp.ban ) !", adrip);
				print(ssss);
				SendClientMessage(playerid, COLOR_GREEN, ssss);
			}
			else//иначе:
			{
				format(ssss,sizeof(ssss)," Администратор %s разбанил аккаунт игрока [%s] ( IP: [%s] ) .", RealName[playerid], akk, adrip);
				print(ssss);
				SendAdminMessage(COLOR_GREEN, ssss);
				format(ssss,sizeof(ssss)," Администратор %s разбанил аккаунт игрока [%s] .", RealName[playerid], akk);
				for(new i=0;i<MAX_PLAYERS;i++)//отправка сообщения НЕ админам
				{
					if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
					{
						SendClientMessage(i, COLOR_GREEN, ssss);
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
	if(strcmp(cmd, "/shad", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 11)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /shad [ид игрока/часть ника] [0-убрать скрытость, 1-скрыть]");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
 			if(IsPlayerConnected(para1))
 			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				if (PlayerInfo[para1][pAdmin] != 0)
				{
					if (PlayerInfo[para1][pAdmin] >= 12 && PlayerInfo[playerid][pAdmin] <= 11)
					{
						SendClientMessage(playerid, COLOR_RED, " Вы не можете изменять скрытость админа 12 уровня !");
						return 1;
					}
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [0-убрать скрытость, 1-скрыть] !");
						return 1;
					}
					new stat;
					stat = strval(tmp);
					if(stat < 0 || stat > 1)
					{
	 					SendClientMessage(playerid, COLOR_RED, " 0-убрать скрытость, 1-скрыть !");
						return 1;
					}
					if(stat == 0 && PlayerInfo[para1][pAdmshad] == 0)
					{
	 					SendClientMessage(playerid, COLOR_RED, " У выбранного админа уже нет скрытости !");
						return 1;
					}
					if(stat == 1 && PlayerInfo[para1][pAdmshad] == 1)
					{
	 					SendClientMessage(playerid, COLOR_RED, " У выбранного админа уже есть скрытость !");
						return 1;
					}
					PlayerInfo[para1][pAdmshad] = stat;
					if(PlayerInfo[para1][pAdmshad] == 1)
					{
						format(string, sizeof(string), " Администратор %s дал админу %s статус скрытости.", RealName[playerid],
						RealName[para1]);
						print(string);
						SendAdminMessage(COLOR_YELLOW, string);
					}
					else
					{
						format(string, sizeof(string), " Администратор %s убрал с админа %s статус скрытости.", RealName[playerid],
						RealName[para1]);
						print(string);
						SendAdminMessage(COLOR_RED, string);
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок - не админ !");
				}
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
	if(strcmp(cmd, "/deltr", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 11)
		{
			new model, cnt;
			cnt = 0;
			for(new i = 1; i < 10001; i++)
			{
				model = GetVehicleModel(i);
				if(model == 537 || model == 538 || model == 569 || model == 570)
				{
					DestroyVehicle(i);
					cnt++;
				}
			}
			if(cnt != 0)
			{
				format(string, sizeof(string), " Было уничтожено %d свободных единиц поездов или вагонов !", cnt);
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, " Свободных поездов или вагонов не было найдено !");
			}
			format(string, sizeof(string), " Администратор %s уничтожил %d свободных единиц поездов или вагонов.",
			RealName[playerid], cnt);
			print(string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/ipban", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 11)
		{
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
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
			new ind3 = 1;//проверка местоположения "*" в каждой из групп цифр,
			new ind4 = 0;//И проверка каждой группы цифр на максимально допустимый адрес
			new ind5 = 0;
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' ||
					ipper[playerid][ind3][2] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
					if(strval(ipper[playerid][ind3]) > 255) {ind5 = 1;}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
    		if(ind5 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
			new dopper33[256];//бан IP-адреса
			strdel(dopper33, 0, 256);
			strcat(dopper33, "banip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			format(string, sizeof(string), " Администратор %s забанил IP адрес: [%s]", RealName[playerid], tmp);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/ipunban", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
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
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
			new ind3 = 1;//проверка местоположения "*" в каждой из групп цифр,
			new ind4 = 0;//И проверка каждой группы цифр на максимально допустимый адрес
			new ind5 = 0;
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' ||
					ipper[playerid][ind3][2] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
					if(strval(ipper[playerid][ind3]) > 255) {ind5 = 1;}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка !!!   Шаблон указан не верно !");
				return 1;
			}
    		if(ind5 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Ошибка в написании IP-адреса !");
				return 1;
			}
			new dopper33[256];//бан IP-адреса
			strdel(dopper33, 0, 256);
			strcat(dopper33, "unbanip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			format(string, sizeof(string), " Администратор %s разбанил IP адрес: [%s]", RealName[playerid], tmp);
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
//-------------------- команды админов 11 лвл (конец) --------------------------
//----------------- команды админов 12 и 13 лвл (начало) -----------------------
	if(strcmp(cmd, "/admakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
   			new data2[26], Float:data333[28], FracTxt[6][64];
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /admakk [имя аккаунта] [левел(0-12)] ( дополнительно:");
				SendClientMessage(playerid, COLOR_GRAD2, " [сумма] [очки] ),");
				SendClientMessage(playerid, COLOR_GRAD2, " или /admakk [имя аккаунта] 99 [пароль] - сменить пароль,");
				SendClientMessage(playerid, COLOR_GRAD2, " или /admakk [имя аккаунта] 100 - просмотреть аккаунт");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			new entpass[64], level, oldlevel, summ1, summ2;
			new ochki1, ochki2, dopper;
			dopper = 0;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [левел(0-12), или 99, или 100] ( дополнительно: [сумма] [очки] ) !");
				return 1;
			}
			level = strval(tmp);
			if((level < 0 || level > 12) && level != 99 && level != 100)
			{
				SendClientMessage(playerid, COLOR_RED, " Уровень админа должен быть от 0 до 12 , (или 99, или 100) !");
				return 1;
			}
			if(level == 99)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " /admakk [имя аккаунта] 99 [пароль] !");
					return 1;
				}
 				if(strlen(tmp) < 3 || strlen(tmp) > 20)
				{
					SendClientMessage(playerid, COLOR_RED, " Длина пароля должна быть от 3 до 20 символов !");
					return 1;
				}
 				if(PassControl(tmp) == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " В пароле можно использовать ТОЛЬКО латинские");
					SendClientMessage(playerid, COLOR_RED, " символы: от a до z , от A до Z , и цифры от 0 до 9 !");
					return 1;
				}
				strdel(entpass, 0, 64);
				strcat(entpass, tmp);
			}
			else
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					summ1 = 0;
				}
				else
				{
					summ1 = 1;
					summ2 = strval(tmp);
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					ochki1 = 0;
				}
				else
				{
					ochki1 = 1;
					ochki2 = strval(tmp);
				}
			}
			new file, locper22[64];//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "Key", igkey);
				ini_getString(file, "TDReg", tdreg);
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "MinLog", data2[0]);
				ini_getInteger(file, "AdminLevel", data2[1]);
				ini_getInteger(file, "AdminShadow", data2[2]);
				ini_getInteger(file, "AdminLive", data2[3]);
				ini_getInteger(file, "Registered", data2[4]);
				ini_getInteger(file, "Prison", data2[5]);
				ini_getInteger(file, "Prisonsec", data2[6]);
				ini_getInteger(file, "Muted", data2[7]);
				ini_getInteger(file, "Mutedsec", data2[8]);
				ini_getInteger(file, "Money", data2[9]);
				ini_getInteger(file, "Score", data2[10]);
				ini_getInteger(file, "Kills", data2[11]);
				ini_getInteger(file, "Deaths", data2[12]);
				ini_getInteger(file, "Lock", data2[13]);
				ini_getFloat(file, "Cord_X", data333[0]);
				ini_getFloat(file, "Cord_Y", data333[1]);
				ini_getFloat(file, "Cord_Z", data333[2]);
				ini_getFloat(file, "Angle", data333[3]);
				ini_getInteger(file, "Frac1", data2[14]);
				ini_getInteger(file, "FracLvl1", data2[15]);
				ini_getFloat(file, "FracCord_X1", data333[4]);
				ini_getFloat(file, "FracCord_Y1", data333[5]);
				ini_getFloat(file, "FracCord_Z1", data333[6]);
				ini_getFloat(file, "FracAngle1", data333[7]);
				ini_getString(file, "FracTxt1", locper22);
				strmid(FracTxt[0], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac2", data2[16]);
				ini_getInteger(file, "FracLvl2", data2[17]);
				ini_getFloat(file, "FracCord_X2", data333[8]);
				ini_getFloat(file, "FracCord_Y2", data333[9]);
				ini_getFloat(file, "FracCord_Z2", data333[10]);
				ini_getFloat(file, "FracAngle2", data333[11]);
				ini_getString(file, "FracTxt2", locper22);
				strmid(FracTxt[1], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac3", data2[18]);
				ini_getInteger(file, "FracLvl3", data2[19]);
				ini_getFloat(file, "FracCord_X3", data333[12]);
				ini_getFloat(file, "FracCord_Y3", data333[13]);
				ini_getFloat(file, "FracCord_Z3", data333[14]);
				ini_getFloat(file, "FracAngle3", data333[15]);
				ini_getString(file, "FracTxt3", locper22);
				strmid(FracTxt[2], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac4", data2[20]);
				ini_getInteger(file, "FracLvl4", data2[21]);
				ini_getFloat(file, "FracCord_X4", data333[16]);
				ini_getFloat(file, "FracCord_Y4", data333[17]);
				ini_getFloat(file, "FracCord_Z4", data333[18]);
				ini_getFloat(file, "FracAngle4", data333[19]);
				ini_getString(file, "FracTxt4", locper22);
				strmid(FracTxt[3], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac5", data2[22]);
				ini_getInteger(file, "FracLvl5", data2[23]);
				ini_getFloat(file, "FracCord_X5", data333[20]);
				ini_getFloat(file, "FracCord_Y5", data333[21]);
				ini_getFloat(file, "FracCord_Z5", data333[22]);
				ini_getFloat(file, "FracAngle5", data333[23]);
				ini_getString(file, "FracTxt5", locper22);
				strmid(FracTxt[4], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac6", data2[24]);
				ini_getInteger(file, "FracLvl6", data2[25]);
				ini_getFloat(file, "FracCord_X6", data333[24]);
				ini_getFloat(file, "FracCord_Y6", data333[25]);
				ini_getFloat(file, "FracCord_Z6", data333[26]);
				ini_getFloat(file, "FracAngle6", data333[27]);
				ini_getString(file, "FracTxt6", locper22);
				strmid(FracTxt[5], locper22, 0, strlen(locper22), 64);
				ini_closeFile(file);
			}
			new fadm;
			if(data2[1] < 0)
			{
				fadm = data2[1] * -1;
			}
			else
			{
				fadm = data2[1];
			}
			if(level == 100)
			{
				new dopdata44;
				dopdata44 = 0;
				for(new i=0;i<MAX_PLAYERS;i++)//проверка аккаунта на On-Line
				{
	   				if(IsPlayerConnected(i))
			    	{
						if(strcmp(akk, RealName[i], false) == 0) { dopdata44 = 1; }
					}
				}
				new dopdata2;
				if(data2[14] == -600)
				{
					dopdata2 = 0;
				}
				else
				{
					dopdata2 = data2[14];
				}
				printf(" Администратор %s [%d] просмотрел аккаунт игрока %s .", RealName[playerid], playerid, akk);

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
				format(ssss, sizeof(ssss), "           *** Аккаунт игрока [%s] ***", akk);
				SendClientMessage(playerid, COLOR_WHITE, ssss);
				if(dopdata44 == 1)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, " Внимание !!! Аккаунт игрока On-Line !");
				}
				format(ssss, sizeof(ssss), " Время и дата регистрации: [ %s ]", tdreg);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " Координаты: X = %f Y = %f Z = %f Угол: %f",
				data333[0], data333[1], data333[2], data333[3]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " Пароль: [%s] IP: [%s] Админ LVL: [%d] Скрытость админа: [%d]",
				igkey, adrip, fadm, data2[2]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " Посадок в тюрьму: [%d] Секунд тюрьмы: [%d] Число затыков: [%d] Секунд затыка: [%d]",
				data2[5], data2[6], data2[7], data2[8]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " Денег: [%d $] Очков: [%d] Убийств: [%d] Смертей: [%d] Блокировка аккаунта: [%d]",
				data2[9], data2[10], data2[11], data2[12], data2[13]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " Минут на сервере: [%d] Бессмертие: [%d]", data2[0], data2[3]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				if(fadm >= 7)
				{
					new twenlim, restlim;
					Fmadmins(2, akk, 0, twenlim, restlim);
					format(ssss,sizeof(ssss)," Суточный денежный лимит: [%d] Остаток денежного лимита: [%d]", twenlim, restlim);
					SendClientMessage(playerid, COLOR_GRAD1, ssss);
				}
				format(ssss, sizeof(ssss), " ID банды: [%d] Уровень в банде: [%d]", dopdata2, data2[15]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
/*
				format(ssss, sizeof(ssss), " ID Фракции-2: [%d] Уровень во фракции-2: [%d] Текст фракции-2: [ %s ]",
				data2[16], data2[17], FracTxt[1]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " Координаты фракции-2: X = %f Y = %f Z = %f Угол фракции-2: %f",
				data333[8], data333[9], data333[10], data333[11]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
*/
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");

				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//проверка аккаунта на On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			if(level == 99)
			{
				if(strcmp(igkey, entpass, false) == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Аккаунт игрока остался без изменений !");
					return 1;
				}
				printf(" Администратор %s сменил пароль аккаунту игрока [%s] на (%s) FP: (%s) .", RealName[playerid], akk, entpass, igkey);
				format(ssss, sizeof(ssss), " Вы сменили пароль аккаунту игрока [%s] на (%s) FP: (%s) .", akk, entpass, igkey);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, ssss);
				strdel(igkey, 0, 256);
				strcat(igkey, entpass);
			}
			else
			{
				if(level == fadm && (summ1 == 0 || summ2 == data2[9]) && (ochki1 == 0 || ochki2 == data2[10]))
				{
	 				SendClientMessage(playerid, COLOR_RED, " Аккаунт игрока остался без изменений !");
					return 1;
				}
				if(level == 0 && level != fadm)
				{
					dopper = 1;
					data2[2] = 0;//убрать скрытость
					data2[3] = 0;//убрать бессмертие
					data2[1] = level;//изменение уровня админки
					format(ssss, sizeof(ssss), " Администратор %s снял админку с аккаунта игрока [%s] .", RealName[playerid], akk);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					new twenlim, restlim;
					Fmadmins(0, akk, 0, twenlim, restlim);
				}
				if(level > 0 && level != fadm)
				{
					dopper = 1;
					oldlevel = fadm;//сохранение старого уровня админки
					data2[2] = 0;//убрать скрытость
					if(data2[1] <= 0)//изменение уровня админки
					{
						data2[1] = level * -1;
					}
					else
					{
						data2[1] = level;
					}
					format(ssss, sizeof(ssss), " Администратор %s дал аккаунту игрока [%s] админку %d уровня.", RealName[playerid],
					akk, level);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					if(level <= 6 && oldlevel >= 7)
					{
						new twenlim, restlim;
						Fmadmins(0, akk, 0, twenlim, restlim);
					}
					if(level >= 7 && oldlevel <= 6)
					{
						new twenlim = 0;
						new restlim = 0;
						Fmadmins(1, akk, 0, twenlim, restlim);
					}
					if(level <= 6 && oldlevel >= 7)
					{
						data2[3] = 0;//выключить бессмертие
					}
					if(level >= 7 && oldlevel <= 6)
					{
						data2[3] = 1;//включить бессмертие
					}
				}
				if(summ1 == 1 && summ2 != data2[9])
				{
					new dopper44;
					dopper44 = data2[9];
					dopper = 1;
					data2[9] = summ2;//изменение личного счёта
					format(ssss, sizeof(ssss), " *** Личный счёт аккаунта игрока [%s] был изменён на: %d $ .", akk, data2[9]);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					printf("[moneysys] Предыдущая сумма аккаунта игрока %s : %d $", akk, dopper44);
				}
				if(ochki1 == 1 && ochki2 != data2[10])
				{
					dopper = 1;
					data2[10] = ochki2;//изменение личного счёта
					format(ssss, sizeof(ssss), " *** Очки аккаунта игрока [%s] были изменены на: %d .", akk, data2[10]);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
				}
				if(dopper == 0)
				{
	 				SendClientMessage(playerid, COLOR_RED, " Аккаунт игрока остался без изменений !");
					return 1;
				}
			}
			file = ini_openFile(string);//запись изменённого аккаунта
			if(file >= 0)
			{
				ini_setString(file, "Key", igkey);
				ini_setInteger(file, "AdminLevel", data2[1]);
				ini_setInteger(file, "AdminShadow", data2[2]);
				ini_setInteger(file, "AdminLive", data2[3]);
				ini_setInteger(file, "Money", data2[9]);
				ini_setInteger(file, "Score", data2[10]);
				ini_closeFile(file);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/delakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
			new data222[2];
    		akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /delakk [имя аккаунта]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//проверка аккаунта на On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " Нельзя, аккаунт игрока [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new file;//чтение аккаунта
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "Frac1", data222[0]);
				ini_getInteger(file, "FracLvl1", data222[1]);
				ini_closeFile(file);
			}
			if(fexist(string))
			{
				fremove(string);//удаляем аккаунт
			}
			format(ssss,sizeof(ssss)," Администратор %s удалил аккаунт игрока [%s] .", RealName[playerid], akk);
			print(ssss);
			SendClientMessageToAll(COLOR_LIGHTBLUE, ssss);
			new twenlim, restlim;
			Fmadmins(0, akk, 0, twenlim, restlim);
			strdel(ssss, 0, 256);//очистка переменной для разбана
			strcat(ssss, "unbanip ");//сборка RCON-команды разбана
			strcat(ssss, adrip);
			SendRconCommand(ssss);//RCON-команда разбана
			SendRconCommand("reloadbans");//RCON-команда перезагрузки бан-листа
			format(ssss,sizeof(ssss)," ( IP: [%s] был удалён из файла samp.ban ) !", adrip);
			print(ssss);
			SendAdminMessage(COLOR_LIGHTBLUE, ssss);
			format(ssss,sizeof(ssss)," ( IP-адрес игрока [%s] был удалён из файла samp.ban ) !", akk);
			for(new i=0;i<MAX_PLAYERS;i++)//отправка сообщения НЕ админам
			{
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				{
					SendClientMessage(i, COLOR_LIGHTBLUE, ssss);
				}
			}
			CallRemoteFunction("vehsys3delakkfunc", "ds", playerid, akk);//возврата транспорта на продажу в скрипте vehsys3
			if(data222[1] == 6)//если удаляемый аккаунт - лидер банды, то:
			{
				format(string, sizeof(string), "gangs/%d.ini", data222[0]);
				if(fexist(string))//если файл с ID банды существует, то:
				{
					GangSA[data222[0]] = 0;//запрещаем запись ID банды в файл
					SetTimerEx("DelAkk22", 300, 0, "i", data222[0]);
				}
			}
			else//если удаляемый аккаунт - НЕ лидер банды, то:
			{
				if(data222[0] > 0)//если игрок состоял в банде, то:
				{
					format(string, sizeof(string), "gangs/%d.ini", data222[0]);
					if(fexist(string))//если файл с ID банды существует, то:
					{
						GPlayers[data222[0]]--;//делаем в банде -1 игрок, и сохраняем изменения
						GangSave(data222[0]);//запись ID банды в файл
						format(ssss, sizeof(ssss), " *** и изменил число игроков в банде [%s{33CCFF}] на %d (автоматически) .",
						GName[data222[0]], GPlayers[data222[0]]);
						print(ssss);
						SendClientMessageToAll(COLOR_LIGHTBLUE, ssss);
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
	if(strcmp(cmd, "/edplgangs", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
   			new data222[2];
			tmp = strtok(cmdtext, idx);
    		if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /edplgangs [режим (0- On-Line игрок, 1- Off-Line игрок)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [ид игрока (режим 0), или имя аккаунта (режим 1)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [ид банды, или: 0 - удалить игрока из банды, -600 - запретить приглашать");
				SendClientMessage(playerid, COLOR_GRAD2, " игрока в банду] ( дополнительно: [уровень в банде (от 1 до 6)] )");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " [режим (0- On-Line игрок, 1- Off-Line игрок)] !");
				return 1;
			}
			akk = strtok(cmdtext, idx);
			if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_RED, " [ид игрока (режим 0), или имя аккаунта (режим 1)] !");
				return 1;
			}
			new para2;
			if(para1 == 0)
			{
				para2 = strval(akk);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " Такого [ид игрока] на сервере нет !");
					return 1;
				}
				if(gPlayerLogged[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
			}
			if(para1 == 1)
			{
				if(strlen(akk) < 1 || strlen(akk) > 25)
				{
					SendClientMessage(playerid, COLOR_RED, " Длина имени аккаунта должна быть от 1 до 25 символов !");
					return 1;
				}
				format(string, sizeof(string), "players/%s.ini", akk);
				if(!fexist(string))
				{
					SendClientMessage(playerid,COLOR_RED," Такого аккаунта не существует !");
					return 1;
				}
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [ид банды, или 0 , или -600] !");
				return 1;
			}
			new para3 = strval(tmp);
			if(para3 < 0 && para3 != -600)
			{
				SendClientMessage(playerid, COLOR_RED, " [ид банды, или 0 , или -600] !");
				return 1;
			}
			new para4 = 0;
			if(para3 > 0)
			{
				new string22[256];
				format(string22,sizeof(string22),"gangs/%i.ini",para3);
				if(!fexist(string22) || para3 >= (MAX_GANGS - 1))
				{
					SendClientMessage(playerid, COLOR_RED, " Такого [ид банды] на сервере нет !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [уровень в банде (от 1 до 6)] !");
					return 1;
				}
				para4 = strval(tmp);
				if(para4 < 1 || para4 > 6)
				{
					SendClientMessage(playerid, COLOR_RED, " [уровень в банде (от 1 до 6)] !");
					return 1;
				}
			}
			if(para1 == 0)
			{
				if(PGang[para2] == para3 && GangLvl[para2] == para4)
				{
					SendClientMessage(playerid,COLOR_RED," У выбранного игрока уже установлены назначаемые данные !");
					return 1;
				}
				if(para3 == -600)
				{
					if(PGang[para2] == 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s запретил приглашать игрока %s в банду (/edplgangs) .",
						RealName[playerid], RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(PGang[para2] > 0)
					{
						if(idgangsave[para2] > 0)//если ID банды для записи - активен, то:
						{
							new perloc;
							idgangsave[para2] = 0;//очистка ID банды для записи
							perloc = 0;
							while(perloc < MAX_PLAYERS)//цикл для всех игроков
							{
								if(PGang[para2] == PGang[perloc] && para2 != perloc)
								{//если есть хотя бы один игрок из банды выходящего, то:
									idgangsave[perloc] = PGang[para2];
									break;
								}
								perloc++;
							}
						}
						format(ssss, sizeof(ssss), " Администратор %s удалил игрока %s из банды (ид: %d) ,",
						RealName[playerid], RealName[para2], PGang[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и запретил приглашать игрока %s в банду (/edplgangs) .",
						RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[PGang[para2]]--;//делаем в банде -1 игрок
						GangSave(PGang[para2]);//записываем банду
					}
				}
				if(para3 == 0)
				{
					if(PGang[para2] == -600)
					{
						format(ssss, sizeof(ssss), " Администратор %s разрешил приглашать игрока %s в банду (/edplgangs) .",
						RealName[playerid], RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(PGang[para2] > 0)
					{
						if(idgangsave[para2] > 0)//если ID банды для записи - активен, то:
						{
							new perloc;
							idgangsave[para2] = 0;//очистка ID банды для записи
							perloc = 0;
							while(perloc < MAX_PLAYERS)//цикл для всех игроков
							{
								if(PGang[para2] == PGang[perloc] && para2 != perloc)
								{//если есть хотя бы один игрок из банды выходящего, то:
									idgangsave[perloc] = PGang[para2];
									break;
								}
								perloc++;
							}
						}

						format(ssss, sizeof(ssss), " Администратор %s удалил игрока %s из банды (ид: %d) ,",
						RealName[playerid], RealName[para2], PGang[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и разрешил приглашать игрока %s в банду (/edplgangs) .",
						RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[PGang[para2]]--;//делаем в банде -1 игрок
						GangSave(PGang[para2]);//записываем банду
					}
				}
				if(para3 > 0)
				{
					if(PGang[para2] == -600 || PGang[para2] == 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s приписал игрока %s к банде (ид: %d) ,",
						RealName[playerid], RealName[para2], para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и назначил игроку %s уровень %d в этой банде (/edplgangs) .",
						RealName[para2], para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//если назначаемый уровень - уровень лидера, то:
						{
							strdel(GHead[para3], 0, 64);//удалить имя старого лидера банды
							strcat(GHead[para3], RealName[para2]);//назначить имя нового лидера банды
						}
						GPlayers[para3]++;//делаем в банде +1 игрок
						GangSave(para3);//записываем банду

						if(GSkin[para3][para4-1] < 500)
						{//если на уровне установлен скин, то сменить скин приписанному игроку
							SetPVarInt(para2, "PlSkin", GSkin[para3][para4-1]);
							SetPlayerSkin(para2, GetPVarInt(para2, "PlSkin"));
						}
						ColorPlay[para2] = GColorDec[para3];
						SetPlayerColor(para2, ColorPlay[para2]);//устанавливаем цвет ника
						for(new i=0;i<MAX_PLAYERS;i++)//устанавливаем цвет маркера для всех игроков
						{
							SetPlayerMarkerForPlayer(i, para2, GColorDec[para3]);
						}

						new dopper = 0;
						for(new i = 0; i < MAX_PLAYERS; i++)//подготовка к записи ID банды
						{
							if(para3 > 0 && para3 == idgangsave[i])
							{//если игрок состоит в банде, и ID его банды уже есть в списке, то:
								dopper = 1;
							}
						}
						if(para3 > 0 && dopper == 0)
						{//если игрок состоит в банде, и ID его банды НЕ был найден в списке, то:
							idgangsave[para2] = para3;//записываем в список ID банды игрока
						}
					}
					if(PGang[para2] == para3)
					{
						format(ssss, sizeof(ssss), " Администратор %s назначил игроку %s уровень %d в его банде (/edplgangs) .",
						RealName[playerid], RealName[para2], para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//если назначаемый уровень - уровень лидера, то:
						{
							strdel(GHead[para3], 0, 64);//удалить имя старого лидера банды
							strcat(GHead[para3], RealName[para2]);//назначить имя нового лидера банды
						}
						GangSave(para3);//записываем банду

						if(GSkin[para3][para4-1] < 500)
						{//если на уровне установлен скин, то сменить скин приписанному игроку
							SetPVarInt(para2, "PlSkin", GSkin[para3][para4-1]);
							SetPlayerSkin(para2, GetPVarInt(para2, "PlSkin"));
						}
					}
					if(PGang[para2] != para3 && PGang[para2] != -600 && PGang[para2] != 0)
					{
						if(idgangsave[para2] > 0)//если ID банды для записи - активен, то:
						{
							new perloc;
							idgangsave[para2] = 0;//очистка ID банды для записи
							perloc = 0;
							while(perloc < MAX_PLAYERS)//цикл для всех игроков
							{
								if(PGang[para2] == PGang[perloc] && para2 != perloc)
								{//если есть хотя бы один игрок из банды выходящего, то:
									idgangsave[perloc] = PGang[para2];
									break;
								}
								perloc++;
							}
						}

						format(ssss, sizeof(ssss), " Администратор %s удалил игрока %s из банды (ид: %d) ,",
						RealName[playerid], RealName[para2], PGang[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** приписал игрока %s к банде (ид: %d) ,",
						RealName[para2], para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и назначил игроку %s уровень %d в этой банде (/edplgangs) .",
						RealName[para2], para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//если назначаемый уровень - уровень лидера, то:
						{
							strdel(GHead[para3], 0, 64);//удалить имя старого лидера банды
							strcat(GHead[para3], RealName[para2]);//назначить имя нового лидера банды
						}
						GPlayers[PGang[para2]]--;//делаем в банде -1 игрок
						GangSave(PGang[para2]);//записываем банду
						GPlayers[para3]++;//делаем в банде +1 игрок
						GangSave(para3);//записываем банду

						if(GSkin[para3][para4-1] < 500)
						{//если на уровне установлен скин, то сменить скин приписанному игроку
							SetPVarInt(para2, "PlSkin", GSkin[para3][para4-1]);
							SetPlayerSkin(para2, GetPVarInt(para2, "PlSkin"));
						}
						ColorPlay[para2] = GColorDec[para3];
						SetPlayerColor(para2, ColorPlay[para2]);//устанавливаем цвет ника
						for(new i=0;i<MAX_PLAYERS;i++)//устанавливаем цвет маркера для всех игроков
						{
							SetPlayerMarkerForPlayer(i, para2, GColorDec[para3]);
						}

						new dopper = 0;
						for(new i = 0; i < MAX_PLAYERS; i++)//подготовка к записи ID банды
						{
							if(para3 > 0 && para3 == idgangsave[i])
							{//если игрок состоит в банде, и ID его банды уже есть в списке, то:
								dopper = 1;
							}
						}
						if(para3 > 0 && dopper == 0)
						{//если игрок состоит в банде, и ID его банды НЕ был найден в списке, то:
							idgangsave[para2] = para3;//записываем в список ID банды игрока
						}
					}
				}
				PGang[para2] = para3;
				GangLvl[para2] = para4;
			}
			if(para1 == 1)
			{
				new file;//чтение аккаунта
				file = ini_openFile(string);
				if(file >= 0)
				{
					ini_getInteger(file, "Frac1", data222[0]);
					ini_getInteger(file, "FracLvl1", data222[1]);
					ini_closeFile(file);
				}
				if(data222[0] == para3 && data222[1] == para4)
				{
					SendClientMessage(playerid,COLOR_RED," У выбранного игрока уже установлены назначаемые данные !");
					return 1;
				}
				if(para3 == -600)
				{
					if(data222[0] == 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s запретил приглашать аккаунт игрока %s в банду (/edplgangs) .",
						RealName[playerid], akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(data222[0] > 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s удалил аккаунт игрока %s из банды (ид: %d) ,",
						RealName[playerid], akk, data222[0]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и запретил приглашать аккаунт игрока %s в банду (/edplgangs) .", akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[data222[0]]--;//делаем в банде -1 игрок
						GangSave(data222[0]);//записываем банду
					}
				}
				if(para3 == 0)
				{
					if(data222[0] == -600)
					{
						format(ssss, sizeof(ssss), " Администратор %s разрешил приглашать аккаунт игрока %s в банду (/edplgangs) .",
						RealName[playerid], akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(data222[0] > 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s удалил аккаунт игрока %s из банды (ид: %d) ,",
						RealName[playerid], akk, data222[0]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и разрешил приглашать аккаунт игрока %s в банду (/edplgangs) .", akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[data222[0]]--;//делаем в банде -1 игрок
						GangSave(data222[0]);//записываем банду
					}
				}
				if(para3 > 0)
				{
					if(data222[0] == -600 || data222[0] == 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s приписал аккаунт игрока %s к банде (ид: %d) ,",
						RealName[playerid], akk, para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и назначил аккаунту игрока %s уровень %d в этой банде (/edplgangs) .",
						akk, para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//если назначаемый уровень - уровень лидера, то:
						{
							strdel(GHead[para3], 0, 64);//удалить имя старого лидера банды
							strcat(GHead[para3], akk);//назначить имя нового лидера банды
						}
						GPlayers[para3]++;//делаем в банде +1 игрок
						GangSave(para3);//записываем банду
					}
					if(data222[0] == para3)
					{
						format(ssss, sizeof(ssss), " Администратор %s назначил аккаунту игрока %s уровень %d в его банде (/edplgangs) .",
						RealName[playerid], akk, para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//если назначаемый уровень - уровень лидера, то:
						{
							strdel(GHead[para3], 0, 64);//удалить имя старого лидера банды
							strcat(GHead[para3], akk);//назначить имя нового лидера банды
						}
						GangSave(para3);//записываем банду
					}
					if(data222[0] != para3 && data222[0] != -600 && data222[0] != 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s удалил аккаунт игрока %s из банды (ид: %d) ,",
						RealName[playerid], akk, data222[0]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** приписал аккаунт игрока %s к банде (ид: %d) ,", akk, para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** и назначил аккаунту игрока %s уровень %d в этой банде (/edplgangs) .",
						akk, para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//если назначаемый уровень - уровень лидера, то:
						{
							strdel(GHead[para3], 0, 64);//удалить имя старого лидера банды
							strcat(GHead[para3], akk);//назначить имя нового лидера банды
						}
						GPlayers[data222[0]]--;//делаем в банде -1 игрок
						GangSave(data222[0]);//записываем банду
						GPlayers[para3]++;//делаем в банде +1 игрок
						GangSave(para3);//записываем банду
					}
				}
				data222[0] = para3;
				data222[1] = para4;
				file = ini_openFile(string);//запись изменённого аккаунта
				if(file >= 0)
				{
					ini_setInteger(file, "Frac1", data222[0]);
					ini_setInteger(file, "FracLvl1", data222[1]);
					ini_closeFile(file);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
    }
	if(strcmp(cmd, "/gmx", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 12)
		{
			format(string, sizeof(string), " Администратор %s [%d] инициализировал рестарт сервера !", RealName[playerid], playerid);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
			SendClientMessageToAll(COLOR_RED, " Внимание ! Через 30 секунд произойдёт рестарт сервера !");
			restart = SetTimer("RestartS", 30000, 1);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " У Вас нет прав на использование этой команды !");
		}
		return 1;
	}
	if(strcmp(cmd, "/madmins", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
			new para1, para2, para3, para4, f[256];
			tmp = strtok(cmdtext, idx);
    		if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /madmins [режим (0- по ИД админа, 1- по нику админа)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [ИД админа / ник админа] [ИД настройки (0- просмотреть суточный");
				SendClientMessage(playerid, COLOR_GRAD2, " денежный лимит админа, 1- установить суточный денежный лимит для");
				SendClientMessage(playerid, COLOR_GRAD2, " админа, 2- удалить суточный денежный лимит админа)]");
				return 1;
			}
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " Режим 0 или 1 !");
				return 1;
			}
			if(para1 == 0)
			{
				tmp = strtok(cmdtext, idx);
	    		if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [ИД админа] [ИД настройки] !");
					return 1;
				}
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранного [ИД админа] на сервере нет !");
					return 1;
				}
				if(PlayerInfo[para2][pAdmin] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный [ИД админа] - не админ !");
					return 1;
				}
				if(PlayerInfo[para2][pAdmin] <= 6)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный [ИД админа] - ниже 7 lvl !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
	    		if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [ИД настройки (0- просмотреть суточный денежный лимит админа,");
					SendClientMessage(playerid, COLOR_RED, " 1- установить суточный денежный лимит для админа,");
					SendClientMessage(playerid, COLOR_RED, " 2- удалить суточный денежный лимит админа)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 2)
				{
					SendClientMessage(playerid, COLOR_RED, " ИД настройки от 0 до 2 !");
					return 1;
				}
				if(para3 == 0)
				{
					new twenlim = 0;
					new restlim = 0;
					format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
					if(!fexist(f))
					{
						Fmadmins(1, RealName[para2], 0, twenlim, restlim);
					}
					else
					{
						Fmadmins(2, RealName[para2], 0, twenlim, restlim);
					}
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
					format(ssss,sizeof(ssss)," Админ: [%s] Денежный лимит: [%d] Остаток лимита: [%d]", RealName[para2], twenlim, restlim);
					SendClientMessage(playerid, COLOR_GRAD1, ssss);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
					printf(" Администратор %s [%d] просмотрел суточный денежный лимит админа %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
					return 1;
				}
				if(para3 == 1)
				{
					tmp = strtok(cmdtext, idx);
		    		if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [суточный денежный лимит] !");
						return 1;
					}
					para4 = strval(tmp);
					if(para4 < 0 || para4 > 2147000000)
					{
						SendClientMessage(playerid, COLOR_RED, " Суточный денежный лимит от 0 до 2'147'000'000 !");
						return 1;
					}
					new twenlim = 0;
					new restlim = 0;
					format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
					if(!fexist(f))
					{
						Fmadmins(1, RealName[para2], 0, twenlim, restlim);
					}
					else
					{
						Fmadmins(2, RealName[para2], 0, twenlim, restlim);
					}
					if(para4 == twenlim)
					{
						format(string, sizeof(string), " Набранный Вами суточный денежный лимит уже установлен для админа %s !", RealName[para2]);
						SendClientMessage(playerid, COLOR_RED, string);
						return 1;
					}
					Fmadmins(1, RealName[para2], 0, para4, para4);
					if(para4 != 0)
					{
						format(ssss, sizeof(ssss), " Администратор %s установил админу %s суточный денежный лимит в %d $ .", RealName[playerid], RealName[para2], para4);
						printf(" Администратор %s [%d] установил админу %s [%d] суточный денежный лимит в %d $ ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2, para4);
					}
					else
					{
						format(ssss, sizeof(ssss), " Администратор %s снял с админа %s суточный денежный лимит.", RealName[playerid], RealName[para2]);
						printf(" Администратор %s [%d] снял с админа %s [%d] суточный денежный лимит ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
					}
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					return 1;
				}
				if(para3 == 2)
				{
					format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
					if(!fexist(f))
					{
						para4 = 0;
					}
					else
					{
						para4 = 1;
					}
					if(para4 == 1)
					{
						new twenlim, restlim;
						Fmadmins(0, RealName[para2], 0, twenlim, restlim);
						format(ssss,sizeof(ssss)," Вы удалили суточный денежный лимит админа %s .", RealName[para2]);
						SendClientMessage(playerid, COLOR_YELLOW, ssss);
						printf(" Администратор %s [%d] удалил суточный денежный лимит админа %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
					}
					else
					{
						format(string, sizeof(string), " Суточный денежный лимит админа %s уже был удалён !", RealName[para2]);
						SendClientMessage(playerid, COLOR_RED, string);
					}
					return 1;
				}
			}
			if(para1 == 1)
			{
	  			new locpara;
				akk = strtok(cmdtext, idx);
	    		if(!strlen(akk))
				{
					SendClientMessage(playerid, COLOR_RED, " [ник админа] [ИД настройки] !");
					return 1;
				}
				if(strlen(akk) < 1 || strlen(akk) > 25)
				{
					SendClientMessage(playerid, COLOR_RED, " Длина ника админа должна быть от 1 до 25 символов !");
					return 1;
				}
				para2 = 0;//поиск ника админа среди он-лайн игроков
				new doppara = 0;
				while(para2 < MAX_PLAYERS)
				{
					if(IsPlayerConnected(para2))
					{
						if(strcmp(akk, RealName[para2], false) == 0)
						{
							doppara = 1;
							break;
						}
					}
					para2++;
				}
				if(doppara == 0)//если ник админа НЕ найден, то:
				{//поиск ника админа в аккаунтах игроков
					format(string, sizeof(string), "players/%s.ini", akk);
					if(!fexist(string))
					{
						SendClientMessage(playerid,COLOR_RED," Выбранного ника админа не существует !");
						return 1;
					}
					new locfile;//чтение аккаунта
					locfile = ini_openFile(string);
					if(locfile >= 0)
					{
						ini_getInteger(locfile, "AdminLevel", locpara);
						ini_closeFile(locfile);
					}
					new fadm;
					if(locpara < 0)
					{
						fadm = locpara * -1;
					}
					else
					{
						fadm = locpara;
					}
					if(fadm == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Выбранный [ник админа] - не админ !");
						return 1;
					}
					if(fadm <= 6)
					{
						SendClientMessage(playerid, COLOR_RED, " Выбранный [ник админа] - ниже 7 lvl !");
						return 1;
					}
					tmp = strtok(cmdtext, idx);
		    		if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [ИД настройки (0- просмотреть суточный денежный лимит админа,");
						SendClientMessage(playerid, COLOR_RED, " 1- установить суточный денежный лимит для админа,");
						SendClientMessage(playerid, COLOR_RED, " 2- удалить суточный денежный лимит админа)] !");
						return 1;
					}
					para3 = strval(tmp);
					if(para3 < 0 || para3 > 2)
					{
						SendClientMessage(playerid, COLOR_RED, " ИД настройки от 0 до 2 !");
						return 1;
					}
					if(para3 == 0)
					{
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", akk);
						if(!fexist(f))
						{
							Fmadmins(1, akk, 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, akk, 0, twenlim, restlim);
						}
						SendClientMessage(playerid, COLOR_LIGHTRED, " Выбранный [ник админа] - Off-Line .");
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						format(ssss,sizeof(ssss)," Админ: [%s] Денежный лимит: [%d] Остаток лимита: [%d]", akk, twenlim, restlim);
						SendClientMessage(playerid, COLOR_GRAD1, ssss);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						printf(" Администратор %s [%d] просмотрел суточный денежный лимит админа %s ( /madmins ) .", RealName[playerid], playerid, akk);
						return 1;
					}
					if(para3 == 1)
					{
						tmp = strtok(cmdtext, idx);
			    		if(!strlen(tmp))
						{
							SendClientMessage(playerid, COLOR_RED, " [суточный денежный лимит] !");
							return 1;
						}
						para4 = strval(tmp);
						if(para4 < 0 || para4 > 2147000000)
						{
							SendClientMessage(playerid, COLOR_RED, " Суточный денежный лимит от 0 до 2'147'000'000 !");
							return 1;
						}
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", akk);
						if(!fexist(f))
						{
							Fmadmins(1, akk, 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, akk, 0, twenlim, restlim);
						}
						if(para4 == twenlim)
						{
							format(string, sizeof(string), " Набранный Вами суточный денежный лимит уже установлен для админа %s !", akk);
							SendClientMessage(playerid, COLOR_RED, string);
							return 1;
						}
						Fmadmins(1, akk, 0, para4, para4);
						SendClientMessage(playerid, COLOR_LIGHTRED, " Выбранный [ник админа] - Off-Line .");
						if(para4 != 0)
						{
							format(ssss, sizeof(ssss), " Администратор %s установил админу %s суточный денежный лимит в %d $ .", RealName[playerid], akk, para4);
							printf(" Администратор %s [%d] установил админу %s суточный денежный лимит в %d $ ( /madmins ) .", RealName[playerid], playerid, akk, para4);
						}
						else
						{
							format(ssss, sizeof(ssss), " Администратор %s снял с админа %s суточный денежный лимит.", RealName[playerid], akk);
							printf(" Администратор %s [%d] снял с админа %s суточный денежный лимит ( /madmins ) .", RealName[playerid], playerid, akk);
						}
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						return 1;
					}
					if(para3 == 2)
					{
						format(f, sizeof(f), "madmins/%s.ini", akk);
						if(!fexist(f))
						{
							para4 = 0;
						}
						else
						{
							para4 = 1;
						}
						if(para4 == 1)
						{
							new twenlim, restlim;
							Fmadmins(0, akk, 0, twenlim, restlim);
							SendClientMessage(playerid, COLOR_LIGHTRED, " Выбранный [ник админа] - Off-Line .");
							format(ssss,sizeof(ssss)," Вы удалили суточный денежный лимит админа %s .", akk);
							SendClientMessage(playerid, COLOR_YELLOW, ssss);
							printf(" Администратор %s [%d] удалил суточный денежный лимит админа %s ( /madmins ) .", RealName[playerid], playerid, akk);
						}
						else
						{
							format(string, sizeof(string), " Суточный денежный лимит админа %s уже был удалён !", akk);
							SendClientMessage(playerid, COLOR_RED, string);
						}
						return 1;
					}
				}
				else//иначе (если ник админа был найден среди он-лайн игроков), то:
				{
					if(PlayerInfo[para2][pAdmin] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " Выбранный [ник админа] - не админ !");
						return 1;
					}
					if(PlayerInfo[para2][pAdmin] <= 6)
					{
						SendClientMessage(playerid, COLOR_RED, " Выбранный [ник админа] - ниже 7 lvl !");
						return 1;
					}
					tmp = strtok(cmdtext, idx);
		    		if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [ИД настройки (0- просмотреть суточный денежный лимит админа,");
						SendClientMessage(playerid, COLOR_RED, " 1- установить суточный денежный лимит для админа,");
						SendClientMessage(playerid, COLOR_RED, " 2- удалить суточный денежный лимит админа)] !");
						return 1;
					}
					para3 = strval(tmp);
					if(para3 < 0 || para3 > 2)
					{
						SendClientMessage(playerid, COLOR_RED, " ИД настройки от 0 до 2 !");
						return 1;
					}
					if(para3 == 0)
					{
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
						if(!fexist(f))
						{
							Fmadmins(1, RealName[para2], 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, RealName[para2], 0, twenlim, restlim);
						}
						SendClientMessage(playerid, COLOR_LIGHTRED, " Выбранный [ник админа] - On-Line .");
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						format(ssss,sizeof(ssss)," Админ: [%s] Денежный лимит: [%d] Остаток лимита: [%d]", RealName[para2], twenlim, restlim);
						SendClientMessage(playerid, COLOR_GRAD1, ssss);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						printf(" Администратор %s [%d] просмотрел суточный денежный лимит админа %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
						return 1;
					}
					if(para3 == 1)
					{
						tmp = strtok(cmdtext, idx);
			    		if(!strlen(tmp))
						{
							SendClientMessage(playerid, COLOR_RED, " [суточный денежный лимит] !");
							return 1;
						}
						para4 = strval(tmp);
						if(para4 < 0 || para4 > 2147000000)
						{
							SendClientMessage(playerid, COLOR_RED, " Суточный денежный лимит от 0 до 2'147'000'000 !");
							return 1;
						}
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
						if(!fexist(f))
						{
							Fmadmins(1, RealName[para2], 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, RealName[para2], 0, twenlim, restlim);
						}
						if(para4 == twenlim)
						{
							format(string, sizeof(string), " Набранный Вами суточный денежный лимит уже установлен для админа %s !", RealName[para2]);
							SendClientMessage(playerid, COLOR_RED, string);
							return 1;
						}
						Fmadmins(1, RealName[para2], 0, para4, para4);
						SendClientMessage(playerid, COLOR_LIGHTRED, " Выбранный [ник админа] - On-Line .");
						if(para4 != 0)
						{
							format(ssss, sizeof(ssss), " Администратор %s установил админу %s суточный денежный лимит в %d $ .", RealName[playerid], RealName[para2], para4);
							printf(" Администратор %s [%d] установил админу %s [%d] суточный денежный лимит в %d $ ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2, para4);
						}
						else
						{
							format(ssss, sizeof(ssss), " Администратор %s снял с админа %s суточный денежный лимит.", RealName[playerid], RealName[para2]);
							printf(" Администратор %s [%d] снял с админа %s [%d] суточный денежный лимит ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
						}
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						return 1;
					}
					if(para3 == 2)
					{
						format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
						if(!fexist(f))
						{
							para4 = 0;
						}
						else
						{
							para4 = 1;
						}
						if(para4 == 1)
						{
							new twenlim, restlim;
							Fmadmins(0, RealName[para2], 0, twenlim, restlim);
							SendClientMessage(playerid, COLOR_LIGHTRED, " Выбранный [ник админа] - On-Line .");
							format(ssss,sizeof(ssss)," Вы удалили суточный денежный лимит админа %s .", RealName[para2]);
							SendClientMessage(playerid, COLOR_YELLOW, ssss);
							printf(" Администратор %s [%d] удалил суточный денежный лимит админа %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
						}
						else
						{
							format(string, sizeof(string), " Суточный денежный лимит админа %s уже был удалён !", RealName[para2]);
							SendClientMessage(playerid, COLOR_RED, string);
						}
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
//----------------- команды админов 12 и 13 лвл (конец) ------------------------
//-------------- команды админов 12, 13, и РКОН лвл (начало) -------------------
	if(strcmp(cmd, "/setlevel", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 17 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " Используйте: /setlevel [ид игрока/часть ника] [левел(0-17)]");
				SendClientMessage(playerid, COLOR_GRAD2, " ( дополнительно: [сумма] )");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
 			if(IsPlayerConnected(para1))
 			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " Выбранный игрок ещё не залогинился !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [левел(0-17)] ( дополнительно: [сумма] ) !");
					return 1;
				}
				new level;
				level = strval(tmp);
				if(level < 0 || level > 17)
				{
	 				SendClientMessage(playerid, COLOR_RED, " Уровень админа должен быть от 0 до 17 !");
					return 1;
				}
				new summ1, summ2;
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					summ1 = 0;
				}
				else
				{
					summ1 = 1;
					summ2 = strval(tmp);
				}
				new dopper;
				dopper = PlayerInfo[para1][pAdmin];
				if(dopper == level)
				{
	 				SendClientMessage(playerid, COLOR_RED, " У игрока уже есть назначаемый уровень админа !");
					return 1;
				}
				PlayerInfo[para1][pAdmin] = level;//изменение уровня админки
				new dopper44;
				dopper44 = GetPlayerMoney(para1);
				if(PlayerInfo[para1][pAdmin] == 0)
				{
					PlayerInfo[para1][pAdmshad] = 0;//убрать скрытость
					format(string, sizeof(string), " Администратор %s снял админку с игрока %s .", RealName[playerid], RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					format(string, sizeof(string), " Администратор %s снял с Вас админку.", RealName[playerid]);
					SendClientMessage(para1, COLOR_RED, string);
					if(summ1 == 1 && summ2 != GetPlayerMoney(para1))
					{
						SetPVarInt(para1, "MonControl", 1);
						ResetPlayerMoney(para1);//изменение личного счёта
						GivePlayerMoney(para1, summ2);
						format(string, sizeof(string), " *** Личный счёт игрока %s был изменён на: %d $ .", RealName[para1],
						GetPlayerMoney(para1));
						print(string);
						SendAdminMessage(COLOR_RED, string);
						format(string, sizeof(string), " *** Ваш личный счёт был изменён на: %d $ .", GetPlayerMoney(para1));
						SendClientMessage(para1, COLOR_RED, string);
						printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[para1], para1, dopper44);
					}
				}
				else
				{
					format(string, sizeof(string), " Администратор %s дал игроку %s админку %d уровня.", RealName[playerid],
					RealName[para1], level);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					if(summ1 == 1 && summ2 != GetPlayerMoney(para1))
					{
						SetPVarInt(para1, "MonControl", 1);
						ResetPlayerMoney(para1);//изменение личного счёта
						GivePlayerMoney(para1, summ2);
						format(string, sizeof(string), " *** Личный счёт игрока %s был изменён на: %d $ .", RealName[para1],
						GetPlayerMoney(para1));
						print(string);
						SendAdminMessage(COLOR_YELLOW, string);
						printf("[moneysys] Предыдущая сумма игрока %s [%d] : %d $", RealName[para1], para1, dopper44);
					}
				}
				if(PlayerInfo[para1][pAdmin] <= 6 && dopper >= 7)
				{
					new twenlim, restlim;
					Fmadmins(0, RealName[para1], 0, twenlim, restlim);
				}
				if(PlayerInfo[para1][pAdmin] >= 7 && dopper <= 6)
				{
					new twenlim = 0;
					new restlim = 0;
					Fmadmins(1, RealName[para1], 0, twenlim, restlim);
				}
				if(PlayerInfo[para1][pAdmin] >= 7 && dopper <= 6)
				{
					PlayerInfo[para1][pAdmlive] = 1;//установить бессмертие
					SendClientMessage(para1, COLOR_GREEN, " Бессмертие включено.");
				}
				if(PlayerInfo[para1][pAdmin] <= 6 && dopper >= 7)
				{
					PlayerInfo[para1][pAdmlive] = 0;//убрать бессмертие
					SendClientMessage(para1, COLOR_RED, " Бессмертие выключено.");
				}
				if(PlayerInfo[para1][pAdmin] >= 1 && dopper == 0)
				{
		        SendClientMessage(playerid, COLOR_RED, "* В целях безопасности своего аккаунта никогда не используйте одинаковые пароли");
		        SendClientMessage(playerid, COLOR_RED, "* на каждом сервере, меняйте их, и используйте один на каждый сервер");
		        SendClientMessage(playerid, COLOR_RED, "* чтобы не потерять свой административный аккаунт !!!");
				}
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
//-------------- команды админов 12, 13, и РКОН лвл (конец) --------------------
	return SendClientMessage(playerid,-1,"{FF0000}СЕРВЕР: {FFFFFF}Команда не найдена! Пиши /cmd для справки!");
}
