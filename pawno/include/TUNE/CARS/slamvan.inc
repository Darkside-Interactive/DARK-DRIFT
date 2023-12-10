if(listitem == 0)
{

            ShowPlayerDialog(playerid, slamvanpered, DIALOG_STYLE_LIST, "Передний бампер-решотки радиатора", "Решотка1\nРешотка2\nБампер\nНа Главную", "Выбрать", "Выход");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, slamvanzad, DIALOG_STYLE_LIST, "Задний бампер и Стопари", "Бампер\nСтопак\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, slamvanubki, DIALOG_STYLE_LIST, "Юбки", "Chrome\nЗакрытое колесо заднее\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, slamvankovh, DIALOG_STYLE_LIST, "Значек игрушка на капот", "Элемент1\nЭлемент2\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}


if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, slamvanvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Chrome\nSlamin\nНа Главную", "Выбрать", "Выход");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "Покрасочные работы", "Покрасочная работа 1\nПокрасочная работа 2\nПокрасочная работа 3\nУбрать покрасочную Работу\nНа Главную", "Выбрать", "Выход");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 6)
	        {
	        ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 7)
	        {
	        ShowPlayerDialog(playerid, whel, DIALOG_STYLE_LIST, "Колеса","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\nГлавное Меню","Выбрать","Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 8)
	        {
	        ShowPlayerDialog(playerid, COLOR, DIALOG_STYLE_LIST, "Colors", "Черный\nБелый\nКрасный\nГолубой\nЗеленый\nЖелтый\nРозовый\nКоричневый\nСерый\nЗолотой\nТемно синий\nСветло синий\nХолодный зеленый\nСветло Серый\nТемно красный\nНа Главную", "Выбрать", "Выход");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}


if(listitem == 9)
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");



       }
       return 1;

	}

if(listitem == 10)
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");



       }
       return 1;

	}
if(listitem == 11)
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");



       }
       return 1;

	}
if(listitem == 12)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "Нитро","Маленький X2\nСредний X4\nБольшой X10","Выбрать","Выход");

return 1;
    }
    if(listitem == 13)
      {
      new car = GetPlayerVehicleID(playerid);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
     RemoveVehicleComponent(car,1109);
     RemoveVehicleComponent(car,1110);
     RemoveVehicleComponent(car,1111);
     RemoveVehicleComponent(car,1112);
     RemoveVehicleComponent(car,1113);
     RemoveVehicleComponent(car,1114);
     RemoveVehicleComponent(car,1115);
     RemoveVehicleComponent(car,1116);
     RemoveVehicleComponent(car,1117);
     RemoveVehicleComponent(car,1118);
     RemoveVehicleComponent(car,1119);
RemoveVehicleComponent(car,1120);
RemoveVehicleComponent(car,1121);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
StopAudioStreamForPlayer(playerid); // отключим
KillTimer(lourider);
return 1;
    }
if(listitem == 14)
      {
ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "Мигалки", "Мигалка на верх\nМигающие фары\nНа Главную", "Выбрать", "Выход");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 15)
      {
ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"Смена номера","Введите номера авто в окошко","Готово","Отмена");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

		return 1;
		}
if(listitem == 16)
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

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         return 1;
        }

if(dialogid == slamvanpered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1115);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanpered, DIALOG_STYLE_LIST, "Передний бампер-решотки радиатора", "Решотка1\nРешотка2\nБампер\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1116);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanpered, DIALOG_STYLE_LIST, "Передний бампер-решотки радиатора", "Решотка1\nРешотка2\nБампер\nНа Главную", "Выбрать", "Выход");
return 1;
}
if(listitem == 2)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1117);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanpered, DIALOG_STYLE_LIST, "Передний бампер-решотки радиатора", "Решотка1\nРешотка2\nБампер\nНа Главную", "Выбрать", "Выход");
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");



       }
       }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         return 1;
        }
if(dialogid == slamvanzad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1109);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanzad, DIALOG_STYLE_LIST, "Задний бампер и Стопари", "Бампер\nСтопак\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1110);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanzad, DIALOG_STYLE_LIST, "Задний бампер и Стопари", "Бампер\nСтопак\nНа Главную", "Выбрать", "Выход");
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna, Blade, Slamvan");



       }
       }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         return 1;
        }

if(dialogid == slamvanubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1118);
AddVehicleComponent(car,1120);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanubki, DIALOG_STYLE_LIST, "Юбки", "Chrome\nЗакрытое колесо заднее\nНа Главную", "Выбрать", "Выход");
return 1;
}

         if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1119);
AddVehicleComponent(car,1121);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanubki, DIALOG_STYLE_LIST, "Юбки", "Chrome\nЗакрытое колесо заднее\nНа Главную", "Выбрать", "Выход");
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         return 1;
        }

if(dialogid == slamvankovh)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1111);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvankovh, DIALOG_STYLE_LIST, "Значек игрушка на капот", "Элемент1\nЭлемент2\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1112);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvankovh, DIALOG_STYLE_LIST, "Значек игрушка на капот", "Элемент1\nЭлемент2\nНа Главную", "Выбрать", "Выход");
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");



       }
       }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         return 1;
        }

if(dialogid == slamvanvihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1113);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Chrome\nSlamin\nНа Главную", "Выбрать", "Выход");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1114);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, slamvanvihlop, DIALOG_STYLE_LIST, "Выхлоп", "Chrome\nSlamin\nНа Главную", "Выбрать", "Выход");
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
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nРешотки радиатора/Фары\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера\nЗадние бампера\nЮбки\nКрыша\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Передние Бампера-Решотки радиатора\nЗадние бампера-стопаки\nЮбки\nЗначёк игрушка на капот\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");

        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");



       }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         return 1;



