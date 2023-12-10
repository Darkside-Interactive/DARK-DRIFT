if(listitem == 0)
	        {
 new car = GetPlayerVehicleID(playerid);
 AddVehicleComponent(car,1008);
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Азот установлен. ");
 StopAudioStreamForPlayer(playerid); // отключим
 KillTimer(lourider);
 KillTimer(stretrace);
return 1;
}

if(listitem == 1)
	        {
 new car = GetPlayerVehicleID(playerid);
 AddVehicleComponent(car,1009);
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Азот установлен. ");
 StopAudioStreamForPlayer(playerid); // отключим
 KillTimer(lourider);
 KillTimer(stretrace);
return 1;
}
if(listitem == 2)
	        {
 new car = GetPlayerVehicleID(playerid);
 AddVehicleComponent(car,1010);
 PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Азот установлен. ");
 StopAudioStreamForPlayer(playerid); // отключим
 KillTimer(lourider);
 KillTimer(stretrace);
return 1;
}
return 1;
