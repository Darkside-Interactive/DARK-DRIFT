
#include <a_samp>


#define FILTERSCRIPT
// <--- Настройка --->
#define DIALOG_AIRPORT_MENU 99 // id диалогового окна. Измените, если у вас уже занят этот id.
#define BOTS_CONNECT true // Настройка Ботов | Включить = True / Выключить = false |
#define RANDOM_MESSAGES_ALLOWED true // Рандомные сообщения | Включить = True / Выключить = false |
#define RANDOM_MESSAGE_TIME 300 // 5 минут ( В секундах = 300 т.е. 5 x 60 = 300 )
#define FLIGHT_RECENT_TIME  300 // 5 минут ( В секундах = 300 т.е. 5 x 60 = 300 )
#define FLIGHT_DURATION      60 // 1 минута ( В секундах = 60 т.е. 1 x 60 = 60 )
#define SKYDIVE_UNFREEZE       5  // 5 секунд
//---

//
#define COLOR_YELLOW_LABEL 0xFFFF00FF
#define COLOR_GREEN_LABEL 0x33AA33FF
#define COLOR_PINK_LABEL 0xFF0080FF
#define COLOR_RED_LABEL 0xFF0000AA
//
#define orange 0xFF9900AA//color
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_VIOLETBLUE 0x8A2BE2AA
#define COLOR_DEADCONNECT 0x808080AA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_FORESTGREEN 0x228B22AA
#define COLOR_DODGERBLUE 0x1E90FFAA
#define COLOR_DARKOLIVEGREEN 0x556B2FAA
#define COLOR_ORANGE 0xFFA500AA
#define COLOR_PURPLE 0x800080AA
#define COLOR_ROYALBLUE 0x4169FFAA
#define COLOR_ERROR 0xD2691EAA
#define COLOR_PINK 0xFF0080FF
#define COLOR_SEXYGREEN 0x00FF00FF
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIME 0x10F441AA
#define COLOR_ADMIN 0x10F441AA
#define COLOR_CYAN 0x40FFFFFF
#define COLOR_ORANGERED 0xFF4500AA





new AirPortPickUp_LS;
new AirPortPickUp_LV;
new AirPortPickUp_SF;
new BoughtTicket[MAX_PLAYERS];
new BOTveh1;
new BOTveh2;
new BOTveh3;
new BOTveh4;
new timer1;
new timer2;
new timer3;
new timer4;
//new Text:flight_textdraw;
//
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;
new Text:Textdraw5;
new Text:Textdraw6;
new Text:Textdraw7;
new Text:Textdraw8;
new Text:Textdraw9;
new Text:Textdraw10;
new Text:Textdraw11;
new Text:Textdraw12;
new Text:Textdraw13;
new Text:Textdraw14;
new Text:Textdraw15;
//new PlayerText:Textdraw4[MAX_PLAYERS];
//
new FLIGHT_TIMER_RECENT;




new randomMessages[][] =
    {
		"[BOT]Puffer:{FFFFFF} Самолет Puffer, летящий по рейсу SF12 просит разрешения на посадку в ВПП 1 аэропорта Сан Фиерро.",
		"[BOT]Skimmer:{FFFFFF} Самолет Skimmer, просит разрешение на взлет с ВПП 2 для соверешения рейса LV34.",
		"[BOT]Andromeda:{FFFFFF} Запрашиваю механика, проблемы с двигателем.",
		"{FF0080}[BOT]Nyan_cat:{FFFFFF} Посети сайт Samp-Mods.com.",
		"[BOT]Puffer:{FFFFFF} Сегодня очень хорошая погода для полета.",
		"[BOT]Skimmer:{FFFFFF} В двигатель попала птица... Аааааааа... Пшшшшшшш.",
		"[BOT]Andromeda:{FFFFFF} Командир корабля, пилот Иванов Петр Семенович приветствуют вас на борту самолета Beagle.",
		"{FF0080}[BOT]Nyan_cat:{FFFFFF} Пристегни ремни безопасности, и застегни свою ширинку.",
	    "[BOT]Puffer:{FFFFFF} Я вижу неопознанный летающий объект перед самолетом... Пшшшшшш...",
		"[BOT]Skimmer:{FFFFFF} Дорогие пассажиры, у самолета отказали оба двигателя. Прошу вас не пониковать и взять парашуты...",
		"[BOT]Andromeda:{FFFFFF} Банзай... Пшшшшшш....",
		"{FF0080}[BOT]Nyan_cat:{FFFFFF} Красавчик, вот мой телефончик. Позвони...",
	    "[BOT]Puffer:{FFFFFF} Все для SA-MP, ты найдешь на Samp-Mods.com.",
		"[BOT]Skimmer:{FFFFFF} Связь с самолетом прервана.",
		"[BOT]Andromeda:{FFFFFF} Связь с самолетом прервана.",
        "{FF0080}[BOT]Nyan_cat:{FFFFFF} Связь с вертолетом прервана.",
		"[BOT]Puffer:{FFFFFF} Связь с самолетом прервана.",
		"[BOT]Skimmer:{FFFFFF} Связь с самолетом прервана.",
		"[BOT]Andromeda:{FFFFFF} Связь с самолетом прервана.",
		"{FF0080}[BOT]Nyan_cat:{FFFFFF} Связь с вертолетом прервана."

    };




public OnFilterScriptInit()
{

print("\n________________________________");
print("|Loaded!|");
print("\n________________________________");
print("Airpot System v1.0");
print("By Anak.");
print("For info visit Sa-mp forums.");
print("________________________________\n");


AirPortPickUp_LS = CreatePickup(1559, 1, 1685.6980,-2335.4922,13.5469, 0);
AirPortPickUp_LV = CreatePickup(1559, 1, 1672.5366,1447.7250,10.7881, 0);
AirPortPickUp_SF = CreatePickup(1559, 1, -1421.1740,-286.9716,14.1484, 0);



/*
flight_textdraw = TextDrawCreate(320, 320, "Wait One minute.");

TextDrawUseBox(flight_textdraw , 1);
TextDrawLetterSize(flight_textdraw ,0.3,1);
TextDrawSetShadow(flight_textdraw ,1);
TextDrawSetOutline(flight_textdraw ,1);
TextDrawBackgroundColor(flight_textdraw ,0xFFFF00FF);
TextDrawBoxColor(flight_textdraw ,0xFFFF00FF);
TextDrawColor(flight_textdraw ,0xFF0000FF);

*/


Textdraw0 = TextDrawCreate(354.000000, 385.000000, "Please wait for ~r~one minute.~n~~y~we are on our way.~n~~w~In the case of emergency~n~please ~y~exit ~w~through ~r~exit doors.");
TextDrawAlignment(Textdraw0, 2);
TextDrawBackgroundColor(Textdraw0, 255);
TextDrawFont(Textdraw0, 1);
TextDrawLetterSize(Textdraw0, 0.539999, 1.299999);
TextDrawColor(Textdraw0, -1);
TextDrawSetOutline(Textdraw0, 0);
TextDrawSetProportional(Textdraw0, 1);
TextDrawSetShadow(Textdraw0, 1);
TextDrawUseBox(Textdraw0, 1);
TextDrawBoxColor(Textdraw0, 999999);
TextDrawTextSize(Textdraw0, -514.000000, 292.000000);
TextDrawSetSelectable(Textdraw0, 0);

Textdraw1 = TextDrawCreate(334.000000, 414.000000, "~w~you are flying with ~y~anak's airways.");
TextDrawAlignment(Textdraw1, 2);
TextDrawBackgroundColor(Textdraw1, 255);
TextDrawFont(Textdraw1, 3);
TextDrawLetterSize(Textdraw1, 0.500000, 1.000000);
TextDrawColor(Textdraw1, 255);
TextDrawSetOutline(Textdraw1, 0);
TextDrawSetProportional(Textdraw1, 1);
TextDrawSetShadow(Textdraw1, 1);
TextDrawSetSelectable(Textdraw1, 0);

Textdraw2 = TextDrawCreate(184.000000, 414.000000, "You are riding with ~p~[bot]Nyan_cat.");
TextDrawBackgroundColor(Textdraw2, 255);
TextDrawFont(Textdraw2, 3);
TextDrawLetterSize(Textdraw2, 0.500000, 1.000000);
TextDrawColor(Textdraw2, -1);
TextDrawSetOutline(Textdraw2, 0);
TextDrawSetProportional(Textdraw2, 1);
TextDrawSetShadow(Textdraw2, 1);
TextDrawSetSelectable(Textdraw2, 0);

Textdraw3 = TextDrawCreate(80.000000, 190.000000, "~y~Skydiving in progress. Wait for ~r~5 seconds~w~.");
TextDrawBackgroundColor(Textdraw3, 255);
TextDrawFont(Textdraw3, 3);
TextDrawLetterSize(Textdraw3, 0.699999, 2.099998);
TextDrawColor(Textdraw3, -1);
TextDrawSetOutline(Textdraw3, 0);
TextDrawSetProportional(Textdraw3, 1);
TextDrawSetShadow(Textdraw3, 1);
TextDrawSetSelectable(Textdraw3, 0);


Textdraw5 = TextDrawCreate(254.000000, 421.000000, "You have ~r~one~w~ airplane ~y~ticket.");
TextDrawBackgroundColor(Textdraw5, 255);
TextDrawFont(Textdraw5, 1);
TextDrawLetterSize(Textdraw5, 0.350000, 1.600000);
TextDrawColor(Textdraw5, -1);
TextDrawSetOutline(Textdraw5, 0);
TextDrawSetProportional(Textdraw5, 1);
TextDrawSetShadow(Textdraw5, 1);
TextDrawSetSelectable(Textdraw5, 0);
//
Textdraw6 = TextDrawCreate(308.000000, 115.000000, "~y~Anak's Airport System v1.0");
TextDrawAlignment(Textdraw6, 2);
TextDrawBackgroundColor(Textdraw6, 255);
TextDrawFont(Textdraw6, 1);
TextDrawLetterSize(Textdraw6, 0.600000, 2.200000);
TextDrawColor(Textdraw6, -1);
TextDrawSetOutline(Textdraw6, 0);
TextDrawSetProportional(Textdraw6, 1);
TextDrawSetShadow(Textdraw6, 1);
TextDrawUseBox(Textdraw6, 1);
TextDrawBoxColor(Textdraw6, 999999);
TextDrawTextSize(Textdraw6, 505.000000, 388.000000);
TextDrawSetSelectable(Textdraw6, 0);

Textdraw7 = TextDrawCreate(308.000000, 140.000000, "~p~Credits:");
TextDrawAlignment(Textdraw7, 2);
TextDrawBackgroundColor(Textdraw7, 255);
TextDrawFont(Textdraw7, 2);
TextDrawLetterSize(Textdraw7, 0.509998, 1.799999);
TextDrawColor(Textdraw7, -1);
TextDrawSetOutline(Textdraw7, 0);
TextDrawSetProportional(Textdraw7, 1);
TextDrawSetShadow(Textdraw7, 1);
TextDrawUseBox(Textdraw7, 1);
TextDrawBoxColor(Textdraw7, 999999);
TextDrawTextSize(Textdraw7, 8.000000, 388.000000);
TextDrawSetSelectable(Textdraw7, 0);

Textdraw8 = TextDrawCreate(308.000000, 161.000000, "~y~Anak ~w~- for writing this script.");
TextDrawAlignment(Textdraw8, 2);
TextDrawBackgroundColor(Textdraw8, 255);
TextDrawFont(Textdraw8, 3);
TextDrawLetterSize(Textdraw8, 0.500000, 1.000000);
TextDrawColor(Textdraw8, -1);
TextDrawSetOutline(Textdraw8, 0);
TextDrawSetProportional(Textdraw8, 1);
TextDrawSetShadow(Textdraw8, 1);
TextDrawUseBox(Textdraw8, 1);
TextDrawBoxColor(Textdraw8, 999999);
TextDrawTextSize(Textdraw8, 29.000000, 388.000000);
TextDrawSetSelectable(Textdraw8, 0);

Textdraw9 = TextDrawCreate(308.000000, 197.000000, "~y~forum.sa-mp.com ~w~- for everything.~n~~y~Sa-Mp Users ~w~- for help.~n~~y~Zamaroht ~w~- for textdraw editor.");
TextDrawAlignment(Textdraw9, 2);
TextDrawBackgroundColor(Textdraw9, 255);
TextDrawFont(Textdraw9, 3);
TextDrawLetterSize(Textdraw9, 0.500000, 1.000000);
TextDrawColor(Textdraw9, -1);
TextDrawSetOutline(Textdraw9, 0);
TextDrawSetProportional(Textdraw9, 1);
TextDrawSetShadow(Textdraw9, 1);
TextDrawUseBox(Textdraw9, 1);
TextDrawBoxColor(Textdraw9, 999999);
TextDrawTextSize(Textdraw9, 0.000000, 388.000000);
TextDrawSetSelectable(Textdraw3, 0);

Textdraw10 = TextDrawCreate(308.000000, 175.000000, "~p~Special Thanks to:");
TextDrawAlignment(Textdraw10, 2);
TextDrawBackgroundColor(Textdraw10, 255);
TextDrawFont(Textdraw10, 2);
TextDrawLetterSize(Textdraw10, 0.480000, 1.900001);
TextDrawColor(Textdraw10, -1);
TextDrawSetOutline(Textdraw10, 0);
TextDrawSetProportional(Textdraw10, 1);
TextDrawSetShadow(Textdraw10, 1);
TextDrawUseBox(Textdraw10, 1);
TextDrawBoxColor(Textdraw10, 999999);
TextDrawTextSize(Textdraw10, 79.000000, 388.000000);
TextDrawSetSelectable(Textdraw10, 0);

Textdraw11 = TextDrawCreate(308.000000, 228.119995, "~p~Crazybob ~w~- for his audio stream.~n~~y~Sa-Mp ~w~-for default NPC script.~n~(Npc script just used for study.)");
TextDrawAlignment(Textdraw11, 2);
TextDrawBackgroundColor(Textdraw11, 255);
TextDrawFont(Textdraw11, 3);
TextDrawLetterSize(Textdraw11, 0.500000, 1.000000);
TextDrawColor(Textdraw11, -1);
TextDrawSetOutline(Textdraw11, 0);
TextDrawSetProportional(Textdraw11, 1);
TextDrawSetShadow(Textdraw11, 1);
TextDrawUseBox(Textdraw11, 1);
TextDrawBoxColor(Textdraw11, 999999);
TextDrawTextSize(Textdraw11, 0.000000, 388.000000);
TextDrawSetSelectable(Textdraw11, 0);

Textdraw12 = TextDrawCreate(308.000000, 260.000000, "~g~(BOT)Skimmer, (BOT)Puffer~n~~g~(BOT)Andromeda, ~r~(BOT)Nyan_Cat~n~~w~for their services.");
TextDrawAlignment(Textdraw12, 2);
TextDrawBackgroundColor(Textdraw12, 255);
TextDrawFont(Textdraw12, 3);
TextDrawLetterSize(Textdraw12, 0.500000, 1.000000);
TextDrawColor(Textdraw12, -1);
TextDrawSetOutline(Textdraw12, 0);
TextDrawSetProportional(Textdraw12, 1);
TextDrawSetShadow(Textdraw12, 1);
TextDrawUseBox(Textdraw12, 1);
TextDrawBoxColor(Textdraw12, 999999);
TextDrawTextSize(Textdraw12, 0.000000, 388.000000);
TextDrawSetSelectable(Textdraw12, 0);

Textdraw13 = TextDrawCreate(308.000000, 291.119995, "~p~Contact:");
TextDrawAlignment(Textdraw13, 2);
TextDrawBackgroundColor(Textdraw13, 255);
TextDrawFont(Textdraw13, 2);
TextDrawLetterSize(Textdraw13, 0.490000, 2.100000);
TextDrawColor(Textdraw13, -1);
TextDrawSetOutline(Textdraw13, 0);
TextDrawSetProportional(Textdraw13, 1);
TextDrawSetShadow(Textdraw13, 1);
TextDrawUseBox(Textdraw13, 1);
TextDrawBoxColor(Textdraw13, 999999);
TextDrawTextSize(Textdraw13, 0.000000, 388.000000);
TextDrawSetSelectable(Textdraw13, 0);

Textdraw14 = TextDrawCreate(308.000000, 315.000000, "~y~forum.sa-mp.com - User name 'Anak'.~n~~p~Email:~n~~y~noumanarshad0320@gmail.com");
TextDrawAlignment(Textdraw14, 2);
TextDrawBackgroundColor(Textdraw14, 255);
TextDrawFont(Textdraw14, 3);
TextDrawLetterSize(Textdraw14, 0.500000, 1.000000);
TextDrawColor(Textdraw14, -1);
TextDrawSetOutline(Textdraw14, 0);
TextDrawSetProportional(Textdraw14, 1);
TextDrawSetShadow(Textdraw14, 1);
TextDrawUseBox(Textdraw14, 1);
TextDrawBoxColor(Textdraw14, 999999);
TextDrawTextSize(Textdraw14, 0.000000, 388.000000);
TextDrawSetSelectable(Textdraw14, 0);

Textdraw15 = TextDrawCreate(308.000000, 347.000000, "~n~~y~Box will close in~n~~p~ 10 seconds.");
TextDrawAlignment(Textdraw15, 2);
TextDrawBackgroundColor(Textdraw15, 255);
TextDrawFont(Textdraw15, 2);
TextDrawLetterSize(Textdraw15, 0.500000, 1.000000);
TextDrawColor(Textdraw15, -1);
TextDrawSetOutline(Textdraw15, 0);
TextDrawSetProportional(Textdraw15, 1);
TextDrawSetShadow(Textdraw15, 1);
TextDrawUseBox(Textdraw15, 1);
TextDrawBoxColor(Textdraw15, 999999);
TextDrawTextSize(Textdraw15, 14.000000, 388.000000);
TextDrawSetSelectable(Textdraw15, 0);


Create3DTextLabel("Аварийный выход.\nНажмите 'СКМ'", COLOR_RED_LABEL, 2.3169,23.0622,1199.5938, 10.0, 0, 0);

//
	#if RANDOM_MESSAGES_ALLOWED == true // random messages config.
    // random messege timer
    SetTimer("RandomMessages", RANDOM_MESSAGE_TIME*1000, true);// 3mins
    print("SETTINGS: RANDOM MESSAGES ALLOWED - true");

    //
    #endif
//



//
   #if BOTS_CONNECT == true // bot config - Do config on top.(#define BOTS_CONNECT true / False)
   ConnectNPC("[BOT]Skimmer","aplane_lv");
   ConnectNPC("[BOT]Andromeda","aplane_sf");
   ConnectNPC("[BOT]Puffer","aplane_ls");
   ConnectNPC("[BOT]Nyan_cat","Anak's_heli");
   print("SETTINGS: BOTS ALLOWED - true");
   BOTveh1 = CreateVehicle(511, 0.0, 0.0, 5.0, 0.0, 194, 194, 5000);
   BOTveh2 = CreateVehicle(511, 0.0, 0.0, 5.0, 0.0, 232, 232, 5000);
   BOTveh3 = CreateVehicle(511, 0.0, 0.0, 5.0, 0.0, 182, 182, 5000);
   BOTveh4 = CreateVehicle(487, 0.0, 0.0, 5.0, 0.0, 228, 228, 5000);
   #endif
//

   #if RANDOM_MESSAGES_ALLOWED == false
   print("SETTINGS: RANDOM_MESSAGES_ALLOWED - false");
   #endif

   #if BOTS_CONNECT == false
   print("SETTINGS: BOTS ALLOWED - false");
   #endif
return 1;
}


public OnPlayerConnect(playerid)
{
BoughtTicket[playerid] = 0;


return 1;
}




public OnPlayerSpawn(playerid)
{
  if(IsPlayerNPC(playerid)) //Checks if the player that just spawned is an NPC.
  {
    new npcname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, npcname, sizeof(npcname)); //Getting the NPC's name.
    if(!strcmp(npcname, "[BOT]Skimmer", true)) //Checking if the NPC's name is MyFirstNPC
    {
      print("|[BOT]Skimmer NPC - Был помещен в самолет.|");
      SetPlayerColor(playerid, COLOR_GREEN);
      SetPlayerSkin(playerid, 61);
      new Text3D:label1 = Create3DTextLabel("Anak's Airways", COLOR_YELLOW_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label1, playerid, 0.0, 0.0, 0.7);
      new Text3D:label4 = Create3DTextLabel("[BOT]Skimmer", COLOR_GREEN_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label4, playerid, 0.0, 0.0, 0.3);
      PutPlayerInVehicle(playerid, BOTveh1, 0); //Putting the NPC into the vehicle we created for it.
      return 1;
    }


    if(!strcmp(npcname, "[BOT]Andromeda", true)) //Checking if the NPC's name is MyFirstNPC
    {
      print("|[BOT]Andromeda NPC - Был помещен в самолет.|");
      SetPlayerColor(playerid, COLOR_GREEN);
      SetPlayerSkin(playerid, 61);
      new Text3D:label2 = Create3DTextLabel("Anak's Airways", COLOR_YELLOW_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label2, playerid, 0.0, 0.0, 0.7);
      new Text3D:label5 = Create3DTextLabel("[BOT]Andromeda", COLOR_GREEN_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label5, playerid, 0.0, 0.0, 0.3);
      PutPlayerInVehicle(playerid, BOTveh2, 0); //Putting the NPC into the vehicle we created for it.
      return 1;
    }


    if(!strcmp(npcname, "[BOT]Puffer", true)) //Checking if the NPC's name is MyFirstNPC
    {
      print("|[BOT]Puffer NPC - Был помещен в самолет.|");
      SetPlayerColor(playerid, COLOR_GREEN);
      SetPlayerSkin(playerid, 61);
      new Text3D:label3 = Create3DTextLabel("Anak's Airways", COLOR_YELLOW_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label3, playerid, 0.0, 0.0, 0.7);
      new Text3D:label6 = Create3DTextLabel("[BOT]Puffer", COLOR_GREEN_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label6, playerid, 0.0, 0.0, 0.3);
      PutPlayerInVehicle(playerid, BOTveh3, 0); //Putting the NPC into the vehicle we created for it.
      return 1;
    }
    
    if(!strcmp(npcname, "[BOT]Nyan_cat", true)) //Checking if the NPC's name is MyFirstNPC
    {
      print("|[BOT]Nyan_cat NPC - Был помещен в вертолет.|");
      SetPlayerColor(playerid, COLOR_PINK);
      SetPlayerSkin(playerid, 87);
      new Text3D:label3 = Create3DTextLabel("Anak's Airways", COLOR_YELLOW_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label3, playerid, 0.0, 0.0, 0.7);
      new Text3D:label6 = Create3DTextLabel("[BOT]Nyan_cat", COLOR_PINK_LABEL, 30.0, 40.0, 50.0, 40.0, 0);
      Attach3DTextLabelToPlayer(label6, playerid, 0.0, 0.0, 0.3);
      PutPlayerInVehicle(playerid, BOTveh4, 0); //Putting the NPC into the vehicle we created for it.
      return 1;
    }

    return 1;
  }
  //Other stuff for normal players goes here!
  return 1;
}


forward Unfreeze_skydive(playerid);
forward FLIGHT_TO_LV(playerid);
forward FLIGHT_TO_LS(playerid);
forward FLIGHT_TO_SF(playerid);
forward FLIGHT_TO_LS1(playerid);
forward RandomMessages();
forward FLIGHT_TIMER(playerid);
forward TEXTDRAW_TICKET_HIDE(playerid);
forward CREDITS_TIMER(playerid);





public OnPlayerCommandText(playerid, cmdtext[])
{
    if (!strcmp("/acredits", cmdtext, true, 10))
	{
	TextDrawShowForPlayer(playerid, Textdraw6);
	TextDrawShowForPlayer(playerid, Textdraw7);
	TextDrawShowForPlayer(playerid, Textdraw8);
	TextDrawShowForPlayer(playerid, Textdraw9);
	TextDrawShowForPlayer(playerid, Textdraw10);
	TextDrawShowForPlayer(playerid, Textdraw11);
	TextDrawShowForPlayer(playerid, Textdraw12);
	TextDrawShowForPlayer(playerid, Textdraw13);
	TextDrawShowForPlayer(playerid, Textdraw14);
	TextDrawShowForPlayer(playerid, Textdraw15);
	SetTimerEx("CREDITS_TIMER", 10*1000, false, "i", playerid);

    

    return 1;
	}

  	return 0;
}




public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_PASSENGER) // Player entered a vehicle as a driver
    {
    new vehicle;
    vehicle = GetPlayerVehicleID(playerid);
    if(vehicle == BOTveh1 || vehicle == BOTveh2 || vehicle == BOTveh3)
    {
                   if(BoughtTicket[playerid] == 0)
					{
					SendClientMessage(playerid, COLOR_RED,"Купите билет на самолет в терминале обслуживания.");
                    GameTextForPlayer(playerid,"~w~you Don't have ~r~Ticket.~n~~y~Buy from terminal.",4000,3);
					new Float:x, Float:y, Float:z;
                    GetPlayerPos(playerid, x, y, z);
                    SetPlayerPos(playerid, x+3, y+3, z+5);
					}
					else
					{
					SendClientMessage(playerid, COLOR_YELLOW,"[Anak's Airways]: Добро пожаловать на рейс. - Ваш билет принят.");
                    SendClientMessage(playerid, COLOR_WHITE,"Пожалуйста, выйдите из самолета, когда достигнете своей цели.");
                    GameTextForPlayer(playerid,"~y~welcome on flight sir.~n~~w~hope you will enjoy your stay.",4000,3);
                    TextDrawShowForPlayer(playerid, Textdraw1);
					BoughtTicket[playerid] = 0;
					}
    }
    
    
    if(vehicle == BOTveh4)
    {
		 if(GetPlayerMoney(playerid) < 10000)
		 {
		 SendClientMessage(playerid, COLOR_PINK, "[BOT]Nyan_cat: {FFFFFF}У вас нет $10000.");
		 new Float:x, Float:y, Float:z;
         GetPlayerPos(playerid, x, y, z);
         SetPlayerPos(playerid, x+5, y+5, z);
         }
         else
         {
         GivePlayerMoney(playerid, -10000);
         GameTextForPlayer(playerid,"~w~welcome to ~y~helicopter~w~.",4000,3);
         SendClientMessage(playerid, COLOR_PINK, "[BOT]Nyan_cat: {FFFFFF}Добро пожаловать в мой вертолет. Эта поездка обойдется вам в $10000. Мой маршрут: LS - LV - SF.");
		 SendClientMessage(playerid, COLOR_WHITE, "Я постараюсь доставить вас с комфортом.");
         TextDrawShowForPlayer(playerid, Textdraw2);
		 }
	}
    }
    return 1;
}



public OnPlayerExitVehicle(playerid, vehicleid)
{
    new vehicle;
    vehicle = GetPlayerVehicleID(playerid);
    if(vehicle == BOTveh1 || vehicle == BOTveh2 || vehicle == BOTveh3)
    {
    TextDrawHideForPlayer(playerid, Textdraw1);
    SendClientMessage(playerid, COLOR_YELLOW, "[Anak's Airways]: До свидания.");
    }
    
    if(vehicle == BOTveh4)
    {
    TextDrawHideForPlayer(playerid, Textdraw2);
    SendClientMessage(playerid, COLOR_PINK, "[BOT]Nyan_cat: {FFFFFF}Пока милашка.");
    }
    
    
    
    
    return 1;
}


public OnFilterScriptExit()
{

print("\n________________________________");
print("|Unloaded!|");
print("\n________________________________");
print("Airpot System v1.0");
print("By Anak.");
print("For info visit Sa-mp forums.");
print("________________________________\n");




return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
BoughtTicket[playerid] = 0;
(FLIGHT_TIMER_RECENT = 0);
KillTimer(timer1);
KillTimer(timer2);
KillTimer(timer3);
KillTimer(timer4);
StopAudioStreamForPlayer(playerid);
TogglePlayerControllable(playerid,1);
FLIGHT_TIMER_RECENT =0;
(FLIGHT_TIMER_RECENT = 0);
TextDrawHideForPlayer(playerid, Textdraw0);
TextDrawHideForPlayer(playerid, Textdraw1);
TextDrawHideForPlayer(playerid, Textdraw2);
TextDrawHideForPlayer(playerid, Textdraw3);
//TextDrawHideForPlayer(playerid, Textdraw4);
TextDrawHideForPlayer(playerid, Textdraw5);
TextDrawHideForPlayer(playerid, Textdraw6);
TextDrawHideForPlayer(playerid, Textdraw7);
TextDrawHideForPlayer(playerid, Textdraw8);
TextDrawHideForPlayer(playerid, Textdraw9);
TextDrawHideForPlayer(playerid, Textdraw10);
TextDrawHideForPlayer(playerid, Textdraw11);
TextDrawHideForPlayer(playerid, Textdraw12);
TextDrawHideForPlayer(playerid, Textdraw13);
TextDrawHideForPlayer(playerid, Textdraw14);
TextDrawHideForPlayer(playerid, Textdraw15);

return 1;
}





public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
  if (newkeys & KEY_LOOK_BEHIND )
  {
     if (IsPlayerInRangeOfPoint (playerid, 5.0, 2.3169,23.0622,1199.5938))
                   {
				   SendClientMessage(playerid, COLOR_YELLOW, "Вы выходите из самолета через аварийный выход.");
				   SendClientMessage(playerid, COLOR_WHITE, "Вы взяли парашют со своего места. Удачи.");
				   KillTimer(timer1);
				   KillTimer(timer2);
				   KillTimer(timer3);
				   KillTimer(timer4);
				   TextDrawHideForPlayer(playerid, Textdraw0);
				   StopAudioStreamForPlayer(playerid);
				   new emergency_exit = random(5);
                   switch(emergency_exit)
                        {
                            case 0:
                            {
                            SetPlayerInterior(playerid, 0);
							SendClientMessage(playerid, COLOR_YELLOW,"|Success|");
							SetPlayerPos(playerid, 375.9342,172.1572,228.3517);
						    GivePlayerWeapon(playerid, 46, 1);
                            }
                            
                            case 1:
                            {
                            SetPlayerInterior(playerid, 0);
                            SendClientMessage(playerid, COLOR_YELLOW,"|Success|");
							SetPlayerPos(playerid, -1072.0977,-994.3056,369.5175);
							GivePlayerWeapon(playerid, 46, 1);
                            }
                            
                            case 2:
                            {
                            SetPlayerInterior(playerid, 0);
                            SendClientMessage(playerid, COLOR_YELLOW,"|Success|");
  							SetPlayerPos(playerid, 400.1494,-2232.8203,369.5175);
  							GivePlayerWeapon(playerid, 46, 1);
                            }
                            
                            case 3:
                            {
                            SetPlayerInterior(playerid, 0);
  							SetPlayerPos(playerid, 2012.4542,-676.9313,307.1604);
  							GivePlayerWeapon(playerid, 46, 1);
  							SendClientMessage(playerid, COLOR_RED,"|Fail|");
  							SendClientMessage(playerid, COLOR_RED, "Sucked in engine.");
                            new Float:x, Float:y, Float:z;
                            GetPlayerPos(playerid, x, y, z);
                            CreateExplosion(x, y, z, 7, 10.0);
							SetPlayerHealth(playerid, -100);
                            }
                            
                            case 4:
                            {
                            SetPlayerInterior(playerid, 0);
                            SendClientMessage(playerid, COLOR_YELLOW,"|Success|");
  							SetPlayerPos(playerid, 2574.5957,1141.1149,307.1604);
  							GivePlayerWeapon(playerid, 46, 1);
  							
                            }
                        }
				   }
  }

}





public Unfreeze_skydive(playerid)
{
    TogglePlayerControllable(playerid,1);
    TextDrawHideForPlayer(playerid, Textdraw3);
    GameTextForPlayer(playerid,"~w~Now skydive!",4000,3);
	SendClientMessage(playerid , COLOR_YELLOW, "5 секунд прошли. Вы начали падать с парашютом.");
}



public FLIGHT_TO_LV(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Вы достигли LV. До свидания.");
	SetPlayerPos(playerid,1670.2096,1424.0031,10.7813);
	SetPlayerInterior(playerid, 0);
	StopAudioStreamForPlayer(playerid);
	GameTextForPlayer(playerid,"~w~reached ~y~LV.",4000,3);
	SetPlayerFacingAngle( playerid, 268.2207);
	TextDrawHideForPlayer(playerid, Textdraw0);


}



public FLIGHT_TO_LS(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Вы достигли LS. До свидания.");
	SetPlayerPos(playerid,1685.6311,-2325.9778,13.5469);
	SetPlayerInterior(playerid, 0);
	StopAudioStreamForPlayer(playerid);
	GameTextForPlayer(playerid,"~w~reached ~y~LS.",4000,3);
	SetPlayerFacingAngle( playerid, 354.3647);
	TextDrawHideForPlayer(playerid, Textdraw0);

}



public FLIGHT_TO_SF(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Вы достигли SF. До свидания.");
	SetPlayerPos(playerid,-1426.1222,-292.4845,14.1484);
	SetPlayerInterior(playerid, 0);
	StopAudioStreamForPlayer(playerid);
	GameTextForPlayer(playerid,"~w~reached ~y~SF.",4000,3);
	SetPlayerFacingAngle( playerid, 136.4093);
	TextDrawHideForPlayer(playerid, Textdraw0);

}



public FLIGHT_TO_LS1(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Вы достигли LS. До свидания.");
	SetPlayerPos(playerid, 1685.6311,-2325.9778,13.5469);
	SetPlayerInterior(playerid, 0);
	StopAudioStreamForPlayer(playerid);
	GameTextForPlayer(playerid,"~w~reached ~y~LS.",4000,3);
	SetPlayerFacingAngle( playerid, 354.3647);
	TextDrawHideForPlayer(playerid, Textdraw0);

}




public RandomMessages()
{
    print("random message - Timer - Called.");
    new randomMsg = random(sizeof(randomMessages));
    SendClientMessageToAll(COLOR_GREEN, randomMessages[randomMsg]);
}



public FLIGHT_TIMER(playerid)
{
       if(FLIGHT_TIMER_RECENT == 1)
	  {
        print(" [ANAK's AIRPORT SYSTEM]: Flight_timer_Called.");
        FLIGHT_TIMER_RECENT =0;

    }
  }

public TEXTDRAW_TICKET_HIDE(playerid)
{
TextDrawHideForPlayer(playerid, Textdraw5);
}




public CREDITS_TIMER(playerid)
{

TextDrawHideForPlayer(playerid, Textdraw6);
TextDrawHideForPlayer(playerid, Textdraw7);
TextDrawHideForPlayer(playerid, Textdraw8);
TextDrawHideForPlayer(playerid, Textdraw9);
TextDrawHideForPlayer(playerid, Textdraw10);
TextDrawHideForPlayer(playerid, Textdraw11);
TextDrawHideForPlayer(playerid, Textdraw12);
TextDrawHideForPlayer(playerid, Textdraw13);
TextDrawHideForPlayer(playerid, Textdraw14);
TextDrawHideForPlayer(playerid, Textdraw15);

return 1;
}




public OnPlayerPickUpPickup(playerid, pickupid)
{
    {
    if(pickupid == AirPortPickUp_LS)
    ShowPlayerDialog(playerid, DIALOG_AIRPORT_MENU, DIALOG_STYLE_LIST, "{FFFF01}Терминал обслуживания", "{FFFF00}Билет на самолет - $1687\n{FFFF00}Парашют - $3379\n{FFFF00}Прямой перелет в LV - $6000\n{FFFF00}Прямой перелет в SF - $6000\n{FFFF00}Прыжок с парашютом в LS - $4000\n{FFFF00}Прыжок с парашютом в LV - $4000\n{FFFF00}Прыжок с парашютом в SF - $4000\n{FFFF00}Прыжок с парашютом в Mount Chiliad - $8500", "Выбрать", "Отменить");
    }
    {
    if(pickupid == AirPortPickUp_LV)
    ShowPlayerDialog(playerid, DIALOG_AIRPORT_MENU, DIALOG_STYLE_LIST, "{FFFF01}Терминал обслуживания", "{FFFF00}Билет на самолет - $1687\n{FFFF00}Парашют - $3379\n{FFFF00}Прямой перелет в LS - $6000\n{FFFF00}Прямой перелет в SF - $6000\n{FFFF00}Прыжок с парашютом в LS - $4000\n{FFFF00}Прыжок с парашютом в LV - $4000\n{FFFF00}Прыжок с парашютом в SF - $4000\n{FFFF00}Прыжок с парашютом в Mount Chiliad - $8500", "Выбрать", "Отменить");
    }
    {
    if(pickupid == AirPortPickUp_SF)
    ShowPlayerDialog(playerid, DIALOG_AIRPORT_MENU, DIALOG_STYLE_LIST, "{FFFF01}Терминал обслуживания", "{FFFF00}Билет на самолет - $1687\n{FFFF00}Парашют - $3379\n{FFFF00}Прямой перелет в LV - $6000\n{FFFF00}Прямой перелет в LS - $6000\n{FFFF00}Прыжок с парашютом в LS - $4000\n{FFFF00}Прыжок с парашютом в LV - $4000\n{FFFF00}Прыжок с парашютом в SF - $4000\n{FFFF00}Прыжок с парашютом в Mount Chiliad - $8500", "Выбрать", "Отменить");
    }

}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_AIRPORT_MENU)
    {
        if(response)
        {

             if(listitem == 0)
             {
                 if(BoughtTicket[playerid] == 1)
                    {
				    SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас уже есть билет на самолет.");
					}
					else
					{

                                if(GetPlayerMoney(playerid) < 1687)
			                     {
				                 SendClientMessage(playerid, COLOR_ERROR,"[ОШИБКА]: У вас нет нужной суммы денег для покупки билета на самолет.");
			                     }
		                         else
			                     {
		                         SendClientMessage(playerid, COLOR_CYAN,"Вы купили билет на самолет. Пожалуйста, пройдите к взлетно - посадочной полосе.");
                                 GameTextForPlayer(playerid,"~w~you have bought ~r~ticket.",4000,3);
                                 GivePlayerMoney(playerid, -1687);
			                     BoughtTicket[playerid] = 1;
			                     TextDrawShowForPlayer(playerid, Textdraw5);
			                     SetTimerEx("TEXTDRAW_TICKET_HIDE", 15*1000, false, "i", playerid);

                                 }


					}

			 }




             if(listitem == 1)
              {


                   if(GetPlayerWeapon(playerid) == 46)
				   {
				   SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас уже есть парашют.");
				   }
				   else
				   {
	                       if(GetPlayerMoney(playerid) < 3379)
				           {
				           SendClientMessage(playerid, COLOR_ERROR,"[ОШИБКА]: У вас нет нужной суммы денег для покупки парашюта.");
			               }
		                   else
			               {
			               SendClientMessage(playerid, COLOR_CYAN,"Вы купили парашют.");
                           GameTextForPlayer(playerid,"~w~you have bought an ~r~parachute.",4000,3);
						   GivePlayerMoney(playerid, -3379);
		                   GivePlayerWeapon(playerid, 46, 1);
			               }
				   }

              }



             if(listitem == 2)
              {
               if(GetPlayerMoney(playerid) < 6000)
               {
               SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас нет нужной суммы денег для покупки билета на прямой рейс.");
			   }
			   else
			   {
	             if(FLIGHT_TIMER_RECENT == 1)
                  {
	              SendClientMessage(playerid, COLOR_RED, "Извините, но на данный момент нет свободных мест в самолете.");
				  }
				  else
				  {
				   new Float:x, Float:y, Float:z;
                   GetPlayerPos(playerid, x, y, z);
                   if (IsPlayerInRangeOfPoint (playerid, 10.0, 1685.6980,-2335.4922,13.5469) || IsPlayerInRangeOfPoint (playerid, 10.0, -1421.1740,-286.9716,14.1484) )
                   {
                   GivePlayerMoney(playerid, -6000);
                   PlayAudioStreamForPlayer(playerid, "http://loadb.cnr-radio.com:8000/stream", 1.7891,26.8486,1199.5938, 10, 1);
                   GameTextForPlayer(playerid,"~y~Welcome on plane.",4000,3);
				   SendClientMessage(playerid, COLOR_WHITE, "Добро пожаловать в самолет.");
				   SendClientMessage(playerid, COLOR_YELLOW, "Мы находимся на пути к LV. Мы приземлимся через одну минуту.");
				   SendClientMessage(playerid, COLOR_GREY, "Вы заплатили $6000 за этот рейс.");
				   //SetTimer("FLIGHT_TO_LV", 1*60*1000, false); // 1 min
				   SetTimerEx("FLIGHT_TIMER", FLIGHT_RECENT_TIME*1000, false, "i", playerid);
				   timer1 = SetTimerEx("FLIGHT_TO_LV", FLIGHT_DURATION*1000, false, "i", playerid);
				   SetPlayerPos(playerid, 2.384830, 33.103397, 1199.849976);
				   SetPlayerInterior(playerid, 1);
                   (FLIGHT_TIMER_RECENT = 1);
                   TextDrawShowForPlayer(playerid, Textdraw0);

				   }



                   if (IsPlayerInRangeOfPoint (playerid, 10.0, 1672.5366,1447.7250,10.7881))
                   {
                   GivePlayerMoney(playerid, -6000);
                   PlayAudioStreamForPlayer(playerid, "http://loadb.cnr-radio.com:8000/stream", 1.7891,26.8486,1199.5938, 10, 1);
                   GameTextForPlayer(playerid,"~y~Welcome on plane.",4000,3);
				   SendClientMessage(playerid, COLOR_WHITE, "Добро пожаловать в самолет.");
				   SendClientMessage(playerid, COLOR_YELLOW, "Мы находимся на пути к LS. Мы приземлимся через одну минуту.");
				   SendClientMessage(playerid, COLOR_GREY, "Вы заплатили $6000 за этот рейс.");
				   //SetTimer("FLIGHT_TO_LS", 1*60*1000, false); // 1 min
                   SetTimerEx("FLIGHT_TIMER", FLIGHT_RECENT_TIME*1000, false, "i", playerid);
                   timer2 = SetTimerEx("FLIGHT_TO_LS",FLIGHT_DURATION*1000, false, "i", playerid);
				   SetPlayerPos(playerid, 2.384830, 33.103397, 1199.849976);
				   SetPlayerInterior(playerid, 1);
				   (FLIGHT_TIMER_RECENT = 1);
				   //TextDrawShowForPlayer(playerid, flight_textdraw);
				   TextDrawShowForPlayer(playerid, Textdraw0);
				   }
			      }

      }


              }



			 if(listitem == 3)
			  {

               if(GetPlayerMoney(playerid) < 6000)
               {
               SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас нет нужной суммы для покупки билета на прямой рейс.");
			   }
			   else
			   {
                 if(FLIGHT_TIMER_RECENT == 1)
                  {
	              SendClientMessage(playerid, COLOR_RED, "Извините, но на данный момент нет свободных мест в самолете.");
				  }
				  else
				  {
				   new Float:x, Float:y, Float:z;
                   GetPlayerPos(playerid, x, y, z);
                   if (IsPlayerInRangeOfPoint (playerid, 10.0, 1685.6980,-2335.4922,13.5469) || IsPlayerInRangeOfPoint (playerid, 10.0, 1672.5366,1447.7250,10.7881) )
                   {
                   GivePlayerMoney(playerid, -6000);
                   PlayAudioStreamForPlayer(playerid, "http://loadb.cnr-radio.com:8000/stream", 1.7891,26.8486,1199.5938, 10, 1);
                   GameTextForPlayer(playerid,"~y~Welcome on plane.",4000,3);
				   SendClientMessage(playerid, COLOR_WHITE, "Добро пожаловать в самолет.");
				   SendClientMessage(playerid, COLOR_YELLOW, "Мы находимся на пути к SF. Мы приземлимся через одну минуту.");
				   SendClientMessage(playerid, COLOR_GREY, "Вы заплатили $6000 за этот рейс.");
				   //SetTimer("FLIGHT_TO_LV", 1*60*1000, false); // 1 min
				   SetTimerEx("FLIGHT_TIMER", FLIGHT_RECENT_TIME*1000, false, "i", playerid);
                   timer3 = SetTimerEx("FLIGHT_TO_SF", FLIGHT_DURATION*1000, false, "i", playerid);
				   SetPlayerPos(playerid, 2.384830, 33.103397, 1199.849976);
				   SetPlayerInterior(playerid, 1);
				   (FLIGHT_TIMER_RECENT = 1);
				   //TextDrawShowForPlayer(playerid, flight_textdraw);
				   TextDrawShowForPlayer(playerid, Textdraw0);
                   

                   }

                   if (IsPlayerInRangeOfPoint (playerid, 10.0, -1421.1740,-286.9716,14.1484))
                   {
                   PlayAudioStreamForPlayer(playerid, "http://loadb.cnr-radio.com:8000/stream", 1.7891,26.8486,1199.5938, 10, 1);
                   GameTextForPlayer(playerid,"~y~Welcome on plane.",4000,3);
                   GivePlayerMoney(playerid, -6000);
				   SendClientMessage(playerid, COLOR_WHITE, "Добро пожаловать в самолет.");
				   SendClientMessage(playerid, COLOR_YELLOW, "Мы находимся на пути к LS. Мы приземлимся через одну минуту.");
				   SendClientMessage(playerid, COLOR_GREY, "Вы заплатили $6000 за этот рейс.");
				   //SetTimer("FLIGHT_TO_LV", 1*60*1000, false); // 1 min
				   SetTimerEx("FLIGHT_TIMER", FLIGHT_RECENT_TIME*1000, false, "i", playerid);
				   timer4 = SetTimerEx("FLIGHT_TO_LS1", FLIGHT_DURATION*1000, false, "i", playerid);
				   SetPlayerPos(playerid, 2.384830, 33.103397, 1199.849976);
				   SetPlayerInterior(playerid, 1);
				   (FLIGHT_TIMER_RECENT = 1);
				   //TextDrawShowForPlayer(playerid, flight_textdraw);
				   TextDrawShowForPlayer(playerid, Textdraw0);

				   }
				  }

               }

			  }


			 if(listitem == 4)
			  {
                 if(GetPlayerMoney(playerid) < 4000)
                 {
                 SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас не хватает денег на прыжок с парашютом.");
                 }
                 else
                 {

                   GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~y~Welcome to LS.",4000,3);
			       SendClientMessage(playerid, COLOR_CYAN, "Вам выдали парашют, наслаждайтесь падением над городом LS!");
                   SetPlayerPos(playerid,1965.5830,-1521.9362,567.4092);
                   GivePlayerWeapon(playerid, 46, 1);
                   //SetTimer("Unfreeze_skydive", 5*1000, false); // 5 seconds
                   TogglePlayerControllable(playerid,0);
                   TextDrawShowForPlayer(playerid, Textdraw3);
                   SetTimerEx("Unfreeze_skydive", SKYDIVE_UNFREEZE*1000, false, "i", playerid);
                   SendClientMessage(playerid, COLOR_WHITE,"Пожалуйста, подождите 5 секунд.");
			     }
			  }


			 if(listitem == 5)
			  {
                if(GetPlayerMoney(playerid) < 4000)
                 {
                 SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас не хватает денег на прыжок с парашютом.");
                 }
                 else
                 {
                    GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~y~Welcome to LV.",4000,3);
			        SendClientMessage(playerid, COLOR_CYAN, "Вам выдали парашют, наслаждайтесь падением над городом LV!");
                    SetPlayerPos(playerid,1973.3391,1355.0848,567.4092);
                    GivePlayerWeapon(playerid, 46, 1);
                    //SetTimer("Unfreeze_skydive", 5*1000, false); // 5 seconds
                    TogglePlayerControllable(playerid,0);
                    TextDrawShowForPlayer(playerid, Textdraw3);
                    SetTimerEx("Unfreeze_skydive", SKYDIVE_UNFREEZE*1000, false, "i", playerid);
                    SendClientMessage(playerid, COLOR_WHITE,"Пожалуйста, подождите 5 секунд.");
				 }
			  }


			 if(listitem == 6)
			  {
                if(GetPlayerMoney(playerid) < 4000)
                 {
                 SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас не хватает денег на прыжок с парашютом.");
                 }
                 else
                 {
                      GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~y~Welcome to SF.",4000,3);
			          SendClientMessage(playerid, COLOR_CYAN, "Вам выдали парашют, наслаждайтесь падением над городом SF!");
                      SetPlayerPos(playerid,-1882.8408,856.5587,630.9056);
                      TogglePlayerControllable(playerid,0);
                      GivePlayerWeapon(playerid, 46, 1);
                      TextDrawShowForPlayer(playerid, Textdraw3);
                      SetTimerEx("Unfreeze_skydive", SKYDIVE_UNFREEZE*1000, false, "i", playerid);
                      SendClientMessage(playerid, COLOR_WHITE,"Пожалуйста, подождите 5 секунд.");
                      //SetTimer("Unfreeze_skydive", 5*1000, false); // 5 seconds
				 }
			  }


			 if(listitem == 7)
			  {
                if(GetPlayerMoney(playerid) < 8500)
                 {
                 SendClientMessage(playerid, COLOR_ERROR, "[ОШИБКА]: У вас не хватает денег на прыжок с парашютом.");
                 }
                 else
				 {
                      GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~y~Welcome to Mount chiliad.",4000,3);
			          SendClientMessage(playerid, COLOR_CYAN, "Вам выдали парашют, наслаждайтесь падением над горой Тысячелетие!");
                      SetPlayerPos(playerid,-2317.5400,-1619.5935,1253.7904);
                      TogglePlayerControllable(playerid,0);
                      TextDrawShowForPlayer(playerid, Textdraw3);
                      SetTimerEx("Unfreeze_skydive", SKYDIVE_UNFREEZE*1000, false, "i", playerid);
                      //SetTimer("Unfreeze_skydive", 5*1000, false); // 5 seconds
					  SendClientMessage(playerid, COLOR_WHITE,"Пожалуйста, подождите 5 секунд.");
					  GivePlayerWeapon(playerid, 46, 1);
				 }
			  }


		}
	 }
}
