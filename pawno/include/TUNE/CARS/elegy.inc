         if(listitem == 0)
{

            ShowPlayerDialog(playerid, elegypered, DIALOG_STYLE_LIST, "Передний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, elegyzad, DIALOG_STYLE_LIST, "Задний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, elegyubki, DIALOG_STYLE_LIST, "Юбки", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, elegykovh, DIALOG_STYLE_LIST, "Ковши", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, elegyspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nPro-carbon\nНа Главную", "Выбрать", "Выход");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, elegyvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
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
     RemoveVehicleComponent(car,1034);
     RemoveVehicleComponent(car,1035);
     RemoveVehicleComponent(car,1036);
     RemoveVehicleComponent(car,1037);
     RemoveVehicleComponent(car,1038);
     RemoveVehicleComponent(car,1039);
     RemoveVehicleComponent(car,1040);
     RemoveVehicleComponent(car,1041);
     RemoveVehicleComponent(car,1146);
     RemoveVehicleComponent(car,1147);
     RemoveVehicleComponent(car,1148);
     RemoveVehicleComponent(car,1149);
     RemoveVehicleComponent(car,1171);
     RemoveVehicleComponent(car,1172);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
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
    


if(dialogid == elegypered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1171);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegypered, DIALOG_STYLE_LIST, "Передний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1172);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegypered, DIALOG_STYLE_LIST, "Передний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
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

if(dialogid == elegyzad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1149);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyzad, DIALOG_STYLE_LIST, "Задний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1148);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyzad, DIALOG_STYLE_LIST, "Задний бампер", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
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

if(dialogid == elegyubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1040);
AddVehicleComponent(car,1036);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyubki, DIALOG_STYLE_LIST, "Юбки", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1039);
AddVehicleComponent(car,1041);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyubki, DIALOG_STYLE_LIST, "Юбки", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
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

if(dialogid == elegykovh)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1035);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegykovh, DIALOG_STYLE_LIST, "Ковши", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1038);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegykovh, DIALOG_STYLE_LIST, "Ковши", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
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
if(dialogid == elegyspoiler)
	    if(response)
	    {
         if(listitem == 0)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1147);
     RemoveVehicleComponent(car,1146);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
AddVehicleComponent(car,1147);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nPro-carbon\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1147);
     RemoveVehicleComponent(car,1146);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
AddVehicleComponent(car,1146);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nPro-carbon\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1147);
     RemoveVehicleComponent(car,1146);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
            	SetPVarInt(playerid, "spoiler", CreateObject(1001,0,0,0,0,0,0));///////////////стороны///Вперед//////ВЫсота/наклон/наклон
            	AttachObjectToVehicle(GetPVarInt(playerid, "spoiler"), GetPlayerVehicleID(playerid), 0.0, -2.4, 0.30, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyspoiler, DIALOG_STYLE_LIST, "Спойлера", "Alien\nX-flow\nPro-carbon\nНа Главную", "Выбрать", "Выход");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 3)
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
if(dialogid == elegyvihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1034);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1037);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, elegyvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Alien\nX-flow\nНа Главную", "Выбрать", "Выход");
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

