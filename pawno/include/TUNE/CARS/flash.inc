if(listitem == 0)
{

            ShowPlayerDialog(playerid, flashpered, DIALOG_STYLE_LIST, "Передний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, flashzad, DIALOG_STYLE_LIST, "Задний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, flashubki, DIALOG_STYLE_LIST, "Юбки", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, flashkovh, DIALOG_STYLE_LIST, "Ковши", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, flashspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, flashvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 6)
	        {
         ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "Покрасочные работы", "Покрасочная работа 1\nПокрасочная работа 2\nПокрасочная работа 3\nУбрать покрасочную Работу\nНа Главную", "Выбрать", "Выход");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 7)
	        {
	        ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 8)
	        {
	        ShowPlayerDialog(playerid, whel, DIALOG_STYLE_LIST, "Колеса","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\nГлавное Меню","Выбрать","Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 9)
	        {
	        ShowPlayerDialog(playerid, COLOR, DIALOG_STYLE_LIST, "Colors", "Черный\nБелый\nКрасный\nГолубой\nЗеленый\nЖелтый\nРозовый\nКоричневый\nСерый\nЗолотой\nТемно синий\nСветло синий\nХолодный зеленый\nСветло Серый\nТемно красный\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}


if(listitem == 10)
      {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[INFO] Машина отремонтирована. ");

        RepairVehicle(GetPlayerVehicleID(playerid));

        SendClientMessage(playerid,COLOR_WHITE,"[INFO] Машина отремонтирована. ");
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
   new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
	   	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       return 1;

	}

if(listitem == 11)
         {
      new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1087);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
SendClientMessage(playerid,COLOR_WHITE,"[INFO] Гидравлика установлена. ");
   new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
	   	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       return 1;

	}
if(listitem == 12)
      {
      new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1086);
					PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] Стерио установлено. ");
   new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
    	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       return 1;

	}
if(listitem == 13)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "Нитро","Маленький X2\nСредний X4\nБольшой X10","Выбрать","Выход");

return 1;
    }
    if(listitem == 14)
      {
      new car = GetPlayerVehicleID(playerid);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
     RemoveVehicleComponent(car,1045);
     RemoveVehicleComponent(car,1046);
     RemoveVehicleComponent(car,1047);
     RemoveVehicleComponent(car,1048);
     RemoveVehicleComponent(car,1049);
     RemoveVehicleComponent(car,1050);
     RemoveVehicleComponent(car,1051);
     RemoveVehicleComponent(car,1052);
     RemoveVehicleComponent(car,1053);
     RemoveVehicleComponent(car,1054);
     RemoveVehicleComponent(car,1150);
     RemoveVehicleComponent(car,1151);
     RemoveVehicleComponent(car,1152);
     RemoveVehicleComponent(car,1153);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
return 1;
    }
if(listitem == 15)
      {
ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "Мигалки", "Мигалка на верх\nМигающие фары\nНа Главную", "Выбрать", "Выход");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 16)
      {
ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"Смена номера","Введите номера авто в окошко","Готово","Отмена");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

		return 1;
		}
if(listitem == 17)
      {
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"Вы должны быть в машине!");
		ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
		PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
		return 1;
	}
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }
        
if(dialogid == flashpered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1153);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashpered, DIALOG_STYLE_LIST, "Передний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1152);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashpered, DIALOG_STYLE_LIST, "Передний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
    	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }

if(dialogid == flashzad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1150);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashzad, DIALOG_STYLE_LIST, "Задний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1151);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashzad, DIALOG_STYLE_LIST, "Задний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
    	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }
if(dialogid == flashubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1047);
AddVehicleComponent(car,1051);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashubki, DIALOG_STYLE_LIST, "Юбки", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1048);
AddVehicleComponent(car,1052);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashubki, DIALOG_STYLE_LIST, "Юбки", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
    	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }

if(dialogid == flashkovh)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1054);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashkovh, DIALOG_STYLE_LIST, "Ковши", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1053);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashkovh, DIALOG_STYLE_LIST, "Ковши", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
   	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }
if(dialogid == flashspoiler)
	    if(response)
	    {
         if(listitem == 0)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1049);
     RemoveVehicleComponent(car,1050);
AddVehicleComponent(car,1049);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1049);
     RemoveVehicleComponent(car,1050);
AddVehicleComponent(car,1050);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 2)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
    	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }
if(dialogid == flashvihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1046);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1045);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {
    	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКапоты\nСпойлера\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;

