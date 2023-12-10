	new carid = GetPlayerVehicleID(playerid);
	new engine,lights,alarm,doors,bonnet,boot,objective;
      if(listitem == 0)//капот отк
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,true,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              return 1;
			}
			if(listitem == 1)//багажник отк
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,true,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 2)//свет вкл
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,true,alarm,doors,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 3)//сигнал вкл
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,true,doors,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 4)//двери блок
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,true,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 5)//мотор старт
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,true,lights,alarm,doors,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 6)//капот зак
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,false,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 7)//багажник зак
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,false,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 8)//свет выкл
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,false,alarm,doors,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 9)//сигнал выкл
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,false,doors,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 10)//двери откр
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,engine,lights,alarm,false,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 11)//мотор стоп
			{
			    GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
              	SetVehicleParamsEx(carid,false,lights,alarm,doors,bonnet,boot,objective);
              	ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"Авто-Меню","Открыть капот\nОткрыть багажник\nВключить свет\nВключить сигнализацию\nЗакрыть двери\nЗапустить мотор\
		\nЗакрыть капот\nЗакрыть багажник\nВыключить свет\nВыключить сигнализацию\nОткрыть двери\nЗаглушить мотор\nГлавное меню\n","Выбрать","Выход");
              	return 1;
			}
			if(listitem == 12)//мотор стоп
			{
			PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
			    	  new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {

	   #include "carid"

       }
      }
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;

