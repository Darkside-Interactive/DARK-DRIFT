         if(listitem == 0)
{

            ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "Выхлоп", "exhaust 1018\nexhaustр 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\nНа Главную", "Выбрать", "Назад");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
         ShowPlayerDialog(playerid, genericubka, DIALOG_STYLE_LIST, "Юбки", "Юбка 1007  1017\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
         ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1\nvents 2\nvents 3\nvents 4\nНа Главную", "Выбрать", "Назад");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
	        ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
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
   ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
       return 1;

	}




if(listitem == 9)
      {
      new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1087);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
SendClientMessage(playerid,COLOR_WHITE,"[INFO] Гидравлика установлена. ");
   ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");

       return 1;

	}
if(listitem == 10)
      {
      new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1086);
					PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] Стерио установлено. ");
   ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");


       return 1;

	}
if(listitem == 11)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "Нитро","Маленький X2\nСредний X4\nБольшой X10","Выбрать","Выход");

return 1;
    }
    if(listitem == 12)
      {



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
ShowPlayerDialog(playerid, genericlamps, DIALOG_STYLE_LIST, "Lamps", "lamps 1013\nlamps 1024\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

		return 1;
		}
		if(listitem == 16)
      {
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"Вы должны быть в машине!");
		ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
		PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

}
        }
if(dialogid == genericexhaust)
	    if(response)
	    {
         if(listitem == 0)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1018);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "Выхлоп", "exhaust 1018\nexhaustр 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\nНа Главную", "Выбрать", "Назад");

	return 1;
}
if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1019);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "Выхлоп", "exhaust 1018\nexhaustр 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\nНа Главную", "Выбрать", "Назад");

	return 1;
}
if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1020);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "Выхлоп", "exhaust 1018\nexhaustр 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\nНа Главную", "Выбрать", "Назад");

	return 1;
}


if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1021);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "Выхлоп", "exhaust 1018\nexhaustр 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\nНа Главную", "Выбрать", "Назад");

	return 1;
}
if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1022);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "Выхлоп", "exhaust 1018\nexhaustр 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\nНа Главную", "Выбрать", "Назад");

	return 1;
}







	if(listitem == 5)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
         return 1;
        }
}

if(dialogid == genericscoop)
	    if(response)
	    {
         if(listitem == 0)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1004);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\nНа Главную", "Выбрать", "Назад");

return 1;
}
if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1005);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\nНа Главную", "Выбрать", "Назад");
	return 1;
}


if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1006);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\nНа Главную", "Выбрать", "Назад");
	return 1;
}

if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1011);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\nНа Главную", "Выбрать", "Назад");
	return 1;
}

if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1012);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\nНа Главную", "Выбрать", "Назад");
	return 1;
}




	if(listitem == 5)
{

ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
         return 1;
        }
        }
if(dialogid == genericubka)
	    if(response)
	    {
         if(listitem == 0)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1012);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericubka, DIALOG_STYLE_LIST, "Юбки", "Юбка 1007  1017\nНа Главную", "Выбрать", "Назад");

return 1;
}


	if(listitem == 1)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
         return 1;
        }
        }
if(dialogid == genericvents)
	    if(response)
	    {
         if(listitem == 0)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1142);


 ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\nНа Главную", "Выбрать", "Назад");

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
         if(listitem == 1)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1143);



ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\nНа Главную", "Выбрать", "Назад");

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1144);




ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1145);




ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
         return 1;
        }
}



  if(dialogid == genericlamps)
	    if(response)
	    {
         if(listitem == 0)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1013);
ShowPlayerDialog(playerid, genericlamps, DIALOG_STYLE_LIST, "Lamps", "lamps 1013\nlamps 1024\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1024);
ShowPlayerDialog(playerid, genericlamps, DIALOG_STYLE_LIST, "Lamps", "lamps 1013\nlamps 1024\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 2)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
	return 1;
}
}






if(dialogid == genericspoiler)
	    if(response)
	    {
         if(listitem == 0)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1000);
ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1002);
ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1003);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1014);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1015);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 5)
{


new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1016);
ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 6)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1023);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "Cпойлеры", "Спойлер 1000\nСпойлер 1001\nСпойлер 1002\nСпойлер 1003\nСпойлер 1014\nСпойлер 1015\nСпойлер 1016\nСпойлер 1023\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}









if(listitem == 7)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Выхлоп\nЗадние бампера\nЮбки\nVents\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nЛампы\nУправление автомобилем","Add","Close");
return 1;

}
return 1;
