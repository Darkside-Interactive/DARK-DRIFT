#include <a_samp>

#define COLOR_DARKGOLD 0x808000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_RED 0xAA3333AA



#define HotPoint1 2009.0814,-1728.1830,13.4533
#define HotPoint2 2009.0692,-1640.7626,13.4465
#define HotPoint3 2075.3311,-1643.5902,13.4073
#define HotPoint4 2138.3816,-1616.8345,13.4692
#define HotPoint5 2172.3430,-1675.6588,14.9697
#define HotPoint6 2308.7888,-1665.8096,14.3982
#define HotPoint7 2503.9426,-1658.8201,13.3568
#define HotPoint8 2376.7712,-1907.2572,13.2880
#define HotPoint9 2238.4990,-1902.2578,13.4472
#define HotPoint10 1131.9427,-2037.3005,68.9129
#define HotPoint11 1623.0204,-1858.5880,13.4557
#define Refillpoint 1618.9200,-1892.1852,13.4540

new hotdog = 0;
new hotinfo;

public OnFilterScriptInit()
{
    
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    hotinfo = CreatePickup(1239,1,1671.2996,-1881.1387,13.5448,-1);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/hotdog", cmdtext, true, 10) == 0)
	{
        if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 588)
      	{
            hotdog = 1;
		    SetPlayerCheckpoint(playerid, HotPoint1, 3.0);
	        GameTextForPlayer(playerid, "~g~You started the job, good luck!", 3000, 3);
            new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "%s продает хот-доги.", name );
            SendClientMessageToAll(COLOR_RED, string);
			return 1;
	    }
		SendClientMessage(playerid, COLOR_RED,"Вы закупили хотдоги и можете отвезти их на маркер");
	}
	if (strcmp("/hotdoginfo", cmdtext, true, 10) == 0)
	{
	    SendClientMessage(playerid, COLOR_YELLOW, "Необходимо ехать с хот-доги в дом.");
	    SendClientMessage(playerid, COLOR_YELLOW, "И продать им эти хот-доги.");
	    SendClientMessage(playerid, COLOR_YELLOW, "Эсли вы введете  /hotdog появится точка куда вам придется везти хот-доги.");
	    SendClientMessage(playerid, COLOR_YELLOW, "Просто довезите хот-доги до маркера и они автоматически продадутся!");
	 	return 1;
	}
	return 0;
}
public OnPlayerEnterCheckpoint(playerid)
{
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 588)
   {
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint1))
     {
          SetPlayerCheckpoint(playerid, HotPoint2, 7.0);
          GameTextForPlayer(playerid, "~g~1 House done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint2))
     {
          SetPlayerCheckpoint(playerid, HotPoint3, 7.0);
          GameTextForPlayer(playerid, "~g~2 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint3))
     {
          SetPlayerCheckpoint(playerid, HotPoint4, 7.0);
          GameTextForPlayer(playerid, "~g~3 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint4))
     {
          SetPlayerCheckpoint(playerid, HotPoint5, 7.0);
          GameTextForPlayer(playerid, "~g~4 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint5))
     {
          SetPlayerCheckpoint(playerid, Refillpoint, 7.0);
          GameTextForPlayer(playerid, "~g~5 Houses done, refill your hotdogs at the marker!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,Refillpoint))
     {
          SetPlayerCheckpoint(playerid, HotPoint6, 7.0);
          GameTextForPlayer(playerid, "~g~Hotdogs refilled!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint6))
     {
          SetPlayerCheckpoint(playerid, HotPoint7, 7.0);
          GameTextForPlayer(playerid, "~g~6 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint7))
     {
          SetPlayerCheckpoint(playerid, HotPoint8, 7.0);
          GameTextForPlayer(playerid, "~g~7 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint8))
     {
          SetPlayerCheckpoint(playerid, HotPoint9, 7.0);
          GameTextForPlayer(playerid, "~g~8 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint9))
     {
          SetPlayerCheckpoint(playerid, HotPoint10, 7.0);
          GameTextForPlayer(playerid, "~g~9 Houses done!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint10))
     {
          SetPlayerCheckpoint(playerid, HotPoint11, 7.0);
          GameTextForPlayer(playerid, "~g~10 Houses done, get back to the startpoint!", 3000, 3);
  	 }
     if (IsPlayerInRangeOfPoint(playerid, 7.0,HotPoint11))
     {
	     GivePlayerMoney(playerid, 800);
	     GameTextForPlayer(playerid, "~g~You collected a total of $800,-!", 3000, 3);
     	 new veh;
     	 veh = GetPlayerVehicleID(playerid);
         SetVehicleToRespawn(veh);
         DisablePlayerCheckpoint(playerid);
         hotdog = 0;
     }
   }
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
     if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 588)
     {
         SendClientMessage(playerid, COLOR_RED, "Что бы отвезти хот-доги используй: /hotdog");
     }
     return 0;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if((hotdog) == 1)
	{
	    hotdog = 0;
	    SendClientMessage(playerid, COLOR_RED, "Вы вышли с транспорта,вернитесь что бы продолжить!");

	}else if((hotdog) == 0){

		//Nothing
 }
}
public OnPlayerDeath(playerid, killerid, reason)
{
          DisablePlayerCheckpoint(playerid);
          hotdog = 0;
          return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    if(pickupid == hotinfo)
	{
    GameTextForPlayer(playerid, "~g~Добро пожаловать на работу *Продавец Hot-Dogs*, используйте команду / hotdoginfo,что бы узнать больше.", 3000, 3);
	}
}