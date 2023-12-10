// Скачано с Doc-Game.ru - Эксперт в игровой индустрии
// Большое количество модов для SA:MP - http://doc-game.ru/
// Мы в ВКонтакте - https://vk.com/dgame_ru
//-----------------------------------------------------------
// Установка / Настройка мода -https://vk.com/aik.docgame
// Услуги скриптера - vk.com/aik.docgame
// Сливы Аккаунтов / Логов / Приват модов - vk.com/legion777.shop
@___If_u_can_read_this_u_r_nerd(); 
@___If_u_can_read_this_u_r_nerd()
{
#emit stack 0x7FFFFFFF 
#emit inc.s cellmax 
static const ___[][] = {"vk.com/", "dgame_ru"};
#emit retn
#emit load.s.pri ___ 
#emit proc
#emit proc 
#emit fill cellmax
#emit proc
#emit stack 1
#emit stor.alt ___ 
#emit strb.i 2 
#emit switch 4
#emit retn 
L1:
#emit jump L1 
#emit zero cellmin
}

/* Инклуды */
#include <a_samp>
#include <a_mysql>
#include <zcmd>
#include <sscanf2>
#include <foreach>
#include <mxdate>
#include <streamer>
/*  - - - - - - - - - - - */

/* Цвета */
#define COLOR_DARK   	0x2B2B2BFF
#define COLOR_WHITE 	0xFFFFFFFF
#define COLOR_GRAY   	0xCECFCEFF
#define COLOR_GREEN 	0x5AB200FF
#define COLOR_OLIVE     0xA5CF84FF
#define COLOR_YELLOW 	0xFFFF00FF
#define COLOR_RED 		0xFF0000FF
#define COLOR_LIGHTRED  0xFF4530FF
#define COLOR_BLUE   	0x00BFFFFF
#define COLOR_ORANGE    0xFF6500FF
#define COLOR_PURPLE 	0xBD96FDFF
/*  - - - - - - - - - - - */

/* Макросы */

//SetTimerEx("TKick", 1000, false, "i", playerid); - КИК

/*  - - - - - - - - - - - */

/* Подключение к Базе Данных */
new
	connect_mysql;
/*  - - - - - - - - - - - */

/* Выбор зоны */
new
	Text:choose_zone_one,
	Text:choose_zone_two,
	Text:choose_zone_three,
	Text:choose_zone_four,
	Text:choose_zone_five;
/*  - - - - - - - - - - - */

/* Логотип */

new
	Text:logotype_monser,
	Text:logotype_gang,
	Text:logotype_war;
/*  - - - - - - - - - - - */

/* Выбор скина */
new
	Text:choose_skin_one,
	Text:choose_skin_two,
	Text:choose_skin_three,
	Text:choose_skin_four,
	Text:choose_skin_five,
	Text:choose_skin_six,
	Text:choose_skin_seven;
/* - - - - - - - - - - - - - */


/* Выбор скина GW */
new
	Text:choose_skin_gw_one,
	Text:choose_skin_gw_two,
	Text:choose_skin_gw_three,
	Text:choose_skin_gw_four,
	Text:choose_skin_gw_five,
	Text:choose_skin_gw_six,
	Text:choose_skin_gw_seven,
	Text:choose_skin_gw_eight,
	Text:choose_skin_gw_nine,
	Text:choose_skin_gw_ten,
	Text:choose_skin_gw_eleven;
/* - - - - - - - - - - - - - */

new
	date_unlock[MAX_PLAYERS];/* Дата разблокировки */

new
	eror_password = 3; /*Максимальное количество неверных паролей*/
new
	player_kick_time[MAX_PLAYERS char];

/* Спавны DeathMatch */
new	Float:random_spawn_deathmatch[7][4] =
{
	{-403.9401,2216.4229,42.4297, 1.0000},
	{-363.8238,2247.4382,42.4844,1.0000},
	{-372.9104,2273.1995,41.7706,1.0000},
	{-347.0618,2210.3579,42.4844,58.7583},
	{-410.7896,2266.9365,42.1703,227.9495},
	{-445.5831,2224.6880,42.4297,182.0314},
	{-389.9460,2194.2104,42.4159,1.0000}

};

new Float:random_spawn_deagle[8][4] =
{
	{1974.6163,-1233.6956,20.0469,110.4629},
	{2043.4861,-1225.6974,23.0381,1.0000},
	{1915.4200,-1189.4819,21.3964,1.0000},
	{1915.2140,-1225.9894,17.9965,1.0000},
	{1873.0089,-1216.3877,18.3144,1.0000},
	{1922.7892,-1151.9774,23.8260,1.0000},
	{1965.5812,-1157.0455,20.9672,256.8908},
	{2027.0773,-1189.5850,21.6190,23.6287}
};

new Float:random_spawn_anti[6][4] =
{
	{1586.2166,43.1374,25.0152,1.0000},
	{1586.2166,43.1374,25.0152,1.0000},
	{1586.2166,43.1374,25.0152,1.0000},
	{1586.2166,43.1374,25.0152,1.0000},
	{1532.2014,3.3587,23.6393,243.8129},
	{1578.9969,20.2184,23.6366,1.0000}
};

new Float:random_spawn_sniper_police[5][4] =
{
	{-540.5989,-69.1781,63.1924,1.0000},
	{-435.7030,-64.8797,58.8750,1.0000},
	{-569.9273,-104.8279,65.7520,1.0000},
	{-540.5989,-69.1781,63.1924,1.0000},
	{-488.0360,-101.8784,62.3414,1.0000}
};

new Float:random_spawn_sniper_army[5][4] =
{
	{-549.2468,-174.5069,78.4063,1.0000},
	{-572.4713,-177.0631,78.4063,1.0000},
	{-490.0184,-203.3595,78.4063,1.0000},
	{-572.4713,-177.0631,78.4063,1.0000},
	{-536.4150,-162.5918,78.3220,1.0000}
};
/* - - - - - - - - - - - - - */

/* Информация о игроке */
enum pInfo
{
	pID,
	pName[MAX_PLAYER_NAME],
	pPassword[30],
	pInvitePlayer[MAX_PLAYER_NAME],
	pEmail[60],
	pBand,
	pGang,
	pSkin,
	pDeath,
 	pKill
};
new
	PlayerInfo[MAX_PLAYERS][pInfo];
/* - - - - - - - - - - - - - */

/* Дамаг, ХП игрока, Сердце */
new
	Text:DamageBar,
	Text:HealthBar[MAX_PLAYERS],
	Heart[MAX_PLAYERS];
/*  - - - - - - - - - - - */

/* Проверка на авторизацию */
new bool:
	player_logins[MAX_PLAYERS char];
/*  - - - - - - - - - - - */

/* Skins GangWar */
new
    skingw[MAX_PLAYERS],
	skingrove[7][1] = {{105}, {106}, {107}, {271}, {269}, {270}, {65}},
	skinballas[4][1] = {{103}, {102}, {104}, {195}},
	skinvagos[4][1] = {{108}, {109}, {110}, {190}},
	skinaztecas[5][1] = {{114}, {116}, {115}, {292}, {193}}
;
/*  - - - - - - - - - - - */

/* Pickup GangWar */
static
	pickupgrove[2],
	pickupballas[2],
	pickupvagos[2],
	pickupaztecas[2];
/*  - - - - - - - - - - - */

main(){}

public OnGameModeInit()
{
	/* Подлючение MySQL */
	connect_mysql = mysql_connect("127.0.0.1", "root", "gangwar", "");
	printf("База даных %s", mysql_errno() == -1 ? ("не подключена") : ("подключена"));
	/*  - - - - - - - - - - - */

	Cars();
	Pickups();
	Label();
	MapIcon();

	SetTimer("@__login_timer", 1000, 1); /* Глобальный таймер на 1 секунду */
	SetTimer("ChooseLogotype", 1000, 1);
	
	DisableInteriorEnterExits();

	SetGameModeText("Monser TDM ft. DM");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	
	/* TextDraw - Выбор зон, скинов */
	choose_skin_one = TextDrawCreate(647.622314, -0.250000, "usebox");//Чёрный квадрат
	TextDrawLetterSize(choose_skin_one, 0.000000, 12.387037);
	TextDrawTextSize(choose_skin_one, -2.468522, 0.000000);
	TextDrawAlignment(choose_skin_one, 1);
	TextDrawColor(choose_skin_one, 0);
	TextDrawUseBox(choose_skin_one, true);
	TextDrawBoxColor(choose_skin_one, 255);
	TextDrawSetShadow(choose_skin_one, 0);
	TextDrawSetOutline(choose_skin_one, 0);
	TextDrawFont(choose_skin_one, 0);

	choose_skin_two = TextDrawCreate(657.929687, 337.499969, "usebox");//Чёрный квадрат
	TextDrawLetterSize(choose_skin_two, 0.000000, 13.580193);
	TextDrawTextSize(choose_skin_two, -4.342606, 0.000000);
	TextDrawAlignment(choose_skin_two, 1);
	TextDrawColor(choose_skin_two, 0);
	TextDrawUseBox(choose_skin_two, true);
	TextDrawBoxColor(choose_skin_two, 255);
	TextDrawSetShadow(choose_skin_two, 0);
	TextDrawSetOutline(choose_skin_two, 0);
	TextDrawFont(choose_skin_two, 0);

	choose_skin_three = TextDrawCreate(68.404090, 372.166870, "ID");
	TextDrawLetterSize(choose_skin_three, 0.556822, 1.990833);
	TextDrawTextSize(choose_skin_three, 100.011695, 25.499999);
	TextDrawAlignment(choose_skin_three, 1);
	TextDrawColor(choose_skin_three, -1);
	TextDrawUseBox(choose_skin_three, true);
	TextDrawBoxColor(choose_skin_three, 255);
	TextDrawSetShadow(choose_skin_three, 0);
	TextDrawSetOutline(choose_skin_three, 1);
	TextDrawBackgroundColor(choose_skin_three, 51);
	TextDrawFont(choose_skin_three, 3);
	TextDrawSetProportional(choose_skin_three, 1);
	TextDrawSetSelectable(choose_skin_three, true);

	choose_skin_four = TextDrawCreate(285.798217, 393.749908, "SELECT");
	TextDrawLetterSize(choose_skin_four, 0.528243, 1.850834);
	TextDrawTextSize(choose_skin_four, 353.733703, 25.083333);
	TextDrawAlignment(choose_skin_four, 1);
	TextDrawColor(choose_skin_four, -1);
	TextDrawUseBox(choose_skin_four, true);
	TextDrawBoxColor(choose_skin_four, 255);
	TextDrawSetShadow(choose_skin_four, 0);
	TextDrawSetOutline(choose_skin_four, 1);
	TextDrawBackgroundColor(choose_skin_four, 51);
	TextDrawFont(choose_skin_four, 3);
	TextDrawSetProportional(choose_skin_four, 1);
	TextDrawSetSelectable(choose_skin_four, true);

	choose_skin_five = TextDrawCreate(527.555664, 372.166809, "RANDOM");
	TextDrawLetterSize(choose_skin_five, 0.473426, 1.722500);
	TextDrawTextSize(choose_skin_five, 608.141174, 6.416665);
	TextDrawAlignment(choose_skin_five, 1);
	TextDrawColor(choose_skin_five, -1);
	TextDrawUseBox(choose_skin_five, true);
	TextDrawBoxColor(choose_skin_five, 255);
	TextDrawSetShadow(choose_skin_five, 0);
	TextDrawSetOutline(choose_skin_five, 1);
	TextDrawBackgroundColor(choose_skin_five, 51);
	TextDrawFont(choose_skin_five, 3);
	TextDrawSetProportional(choose_skin_five, 1);
	TextDrawSetSelectable(choose_skin_five, true);

    choose_zone_one = TextDrawCreate(643.874023, 1.500000, "usebox");
	TextDrawLetterSize(choose_zone_one, 0.000000, 10.541842);
	TextDrawTextSize(choose_zone_one, -2.000000, 0.000000);
	TextDrawAlignment(choose_zone_one, 1);
	TextDrawColor(choose_zone_one, 0);
	TextDrawUseBox(choose_zone_one, true);
	TextDrawBoxColor(choose_zone_one, 255);
	TextDrawSetShadow(choose_zone_one, 0);
	TextDrawSetOutline(choose_zone_one, 0);
	TextDrawFont(choose_zone_one, 0);

	choose_zone_two = TextDrawCreate(647.153991, 337.500061, "usebox");
	TextDrawLetterSize(choose_zone_two, 0.000000, 11.899065);
	TextDrawTextSize(choose_zone_two, -5.279647, 0.000000);
	TextDrawAlignment(choose_zone_two, 1);
	TextDrawColor(choose_zone_two, 0);
	TextDrawUseBox(choose_zone_two, true);
	TextDrawBoxColor(choose_zone_two, 255);
	TextDrawSetShadow(choose_zone_two, 0);
	TextDrawSetOutline(choose_zone_two, 0);
	TextDrawFont(choose_zone_two, 0);

	choose_zone_three = TextDrawCreate(84.333831, 373.333404, "LD_BEAT:left");
	TextDrawLetterSize(choose_zone_three, 0.000000, 0.000000);
	TextDrawTextSize(choose_zone_three, 44.978027, 35.000000);
	TextDrawAlignment(choose_zone_three, 1);
	TextDrawColor(choose_zone_three, -1);
	TextDrawSetShadow(choose_zone_three, 0);
	TextDrawSetOutline(choose_zone_three, 0);
	TextDrawFont(choose_zone_three, 4);
	TextDrawSetSelectable(choose_zone_three, true);

	choose_zone_four = TextDrawCreate(488.997161, 372.399902, "LD_BEAT:right");
	TextDrawLetterSize(choose_zone_four, 0.000000, 0.000000);
	TextDrawTextSize(choose_zone_four, 51.068786, 34.999996);
	TextDrawAlignment(choose_zone_four, 1);
	TextDrawColor(choose_zone_four, -1);
	TextDrawSetShadow(choose_zone_four, 0);
	TextDrawSetOutline(choose_zone_four, 0);
	TextDrawFont(choose_zone_four, 4);
	TextDrawSetSelectable(choose_zone_four, true);

	choose_zone_five = TextDrawCreate(276.895996, 382.666625, "SPAWN");
	TextDrawLetterSize(choose_zone_five, 0.553543, 2.142501);
	TextDrawTextSize(choose_zone_five, 332.500000, 23.893331);
	TextDrawAlignment(choose_zone_five, 1);
	TextDrawColor(choose_zone_five, -1);
	TextDrawSetShadow(choose_zone_five, 0);
	TextDrawSetOutline(choose_zone_five, 1);
	TextDrawBackgroundColor(choose_zone_five, 30);
	TextDrawFont(choose_zone_five, 3);
	TextDrawSetProportional(choose_zone_five, 1);
	TextDrawSetSelectable(choose_zone_five, true);

	choose_skin_six = TextDrawCreate(362.997161, 246.959930, "LD_BEAT:right");
	TextDrawLetterSize(choose_skin_six, 0.000000, 0.000000);
	TextDrawTextSize(choose_skin_six, 27.068786, 27.533340);
	TextDrawAlignment(choose_skin_six, 1);
	TextDrawColor(choose_skin_six, -1);
	TextDrawSetShadow(choose_skin_six, 0);
	TextDrawSetOutline(choose_skin_six, 0);
	TextDrawFont(choose_skin_six, 4);
	TextDrawSetSelectable(choose_skin_six, true);

	choose_skin_seven = TextDrawCreate(254.062255, 245.953460, "LD_BEAT:left");
	TextDrawLetterSize(choose_skin_seven, 0.000000, 0.000000);
	TextDrawTextSize(choose_skin_seven, 27.500000, 25.386663);
	TextDrawAlignment(choose_skin_seven, 1);
	TextDrawColor(choose_skin_seven, -1);
	TextDrawSetShadow(choose_skin_seven, 0);
	TextDrawSetOutline(choose_skin_seven, 0);
	TextDrawFont(choose_skin_seven, 4);
	TextDrawSetSelectable(choose_skin_seven, true);
	/*  - - - - - - - - - - - */

	/* TextDraw - ГангВар */
	choose_skin_gw_one = TextDrawCreate(647.622314, -0.250000, "usebox");//Чёрный квадрат
	TextDrawLetterSize(choose_skin_gw_one, 0.000000, 12.387037);
	TextDrawTextSize(choose_skin_gw_one, -2.468522, 0.000000);
	TextDrawAlignment(choose_skin_gw_one, 1);
	TextDrawColor(choose_skin_gw_one, 0);
	TextDrawUseBox(choose_skin_gw_one, true);
	TextDrawBoxColor(choose_skin_gw_one, 255);
	TextDrawSetShadow(choose_skin_gw_one, 0);
	TextDrawSetOutline(choose_skin_gw_one, 0);
	TextDrawFont(choose_skin_gw_one, 0);

	choose_skin_gw_two = TextDrawCreate(657.929687, 337.499969, "usebox");//Чёрный квадрат
	TextDrawLetterSize(choose_skin_gw_two, 0.000000, 13.580193);
	TextDrawTextSize(choose_skin_gw_two, -4.342606, 0.000000);
	TextDrawAlignment(choose_skin_gw_two, 1);
	TextDrawColor(choose_skin_gw_two, 0);
	TextDrawUseBox(choose_skin_gw_two, true);
	TextDrawBoxColor(choose_skin_gw_two, 255);
	TextDrawSetShadow(choose_skin_gw_two, 0);
	TextDrawSetOutline(choose_skin_gw_two, 0);
	TextDrawFont(choose_skin_gw_two, 0);

	choose_skin_gw_three = TextDrawCreate(276.895996, 382.666625, "SPAWN");
	TextDrawLetterSize(choose_skin_gw_three, 0.553543, 2.142501);
	TextDrawTextSize(choose_skin_gw_three, 332.500000, 23.893331);
	TextDrawAlignment(choose_skin_gw_three, 1);
	TextDrawColor(choose_skin_gw_three, -1);
	TextDrawSetShadow(choose_skin_gw_three, 0);
	TextDrawSetOutline(choose_skin_gw_three, 1);
	TextDrawBackgroundColor(choose_skin_gw_three, 30);
	TextDrawFont(choose_skin_gw_three, 3);
	TextDrawSetProportional(choose_skin_gw_three, 1);
	TextDrawSetSelectable(choose_skin_gw_three, true);

	choose_skin_gw_four = TextDrawCreate(362.997161, 246.959930, "LD_BEAT:right");//Выбор скина
	TextDrawLetterSize(choose_skin_gw_four, 0.000000, 0.000000);
	TextDrawTextSize(choose_skin_gw_four, 27.068786, 27.533340);
	TextDrawAlignment(choose_skin_gw_four, 1);
	TextDrawColor(choose_skin_gw_four, -1);
	TextDrawSetShadow(choose_skin_gw_four, 0);
	TextDrawSetOutline(choose_skin_gw_four, 0);
	TextDrawFont(choose_skin_gw_four, 4);
	TextDrawSetSelectable(choose_skin_gw_four, true);

	choose_skin_gw_five = TextDrawCreate(254.062255, 245.953460, "LD_BEAT:left");//Выбор скина
	TextDrawLetterSize(choose_skin_gw_five, 0.000000, 0.000000);
	TextDrawTextSize(choose_skin_gw_five, 27.500000, 25.386663);
	TextDrawAlignment(choose_skin_gw_five, 1);
	TextDrawColor(choose_skin_gw_five, -1);
	TextDrawSetShadow(choose_skin_gw_five, 0);
	TextDrawSetOutline(choose_skin_gw_five, 0);
	TextDrawFont(choose_skin_gw_five, 4);
	TextDrawSetSelectable(choose_skin_gw_five, true);

	choose_skin_gw_six = TextDrawCreate(68.404090, 372.166870, "LD_BEAT:left");//Выбор банды
	TextDrawLetterSize(choose_skin_gw_six, 0.000000, 0.000000);
	TextDrawTextSize(choose_skin_gw_six, 51.068786, 34.999996);
	TextDrawAlignment(choose_skin_gw_six, 1);
	TextDrawColor(choose_skin_gw_six, -1);
	TextDrawSetShadow(choose_skin_gw_six, 0);
	TextDrawSetOutline(choose_skin_gw_six, 0);
	TextDrawFont(choose_skin_gw_six, 4);
	TextDrawSetSelectable(choose_skin_gw_six, true);

	choose_skin_gw_seven = TextDrawCreate(527.555664, 372.166809, "LD_BEAT:right");//Выбор банды
	TextDrawLetterSize(choose_skin_gw_seven, 0.000000, 0.000000);
	TextDrawTextSize(choose_skin_gw_seven, 51.068786, 34.999996);
	TextDrawAlignment(choose_skin_gw_seven, 1);
	TextDrawColor(choose_skin_gw_seven, -1);
	TextDrawSetShadow(choose_skin_gw_seven, 0);
	TextDrawSetOutline(choose_skin_gw_seven, 0);
	TextDrawFont(choose_skin_gw_seven, 4);
	TextDrawSetSelectable(choose_skin_gw_seven, true);

	choose_skin_gw_eight = TextDrawCreate(239.500000, 413.000000, "Online:");
	TextDrawLetterSize(choose_skin_gw_eight, 0.378500, 1.459999);
	TextDrawAlignment(choose_skin_gw_eight, 1);
	TextDrawColor(choose_skin_gw_eight, -1);
	TextDrawSetShadow(choose_skin_gw_eight, 0);
	TextDrawSetOutline(choose_skin_gw_eight, 1);
	TextDrawBackgroundColor(choose_skin_gw_eight, 51);
	TextDrawFont(choose_skin_gw_eight, 1);
	TextDrawSetProportional(choose_skin_gw_eight, 1);

	choose_skin_gw_nine = TextDrawCreate(289.500000, 413.583190, "20");
	TextDrawLetterSize(choose_skin_gw_nine, 0.394499, 1.448333);
	TextDrawAlignment(choose_skin_gw_nine, 1);
	TextDrawColor(choose_skin_gw_nine, -65281);
	TextDrawSetShadow(choose_skin_gw_nine, 0);
	TextDrawSetOutline(choose_skin_gw_nine, 1);
	TextDrawBackgroundColor(choose_skin_gw_nine, 51);
	TextDrawFont(choose_skin_gw_nine, 1);
	TextDrawSetProportional(choose_skin_gw_nine, 1);

	choose_skin_gw_ten = TextDrawCreate(321.000000, 413.416687, "Zons:");
	TextDrawLetterSize(choose_skin_gw_ten, 0.378500, 1.459999);
	TextDrawAlignment(choose_skin_gw_ten, 1);
	TextDrawColor(choose_skin_gw_ten, -1);
	TextDrawSetShadow(choose_skin_gw_ten, 0);
	TextDrawSetOutline(choose_skin_gw_ten, 1);
	TextDrawBackgroundColor(choose_skin_gw_ten, 51);
	TextDrawFont(choose_skin_gw_ten, 1);
	TextDrawSetProportional(choose_skin_gw_ten, 1);

	choose_skin_gw_eleven = TextDrawCreate(359.000000, 413.999847, "13");
	TextDrawLetterSize(choose_skin_gw_eleven, 0.394499, 1.448333);
	TextDrawAlignment(choose_skin_gw_eleven, 1);
	TextDrawColor(choose_skin_gw_eleven, -65281);
	TextDrawSetShadow(choose_skin_gw_eleven, 0);
	TextDrawSetOutline(choose_skin_gw_eleven, 1);
	TextDrawBackgroundColor(choose_skin_gw_eleven, 51);
	TextDrawFont(choose_skin_gw_eleven, 1);
	TextDrawSetProportional(choose_skin_gw_eleven, 1);
	/*  - - - - - - - - - - - */

    /* TextDraw - Логотип */
	logotype_monser = TextDrawCreate(551.500000, 16.426694, "Monser");
	TextDrawLetterSize(logotype_monser, 0.449999, 1.600000);
	TextDrawAlignment(logotype_monser, 1);
	TextDrawColor(logotype_monser, -252);
	TextDrawSetShadow(logotype_monser, 0);
	TextDrawSetOutline(logotype_monser, 0);
	TextDrawBackgroundColor(logotype_monser, 51);
	TextDrawSetProportional(logotype_monser, 1);

	logotype_gang = TextDrawCreate(560.000000, 26.880001, "Gang");
	TextDrawLetterSize(logotype_gang, 0.449999, 1.600000);
	TextDrawAlignment(logotype_gang, 1);
	TextDrawColor(logotype_gang, -252);
	TextDrawSetShadow(logotype_gang, 0);
	TextDrawSetOutline(logotype_gang, 0);
	TextDrawBackgroundColor(logotype_gang, 51);
	TextDrawSetProportional(logotype_gang, 1);

	logotype_war = TextDrawCreate(562.500000, 38.826667, "War");
	TextDrawLetterSize(logotype_war, 0.449999, 1.600000);
	TextDrawAlignment(logotype_war, 1);
	TextDrawColor(logotype_war, -252);
	TextDrawSetShadow(logotype_war, 0);
	TextDrawSetOutline(logotype_war, 0);
	TextDrawBackgroundColor(logotype_war, 51);
	TextDrawSetProportional(logotype_war, 1);
	/*  - - - - - - - - - - - */
	
	/* TextDraw - Дамаг */
	DamageBar = TextDrawCreate(325.500000, 185.173049, "-7hp");
	TextDrawLetterSize(DamageBar, 0.428000, 1.458133);
	TextDrawAlignment(DamageBar, 1);
	TextDrawColor(DamageBar, -1);
	TextDrawSetShadow(DamageBar, 0);
	TextDrawSetOutline(DamageBar, 1);
	TextDrawBackgroundColor(DamageBar, 51);
	TextDrawFont(DamageBar, 1);
	TextDrawSetProportional(DamageBar, 1);
	/*  - - - - - - - - - - - */
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(player_logins{playerid})
	SpawnPlayer(playerid);
	SetTimerEx("fix_buttons", 500, false, "i", playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
    /* Получение ника в переменую pName */
	GetPlayerName(playerid, PlayerInfo[playerid][pName], MAX_PLAYER_NAME);
	/*  - - - - - - - - - - - */

	/* Отвечает за Авторизацию и Регистрацию  */
	static const
	    frm_string[] = "SELECT `ID`, `Password` FROM `accounts` WHERE `Name` = '%s'";
	new
		query_string[sizeof(frm_string)-2+MAX_PLAYER_NAME]; /* Авто-Подсчет кол-ва символов в строке */

	format(query_string, sizeof(query_string), frm_string, PlayerInfo[playerid][pName]);
	mysql_function_query(connect_mysql, query_string, true, "IsFindAccountInTable", "i", playerid);
	/*  - - - - - - - - - - - */

	/* Одним словом бан */
	static
		frm_string_2[] = "SELECT * FROM `ban` WHERE `Name` = '%s'";
	new
		query_string_2[sizeof(frm_string_2)-2+MAX_PLAYER_NAME+1];
	mysql_format(connect_mysql, query_string_2, sizeof(query_string_2), frm_string_2, PlayerInfo[playerid][pName]);
	mysql_function_query(connect_mysql, query_string_2, true, "PlayerBan", "d", playerid);
	/*  - - - - - - - - - - - */

	player_kick_time{playerid} = 60;

	/* Подключение игрока на сервер */
	/*new ip[16];
	GetPlayerIp(playerid,ip,16);
	static const
 		getip[] = "[ID:%d] %s заходит на сервер. (%s)";
	new
		str_getip[sizeof(getip)+MAX_PLAYER_NAME+3+16-6];
	format(str_getip, sizeof(str_getip), getip, playerid, GN(playerid), ip);
	AdminChat(COLOR_GRAY, str_getip);
	printf("%s", str_getip);*/
	/*  - - - - - - - - - - - */

	/* TextDraw - ХП */
	HealthBar[playerid] = TextDrawCreate(571.500000, 65.333297, "100");
	TextDrawLetterSize(HealthBar[playerid], 0.214000, 1.104166);
	TextDrawAlignment(HealthBar[playerid], 1);
	TextDrawColor(HealthBar[playerid], -1);
	TextDrawSetShadow(HealthBar[playerid], 0);
	TextDrawSetOutline(HealthBar[playerid], 0);
	TextDrawBackgroundColor(HealthBar[playerid], 51);
	TextDrawSetProportional(HealthBar[playerid], 1);
	/*  - - - - - - - - - - - */

	Heart[playerid] = 1;//Сердце
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    /* Сохранение информации о игроке */
	/*  - - - - - - - - - - - */

    clear_playerinfo(playerid);
    TextDrawDestroy(HealthBar[playerid]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid,HealthBar[playerid]);
	if(GetPVarInt(playerid, "select_mode") == 1)
	{
		switch(GetPVarInt(playerid, "choose_gangwar"))
		{
		    case 0: //GROVE STREET
		    {
				SetPlayerPos(playerid, 2449.2578,-1692.7897,1013.5152);
				SetPlayerFacingAngle(playerid, 180.0000);
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				SetPlayerColor(playerid, 0x009900AA);
				SetPlayerInterior(playerid, 2);
				SetPlayerVirtualWorld(playerid, 1);
		    }
		    case 1: //THE BALLAS GANG
		    {
				SetPlayerPos(playerid, -49.6582,1399.9801,1084.4297);
				SetPlayerFacingAngle(playerid, 0.0000);
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				SetPlayerColor(playerid, 0xCC00FFAA);
				SetPlayerInterior(playerid, 8);
				SetPlayerVirtualWorld(playerid, 1);
		    }
		    case 2: //LOS SANTOS VAGOS
		    {
				SetPlayerPos(playerid, 330.6743,1121.3982,1083.8903);
				SetPlayerFacingAngle(playerid, 0.0000);
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				SetPlayerColor(playerid, 0xFFCD00AA);
				SetPlayerInterior(playerid, 5);
				SetPlayerVirtualWorld(playerid, 1);
		    }
		    case 3: //VARIOS LOS AZTECAS
		    {
				SetPlayerPos(playerid, 230.8951,1247.3800,1082.1406);
				SetPlayerFacingAngle(playerid, 180.0000);
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				SetPlayerColor(playerid, 0x00CCFFAA);
				SetPlayerInterior(playerid, 2);
				SetPlayerVirtualWorld(playerid, 1);
			}
		}
	}
	switch(GetPVarInt(playerid, "system_zone"))
	{
		case 1:
		{
	        new
				rand = random(sizeof(random_spawn_deagle));
 			SetPlayerPos(playerid, random_spawn_deagle[rand][0], random_spawn_deagle[rand][1], random_spawn_deagle[rand][2]);
			SetPlayerFacingAngle(playerid, random_spawn_deagle[rand][3]);
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			SetPlayerHealth(playerid, 30);
			GivePlayerWeapon(playerid, 24, 999);
			SetPlayerColor(playerid, 0x808080AA);
		}
		case 2:
		{
			new
				rand = random(sizeof(random_spawn_deathmatch));
 			SetPlayerPos(playerid, random_spawn_deathmatch[rand][0], random_spawn_deathmatch[rand][1], random_spawn_deathmatch[rand][2]);
			SetPlayerFacingAngle(playerid, random_spawn_deathmatch[rand][3]);
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			GivePlayerWeapon(playerid, 24, 999);
			SetPlayerColor(playerid, 0x808080AA);
		}
		case 3:
		{
		    new
				rand = random(sizeof(random_spawn_anti));
 			SetPlayerPos(playerid, random_spawn_anti[rand][0], random_spawn_anti[rand][1], random_spawn_anti[rand][2]);
			SetPlayerFacingAngle(playerid, random_spawn_anti[rand][3]);
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			GivePlayerWeapon(playerid, 24, 999);
			SetPlayerColor(playerid, 0x808080AA);
		}
		case 4:
		{
		    GivePlayerWeapon(playerid, 34, 999);
			switch(PlayerInfo[playerid][pBand])
			{
			    case 3: //Army
			    {
			        new
						rand = random(sizeof(random_spawn_sniper_army));
 					SetPlayerPos(playerid, random_spawn_sniper_army[rand][0], random_spawn_sniper_army[rand][1], random_spawn_sniper_army[rand][2]);
					SetPlayerFacingAngle(playerid, random_spawn_sniper_army[rand][3]);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, 0xFF0000AA);
			    }
			    case 4: //Police
			    {
			        new
						rand = random(sizeof(random_spawn_sniper_police));
 					SetPlayerPos(playerid, random_spawn_sniper_police[rand][0], random_spawn_sniper_police[rand][1], random_spawn_sniper_police[rand][2]);
					SetPlayerFacingAngle(playerid, random_spawn_sniper_police[rand][3]);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, 0x0000FFAA);
			    }
			}
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    /* Показывает килл лист */
    SendDeathMessage(killerid, playerid, reason);
    /*  - - - - - - - - - - - */
    /* Показывает Текст при смерте или убийстве! */
	static const
	    frm_string[] = "~n~~n~~n~~n~~n~~y~KILLED BY %s",
	    frm_string_two[] = "~n~~n~~n~~n~~n~~y~ +1 SCORE~n~KILLED %s";
	new
		string[sizeof(frm_string)-2+MAX_PLAYER_NAME];
	new
		string_two[sizeof(frm_string_two)-2+MAX_PLAYER_NAME];
	format(string, sizeof(string), frm_string, PlayerInfo[killerid][pName]);
	GameTextForPlayer(playerid, string, 2000, 5);
	format(string_two, sizeof(string_two), frm_string_two, PlayerInfo[playerid][pName]);
	GameTextForPlayer(killerid, string_two, 2000, 5);
	PlayerInfo[killerid][pKill]++;
	PlayerInfo[playerid][pDeath]++;
	/*  - - - - - - - - - - - */
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(player_logins{playerid} == false)
	{
	    SendClientMessage(playerid, COLOR_RED, "Вы не авторизованы!");
	    return 0;
	}
	AntiCaps(text);
	static const
	    frm_string[] =  "{%06x}%s [ID:%i]: {ffffff}%s";
	new
		string[sizeof(frm_string)-2+MAX_PLAYER_NAME-2+3-2+128];
	format(string, sizeof(string), frm_string, GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][pName], playerid, text);
	ProxDetectorNew(20.0, playerid, string, -1);
	return false;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(player_logins{playerid} == false)return 1;
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == pickupgrove[0])
	{
		if(PlayerInfo[playerid][pGang] == 1)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 2466.6616,-1698.3544,1013.5078);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 2);
			SetPlayerFacingAngle(playerid, 90.7092);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupgrove[1])
	{
		if(PlayerInfo[playerid][pGang] == 1)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 2520.0061,-1678.7922,14.9097);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 77.3067);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupballas[0])
	{
		if(PlayerInfo[playerid][pGang] == 2)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, -42.5430,1407.3855,1084.4297);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 8);
			SetPlayerFacingAngle(playerid, 359.5516);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupballas[1])
	{
		if(PlayerInfo[playerid][pGang] == 2)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 2261.4043,-1020.9064,59.2785);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 226.6196);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupvagos[0])
	{
		if(PlayerInfo[playerid][pGang] == 3)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 318.5677,1116.8627,1083.8828);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 5);
			SetPlayerFacingAngle(playerid, 358.9016);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupvagos[1])
	{
		if(PlayerInfo[playerid][pGang] == 3)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 2261.4043,-1020.9064,59.2785);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 226.6196);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupaztecas[0])
	{
		if(PlayerInfo[playerid][pGang] == 4)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 224.3553,1240.0751,1082.1406);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 2);
			SetPlayerFacingAngle(playerid, 87.5759);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	if(pickupid == pickupaztecas[1])
	{
		if(PlayerInfo[playerid][pGang] == 4)
		{
			TogglePlayerControllable(playerid,false);
			SetPlayerPos(playerid, 2296.5432,-1885.4868,13.5964);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid, 0);
			SetPlayerFacingAngle(playerid, 171.4073);
			SetTimerEx("PlayerToggle", 700, false, "d", playerid);
			return true;
		}
		//else SendClientMessage(playerid, COLOR_WHITE,"У вас нет ключей от этой двери.");
	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
	TextDrawShowForPlayer(playerid, DamageBar);
    new
		string[10];
    format(string, sizeof(string), "-%d", floatround(Float:amount, floatround_ceil));
    TextDrawSetString(DamageBar, string);
    SetTimerEx("HideDamager", 1000, false, "i", playerid);/* Показываем HP противнику */

    if(Heart[damagedid] == 0)
	{
	    if(!IsPlayerAttachedObjectSlotUsed(damagedid, 1))/* Сердце над головой */
		{
	     	SetPlayerAttachedObject(damagedid, 1, 1240, 1, 0.877999, 0.034, 0.044999, 3.699995, 87.599967, 0.4, 1.0, 0.4820, 1.0, 0, 0);
	    	SetTimerEx("HeartTimer", 1000, false, "i", damagedid);
		}
	}
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	/* ХП игрока */
    new
		Float:Health;
    GetPlayerHealth(playerid,Health);
    new
		HealthHP[6];
	format(HealthHP,6,"%d",floatround(Health));
	TextDrawSetString(HealthBar[playerid], HealthHP);
	/*  - - - - - - - - - - - */
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 0: /* Авторизация */
	    {
	        if(response)
	        {
		        if(!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 15)
		        {
		            static const
						frm_string[] = "\
						{ffffff}Добро пожаловать на Monser Gang War!\n\
						Ваш Логин: {FFFF00}%s{ffffff}\n\n\
						Введите свой пароль, чтобы начать игру:\n\n\
						\t {FFFF00}-{ffffff} %i секунд\n\
						\t {FFFF00}-{ffffff} %i попытки{ffffff}";
					new
						string[sizeof(frm_string)-2-2+MAX_PLAYER_NAME-2+2-2+2];
					format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName], player_kick_time{playerid}, eror_password);
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_INPUT, "{FFFF00}Авторизация{ffffff}", string, "Войти", "Выход");
					return false;
		        }
		        if(!strcmp(PlayerInfo[playerid][pPassword], inputtext))
		        {
         			static const
						frm_string[] = "SELECT * FROM `accounts` WHERE `Name` = '%s'";
					new
						query_string[sizeof(frm_string)-2+MAX_PLAYER_NAME];
					format(query_string, sizeof(query_string), frm_string, PlayerInfo[playerid][pName]);
					mysql_function_query(connect_mysql, query_string, true, "LoadPlayerAccount", "i", playerid);
					ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "			", "\t{FFFF00}Выберите тип игры{FFFF00}\t", "GangWar", "DeathMatch");
		        }
		        else
		        {
		            eror_password --;
	  				if(eror_password == 0)
	  				{
	  				    SendClientMessage(playerid, -1, "Неверный пароль!");
	  				    Kick(playerid);
	  				}
	  				else
	  				{
						static const
							frm_string[] = "\
							{ffffff}Добро пожаловать на Monser Gang War!\n\
							Ваш Логин: {FFFF00}%s{ffffff}\n\n\
							Введите свой пароль, чтобы начать игру:\n\n\
							\t {FFFF00}-{ffffff} %i секунд\n\
							\t {FFFF00}-{ffffff} %i попытки{ffffff}";
						new
							string[sizeof(frm_string)-2-2+MAX_PLAYER_NAME-2+2-2+2];
						format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName], player_kick_time{playerid}, eror_password);
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_INPUT, "{FFFF00}Авторизация{ffffff}", string, "Войти", "Выход");
					}
		        }
			}
	    }
	    case 1: /* Регистрация */
	    {
	        if(!response) return Kick(playerid);
			if(response)
	        {
	            if(!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 16)
	            {
            		static const
						frm_string[] = "\
						{ffffff}Добро пожаловать на Monser GangWar!\n\
						Ваш Логин: {FFFF00}%s{ffffff}\n\n\
						Придумайте пароль от Вашего аккаунт:\n\n\
						\t{FFFF00}-{ffffff} Пароль должен быть чувствителен к регистру\n\
						\t{FFFF00}-{ffffff} Длина пароля состоять от 6 до 16 символов";
					new
						string[sizeof(frm_string)-2+MAX_PLAYER_NAME];
					format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName]);
					ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "{FFFF00}Регистрация{ffffff}", string, "Далее", "Выйти");
					return false;
	            }
            	for(new i = strlen(inputtext); i != 0; --i)
				switch(inputtext[i])
				{
					case 'А'..'Я', 'а'..'я', ' ':
					{
					    static const
							frm_string[] = "\
							{ffffff}Добро пожаловать на Monser GangWar!\n\
							Ваш Логин: {FFFF00}%s{ffffff}\n\n\
							Придумайте пароль от Вашего аккаунт:\n\n\
							\t{FFFF00}-{ffffff} Пароль должен быть чувствителен к регистру\n\
							\t{FFFF00}-{ffffff} Длина пароля состоять от 6 до 16 символов";
						new
							string[sizeof(frm_string)-2+MAX_PLAYER_NAME];
						format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName]);
						ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "{FFFF00}Регистрация{ffffff}", string, "Далее", "Выйти");
						SendClientMessage(playerid, -1, "В пароле не должны присутствовать русские символы!");
						return false;
					}

				}
	   			strins(PlayerInfo[playerid][pPassword], inputtext, 0, 30);
	            CreatePlayerAccount(playerid, PlayerInfo[playerid][pPassword]);
				static const
					frm_string[] = "\
					{ffffff}Добро пожаловать на Monser Gang War!\n\
					Ваш Логин: {FFFF00}%s{ffffff}\n\n\
					Введите свой пароль, чтобы начать игру:\n\n\
					\t {FFFF00}-{ffffff} 60 секунд\n\
					\t {FFFF00}-{ffffff} 3 попытки{ffffff}";

				new
					string[sizeof(frm_string)-2-2+MAX_PLAYER_NAME-2+2-2+2];
				format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName]);
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_INPUT, "{FFFF00}Авторизация{ffffff}", string, "Войти", "Выход");
	        }
	    }
		case 5:
		{
		    if(response) //Gang War
		    {
				TextDrawShowForPlayer(playerid, choose_skin_gw_one);
				TextDrawShowForPlayer(playerid, choose_skin_gw_two);
				TextDrawShowForPlayer(playerid, choose_skin_gw_three);
				TextDrawShowForPlayer(playerid, choose_skin_gw_four);
				TextDrawShowForPlayer(playerid, choose_skin_gw_five);
				TextDrawShowForPlayer(playerid, choose_skin_gw_six);
				TextDrawShowForPlayer(playerid, choose_skin_gw_seven);
				TextDrawShowForPlayer(playerid, choose_skin_gw_eight);
				TextDrawShowForPlayer(playerid, choose_skin_gw_nine);
				TextDrawShowForPlayer(playerid, choose_skin_gw_ten);
				TextDrawShowForPlayer(playerid, choose_skin_gw_eleven);
				
				TextDrawShowForAll(logotype_monser);
				TextDrawShowForAll(logotype_gang);
				TextDrawShowForAll(logotype_war);
				SelectTextDraw(playerid, 0xFFFF00AA);
				
				GameTextForPlayer(playerid, "~g~GROVE STREET", 2000, 4);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				SetPlayerCameraPos(playerid,2484.4568,-1666.8081,13.3330);
				SetPlayerCameraLookAt(playerid, 2479.4568,-1666.8081,13.3330);
				SetPlayerSkin(playerid, 105);
				SetPlayerPos(playerid, 2479.4568,-1666.8081,13.3330);
				TogglePlayerControllable(playerid, 0);
				new
					local_player_name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, local_player_name[playerid], MAX_PLAYER_NAME);
				if(strfind(local_player_name[playerid], "[GW]", true) != -1)
				{
					strdel(local_player_name[playerid], 0, 4);
					strins(local_player_name[playerid], "[GW]", 0, 24);
					SetPlayerName(playerid,	local_player_name[playerid]);
				}
				else
				{
				    strins(local_player_name[playerid], "[GW]", 0, 24);
					SetPlayerName(playerid,	local_player_name[playerid]);
				}
				SetPVarInt(playerid,"select_mode", 1);
		    }
		    else//Death Match
		    {
      			TextDrawShowForPlayer(playerid, choose_zone_one);
				TextDrawShowForPlayer(playerid, choose_zone_two);
				TextDrawShowForPlayer(playerid, choose_zone_three);
    			TextDrawShowForPlayer(playerid, choose_zone_four);
   			 	TextDrawShowForPlayer(playerid, choose_zone_five);
   			 	
 				TextDrawShowForAll(logotype_monser);
				TextDrawShowForAll(logotype_gang);
				TextDrawShowForAll(logotype_war);

				SelectTextDraw(playerid, 0xFFFF00AA);

				GameTextForPlayer(playerid, "~y~Death Match", 2000, 4);

				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid, -350.549407, 2170.905273, 61.047248);
				SetPlayerCameraPos(playerid, -354.549407, 2170.905273, 61.047248);
				SetPlayerCameraLookAt(playerid, -356.810791, 2175.022949, 59.335357);
				TogglePlayerControllable(playerid, 0);

				new
					local_player_name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, local_player_name[playerid], MAX_PLAYER_NAME);

				if(strfind(local_player_name[playerid], "[DM]", true) != -1)
				{
					strdel(local_player_name[playerid], 0, 4);
					strins(local_player_name[playerid], "[DM]", 0, 24);
					SetPlayerName(playerid,	local_player_name[playerid]);
				}
				else
				{
				    strins(local_player_name[playerid], "[DM]", 0, 24);
					SetPlayerName(playerid,	local_player_name[playerid]);
				}
				SetPVarInt(playerid,"select_mode", 2);
		    }
		}
		case 6:
		{
		    if(strval(inputtext) < 1 || strval(inputtext) > 311) return ShowPlayerDialog(playerid, 6, DIALOG_STYLE_INPUT, "{FFFF00}Выбор локации{ffffff}", "{ffffff}Введите номер локации от 1 до 100", "Далее", "");

		    if(response)
		    {
		        TextDrawHideForPlayer(playerid, choose_zone_one);
		  		TextDrawHideForPlayer(playerid, choose_zone_two);
		    	TextDrawHideForPlayer(playerid, choose_zone_three);
		     	TextDrawHideForPlayer(playerid, choose_zone_four);
		      	TextDrawHideForPlayer(playerid, choose_zone_five);

     			TextDrawShowForPlayer(playerid, choose_skin_one);
                TextDrawShowForPlayer(playerid, choose_skin_two);
                TextDrawShowForPlayer(playerid, choose_skin_three);
                TextDrawShowForPlayer(playerid, choose_skin_four);
                TextDrawShowForPlayer(playerid, choose_skin_five);
                TextDrawShowForPlayer(playerid, choose_skin_six);
                TextDrawShowForPlayer(playerid, choose_skin_seven);


		        SetPlayerVirtualWorld(playerid, strval(inputtext));

                if(IsPlayerInRangeOfPoint(playerid, 5.0, 1850.909057, -1163.629394, 50.242549)) // Deagle
                {
               		SpawnPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					GameTextForPlayer(playerid, "~y~SKIN", 2000, 4);
                    SetPlayerSkin(playerid, SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")+1));
					SetPlayerPos(playerid, 1966.7734,-1177.7377,20.0307);
					SetPlayerFacingAngle(playerid, 171.8607);
					SetPlayerCameraPos(playerid, 1966.158691, -1183.401855, 21.902816);
					SetPlayerCameraLookAt(playerid, 1966.847900, -1178.679931, 20.409858);
               	}
                if(IsPlayerInRangeOfPoint(playerid, 5.0, -354.549407, 2170.905273, 61.047248)) // DM
                {
                	SpawnPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					GameTextForPlayer(playerid, "~y~SKIN", 2000, 4);
                    SetPlayerSkin(playerid, SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")+1));
					SetPlayerPos(playerid, -288.5343,2177.5720,112.8697);
					SetPlayerFacingAngle(playerid, 226.1123);
					SetPlayerCameraPos(playerid, -284.299285, 2173.412353, 113.890808);
					SetPlayerCameraLookAt(playerid, -287.732971, 2176.956787, 113.086280);
                }
                if(IsPlayerInRangeOfPoint(playerid, 5.0, 1543.701171, 77.263519, 43.000572)) // ANTI +C
                {
               		SpawnPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
                    SetPlayerSkin(playerid, SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")+1));
					GameTextForPlayer(playerid, "~y~SKIN", 2000, 4);
					SetPlayerPos(playerid, 1560.7184,-42.9897,21.1547);
					SetPlayerFacingAngle(playerid, 180);
					SetPlayerCameraPos(playerid, 1560.459838, -50.185821, 22.036848);
					SetPlayerCameraLookAt(playerid, 1560.625854, -45.207065, 21.607362);
                }
		    }
		    else ShowPlayerDialog(playerid, 6, DIALOG_STYLE_INPUT, "{FFFF00}Выбор локации{ffffff}", "{ffffff}Введите номер локации от 1 до 100", "Далее", "");
		}
		case 7:
		{
		    if(response)
		    {
				if(strval(inputtext) > 299 || strval(inputtext) < 1) return ShowPlayerDialog(playerid, 7, DIALOG_STYLE_INPUT, "{FFFF00}Выбор скина", "{ffffff}Введите ID скина от 1 до 299", "Далее", "");
				PlayerInfo[playerid][pSkin] = strval(inputtext);

  				TextDrawHideForPlayer(playerid, choose_zone_one);
				TextDrawHideForPlayer(playerid, choose_zone_two);
				TextDrawHideForPlayer(playerid, choose_zone_three);
				TextDrawHideForPlayer(playerid, choose_zone_four);
				TextDrawHideForPlayer(playerid, choose_zone_five);

				TextDrawHideForPlayer(playerid, choose_skin_one);
		  		TextDrawHideForPlayer(playerid, choose_skin_two);
		  		TextDrawHideForPlayer(playerid, choose_skin_three);
		    	TextDrawHideForPlayer(playerid, choose_skin_four);
		     	TextDrawHideForPlayer(playerid, choose_skin_five);
		      	TextDrawHideForPlayer(playerid, choose_skin_six);
		       	TextDrawHideForPlayer(playerid, choose_skin_seven);
		       	CancelSelectTextDraw(playerid);
		       	TogglePlayerControllable(playerid, 1);

    			if(IsPlayerInRangeOfPoint(playerid, 5.0, 1966.7734,-1177.7377,20.0307)) // Deagle
    			{
   					SpawnPlayer(playerid);
					SetPVarInt(playerid, "system_zone", 1); // 1 - Deagle
	   			}
	     		if(IsPlayerInRangeOfPoint(playerid, 5.0, -288.5343,2177.5720,112.8697)) // DeathMatch
	      		{
	      			SpawnPlayer(playerid);
	            	SetPVarInt(playerid, "system_zone", 2); // 2 - DeathMatch

				}
		 		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1560.7184,-42.9897,21.1547)) // Anti +C
				{
	 				SpawnPlayer(playerid);
	            	SetPVarInt(playerid, "system_zone", 3); // 3 - Anti +C
			    }
			}
		}
		case 8:
		{
		    TextDrawHideForPlayer(playerid, choose_zone_one);
			TextDrawHideForPlayer(playerid, choose_zone_two);
			TextDrawHideForPlayer(playerid, choose_zone_three);
			TextDrawHideForPlayer(playerid, choose_zone_four);
			TextDrawHideForPlayer(playerid, choose_zone_five);

			TextDrawHideForPlayer(playerid, choose_skin_one);
 			TextDrawHideForPlayer(playerid, choose_skin_two);
  			TextDrawHideForPlayer(playerid, choose_skin_three);
    		TextDrawHideForPlayer(playerid, choose_skin_four);
     		TextDrawHideForPlayer(playerid, choose_skin_five);
      		TextDrawHideForPlayer(playerid, choose_skin_six);
       		TextDrawHideForPlayer(playerid, choose_skin_seven);

       		CancelSelectTextDraw(playerid);
	       	TogglePlayerControllable(playerid, 1);

		    if(response)
		    {
                SpawnPlayer(playerid);
		        PlayerInfo[playerid][pBand] = 3;

				new
					rand = random(2) +1;
				switch(rand)
				{
					case 0: PlayerInfo[playerid][pSkin] = 287;
					case 1: PlayerInfo[playerid][pSkin] = 179;
					case 2: PlayerInfo[playerid][pSkin] = 255;
				}
				printf("%i", rand);
		    }
			else
			{
  				SpawnPlayer(playerid);
		        PlayerInfo[playerid][pBand] = 4;
				new
					rand = random(4) + 1;
				switch(rand)
				{
					case 0: PlayerInfo[playerid][pSkin] = 285;
					case 1: PlayerInfo[playerid][pSkin] = 282;
					case 2: PlayerInfo[playerid][pSkin] = 267;
					case 3: PlayerInfo[playerid][pSkin] = 283;
					case 4: PlayerInfo[playerid][pSkin] = 284;
				}
			}
		}
	}
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	SetPlayerPos(playerid, fX, fY, fZ);
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == choose_skin_gw_seven)
	{
	    SetPVarInt(playerid, "choose_gangwar", GetPVarInt(playerid, "choose_gangwar")+1);
	    if(GetPVarInt(playerid, "choose_gangwar") > 3) SetPVarInt(playerid, "choose_gangwar", 0);
	    if(GetPVarInt(playerid, "choose_gangwar")==0)
		{
		    SetPVarInt(playerid, "system_choose_skin_gw", 0);
			TogglePlayerControllable(playerid, 0);
			GameTextForPlayer(playerid, "~g~GROVE STREET", 2000, 4);
			SetPlayerSkin(playerid, 105);
			SetPlayerPos(playerid, 2479.4568,-1666.8081,13.3330);
			SetPlayerCameraPos(playerid,2484.4568,-1666.8081,13.3330);
			SetPlayerCameraLookAt(playerid, 2479.4568,-1666.8081,13.3330);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
		}
	    if(GetPVarInt(playerid, "choose_gangwar")==1)
	    {
	        SetPVarInt(playerid, "system_choose_skin_gw", 1);
    		TogglePlayerControllable(playerid, 0);
    		GameTextForPlayer(playerid, "~p~THE BALLAS GANG", 2000, 4);
			SetPlayerSkin(playerid, 103);
			SetPlayerPos(playerid, 2010.1097,-1138.6997,25.1106);
			SetPlayerCameraPos(playerid, 2015.1097,-1138.6997,25.1106);
			SetPlayerCameraLookAt(playerid, 2010.1097,-1138.6997,25.1106);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
	    }
	    if(GetPVarInt(playerid, "choose_gangwar")==2)
	    {
	        SetPVarInt(playerid, "system_choose_skin_gw", 2);
    		TogglePlayerControllable(playerid, 0);
            GameTextForPlayer(playerid, "~y~LOS SANTOS VAGOS", 2000, 4);
            SetPlayerSkin(playerid, 108);
 			SetPlayerPos(playerid, 2847.3208,-1188.3119,24.6601);
			SetPlayerCameraPos(playerid, 2852.3208,-1188.3119,24.6601);
			SetPlayerCameraLookAt(playerid, 2847.3208,-1188.3119,24.6601);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
	    }
        if(GetPVarInt(playerid, "choose_gangwar")==3)
		{
		    SetPVarInt(playerid, "system_choose_skin_gw", 3);
            TogglePlayerControllable(playerid, 0);
            GameTextForPlayer(playerid, "~b~VARIOS LOS AZTECAS", 2000, 4);
            SetPlayerSkin(playerid, 114);
			SetPlayerPos(playerid, 1710.2845,-2115.8792,13.3828);
			SetPlayerCameraPos(playerid, 1715.2845,-2115.8792,13.3828);
			SetPlayerCameraLookAt(playerid, 1710.2845,-2115.8792,13.3828);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
  		}
	}
	if(clickedid == choose_skin_gw_six)
	{
	    SetPVarInt(playerid, "choose_gangwar", GetPVarInt(playerid, "choose_gangwar")-1);
     	if(GetPVarInt(playerid, "choose_gangwar") < 0)
	    {
     		SetPVarInt(playerid, "choose_gangwar", 3);
	    }
	    if(GetPVarInt(playerid, "choose_gangwar")==0)
		{
  			SetPVarInt(playerid, "system_choose_skin_gw", 0);
			TogglePlayerControllable(playerid, 0);
            SetPlayerSkin(playerid, 105);
			GameTextForPlayer(playerid, "~g~GROVE STREET", 2000, 4);
			SetPlayerPos(playerid, 2479.4568,-1666.8081,13.3330);
			SetPlayerCameraPos(playerid,2484.4568,-1666.8081,13.3330);
			SetPlayerCameraLookAt(playerid, 2479.4568,-1666.8081,13.3330);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
		}
	    if(GetPVarInt(playerid, "choose_gangwar")==1)
	    {
	    	SetPVarInt(playerid, "system_choose_skin_gw", 1);
    		TogglePlayerControllable(playerid, 0);
			SetPlayerSkin(playerid, 103);
    		GameTextForPlayer(playerid, "~p~THE BALLAS GANG", 2000, 4);
			SetPlayerPos(playerid, 2010.1097,-1138.6997,25.1106);
			SetPlayerCameraPos(playerid, 2015.1097,-1138.6997,25.1106);
			SetPlayerCameraLookAt(playerid, 2010.1097,-1138.6997,25.1106);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
	    }
	    if(GetPVarInt(playerid, "choose_gangwar")==2)
	    {
	    	SetPVarInt(playerid, "system_choose_skin_gw", 2);
    		TogglePlayerControllable(playerid, 0);
            SetPlayerSkin(playerid, 108);
            GameTextForPlayer(playerid, "~y~LOS SANTOS VAGOS", 2000, 4);
 			SetPlayerPos(playerid, 2847.3208,-1188.3119,24.6601);
			SetPlayerCameraPos(playerid, 2852.3208,-1188.3119,24.6601);
			SetPlayerCameraLookAt(playerid, 2847.3208,-1188.3119,24.6601);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
	    }
        if(GetPVarInt(playerid, "choose_gangwar")==3)
		{
		    SetPVarInt(playerid, "system_choose_skin_gw", 3);
            TogglePlayerControllable(playerid, 0);
            SetPlayerSkin(playerid, 114);
            GameTextForPlayer(playerid, "~b~VARIOS LOS AZTECAS", 2000, 4);
			SetPlayerPos(playerid, 1710.2845,-2115.8792,13.3828);
			SetPlayerCameraPos(playerid, 1715.2845,-2115.8792,13.3828);
			SetPlayerCameraLookAt(playerid, 1710.2845,-2115.8792,13.3828);
			SetPlayerFacingAngle(playerid, -90);
			SetPlayerInterior(playerid, 0);
  		}
	}
    if(clickedid == choose_zone_four)
	{
	    SetPVarInt(playerid, "choose_deathmatch", GetPVarInt(playerid, "choose_deathmatch")+1);
	    if(GetPVarInt(playerid, "choose_deathmatch") > 3)
	    {
        	SetPVarInt(playerid, "choose_deathmatch", 0);
	    }
	    if(GetPVarInt(playerid, "choose_deathmatch")==0)
		{
			SpawnPlayer(playerid);
			TogglePlayerControllable(playerid, 0);

			GameTextForPlayer(playerid, "~y~Death Match", 2000, 4);

			SetPlayerPos(playerid, -350.549407, 2170.905273, 61.047248);
			SetPlayerCameraPos(playerid, -354.549407, 2170.905273, 61.047248);
			SetPlayerCameraLookAt(playerid, -356.810791, 2175.022949, 59.335357);

		}
	    if(GetPVarInt(playerid, "choose_deathmatch")==1)
	    {
    		SpawnPlayer(playerid);
    		TogglePlayerControllable(playerid, 0);

    		GameTextForPlayer(playerid, "~y~Deagle", 2000, 4);

			SetPlayerPos(playerid, 1850.909057, -1163.629394, 50.242549);
			SetPlayerCameraPos(playerid, 1867.909057, -1163.629394, 50.242549);
			SetPlayerCameraLookAt(playerid, 1871.959716, -1165.643310, 48.112735);

	    }
	    if(GetPVarInt(playerid, "choose_deathmatch")==2)
	    {
   			SpawnPlayer(playerid);
    		TogglePlayerControllable(playerid, 0);

            GameTextForPlayer(playerid, "~y~ANTI +C", 2000, 4);

 			SetPlayerPos(playerid, 1543.701171, 77.263519, 43.000572);
			SetPlayerCameraPos(playerid, 1563.701171, 77.263519, 43.000572);
			SetPlayerCameraLookAt(playerid,  1562.938354, 72.580993, 41.421962);

	    }
        if(GetPVarInt(playerid, "choose_deathmatch")==3)
		{
 			SpawnPlayer(playerid);
            TogglePlayerControllable(playerid, 0);

            GameTextForPlayer(playerid, "~y~SNIPER", 2000, 4);

			SetPlayerPos(playerid, -570.500610, -197.223327, 89.152450);
			SetPlayerCameraPos(playerid, -580.500610, -197.223327, 89.152450);
			SetPlayerCameraLookAt(playerid,-576.742797, -194.312789, 87.600807);

		}

	}
	if(clickedid == choose_zone_three)
	{
	    SetPVarInt(playerid, "choose_deathmatch", GetPVarInt(playerid, "choose_deathmatch")-1);
     	if(GetPVarInt(playerid, "choose_deathmatch") < 0)
	    {
     		SetPVarInt(playerid, "choose_deathmatch", 3);
	    }
	    if(GetPVarInt(playerid, "choose_deathmatch")==0)
		{
		    SpawnPlayer(playerid);
			TogglePlayerControllable(playerid, 0);

			GameTextForPlayer(playerid, "~y~Death Match", 2000, 4);

			SetPlayerPos(playerid, -350.549407, 2170.905273, 61.047248);
			SetPlayerCameraPos(playerid, -354.549407, 2170.905273, 61.047248);
			SetPlayerCameraLookAt(playerid, -356.810791, 2175.022949, 59.335357);

		}
	    if(GetPVarInt(playerid, "choose_deathmatch")==1)
	    {
   			SpawnPlayer(playerid);
    		TogglePlayerControllable(playerid, 0);

			GameTextForPlayer(playerid, "~y~Deagle", 2000, 4);

			SetPlayerPos(playerid, 1850.909057, -1163.629394, 50.242549);
			SetPlayerCameraPos(playerid, 1867.909057, -1163.629394, 50.242549);
			SetPlayerCameraLookAt(playerid, 1871.959716, -1165.643310, 48.112735);

	    }
	    if(GetPVarInt(playerid, "choose_deathmatch")==2)
	    {
    		SpawnPlayer(playerid);
    		TogglePlayerControllable(playerid, 0);

			GameTextForPlayer(playerid, "~y~ANTI +C", 2000, 4);

			SetPlayerPos(playerid, 1543.701171, 77.263519, 43.000572);
			SetPlayerCameraPos(playerid, 1563.701171, 77.263519, 43.000572);
			SetPlayerCameraLookAt(playerid,  1562.938354, 72.580993, 41.421962);

	    }
	    if(GetPVarInt(playerid, "choose_deathmatch")==3)
		{
 			SpawnPlayer(playerid);
            TogglePlayerControllable(playerid, 0);

            GameTextForPlayer(playerid, "~y~SNIPER", 2000, 4);

			SetPlayerPos(playerid, -570.500610, -197.223327, 89.152450);
			SetPlayerCameraPos(playerid, -580.500610, -197.223327, 89.152450);
			SetPlayerCameraLookAt(playerid,-576.742797, -194.312789, 87.600807);
		}
	}
	if(clickedid == choose_zone_five)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, -570.500610, -197.223327, 89.152450))
		{
	 		ShowPlayerDialog(playerid, 8, DIALOG_STYLE_MSGBOX, "			", "\t{FFFF00}Выберите команду", "Армия", "Полиция");
            SetPVarInt(playerid, "system_zone", 4); // 3 - anti +c
		}
		else ShowPlayerDialog(playerid, 6, DIALOG_STYLE_INPUT, "{FFFF00}Выбор локации{FFFFFF}", "{FFFFFF}Введите номер локации от 1 до 100", "Далее", "");
	}
	if(clickedid == choose_skin_five)
	{
		new random_skin = random(311) + 1;
		if(random_skin == 74) random_skin ++;
		if(random_skin == 0) random_skin ++;

		TextDrawHideForPlayer(playerid, choose_zone_one);
		TextDrawHideForPlayer(playerid, choose_zone_two);
		TextDrawHideForPlayer(playerid, choose_zone_three);
		TextDrawHideForPlayer(playerid, choose_zone_four);
		TextDrawHideForPlayer(playerid, choose_zone_five);

		TextDrawHideForPlayer(playerid, choose_skin_one);
  		TextDrawHideForPlayer(playerid, choose_skin_two);
    	TextDrawHideForPlayer(playerid, choose_skin_three);
     	TextDrawHideForPlayer(playerid, choose_skin_four);
      	TextDrawHideForPlayer(playerid, choose_skin_five);
       	TextDrawHideForPlayer(playerid, choose_skin_six);
       	TextDrawHideForPlayer(playerid, choose_skin_seven);
       	CancelSelectTextDraw(playerid);
       	TogglePlayerControllable(playerid, 1);
       	PlayerInfo[playerid][pSkin] = random_skin;

  		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1966.7734,-1177.7377,20.0307)) // Deagle
    	{
			SpawnPlayer(playerid);
			SetPVarInt(playerid, "system_zone", 1); // 1 - Deagle;
   		}
     	if(IsPlayerInRangeOfPoint(playerid, 5.0, -288.5343,2177.5720,112.8697)) // DeathMatch
      	{
      		SpawnPlayer(playerid);
            SetPVarInt(playerid, "system_zone", 2); // 2 - DeathMatch
		}
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1560.7184,-42.9897,21.1547)) // Anti +C
		{
		    SpawnPlayer(playerid);
            SetPVarInt(playerid, "system_zone", 3); // 3 - Anti +C
		}
	}
	if(clickedid == choose_skin_six)
	{
		SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")+1);
		if(GetPVarInt(playerid, "system_choose_skin")== 74) SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")+1);
        if(GetPVarInt(playerid, "system_choose_skin")> 311) SetPVarInt(playerid, "system_choose_skin", 1);

        SetPlayerSkin(playerid, GetPVarInt(playerid, "system_choose_skin"));
        PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	}
	if(clickedid == choose_skin_seven)
	{
		SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")-1);
		if(GetPVarInt(playerid, "system_choose_skin")== 74) SetPVarInt(playerid, "system_choose_skin", GetPVarInt(playerid, "system_choose_skin")+1);
        if(GetPVarInt(playerid, "system_choose_skin") < 1) SetPVarInt(playerid, "system_choose_skin", 311);

        SetPlayerSkin(playerid, GetPVarInt(playerid, "system_choose_skin"));

        PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	}
	if(clickedid == choose_skin_gw_three)
	{
		TextDrawHideForPlayer(playerid, choose_skin_gw_one);
		TextDrawHideForPlayer(playerid, choose_skin_gw_two);
		TextDrawHideForPlayer(playerid, choose_skin_gw_three);
		TextDrawHideForPlayer(playerid, choose_skin_gw_four);
		TextDrawHideForPlayer(playerid, choose_skin_gw_five);
		TextDrawHideForPlayer(playerid, choose_skin_gw_six);
		TextDrawHideForPlayer(playerid, choose_skin_gw_seven);
		TextDrawHideForPlayer(playerid, choose_skin_gw_eight);
		TextDrawHideForPlayer(playerid, choose_skin_gw_nine);
		TextDrawHideForPlayer(playerid, choose_skin_gw_ten);
		TextDrawHideForPlayer(playerid, choose_skin_gw_eleven);
       	CancelSelectTextDraw(playerid);
       	TogglePlayerControllable(playerid, 1);
       	SpawnPlayer(playerid);
	}
	else if(clickedid == choose_skin_gw_four)
	{
	    if(GetPVarInt(playerid,"system_choose_skin_gw") == 0)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 0);
		    skingw[playerid]++;
		    if(skingw[playerid] > 6) skingw[playerid] = 0;
		    SetPlayerSkin(playerid,skingrove[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
		if(GetPVarInt(playerid,"system_choose_skin_gw") == 1)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 1);
		    skingw[playerid]++;
		    if(skingw[playerid] > 3) skingw[playerid] = 0;
		    SetPlayerSkin(playerid,skinballas[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
		if(GetPVarInt(playerid,"system_choose_skin_gw") == 2)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 2);
		    skingw[playerid]++;
		    if(skingw[playerid] > 3) skingw[playerid] = 0;
		    SetPlayerSkin(playerid,skinvagos[skingw[playerid]][0]);
		    return true;
		}
		if(GetPVarInt(playerid,"system_choose_skin_gw") == 3)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 3);
		    skingw[playerid]++;
		    if(skingw[playerid] > 4) skingw[playerid] = 0;
		    SetPlayerSkin(playerid,skinaztecas[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
	}
	else if(clickedid == choose_skin_gw_five)
	{
	    if(GetPVarInt(playerid,"system_choose_skin_gw") == 0)
		{
		    SetPVarInt(playerid, "choose_gangwar", 3);
		    skingw[playerid]--;
		    if(skingw[playerid] < 0) skingw[playerid] = 6;
		    SetPlayerSkin(playerid,skingrove[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
		if(GetPVarInt(playerid,"system_choose_skin_gw") == 1)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 2);
		    skingw[playerid]--;
		    if(skingw[playerid] < 0) skingw[playerid] = 3;
		    SetPlayerSkin(playerid,skinballas[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
		if(GetPVarInt(playerid,"system_choose_skin_gw") == 2)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 1);
		    skingw[playerid]--;
		    if(skingw[playerid] < 0) skingw[playerid] = 3;
		    SetPlayerSkin(playerid,skinvagos[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
		if(GetPVarInt(playerid,"system_choose_skin_gw") == 3)
	    {
	        SetPVarInt(playerid, "choose_gangwar", 0);
		    skingw[playerid]--;
		    if(skingw[playerid] < 0) skingw[playerid] = 4;
		    SetPlayerSkin(playerid,skinaztecas[skingw[playerid]][0]);
		    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		    return true;
		}
	}
	if(clickedid == choose_skin_four)
	{
		TextDrawHideForPlayer(playerid, choose_zone_one);
		TextDrawHideForPlayer(playerid, choose_zone_two);
		TextDrawHideForPlayer(playerid, choose_zone_three);
		TextDrawHideForPlayer(playerid, choose_zone_four);
		TextDrawHideForPlayer(playerid, choose_zone_five);

		TextDrawHideForPlayer(playerid, choose_skin_one);
  		TextDrawHideForPlayer(playerid, choose_skin_two);
  		TextDrawHideForPlayer(playerid, choose_skin_three);
    	TextDrawHideForPlayer(playerid, choose_skin_four);
     	TextDrawHideForPlayer(playerid, choose_skin_five);
      	TextDrawHideForPlayer(playerid, choose_skin_six);
       	TextDrawHideForPlayer(playerid, choose_skin_seven);
       	CancelSelectTextDraw(playerid);
       	TogglePlayerControllable(playerid, 1);

        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1966.7734,-1177.7377,20.0307)) // Deagle
    	{
   			SpawnPlayer(playerid);
			PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
			SetPVarInt(playerid, "system_zone", 1); // 1 - Deagle;
   		}
     	if(IsPlayerInRangeOfPoint(playerid, 5.0, -288.5343,2177.5720,112.8697)) // DeathMatch
      	{
      		SpawnPlayer(playerid);
            PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
            SetPVarInt(playerid, "system_zone", 2); // 2 - DeathMatch
		}
	 	if(IsPlayerInRangeOfPoint(playerid, 5.0, 1560.7184,-42.9897,21.1547)) // Anti +C
		{
 			SpawnPlayer(playerid);
            PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
            SetPVarInt(playerid, "system_zone", 3); // 3 - Anti +C
		}
	}
	if(clickedid == choose_skin_three) //Sniper
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, -570.500610, -197.223327, 89.152450))
		{
	 		ShowPlayerDialog(playerid, 8, DIALOG_STYLE_MSGBOX, "			", "Выберите команду", "Армия", "Полиция");
            SetPVarInt(playerid, "system_zone", 3); // 4 - Sniper
		}
		else
		{
		    CancelSelectTextDraw(playerid);
			ShowPlayerDialog(playerid, 7, DIALOG_STYLE_INPUT, "{FFFF00}Выбор скина", " {ffffff}Введите ID скина от 1 до 299", "Далее", "");
		}
	}
	return true;
}

/* Publick */
forward HideDamager(playerid);
public HideDamager(playerid)
	return TextDrawHideForPlayer(playerid, DamageBar);

forward UnfreezeBagouse(playerid);
public UnfreezeBagouse(playerid)
	return TogglePlayerControllable(playerid, 1);

forward ChooseLogotype(playerid);
public  ChooseLogotype(playerid)
{
	SetPVarInt(playerid, "next_logotype", GetPVarInt(playerid, "next_logotype")+1);

	if(GetPVarInt(playerid, "next_logotype") == 1)
	{
		TextDrawColor(logotype_monser, -65281);
		TextDrawColor(logotype_gang, -1);
		TextDrawColor(logotype_war, -1);

		TextDrawShowForAll(logotype_monser);
		TextDrawShowForAll(logotype_gang);
		TextDrawShowForAll(logotype_war);

	}
	if(GetPVarInt(playerid, "next_logotype") == 2)
	{
		TextDrawColor(logotype_monser, -1);
		TextDrawColor(logotype_gang, -65281);
		TextDrawColor(logotype_war, -1);

		TextDrawShowForAll(logotype_monser);
		TextDrawShowForAll(logotype_gang);
		TextDrawShowForAll(logotype_war);
	}
	if(GetPVarInt(playerid, "next_logotype") == 3)
	{
		TextDrawColor(logotype_monser, -1);
		TextDrawColor(logotype_gang, -1);
		TextDrawColor(logotype_war, -65281);

		TextDrawShowForAll(logotype_monser);
		TextDrawShowForAll(logotype_gang);
		TextDrawShowForAll(logotype_war);

	}
	if(GetPVarInt(playerid, "next_logotype") > 3)
	{
	   	SetPVarInt(playerid, "next_logotype", 0);
	}
}

forward fix_buttons(playerid);
public fix_buttons(playerid)
{
	SpawnPlayer(playerid);
	SetPlayerPos(playerid, 1855.2988,-1168.7986,51.8718);
	InterpolateCameraPos(playerid, 1849.279663, -1173.270019, 49.163814, 1899.455566, -1171.870727, 33.920963, 11000);
	InterpolateCameraLookAt(playerid, 1854.062133, -1173.136596, 47.710987, 1904.238037, -1171.737304, 32.468135, 1000);
}

forward IsFindAccountInTable(playerid);
public IsFindAccountInTable(playerid)
{
	new
		rows,
		fields;
	cache_get_data(rows, fields);
	if(rows)
	{
		for(new o; o < 20; o++) SendClientMessage(playerid, -1, "");
		SendClientMessage(playerid, COLOR_WHITE, "Добро пожаловать на \"{FFFF00}Monser Gang War ft. Death Match{FFFFFF}\".");
	 	if(strfind(PlayerInfo[playerid][pName], "[",  true)  != -1)
	    {
			SendClientMessage(playerid, COLOR_RED, "В нике не должно быть тэга [GW] или [DM]!");
			SetTimerEx("TKick", 1500, false, "i", playerid);
	    }
		static const
			frm_string[] = "\
			{ffffff}Добро пожаловать на Monser Gang War!\n\
			Ваш Логин: {FFFF00}%s{ffffff}\n\n\
			Введите свой пароль, чтобы начать игру:\n\n\
			\t {FFFF00}-{ffffff} 60 секунд\n\
			\t {FFFF00}-{ffffff} 3 попытки{ffffff}";
		new
			string[sizeof(frm_string)-2+MAX_PLAYER_NAME-2+2];
		format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName],SetPVarInt(playerid, "wrongPass", 3));
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_INPUT, "{FFFF00}Авторизация{ffffff}", string, "Войти", "Выход");
		cache_get_field_content(0, "Password", PlayerInfo[playerid][pPassword], connect_mysql, 30);
	}
	else
	{
		for(new o; o < 20; o++) SendClientMessage(playerid, -1, "");
		SendClientMessage(playerid, COLOR_WHITE, "Добро пожаловать на \"{FFFF00}Monser Gang War ft. Death Match{FFFFFF}\".");
	 	if(strfind(PlayerInfo[playerid][pName], "[",  true)  != -1)
	    {
			SendClientMessage(playerid, COLOR_RED, "В нике не должно быть тэга [GW] или [DM]!");
			SetTimerEx("TKick", 1500, false, "i", playerid);
	    }
		static const
			frm_string[] = "\
			{ffffff}Добро пожаловать на Monser GangWar!\n\
			Ваш Логин: {FFFF00}%s{ffffff}\n\n\
			Придумайте пароль от Вашего аккаунт:\n\n\
			\t{FFFF00}-{ffffff} Пароль должен быть чувствителен к регистру\n\
			\t{FFFF00}-{ffffff} Длина пароля состоять от 6 до 16 символов";
		new
			string[sizeof(frm_string)-2+MAX_PLAYER_NAME];
		format(string, sizeof(string), frm_string, PlayerInfo[playerid][pName]);
		ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "{FFFF00}Регистрация{ffffff}", string, "Далее", "Выйти");

	}
}

forward PlayerBan(playerid);
public PlayerBan(playerid)
{
    new rows,
		rows2;
	cache_get_data(rows, rows2);
	if(rows)
	{
		date_unlock[playerid] = cache_get_field_content_int(0, "UnBanDate");
		if(gettime() > date_unlock[playerid])
		{
		    static const
				fmt_str[] = "DELETE FROM `ban` WHERE `Name` = '%s'";
			new
				string[sizeof(fmt_str)-2+MAX_PLAYER_NAME+1];
		    format(string, sizeof(string), fmt_str, PlayerInfo[playerid][pName]);
		    mysql_function_query(connect_mysql, string, false, "", "");
		}
		else
		{
		    static const
				fmt_str[] = "{FFFF00}Ваш аккаунт заблокирован!\nДата вашей разблокировки: {FFFFFF}%s";
			new
				string[sizeof(fmt_str)-2+13];
		    format(string, sizeof(string), fmt_str, date("%dd/%mm/%yyyy", date_unlock[playerid]));
		    ShowPlayerDialog(playerid, 1337, DIALOG_STYLE_MSGBOX, "Бан", string, "Ок", "");
      		SetTimerEx("TKick", 1000, false, "i", playerid);
		}
	}
	return true;
}

forward TKick(playerid);
	public TKick(playerid) return Kick(playerid);

forward LoadPlayerAccount(playerid);
public LoadPlayerAccount(playerid)
{
    PlayerInfo[playerid][pID] = cache_get_field_content_int(0, "ID",connect_mysql);
	cache_get_field_content(0, "InvitePlayer", PlayerInfo[playerid][pInvitePlayer], connect_mysql, 24);
	cache_get_field_content(0, "Email", PlayerInfo[playerid][pEmail], connect_mysql, 60);
	PlayerInfo[playerid][pKill] = cache_get_field_content_int(0, "Kill",connect_mysql);
	PlayerInfo[playerid][pDeath] = cache_get_field_content_int(0, "Death",connect_mysql);
    player_kick_time{playerid} = 0;
    player_logins{playerid} = true;
	SendClientMessage(playerid, COLOR_WHITE, "{5AB200}Вы успешно авторизовались!");
}

forward PlayerToggle(playerid);
	public PlayerToggle(playerid) return TogglePlayerControllable(playerid,true);

/*  - - - - - - - - - - - */

/* Stock */
stock AntiCaps(text [], i = 1)
{
    do
    {
        switch (text [i - 1] )
        {
            case 'А'..'я', 'A'..'z':
            {
                text [i] = tolower(text[i]);
            }
        }
        ++ i;
    }
    while (text [i] );
    return text;
}

stock CreatePlayerAccount(playerid, password[])
{
	static const
	    frm_string[] = "INSERT INTO `accounts` (`Name`, `Password`) VALUES ('%s', '%s')";
	new
		query_string[sizeof(frm_string)-4+30];
	format(query_string, sizeof(query_string), frm_string, PlayerInfo[playerid][pName], password);
 	mysql_query(connect_mysql, query_string);
	static const
		frm_string1[] = "SELECT * FROM `accounts` WHERE `Name` = '%s'";
	new
		query_string1[sizeof(frm_string1)-2+MAX_PLAYER_NAME];
	format(query_string1, sizeof(query_string1), frm_string1, PlayerInfo[playerid][pName]);
	mysql_query(connect_mysql, query_string1);
    PlayerInfo[playerid][pID] = cache_get_field_content_int(0, "ID",connect_mysql);
	static const
		frm_string_1[] = "\
		{00BFFF}Ваш номер аккаунта: {5AB200}%d {CFCFCF}(сохраните его, записав или сделав скриншот на клавишу F8)";
	new
		string_1[sizeof(frm_string_1)-2+10+128];
	format(string_1, sizeof(string_1), frm_string_1, PlayerInfo[playerid][pID]);
	SendClientMessage(playerid, -1, "{5AB200}Вы успешно зарегистрировались!");
	SendClientMessage(playerid, -1, string_1);
	SendClientMessage(playerid, -1, "{00BFFF}В будущем он Вам понадобится при восстановлении доступа к аккаунту");
}

stock ProxDetectorNew(Float: range, playerid, string[], color = -1)
{
    new
        Float: x,
        Float: y,
        Float: z,
        i = GetMaxPlayers(),
        world = GetPlayerVirtualWorld(playerid);

    GetPlayerPos(playerid, x, y, z);

    do
    {
        if(0 == IsPlayerConnected(--i)
        || world != GetPlayerVirtualWorld(i)
        || GetPlayerDistanceFromPoint(i, x, y, z) > range)
            continue;

        SendClientMessage(i, color, string);
    }
    while(i > 0);
    return 1;
}

stock clear_playerinfo(playerid)
{
	PlayerInfo[playerid][pName][0] = 0;
	PlayerInfo[playerid][pPassword][0] = 0;
	PlayerInfo[playerid][pInvitePlayer][0] = 0;
	PlayerInfo[playerid][pEmail][0] = 0;
	PlayerInfo[playerid][pBand] = 0;
	PlayerInfo[playerid][pGang] = 0;
}

stock Cars()
{
	/* Grove Cars */
	/*cargrove[0] = AddStaticVehicleEx(596,1595.6506,-1711.8431,5.6183,359.8867,209,1,900);
	AddStaticVehicleEx(596,1591.7241,-1711.8275,5.6235,359.8774,209,1,900); 
	AddStaticVehicleEx(596,1587.4192,-1711.8121,5.6188,359.3947,209,1,900); 
	AddStaticVehicleEx(596,1583.4957,-1711.8350,5.5571,0.8552,209,1,900); 
	AddStaticVehicleEx(596,1578.6215,-1711.8555,5.6216,0.8517,209,1,900); 
	AddStaticVehicleEx(596,1574.6592,-1711.8396,5.6250,0.0291,209,1,900); 
	AddStaticVehicleEx(596,1570.1732,-1711.8813,5.5593,0.0281,209,1,900); 
	AddStaticVehicleEx(596,1564.6235,-1711.8700,6.0872,359.2119,209,1,900); 
	AddStaticVehicleEx(596,1558.6179,-1711.8911,5.5346,359.9999,209,1,900);
	AddStaticVehicleEx(599,1546.8105,-1662.9476,6.0823,89.9610,209,1,900); 
	cargrove[1] = AddStaticVehicleEx(427,1529.0786,-1683.8983,6.0236,270.4686,209,1,900);*/
	/* Ballas Cars */
	/* Vagos Cars */
	/* Aztecas Cars */
}
stock Label()
{
    //Create3DTextLabel("{FFD700}Дровосек{FFFFFF}", 0xFFFFFFFF, -2333.9763, -1660.4789, 483.7031, 20.0, 0, 1);
	/* Grove Label */
	/* Ballas Label */
	/* Vagos Label */
	/* Aztecas Label */
}
stock MapIcon()
{
    //CreateDynamicMapIcon(-2333.9763, -1660.4789, 483.7031, 52, COLOR_WHITE, -1, -1, -1, 1000.0);
	/* Grove MapIcon */
	/* Ballas MapIcon */
	/* Vagos MapIcon */
	/* Aztecas MapIcon */
}
stock Pickups()
{
	pickupgrove[0] = CreatePickup(1559,23,2523.1724,-1679.3020,15.4970,1);/* Grove Pickups */
	pickupgrove[1] = CreatePickup(1559,23,2468.7390,-1698.3080,1013.5078, -1);/* Grove Pickups */
	pickupballas[0] = CreatePickup(1559,23,-42.5580,1405.4724,1084.4297,1);/* Ballas Pickups */
	pickupballas[1] = CreatePickup(1559,23,2408.4783,-1676.7811,1016.0280, -1);/* Ballas Pickups */
	pickupvagos[0] = CreatePickup(1559,23,2259.4805,-1019.1956,59.2965,1);/* Vagos Pickups */
	pickupvagos[1] = CreatePickup(1559,23,318.5500,1114.5664,1083.8828, -1);/* Vagos Pickups */
	pickupaztecas[0] = CreatePickup(1559,23,2296.5164,-1882.0416,14.2344,1);/* Aztecas Pickups */
	pickupaztecas[1] = CreatePickup(1559,23,226.7860,1239.9669,1082.1406, -1);/* Aztecas Pickups */
}
/*  - - - - - - - - - - - */


/* Команды на сервере */

CMD:aint(playerid, params[])
{
    if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, COLOR_GRAY,"Используйте: /aint [Номер]");
    return SetPlayerInterior(playerid, params[0]);
}
CMD:avirt(playerid, params[])
{
    if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, COLOR_GRAY,"Используйте: /avirt [Номер]");
    return SetPlayerVirtualWorld(playerid, params[0]);
}
CMD:o(playerid, params[])
{
	if(sscanf(params, "s[128]", params[0])) return SendClientMessage(playerid, -1, "Информация: /o [текст]");
    AntiCaps(params[0]);
	static const
	    frm_string[] = "{66ff00}[O]{ffffff} {%06x}%s {66ff00}[ID:%i]{ffffff}: %s";
	new
		string[sizeof(frm_string)-4+6-2+MAX_PLAYER_NAME-2+3-2+128];
	format(string, sizeof(string), frm_string, GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][pName], playerid, params[0]);
	SendClientMessageToAll(-1, string);
	return true;
}
CMD:choosedm(playerid)
{
	TextDrawShowForPlayer(playerid, choose_zone_one);
	TextDrawShowForPlayer(playerid, choose_zone_two);
	TextDrawShowForPlayer(playerid, choose_zone_three);
	TextDrawShowForPlayer(playerid, choose_zone_four);
	TextDrawShowForPlayer(playerid, choose_zone_five);

	SelectTextDraw(playerid, 0xFFFF00AA);
	GameTextForPlayer(playerid, "~y~Death Match", 2000, 4);

	SpawnPlayer(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, -350.549407, 2170.905273, 61.047248);
	SetPlayerCameraPos(playerid, -354.549407, 2170.905273, 61.047248);
	SetPlayerCameraLookAt(playerid, -356.810791, 2175.022949, 59.335357);
	TogglePlayerControllable(playerid, 0);

	PlayerInfo[playerid][pSkin] = 0;
   	DeletePVar(playerid, "choose_gangwar");
   	DeletePVar(playerid, "system_choose_skin_gw");
   	DeletePVar(playerid, "choose_deathmatch");
   	DeletePVar(playerid, "system_zone");
   	DeletePVar(playerid, "system_choose_skin");
   	DeletePVar(playerid, "army_or_police");
	return true;
}
CMD:choosegw(playerid)
{
	TextDrawShowForPlayer(playerid, choose_skin_gw_one);
	TextDrawShowForPlayer(playerid, choose_skin_gw_two);
	TextDrawShowForPlayer(playerid, choose_skin_gw_three);
	TextDrawShowForPlayer(playerid, choose_skin_gw_four);
	TextDrawShowForPlayer(playerid, choose_skin_gw_five);
	TextDrawShowForPlayer(playerid, choose_skin_gw_six);
	TextDrawShowForPlayer(playerid, choose_skin_gw_seven);
	TextDrawShowForPlayer(playerid, choose_skin_gw_eight);
	TextDrawShowForPlayer(playerid, choose_skin_gw_nine);
	TextDrawShowForPlayer(playerid, choose_skin_gw_ten);
	TextDrawShowForPlayer(playerid, choose_skin_gw_eleven);

	SelectTextDraw(playerid, 0xFFFF00AA);

	GameTextForPlayer(playerid, "~g~GROVE STREET", 2000, 4);
	SetPlayerCameraPos(playerid,2484.4568,-1666.8081,13.3330);
	SetPlayerCameraLookAt(playerid, 2479.4568,-1666.8081,13.3330);
	SetPlayerSkin(playerid, 105);
	SetPlayerPos(playerid, 2479.4568,-1666.8081,13.3330);
	TogglePlayerControllable(playerid, 0);

   	DeletePVar(playerid, "choose_gangwar");
   	DeletePVar(playerid, "system_choose_skin_gw");
   	DeletePVar(playerid, "choose_deathmatch");
   	DeletePVar(playerid, "system_zone");
   	DeletePVar(playerid, "system_choose_skin");
   	DeletePVar(playerid, "army_or_police");
	return true;
}
CMD:help(playerid)
{
	ShowPlayerDialog(playerid, 1337, DIALOG_STYLE_MSGBOX, "{FFFF00}Список команд", "\
	{5AB200}/f {FFFFFF}- чат банды\n\
	{5AB200}/o {FFFFFF}- общий чат\n\
	{5AB200}/id {FFFFFF}- найти игрока\n\
	{5AB200}/mask {FFFFFF}- надеть маску\n\
	{5AB200}/radio {FFFFFF}- радио рекорд\n\
	{5AB200}/menu {FFFFFF}- меню игрока\n\
	{5AB200}/scar {FFFFFF}- заспавнить авто\n\
	{5AB200}/time {FFFFFF}- посмотреть время\n\
	{5AB200}/animlist {FFFFFF}- список анимаций\n\
	{5AB200}/giveheal {FFFFFF}- передать аптечку\n\
	{5AB200}/sms {FFFFFF}- отправить сообщение\n\
	{5AB200}/capture {FFFFFF}- начать захват терры\n\
	{5AB200}/leaders {FFFFFF}- лидеры банд онлайн\n\
	{5AB200}/healme {FFFFFF}- использовать аптечку\n\
	{5AB200}/healme {FFFFFF}- использовать аптечку\n\
	{5AB200}/members {FFFFFF}- члены банды онлайн\n\
	{5AB200}/unlead {FFFFFF}- покинуть лидерство", "Ок", "Назад");
	return true;
}
CMD:menu(playerid)
{
	if(GetPVarInt(playerid,"select_mode") == 1) ShowPlayerDialog(playerid, 9, DIALOG_STYLE_LIST, "{FFFF00}Меню игрока", "1) Статистика\n2) Перейти на другую зону\n3) Перейти на {FFFF00}Death Match\n{FFFFFF}4) Топ лучших\n5) Топ худших\n6) Список команд\n7) Связь с администрацией\n8) Личные настройки\n9) Безопасность\n10) Донат", "Выбрать", "Выход");
	else ShowPlayerDialog(playerid, 9, DIALOG_STYLE_LIST, "{FFFF00}Меню игрока", "1) Статистика\n2) Перейти за другую банду\n3) Перейти на {FFFF00}Gang War\n{FFFFFF}4) Топ лучших\n5) Топ худших\n6) Список команд\n7) Связь с администрацией\n8) Личные настройки\n9) Безопасность\n10) Донат", "Выбрать", "Выход");
	return true;
}
ALTX:menu("/mm");
CMD:ban(playerid, params[])
{
    if(sscanf(params, "iis[128]", params[0], params[1], params[2])) return
		SendClientMessage(playerid, COLOR_GRAY, "Используйте: /ban [id] [Дни] [Причина]");
    if(!IsPlayerConnected(params[0]))
		return SendClientMessage(playerid, COLOR_GRAY, "Данный игрок не находиться в игре.");
	if(player_logins[params[0]] == false)
		return SendClientMessage(playerid, COLOR_GRAY, "Данный игрок не авторизован в игре.");
	if(params[1] < 1 || params[1] > 30)
		return SendClientMessage(playerid, COLOR_GRAY, "Количество дней не должно быть меньше 1-го или больше 30-ти");
    static const
		fmt_str[] = "Администратор %s забанил игрока %s на %d дней. Причина: %s";
	new
		string[sizeof(fmt_str)-2+MAX_PLAYER_NAME-2+MAX_PLAYER_NAME-2+2-2+36];
	format(string, sizeof(string), fmt_str, PlayerInfo[playerid][pName], PlayerInfo[params[0]][pName], params[1], params[2]);
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	static const
		fmt_str_2[] = "INSERT INTO `ban` (`Name`, `UnBanDate`) VALUES ('%s', '%d')";
	new
		string_2[sizeof(fmt_str_2)-2+MAX_PLAYER_NAME-2+9];
	format(string_2, sizeof(string_2), fmt_str_2, PlayerInfo[params[0]][pName], gettime() + 86400*params[1]);
	mysql_function_query(connect_mysql, string_2, false, "", "");
	SetTimerEx("TKick", 1000, false, "i", params[0]);
	return true;
}
CMD:heart(playerid)
{
	if (!Heart[playerid]) Heart[playerid] = 1,  SendClientMessage(playerid, COLOR_GRAY, "Сердце над головой выключено!");
	else if (Heart[playerid]) Heart[playerid] = 0, SendClientMessage(playerid, COLOR_GRAY, "Сердце над головой включено!");
	return true;
}
/*CMD:ahelp(playerid, params[])
{
	if(GetPVarInt(playerid,"Admins") < 1 || !GetPVarInt(playerid,"AdminLogin")) return true;
	switch(GetPVarInt(playerid,"Admins"))
	{
		case 1:
		{
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /jail, /slap, /(o)oc, /tp, /hp, /aad");
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /kick, /pm, /mute, /(a)dmin, /admins");
		}
		case 2:
		{
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /jail, /slap, /(o)oc, /tp, /hp, /aad");
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /kick, /pm, /mute, /(a)dmin, /admins");
			SendClientMessage(playerid, 0xFFFF00AA, "[2 уровень]: /sp, /gm, /goto, /ban, /warn, /recon, /skin");
		}
		case 3:
		{
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /jail, /slap, /(o)oc, /tp, /hp, /aad");
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /kick, /pm, /mute, /(a)dmin, /admins");
			SendClientMessage(playerid, 0xFFFF00AA, "[2 уровень]: /sp, /gm, /goto, /ban, /warn, /recon, /skin");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /freeze, /unfreeze, /noooc /veh /delveh, /agetstat, /getip");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /gethere, /setname /spcar, /banip, /unbanip, /spcars");
		}
		case 4:
		{
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /jail, /slap, /(o)oc, /tp, /hp, /aad");
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /kick, /pm, /mute, /(a)dmin, /admins");
			SendClientMessage(playerid, 0xFFFF00AA, "[2 уровень]: /sp, /gm, /goto, /ban, /warn, /recon, /skin");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /freeze, /unfreeze, /noooc /veh /delveh, /agetstat, /getip");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /gethere, /setname /spcar, /banip, /unbanip, /spcars");
			SendClientMessage(playerid, 0xFFFF00AA, "[4 уровень]: /givegun, /sethp, /weather, /unban");
			SendClientMessage(playerid, 0xFFFF00AA, "[4 уровень]: /cc, /unwarn, /uval, /makeleader");
		}
		case 5:
		{
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /jail, /slap, /(o)oc, /tp, /hp, /aad");
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /kick, /pm, /mute, /(a)dmin, /admins");
			SendClientMessage(playerid, 0xFFFF00AA, "[2 уровень]: /sp, /gm, /goto, /ban, /warn, /recon, /skin");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /freeze, /unfreeze, /noooc /veh /delveh, /agetstat, /getip");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /gethere, /setname /spcar, /banip, /unbanip, /spcars");
			SendClientMessage(playerid, 0xFFFF00AA, "[4 уровень]: /givegun, /sethp, /weather, /unban");
			SendClientMessage(playerid, 0xFFFF00AA, "[4 уровень]: /cc, /unwarn, /uval, /makeleader");
			SendClientMessage(playerid, 0xFFFF00AA, "[5 уровень]: /gzcolor, /fuelcars");
			SendClientMessage(playerid, 0xFFFF00AA, "[5 уровень]: /setmats");
		}
		case 6:
		{
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /jail, /slap, /(o)oc, /tp, /hp, /aad");
			SendClientMessage(playerid, 0xFFFF00AA, "[1 уровень]: /kick, /pm, /mute, /(a)dmin, /admins");
			SendClientMessage(playerid, 0xFFFF00AA, "[2 уровень]: /sp, /gm, /goto, /ban, /warn, /recon, /skin");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /freeze, /unfreeze, /noooc /veh /delveh, /agetstat, /getip");
			SendClientMessage(playerid, 0xFFFF00AA, "[3 уровень]: /gethere, /setname /spcar, /banip, /unbanip, /spcars");
			SendClientMessage(playerid, 0xFFFF00AA, "[4 уровень]: /givegun, /sethp, /weather, /unban");
			SendClientMessage(playerid, 0xFFFF00AA, "[4 уровень]: /cc, /unwarn, /uval, /makeleader");
			SendClientMessage(playerid, 0xFFFF00AA, "[5 уровень]: /gzcolor, /fuelcars");
			SendClientMessage(playerid, 0xFFFF00AA, "[5 уровень]: /setmats");
			SendClientMessage(playerid, 0xFFFF00AA, "[6 уровень]: /setstat, /givemonay, /offadmin, /dellaccount");
			SendClientMessage(playerid, 0xFFFF00AA, "[6 уровень]: /setbizprod, /makeadmin, /saveall /payday");
		}
	return true;
}
CMD:admins(playerid)
{
	SCM(playerid, COLOR_GREEN, "Администраторы онлайн:");
	static const fmt_str[] = "Администратор %d уровня %s[ID:%d]";
	foreach(new i: Player)
	{
	    if(player[i][pAdmin] > 0)
	    {
			new string[sizeof(fmt_str)-2+MAX_PLAYER_NAME-2+3-2+1];
	        format(string, sizeof(string), fmt_str, PlayerInfo[i][pAdmin], PlayerInfo[i][pName], i);
	        SCM(playerid, COLOR_WHITE, string);
	    }
	}
	SCM(playerid, COLOR_GREEN, "*******");
	return true;
}*/
/*  - - - - - - - - - - - */

/* by LONDLEM */
@__login_timer();
@__login_timer()
{
    new
        i = GetMaxPlayers()
	;
    do
    {
        --i;
        if(IsPlayerConnected(i) && player_kick_time{i} != 0 && --player_kick_time{i} == 0)
        {
            SendClientMessage(i, -1, "{FF6347}Время на авторизацию вышло!");
           	SetTimerEx("TKick", 1000, false, "i", i);
        }
    }
    while(i);
}
/*  - - - - - - - - - - - */
