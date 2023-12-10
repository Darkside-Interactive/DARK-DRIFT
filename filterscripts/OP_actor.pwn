/*=================[FS] Система актёров v6.2====================================
_____________ При публикации просьба указывать автора Oleg_Petrow ______________

  +==========+ +==========+ +==========+ +==========+    +======+  +==+      +==+     +==+
  ||        || ||                ||      ||        ||  //       \\  \  \     |  |    /  /
  ||        || ||                ||      ||        || ||         ||  \  \    |  |   /  /
  ||=========+ |+========+       ||      ||=\\======+ ||         ||   \  \   |  |  /  /
  ||           ||                ||      ||   \\      ||         ||    \  \  |  | /  /
  ||           ||                ||      ||     \\     \\       //      \  \/   \/  /
  ||           |+=========+      ||      ||       \\    +======+         \_________/

	Обновления в версии 1.1:
	- Не нужны инклуды dc_cmd и mxINI.

	Обновления в версии 2.0:
	- Добавлена система поворота актёра.
	- Исправлен большой баг с удалением актёров.
	- Теперь при удалении обновляются все актёры.
	- Поставленно ограничение на создание актёров (максимальное число: 50).
	- Добавлена функция сохранения актёров. Они сохраняются в папку scriptfiles. Файл: op_actors.pwn
	- Показывается номер скина в "Изменении скина"
	
	Обновления в версии 3.0:
	- Добавлена функция изменения виртуального мира актёра.
	- При создании актёра ему даётся вирт.мир такой же, как и у игрока.
	- Теперь команда /actor доступна только Rcon-администратору.
	- Максимальное количество актёров теперь 100.
	- Теперь использование скрипта более удобно (я про диалог)
	- Из-за пункта выше количество строк и количество диалогов уменьшилось.
	
	Обновление в версии 3.1:
	- Исправлен маленький баг с вирт.миром
	
	Обновление в версии 4.0:
	- Теперь при сохранении сохраняется ещё и вирт.мир актёра.
	- Добавлена функция "передвигать актёра".
	- В меню управления актёром можно задать актёру анимацию. Пока что это пробная версия, поэтому пока что только анимации из библиотеки DANCING.
	- При сохранении актёров их анимации тоже сохраняются.
	
	Обновление в версии 4.1:
	- Добавлены 3 библиотеки анимаций.

	Обновление в версии 4.2:
	- Добавлены ещё 3 библиотеки анимаций.
	
	Обновление в версии 5.0:
	- Теперь максимальное количество актёров равно его лимиту в клиенте SA-MP (1000 актёров).
	- Исправлен небольшой баг при создании актёра на одном месте.
	- Теперь вместо клавиши 'Пробел' нужно нажать 'с' (по умолчанию - присесть). Причиной тому стало то, что на Пробел игроки бегают, и не удобно использовать.
	- Нельзя создать актёра, сидя в машине.
	- Теперь актёр создаётся не в мерте от Вас, а на вашем месте. После создания актёра - Вас ТПшит на расстояние метра от актёра.
	- Сидя в машине нельзя переместить/повернуть актёра.
	- Теперь снова нужен инклуд mxINI (как в версии 1.0, но там он был бесполезен).
	- Теперь функция "Сохранение актёров" - не для вставки в мод.
	- Добавлена функция загрузки актёров - загружаются они после сохранения (пункт выше).
	- Исправлены текстовые ошибки.
	- Добавлена функция удаления всех актёров.
	
	Обновление в версии 5.1:
	- Исправлен крупный баг с командами (у многих команды сервера не работали).
	- Исправлен баг с удалением всех актёров (раньше не удаляло).
	
	Обновление в версии 6.0:
	- Добавлены имена актёрам. Имена отображаются над головой актёра (так же как и ник у игрока).
	- Добавлена смена имён.
	- Стандартные имена (даётся при создании актёра): мужское - Олежка; женское - Викуля.
	- Добавлена функция изменение цвета имени.
	- Стандартный цвет (при создании) - белый.
	- Добавлено сохранение/загрузка цвета.
	
	Обновление в версии 6.1:
	- Теперь в просмотре актёров, если актёры не созданы - будет писаться, типа "Актёры ещё не созданы".
	- То же самое, но с удалением и с сохранением.
	
	Обновление в версии 6.2:
	- Исправлен баг с удалением актёра (оставалось его имя над головой).
	
																																																												*/
#include <a_samp>
#include <a_actor>
#include <mxINI>

#define COLOR_WHITE 	0xFFFFFFAA

new MAXACT = -1;
new Text3D:IDTexts[1000];
enum aInfo
{
	aID,
	aSkin,
	Float:aPosX,
	Float:aPosY,
	Float:aPosZ,
	Float:aPosA,
	aVirt,
	bool:aPol,
	aColor,
	aName[MAX_PLAYER_NAME]
};
new ActorInfo[1000][aInfo];

stock GetActorPol(actor)
{
	switch(ActorInfo[actor][aSkin])
	{
		case 1..8,14..30,32..38,42..52,57..62,66..68,70..74,78..84,86,94..128,132..137,142..147,149,153..156,158..168,170,171,173..177,179..189,200,202..204,206,208..213,217,220..223,227..230,234..236,239..242,247..250,252..255,258..262,264..297,299..305,310,311: return ActorInfo[actor][aPol] = false;
		case 9..13,31,39..41,53..56,63..65,69,75.77,85,87..93,129..131,138..141,148,150..152,157,169,172,178,190..199,201,205,207,214..216,218,219,224..226,231..233,237,238,243..246,251,256,257,263,298,306..309: return ActorInfo[actor][aPol] = true;
	}
	return false;
}
public OnFilterScriptInit()
{
	print("+-----------------------------------------+");
	print("|  Скрипт от Oleg_Petrow успешно загружен |");
	print("|      Система актёров | Версия: 6.2      |");
	print("|_________________________________________|");
	LoadActors();
	return 1;
}
stock LoadActors()
{
	new iniFile = ini_openFile("OP_Actors.cfg");
	ini_getInteger(iniFile, "MAXACT",MAXACT);
	new allactors;
	for(new i = 0; i <= MAXACT; i++)
	{
	    new string[50];
		new namestr[30];
	    format(string, sizeof(string), "[%d] aID", i);
		ini_getInteger(iniFile, string, ActorInfo[i][aID]);
	    format(string, sizeof(string), "[%d] aSkin", i);
		ini_getInteger(iniFile, string, ActorInfo[i][aSkin]);
	    format(string, sizeof(string), "[%d] aVirt", i);
		ini_getInteger(iniFile, string, ActorInfo[i][aVirt]);
	    format(string, sizeof(string), "[%d] aPosX", i);
		ini_getFloat(iniFile, string, ActorInfo[i][aPosX]);
	    format(string, sizeof(string), "[%d] aPosY", i);
		ini_getFloat(iniFile, string, ActorInfo[i][aPosY]);
	    format(string, sizeof(string), "[%d] aPosZ", i);
		ini_getFloat(iniFile, string, ActorInfo[i][aPosZ]);
	    format(string, sizeof(string), "[%d] aPosA", i);
		ini_getFloat(iniFile, string, ActorInfo[i][aPosA]);
	    format(string, sizeof(string), "[%d] aColor", i);
		ini_getInteger(iniFile, string, ActorInfo[i][aColor]);
		format(string, sizeof(string), "[%d] aName", i);
		ini_getString(iniFile, string,namestr);
		strmid(ActorInfo[i][aName], namestr, 0, strlen(namestr), 255);
		CreateActor(ActorInfo[i][aSkin], ActorInfo[i][aPosX], ActorInfo[i][aPosY], ActorInfo[i][aPosZ], ActorInfo[i][aPosA]);
		SetActorVirtualWorld(i, ActorInfo[i][aVirt]);
		LoadActorAnim(i);
		IDTexts[i] = Create3DTextLabel(ActorInfo[i][aName], SetActorColor(i), ActorInfo[i][aPosX], ActorInfo[i][aPosY], ActorInfo[i][aPosZ]+1.1, 15.0, ActorInfo[i][aVirt], 1);
		allactors++;
	}
	printf("Загружено %d актёров!",allactors);
	ini_closeFile(iniFile);
	return 1;
}
stock SaveActors()
{
	new iniFile = ini_openFile("OP_Actors.cfg");
	ini_setInteger(iniFile, "MAXACT", MAXACT);
	for(new i = 0; i <= MAXACT; i++)
	{
	    new string[50];
	    format(string, sizeof(string), "[%d] aID", i);
		ini_setInteger(iniFile, string, ActorInfo[i][aID]);
	    format(string, sizeof(string), "[%d] aSkin", i);
		ini_setInteger(iniFile, string, ActorInfo[i][aSkin]);
	    format(string, sizeof(string), "[%d] aVirt", i);
		ini_setInteger(iniFile, string, ActorInfo[i][aVirt]);
	    format(string, sizeof(string), "[%d] aPosX", i);
		ini_setFloat(iniFile, string, ActorInfo[i][aPosX]);
	    format(string, sizeof(string), "[%d] aPosY", i);
		ini_setFloat(iniFile, string, ActorInfo[i][aPosY]);
	    format(string, sizeof(string), "[%d] aPosZ", i);
		ini_setFloat(iniFile, string, ActorInfo[i][aPosZ]);
	    format(string, sizeof(string), "[%d] aPosA", i);
		ini_setFloat(iniFile, string, ActorInfo[i][aPosA]);
	    format(string, sizeof(string), "[%d] aName", i);
		ini_setString(iniFile, string, ActorInfo[i][aName]);
	    format(string, sizeof(string), "[%d] aColor", i);
		ini_setInteger(iniFile, string, ActorInfo[i][aColor]);
	}
	ini_closeFile(iniFile);
	return 1;
}
stock SetActorColor(actor)
{
	new color;
	switch(ActorInfo[actor][aColor])
	{
/*	    case 0: Update3DTextLabelText(IDTexts[actor], 0xFFFFFFFF, ActorInfo[actor][aName]);
		case 1: Update3DTextLabelText(IDTexts[actor], 0x0000FFFF, ActorInfo[actor][aName]);
		case 2: Update3DTextLabelText(IDTexts[actor], 0x000000FF, ActorInfo[actor][aName]);
		case 3: Update3DTextLabelText(IDTexts[actor], 0xFF0000FF, ActorInfo[actor][aName]);
		case 4: Update3DTextLabelText(IDTexts[actor], 0xFFFF00FF, ActorInfo[actor][aName]);
		case 5: Update3DTextLabelText(IDTexts[actor], 0x00FF00FF, ActorInfo[actor][aName]);
		case 6: Update3DTextLabelText(IDTexts[actor], 0x000066FF, ActorInfo[actor][aName]);
		case 7: Update3DTextLabelText(IDTexts[actor], 0xFF66FFFF, ActorInfo[actor][aName]);
		case 8: Update3DTextLabelText(IDTexts[actor], 0x009900FF, ActorInfo[actor][aName]);
		case 9: Update3DTextLabelText(IDTexts[actor], 0x00FFFFFF, ActorInfo[actor][aName]);*/
	    case 0: color = 0xFFFFFFFF;
		case 1: color = 0x0000FFFF;
		case 2: color = 0x000000FF;
		case 3: color = 0xFF0000FF;
		case 4: color = 0xFFFF00FF;
		case 5: color = 0x00FF00FF;
		case 6: color = 0x000066FF;
		case 7: color = 0xFF66FFFF;
		case 8: color = 0x009900FF;
		case 9: color = 0x00FFFFFF;
		default: color = 0xFFFFFFFF;
	}
	return color;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case 5100:
		{
	        if(!response) return 1;
			switch(listitem)
			{
				case 0:
				{
				    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Нельзя создать актёра, сидя в машине!");
					ShowPlayerDialog(playerid, 5101, DIALOG_STYLE_INPUT, "Создание актёра","Введите номер скина, который будет у актёра!", "Далее","Назад");
				}
				case 1:
				{
				    if(MAXACT < 0) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Актёры ещё не созданы!");
				    new stringer[1000] = "";
				    new string[100];
				    for(new i = 0; i <= MAXACT; i++)
				    {
					    format(string, sizeof(string), "Актёр номер {FF0000}%d{FFFFFF}\n", i);
					    strcat(stringer, string);
				    }
					ShowPlayerDialog(playerid, 5150, DIALOG_STYLE_LIST, "Выберите действие",stringer, "Далее","Назад");
				}
				case 2:
				{
				    if(MAXACT < 0) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Актёры не были созданы!");
				    for(new i = 0; i <= MAXACT; i++)
				    {
				        DestroyActor(i);
						Delete3DTextLabel(IDTexts[i]);
				    }
				    MAXACT = -1;
					SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Все актёры удалены!");
				}
				case 3:
				{
				    if(MAXACT < 0) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Актёры ещё не созданы!");
				    SaveActors();
					SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Все актёры сохранены. При следующем запуске мода вместе со скриптом - актёры будут загружены.");
				}
			}
		    return 1;
		}
		case 5150:
		{
	        if(!response) return 1;
	        for(new i = 0; i <= MAXACT; i++)
	        {
	            if(listitem == i)
	            {
	                new acid[25];
					SetPVarInt(playerid, "actor", i);
	                format(acid, sizeof(acid), "Актёр номер {FF0000}%d", i);
	                ShowPlayerDialog(playerid, 5102, DIALOG_STYLE_LIST, acid, "Телепорт к актёру\nИзменить скин актёру\nУдалить актёра\nПовернуть актёра\nИзменить вирт.мир актёра\nПереместить актёра\nДобавить анимацию актёру\nИзменить имя актёру\nИзменить цвет имени", "Далее", "Назад");
	            }
	        }
	        return 1;
		}
	    case 5101:
		{
	        if(!response) return OnPlayerCommandText(playerid, "/actor");
	        if(MAXACT >= 999) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] У вас уже максимальное количество актёров!");
			if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Неверный номер скина!");
			if(strval(inputtext) < 1 || strval(inputtext) > 311) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Неверный номер скина!");
			new Float: pX, Float: pY, Float: pZ, Float: pA, Float: pXx, Float: pYy, Float: pZz;
			GetPlayerPos(playerid, pX, pY, pZ);
			for(new i = 0; i <= MAXACT; i++)
			{
				GetActorPos(i, pXx, pYy, pZz);
				if(pX == pXx && pY == pYy) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Актёр уже существует на этом месте!");
			}
			GetPlayerFacingAngle(playerid, pA);
			new string[61];
			MAXACT = CreateActor(strval(inputtext), pX, pY, pZ, pA);
			ActorInfo[MAXACT][aID] = MAXACT;
			ActorInfo[MAXACT][aSkin] = strval(inputtext);
			ActorInfo[MAXACT][aVirt] = GetPlayerVirtualWorld(playerid);
			ActorInfo[MAXACT][aPosX] = pX;
			ActorInfo[MAXACT][aPosY] = pY;
			ActorInfo[MAXACT][aPosZ] = pZ;
			ActorInfo[MAXACT][aPosA] = pA;
			SetActorVirtualWorld(MAXACT, ActorInfo[MAXACT][aVirt]);
			LoadActorAnim(MAXACT);
			SetPlayerPos(playerid, pX, pY+1, pZ);
			GetActorPol(MAXACT);
			new nameact[MAX_PLAYER_NAME];
			switch(ActorInfo[MAXACT][aPol])
			{
			    case false: nameact = "Олежка";
			    case true: nameact = "Викуля";
			}
			IDTexts[MAXACT] = Create3DTextLabel(nameact,0xFFFFFFFF,pX, pY, pZ+1.1, 15.0, GetActorVirtualWorld(MAXACT), 1);
			format(ActorInfo[MAXACT][aName], MAX_PLAYER_NAME,nameact);
			ActorInfo[MAXACT][aColor] = 0;
			format(string, 60, "{00FFFF}Вы создали актёра. Номер: {FFFFFF}%d", MAXACT);
			SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
	    }
		case 5102:
		{
		    if(!response) return 1;
			new i = GetPVarInt(playerid, "actor");
		    switch(listitem)
		    {
		        case 0:
				{
				    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SetPlayerPos(playerid, ActorInfo[i][aPosX], ActorInfo[i][aPosY]+2, ActorInfo[i][aPosZ]);
					SetVehiclePos(GetPlayerVehicleID(playerid), ActorInfo[i][aPosX], ActorInfo[i][aPosY]+3, ActorInfo[i][aPosZ]);
				}
				case 1: ShowPlayerDialog(playerid, 5103, DIALOG_STYLE_INPUT, "Изменить скин актёру","Введите номер скина", "Сменить","Назад");
				case 2:
				{
	                DestroyActor(i);
					Delete3DTextLabel(IDTexts[i]);
				    for(new o = 0; o <= MAXACT; o++)
				    {
				        if(o <= i) continue;
						DestroyActor(o);
						ActorInfo[o-1][aID] = CreateActor(ActorInfo[o][aSkin], ActorInfo[o][aPosX], ActorInfo[o][aPosY], ActorInfo[o][aPosZ], ActorInfo[o][aPosA]);
						ActorInfo[o-1][aSkin] = ActorInfo[o][aSkin];
						ActorInfo[o-1][aVirt] = ActorInfo[o][aVirt];
						ActorInfo[o-1][aPosX] = ActorInfo[o][aPosX];
						ActorInfo[o-1][aPosY] = ActorInfo[o][aPosY];
						ActorInfo[o-1][aPosZ] = ActorInfo[o][aPosZ];
						ActorInfo[o-1][aPosA] = ActorInfo[o][aPosA];
						ActorInfo[o-1][aColor] = ActorInfo[o][aColor];
						format(ActorInfo[o-1][aName], MAX_PLAYER_NAME, ActorInfo[o][aName]);
						SetActorVirtualWorld(ActorInfo[o-1][aID], ActorInfo[o-1][aVirt]);
						Delete3DTextLabel(IDTexts[o]);
						IDTexts[o-1] = Create3DTextLabel(ActorInfo[o-1][aName], SetActorColor(o-1), ActorInfo[o-1][aPosX], ActorInfo[o-1][aPosY], ActorInfo[o-1][aPosZ]+1.1, 15.0, ActorInfo[o-1][aVirt], 1);
						LoadActorAnim(o-1);
				    }
				    MAXACT --;
	        		SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Вы успешно удалили актёра. Все актёры обновлены!");
				}
				case 3:
				{
				    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] В машине нельзя повернуть актёра!");
					SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Встаньте с таким углом поворота, с каким вы хотите видеть актёра!");
					SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] После того как Вы встали под таким углом - нажмите 'c' (по умолчанию - присесть)!");
					SetPVarInt(playerid, "vbor", 1);
				}
				case 4: ShowPlayerDialog(playerid, 5104, DIALOG_STYLE_INPUT, "Изменение вирт.мира актёра","Введите вирт.мир актёра \n\nвирт.мир не может быть меньше 0 и больше 1000.", "Далее","Назад");
				case 5:
				{
				    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] В машине нельзя переместить актёра!");
					SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Встаньте на то место, куда нужно переместить актёра!");
					SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] После того как Вы встали на то место - нажмите 'c' (по умолчанию - присесть)!");
					SetPVarInt(playerid, "vbor", 2);
				}
				case 6: ShowPlayerDialog(playerid, 5105, DIALOG_STYLE_LIST, "Анимации","Очистить анимацию\nDANCING\nBAR\nBEACH\nBOMBER\nBUDDY\nCAMERA\nped","Далее","Назад");
				case 7: ShowPlayerDialog(playerid, 5113, DIALOG_STYLE_INPUT, "Изменить имя актёру","Введите новое имя","Далее","Отмена");
				case 8: ShowPlayerDialog(playerid, 5114, DIALOG_STYLE_LIST, "Цвет имени актёра","{FFFFFF}Белый\n{0000FF}Синий\n{000000}Чёрный\n{FF0000}Красный\n{FFFF00}Жёлтый\n{00FF00}Ярко-зелёный\n{000066}Тёмно-синий\n{FF66FF}Розовый\n{009900}Зелёный\n{00FFFF}Голубой","Далее","Отмена");
		 	}
		    return 1;
		}
		case 5114:
		{
			if(!response) return 1;
			new actor = GetPVarInt(playerid, "actor"), string[100];
			switch(listitem)
			{
			    case 0: ActorInfo[actor][aColor] = 0, format(string, sizeof(string), "Вы выбрали белый цвет имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 1: ActorInfo[actor][aColor] = 1, format(string, sizeof(string), "Вы выбрали {0000FF}синий цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 2: ActorInfo[actor][aColor] = 2, format(string, sizeof(string), "Вы выбрали {000000}чёрный цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 3: ActorInfo[actor][aColor] = 3, format(string, sizeof(string), "Вы выбрали {FF0000}красный цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 4: ActorInfo[actor][aColor] = 4, format(string, sizeof(string), "Вы выбрали {FFFF00}жёлтый цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 5: ActorInfo[actor][aColor] = 5, format(string, sizeof(string), "Вы выбрали {00FF00}ярко-зелёный цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 6: ActorInfo[actor][aColor] = 6, format(string, sizeof(string), "Вы выбрали {000066}тёмно-синий цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 7: ActorInfo[actor][aColor] = 7, format(string, sizeof(string), "Вы выбрали {FF66FF}розовый цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 8: ActorInfo[actor][aColor] = 8, format(string, sizeof(string), "Вы выбрали {009900}зелёный цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			    case 9: ActorInfo[actor][aColor] = 9, format(string, sizeof(string), "Вы выбрали {00FFFF}голубой цвет{FFFFFF} имени для актёра {FF0000}%d", actor), SendClientMessage(playerid, COLOR_WHITE, string);
			}
			Update3DTextLabelText(IDTexts[actor],SetActorColor(actor), ActorInfo[actor][aName]);
		}
	    case 5103:
	    {
	        if(!response) return OnPlayerCommandText(playerid, "/actor");
			if(!strlen(inputtext) || strval(inputtext) < 1 || strval(inputtext) > 311) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Неверный номер скина!");
			new i = GetPVarInt(playerid, "actor"), string[100];
			DestroyActor(i);
			CreateActor(strval(inputtext), ActorInfo[i][aPosX], ActorInfo[i][aPosY], ActorInfo[i][aPosZ], ActorInfo[i][aPosA]);
			SetActorVirtualWorld(i, ActorInfo[i][aVirt]);
			ActorInfo[i][aSkin] = strval(inputtext);
			LoadActorAnim(i);
			format(string, sizeof(string), "[{0000FF}OP_Actor{FFFFFF}] Новый скин актёра номер {00FF00}%d{FFFFFF}: {FF0000}%d",i, ActorInfo[i][aSkin]);
			SendClientMessage(playerid, COLOR_WHITE, string);
			return 1;
	    }
		case 5104:
		{
			if(!response) return OnPlayerCommandText(playerid, "/actor");
			if(!strlen(inputtext) || strval(inputtext) < 0 || strval(inputtext) > 1000) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Неверный номер вирт.мира!");
			new i = GetPVarInt(playerid, "actor"), string[100];
			SetActorVirtualWorld(i, strval(inputtext));
			ActorInfo[i][aVirt] = strval(inputtext);
			Delete3DTextLabel(IDTexts[i]);
			IDTexts[i] = Create3DTextLabel(ActorInfo[i][aName], SetActorColor(i), ActorInfo[i][aPosX], ActorInfo[i][aPosY], ActorInfo[i][aPosZ]+1.1, 15.0, ActorInfo[i][aVirt], 1);
			format(string, sizeof(string), "[{0000FF}OP_Actor{FFFFFF}] Новый вирт.мир актёра номер {00FF00}%d{FFFFFF}: {FF0000}%d",i, ActorInfo[i][aVirt]);
			SendClientMessage(playerid, COLOR_WHITE, string);
			LoadActorAnim(i);
			return 1;
		}
		case 5105:
		{
			if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
			switch(listitem)
			{
			    case 0: ClearActorAnimations(i);//, format(ActorInfo[i][aAnimB], 1, ""), format(ActorInfo[i][aAnimN], 1, ""), ActorInfo[i][aAnimP] = 0;
			    case 1: ShowPlayerDialog(playerid, 5106, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}DANCING","bd_clap\nbd_clap1\ndance_loops\nDAN_Down_A\nDAN_Left_A\nDAN_Loop_A\nDAN_Right_A\nDAN_Up_A\ndnce_M_a\ndnce_M_b\ndnce_M_c\ndnce_M_d\ndnce_M_e","Далее","Назад");
				case 2: ShowPlayerDialog(playerid, 5107, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}BAR","Barcustom_loop\nBARman_idle\nBarserve_bottle\nBarserve_give\nBarserve_glass\nBarserve_loop\ndnk_stndF_loop\ndnk_stndM_loop","Далее","Назад");
				case 3: ShowPlayerDialog(playerid, 5108, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}BEACH","bather\nLay_Bac_Loop\nParkSit_M_loop\nParkSit_W_loop\nSitnWait_loop_W","Далее","Назад");
				case 4: ShowPlayerDialog(playerid, 5109, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}BOMBER","BOM_Plant\nBOM_Plant_Loop","Далее","Назад");
				case 5: ShowPlayerDialog(playerid, 5110, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}BUDDY", "buddy_crouchfire\nbuddy_crouchreload\nbuddy_fire","Далее","Назад");
				case 6: ShowPlayerDialog(playerid, 5111, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}CAMERA", "camcrch_cmon\ncamcrch_idleloop\ncamcrch_stay\ncamcrch_to_camstnd\ncamstnd_cmon\ncamstnd_idleloop\ncamstnd_lkabt","Далее","Назад");
				case 7: ShowPlayerDialog(playerid, 5112, DIALOG_STYLE_LIST, "Выберите анимацию | {FF0000}ped", "WALK_armed\nWALK_civi\nWALK_csaw\nWalk_DoorPartial\nWALK_drunk\nWALK_fat\nWALK_fatold\nWALK_gang1\nWALK_gang2\nWALK_old\nWALK_player\nWALK_rocket\nWALK_shuffle\nWALK_start\nWALK_start_armed\nWALK_start_csaw\nWALK_start_rocket\nWalk_Wuzi\nWEAPON_crouch\nXPRESSscratch\nsprint_civi\nsprint_panic\nSprint_Wuzi","Далее","Назад");
			}
			return 1;
		}
		case 5106:
		{
		    if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
		    switch(listitem)
		    {
		        case 0: ApplyActorAnimation(i, "DANCING", "bd_clap", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "bd_clap"), ActorInfo[i][aAnimP] = 1;
		        case 1: ApplyActorAnimation(i, "DANCING", "bd_clap1", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "bd_clap1"), ActorInfo[i][aAnimP] = 1;
		        case 2: ApplyActorAnimation(i, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "dance_loop"), ActorInfo[i][aAnimP] = 1;
		        case 3: ApplyActorAnimation(i, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "DAN_Down_A"), ActorInfo[i][aAnimP] = 1;
		        case 4: ApplyActorAnimation(i, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "DAN_Left_A"), ActorInfo[i][aAnimP] = 1;
		        case 5: ApplyActorAnimation(i, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "DAN_Loop_A"), ActorInfo[i][aAnimP] = 1;
		        case 6: ApplyActorAnimation(i, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "DAN_Right_A"), ActorInfo[i][aAnimP] = 1;
		        case 7: ApplyActorAnimation(i, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "DAN_Up_A"), ActorInfo[i][aAnimP] = 1;
		        case 8: ApplyActorAnimation(i, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "dnce_M_a"), ActorInfo[i][aAnimP] = 1;
		        case 9: ApplyActorAnimation(i, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "dnce_M_b"), ActorInfo[i][aAnimP] = 1;
		        case 10: ApplyActorAnimation(i, "DANCING", "dnce_M_c", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "dnce_M_c"), ActorInfo[i][aAnimP] = 1;
		        case 11: ApplyActorAnimation(i, "DANCING", "dnce_M_d", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "dnce_M_d"), ActorInfo[i][aAnimP] = 1;
		        case 12: ApplyActorAnimation(i, "DANCING", "dnce_M_e", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 8, "DANCING"), format(ActorInfo[i][aAnimN], 30, "dnce_M_e"), ActorInfo[i][aAnimP] = 1;
		    }
		    return 1;
		}
		case 5107:
		{
		    if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
			switch(listitem)
			{
			    case 0: ApplyActorAnimation(i, "BAR", "Barcustom_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "Barcustom_loop"), ActorInfo[i][aAnimP] = 1;
			    case 1: ApplyActorAnimation(i, "BAR", "BARman_idle", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "BARman_idle"), ActorInfo[i][aAnimP] = 1;
			    case 2: ApplyActorAnimation(i, "BAR", "Barserve_bottle", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "Barserve_bottle"), ActorInfo[i][aAnimP] = 1;
			    case 3: ApplyActorAnimation(i, "BAR", "Barserve_give", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "Barserve_give"), ActorInfo[i][aAnimP] = 1;
			    case 4: ApplyActorAnimation(i, "BAR", "Barserve_glass", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "Barserve_glass"), ActorInfo[i][aAnimP] = 1;
			    case 5: ApplyActorAnimation(i, "BAR", "Barserve_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "Barserve_loop"), ActorInfo[i][aAnimP] = 1;
			    case 6: ApplyActorAnimation(i, "BAR", "dnk_stndF_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "dnk_stndF_loop"), ActorInfo[i][aAnimP] = 1;
			    case 7: ApplyActorAnimation(i, "BAR", "dnk_stndM_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "BAR"), format(ActorInfo[i][aAnimN], 30, "dnk_stndM_loop"), ActorInfo[i][aAnimP] = 1;
			}
			return 1;
		}
		case 5108:
		{
		    if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
		    switch(listitem)
		    {
		        case 0: ApplyActorAnimation(i, "BEACH", "bather", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BEACH"), format(ActorInfo[i][aAnimN], 30, "bather"), ActorInfo[i][aAnimP] = 1;
		        case 1: ApplyActorAnimation(i, "BEACH", "Lay_Bac_Loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BEACH"), format(ActorInfo[i][aAnimN], 30, "Lay_Bac_Loop"), ActorInfo[i][aAnimP] = 1;
		        case 2: ApplyActorAnimation(i, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BEACH"), format(ActorInfo[i][aAnimN], 30, "ParkSit_M_loop"), ActorInfo[i][aAnimP] = 1;
		        case 3: ApplyActorAnimation(i, "BEACH", "ParkSit_W_loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BEACH"), format(ActorInfo[i][aAnimN], 30, "ParkSit_W_loop"), ActorInfo[i][aAnimP] = 1;
		        case 4: ApplyActorAnimation(i, "BEACH", "SitnWait_loop_W", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BEACH"), format(ActorInfo[i][aAnimN], 30, "SitnWait_loop_W"), ActorInfo[i][aAnimP] = 1;
			}
			return 1;
		}
		case 5109:
		{
		    if(!response) return OnPlayerCommandText(playerid, "/actor");
		    new i = GetPVarInt(playerid, "actor");
		    switch(listitem)
		    {
		        case 0: ApplyActorAnimation(i, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "BOMBER"), format(ActorInfo[i][aAnimN], 30, "BOM_Plant"), ActorInfo[i][aAnimP] = 1;
		        case 1: ApplyActorAnimation(i, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "BOMBER"), format(ActorInfo[i][aAnimN], 30, "BOM_Plant_Loop"), ActorInfo[i][aAnimP] = 1;
		    }
		    return 1;
		}
		case 5110:
		{
			if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
			switch(listitem)
			{
			    case 0: ApplyActorAnimation(i, "BUDDY", "buddy_crouchfire", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BUDDY"), format(ActorInfo[i][aAnimN], 30, "buddy_crouchfire"), ActorInfo[i][aAnimP] = 1;
			    case 1: ApplyActorAnimation(i, "BUDDY", "buddy_crouchreload", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BUDDY"), format(ActorInfo[i][aAnimN], 30, "buddy_crouchreload"), ActorInfo[i][aAnimP] = 1;
			    case 2: ApplyActorAnimation(i, "BUDDY", "buddy_fire", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 6, "BUDDY"), format(ActorInfo[i][aAnimN], 30, "buddy_fire"), ActorInfo[i][aAnimP] = 1;
			}
			return 1;
		}
		case 5111:
		{
		    if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
		    switch(listitem)
		    {
		        case 0: ApplyActorAnimation(i, "CAMERA", "camcrch_cmon", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camcrch_cmon"), ActorInfo[i][aAnimP] = 1;
		        case 1: ApplyActorAnimation(i, "CAMERA", "camcrch_idleloop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camcrch_idleloop"), ActorInfo[i][aAnimP] = 1;
		        case 2: ApplyActorAnimation(i, "CAMERA", "camcrch_stay", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camcrch_stay"), ActorInfo[i][aAnimP] = 1;
		        case 3: ApplyActorAnimation(i, "CAMERA", "camcrch_to_camstnd", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camcrch_to_camstnd"), ActorInfo[i][aAnimP] = 1;
		        case 4: ApplyActorAnimation(i, "CAMERA", "camstnd_cmon", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camstnd_cmon"), ActorInfo[i][aAnimP] = 1;
		        case 5: ApplyActorAnimation(i, "CAMERA", "camstnd_idleloop", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camstnd_idleloop"), ActorInfo[i][aAnimP] = 1;
		        case 6: ApplyActorAnimation(i, "CAMERA", "camstnd_lkabt", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camstnd_lkabt"), ActorInfo[i][aAnimP] = 1;
		        case 7: ApplyActorAnimation(i, "CAMERA", "camstnd_to_camcrch", 4.1, 1, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 7, "CAMERA"), format(ActorInfo[i][aAnimN], 30, "camstnd_to_camcrch"), ActorInfo[i][aAnimP] = 1;
	     	}
		    return 1;
		}
		case 5112:
		{
		    if(!response) return OnPlayerCommandText(playerid, "/actor");
			new i = GetPVarInt(playerid, "actor");
		    switch(listitem)
		    {
		        case 0: ApplyActorAnimation(i, "ped", "WALK_armed", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_armed"), ActorInfo[i][aAnimP] = 0;
		        case 1: ApplyActorAnimation(i, "ped", "WALK_civi", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_civi"), ActorInfo[i][aAnimP] = 0;
		        case 2: ApplyActorAnimation(i, "ped", "WALK_csaw", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_csaw"), ActorInfo[i][aAnimP] = 0;
		        case 3: ApplyActorAnimation(i, "ped", "Walk_DoorPartial", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "Walk_DoorPartial"), ActorInfo[i][aAnimP] = 0;
		        case 4: ApplyActorAnimation(i, "ped", "WALK_drunk", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_drunk"), ActorInfo[i][aAnimP] = 0;
		        case 5: ApplyActorAnimation(i, "ped", "WALK_fat", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_fat"), ActorInfo[i][aAnimP] = 0;
		        case 6: ApplyActorAnimation(i, "ped", "WALK_fatold", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_fatold"), ActorInfo[i][aAnimP] = 0;
		        case 7: ApplyActorAnimation(i, "ped", "WALK_gang1", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_gang1"), ActorInfo[i][aAnimP] = 0;
		        case 8: ApplyActorAnimation(i, "ped", "WALK_gang2", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_gang2"), ActorInfo[i][aAnimP] = 0;
		        case 9: ApplyActorAnimation(i, "ped", "WALK_old", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_old"), ActorInfo[i][aAnimP] = 0;
		        case 10: ApplyActorAnimation(i, "ped", "WALK_player", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_player"), ActorInfo[i][aAnimP] = 0;
		        case 11: ApplyActorAnimation(i, "ped", "WALK_rocket", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_rocket"), ActorInfo[i][aAnimP] = 0;
		        case 12: ApplyActorAnimation(i, "ped", "WALK_shuffle", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_shuffle"), ActorInfo[i][aAnimP] = 0;
		        case 13: ApplyActorAnimation(i, "ped", "WALK_start", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_start"), ActorInfo[i][aAnimP] = 0;
		        case 14: ApplyActorAnimation(i, "ped", "WALK_start_armed", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_start_armed"), ActorInfo[i][aAnimP] = 0;
		        case 15: ApplyActorAnimation(i, "ped", "WALK_start_csaw", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_start_csaw"), ActorInfo[i][aAnimP] = 0;
		        case 16: ApplyActorAnimation(i, "ped", "WALK_start_rocket", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WALK_start_rocket"), ActorInfo[i][aAnimP] = 0;
		        case 17: ApplyActorAnimation(i, "ped", "Walk_Wuzi", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "Walk_Wuzi"), ActorInfo[i][aAnimP] = 0;
		        case 18: ApplyActorAnimation(i, "ped", "WEAPON_crouch", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "WEAPON_crouch"), ActorInfo[i][aAnimP] = 0;
		        case 19: ApplyActorAnimation(i, "ped", "XPRESSscratch", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "XPRESSscratch"), ActorInfo[i][aAnimP] = 0;
		        case 20: ApplyActorAnimation(i, "ped", "sprint_civi", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "sprint_civi"), ActorInfo[i][aAnimP] = 0;
		        case 21: ApplyActorAnimation(i, "ped", "sprint_panic", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "sprint_panic"), ActorInfo[i][aAnimP] = 0;
		        case 22: ApplyActorAnimation(i, "ped", "Sprint_Wuzi", 4.1, 0, 0, 0, 0, 0); //, format(ActorInfo[i][aAnimB], 4, "ped"), format(ActorInfo[i][aAnimN], 30, "Sprint_Wuzi"), ActorInfo[i][aAnimP] = 0;
	     	}
		    return 1;
		}
		case 5113:
		{
			if(!response) return 1;
		    if(!strlen(inputtext)) return SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Вы ничего не ввели!");
		    new actor = GetPVarInt(playerid, "actor"), Float:axX, Float:ayY, Float:azZ, string[100];
		    GetActorPos(actor, axX, ayY, azZ);
			Update3DTextLabelText(IDTexts[actor], SetActorColor(actor), inputtext);
			format(string, sizeof(string), "[{0000FF}OP_Actor{FFFFFF}] Вы сменили имя актёру. Новое имя: %s.", inputtext);
			SendClientMessage(playerid, COLOR_WHITE, string);
			format(ActorInfo[actor][aName], MAX_PLAYER_NAME, inputtext);
		    return 1;
		}
	}
	return 1;
}
forward LoadActorAnim(actor);
public LoadActorAnim(actor)
{
	ApplyActorAnimation(actor, "DANCING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "BAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "BEACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "CAMERA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "DANCING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "CAMERA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "ped", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "BOMBER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyActorAnimation(actor, "BUDDY", "null", 0.0, 0, 0, 0, 0, 0);
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	switch(GetPVarInt(playerid, "vbor"))
	{
		case 1:
		{
			if(newkeys == KEY_CROUCH)
		    {
				if(IsPlayerInAnyVehicle(playerid)) return DeletePVar(playerid, "vbor") && DeletePVar(playerid, "actor") && SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Поворот актёра отменён: в машине нельзя повернуть актёра!");
		        new actor = GetPVarInt(playerid, "actor");
				new Float:fa;
				GetPlayerFacingAngle(playerid, fa);
				DestroyActor(actor);
				CreateActor(ActorInfo[actor][aSkin], ActorInfo[actor][aPosX], ActorInfo[actor][aPosY], ActorInfo[actor][aPosZ], fa);
				ActorInfo[actor][aPosA] = fa;
				SetActorVirtualWorld(actor, ActorInfo[actor][aVirt]);
				DeletePVar(playerid, "actor");
				LoadActorAnim(actor);
				DeletePVar(playerid, "vbor");
		        SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Вы успешно повернули актёра!");
				return 1;
			}
		}
		case 2:
		{
			if(newkeys == KEY_CROUCH)
		    {
				if(IsPlayerInAnyVehicle(playerid)) return DeletePVar(playerid, "vbor") && DeletePVar(playerid, "actor") && SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Перемещение актёра отменено: в машине нельзя переместить актёра!");
		        new actor = GetPVarInt(playerid, "actor");
				new Float:fx, Float:fy, Float:fz;
				GetPlayerPos(playerid, fx, fy, fz);
				DestroyActor(actor);
				SetPlayerPos(playerid, fx, fy+1, fz);
				CreateActor(ActorInfo[actor][aSkin], fx, fy, fz, ActorInfo[actor][aPosA]);
				ActorInfo[actor][aPosX] = fx;
				ActorInfo[actor][aPosY] = fy;
				ActorInfo[actor][aPosZ] = fz;
				LoadActorAnim(actor);
				Delete3DTextLabel(IDTexts[actor]);
				IDTexts[actor] = Create3DTextLabel(ActorInfo[actor][aName], SetActorColor(actor), fx, fy, fz+1.1, 15.0, ActorInfo[actor][aVirt], 1);
				SetActorVirtualWorld(actor, ActorInfo[actor][aVirt]);
				DeletePVar(playerid, "actor");
				DeletePVar(playerid, "vbor");
		        SendClientMessage(playerid, COLOR_WHITE, "[{0000FF}OP_Actor{FFFFFF}] Вы успешно переместили актёра!");
		        return 1;
		    }
		}
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/actor", true) == 0)
	{
		if(!IsPlayerAdmin(playerid)) return 1;
		ShowPlayerDialog(playerid, 5100, DIALOG_STYLE_LIST, "Актёры от Oleg_Petrow","Создать нового актёра\nПросмотр списка актёров\nУдалить всех актёров\nСохранить всех актёров","Далее","Выход");
		return 1;
	}
	return 0;
}
