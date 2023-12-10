   new Car2 = GetPlayerVehicleID(playerid), Model2 = GetVehicleModel(Car2);
	  switch(Model2)
		{
			case 446,432,448,452,424,453,454,461,462,463,468,471,430,472,449,473,481,484,493,495,509,510,521,538,522,523,532,537,570,581,586,590,569,595,604,611: return 1;
		}
      if(response)
		{
		    if(listitem == 0)
		    {
                DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");
		    	if(GetPlayerMoney(playerid)>=5000)
                GivePlayerMoney(playerid, -5000);
		        SetPVarInt(playerid, "neon", 1);
            	SetPVarInt(playerid, "blue", CreateObject(18648,0,0,0,0,0,0));
            	SetPVarInt(playerid, "blue1", CreateObject(18648,0,0,0,0,0,0));//               eaai i?aai  aa?o iec
            	AttachObjectToVehicle(GetPVarInt(playerid, "blue"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "blue1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	GameTextForPlayer(playerid, "~b~ Blue ~w~Neon has been added to your vehicle",3500,5);
            	ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
			}

			if(listitem == 1)
			{
		    	DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");
                if(GetPlayerMoney(playerid)>=5000)
                GivePlayerMoney(playerid, -5000);
   				SetPVarInt(playerid, "neon", 1);
       			SetPVarInt(playerid, "green", CreateObject(18649,0,0,0,0,0,0));
       			SetPVarInt(playerid, "green1", CreateObject(18649,0,0,0,0,0,0));
       			AttachObjectToVehicle(GetPVarInt(playerid, "green"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		AttachObjectToVehicle(GetPVarInt(playerid, "green1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		GameTextForPlayer(playerid, "~g~Green ~w~Neon has been added to your vehicle",3500,5);
               ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
			if(listitem == 2)
   {
                DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");
                if(GetPlayerMoney(playerid)>=5000)
                GivePlayerMoney(playerid, -5000);
			    SetPVarInt(playerid, "neon", 1);
       			SetPVarInt(playerid, "yellow", CreateObject(18650,0,0,0,0,0,0));
          		SetPVarInt(playerid, "yellow1", CreateObject(18650,0,0,0,0,0,0));
            	AttachObjectToVehicle(GetPVarInt(playerid, "yellow"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
             	AttachObjectToVehicle(GetPVarInt(playerid, "yellow1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				GameTextForPlayer(playerid, "~y~Yellow~w~ Neon has been added to your vehicle",3500,5);
				ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
			if(listitem == 3)
			{
			    DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");
		      	if(GetPlayerMoney(playerid)>=5000)
                GivePlayerMoney(playerid, -5000);
   				SetPVarInt(playerid, "neon", 1);
   				SetPVarInt(playerid, "white", CreateObject(18652,0,0,0,0,0,0));
   				SetPVarInt(playerid, "white1", CreateObject(18652,0,0,0,0,0,0));
       			AttachObjectToVehicle(GetPVarInt(playerid, "white"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
          		AttachObjectToVehicle(GetPVarInt(playerid, "white1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);

				GameTextForPlayer(playerid, "~w~White~w~ Neon has been added to your vehicle",3500,5);
				ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
			if(listitem == 4)
			{
			    DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");
			    if(GetPlayerMoney(playerid)>=5000)
                GivePlayerMoney(playerid, -5000);
   				SetPVarInt(playerid, "neon", 1);
     			SetPVarInt(playerid, "pink", CreateObject(18651,0,0,0,0,0,0));
        		SetPVarInt(playerid, "pink1", CreateObject(18651,0,0,0,0,0,0));
          		AttachObjectToVehicle(GetPVarInt(playerid, "pink"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "pink1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				GameTextForPlayer(playerid, "~p~Pink~w~ Neon has been added to your vehicle",3500,5);
				ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

			if(listitem == 5)
			{
			    DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");
			    if(GetPlayerMoney(playerid)>=5000)
                GivePlayerMoney(playerid, -5000);
   				SetPVarInt(playerid, "neon", 1);
     			SetPVarInt(playerid, "aqua", CreateObject(18648,0,0,0,0,0,0));
     			SetPVarInt(playerid, "aqua1", CreateObject(18649,0,0,0,0,0,0));
        		SetPVarInt(playerid, "aqua2", CreateObject(18648,0,0,0,0,0,0));
        		SetPVarInt(playerid, "aqua3", CreateObject(18649,0,0,0,0,0,0));
          		AttachObjectToVehicle(GetPVarInt(playerid, "aqua"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "aqua1"), GetPlayerVehicleID(playerid),-0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "aqua2"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            	AttachObjectToVehicle(GetPVarInt(playerid, "aqua3"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				GameTextForPlayer(playerid, "~p~Aqua~w~ Neon has been added to your vehicle",3500,5);
				ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Неон для авто","Синий\nЗеленый\nЖелтый\nБелый\nРозовый\nАква\nВыключить неон\nНа Главную","Выбрать","Выход");
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}


			if(listitem == 6)
			{
	   			DestroyObject(GetPVarInt(playerid, "blue"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "blue1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "green1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "yellow1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "white1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "pink1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua1"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua2"));
	            DeletePVar(playerid, "neon");
	            DestroyObject(GetPVarInt(playerid, "aqua3"));
	            DeletePVar(playerid, "neon");

	            DeletePVar(playerid, "neon");
	            GameTextForPlayer(playerid, "~g~Neon was deleted from your vehicle",3500,5);
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
  PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
   PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
     PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
       PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
         PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
          PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
           PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
             PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
              PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
               PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);

return 1;
}

	if(listitem == 7)

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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "Тюнинг System от Startserv","Лампы\nКапот\nЮбки\nКовши\nСпойлера\nВыхлоп\nПокрасочные работы\nНеон\nКолеса\nПокрасить\nПочинить\nГидравлика\nСтерео\nНитро\nУбрать все обвесы\nМигалки\nСменить номер\nУправление автомобилем","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "Вы должны быть в: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");

	   }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         KillTimer(stretrace);
         return 1;
        }
         return 1;
