if(listitem == 0)
	        {
new carid = GetPlayerVehicleID(playerid);
  		if(NenadoLustru(carid))
		{
    		SendClientMessage(playerid, 0xF6CB00AA, "На этот транспорт мигалка не предусмотрена");
			return true;
		}
		lustra[playerid] = CreateObject(18646,0,0,0,0,0,0,0.0);
		switch(GetVehicleModel(carid))
		{
			case 587: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.30, 0.80, 0.0, 0.0, 0.0); //Euros
			case 562: AttachObjectToVehicle(lustra[playerid],carid, 0.0,-0.0, 0.85, 0.0, 0.0, 0.0); //Elegy
			case 602: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.30, 0.77, 0.0, 0.0, 0.0); //Alpha
			case 415: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.65, 0.0, 0.0, 0.0); //Cheetah
			case 451: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.20, 0.63, 0.0, 0.0, 0.0); //Turismo
			case 559: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.77, 0.0, 0.0, 0.0); //Jester
			case 541: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.70, 0.0, 0.0, 0.0); //Bullet
			case 565: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0); //Flash
			case 540: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.79, 0.0, 0.0, 0.0); //Vincent
			case 507: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.88, 0.0, 0.0, 0.0); //Elegant
			case 491: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.20, 0.78, 0.0, 0.0, 0.0); //Virgo
			case 492: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.92, 0.0, 0.0, 0.0); //Greenwood
			case 526: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.70, 0.0, 0.0, 0.0); //Fortune
			case 529: AttachObjectToVehicle(lustra[playerid],carid,  0.0, 0.0, 0.95, 0.0, 0.0, 0.0); //Willard
            case 401: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.82, 0.0, 0.0, 0.0); //Bravura
            case 518: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0); //Buccaneer
            case 527: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.93, 0.0, 0.0, 0.0); //Cadrona
            case 542: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.87, 0.0, 0.0, 0.0); //Clover
            case 585: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.08, 0.0, 0.0, 0.0); //Emperor
            case 419: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0); //Esperanto
            case 466: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.93, 0.0, 0.0, 0.0); //Glendale
            case 474: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.88, 0.0, 0.0, 0.0); //Hermes
            case 546: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.87, 0.0, 0.0, 0.0); //Intruder
            case 551: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0); //Merit
            case 467: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.87, 0.0, 0.0, 0.0); //Oceanic
            case 547: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0); //Primo
            case 580: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.10, 0.0, 0.0, 0.0); //Stafford
            case 405: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.80, 0.0, 0.0, 0.0); //Sentinel
            case 550: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.77, 0.0, 0.0, 0.0); //Sunrise
            case 549: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.80, 0.0, 0.0, 0.0); //Tampa
            case 421: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0); //Washington
            case 429: AttachObjectToVehicle(lustra[playerid],carid,0.0, 0.60, 0.37, 0.0, 0.0, 0.0); //Banshee
            case 402: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.20, 0.80, 0.0, 0.0, 0.0); //Buffalo
            case 589: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.10, 0.0, 0.0, 0.0); //Club
            case 494: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.10, 0.80, 0.0, 0.0, 0.0); //Hotring Racer
            case 502: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.10, 0.82, 0.0, 0.0, 0.0); //Hotring Racer 2
            case 503: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.10, 0.84, 0.0, 0.0, 0.0); //Hotring Racer 3
            case 411: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.77, 0.0, 0.0, 0.0); //Infernus
            case 603: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.10, 0.73, 0.0, 0.0, 0.0); //Phoenix
            case 475: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.79, 0.0, 0.0, 0.0); //Sabre
            case 506: AttachObjectToVehicle(lustra[playerid],carid,0.0, 0.90, 0.30, 0.0, 0.0, 0.0); //Super GT
            case 477: AttachObjectToVehicle(lustra[playerid],carid,0.0,-0.20, 0.77, 0.0, 0.0, 0.0); //ZR-350
            case 404: AttachObjectToVehicle(lustra[playerid],carid,0.0,  0.0, 1.00, 0.0, 0.0, 0.0); //Perenniel
            case 479: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.05, 0.0, 0.0, 0.0); //Regina
            case 458: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.80, 0.0, 0.0, 0.0); //Solair
            case 412: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.78, 0.0, 0.0, 0.0); //Voodoo
            case 439: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 1.0, 0.35, 0.0, 0.0, 0.0); //Stallion
            case 480: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.80, 0.35, 0.0, 0.0, 0.0); //Comet
            case 500: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.80, 0.35, 0.0, 0.0, 0.0); //Mesa
            case 505: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.15, 0.0, 0.0, 0.0); //Rancher
            case 489: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.15, 0.0, 0.0, 0.0); //Rancher 2
            case 504: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.93, 0.0, 0.0, 0.0); //Bloodring Banger
            case 533: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 1.15, 0.40, 0.0, 0.0, 0.0); //Feltzer
            case 534: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.70, 0.0, 0.0, 0.0); //Remington
            case 535: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.87, 0.0, 0.0, 0.0); //Slamvan
            case 536: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 1.20, 0.28, 0.0, 0.0, 0.0); //Blade
            case 555: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.90, 0.30, 0.0, 0.0, 0.0); //Windsor
            case 567: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 1.60, 0.22, 0.0, 0.0, 0.0); //Savanna
            case 575: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 1.30, 0.58, 0.0, 0.0, 0.0); //Broadway
            case 576: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0); //Tornado
            case 579: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.30, 0.0, 0.0, 0.0); //Huntley
            case 600: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.84, 0.0, 0.0, 0.0); //Picador
            case 495: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.06, 0.0, 0.0, 0.0); //Sandking
            case 543: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0); //Sadler
            case 422: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.89, 0.0, 0.0, 0.0); //Bobcat
            case 554: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 1.10, 0.0, 0.0, 0.0); //Yosemite
		 	 default: AttachObjectToVehicle(lustra[playerid],carid, 0.0, 0.0, 0.90, 0.0, 0.0, 0.0); //Other cars


  }
  PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
  ShowPlayerDialog(playerid, lightsmenu2, DIALOG_STYLE_LIST, "Мигалка", "Включить\nВыключить\nНазад\nНа Главную", "Выбрать", "Выход");
	return true;

}

if(listitem == 1)
	        {
 DestroyObject(lustra[playerid]);
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, lightsmenu2, DIALOG_STYLE_LIST, "Мигалка", "Включить\nВыключить\nНазад\nНа Главную", "Выбрать", "Выход");
		return true;
	}

	if(listitem == 2)
	        {

ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "Мигалки", "Мигалка на верх\nМигающие фары\nНа Главную", "Выбрать", "Назад");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
		return true;
	}



if(listitem == 3)
	        {
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
 new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {

	   #include "CARID"
       }

}
        }
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {

         StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(lourider);
         KillTimer(stretrace);
         return 1;

