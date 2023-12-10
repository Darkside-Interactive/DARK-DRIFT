         if(listitem == 0)
{

            ShowPlayerDialog(playerid, infernuspered, DIALOG_STYLE_LIST, "Передний бампер", "Бампер 1\nБампер 2\nБампер 3\nНа Главную", "Выбрать", "Назад");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, infernuszad, DIALOG_STYLE_LIST, "Задний бампер", "Бампер 1\nБампер 2\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, infernusubka, DIALOG_STYLE_LIST, "Юбки", "Юбка 1\nЮбка 2\nЮбка 3\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, infernuskapot, DIALOG_STYLE_LIST, "Капоты", "Капот 1\nКапот 2\nКапот 3\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
	        ShowPlayerDialog(playerid, infernusspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1\nСпойлер 2\nСпойлер 3\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
	        ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 6)
	        {
	        ShowPlayerDialog(playerid, whel, DIALOG_STYLE_LIST, "Колеса","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\nГлавное Меню","Выбрать","Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 7)
	        {
	        ShowPlayerDialog(playerid, COLOR, DIALOG_STYLE_LIST, "Colors", "Черный\nБелый\nКрасный\nГолубой\nЗеленый\nЖелтый\nРозовый\nКоричневый\nСерый\nЗолотой\nТемно синий\nСветло синий\nХолодный зеленый\nСветло Серый\nТемно красный\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 8)
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




if(listitem == 9)
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
if(listitem == 10)
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
if(listitem == 11)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "Нитро","Маленький X2\nСредний X4\nБольшой X10","Выбрать","Выход");

return 1;
    }
    if(listitem == 12)
      {
          DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad3"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka22"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka33"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot3"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
SetPVarInt(playerid, "object", 1);
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

    if(listitem == 13)
      {
ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "Мигалки", "Мигалка на верх\nМигающие фары\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 14)
      {
ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"Смена номера","Введите номера авто в окошко","Готово","Отмена");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

		return 1;
		}
		if(listitem == 15)
      {
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"Вы должны быть в машине!");
		ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
		PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

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
if(dialogid == infernuspered)
	    if(response)
	    {
         if(listitem == 0)
	        {

DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "bamper", CreateObject(1160,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "bamper"), GetPlayerVehicleID(playerid), -1.1, 1.9, -0.30, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernuspered, DIALOG_STYLE_LIST, "Передний бампер", "Бампер 1\nБампер 2\nБампер 3\nНа Главную", "Выбрать", "Назад");

	return 1;
}
if(listitem == 1)
{
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper"));
SetPVarInt(playerid, "object", 1);

SetPVarInt(playerid, "bamper2", CreateObject(1172,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "bamper2"), GetPlayerVehicleID(playerid), -1.025, 2.06, -0.25, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernuspered, DIALOG_STYLE_LIST, "Передний бампер", "Бампер 1\nБампер 2\nБампер 3\nНа Главную", "Выбрать", "Назад");

	return 1;
}
if(listitem == 2)
{
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamper"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "bamper3", CreateObject(1157,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "bamper3"), GetPlayerVehicleID(playerid), -1.050, 2.06, -0.23, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernuspered, DIALOG_STYLE_LIST, "Передний бампер", "Бампер 1\nБампер 2\nБампер 3\nНа Главную", "Выбрать", "Назад");

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


if(dialogid == infernuszad)
	    if(response)
	    {
         if(listitem == 0)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad3"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "bamperzad", CreateObject(1154,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "bamperzad"), GetPlayerVehicleID(playerid), 1.1, -1.55, -0.20, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernuszad, DIALOG_STYLE_LIST, "Задний бампер", "Бампер 1\nБампер 2\nНа Главную", "Выбрать", "Назад");

return 1;
}
if(listitem == 1)
{
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "bamperzad3"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "bamperzad2", CreateObject(1148,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "bamperzad2"), GetPlayerVehicleID(playerid), 1.05, -1.85, -0.20, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernuszad, DIALOG_STYLE_LIST, "Задний бампер", "Бампер 1\nБампер 2\nНа Главную", "Выбрать", "Назад");
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
if(dialogid == infernusubka)
	    if(response)
	    {
         if(listitem == 0)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka22"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka33"));
SetPVarInt(playerid, "object", 1);
       			SetPVarInt(playerid, "upka", CreateObject(1071,0,0,0,0,0,0));
          		SetPVarInt(playerid, "upka1", CreateObject(1069,0,0,0,0,0,0));
            	AttachObjectToVehicle(GetPVarInt(playerid, "upka"), GetPlayerVehicleID(playerid), -1.0, -1.15, -0.65, 0.0, 0.0, 0.0);

           	AttachObjectToVehicle(GetPVarInt(playerid, "upka1"), GetPlayerVehicleID(playerid), 1.0, -1.15, -0.65, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernusubka, DIALOG_STYLE_LIST, "Юбки", "Юбка 1\nЮбка 2\nЮбка 3\nНа Главную", "Выбрать", "Назад");

return 1;
}

 if(listitem == 1)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka22"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka33"));
SetPVarInt(playerid, "object", 1);
          		SetPVarInt(playerid, "upka2", CreateObject(1062,0,0,0,0,0,0));
          		SetPVarInt(playerid, "upka22", CreateObject(1056,0,0,0,0,0,0));
             	AttachObjectToVehicle(GetPVarInt(playerid, "upka2"), GetPlayerVehicleID(playerid), -1.0, -0.15, -0.60, 0.0, 0.0, 0.0);
             	AttachObjectToVehicle(GetPVarInt(playerid, "upka22"), GetPlayerVehicleID(playerid), 1.0, -0.15, -0.60, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernusubka, DIALOG_STYLE_LIST, "Юбки", "Юбка 1\nЮбка 2\nЮбка 3\nНа Главную", "Выбрать", "Назад");

return 1;
}
if(listitem == 2)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka22"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka3"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "upka33"));
SetPVarInt(playerid, "object", 1);
          		SetPVarInt(playerid, "upka3", CreateObject(1107,0,0,0,0,0,0));
          		SetPVarInt(playerid, "upka33", CreateObject(1107,0,0,0,0,0,0));
             	AttachObjectToVehicle(GetPVarInt(playerid, "upka3"), GetPlayerVehicleID(playerid), -1.0, -0.15, -0.65, 0.0, 180.0, 0.0);
             	AttachObjectToVehicle(GetPVarInt(playerid, "upka33"), GetPlayerVehicleID(playerid), 1.0, -0.15, -0.65, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernusubka, DIALOG_STYLE_LIST, "Юбки", "Юбка 1\nЮбка 2\nЮбка 3\nНа Главную", "Выбрать", "Назад");

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
if(dialogid == infernuskapot)
	    if(response)
	    {
         if(listitem == 0)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot3"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
                SetPVarInt(playerid, "kapot", CreateObject(1144,0,0,0,0,0,0));
          		SetPVarInt(playerid, "kapot1", CreateObject(1144,0,0,0,0,0,0));
            	AttachObjectToVehicle(GetPVarInt(playerid, "kapot"), GetPlayerVehicleID(playerid), -0.8, 1.45, 0.18, 0.0, 0.0, 0.0);
             	AttachObjectToVehicle(GetPVarInt(playerid, "kapot1"), GetPlayerVehicleID(playerid), 0.8, 1.45, 0.18, 0.0, 0.0, 0.0);
 ShowPlayerDialog(playerid, infernuskapot, DIALOG_STYLE_LIST, "Капоты", "Капот 1\nКапот 2\nКапот 3\nНа Главную", "Выбрать", "Назад");

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
         if(listitem == 1)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot3"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
          		SetPVarInt(playerid, "kapot2", CreateObject(1012,0,0,0,0,0,0));
             	AttachObjectToVehicle(GetPVarInt(playerid, "kapot2"), GetPlayerVehicleID(playerid), 0.0, 1.45, 0.18, 0.0, 0.0, 0.0);
 ShowPlayerDialog(playerid, infernuskapot, DIALOG_STYLE_LIST, "Капоты", "Капот 1\nКапот 2\nКапот 3\nНа Главную", "Выбрать", "Назад");

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot1"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot2"));
SetPVarInt(playerid, "object", 1);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "kapot3"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "kapot", CreateObject(1144,0,0,0,0,0,0));
SetPVarInt(playerid, "kapot1", CreateObject(1144,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "kapot"), GetPlayerVehicleID(playerid), -0.8, 1.45, 0.18, 0.0, 0.0, 0.0);
AttachObjectToVehicle(GetPVarInt(playerid, "kapot1"), GetPlayerVehicleID(playerid), 0.8, 1.45, 0.18, 0.0, 0.0, 0.0);
SetPVarInt(playerid, "kapot3", CreateObject(1012,0,0,0,0,0,0));
AttachObjectToVehicle(GetPVarInt(playerid, "kapot3"), GetPlayerVehicleID(playerid), 0.0, 1.45, 0.18, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernuskapot, DIALOG_STYLE_LIST, "Капоты", "Капот 1\nКапот 2\nКапот 3\nНа Главную", "Выбрать", "Назад");
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

if(dialogid == infernusspoiler)
	    if(response)
	    {
         if(listitem == 0)
	        {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
SetPVarInt(playerid, "object", 1);
            	SetPVarInt(playerid, "spoiler", CreateObject(1001,0,0,0,0,0,0));///////////////стороны///Вперед//////ВЫсота/наклон/наклон
            	AttachObjectToVehicle(GetPVarInt(playerid, "spoiler"), GetPlayerVehicleID(playerid), 0.0, -2.4, 0.30, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernusspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1\nСпойлер 2\nСпойлер 3\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "spoiler2", CreateObject(1016,0,0,0,0,0,0));///////////////стороны///Вперед//////ВЫсота/наклон/наклон
AttachObjectToVehicle(GetPVarInt(playerid, "spoiler2"), GetPlayerVehicleID(playerid), 0.0, -2.4, 0.30, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernusspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1\nСпойлер 2\nСпойлер 3\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 2)
{
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "spoiler3", CreateObject(1164,0,0,0,0,0,0));///////////////стороны///Вперед//////ВЫсота/наклон/наклон
AttachObjectToVehicle(GetPVarInt(playerid, "spoiler3"), GetPlayerVehicleID(playerid), 0.0, -2.4, 0.40, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, infernusspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1\nСпойлер 2\nСпойлер 3\nНа Главную", "Выбрать", "Назад");
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
