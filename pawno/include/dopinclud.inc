#include <a_samp>

//##############################################################################
//                          Messages added in v1.3
//##############################################################################
//------------------------------------------------------------------------------
//                              Important.
//------------------------------------------------------------------------------
#define LABELTEXT1 "{FFA700}Имя дома: %s\n{FFDC00}Хозяин дома: Дом на продаже\n{FFFB00}Стоимость дома: $%d\n{C4FF00}ID Дома: %d"
#define LABELTEXT2 "{FFA700}Имя дома: %s\n{FFDC00}Хозяин дома: %s\n{FFFB00}Стоимость дома: $%d\n{C4FF00}ID Дома: %d"
#define FILEPATH "/GarHouse/Houses/%d.ini"
#define INFORMATION_HEADER "Система домов - Информация"
#define I_HOWNER_HINFO_1 "Имя дома: %s\nРасположение дома: %s\nДистанция между домом и Вами: %0.2f шагов\n"
#define I_HOWNER_HINFO_2 "Стоимость дома: $%d\nКамера хранения: $%d\nID дома: %d"
//------------------------------------------------------------------------------
// 				Information and error messages
//------------------------------------------------------------------------------
#define E_NO_HOUSES_OWNED "Ты не владеешь домом."
#define I_HMENU "Используй /housemenu Чтобы посмотреть меню дома."
#define E_H_ALREADY_OWNED "Этот дом уже принадлежат другому человеку."
#define E_INVALID_HPASS_LENGTH "Не верная длина пароля."
#define E_INVALID_HPASS "Не правельный пароль от дома. Ты не можешь использовать этот пароль."
#define E_INVALID_HPASS_CHARS "Твой пароль от дома содержит не допустимые символы(Процент или ~)."
#define E_INVALID_HNAME_LENGTH "Не правельная длина названия дома."
#define E_INVALID_HNAME_CHARS "Твое название дома содержит не допустимые символы(Процент или ~)."
#define I_HPASS_NO_CHANGE "Пароль от вашего дома остается прежним."
#define I_HPASS_REMOVED "Пароль от дома был удален."
#define E_NOT_ENOUGH_PMONEY "Тебе не хватает денег!"
#define E_INVALID_AMOUNT "Неверная сумма."
#define E_HSTORAGE_L_REACHED "Вы не можете вложить столько денег в дом. Ты можешь положить до $25,000,000."
#define E_NOT_ENOUGH_HSMONEY "В камере хранения нету столько денег!"
#define E_NO_WEAPONS "У тебя нету оружия."
#define E_NO_HS_WEAPONS "У тебя нету оружия в камере хранения."
#define E_INVALID_HPASS_CHARS2 "Пароль от дома содержит не допустимые символы (Знак процента или ~)."
#define E_C_ACCESS_SE_HM "Вы не можете пользоватся меню в не своем доме."
#define E_NOT_IN_HOUSE "Ты должен быть в доме чтоб использовать эту команду."
#define E_NOT_HOWNER "Тебе нужно быть владельцем дома чтобы использовать эту команду."
#define E_HCAR_NOT_IN_VEH "Ты должен быть в машине чтобы добавить машину к дому."
#define E_INVALID_HID "Не правельный ID дома. Этот дом не существует."
#define E_NO_HCAR "Этот дом не имеет машину. Невозможно удалить."
#define E_H_A_F_SALE "Этот дом и так на продаже. Вы не можете продать его"
#define HMENU_ENTER_PASS "Имя дома: %s\nВладелец дома: %s\nСтоимость дома: $%d\nID Дома: %d\n\nВведите пароль от дома ниже, если вы хотите войти:"
#define HMENU_BUY_HOUSE "%s, Вы точно хотите купить этот дом за $%d?"
#define HMENU_BUY_HINTERIOR "Вы точно хотите купить этот вид дома (%s) за $%d?"
#define HMENU_SELL_HOUSE "%s, Вы уверены что хотите продать свой дом %s за $%d?"
#define I_SELL_HOUSE1 "Ты успешно продал свой дом за $%d.\nПродажный взнос: $%d.\n$%d Из твоей камеры хранения было передано тебе."
#define I_SELL_HOUSE2 "YТы успешно продал свой дом \"%s\" за $%d.\nПродажный взнос: $%d."
#define I_BUY_HOUSE "Ты успешно купил этот дом за $%d!"
#define I_HPASSWORD_CHANGED "Ты успешно установил дому пароль \"%s\"!"
#define I_HNAME_CHANGED "Ты успешно установил дому имя \"%s\"!"
#define E_ALREADY_HAVE_HINTERIOR "У тебя уже установлен этот вид дома."
#define I_VISITING_HOUSEINT "Ты щас находишся в виде дома %s.\nВид стоит $%d.\nВремя твоего нахождения в доме %d Минут."
#define E_CANT_AFFORD_HINT "Ты не можешь купить вид дома %s.\nСтоимость вида: $%d.\nУ тебя есть: $%d.\nТебе надо: $%d."
#define I_HINT_BOUGHT "Ты купил вид дома %s за $%d."
#define I_HINT_DEPOSIT1 "У Вас $%d в Вашей камере хранения.\n\nНаберите, сколько денег хотите положить в хранение:"
#define I_HINT_WITHDRAW1 "У Вас $%d в Вашей камере хранения.\n\nНаберите, сколько хотите взять из камеры:"
#define I_HINT_DEPOSIT2 "Ты успешно положил $%d В камеру хранения своего дома.\nБаланс камеры хранения: $%d"
#define I_HINT_WITHDRAW2 "Ты успешно снял $%d Из своей камеры хранения.\nБаланс камеры хранения: $%d"
#define I_HINT_CHECKBALANCE "У Вас $%d В Вашей камере хранения."
#define E_HINT_WAIT_BEFORE_VISITING "Пожалуйста, подождите после визита в вид дома."
#define I_HS_WEAPONS1 "Вы успешно положили %d Оружий в Вашу камеру хранения."
#define I_HS_WEAPONS2 "Вы успешно взяли %d Оружий из своей камеры хранения."
#define I_WRONG_HPASS1 "Вы не вошли в дом %s'а, Используя пароль \"%s\"."
#define I_WRONG_HPASS2 "Информация дома: %s (%d) Попытался войти в Ваш дом с использованием пароля \"%s\"!"
#define I_CORRECT_HPASS1 "Вы успешно вошли в дом %s'а С использованием пароля \"%s\"!"
#define I_CORRECT_HPASS2 "Информация дома: %s (%d) Успешно вошел в Ваш дом с использованием пароля \"%s\"!"
#define E_TOO_MANY_HOUSES "Простите, но на сервере создано %d домов.\nУдалите дома, чтобы избежать лимита."
#define E_INVALID_HVALUE "Неверная стоимость дома. Стоимость дома должна быть между $1,500,000 и $25,000,000."
#define I_H_CREATED "Дом ID %d Сделан..."
#define I_HCAR_EXIST_ALREADY "Дом ID %d Уже имеет машину. Можно иметь всего одну."
#define I_HCAR_CREATED "Машина для дома ID %d создана..."
#define I_H_DESTROYED "Дом ID %d Удален..."
#define I_HCAR_REMOVED "Машина для дома ID %d удалена..."
#define I_ALLH_DESTROYED "Все дома удалены. (%d Всего было)"
#define I_ALLHCAR_REMOVED "Все машины с домов удалены. (%d Всего было)"
#define I_HSPAWN_CHANGED "Вы поменяли позицию и angle дома ID %d."
#define I_TELEPORT_MSG "Ты телепортнулся к дому ID %d."
#define I_H_SOLD "Вы продали дом ID %d..."
#define I_ALLH_SOLD "Все дома на сервере были удалены. (%d Всего было)"
#define I_H_PRICE_CHANGED "Стоимость дома ID %d Была изменена на $%d."
#define I_ALLH_PRICE_CHANGED "Ты поменял всем домам стоимость на $%d. (%d Всего было)"
#define I_HINT_VISIT_OVER "Прибывание в доме истекло.\nВы хотите купить вид дома %s за $%d?"
#define E_INVALID_HCAR_MODEL "Неверная модель машины. Принимаются ид машин 400-612."
#define I_HCAR_CHANGED "Модель машины для дома ID %d поменялась на %d."
//------------------------------------------------------------------------------
#define E_CMD_USAGE_CREATEHOUSE "Используй: /createhouse (Стоимость дома) (Вид дома)"
#define E_CMD_USAGE_ADDHCAR "Используй: /addhcar (ИД дома)"
#define E_CMD_USAGE_REMOVEHOUSE "Используй: /removehouse (houseid)"
#define E_CMD_USAGE_REMOVEHCAR "Используй: /removehcar (house id)"
#define E_CMD_USAGE_CHANGEHCAR "Используй: /changehcar (house id) (modelid: 400-612)"
#define E_CMD_USAGE_CHANGESPAWN "Используй: /changespawn (houseid)"
#define E_CMD_USAGE_GOTOHOUSE "Используй: /gotohouse (houseid)"
#define E_CMD_USAGE_SELLHOUSE "Используй: /sellhouse (houseid)"
#define E_CMD_USAGE_CHANGEPRICE "Используй: /changeprice (houseid) (цена)"
#define E_CMD_USAGE_CHANGEALLPRICE "Используй: /changeallprices (цена)"
//------------------------------------------------------------------------------
//                          Debug messages
//------------------------------------------------------------------------------
#if defined GH_DEBUGGING
#define DEBUG_OP_DISCONNECT "[GarHouse Debug] (OnPlayerDisconnect) - %s (%d) Quit In Their House."
#define DEBUG_OP_ED_CP1 "[GarHouse Debug] (OnPlayerEnterDynamicCP) - %s (%d) Entered Their House [House ID: %d]."
#define DEBUG_OP_ED_CP2 "[GarHouse Debug] (OnPlayerEnterDynamicCP) - %s (%d) Exited House ID %d."
#define DEBUG_OP_PUD_PICKUP1 "[GarHouse Debug] (OnPlayerPickUpDynamicPickup) - %s (%d) Entered Their House [House ID: %d]."
#define DEBUG_OP_PUD_PICKUP2 "[GarHouse Debug] (OnPlayerPickUpDynamicPickup) - %s (%d) Exited House ID %d."
#define DEBUG_ODR1 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Bought House ID %d For $%d."
#define DEBUG_ODR2 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Has Changed The House Name For House ID %d To %s."
#define DEBUG_ODR3 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Bought The House Interior %s For $%d. [House ID: %d]."
#define DEBUG_ODR4 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Is Visiting House Interior %s [House ID: %d]."
#define DEBUG_ODR5 "[GarHouse Debug] (OnDialogResponse) - House Interior For House ID %d Set To %d."
#define DEBUG_ODR6 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Checked The House Storage Balance For House ID %d. [Balance: $%d]"
#define DEBUG_ODR7 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Deposited $%d Into The House Storage For House ID %d."
#define DEBUG_ODR8 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Withdrew $%d From The House Storage For House ID %d."
#define DEBUG_ODR9 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Stored %d Weapon%s In The House Storage For House ID %d."
#define DEBUG_ODR10 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Stored %d Weapon%s In The House Storage For House ID %d."
#define DEBUG_ODR11 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Recieved %d Weapon%s From The House Storage For House ID %d."
#define DEBUG_ODR12 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Successfully Entered House ID %d Using The House Password."
#define DEBUG_ODR13 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Sold Their House For $%d (House Storage: $%d). [House ID: %d]"
#define DEBUG_ODR14 "[GarHouse Debug] (OnDialogResponse) - %s (%d) Has Changed The House Password For House ID %d."
#define DEBUG_OP_CMD1 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Created A House. [House ID: %d | House Value: $%d | Total Houses: %d]"
#define DEBUG_OP_CMD2 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Created A House Car For House ID %d."
#define DEBUG_OP_CMD3 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Deleted House ID %d."
#define DEBUG_OP_CMD4 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Removed The House Car For House ID %d."
#define DEBUG_OP_CMD5 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Deleted All Houses On The Server. [%d In Total]"
#define DEBUG_OP_CMD6 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Deleted All House Cars On The Server. [%d In Total]"
#define DEBUG_OP_CMD7 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Changed The Spawnposition And Angle For House ID %d."
#define DEBUG_OP_CMD8 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Sold House ID %d."
#define DEBUG_OP_CMD9 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Sold All Houses On The Server. [%d In Total]"
#define DEBUG_OP_CMD10 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Changed The Value Of House ID %d To $%d."
#define DEBUG_OP_CMD11 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Changed The Value Of All Houses On The Server To $%d. [%d In Total]"
#define DEBUG_OP_CMD12 "[GarHouse Debug] (OnPlayerCommandText) - %s (%d) Changed The Housecar Model ID For House %d To %d."
#define DEBUG_OP_SPAWN "[GarHouse Debug] (OnPlayerSpawn) - %s (%d) Spawned In Their House."
#endif

//==============================================================================
//                              Macros
//==============================================================================
//##############################################################################
#undef MAX_PLAYERS
#define MAX_PLAYERS 500 // Change it to the amount of server slots!!
//##############################################################################
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
new CMDSString[1000];
#define ShowInfoBox(%0,%1,%2,%3) do{format(CMDSString, 1000, %2, %3); ShowPlayerDialog(%0, HOUSEMENU-1, DIALOG_STYLE_MSGBOX, %1, CMDSString, "Закрыть", "Отмена");}while(FALSE)
#define SendMSG(%0,%1,%2,%3,%4) do{new _str[%2]; format(_str,%2,%3,%4); SendClientMessage(%0,%1,_str);}while(FALSE)
#define Loop(%0,%1) for(new %0 = 0; %0 < %1; %0++)
#define TYPE_OUT (0)
#define TYPE_INT (1)
#define GivePlayerMoney GivePlayerKryptoMoney
#define SetPlayerMoney SetPlayerKryptoMoney
#define ResetPlayerMoney ResetPlayerKryptoMoney
#define GetPlayerMoney GetPlayerKryptoMoney
#define TEAM_GROOVE 1
#define TEAM_AZTEC 2
#define TEAM_BALLAS 3
#define TEAM_VAGOS 4
#define TEAM_MAFIA 5
#define TEAM_RIFA 6
#define TEAM_YAKUZA 7
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF99AADD
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xDEAD4370
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000//ЧЕРНЫЙ
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA//сИНИЙ
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA//Оранжевый
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA//Зеленый
#define COLOR_RED 0xAA3333AA//Красный
#define COLOR_YELLOW 0xFFFF00AA//ЖЕЛТЫЙ
#define COLOR_WHITE 0xFFFFFFAA//БЕЛЫЙ
#define COLOR_PURPLE 0x800080AA
#define COLOR_CYAN  	0x40FFFFFF
#define red 0xFF0000AA
#define COLOR_INTERFACE_BODY 0xFDE39DAA
#define COLOR_TEMA 0x33AA33AA
#define yellow 0xFFFF00AA
#define DIALOG_CONNECT   0
#define DIALOG_CONNECT_1 1
#define DIALOG_CONNECT_2 2
#define DIALOG_CONNECT_3 3
#define DIALOG_CONNECT_4 4
#define DIALOG_HELP      5
#define DIALOG_GUNS      6
#define DIALOG_EAT      7
#define index 1 // You can change the number of the Object Index.
#define MAX_PROPERTIES 101
#define MAX_PROPERTIES_PER_PLAYER 4
#define UNBUYABLETIME 15  //If a propertie is bought, someone else have to wait this number of minutes before he/she can buy it.
#define ENABLE_LOGIN_SYSTEM 0
#define ENABLE_MAP_ICON_STREAMER 0
#define REGISTER_COMMAND "/hjhgjhgjhgjghjhj"
#define LOGIN_COMMAND "/ghjhgjhgjhgjghkjgfgfdhvfdsg"#define SetPlayerHoldingObject(%1,%2,%3,%4,%5,%6,%7,%8,%9) SetPlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1,%2,%3,%4,%5,%6,%7,%8,%9)
#define StopPlayerHoldingObject(%1) RemovePlayerAttachedObject(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define IsPlayerHoldingObject(%1) IsPlayerAttachedObjectSlotUsed(%1,MAX_PLAYER_ATTACHED_OBJECTS-1)
#define MAX_MONEY    1
#define SHOP_DIALOG 4449
#define FORXEN(%1,%2)	for(new %1 = 0; %1 < %2; %1++)
#define help 1111
#define help2 8111
#define help3 9111
#define help4 5111
#define anim 9111
#define telesnc 1112
#define lv 1114
#define sf 1113
#define ls 1115
#define fd 1116
#define fd1 1117
#define fd2 1118
#define placess 5731
#define buygun 5735
#define DIALOGID 1
#define fixchars(%1) for(new charfixloop=0;charfixloop<strlen(%1);charfixloop++)if(%1[charfixloop]<0)%1[charfixloop]+=256
#define DUELCOLOR1 0x10F441AA
#define DUELCOLOR2 0xAFAFAFAA
#define MaxSumma 20000
#define FreezeTime 5
#define DuelAmmo 999
#define duels 2501
#define duel2 2101
#define duel3 2301
#define duel4 2401
#define dduels 2502
#define dduel2 2102
#define dduel3 2302
#define dduel4 2402
#define FloodTime 3 //Секунды флуда
//==============================================================================
//                              Colours
//==============================================================================
#define COLOUR_INFO			   			0x00FFFFFF
#define COLOUR_SYSTEM 		   			0xB60000FF
#define COLOUR_YELLOW 					0xFFFF2AFF
#define COLOUR_GREEN 					0x00BC00FF
//==============================================================================
//                              Configuration
//==============================================================================
#define HOUSEMENU 						21700 // Dialog ID
#define SPAWN_IN_HOUSE // Comment if you do not want the player to spawn in his house the next time he rejoins.
#define GH_HINTERIOR_UPGRADE // Comment if you do not want players to be able to upgrade their house interior.
#define HSPAWN_TIMER_RATE   1000 // After how long will the timer call the spawn in house function? (in ms)
#define MICON_VD 5000.0 // Map icon visible range (drawdistance).
#define DEFAULT_H_INTERIOR  0 // Default house interior when creating a house
#define DEFAULT_H_INTERIOR_PRICE  3000000 // Default house interior price when creating a house
#define GH_USE_WEAPONSTORAGE // If defined the house owner may store their weapons in the house storage.
#define GH_HOUSECARS // If defined the script will have house cars (note: you need to add the house car position using /addhcar)
#define HCAR_COLOUR1 -1 // The first colour of the housecar
#define HCAR_COLOUR2 -1 // The second colour of the housecar
#define HCAR_RESPAWN 60 // The respawn delay of the house car (in seconds)с
#define HCAR_RANGE  10.0 // The range to check for nearby vehicles when saving the house car.
#define MAX_HOUSES 						5000 // Max houses created
#define MAX_HOUSES_OWNED    			1 // Max houses owned per player
#define PICKUP_MODEL_OUT (1273)
#define PICKUP_MODEL_INT (1272)
#define PICKUP_TYPE (23)
#define HOUSEFILE_LENGTH                30 // The length of the housefile (Default is /GarHouse/Houses/<0-MAX_HOUSES>.ini
#define MAX_VISIT_TIME                  1 // The max time the player can be visiting in (In Minutes).
#define INVALID_HOWNER_NAME             "INVALID_PLAYER_ID" // The "name" of the house owner when there is no real house owner (if that made sense)
#define TIME_BETWEEN_VISITS             2 // The time the player have to wait before previewing a new house interior (In minutes).
#define H_INT_0_VALUE   				3000000 // House interior price for house interior 0
#define H_INT_1_VALUE   				100000 // House interior price for house interior 1
#define H_INT_2_VALUE   				1000000 // House interior price for house interior 2
#define H_INT_3_VALUE   				1500000 // House interior price for house interior 3
#define H_INT_4_VALUE   				1500000 // House interior price for house interior 4
#define H_INT_5_VALUE   				2500000 // House interior price for house interior 5
#define H_INT_6_VALUE   				3000000 // House interior price for house interior 6
#define H_INT_7_VALUE   				5000000 // House interior price for house interior 7
#define H_INT_8_VALUE   				7500000 // House interior price for house interior 8
#define H_INT_9_VALUE   				10000000 // House interior price for house interior 9
#define H_INT_10_VALUE   				25000000 // House interior price for house interior 10
#define HOUSE_SELLING_PROCENT   		75 // The amount of the house value the player will get when the house is sold.
#define HOUSE_SELLING_PROCENT2 			6.5 // The total percentage the nearby houses will go up/down by when a house is sold/bought nearby.
#define RANGE_BETWEEN_HOUSES            200 // The range used when increasing/decreasing the value of nearby houses when a house is bought/sold (set to 0 to disable)
#define MAX_HOUSE_NAME                  35 // Max length of a house name
#define MIN_HOUSE_NAME                  4 // Min length of a house name
#define MAX_HOUSE_PASSWORD              35 // Max length of a house password
#define MIN_HOUSE_PASSWORD              4 // Min length of a house password
#define DEFAULT_HOUSE_NAME              "Простой дом" // The default name when a house is created/sold
#define MIN_HOUSE_VALUE                 100000 // Min house value of a house (ofc prices will change when a house is bought/sold nearby)
#define MAX_HOUSE_VALUE                 999999999 // Max house value of a house (ofc prices will change when a house is bought/sold nearby)
#define CASE_SENSETIVE                  true // Used in strcmp name checks. Define as true/false [0/1]. Read wiki for more information
#define MAX_ZONE_NAME 				60 // Max length of a zone name
#if defined GH_USE_CPS
	new HouseCPOut[MAX_HOUSES], HouseCPInt[MAX_HOUSES];
#endif
#if !defined GH_USE_CPS
	new HousePickupOut[MAX_HOUSES], HousePickupInt[MAX_HOUSES];
#endif
new Text3D:HouseLabel[MAX_HOUSES];
new Float:X, Float:Y, Float:Z, Float:Angle;
#if defined GH_USE_MAPICONS
	new HouseMIcon[MAX_HOUSES];
#endif
#if defined GH_HOUSECARS
	new HouseCar[MAX_HOUSES];
#endif


//================| Форварды |==================================================
forward CheckCheatMoney(playerid);
forward OnGMSecond();
forward HouseVisiting(playerid);
forward DuelTimer2(playerid);
forward UnfreezePlayerter(playerid);
forward YourObratno(playerid);
forward AntiKillSys();
forward Givecashdelaytimer(playerid);
forward SetupPlayerForClassSelection(playerid);
forward GameModeExitFunc();
forward Tbank(playerid);
forward AntiMoneyHack();
forward GivePlayerKryptoMoney(playerid, amount);
forward SetPlayerKryptoMoney(playerid, amount);
forward ResetPlayerKryptoMoney(playerid);
forward GetPlayerKryptoMoney(playerid);
forward time(playerid);
forward SetRandomWeather();
forward SetPlayerRandomSpawn(playerid);
forward Float:GetDistancePlayertoPlayer(playerid,killerid);
forward unfreeze(playerid);
forward commercials();
forward commercials2();
forward DuelTimer1(playerid);
forward SetName();
forward HouseSpawning(playerid);
forward ycKoPuTeJlb333(playerid);//yckopntel
forward BocToHoBuJlu(playerid);//yckopntel
forward Reklama(playerid);//yckopntel
forward Reklama();
forward vitals();
forward IsMiniCar(carid);
forward UnMutedX(playerid); //Анти-флуд

