//Autor: Eugen_McLuhan(Mesmer)
#include <a_samp>
#pragma tabsize 0
#define COLOR_ACCESS 0x33AA33FF
//Picap`s ///////
new pickupIzintmeri;
new pickupVint;
new pickupIZinta;
new pickupVkabinet;
new pickupIZkabineta;
new pickupVintmeri;
new pickupvihoda;
new pickupvhoda;
new pickupvofis;
new pickupizofis;
new chemodan;
new adminshtab;
new kyxna;
public OnFilterScriptInit()
{
////Picap`s //////////
CreateVehicle(522, -2621.780029, 1369.574829, 7.067412, -1, -1, 100);
SetVehicleVirtualWorld(522, 5);
pickupVint = CreatePickup(1318,23,1547.2399,-1270.5383,17.4063,-1); //+//
pickupIZinta = CreatePickup(1318,23,1583.9526,-1263.7540,252.7455,-1); //+//
pickupVkabinet = CreatePickup(1318,23,1582.9235,-1239.3081,252.7382,-1); //+//
pickupIZkabineta = CreatePickup(1318,23,1582.2412,-1237.0963,252.7301,-1); //+//
chemodan = CreatePickup(1210,23,-2660.444335,1446.305541,41.835937,-1); //+//
adminshtab = CreatePickup(1318,23,1456.132568,2773.340087,10.820312,-1);
kyxna = CreatePickup(19605,23,1279.297729,-808.949890,1085.632812,-1);
Create3DTextLabel("Если ты не выполняешь задание, лучше не бери этот пикап!",0xFF0000FF,1279.297729,-808.949890,1085.632812,10.0,0,1);
	return 1;
}
public OnFilterScriptExit()
{
	DestroyPickup(pickupVint);
	DestroyPickup(pickupIZinta);
	DestroyPickup(pickupVkabinet);
	DestroyPickup(pickupIZkabineta);
	DestroyPickup(pickupVintmeri);
	DestroyPickup(pickupIzintmeri);
	DestroyPickup(pickupvhoda);
	DestroyPickup(pickupvihoda);
	DestroyPickup(pickupvofis);
	DestroyPickup(pickupizofis);
	DestroyPickup(chemodan);
	DestroyPickup(adminshtab);
	DestroyPickup(kyxna);
	return 1;
}
public OnPlayerPickUpPickup(playerid,pickupid)
{
   if(pickupid == pickupVint)//ставим условие подобрал ли перс пикап pickup
   {
      SetPlayerPos(playerid,1582.4109,-1263.6188,252.7382);//перемещаем его к координатам 0.1,0.1,0.1
   }
   if(pickupid == pickupIZinta)//ставим условие подобрал ли перс пикап pickup
   {
      SetPlayerPos(playerid,1550.1708,-1272.7487,17.4063);//перемещаем его к координатам 0.1,0.1,0.1
   }
   if(pickupid == pickupVkabinet)//ставим условие подобрал ли перс пикап pickup
   {
      SetPlayerPos(playerid,1584.5289,-1236.7483,252.7301);//перемещаем его к координатам 0.1,0.1,0.1
   }
   if(pickupid == pickupIZkabineta)//ставим условие подобрал ли перс пикап pickup
   {
      SetPlayerPos(playerid,1584.8314,-1239.5516,252.7382);//перемещаем его к координатам 0.1,0.1,0.1
   }
   if(pickupid == chemodan)
   {
	  GivePlayerMoney(playerid,100000);
	  SendClientMessage(playerid, COLOR_ACCESS,"Молодец! Теперь отвези его в Админ-Штаб!");
	  SendClientMessage(playerid, COLOR_ACCESS,"Установлена метка на карте. Вези туда!");
	  SendClientMessage(playerid, COLOR_ACCESS,"Возле выезда из Джиззи стоит мотоцикл, используй его!");
	  DisablePlayerCheckpoint(playerid,-2660.444335,1446.305541,41.835937);
	  PlayerPlaySound(playerid, 3036, 10.0, 10.0, 1.0);
	  SetPlayerCheckpoint(playerid,1456.132568,2773.340087,10.820312);
	  DestroyPickup(chemodan);
   }
   if(pickupid == adminshtab)
   {
	  SetPlayerPos(playerid, 1267.663208,-781.323242,1091.906250);
	  SetPlayerInterior(playerid, 5);
   }
   if(pickupid == kyxna)
   {
	  SetPlayerPos(playerid,1460.072875,2773.127197,10.820312);
	  SendClientMessage(playerid, COLOR_ACCESS,"Поздравляю! Ты прошел первое задание!");
	  SendClientMessage(playerid, COLOR_ACCESS,"В награду ты получаешь +50 к своей репутации!");
	  DisablePlayerCheckpoint(playerid,1279.297729,-808.949890,1085.632812);
	  DisablePlayerCheckpoint(playerid,1456.132568,2773.340087,10.820312);
	  GetPlayerMoney(playerid, 50);
	  SetPlayerTime(playerid, 12);
	  SetPlayerWeather(playerid, 0);
	  SetPlayerVirtualWorld(playerid, 0);
	  SetPlayerInterior(playerid, 0);
	  PlayAudioStreamForPlayer(playerid, "https://dl2.mp3party.net/online/8423213.mp3");
   }
}
main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}
