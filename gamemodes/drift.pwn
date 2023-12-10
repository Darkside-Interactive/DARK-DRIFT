#include <a_samp>
/*---------------------------------------------------------------*/
#undef 	MAX_PLAYERS
#define MAX_PLAYERS     900
/*---------------------------------------------------------------*/
//Онлайн в списке кланов
//#define OSNOVNOI_SERV
#pragma dynamic 7000

/*---------------------------------------------------------------*/
#include <streamer>
#include <sscanf2>
#include <zcmd>
#include <a_mysql>
#include <dopinc>
//#include <mSelection>
#include <a_wcEx>
#if defined OSNOVNOI_SERV
//#include <antiattack>
#endif
enum CamInfo{
	Float:StartX,
	Float:StartY,
	Float:StartZ,
	Float:FinishX,
	Float:FinishY,
	Float:FinishZ
}
new const Cams[3][CamInfo]={
	{2057.972900,857.365722,33.937778,2057.710449,1642.119995,36.535976},//finish_1
	{1333.409301,-1144.964111,43.899951,818.639404,-1144.652954,40.484306}, //finish_2
	{-2003.782226,1029.583251,72.096122,-2006.270996,40.261085,42.102680} //finish_3
};
enum clInfo{
	cKey,
	cCreator,
	cPlayers,
Float:cCordBase[3],
	cTag[7],
	cColour,
	cTypeSkobok,
	cRate,
	cMoney,
	bool:cPrivate,
	cRate1[13],
	cRate2[13],
	cRate3[13],
	cRate4[13],
	cRate5[13],
	cMaxMoneys[6],
	cInvite[6],
	cKick[6],
	cRangUP[6]
};
new ClanInfo[MAX_CLANS][clInfo];
/*---------------------------------------------------------------*/
new RecorderName[3][MAX_PLAYER_NAME],
	RecordSkolk[2],
	Float:RecordKoeff;
enum DDInfoEx{
	rRaceStatus = 0,
	rRacer[2],
	rTrackID,
	rPoints[2],
	rTime,
	rPrize,
	DDcars[2],
	rWinner
};
new DDInfo[MAX_RACE][DDInfoEx];
enum rcInfo{
	Record,
	RecordsmanUID,
	Recordsman[MAX_PLAYER_NAME]
};
new RaceInfo[RACE_TRACKS][rcInfo];
enum sPostitions{
	Float:startX,
	Float:startY,
	Float:startZ,
	Float:startA,
	rName[25],
	rNameEn[25],
	bool:rChecks
};
new const Starts[RACE_TRACKS][sPostitions]={
	{-302.7044,1510.9312,75.0178,181.7456,	"Ухо [1]\t\t","Ear [1]"}, // start_drift1
	{-2426.5303,-603.8752,132.2197,36.0593,	"Холм [2]\t","Hill [2]" }, // start_drift2
	{-1566.0450,272.5009,6.8463,272.7201,	"Военная база [4]","Military base [4]"}, // start_drift4
	{2330.2727,1399.3290,42.4799,358.1284,	"Открытая парковка [5]","Open parking [5]"}, // start_drift5
	{-2283.0215,1869.1157,1.6579,60.9128,	"Гоночный остров [9]","Racing island [9]"}, // start_drift9
	{1435.2474,1465.4468,10.4806,267.4537,	"Аэропорт [10]\t","Airport [10]"}, // start_drift10
	{1802.3326,-2813.1934,2.6579,87.9484,	"Гоночный остров [11]","Racing island [11]"}, // start_drift11
	{-2895.3684,1618.7184,12.3036,318.2918,	"Гоночный остров [12]","Racing island [12]"}, // start_drift12
	{1116.3909,-1400.5203,13.1057,269.8989,	"Фристайл [1]\t","Freestyle [1]"}, // free1
	{-1856.0066,925.1449,34.6461,269.5643,	"Фристайл [2]\t","Freestyle [2]"}, // free2
	{2350.2856,1987.3611,10.3103,0.2776,	"Фристайл [3]\t","Freestyle [3]"}
};
new Text:CarColorTX[256];
new Text:CarColorFon;
new Text:ColorKeyBuy;
new Text:ColorKeyCancel;
new UsedColorSlot[MAX_PLAYERS],
	UsedColorID[MAX_PLAYERS],
	ShowStirLock[MAX_PLAYERS];
new const VehicleColoursTableRGBA[256] = {
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
	0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
	0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
	0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
	0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
	0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
	0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
	0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
	0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
	0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
	0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
	0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
	0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
	0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};
#define DIALOG_RULES 234
new const rules_drag[][] = {
	{"\t\t{ffffffПравила мероприятия - ДРАГ\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование читов, клео-скриптов и прочего,что дает преимущество над игроками.\nПокидать место соревнований, кататься по трассе.\n/Оставлять транспорт на дороге, тем самым мешая другим игрокам.\nВыбрасывать другого игрока из авто.\nОскорблять участников мероприятия.\n/Препятствовать проезду другого участника,тем самым мешая ему.\nПодсуживание друзьям, соклановцам и т.д. \nУгрожать сопернику.\nУчаствовать 2-ой раз в этапе."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffВнимательно следить за чатом, смотреть что скажет организатор.\nНе отходить от компьютера(AFK).\nБыть адекватным.\nЖдать своей очереди.\nКак вас вызвал организатор,незамедлительно встать на старт.\nДо конца мероприятия быть на одном  и том же авто, котором сказал организатор."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПросить РР (Рестарт), если 2-ой игрок согласен.\nПокидать МП и перезаходить в игру, но перед этим предупредить организатора.\nОтдать победу, если есть желание.\nС разрешения организатора, вы можете изучить трассу."}
};
new const rules_drift[][] = {
	{"\t\t{ffffffПравила мероприятия - ДРИФТ\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование читов, клео-скриптов и прочего,что дает преимущество над игроками.\nПокидать место соревнований, кататься по трассе.\nОставлять транспорт на дороге, тем самым мешая другим игрокам.\nВыбрасывать другого игрока из авто.\nОскорблять участников мероприятия.\nПрепятствовать проезду другого участника,тем самым мешая ему.\nОбгонять ведущего в заезде.\nУгрожать сопернику.\nУчаствовать 2-ой раз в этапе."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffВнимательно следить за чатом, смотреть что скажет организатор.\nНе отходить от компьютера(AFK). \nБыть адекватным.\nЖдать своей очереди.\nКак вас вызвал организатор,незамедлительно встать на старт.\nДо конца мероприятия быть на одном  и том же авто, котором сказал организатор."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПросить РР (Рестарт), если 2-ой игрок согласен.\nПокидать МП и перезаходить в игру, но перед этим предупредить организатора.\nОтдать победу, если есть желание.\nС разрешения организатора, вы можете изучить трассу."}
};
new const rules_derby[][] = {
	{"\t\t{ffffffПравила мероприятия - ДЕРБИ\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование читов, клео-скриптов и прочего, что дает преимущество над игроками.\nПокидать место соревнований, кататься по трассе.\nОставлять транспорт на дороге, тем самым мешая другим игрокам.\nВыбрасывать другого игрока из авто.\nОскорблять участников мероприятия.\nПрепятствовать проезду другого участника, тем самым мешая ему.\nПодсуживание друзьям, соклановцам и т.д."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffВнимательно следить за чатом, смотреть что скажет организатор.\nНе отходить от компьютера(AFK).\nБыть адекватным.\nЖдать своей очереди.\nКак вас вызвал организатор, незамедлительно встать на старт.\nДо конца мероприятия быть на одном и том же авто, котором сказал организатор.\nПосле отсчёта, стартовать."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПо разрешению организатора, выходить из машины и фотографировать мероприятие.\nПокидать МП и перезаходить в игру, но перед этим предупредить организатора.\nПо своему желанию, отдать сопернику победу.\nПо окончания мероприятия, можно сфотографироваться.\nЕсли вы не знакомы с трассой, то вы можете потренироваться."}
};
new const rules_poiskauto[][] = {
	{"\t\t{ffffffПравила мероприятия - ПОИСК АВТО\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование любых видов читов, клео-скриптов, программ.\nВыкидывать из транспорта других игроков.\nОскорбление игроков, прибывающих на авто пробеге.\nИспользовать вертолёт, лодку.\nЛожно сообщение, об нахождение авто."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffВнимательно следить за чатом, смотреть что пишет организатор.\nЗапрещено стоять в AFK.\nНа мероприятие вести себя адекватно."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПо разрешению организатора, выходить из машины и фотографировать мероприятие.\nПокидать МП и перезаходить в игру, но перед этим предупредить организатора.\nСпросить в каком городе находится транспорт."}
};
new const rules_probeg[][] = {
	{"\t\t{ffffffПравила мероприятия - АВТО ПРОБЕГ\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование любых видов читов, клео-скриптов, программ.\nПокидать свое место.\nВыкидывать из транспорта других игроков.\nОскорбление игроков, прибывающих на авто пробеге."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffОбязательно следить за чатом, смотреть что пишет организатор.\nНе стоять на авто пробеге в AFK.\nНа мероприятие вести себя адекватно.\nКогда игрок едет, он должен держать дистанцию не больше, чем 3 машины!\nВо время мероприятия запрещено менять авто, только то, которое сказал организатор.После отсчёта, держаться строя."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПо разрешению организатора, фотографировать мероприятия!\nПокидать МП и перезахидить в игру, но перед этим предупредить организатора!"}
};
new const rules_dd[][] = {
	{"\t\t{ffffffПравила мероприятия - ДРИФТ ДУЭЛЬ\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование каких-либо программ, читов, клео-скриптов запрещено.\nПокидать место проведения мероприятия.\nРазбрасывать авто во время проведения мероприятия.\nВыкидывать игрока из его машины.\nОскорблять всех участников Дрифт Дуэля.\nПодсуживание друзьям,соклановцам и т.д."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffВнимательно смотреть в чат, смотреть то, что напишет судья.\nНе отходить от компьютера во время дрифт-дуэля(AFK).\nНа дрифт-дуэле вести себя адекватно.\nКогда игрок едет, он должен держать дистанцию не больше, чем 3 машины.\nОжидать своей очереди.\nВставать на старт, только после того, как вас позовет судья.\nЕздить на той машине, которой сказал организатор."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПо разрешению организатора, выходить из машины и фотографировать мероприятие.\nПросить РР (Рестарт), если 2-ой игрок согласен.\nПокидать МП и перезаходить в игру, но перед этим предупредить организатора.\nПо своему желанию, отдать сопернику победу.\nПо окончания мероприятия, можно сфотографироваться.\nЕсли вы не знакомы с трассой, то вы можете потренироваться."}
};
new const rules_tochka[][] = {
	{"\t\t{ffffffПравила мероприятия - ДОБЕРИСЬ ДО ТОЧКИ\n\n{ff0000\t\tЗапрещено\n{ffffffИспользование каких-либо читов,скриптов и т.д, что дает преимущество над другими игроками.\nВыкидывать из машины других игроков.\nОскорблять других игроков или организатора.\nПодсуживание друзьям, соклановцам, другим людям.\nТелепортироватся на ближайшую точку."},
	{"\n\n{ffff00\t\tОбязан\n{ffffffВнимательно смотреть в чат, смотреть то, что напишет организатор мероприятия.\nНе отходить от компьютера во время мероприятия.\nНа мероприятие вести себя адекватно.\nОжидать своей очереди.\nЕздить на той машине, которой сказал организатор."},
	{"\n\n{00ff00\t\tРазрешено\n{ffffffПо разрешению организатора, выходить из машины и фотографировать мероприятие.\nПокидать МП и перезаходить в игру, но перед этим предупредить организатора.\nПо своему желанию, отдать сопернику победу.\nПо окончания мероприятия, можно сфотографироваться."}
};
#undef MAX_OWNED_HOUSES
#define MAX_OWNED_HOUSES 3
#define STOIMOST_VIP		50
#define STOIMOST_VIP_UNLIM	300
#define STOIMOST_DENEG 		10
#define STOIMOST_SCORE		1
#define DONATDIALOG   		666
#define MESSAGES_LIST       689
#define TELEPORTS_LIST      734
#define START_INFO_DIALOG   484
#define DIALOG_STG_AKK      363
/*---------------------------------------------------------------*/
#define MYSQL_HOST 			"127.0.0.1"
#define MYSQL_USER 			"gs129"
#define MYSQL_DATABASE 		"gs129"
#define MYSQL_PASSWORD 		"qwer19941111"
//974
new
	rRecordScore,
	rRecordTime,
	Float:rRecordCombo,
	rRecordScoreUID,
	rRecordTimeUID,
	rRecordComboUID,
	rDateReloadRecords;
///////////////////////////////////////////////////////////////////
new Float:VehPos[MAX_VEHICLES][4]; 
new bool: BanCar[MAX_VEHICLES]; 
bool: UseCar(carid); 	
///////////////////////////////////////////////////////////////////
new records[4][10];
new recorder[4][10];
enum pInfo {
	PlayerName[MAX_PLAYER_NAME],
	PlayerPassword[MAX_PLAYER_NAME],
	pSQLID,
	pCashPlayer,
	pScore,
	pLevel,
	pSkin,
	pMuteTime,
	pMutedAdm,
	pVcar,
	pJTime,
	pJailAdm,
	pAdminPlayer,
	pDoubleDriftT,
	pNoCrashTime,
	pSpeedom,
	pColorSpeedom,
	pPmStatus,
	pCheater,
	pBonus_d,
	pComboDays,
	pJMin,
	pInt,
	pVirt,
	pCt,
	pCarslots,
	pColorPlayer,
	pCarSpeed,
	pMaxSpeed,
	pDonatM,
	pTimeOnline,
	pTimeOnlineH,
	pTimeOnlineD,
	pStopAdmin,
	pStopVip,
	pTimeNewNick,
	pDriftPointsNow[2],
	pColorScore,
	pWeapons,
	pColorText,
	pFrinend[MAX_FRENDS],
	pNoActFrinend[MAX_FRENDS],
	pBlackList[MAX_FRENDS],
	pZayavki[MAX_FRENDS],
	ptID[MAX_TELEPORTS],
	pOldDuel,
	pWinRace,
	pLooseRace,
	cClan[MAX_CLANS_ON_PLAYER],
	cRate[MAX_CLANS_ON_PLAYER],
	cMoneys[MAX_CLANS_ON_PLAYER],
	cMDay[MAX_CLANS_ON_PLAYER],
	Float:pPos[4],
	Float:pAPos_x	[MAX_VEHICLES_FOR_PLAYER+1],
	Float:pAPos_y	[MAX_VEHICLES_FOR_PLAYER+1],
	Float:pAPos_z	[MAX_VEHICLES_FOR_PLAYER+1],
	Float:pAPos_a	[MAX_VEHICLES_FOR_PLAYER+1],
	pAutoUID		[MAX_VEHICLES_FOR_PLAYER+1],
	pAuto			[MAX_VEHICLES_FOR_PLAYER+1],
	pVinil			[MAX_VEHICLES_FOR_PLAYER+1],
	pColor			[MAX_VEHICLES_FOR_PLAYER+1],
	pColorTwo		[MAX_VEHICLES_FOR_PLAYER+1],
	cGidravlika		[MAX_VEHICLES_FOR_PLAYER+1],
	cWheels			[MAX_VEHICLES_FOR_PLAYER+1],
	cWorld			[MAX_VEHICLES_FOR_PLAYER+1],
	Float:ptPosX[MAX_TELEPORTS],
	Float:ptPosY[MAX_TELEPORTS],
	Float:ptPosZ[MAX_TELEPORTS],
	Float:ptPosA[MAX_TELEPORTS],
	bool:KeyTP,
	bool:KeyStop,
	bool:logged,
	bool:pBanned,
	bool:pJail,
	bool:pDoubleDrift,
	bool:pNoCrash,
	bool:pMuted,
	bool:pRepair,
	bool:pTags,
	bool:pKeyMenu,
	bool:pVIP
};
enum hInfo{
	Float: henterx,
	Float: hentery,
	Float: henterz,
	Float: henterza,
	Float: hexitx,
	Float: hexity,
	Float: hexitz,
	Float: hexitza,
	howner[MAX_PLAYER_NAME],
	hprice,
	hint,
	bool: hlock,
	Text3D:hlabel,
	hpickup,
	hpickup2,
	hprice2,
	naprodaje,
	howneruid
};
new HouseInfo[MAX_HOUSES][hInfo],
	pHID[MAX_HOUSES],
	Text:AllRaceTextDraw[9],
	Text:RaceTextDraw[MAX_RACE][7],
	RemovStatusRace[MAX_RACE],
	TimeStart,
	Text: hpDrawFon,
	Text: hpDraweFon,
	Text:Textdraw[18];
new const word_arr[17][]={
	{"еблан"},{"ебок"},{"ёбок"},{"стукач"},{"пидар"},
	{"гандон"},{"бля"},{"долба"},{"даун"},{"хуй"},
	{"всосал"},{"хуе"},{"хуё"},{"хуя"},{"ебану"},
	{"пизд"},{"ебат"}
};
new const exep_arr[8][]={
	{"страхуй"},{"треблять"},{"скипидар"},{"хлеба"},{"спид"},
	{"небалу"},{"сабля"},{"рубля"}
};
enum tpMap{
	nameMap[10],
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	Float:pPosA
};
new const tpMapPack[][tpMap] ={
	{"Track 1",1187.3496,-2554.4966,12.3262,133.2300},
	{"Track 2",993.3267,-2746.1489,5.4409,268.5292},
	{"Track 3",397.3609,-2157.3386,143.7186,182.5751},
	{"Track 4",597.1138,-798.0166,184.3065,93.6396},
	{"Track 5",-74.7660,-1885.8969,84.8688,270.9999},
	{"Track 6",-354.9154,-1508.5494,121.3319,341.7031},
	{"Track 7",-1873.2245,-2130.4412,443.4825,57.4412},
	{"Track 8",-2849.9355,-2573.3494,518.2695,235.6728},
	{"Track 9",-2411.2192,-1997.8624,300.0460,190.5322},
	{"Track 10",-2229.5625,1890.8632,563.3383,221.6701},
	{"Track 11",-2789.6953,1515.6072,15.1269,66.3029},
	{"Track 12",-1779.4031,1758.3761,90.8921,182.9342},
	{"Track 13",-2280.0598,1755.1333,19.5881,341.9283},
	{"Track 14",-1573.8362,1732.7357,33.7757,108.6198},
	{"Track 15",-151.4779,1464.1478,69.3265,342.8365},
	{"Track 16",-446.0157,2165.6731,107.6444,10.0531},
	{"Track 17",-1145.6375,2363.0732,151.5348,188.8958},
	{"Track 18",523.2065,2190.8586,83.3317,322.4882},
	{"Track 19",-149.5594,265.3265,323.5223,231.1922},
	{"Track 20",1478.9824,1444.2159,110.2100,273.9723},
	{"Track 21",1539.7742,185.5446,275.3183,355.7020},
	{"Track 22",1636.6742,2859.9729,237.0740,93.9691}
};
enum tpDere{
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	nameD[15]
};
new const tpDerevni[][tpDere] ={
	{-193.3764,1097.7527,19.5959,"Fort Carson"},
	{-2095.9812,-2238.6663,30.6250,"Angel Pine"},
	{-2255.7288,2340.6919,4.8125,"Bayside Marina"},
	{626.4049,-603.3666,16.7251,"Dillimore"},
	{111.5977,-159.5757,1.5839,"Blueberry"},
	{2413.3479,88.3292,26.4725,"Palomino Creek"},
	{1347.0132,347.6915,19.9204,"Montgomery"}
};
enum pgInfo{
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	Float:pPosA
};
new const PosInGarage[31][pgInfo] ={
	{0.0,0.0,0.0,0.0},
	{-1735.555664,1008.339599,18.023996,269.483520},//тачка_1
	{-1735.536499,1011.888427,18.023550,271.459075},//тачка_2
	{-1735.640258,1015.968566,18.032510,271.457031},//тачка_3
	{-1735.744873,1020.089111,18.036809,271.457092},//тачка_4
	{-1735.842407,1023.940856,18.040948,271.457031},//тачка_5
	{-1735.626464,1028.631591,18.028358,270.675598},//тачка_6
	{-1735.673217,1032.617675,18.037445,270.675628},//тачка_7
	{-1735.719726,1036.575683,18.042287,270.675628},//тачка_8
	{-1735.769653,1040.636352,18.065690,270.764587},//тачка_9
	{-1735.823120,1044.703491,18.077976,270.764526},//тачка_10
	{-1735.875122,1048.579467,18.077976,270.764526},//тачка_11
	{-1735.932983,1052.899169,18.077985,270.764526},//тачка_12
	{-1735.989379,1057.127685,18.077995,270.764343},//тачка_13
	{-1736.040161,1060.945434,18.078006,270.764434},//тачка_14
	{-1720.920532,1036.480346,18.020280,89.950340},//тачка_15
	{-1720.923828,1032.351318,18.029251,89.950340},//тачка_16
	{-1720.927246,1028.554931,18.038955,89.950332},//тачка_17
	{-1720.930908,1024.316406,18.043518,89.950332},//тачка_18
	{-1720.941894,1011.952819,18.043491,89.950332},//тачка_19
	{-1720.945190,1008.130676,18.043491,89.950332},//тачка_20
	{-1720.949707,1003.454467,18.048946,89.949409},//тачка_21
	{-1720.953613,999.649230,18.053304,89.950325},//тачка_22
	{-1702.888793,999.765930,18.014667,271.004089},//тачка_23
	{-1702.958618,1003.686218,18.035543,271.004089},//тачка_24
	{-1703.026489,1007.625610,18.061166,271.004180},//тачка_25
	{-1703.104370,1012.071289,18.065952,271.004394},//тачка_26
	{-1702.726440,1024.106445,18.018993,270.959564},//тачка_27
	{-1702.799194,1028.466430,18.033727,270.959594},//тачка_28
	{-1702.861694,1032.193969,18.033744,270.960357},//тачка_29
	{-1702.937866,1036.519531,18.039001,271.014587}//тачка_30
};
#define INVALID_COUNT_ID -1
new countid[MAX_PLAYERS] = INVALID_COUNT_ID;
enum countInfo {
	bool:started,
	time,
	timestart,
	Float: xC,
	Float: yC,
	Float: zC
};
new AllCounts[MAX_PLAYERS][countInfo];
enum tpInfo {
	alocat[6],
	tname[24],
	tnameEn[24],
	Float: ix,
	Float: iy,
	Float: iz
};
new AllTeleports[9][tpInfo] = {
	{"[LS] ","VineWood","VineWood",	1241.8102,-740.5389,95.0492},
	{"[WS] ","Чиллиад","Chilliad",		-2336.696,-1613.594,483.3655},
 	{"[RC] ","Туннель","Tunnel",		-844.1119,1260.7810,2824.0},
	{"[LS] ","Остров VT","VT island",	2909.6999,-806.0999,11.0},
	{"[RC] ","Вышка","Tower",		-1275.807,53.770999,1272.0119629},
	{"[LS] ","Аэропорт","Airport",	1961.3020,-2215.607,15.7784},
	{"[LS] ","Дерби","Derby",		1614.7149,-1345.935,172.14999},
	{"[LS] ","GroveStreet","GroveStreet",	2439.0411,-1663.800,13.15},
	{"[LS] ","Спираль","Spiral",	4388.7431640625,-2632.8659667969,2454.6589355469}	
};
enum tunInfo {
	Uranus,
	Jester,
	Sultan,
	Stratum,
	Elegy,
	Flash
};
new bool:LanglePlayer[MAX_PLAYERS];
new const AllTuning[12][tunInfo] = { //(cartype < 565)?cartype - 558:5
	{1165,1173,1170,1157,1172,1152},
	{1166,1160,1169,1155,1171,1153},
	{1167,1161,1140,1156,1148,1151},
	{1168,1159,1141,1154,1149,1150},
	{1163,1158,1139,1050,1146,1160},
	{1164,1162,1138,1058,1147,1049},
	{0,0,0,0,0,0},
	{0,0,0,0,0,0},
	{1091,1068,1033,1061,1035,1052},
	{1088,1067,1032,1055,1038,1054},
	{1089,1066,1029,1059,1037,1045},
	{1092,1065,1028,1064,1034,1046}};
new const SlotOne[6] = {1093,1070,1031,1057,1041,1052};
new const SlotTwue[6] = {1090,1069,1026,1056,1036,1051};
enum tpInfoDrag {
	dglocat[6],
	dgName[24],
	dgNameEn[24],
	Float: dx,
	Float: dy,
	Float: dz,
	Float: da,
	number[8]
};
#define DRAGRACKE "2"
#define DRAGRACK 2
new const DragTeleports[DRAGRACK][tpInfoDrag] = {
	{"[SF] ","Аэропорт","Airport",-1178.1807,25.2291,13.8069, 118.2190,"[1] "},
	{"[LS] ","Причал","Dock",826.9761,-1818.5415,11.9934, 206.7258,"[2] "}
};
#define SPAWNS 4
enum iSpawns{
	Float:xS,
	Float:yS,
	Float:zS,
	Float:aS};
new const Spawnse[SPAWNS][iSpawns] ={
	{2364.4922,2377.6047,10.8203,100.8853},
	{2655.2659,640.1639,14.4545,178.8072},
	{1177.4288,-1323.1599,14.0702,269.2685},
	{2035.3485,-1412.8281,16.9922,137.1058}};
enum tpDrifts{
	dtlocat[6],
	dtName[28],
	dtNameEn[28],
	Float:pPosX1,
	Float:pPosY1,
	Float:pPosX2,
	Float:pPosY2,
	Float:pPosX3,
	Float:pPosY3,
	Float:pPosZ,
	Float:pPosA,
	number[8]
};
#define DRIFTRACKE "19"
#define DRIFTRACK 19
new const DriftTeleports[DRIFTRACK][tpDrifts] = {
	{"[BC] ","Ухо","Ear",								-318.5018,1532.1637, -323.0225,1532.2266, -328.4930,1532.1046,75.0173,177.2239,		"[1] "}, // drift1
	{"[SF] ","Холм","Hill",								-2401.2861,-587.1075, -2399.6335,-589.6394, -2397.7878,-591.9897,132.3073,124.5392,	"[2] "}, // drift2
	{"[LS] ","Холм","Hill",								1266.8309,-2009.9177, 1263.5795,-2009.7245, 1259.7664,-2009.5834,59.0857,181.0183,	"[3] "}, // drift3
	{"[SF] ","Военная база","Military base",			-1679.7599,284.2592, -1676.5083,282.4803, -1675.1378,279.2675,6.8465,313.3656,		"[4] "}, // drift4
	{"[LV] ","Открытая парковка","Open parking",		2330.1248,1405.8719, 2333.7217,1405.8818, 2326.2241,1405.6658,42.4807,3.9606,		"[5] "}, // drift5
	{"[LV] ","Закрытая парковка","Closed parking",		2221.3342,1960.1985, 2221.4412,1963.2152, 2221.6892,1966.7771,31.4384,271.7726,		"[6] "}, // drift6
	{"[LS] ","Тренировочный остров","Training island",	2869.7190,-1747.3102, 2866.2771,-1747.1375, 2863.4373,-1748.7715,10.7057,5.5140,	"[7] "}, // drift8 //0014
	{"[SF] ","Гоночный остров","Racing island",			-2355.9683,2141.9788, -2355.5208,2145.6587, -2357.0117,2148.7844,1.7694,281.8397,	"[8] "}, // drift10 //0010
	{"[LV] ","Аэропорт","Airport",						1483.9586,1188.9703, 1480.6676,1188.3352, 1477.1934,1188.2609,10.4797,359.4992,		"[9] "}, // drift11
	{"[LS] ","Гоночный остров [2]","Racing island [2]",	1858.0082,-2795.4971, 1856.3673,-2795.1719, 1853.9384,-2794.7751,2.6617,177.9561,	"[10] "}, // drift12
	{"[TR] ","Гоночный остров","Racing island",			-2786.1418,1518.6863, -2782.6448,1518.8215, -2779.4548,1518.9153,8.2133,358.8186,	"[11] "}, // drift13
	{"[RC] ","Холм","Hill",								-874.8820,-140.4748, -877.6764,-141.2505, -880.5070,-141.6899,58.0049,19.1784,		"[12] "}, // drift14
	{"[FC] ","Холм","Hill",								-1053.7087,-1342.1652,-1055.3861,-1339.4204,-1058.3955,-1338.7319,129.8497,158.7466,"[13] "}, // drift16 //0016
	{"[LS] ","Гоночный остров [3]","Racing island [3]",	722.8224,-3430.9810, 722.3833,-3433.9785, 722.0634,-3437.0227,14.3388,91.0405,		"[14] "}, // drift17 //0017
	{"[SF] ","Ферма","Farm",							-1197.3618,-1036.4196,-1197.3367,-1038.9037,-1197.2070,-1041.9266,128.8776,269.5293,"[15] "},
	{"[BC] ","Тренировочная площадка","Training site",	1120.5309,1335.7969, 1120.7354,1338.5088, 1120.6158,1341.1681,10.4796,273.2691,		"[16] "},
	{"[SF] ","Гоночный остров","Racing island",			-2969.829,104.762,-2973.290,104.944862,-2966.722900,104.941093,3.884747,180.0324,	"[17] "},
	{"[SF] ","Больница","Hospital",						-2591.597,645.2578,-2591.0627,650.308105,-2592.071777,655.542968,27.472650,270.8774,"[18] "},
	{"[SF] ","Автошкола","Driving school",				-2062.639,-107.2212,-2066.0883,-106.9372,-2070.8259,-107.2753,34.982,180.1838,		"[19] "}
};
enum iInfoBuy {
	iint,
	iname[128],
	Float: ix,
	Float: iy,
	Float: iz,
	Float: iza,
	price
};
new InteriorInfoBuy[12][iInfoBuy] =
{
	{ 1, 	""INT_1" 		[ 100000 ]\n", 			243.7176,	304.9697, 	999.1484, 	270.0, 	100000},
	{ 3, 	""INT_2" 		[ 500000 ]\n", 				2495.9456, -1692.0854, 	1014.7422, 	180.0, 	500000},
	{ 10, 	""INT_3" 		[ 150000 ]\n", 			422.5720, 	2536.4568, 	10.0000, 	90.0, 	150000},
	{ 5, 	""INT_4" 		[ 250000 ]\n", 		2233.6184, -1115.2618, 	1050.8828, 	0.0, 	250000},
	{ 9, 	""INT_5"		[ 300000 ]\n", 	2317.7410, -1026.7661, 	1050.2178, 	0.0, 	300000},
	{ 10, 	""INT_6" 		[ 120000 ]\n", 	2259.3816, -1135.8962, 	1050.6403, 	270.0, 	120000},
	{ 3, 	""INT_7" 		[ 350000 ]\n", 		235.2910, 	1186.6793, 	1080.2578, 	0.0, 	350000},
	{ 1, 	""INT_8" 		[ 250000 ]\n", 	223.1530, 	1287.0830, 	1082.1406, 	0.0, 	250000},
	{ 5, 	""INT_9" 		[ 550000 ]\n", 		226.2990, 	1114.3126, 	1080.9929, 	270.0, 	550000},
	{ 2, 	""INT_10" 		[ 200000 ]\n", 		447.0905, 	1397.0645, 	1084.3047, 	0.0, 	200000},
	{ 10, 	""INT_11" 		[ 225000 ]\n", 		23.9724, 	1340.1591, 	1084.3750, 	0.0, 	225000},
	{ 5, 	""INT_12" 		[ 1000000 ]",		1261.7544,	-785.3931,	1091.9062,	95.1, 1000000}
};
new const ColorsScore[7] = {
	0x00f5daFF,0x4f7942FF,0x0000ffFF,0xffffffFF,0xff0000FF,0x9966ccFF,0xffff00FF
};
new Text:StirLock[7];
new const PlayerColors[511] = {
	0x000022FF, 0x000044FF, 0x000066FF, 0x000088FF, 0x0000AAFF, 0x0000CCFF, 0x0000EEFF,
	0x002200FF, 0x002222FF, 0x002244FF, 0x002266FF, 0x002288FF, 0x0022AAFF, 0x0022CCFF, 0x0022EEFF,
	0x004400FF, 0x004422FF, 0x004444FF, 0x004466FF, 0x004488FF, 0x0044AAFF, 0x0044CCFF, 0x0044EEFF,
	0x006600FF, 0x006622FF, 0x006644FF, 0x006666FF, 0x006688FF, 0x0066AAFF, 0x0066CCFF, 0x0066EEFF,
	0x008800FF, 0x008822FF, 0x008844FF, 0x008866FF, 0x008888FF, 0x0088AAFF, 0x0088CCFF, 0x0088EEFF,
	0x00AA00FF, 0x00AA22FF, 0x00AA44FF, 0x00AA66FF, 0x00AA88FF, 0x00AAAAFF, 0x00AACCFF, 0x00AAEEFF,
	0x00CC00FF, 0x00CC22FF, 0x00CC44FF, 0x00CC66FF, 0x00CC88FF, 0x00CCAAFF, 0x00CCCCFF, 0x00CCEEFF,
	0x00EE00FF, 0x00EE22FF, 0x00EE44FF, 0x00EE66FF, 0x00EE88FF, 0x00EEAAFF, 0x00EECCFF, 0x00EEEEFF,
	0x220000FF, 0x220022FF, 0x220044FF, 0x220066FF, 0x220088FF, 0x2200AAFF, 0x2200CCFF, 0x2200FFFF,
	0x222200FF, 0x222222FF, 0x222244FF, 0x222266FF, 0x222288FF, 0x2222AAFF, 0x2222CCFF, 0x2222EEFF,
	0x224400FF, 0x224422FF, 0x224444FF, 0x224466FF, 0x224488FF, 0x2244AAFF, 0x2244CCFF, 0x2244EEFF,
	0x226600FF, 0x226622FF, 0x226644FF, 0x226666FF, 0x226688FF, 0x2266AAFF, 0x2266CCFF, 0x2266EEFF,
	0x228800FF, 0x228822FF, 0x228844FF, 0x228866FF, 0x228888FF, 0x2288AAFF, 0x2288CCFF, 0x2288EEFF,
	0x22AA00FF, 0x22AA22FF, 0x22AA44FF, 0x22AA66FF, 0x22AA88FF, 0x22AAAAFF, 0x22AACCFF, 0x22AAEEFF,
	0x22CC00FF, 0x22CC22FF, 0x22CC44FF, 0x22CC66FF, 0x22CC88FF, 0x22CCAAFF, 0x22CCCCFF, 0x22CCEEFF,
	0x22EE00FF, 0x22EE22FF, 0x22EE44FF, 0x22EE66FF, 0x22EE88FF, 0x22EEAAFF, 0x22EECCFF, 0x22EEEEFF,
	0x440000FF, 0x440022FF, 0x440044FF, 0x440066FF, 0x440088FF, 0x4400AAFF, 0x4400CCFF, 0x4400FFFF,
	0x442200FF, 0x442222FF, 0x442244FF, 0x442266FF, 0x442288FF, 0x4422AAFF, 0x4422CCFF, 0x4422EEFF,
	0x444400FF, 0x444422FF, 0x444444FF, 0x444466FF, 0x444488FF, 0x4444AAFF, 0x4444CCFF, 0x4444EEFF,
	0x446600FF, 0x446622FF, 0x446644FF, 0x446666FF, 0x446688FF, 0x4466AAFF, 0x4466CCFF, 0x4466EEFF,
	0x448800FF, 0x448822FF, 0x448844FF, 0x448866FF, 0x448888FF, 0x4488AAFF, 0x4488CCFF, 0x4488EEFF,
	0x44AA00FF, 0x44AA22FF, 0x44AA44FF, 0x44AA66FF, 0x44AA88FF, 0x44AAAAFF, 0x44AACCFF, 0x44AAEEFF,
	0x44CC00FF, 0x44CC22FF, 0x44CC44FF, 0x44CC66FF, 0x44CC88FF, 0x44CCAAFF, 0x44CCCCFF, 0x44CCEEFF,
	0x44EE00FF, 0x44EE22FF, 0x44EE44FF, 0x44EE66FF, 0x44EE88FF, 0x44EEAAFF, 0x44EECCFF, 0x44EEEEFF,
	0x660000FF, 0x660022FF, 0x660044FF, 0x660066FF, 0x660088FF, 0x6600AAFF, 0x6600CCFF, 0x6600FFFF,
	0x662200FF, 0x662222FF, 0x662244FF, 0x662266FF, 0x662288FF, 0x6622AAFF, 0x6622CCFF, 0x6622EEFF,
	0x664400FF, 0x664422FF, 0x664444FF, 0x664466FF, 0x664488FF, 0x6644AAFF, 0x6644CCFF, 0x6644EEFF,
	0x666600FF, 0x666622FF, 0x666644FF, 0x666666FF, 0x666688FF, 0x6666AAFF, 0x6666CCFF, 0x6666EEFF,
	0x668800FF, 0x668822FF, 0x668844FF, 0x668866FF, 0x668888FF, 0x6688AAFF, 0x6688CCFF, 0x6688EEFF,
	0x66AA00FF, 0x66AA22FF, 0x66AA44FF, 0x66AA66FF, 0x66AA88FF, 0x66AAAAFF, 0x66AACCFF, 0x66AAEEFF,
	0x66CC00FF, 0x66CC22FF, 0x66CC44FF, 0x66CC66FF, 0x66CC88FF, 0x66CCAAFF, 0x66CCCCFF, 0x66CCEEFF,
	0x66EE00FF, 0x66EE22FF, 0x66EE44FF, 0x66EE66FF, 0x66EE88FF, 0x66EEAAFF, 0x66EECCFF, 0x66EEEEFF,
	0x880000FF, 0x880022FF, 0x880044FF, 0x880066FF, 0x880088FF, 0x8800AAFF, 0x8800CCFF, 0x8800FFFF,
	0x882200FF, 0x882222FF, 0x882244FF, 0x882266FF, 0x882288FF, 0x8822AAFF, 0x8822CCFF, 0x8822EEFF,
	0x884400FF, 0x884422FF, 0x884444FF, 0x884466FF, 0x884488FF, 0x8844AAFF, 0x8844CCFF, 0x8844EEFF,
	0x886600FF, 0x886622FF, 0x886644FF, 0x886666FF, 0x886688FF, 0x8866AAFF, 0x8866CCFF, 0x8866EEFF,
	0x888800FF, 0x888822FF, 0x888844FF, 0x888866FF, 0x888888FF, 0x8888AAFF, 0x8888CCFF, 0x8888EEFF,
	0x88AA00FF, 0x88AA22FF, 0x88AA44FF, 0x88AA66FF, 0x88AA88FF, 0x88AAAAFF, 0x88AACCFF, 0x88AAEEFF,
	0x88CC00FF, 0x88CC22FF, 0x88CC44FF, 0x88CC66FF, 0x88CC88FF, 0x88CCAAFF, 0x88CCCCFF, 0x88CCEEFF,
	0x88EE00FF, 0x88EE22FF, 0x88EE44FF, 0x88EE66FF, 0x88EE88FF, 0x88EEAAFF, 0x88EECCFF, 0x88EEEEFF,
	0xAA0000FF, 0xAA0022FF, 0xAA0044FF, 0xAA0066FF, 0xAA0088FF, 0xAA00AAFF, 0xAA00CCFF, 0xAA00FFFF,
	0xAA2200FF, 0xAA2222FF, 0xAA2244FF, 0xAA2266FF, 0xAA2288FF, 0xAA22AAFF, 0xAA22CCFF, 0xAA22EEFF,
	0xAA4400FF, 0xAA4422FF, 0xAA4444FF, 0xAA4466FF, 0xAA4488FF, 0xAA44AAFF, 0xAA44CCFF, 0xAA44EEFF,
	0xAA6600FF, 0xAA6622FF, 0xAA6644FF, 0xAA6666FF, 0xAA6688FF, 0xAA66AAFF, 0xAA66CCFF, 0xAA66EEFF,
	0xAA8800FF, 0xAA8822FF, 0xAA8844FF, 0xAA8866FF, 0xAA8888FF, 0xAA88AAFF, 0xAA88CCFF, 0xAA88EEFF,
	0xAAAA00FF, 0xAAAA22FF, 0xAAAA44FF, 0xAAAA66FF, 0xAAAA88FF, 0xAAAAAAFF, 0xAAAACCFF, 0xAAAAEEFF,
	0xAACC00FF, 0xAACC22FF, 0xAACC44FF, 0xAACC66FF, 0xAACC88FF, 0xAACCAAFF, 0xAACCCCFF, 0xAACCEEFF,
	0xAAEE00FF, 0xAAEE22FF, 0xAAEE44FF, 0xAAEE66FF, 0xAAEE88FF, 0xAAEEAAFF, 0xAAEECCFF, 0xAAEEEEFF,
	0xCC0000FF, 0xCC0022FF, 0xCC0044FF, 0xCC0066FF, 0xCC0088FF, 0xCC00AAFF, 0xCC00CCFF, 0xCC00FFFF,
	0xCC2200FF, 0xCC2222FF, 0xCC2244FF, 0xCC2266FF, 0xCC2288FF, 0xCC22AAFF, 0xCC22CCFF, 0xCC22EEFF,
	0xCC4400FF, 0xCC4422FF, 0xCC4444FF, 0xCC4466FF, 0xCC4488FF, 0xCC44AAFF, 0xCC44CCFF, 0xCC44EEFF,
	0xCC6600FF, 0xCC6622FF, 0xCC6644FF, 0xCC6666FF, 0xCC6688FF, 0xCC66AAFF, 0xCC66CCFF, 0xCC66EEFF,
	0xCC8800FF, 0xCC8822FF, 0xCC8844FF, 0xCC8866FF, 0xCC8888FF, 0xCC88AAFF, 0xCC88CCFF, 0xCC88EEFF,
	0xCCAA00FF, 0xCCAA22FF, 0xCCAA44FF, 0xCCAA66FF, 0xCCAA88FF, 0xCCAAAAFF, 0xCCAACCFF, 0xCCAAEEFF,
	0xCCCC00FF, 0xCCCC22FF, 0xCCCC44FF, 0xCCCC66FF, 0xCCCC88FF, 0xCCCCAAFF, 0xCCCCCCFF, 0xCCCCEEFF,
	0xCCEE00FF, 0xCCEE22FF, 0xCCEE44FF, 0xCCEE66FF, 0xCCEE88FF, 0xCCEEAAFF, 0xCCEECCFF, 0xCCEEEEFF,
	0xEE0000FF, 0xEE0022FF, 0xEE0044FF, 0xEE0066FF, 0xEE0088FF, 0xEE00AAFF, 0xEE00CCFF, 0xEE00FFFF,
	0xEE2200FF, 0xEE2222FF, 0xEE2244FF, 0xEE2266FF, 0xEE2288FF, 0xEE22AAFF, 0xEE22CCFF, 0xEE22EEFF,
	0xEE4400FF, 0xEE4422FF, 0xEE4444FF, 0xEE4466FF, 0xEE4488FF, 0xEE44AAFF, 0xEE44CCFF, 0xEE44EEFF,
	0xEE6600FF, 0xEE6622FF, 0xEE6644FF, 0xEE6666FF, 0xEE6688FF, 0xEE66AAFF, 0xEE66CCFF, 0xEE66EEFF,
	0xEE8800FF, 0xEE8822FF, 0xEE8844FF, 0xEE8866FF, 0xEE8888FF, 0xEE88AAFF, 0xEE88CCFF, 0xEE88EEFF,
	0xEEAA00FF, 0xEEAA22FF, 0xEEAA44FF, 0xEEAA66FF, 0xEEAA88FF, 0xEEAAAAFF, 0xEEAACCFF, 0xEEAAEEFF,
	0xEECC00FF, 0xEECC22FF, 0xEECC44FF, 0xEECC66FF, 0xEECC88FF, 0xEECCAAFF, 0xEECCCCFF, 0xEECCEEFF,
	0xEEEE00FF, 0xEEEE22FF, 0xEEEE44FF, 0xEEEE66FF, 0xEEEE88FF, 0xEEEEAAFF, 0xEEEECCFF, 0xEEEEEEFF
};
/*new speedcolors[31] = {
	0x00ff00ff,0x10ef00ff,0x20df00ff,0x30cf00ff,
	0x40bf00ff,0x50af00ff,0x609f00ff,0x708f00ff,
	0x807f00ff,0x906f00ff,0xa05f00ff,0xb04f00ff,
	0xc03f00ff,0xd02f00ff,0xe01f00ff,0xf00f00ff};
new const speedcolors[2][COLORS_SPEEDOM] = {{
	0x3fff00FF,0x4fff00FF,0x5fff00FF,0x6fff00FF,0x7fff00FF,0x8fff00FF,0x9fff00FF,
	0xafff00FF,0xbfff00FF,0xcfff00FF,0xdfff00FF,0xefff00FF,0xfff000FF,0xffe000FF,
	0xffd000FF,0xffc000FF,0xffb000FF,0xffa000FF,0xff9000FF,0xff8000FF,0xff7000FF,
	0xff6000FF,0xff5000FF,0xff4000FF,0xff3000FF,0xff2000FF,0xff1000FF,0xff0000FF
	},{
	0x2fffd0FF,0x3fffc0FF,0x4fffb0FF,0x5fffa0FF,0x6fff90FF,0x7fff80FF,0x8fff70FF,
	0x9fff60FF,0xafff50FF,0xbfff40FF,0xcfff30FF,0xdfff20FF,0xefff10FF,0xffff00FF,
	0xfff00fFF,0xffe01fFF,0xffd02fFF,0xffc03fFF,0xffb04fFF,0xffa05fFF,0xff906fFF,
	0xff807fFF,0xff708fFF,0xff609fFF,0xff50afFF,0xff40bfFF,0xff30cfFF,0xff20dfFF}};*/
#define COLORS_SPEEDOM 54
new const speedcolors[2][COLORS_SPEEDOM] = {{ 
    0x3FFF00FF,0x37FF00FF,0x4FFF00FF,0x47FF00FF,0x5FFF00FF,0x57FF00FF,0x6FFF00FF,0x67FF00FF,0x7FFF00FF,0x77FF00FF,
	0x8FFF00FF,0x87FF00FF,0x9FFF00FF,0x97FF00FF,0xAFFF00FF,0xA7FF00FF,0xBFFF00FF,0xB7FF00FF,0xCFFF00FF,0xC7FF00FF,
	0xDFFF00FF,0xD7FF00FF,0xEFFF00FF,0xE7FF00FF,0xFFF000FF,0xFFEF00FF,0xFFE700FF,0xFFDF00FF,0xFFD700FF,0xFFCF00FF,
	0xFFC700FF,0xFFBF00FF,0xFFB700FF,0xFFAF00FF,0xFFA700FF,0xFF9F00FF,0xFF9700FF,0xFF8F00FF,0xFF8700FF,0xFF7F00FF,
	0xFF7700FF,0xFF6F00FF,0xFF6700FF,0xFF5F00FF,0xFF5700FF,0xFF4F00FF,0xFF4700FF,0xFF3F00FF,0xFF3700FF,0xFF2F00FF,
	0xFF2700FF,0xFF1F00FF,0xFF1700FF,0xFF0000FF
    },{ 
    0x2FFFDFFF,0x2FFFD7FF,0x3FFFCFFF,0x3FFFC7FF,0x4FFFBFFF,0x4FFFB7FF,0x5FFFAFFF,0x5FFFA7FF,0x6FFF9FFF,0x6FFF97FF,
	0x7FFF8FFF,0x7FFF87FF,0x8FFF7FFF,0x8FFF77FF,0x9FFF6FFF,0x9FFF67FF,0xAFFF5FFF,0xAFFF57FF,0xBFFF4FFF,0xBFFF47FF,
	0xCFFF3FFF,0xCFFF37FF,0xDFFF2FFF,0xDFFF27FF,0xEFFF1FFF,0xEFFF17FF,0xFFFF00FF,0xFFFF0FFF,0xFFF707FF,0xFFEF1FFF,
	0xFFE717FF,0xFFDF2FFF,0xFFD727FF,0xFFCF3FFF,0xFFC737FF,0xFFBF4FFF,0xFFB747FF,0xFFAF5FFF,0xFFA757FF,0xFF9F6FFF,
	0xFF9767FF,0xFF8F7FFF,0xFF8777FF,0xFF7F8FFF,0xFF7787FF,0xFF6F9FFF,0xFF6797FF,0xFF5FAFFF,0xFF57A7FF,0xFF4FBFFF,
	0xFF47B7FF,0xFF3FCFFF,0xFF37C7FF,0xFF20DFFF}};
/*new speedcolorss[32][8] = {
	"3fff00","4fff00","5fff00","6fff00","7fff00","8fff00","9fff00",
	"afff00","bfff00","cfff00","dfff00","efff00","fff000","ffe000",
	"ffd000","ffc000","ffb000","ffa000","ff9000","ff8000","ff7000",
	"ff6000","ff5000","ff4000","ff3000","ff2000","ff1000","ff0000"
};*/
new	colorcars[41] = {
    0,3,6,14,18,25,31,36,38,46,51,61,65,79,
	82,128,134,136,137,142,145,147,155,
	158,164,179,183,194,196,198,200,205,
	213,214,217,233,235,243,246,252,255};
new timesave,
	timejail,
	Float:X, Float:Y, Float:Z, Float:Angle,
	bool:ChatOn = true,
	timechaton,
	antysh,
	antyshtwo,
	hour, minute, second,
	Text:gTextDraw[3],
	Text:Speed[3][COLORS_SPEEDOM],
	Float:wc_x,Float:wc_y,
	bigdialog[2500],
	minidialog[1500],
	engine,lights,alarm,doors,bonnet,boot,objective,
	carstate[7],
	Text:Logo[4],
	Text:txtTimeDisp[7],
	MYSQL,
	bool:restarting=false,
	TotalHouses,
	TimeNoOwned[MAX_VEHICLES],
	bool:NoOwned[MAX_VEHICLES],
	interier[MAX_VEHICLES],
	carowner[MAX_VEHICLES],
	Text:Box,
	timesaver,
	timemsg,
	msgcheat[200],
	msgcheatEn[200],
	//skinlist = mS_INVALID_LISTID,
	bool:houseson,
	timetimer,
	servername,
	bool:UseEnter[MAX_PLAYERS],
	bool:PlayerSpectate[MAX_PLAYERS],
	bool:SpeedOpen[MAX_PLAYERS][COLORS_SPEEDOM],
	bool:gocamera[MAX_PLAYERS],
	bool:crash[MAX_PLAYERS],
	bool:OpenBox[MAX_PLAYERS],
	bool:AfkPlayer[MAX_PLAYERS],
	bool:WaitSum[MAX_PLAYERS],
	bool:Kicked[MAX_PLAYERS],
	bool:ReConnect[MAX_PLAYERS],
	bool:LoadCarsEx[MAX_PLAYERS],
	bool:UpdSpd[MAX_PLAYERS],
	oldpickup[MAX_PLAYERS],
	pvehs[MAX_VEHICLES_FOR_PLAYER+1][MAX_PLAYERS],
	OLDVEH[MAX_PLAYERS],
	OLDSEAT[MAX_PLAYERS],
	IDVEH[MAX_PLAYERS],
	IDSEAT[MAX_PLAYERS],
	IDTICK[MAX_PLAYERS],
	GetSpectate[MAX_PLAYERS],
	SpectateTimer[MAX_PLAYERS],
	Jumping[MAX_PLAYERS],
	PlayerDriftCancellation[MAX_PLAYERS],
	jumped[MAX_PLAYERS],
	ramped[MAX_PLAYERS],
	Float:ppos[MAX_PLAYERS][3],
	PlayerText:ScoreShow[MAX_PLAYERS],
	PlayerText:DriftPointsShow[MAX_PLAYERS],
	PlayerText:LevelShow[MAX_PLAYERS],
	PlayerText:Speed2[MAX_PLAYERS],
	PlayerText:Loggeds[MAX_PLAYERS],
	pNumber[MAX_VEHICLES_FOR_PLAYER+1][MAX_PLAYERS][25],
	timerramp[MAX_PLAYERS],
	Text3D:AFK_3DT[MAX_PLAYERS],
	Player[MAX_PLAYERS][pInfo],
	clickedplayeride[MAX_PLAYERS],
	activetedfrends[MAX_PLAYERS],
	noactivetedfrends[MAX_PLAYERS],
	playersinblacklist[MAX_PLAYERS],
	playerszayavkinses[MAX_PLAYERS],
	useduid[MAX_PLAYERS],
	usedrang[MAX_PLAYERS],
	messages[MAX_PLAYERS],
	messagesid[MAX_PLAYERS][11],
	AfkTime[MAX_PLAYERS],
	Teleports[MAX_PLAYERS],
	Warned[MAX_PLAYERS],
	Text: hpDraw[MAX_PLAYERS],
	Text: hpDrawe[MAX_PLAYERS],
	BonusDrift[MAX_PLAYERS],
	BadWords[MAX_PLAYERS],
	address[MAX_PLAYERS],
	carsEx[MAX_PLAYERS],
	TimeUpdate[MAX_PLAYERS],
	starttime[MAX_PLAYERS],
	checksdrift[MAX_PLAYERS],
	Float:checkangle[MAX_PLAYERS],
	players[MAX_PLAYERS],
	TOTALAIR[MAX_PLAYERS],
	Float:OldPosZ[MAX_PLAYERS],
	MaxSpeeds[MAX_PLAYERS],
	MaxRazgon[MAX_PLAYERS],
	SumID[MAX_PLAYERS],
	SumTIME[MAX_PLAYERS],
	PrizDD[MAX_PLAYERS],
	ask[MAX_PLAYERS],
	ans[MAX_PLAYERS],
	RaceID[MAX_PLAYERS],
	SaceSlot[MAX_PLAYERS],
	rRaceStatusEx[MAX_PLAYERS],
	TPToTrack[MAX_PLAYERS],
	usedkeyclan[MAX_PLAYERS],
	usedrateclan[MAX_PLAYERS],
	StatusUpdate[MAX_PLAYERS],
	OldTP[MAX_PLAYERS],
	PlayerCar[MAX_PLAYERS],
	PlayerText:Inf_NewPlayer[MAX_PLAYERS],
	PlayerText:Elegy_NewPlayer[MAX_PLAYERS],
	PlayerText:Sul_NewPlayer[MAX_PLAYERS],
	TPToTrackEx[MAX_PLAYERS];
#define INTERVAL_SMG 2
new
	sizemsg[MAX_PLAYERS][2],
	textmsg[MAX_PLAYERS][3];
//END NEW's//
#if !defined OSNOVNOI_SERV
native gpci (playerid, serial [], len); // this is the native.
#endif
new
	speedosl[MAX_PLAYERS];
/*bool:GetRussiaBooks(text_text[]){
	for (new i; i < strlen(text_text); i++){
		if(text_text[i] == 'а' || text_text[i] == 'о' || text_text[i] == 'е'|| text_text[i] == 'у'|| text_text[i] == 'р' || text_text[i] == 'с')
				continue;
		if(text_text[i] == 'a' || text_text[i] == 'o' || text_text[i] == 'e'|| text_text[i] == 'y'|| text_text[i] == 'p' || text_text[i] == 'c')
				continue;
		switch(text_text[i]){
			case 'а'..'я','А'..'Я':
				return true;
	}	}
	return false;
}*/
main(){
	print("\n----------------------------------------------\n---------Drift Empire Mode by .Alpano.--------\n----------------------------------------------\n");
	TimeStart = GetTickCount();
}
SendClientMessageToUID(playerUID, colour, string[]){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
        if(playerUID == Player[i][pSQLID]){
            SendClientMessage(i, colour, string);
			break;
}   }   }
GetPlayerID(UID){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
        if(UID == Player[i][pSQLID]){
            return i;
	}   }
	return INVALID_PLAYER_ID;
}
t_GetPlayerScore(playerid) return Player[playerid][pScore];
#define GetPlayerScore t_GetPlayerScore
#if defined AirBrekE
protected AirBrk(playerid){
	new Float:Pos[4];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	Pos[3] = floatround(GetPlayerDistanceFromPoint(playerid, Player[playerid][pPos][0], Player[playerid][pPos][1], Player[playerid][pPos][2]));
	if(!GetPVarInt(playerid, "AntiBreik") && GetPlayerSpeed(playerid) < 20 && Pos[3] > 50)
	{
		//new str[30];format(str,sizeof(str),"Pos[3] = %f",Pos[3]);SendClientMessage(playerid,-1,str);
		new Float:vida;
		GetPlayerHealth(playerid, vida);
		if((GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID) && vida > 0){
			if(!(IDSEAT[playerid] == 1 && GetTickCount()-IDTICK[playerid] < 15000)){
				if(Pos[3] < 250){
					if(TOTALAIR[playerid] > 1){
						AddBan(playerid,INVALID_PLAYER_ID,"Cheat: AirBrk #1",600);
						return SendMess(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [AirBrk #1]"), t_Kick(playerid);
					}
					else
						TOTALAIR[playerid]++;
				}else{
					AddBan(playerid,INVALID_PLAYER_ID,"Cheat: TP #1",600);
					return SendMess(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [TP #1]"), t_Kick(playerid);
				}
			}
		}
	}
	else if(TOTALAIR[playerid])
		TOTALAIR[playerid]=0;
	Player[playerid][pPos][0] = Pos[0];
	Player[playerid][pPos][1] = Pos[1];
	Player[playerid][pPos][2] = Pos[2];
	return true;
}
#endif
protected Float:GetPosInFrontOfPlayer(playerid, &Float:x12, &Float:y12, Float:distance){
	new Float:a;
	GetPlayerPos(playerid, wc_x, wc_y, a);
	switch(IsPlayerInAnyVehicle(playerid)){
		case 0: GetPlayerFacingAngle(playerid, a);
		case 1: GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	wc_x += (distance * floatsin(-a, degrees));
	wc_y += (distance * floatcos(-a, degrees));
	return a;
}
protected GetCoordBonnetVehicle(vehicleid, &Float:x, &Float:y, &Float:z)
{
    new Float:angle,Float:distance;
    GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z);
    distance = distance*3 + 0.1;
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    x -= (distance * floatsin(-angle+180, degrees));
    y -= (distance * floatcos(-angle+180, degrees));
    return 1;
}
protected GetDDSopernikID(playerid)
	return (playerid==DDInfo[RaceID[playerid]][rRacer][0])?DDInfo[RaceID[playerid]][rRacer][1]:DDInfo[RaceID[playerid]][rRacer][0];
protected ShowClanDialog(playerid,dialog,&clanid = -1){
	if(clanid == -1)
		clanid = ReturnClotBD(usedkeyclan[playerid]);
	new slotEx = GetSlotClan(playerid,usedkeyclan[playerid]),
		moneys[12];
	if(dialog == CLAN_DIALOG+18){
		msgcheat = "";
		strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI"Банк");
		msgcheatEn = "";
		strcat(msgcheatEn,"{FFFFFF}");
		strcat(msgcheatEn,"Доступно для снятия\t\t{00f5da}[");
		format(moneys,sizeof(moneys),"%d",(Player[playerid][cRate][slotEx] == 5 || !ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]])?ClanInfo[clanid][cMoney]:((ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]]!=-1)?ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]]-Player[playerid][cMoneys][slotEx]:0));
		strcat(msgcheatEn,moneys);
		strcat(msgcheatEn,"]\n{FFFFFF}Внести наличные\nИстория операций");
		ShowPlayerDialog(playerid, CLAN_DIALOG+18, DIALOG_STYLE_LIST, msgcheat, msgcheatEn, "Далее", "Отмена" );
	}
	else if(dialog == CLAN_DIALOG+19){
		msgcheat = "";
		msgcheatEn = "";
		strcat(msgcheat,"{FFFFFF}..."STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI"Банк");
		format(moneys,sizeof(moneys),"%d",ClanInfo[clanid][cMoney]);
		strcat(msgcheatEn,"{FFFFFF}Сейчас в банке\t\t{00f5da}[");
		strcat(msgcheatEn,moneys);
		strcat(msgcheatEn,"]\n{FFFFFF}Доступно для снятия\t\t{00f5da}[");
		format(moneys,sizeof(moneys),"%d",(Player[playerid][cRate][slotEx] == 5 || !ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]])?ClanInfo[clanid][cMoney]:((ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]]!=-1)?ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]]-Player[playerid][cMoneys][slotEx]:0));
		strcat(msgcheatEn,moneys);
		strcat(msgcheatEn,"]\n{FFFFFF}Сегодня Вы уже сняли:\t{00f5da}[");
		format(moneys,sizeof(moneys),"%d",Player[playerid][cMoneys][slotEx]);
		strcat(msgcheatEn,moneys);
		strcat(msgcheatEn,"]");
		ShowPlayerDialog(playerid, CLAN_DIALOG+19, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
	}
	else if(dialog == CLAN_DIALOG+20){
		msgcheat = "";
		msgcheatEn = "";
		strcat(msgcheat,"{FFFFFF}..."STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI"Банк");
		format(moneys,sizeof(moneys),"%d",ClanInfo[clanid][cMoney]);
		strcat(msgcheatEn,"{FFFFFF}Сейчас в банке\t\t{00f5da}[");
		strcat(msgcheatEn,moneys);
		strcat(msgcheatEn,"]\n{FFFFFF}Введите, сколько денег Вы хотите положить в банк?");
		ShowPlayerDialog(playerid, CLAN_DIALOG+20, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
	}
	else if(dialog == CLAN_DIALOG+2){
		new msg[256];
		msgcheat = "";
		strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msg,""TEXT_CLAN_11" о клане\nСостав клана\n");
		format(moneys,sizeof(moneys),"%d",ClanInfo[clanid][cMoney]);
		if(slotEx == -1)
			strcat(msg,"{808080}");
		strcat(msg,"Банк\t\t\t\t{00f5da}[");
		strcat(msg,moneys);
		strcat(msg,"]\n{FFFFFF}");
		if(Player[playerid][pAdminPlayer] < 5 && (slotEx == -1 || !((Player[playerid][cRate][slotEx] > 1)?ClanInfo[clanid][cInvite][Player[playerid][cRate][slotEx]]:0)))
			strcat(msg,"{808080}");
		else if(Player[playerid][pAdminPlayer] >= 5 && slotEx == -1)
			strcat(msg,"{ff0000}ADM:{FFFFFF}");
		strcat(msg,"Пригласить человека\n{FFFFFF}");
		if(slotEx == -1 || Player[playerid][cRate][slotEx] < 4)
			strcat(msg,"{808080}");
		strcat(msg,"Управление\n");
		if(slotEx == -1 || Player[playerid][cRate][slotEx] == 5)
			strcat(msg,"{808080}");
		strcat(msg,"Покинуть клан");
		if(Player[playerid][pAdminPlayer] >= 5)
			strcat(msg,"\n{ff0000}ADM:{FFFFFF}Сменить лидера\n{ff0000}ADM:{FFFFFF}Удалить клан");
		ShowPlayerDialog(playerid, CLAN_DIALOG+2,DIALOG_STYLE_LIST,msgcheat,msg,"Выбрать","Отмена");
	}
	else if(dialog == CLAN_DIALOG+6){
		minidialog = "";
		new buffer[70];
		strcat(minidialog,"Изменить название\t\t\t\t");
		strcat(minidialog,ReturnRateClan(usedkeyclan[playerid],usedrateclan[playerid]));
		strcat(minidialog,"\n");
		if(usedrateclan[playerid] == 5) strcat(minidialog,"{808080}");
		strcat(minidialog,"Ограничение по снятию наличных");
		if(usedrateclan[playerid] != 5){
			if(ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] > 1){
				format(buffer,sizeof(buffer),"\t\t[{0033CC}[%d]{FFFFFF}|Безлимит|Запрет]",ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]]);
				strcat(minidialog, buffer);
			}else if(ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] == 0)
				strcat(minidialog, "\t\t[[100000]|{0033CC}Безлимит{FFFFFF}|Запрет]");
			else if(ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] == -1)
				strcat(minidialog, "\t\t[[100000]|Безлимит|{0033CC}Запрет{FFFFFF}]");
		}
		strcat(minidialog,"\n");
		if(usedrateclan[playerid] == 5) strcat(minidialog,"{808080}");
		strcat(minidialog,"Возможность принимать новичков\t\t");
		if(usedrateclan[playerid] != 5){
			if(ClanInfo[clanid][cInvite][usedrateclan[playerid]])	strcat(minidialog, "[{0033CC}On{FFFFFF}/Off]");
			else 													strcat(minidialog, "[On/{0033CC}Off{FFFFFF}]");
		}
		strcat(minidialog,"\n");
		if(usedrateclan[playerid] == 5 || usedrateclan[playerid] == 1) strcat(minidialog,"{808080}");
		strcat(minidialog,"Возможность исключать\t\t\t");
		if(usedrateclan[playerid] != 5 && usedrateclan[playerid] != 1){
			if(ClanInfo[clanid][cKick][usedrateclan[playerid]])		strcat(minidialog, "[{0033CC}On{FFFFFF}/Off]");
			else 													strcat(minidialog, "[On/{0033CC}Off{FFFFFF}]");
		}
		strcat(minidialog,"\n");
		if(usedrateclan[playerid] == 5 || usedrateclan[playerid] == 1) strcat(minidialog,"{808080}");
		strcat(minidialog,"Возможность повышать\t\t\t");
		if(usedrateclan[playerid] != 5 && usedrateclan[playerid] != 1){
			if(ClanInfo[clanid][cRangUP][usedrateclan[playerid]])	strcat(minidialog, "[{0033CC}On{FFFFFF}/Off]");
			else 													strcat(minidialog, "[On/{0033CC}Off{FFFFFF}]");
		}
		msgcheat = "";
		strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI"Управление"STRELKI"Звания");
		ShowPlayerDialog(playerid, CLAN_DIALOG+6,DIALOG_STYLE_LIST,msgcheat,minidialog,"Выбрать","Отмена");
		return true;
	}
	return true;
}
protected Float:SetFloat(member){
	new Float:memb;
	memb = member;
	return memb;
}
protected KickPlayer(adminid,playerid,reason[]){
	if(Player[adminid][pAdminPlayer] < LEVEL_KICK) return 0;
	if(!IsPlayerConnected(playerid)) return SendClientMessage(adminid,-1,""SERVER_MSG"Этого игрока нет на сервере!");
	new msg[256];
	format( msg, sizeof(msg), ""SERVER_MSG"Администратор \"{%s}%s{FFFFFF}\" кикнул \"{%s}%s{FFFFFF}\".",chatcolor[Player[adminid][pColorPlayer]],Player[adminid][PlayerName],chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
	format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator \"{%s}%s{FFFFFF}\" has kicked \"{%s}%s{FFFFFF}\".",chatcolor[Player[adminid][pColorPlayer]],Player[adminid][PlayerName],chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	msg = "";
	format( msg, sizeof(msg), ""SERVER_MSG"Причина:\"%s\".",reason);
	format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Reason:\"%s\".",reason);
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	msg = "";
	format( msg, sizeof(msg), "\"%s\" кикнул \"%s\", причина: %s.",Player[adminid][PlayerName],Player[playerid][PlayerName],reason);
	WriteRusLog("Kick.cfg", msg);
	if(!LanglePlayer{playerid})
		SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#17]");
	else
		SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#17]");
	t_Kick(playerid);
	return true;
}
protected GiveWarn(adminid,playerid,reason[]){
	if(Player[adminid][pAdminPlayer] < LEVEL_WARN) return SendClientMessage(adminid,-1,""SERVER_MSG"У тебя нет прав для использования этой команды!");
	if(!IsPlayerConnected(playerid)) return SendClientMessage(adminid,-1, ""SERVER_MSG"Игрока нет на сервере!");
   	if(gettime() < Warned[playerid]) return SendClientMessage(adminid,-1, ""SERVER_MSG"Выдавать предупреждения можно с интервалом не менее 3 сек!");
	Warned[playerid] = gettime()+3;
	SetPVarInt(playerid,"warn",GetPVarInt(playerid,"warn")+1);
	new msg[256];
	format( msg, sizeof(msg), ""SERVER_MSG"Администратор %s выдал предупреждение %s. [%d/3]",Player[adminid][PlayerName],Player[playerid][PlayerName],GetPVarInt(playerid,"warn"));
	format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s has warned %s. [%d/3]",Player[adminid][PlayerName],Player[playerid][PlayerName],GetPVarInt(playerid,"warn"));
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	msg = "";
	format( msg, sizeof(msg), ""SERVER_MSG"Причина:\"%s\"",reason);
	format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Reason:\"%s\"",reason);
	t_SendClientMessageToAll(-1,-1, msg, msgcheatEn);
	if(GetPVarInt(playerid,"warn") > 2){
		if(!LanglePlayer{playerid}) SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#20]");
		else SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#20]");
		t_Kick(playerid);
	}
	return true;
}
protected TeleportPlayerToPlayer(playerid,giveplayerid){//playerid = кого ТПхать
	new Float:pos[4];
	GetPlayerPos(giveplayerid,pos[0],pos[1],pos[2]);
	t_SetPlayerPos(playerid,pos[0]+1.5,pos[1]+1.5,pos[2]+2);
	SetPlayerInterior(playerid,GetPlayerInterior(giveplayerid));
	t_SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(giveplayerid));
	return true;
}
protected BanIPex(adminid,playerid,reason[],daysEx){
	if(Player[adminid][pAdminPlayer] < LEVEL_BANN) return 0;
	if(!IsPlayerConnected(playerid)) return SendClientMessage(adminid, -1,"Этого игрока нет на сервере!");
	if(Player[playerid][pAdminPlayer] > Player[adminid][pAdminPlayer]) return SendClientMessage(adminid, -1, "Ты не можешь забанить администратора старшего или равного тебя!");
	new msg[256];
	format( msg, sizeof(msg), ""SERVER_MSG"Администратор \"{%s}%s{FFFFFF}\" забанил \"{%s}%s{FFFFFF}\"",chatcolor[Player[adminid][pColorPlayer]],Player[adminid][PlayerName],chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
	format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator {FFBF00}\"%s\" has banned \"%s\"",Player[adminid][PlayerName],Player[playerid][PlayerName]);
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	msg = "";
	format( msg, sizeof(msg), ""SERVER_MSG"Причина:\"%s\"",reason);
	format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Reason:\"%s\"",reason);
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	msg = "";
	format( msg, sizeof(msg), "\"%s\" забанил \"%s\", причина:\"%s\"",Player[adminid][PlayerName],Player[playerid][PlayerName],reason);
	WriteRusLog("Ban.cfg", msg);
	AddBan(playerid,adminid,reason,((daysEx==-1)?-1:daysEx*86400));
	Player[playerid][pBanned] = true;
	if(!LanglePlayer{playerid}) SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#18]");
	else SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#18]");
	t_Kick(playerid);
	return true;
}
protected t_GetPlayerInterior(playerid){
	if(IsPlayerConnected(playerid))
		return GetPlayerInterior(playerid);
	else
	    return 0;
}
protected t_GetPlayerVirtualWorld(playerid){
	if(IsPlayerConnected(playerid))
		return GetPlayerVirtualWorld(playerid);
	else
	    return 0;
}
protected GetCarSlotForUID(playerid,uid){
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++)
	{
	    if(!Player[playerid][pAuto][f])
			continue;
		if(uid == Player[playerid][pAutoUID][f])
		    return f;
	}
	return 0;
}
protected GetPlayerSpeedEx(playerid,getsd){
	new Float:xB,Float:yB,Float:zB;
	if(IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid),xB,yB,zB);
	else
	    GetPlayerVelocity(playerid,xB,yB,zB);
	return PlayerSpeed(xB,yB,zB,100.0,getsd);
}
protected bool:incorrectCmdAttempt(playerid, string[]){
		if(string[0] == '.' || string[0] == '?'){
			switch(string[1]){
				case 'а'..'я','А'..'Я':{
					new
						commandEnd, //позиция конца команды
						command[112], //будущяя команда, без параметровnew
						commandRev[112];//Если команда не верная
					strcat(commandRev, string);
                    string[0] = '/';
					for(new i = 1; string[i] != 0x0; i++){
						switch(string[i]){
							case 0xE0..0xFF, 0xC0..0xDF: string[i - 1] = Translate(string[i]); //переводим в англ. раскладку
							case ' ': { commandEnd = i; break; } //если конца команды еще не было, записываем туда текущее состояние переменной i (позиция конца команды)
					}	}
					if(commandEnd){
						strmid(command,string,0,commandEnd - 1); //копируем команду в отдельную переменную
						strins(command,"cmd_",0); //вставляем перфикс cmd_
						if(funcidx(command) < 0 || strlen(command) > 18){
						    format(string, 112, "%s", commandRev);
						    return false;
						}
						CallLocalFunction(command,"ds",playerid,string[commandEnd]); //вызываем команду с параметрами
						return true;
					}else{
						strmid(command,string,0,strlen(string) - 1); //копируем команду в отдельную переменную
						strins(command,"cmd_",0); //вставляем перфикс cmd_
						if(funcidx(command) < 0 || strlen(command) > 18){
						    format(string, 112, "%s", commandRev);
						    return false;
						}
						CallLocalFunction(command,"ds",playerid,"\1"); //вызываем команду
						return true;
		}   }	}	}
		return false;
}
protected getprocent(count,procent){
	new Float:proc =(count/100.0*procent);
	return floatround(proc,floatround_ceil);
}
protected CreateObjectsX(laps,objectid,Float:px, Float:py, Float:pz, Float:rx, Float:ry, ammount, Float:radius, Float:angle=282.0, bool:circleangles=true, Float:rz=0.0)
{
    if(ammount <= 1 || 0.0 <= angle > 360.0 || radius<=0.0) return false;
	for(new l;l<=laps;l++){
		if(l)
			pz = pz-(ammount*2);
		for(new i;i<=(ammount-1);i++)
			printf("<object id=\"obj %d\" doublesided=\"false\" model=\"%d\" interior=\"0\" dimension=\"0\" posX=\"%f\" posY=\"%f\" posZ=\"%f\" rotX=\"%f\" rotY=\"%f\" rotZ=\"%f\"></object>",i,objectid,px+floatsin((angle/ammount)*i, degrees)*radius, py+floatcos((angle/ammount)*i, degrees)*radius, pz-(i*2), rx, ry, circleangles ? (133-(i*8.0)) : (rz));
    }
	return true;
}
protected GetAddres(playerid){
	new ip[16],
		splitt[4][4];
	GetPlayerIp(playerid,ip,sizeof(ip));
	split(ip,splitt,'.');
	return (strval(splitt[0])-strval(splitt[1])+(strval(splitt[2])*2)-strval(splitt[3]));
}
protected RemoveBuildingForPlayerEx(playerid,Float:radius,model,Float:Ex,Float:Ey,Float:Ez)
	return RemoveBuildingForPlayer(playerid, model,Ex,Ey,Ez,radius);
protected SendMess(playerid, color, fstring[]) return SendClientMessage(playerid, color, fstring);
protected Difference(Float:Value1, Float:Value2) { 
        return floatround((Value1 > Value2) ? (Value1 - Value2) : (Value2 - Value1)); 
} 
protected bool: UseCar(carid) { 
	for(new i; i != GetMaxPlayers(); i++) 
	{ 
		if(!IsPlayerConnected(i) || IDVEH[i] != carid) continue; 
		if(IsPlayerInVehicle(i, carid)) return true; 
	} 
	return false; 
} 
new protected airbreakIndexes[] ={
    1231, 1266, 1234, 1189,
    1235, 1136, 1196, 1197,
    1198, 1159, 1133, 1130,
    1129, 1208, 1156
};
protected ShowSpiski(playerid){
	new string[162];
	if(!LanglePlayer{playerid}){
		format(string, sizeof(string), ""LISTS_TEXT"",activetedfrends[playerid],noactivetedfrends[playerid],playersinblacklist[playerid],playerszayavkinses[playerid],messages[playerid]);
		return	ShowPlayerDialog(playerid, 260, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski"", string, "OK", "Назад"),true;
	}else{
		format(string, sizeof(string), ""LISTS_TEXT_EN"",activetedfrends[playerid],noactivetedfrends[playerid],playersinblacklist[playerid],playerszayavkinses[playerid],messages[playerid]);
		return	ShowPlayerDialog(playerid, 260, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski_EN"", string, "OK", "Back"),true;
}	}
protected indextrue(index){
	for (new l = 0; l < sizeof(airbreakIndexes); l ++)
	{
		if (index == airbreakIndexes[l])
 		    return true;
	}
	return false;
}
protected RandomString(medod) {
    new string[8];
	if(medod == 0)
		format(string, 8, "%c%c%i%c", 65+random(26), 65+random(26), 100+random(899), 65+random(26));
	else if(medod == 1)
		format(string, 8, "%c%i%c%c", 65+random(26), 100+random(899), 65+random(26), 65+random(26));
	else
		format(string, 8, "%i%c%c%c", 100+random(899), 65+random(26), 65+random(26), 65+random(26));
    return string;
}
protected SearchNoOwnedClan(){
	for(new i; i < MAX_CLANS; i++){
		if(ClanInfo[i][cCreator] == 0 && ClanInfo[i][cPlayers] == 0)
			return i;
	}
	return -1;
}
protected ReturnClotBD(clanKey){
	for(new i; i < MAX_CLANS; i++){
		if(ClanInfo[i][cKey] == clanKey)
			return i;
	}
	return -1;
}
protected SearchNoOwnedSlot(playerid){
	for(new i; i < MAX_CLANS_ON_PLAYER; i++){
		if(Player[playerid][cClan][i] == INVALID_CLAN_ID)
			return i;
	}
	return -1;
}
protected GetSlotClan(playerid,key){
	for(new i; i < MAX_CLANS_ON_PLAYER; i++){
		if(Player[playerid][cClan][i] == key)
			return i;
	}
	return -1;
}
protected CreateClan(playerid,tag[]){
	if(strlen(tag) > 6)
		SendClientMessage(playerid,-1,""TEXT_CLAN_1"");
	new slot = SearchNoOwnedSlot(playerid);
	if(SearchNoOwnedClan() == -1)
		SendClientMessage(playerid,-1,""TEXT_CLAN_2"");
	else if(slot == -1)
		SendClientMessage(playerid,-1,""TEXT_CLAN_3"");
	new Float:pOs[3],strdate[11], year, month, day;
	getdate(year, month, day);
	format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
	GetPlayerPos(playerid,pOs[0],pOs[1],pOs[2]);	
	format(minidialog, sizeof(minidialog),"INSERT INTO "TABLE_CLANS" (`cID`, `cCreator`, `cPlayers`, `cCordX`, `cCordY`, `cCordZ`, `cTag`, `cColour`, `cTypeSkobok`, `cRate`, `cMoney`, `cRate1`, `cRate2`, `cRate3`, `cRate4`, `cRate5`, `cCreatorName`,`cCreateDate`) VALUES ( NULL, %d,1,%f,%f,%f,'%s',154,1,0,500000,'"RATE_NOOBE"','"RATE_NENOOBE"','"RATE_SVOIE"','"RATE_ZAME"','"RATE_GLAVAE"','%s','%s')",
		Player[playerid][pSQLID],
		pOs[0],pOs[1],pOs[2],
		tag,
		Player[playerid][PlayerName],
		strdate
	);
	SetPVarString(playerid,"cTagEx",tag);
	mysql_function_query(MYSQL, minidialog, true, "CreateClanEx", "d",playerid);
	return true;
}

protected ShowPlayerClans(playerid){
	new clansEx[256];
	for(new f; f < MAX_CLANS_ON_PLAYER; f++){
		if(f)
			strcat(clansEx,"\n");
		if(Player[playerid][cClan][f]){
			new i = ReturnClotBD(Player[playerid][cClan][f]);
			format(clansEx,sizeof(clansEx),"%s{FFFFFF}%d]\t{%s}%s%s%s{FFFFFF}%s(%s{FFFFFF})",clansEx,(f+1),chatcolor[ClanInfo[i][cColour]],skobka1[ClanInfo[i][cTypeSkobok]],ClanInfo[i][cTag],skobka2[ClanInfo[i][cTypeSkobok]],(strlen(ClanInfo[i][cTag])>4)?("\t"):("\t\t"),ReturnColorRateClan(Player[playerid][cClan][f],Player[playerid][cRate][f]));
		}else
			format(clansEx,sizeof(clansEx),"%s{FFFFFF}%d]\t{00f5da}Пусто",clansEx,(f+1));
	}
	strcat(clansEx,"\n"STRELKIEX""TEXT_CLAN_4"\n"STRELKIEX"Самые богатые кланы\n"STRELKIEX"Самые сильные кланы");
	ShowPlayerDialog(playerid, CLAN_DIALOG, DIALOG_STYLE_LIST, ""MENU_PRFX_Klani"", clansEx, "Выбрать", "Назад" );
	return true;
}
protected AddPlayerInClan(playerid,clanKey,rate){
	new Slot = ReturnClotBD(clanKey);
	for(new i; i < MAX_CLANS_ON_PLAYER; i++){
		if(Player[playerid][cClan][i] == INVALID_CLAN_ID){
			ClanInfo[Slot][cPlayers]++;
			Player[playerid][cClan][i] = clanKey;
			Player[playerid][cRate][i] = rate;
			UpdateNick(playerid);
			break;
		}
	}
	new query[168];
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS" SET `cPlayers` = '%d' WHERE `cID` = %d",
		ClanInfo[Slot][cPlayers],
		clanKey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	format(query, sizeof(query),"INSERT INTO "TABLE_CLANS_P" (`cID`, `cUID`, `cClanID`, `cRang`, `cNickName`, `skolkouje`) VALUES ( NULL, %d,%d,%d,'%s',%d)",
		Player[playerid][pSQLID],clanKey,rate,Player[playerid][PlayerName],gettime());
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected KickAllFromClan(clankey){
	for(new f; f < MAX_PLAYERS; f++){
		if(!IsPlayerConnected(f)|| !Player[f][logged]) continue;
		for(new i; i < MAX_CLANS_ON_PLAYER; i++){
			if(Player[f][cClan][i] == clankey){
				Player[f][cClan][i] = INVALID_CLAN_ID;
				Player[f][cRate][i] = NO_RATE;
				UpdateNick(f);
				break;
			}
		}
	}
	new query[112];
	format(query, sizeof(query),"DELETE FROM  "TABLE_CLANS" WHERE `cID` = %d;",
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	format(query, sizeof(query),"DELETE FROM "TABLE_CLANS_P" WHERE `cClanID` = %d",
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected KickPlayerFromClan(uid,clankey){
	new clanid = ReturnClotBD(clankey),
		playerid = GetPlayerID(uid);
	ClanInfo[clanid][cPlayers]--;
	if(playerid != INVALID_PLAYER_ID){
		for(new i; i < MAX_CLANS_ON_PLAYER; i++){
			if(Player[playerid][cClan][i] == clankey){
				Player[playerid][cClan][i] = INVALID_CLAN_ID;
				Player[playerid][cRate][i] = NO_RATE;
				UpdateNick(playerid);
				break;
			}
		}
	}
	new query[112];
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS" SET `cPlayers` = '%d' WHERE `cID` = %d;",
		ClanInfo[clanid][cPlayers],
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	format(query, sizeof(query),"DELETE FROM "TABLE_CLANS_P" WHERE `cUID` = %d && `cClanID` = %d",
		uid,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected ReturnRateClan(clankey,rate){
	new clanid = ReturnClotBD(clankey),
		ranG[12];
	if(!rate)
		strcat(ranG,"Приглашение");
	else{
		switch(rate){
			case RATE_NOOB: 	{strcat(ranG,ClanInfo[clanid][cRate1]);}
			case RATE_NENOOB:	{strcat(ranG,ClanInfo[clanid][cRate2]);}
			case RATE_SVOI:		{strcat(ranG,ClanInfo[clanid][cRate3]);}
			case RATE_ZAM:		{strcat(ranG,ClanInfo[clanid][cRate4]);}
			case RATE_GLAVA:	{strcat(ranG,ClanInfo[clanid][cRate5]);}
	}	}
	return ranG;
}
protected ReturnColorRateClan(clankey,rate){
	new clanid = ReturnClotBD(clankey),
		ranG[22];
	if(!rate)
		strcat(ranG,"{00f5da}Приглашение");
	else{
		switch(rate){
			case RATE_NOOB: 	{strcat(ranG,"{7df9ff}");strcat(ranG,ClanInfo[clanid][cRate1]);}
			case RATE_NENOOB:	{strcat(ranG,"{ffff00}");strcat(ranG,ClanInfo[clanid][cRate2]);}
			case RATE_SVOI:		{strcat(ranG,"{2fff00}");strcat(ranG,ClanInfo[clanid][cRate3]);}
			case RATE_ZAM:		{strcat(ranG,"{0000ff}");strcat(ranG,ClanInfo[clanid][cRate4]);}
			case RATE_GLAVA:	{strcat(ranG,"{ff0000}");strcat(ranG,ClanInfo[clanid][cRate5]);}
	}	}
	return ranG;
}
protected UpdateRate(uid,clankey,rate){
	new playerid = GetPlayerID(uid);
	if(playerid != INVALID_PLAYER_ID){
		for(new i; i < MAX_CLANS_ON_PLAYER; i++){
			if(Player[playerid][cClan][i] == clankey){
				Player[playerid][cRate][i] = rate;
				UpdateNick(playerid);
				break;
			}
		}
	}
	new query[112];
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS_P" SET `cRang` = '%d' WHERE `cUID` = %d && `cClanID` = %d",
		rate,
		uid,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected UpdateClanTag(clankey,tag[]){
	new clanid = ReturnClotBD(clankey);
	format(ClanInfo[clanid][cTag],7,"%s",tag);
	UpdateClanTagEx(clankey);
	new query[112];
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS" SET `cTag` = '%s' WHERE `cID` = %d",
		tag,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected UpdateClanSpawn(clankey,Float:cX,Float:cY,Float:cZ){
	new clanid = ReturnClotBD(clankey),
		query[112];
	ClanInfo[clanid][cCordBase][0] = cX;
	ClanInfo[clanid][cCordBase][1] = cY;
	ClanInfo[clanid][cCordBase][2] = cZ;
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS" SET `cCordX` = '%f', `cCordY` = '%f', `cCordZ` = '%f' WHERE `cID` = %d",
		cX,cY,cZ,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected PlayerGoToBase(playerid,clankey){
	new clanid = ReturnClotBD(clankey);
	t_SetPlayerPos(playerid,ClanInfo[clanid][cCordBase][0],ClanInfo[clanid][cCordBase][1],ClanInfo[clanid][cCordBase][2]);
	return true;
}
protected ShangeRateClan(clankey,rate,text[]){
	new clanid = ReturnClotBD(clankey);
	switch(rate){
		case RATE_NOOB: 	format(ClanInfo[clanid][cRate1],13,"%s",text);
		case RATE_NENOOB:	format(ClanInfo[clanid][cRate2],13,"%s",text);
		case RATE_SVOI:		format(ClanInfo[clanid][cRate3],13,"%s",text);
		case RATE_ZAM:		format(ClanInfo[clanid][cRate4],13,"%s",text);
		case RATE_GLAVA:	format(ClanInfo[clanid][cRate5],13,"%s",text);
	}
	new query[112];
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS" SET `cRate%d` = '%s' WHERE `cID` = %d;",
		rate,
		text,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected ShangeSkobkiClan(clankey,type){
	new clanid = ReturnClotBD(clankey);
	ClanInfo[clanid][cTypeSkobok] = type;
	UpdateClanTagEx(clankey);
	new query[112];
	format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cTypeSkobok` = '%d' WHERE `cID` = %d;",
		type,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected GiveClanMoney(clankey,count){
	new clanid = ReturnClotBD(clankey);
	ClanInfo[clanid][cMoney] += count;
	new query[112];
	format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cMoney` = '%d' WHERE `cID` = %d;",
		ClanInfo[clanid][cMoney],
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected GiveClanRate(clankey,rate){
	new clanid = ReturnClotBD(clankey);
	ClanInfo[clanid][cRate] += rate;
	new query[112];
	format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cRate` = '%d' WHERE `cID` = %d",
		ClanInfo[clanid][cRate],
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected ReturnClanTag(clanid){
	new tag[18];
	strcat(tag,"{");
	strcat(tag,chatcolor[ClanInfo[clanid][cColour]]);
	strcat(tag,"}");
	strcat(tag,skobka1[ClanInfo[clanid][cTypeSkobok]]);
	strcat(tag,ClanInfo[clanid][cTag]);
	strcat(tag,skobka2[ClanInfo[clanid][cTypeSkobok]]);
	return tag;
}
protected ShowClanMembers(playerid,key){
	new query[90];
	format(query,sizeof(query),"SELECT * FROM  "TABLE_CLANS_P" WHERE `cClanID` = %d && `cRang` > 0 ORDER BY `cRang` DESC",key);
	mysql_function_query(MYSQL, query, true, "ShowClanMembersEx", "dd",playerid,key);
	return true;
}

protected ChowClanColorPanel(playerid,clanid){
    bigdialog = "";
	new ColorID[33];
    if(!LanglePlayer{playerid}){
		strcat(bigdialog,"{FFFFFF}Сейчас у клана >{");
		strcat(bigdialog,chatcolor[ClanInfo[clanid][cColour]]);
		format(ColorID,sizeof(ColorID),"}такой [ID%d]{FFFFFF}< цвет\n",ClanInfo[clanid][cColour]);
		strcat(bigdialog,ColorID);
	}else{
		strcat(bigdialog,"{FFFFFF}Now clan >{");
		strcat(bigdialog,chatcolor[Player[playerid][pColorPlayer]]);
		format(ColorID,sizeof(ColorID),"}such [ID%d]{FFFFFF}< color\n",ClanInfo[clanid][cColour]);
		strcat(bigdialog,ColorID);
	}
	if(!LanglePlayer{playerid}){
		msgcheat = "";
		strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI"Управление"STRELKI"Цвет тега");
		strcat(bigdialog,""TEXT_CLAN_12"");
		ShowPlayerDialog(playerid, CLAN_DIALOG+10, DIALOG_STYLE_INPUT, msgcheat,bigdialog, "Ок", "Назад" );
	}else{
		strcat(bigdialog,""TEXT_CLAN_12_EN"");
		ShowPlayerDialog(playerid, CLAN_DIALOG+10, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Change color clan",bigdialog, "Ok", "Back" );
	}
	return true;
}
protected UpdClanColor(clankey,color){
	new clanid = ReturnClotBD(clankey);
	ClanInfo[clanid][cColour] = color;
	new query[112];
	format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cColour` = '%d' WHERE `cID` = %d;",
		color,
		clankey
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
protected GetClanMoney(clankey){
	new clanid = ReturnClotBD(clankey);
	return ClanInfo[clanid][cMoney];
}
protected GetClanColor(clankey){
	new clanid = ReturnClotBD(clankey);
	return ClanInfo[clanid][cColour];
}
protected GetClanRate(clankey){
	new clanid = ReturnClotBD(clankey);
	return ClanInfo[clanid][cRate];
}
protected t_SetPlayerInterior(playerid,interior){
	return SetPlayerInterior(playerid,interior);
}
bool:IsCar(vid){
	vid = GetVehicleModel(vid);
	for(new f; f < sizeof(driftcars); f++){
		if(vid == driftcars[f])
			return true;
	}
	if(vid == 411 || vid == 560 || vid == 504 || vid == 409 || vid == 535 || vid == 603)
		return true;
	return false;
}
new bool:IsCarEx[MAX_PLAYERS];
#define SetPlayerInterior t_SetPlayerInterior
protected GetPlayersInCar(carid,playerid){
	new playersincar;
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged] || i == playerid || GetPlayerVehicleID(i) != carid)continue;
		playersincar++;
	}
	return playersincar++;
}
protected RemovCarDriver(carid){
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f) || !Player[f][logged])continue;
		if(GetPlayerVehicleID(f) == carid && GetPlayerVehicleSeat(f) == 0){
		    new world = GetPlayerVirtualWorld(f),
				Float:pos[3];
			GetPlayerPos(f,pos[0],pos[1],pos[2]);
			SetPlayerVirtualWorld(f,f+100);
			SetPlayerVirtualWorld(f,world);
			t_SetPlayerPos(f,pos[0],pos[1],pos[2]);
			break;
	}	}
	return true;
}
protected ShowClanInfo(playerid,key){
	new query[75];
	format(query,sizeof(query),"SELECT * FROM  "TABLE_CLANS" WHERE `cID` = %d LIMIT 1",key);
	mysql_function_query(MYSQL, query, true, "ShowClanInfoEx", "dd",playerid,key);
	return true;
}
public CreateClanEx(playerid){
	new slotBD = SearchNoOwnedClan(),
		tag[6];
	GetPVarString(playerid,"cTagEx",tag,sizeof(tag));
	ClanInfo[slotBD][cKey] = cache_insert_id();
	ClanInfo[slotBD][cCreator] = Player[playerid][pSQLID];
	ClanInfo[slotBD][cPlayers] = 1;
	ClanInfo[slotBD][cColour] = 154;
	ClanInfo[slotBD][cTypeSkobok] = 1;
	format(ClanInfo[slotBD][cTag],7,"%s",tag);
	format(ClanInfo[slotBD][cRate1],13,"%s",RATE_NOOBE);
	format(ClanInfo[slotBD][cRate2],13,"%s",RATE_NENOOBE);
	format(ClanInfo[slotBD][cRate3],13,"%s",RATE_SVOIE);
	format(ClanInfo[slotBD][cRate4],13,"%s",RATE_ZAME);
	format(ClanInfo[slotBD][cRate5],13,"%s",RATE_GLAVAE);
	ClanInfo[slotBD][cMoney] = PRICE_CLAN/2;
	ClanInfo[slotBD][cRate] = 0;
	ClanInfo[slotBD][cMaxMoneys][1] = -1;
	ClanInfo[slotBD][cMaxMoneys][2] = 100000;
	ClanInfo[slotBD][cMaxMoneys][3] = 250000;
	ClanInfo[slotBD][cMaxMoneys][4] = 1000000;
	ClanInfo[slotBD][cMaxMoneys][5] = 0;
	ClanInfo[slotBD][cInvite][1] = 0;
	ClanInfo[slotBD][cInvite][2] = 0;
	ClanInfo[slotBD][cInvite][3] = 1;
	ClanInfo[slotBD][cInvite][4] = 1;
	ClanInfo[slotBD][cInvite][5] = 1;
	ClanInfo[slotBD][cKick][1] = 0;
	ClanInfo[slotBD][cKick][2] = 0;
	ClanInfo[slotBD][cKick][3] = 0;
	ClanInfo[slotBD][cKick][4] = 1;
	ClanInfo[slotBD][cKick][5] = 1;
	ClanInfo[slotBD][cRangUP][1] = 0;
	ClanInfo[slotBD][cRangUP][2] = 0;
	ClanInfo[slotBD][cRangUP][3] = 0;
	ClanInfo[slotBD][cRangUP][4] = 1;
	ClanInfo[slotBD][cRangUP][5] = 1;
	new Float:pOs[3];
	GetPlayerPos(playerid,pOs[0],pOs[1],pOs[2]);
	UpdateClanSpawn(ClanInfo[slotBD][cKey],pOs[0],pOs[1],pOs[2]);
	AddPlayerInClan(playerid,ClanInfo[slotBD][cKey],5);
	return true;
}
timec(timestamp, compare = -1) {
    if (compare == -1)
        compare = gettime();
    new
        n,
        Float:d = (timestamp > compare) ? timestamp - compare : compare - timestamp,
        returnstr[48];
    if (d < 60) {
        format(returnstr, sizeof(returnstr), "< 1 minute");
        return returnstr;
    } else if (d < 3600) {
        n = floatround(floatdiv(d, 60.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("минута","минуты","минут",n));
    } else if (d < 86400) {
        n = floatround(floatdiv(d, 3600.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("час","часа","часов",n));
    } else if (d < 2592000) {
        n = floatround(floatdiv(d, 86400.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("день","дня","дней",n));
    } else if (d < 31536000) {
        n = floatround(floatdiv(d, 2592000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("месяц","месяца","месяцев",n));
    } else {
        n = floatround(floatdiv(d, 31536000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("год","года","лет",n));
    }
    format(returnstr, sizeof(returnstr), "%d %s", n, returnstr);
    return returnstr;
}
timecsEn(timestamp, compare = -1) {
    if (compare == -1)
        compare = gettime();
    new
        d = ((timestamp > compare) ? timestamp - compare : compare - timestamp),
        returnstr[256],
        str[48],
        year,month,day,hours,minutes,
        bool:one;
    for(new f ; f < 100; f++){
        if(d >= 31556926) {d = d-31556926;year++;}
        else break;
    }
    for(new f ; f < 12; f++){
        if(d >= 2629743) {d = d-2629743;month++;}
        else break;
    }
    for(new f ; f < 31; f++){
        if(d >= 86400) {d = d-86400;day++;}
        else break;
    }
    for(new f ; f < 24; f++){
        if(d >= 3600) {d = d-3600;hours++;}
        else break;
    }
    for(new f ; f < 60; f++){
        if(d >= 60) {d = d-60;minutes++;}
        else break;
    }
    if(year){
        one = true;
		format(str, sizeof(str), "%d %s",year,FormatText("year", "year", "years",year));
		strcat(returnstr, str);
	}
    if(month){
		if(one)strcat(returnstr,", ");else one = true;
		format(str, sizeof(str), "%d %s",month,FormatText("month", "month", "months",month));
		strcat(returnstr, str);
	}
    if(day){
		if(one)strcat(returnstr,", ");else one = true;
	    format(str, sizeof(str), "%d %s",day,FormatText("day", "day", "days",day));
		strcat(returnstr, str);
	}
    if(hours){
		if(one)strcat(returnstr,", ");else one = true;
	    format(str, sizeof(str), "%d %s",hours,FormatText("hour", "hour", "hours",hours));
		strcat(returnstr, str);
	}
    if(minutes){
		if(one)strcat(returnstr,", ");else one = true;
	    format(str, sizeof(str), "%d %s",minutes,FormatText("minute", "minutes", "minutes",minutes));
		strcat(returnstr, str);
	}
    if(d){
        if(one)strcat(returnstr,", ");
	    format(str, sizeof(str), "%d %s",d,FormatText("second", "second", "seconds",d));
		strcat(returnstr, str);
	}
    return returnstr;
}
public ShowClanMembersEx(playerid,key){
	new rows,
		fields,
		string[MAX_PLAYER_NAME],
		stringi[100],
		rangE[22],
		pluid,
		skolkoujee,
		rang;
	cache_get_data(rows, fields);
	bigdialog = "";
	strcat(bigdialog,""TEXT_CLAN_5"");
	for(new i; i < rows; i++){
		cache_get_field_content(i, "skolkouje", string);
		sscanf(string, "d", skolkoujee);
		cache_get_field_content(i, "cUID", string);
		sscanf(string, "d", pluid);
		cache_get_field_content(i, "cRang", string);
		sscanf(string, "d", rang);
		rangE = "";
		strcat(rangE,ReturnColorRateClan(key,rang));
		cache_get_field_content(i, "cNickName", string);
		format(stringi,sizeof(stringi),"{00f5da}[%05d]{FFFFFF}\t\t%15s\t\t{00f5da}%d %16s{FFFFFF}\t%s",pluid,string,/*(strlen(string)>8)?("\t"):("\t\t"),*/rang,rangE/*,(strlen(rangE[8])<5)?("\t\t"):("\t")*/,timec(skolkoujee));
	    strcat(stringi, "\n");
		strcat(bigdialog,stringi);
	}
	msgcheat = "";
	new clanid = ReturnClotBD(key);
	strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
	strcat(msgcheat,ReturnClanTag(clanid));
	strcat(msgcheat,""STRELKI"Состав");
	ShowPlayerDialog(playerid,CLAN_DIALOG+14,DIALOG_STYLE_LIST,msgcheat,bigdialog,"Закрыть","");
	return true;
}
public ShowClanInfoEx(playerid,key){
	new
		rows,
		fields,
		string[MAX_PLAYER_NAME],
		typeskobok,
		color;
	cache_get_data(rows, fields);
	if(rows){
		new clanid = ReturnClotBD(key);
		minidialog = "";
		cache_get_field_content(0, "cColour", string);
		sscanf(string, "d", color);
		cache_get_field_content(0, "cTypeSkobok", string);
		sscanf(string, "d", typeskobok);
		strcat(minidialog,"{FFFFFF}"TEXT_CLAN_6":\t\t\t");
		strcat(minidialog,ReturnClanTag(clanid));
		strcat(minidialog,"\n{FFFFFF}"TEXT_CLAN_7":\t");
		cache_get_field_content(0, "cPlayers", string);
		strcat(minidialog,string);
		strcat(minidialog,"\n"TEXT_CLAN_8":\t\t");
		cache_get_field_content(0, "cCreatorName", string);
		strcat(minidialog,string);
		strcat(minidialog,"\n"TEXT_CLAN_9":\t");
		cache_get_field_content(0, "cRate", string);
		strcat(minidialog,string);
		strcat(minidialog,"\n"TEXT_CLAN_10":\t");
		cache_get_field_content(0, "cCreateDate", string);
		strcat(minidialog,string);
		msgcheat = "";
		strcat(msgcheat,"{FFFFFF}..."STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI""TEXT_CLAN_11"");
		ShowPlayerDialog(playerid,CLAN_DIALOG-1,DIALOG_STYLE_MSGBOX,msgcheat,minidialog,"Закрыть","");
	}
	return true;
}
t_PutPlayerInVehicle( playerid, vehid, mesto = 0){
 	new carid = GetPlayerVehicleID(playerid);
	if(Player[playerid][pJail] || GetVehicleModel(vehid) == 435 || carid == vehid) return false;
	if(carid && GetCarIdPoId(carid,playerid)){
		UpdateVehiclePos(carid, 0); 
		if(!GetPlayersInCar(carid,playerid))
			NoOwned[carid] = true;
		else{
			NoOwned[carid] = false;
			TimeNoOwned[carid] = gettime();
		}//
		GetVehicleParamsEx(carid,	carstate[0],	carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
		SetVehicleParamsEx(carid,	false,		carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
	}
	SetPVarInt(playerid,"NoRemov",3);
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f) || !Player[f][logged])continue;
		if(GetPlayerVehicleID(f) == vehid && GetPlayerVehicleSeat(f) == mesto){
		    new world = GetPlayerVirtualWorld(f);
			SetPlayerVirtualWorld(f,f+100);
			SetPlayerVirtualWorld(f,world);
			break;
	}	}
	switch(Player[playerid][pSpeedom])
	{
		case 1: PlayerTextDrawShow(playerid,Speed2[playerid]);
		case 2: PlayerTextDrawHide(playerid,Speed2[playerid]);
	}
	UseEnter{playerid} = true;
	IDVEH[playerid] = vehid;
	IDSEAT[playerid] = (mesto == 0)?0:1;
	IDTICK[playerid] = GetTickCount();
	IsCarEx[playerid] = IsCar(vehid);
	SetPVarInt(playerid, "AntiBreik", 4+(GetPlayerPing(playerid)/35));
	PlayerCar[playerid] = GetCarIdPoId(vehid,playerid);
	Player[playerid][pCarSpeed] = GetMaxRazgon(GetVehicleModel(vehid))*5;
	Player[playerid][pMaxSpeed] = GetMaxSpeed(GetVehicleModel(vehid))/2*3;
	SetPlayerInterior(playerid,GetVehicleInterior(vehid));
	PutPlayerInVehicle(playerid,vehid,mesto);
	new Float:xr, Float:yr, Float:zr;
    GetVehiclePos(vehid, xr, yr, zr);
    Player[playerid][pPos][0] = xr;
    Player[playerid][pPos][1] = yr;
    Player[playerid][pPos][2] = zr;
   	if(PlayerCar[playerid] && IsValidVehicle(vehid)){
		GetVehicleParamsEx(vehid,	carstate[0],carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
		SetVehicleParamsEx(vehid,	true,		carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
	}
	return true;
}
t_SetSpawnInfo(playerid, team, skin, Float:xD, Float:yD, Float:zD, Float:AngleD, weapon1 = 0, weapon1_ammo = 0, weapon2 = 0, weapon2_ammo = 0, weapon3 = 0, weapon3_ammo = 0){
    Player[playerid][pPos][0] = xD;
    Player[playerid][pPos][1] = yD;
    Player[playerid][pPos][2] = zD;
	return SetSpawnInfo(playerid, team, skin, xD, yD, zD, AngleD, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
}
#define SetSpawnInfo t_SetSpawnInfo
ShowPlayerInfoToUID(playerid,giveplayerUID){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
        if(giveplayerUID == Player[i][pSQLID]){
            minidialog = "";
            new status[16];
            if(!LanglePlayer{playerid}){
				if(Player[i][pAdminPlayer] > 1)
				    strcat(status,"Админ");
				else if(Player[i][pAdminPlayer])
				    strcat(status,"Помощник");
				else if(Player[i][pVIP])
				    strcat(status,"VIP");
				else
				    strcat(status,"Игрок");
				format(minidialog, sizeof(minidialog), "{FFFFFF}=============================\n\nНик:\t\t\t{%s}%s{FFFFFF}\nУровень:\t\t%d\nДеньги:\t\t%d\nСтатус:\t\t\t%s\nБыл на сервере:\tOnline\nU-ID:\t\t\t%d\n\n=============================",
					chatcolor[Player[i][pColorPlayer]],
					Player[i][PlayerName],
					Player[i][pLevel],
					GetPlayerCash(i),
					status,
					Player[i][pSQLID]
				);
				ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Статистика игрока.",minidialog,"Закрыть","");
			}else{
				if(Player[i][pAdminPlayer] > 1)
				    strcat(status,"AdminEx");
				else if(Player[i][pAdminPlayer])
				    strcat(status,"Helper");
				else if(Player[i][pVIP])
				    strcat(status,"VIP");
				else
				    strcat(status,"Player");
				format(minidialog, sizeof(minidialog), "{FFFFFF}=============================\n\nNickname:\t\t{%s}%s{FFFFFF}\nLevel:\t\t\t%d\nMoney:\t\t%d\nStatus:\t\t\t%s\nWas on the server:\tOnline\nU-ID:\t\t\t%d\n\n=============================",
					chatcolor[Player[i][pColorPlayer]],
					Player[i][PlayerName],
					Player[i][pLevel],
					GetPlayerCash(i),
					status,
					Player[i][pSQLID]
				);
				ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Statistics player.",minidialog,"Close","");
			}
			return true;
	}   }
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM "TABLE_ACC" WHERE `id`='%d'", giveplayerUID);
	mysql_function_query(MYSQL, qString, true, "ShowInfoToPlayer", "i", playerid);
	return false;
}
public ShowInfoToPlayer(playerid) {
	new rows, fields,
		string[64],
		aLvl,pVip;
	cache_get_data(rows, fields);
	if(rows)
	{
	    minidialog = "";
	    if(!LanglePlayer{playerid}){
			strcat(minidialog,"{FFFFFF}=============================\n\nНик:\t\t\t");
		    cache_get_field_content(0, "Nickname", string);	strcat(minidialog,string);
			strcat(minidialog,"\nУровень:\t\t");
			cache_get_field_content(0, "level", string);	strcat(minidialog,string);
			strcat(minidialog,"\nДеньги:\t\t");
			cache_get_field_content(0, "Money", string);	strcat(minidialog,string);
			strcat(minidialog,"\nCтатус:\t\t\t");
			cache_get_field_content(0, "AdminEx", string);
			sscanf(string, "d", aLvl);
			cache_get_field_content(0, "VIPg", string);
			sscanf(string, "d", pVip);
			if(aLvl > 1)
			    strcat(minidialog,"Админ");
			else if(aLvl)
			    strcat(minidialog,"Помощник");
			else if(pVip)
			    strcat(minidialog,"VIP");
			else
			    strcat(minidialog,"Игрок");
			strcat(minidialog,"\nБыл на сервере:\t");
			cache_get_field_content(0, "EndOnline", string);
			strcat(minidialog,timec(strval(string)));
			strcat(minidialog," назад\nU-ID:\t\t\t");
			cache_get_field_content(0, "id", string);
			strcat(minidialog,string);
			strcat(minidialog,"\n\n=============================");
			ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Статистика игрока.",minidialog,"Закрыть","");
		}else{
			strcat(minidialog,"{FFFFFF}=============================\n\nNick:\t\t\t");
		    cache_get_field_content(0, "Nickname", string);	strcat(minidialog,string);
			strcat(minidialog,"\nLevel:\t\t\t");
			cache_get_field_content(0, "level", string);	strcat(minidialog,string);
			strcat(minidialog,"\nMoney:\t\t");
			cache_get_field_content(0, "Money", string);	strcat(minidialog,string);
			strcat(minidialog,"\nStatus:\t\t\t");
			cache_get_field_content(0, "AdminEx", string);
			sscanf(string, "d", aLvl);
			cache_get_field_content(0, "VIPg", string);
			sscanf(string, "d", pVip);
			if(aLvl)
			    strcat(minidialog,"AdminEx");
			else if(pVip)
			    strcat(minidialog,"VIP");
			else
			    strcat(minidialog,"Player");
			strcat(minidialog,"\nWas on the server:\t");
			cache_get_field_content(0, "EndOnline", string);
			strcat(minidialog,timecEn(strval(string)));
			strcat(minidialog," old\nU-ID:\t\t\t");
			cache_get_field_content(0, "id", string);
			strcat(minidialog,string);
			strcat(minidialog,"\n\n=============================");
			ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Statistics player.",minidialog,"Close","");
	}   }
}
Razban(playerid){
	Player[playerid][pBanned] = false;
	new bGpci[65],
		zapros[128],
		ip[16],
		splitt[4][4];
	GetPlayerIp(playerid,ip,sizeof(ip));
	split(ip,splitt,'.');
	gpci(playerid,bGpci,64);
	format(zapros, sizeof zapros, "DELETE FROM `banlist` WHERE `bUID`='%d' OR `bPodset` = '%d.%d'",
		Player[playerid][pSQLID],
		strval(splitt[0]),strval(splitt[1])
	);
	mysql_function_query(MYSQL, zapros, false, "", "");
}
SearchBan(playerid){
	new bGpci[65],
		zapros[128],
		ip[16],
		splitt[4][4];
	GetPlayerIp(playerid,ip,sizeof(ip));
	split(ip,splitt,'.');
	gpci(playerid,bGpci,64);
	format(zapros, sizeof zapros, "SELECT * FROM `banlist` WHERE `bUID`='%d' OR `gpci` = '%s' OR `bPodset` = '%d.%d'",
		Player[playerid][pSQLID],
		bGpci,
		strval(splitt[0]),strval(splitt[1])
	);
	mysql_function_query(MYSQL, zapros, true, "SearchBanEx", "i", playerid);
}
public SearchBanEx(playerid) {
	new rows, fields;
	cache_get_data(rows, fields);
	for(new i; i < rows; i++)
	{
		new buffer[70],
			razbanEx,
			uidbanEx;
		cache_get_field_content(i, "bRazban", buffer); razbanEx = strval(buffer);
		cache_get_field_content(i, "bUID", buffer); uidbanEx = strval(buffer);
		new bGpci[65],
			ip[16],
			splitt[4][4],
			bool:ipS,
			bool:uid,
			bool:gpciS;
		GetPlayerIp(playerid,ip,sizeof(ip));
		split(ip,splitt,'.');
		gpci(playerid,bGpci,64);
		format(ip,sizeof(ip),"%s.%s",splitt[0],splitt[1]);
		cache_get_field_content(i, "bPodset", buffer);
		if(!strcmp(buffer,ip,false))
			ipS = true;
		cache_get_field_content(i, "gpci", buffer);
		if(!strcmp(buffer,bGpci,false))
			gpciS = true;
		if(uidbanEx == Player[playerid][pSQLID])
			uid = true;
		if(razbanEx != -1 && razbanEx < gettime() && (ipS && gpciS || uid && strval(buffer) != 0)){
			if(uidbanEx == Player[playerid][pSQLID])
				SendClientMessage(playerid,-1,""SERVER_MSG""TEXT_UNBAN"");
			Razban(playerid);
			return true;
		}
		if(ipS && gpciS || uid && strval(buffer) != 0){
			if(gpciS && uid && !ipS || !gpciS && uid && ipS)
				AddBanEx(playerid,razbanEx);
			minidialog = "";
			strcat(minidialog,"{FFFFFF}Ник:\t\t\t");
			cache_get_field_content(i, "bNick", buffer);
			strcat(minidialog,buffer);
			strcat(minidialog,"\n{00f5da}Дата бана:\t\t");
			cache_get_field_content(i, "bDate", buffer);
			strcat(minidialog,buffer);
			strcat(minidialog,"\n{FFFFFF}Причина:\t\t");
			cache_get_field_content(i, "bReasoon", buffer);
			strcat(minidialog,buffer);
			strcat(minidialog,"\n{00f5da}Забанил:\t\t");
			cache_get_field_content(i, "bAdmin", buffer);
			strcat(minidialog,buffer);
			strcat(minidialog,"\n{FFFFFF}Разбан через:\t\t");
			if(razbanEx == -1)
				strcat(minidialog,"Никогда");
			else
				strcat(minidialog,timec(razbanEx));
			ShowPlayerDialog(playerid,BAN_DIALOG,DIALOG_STYLE_MSGBOX,"{FFFFFF}Вы заблокированы на сервере.",minidialog,"Закрыть","");
			t_Kick(playerid);
			return true;
		}
		else
			Player[playerid][pBanned] = false;
	}
	if(!rows && Player[playerid][pBanned])
		Player[playerid][pBanned] = false;
	return true;
}
AddBan(playerid,adminid,reason[],timeban){
	Player[playerid][pBanned] = true;
	Player[playerid][pCheater]++;
	new bGpci[65],
		bDate[26],
		year, month, day,
		AdminName[MAX_PLAYER_NAME];
		//ip[16],
		//splitt[4][4];
	getdate(year, month, day);
	gettime(hour, minute);
	gpci(playerid,bGpci,64);
	format(bDate,sizeof(bDate),"%02d.%02d.%02d %02d:%02d",day,month,year,hour, minute);
	minidialog = "";
	if(timeban != -1)
		timeban += gettime();
	if(adminid != INVALID_PLAYER_ID)
		strcat(AdminName,Player[adminid][PlayerName]);
	else
		strcat(AdminName,"Drift Empire");
	/*GetPlayerIp(playerid,ip,sizeof(ip));
	split(ip,splitt,'.');
	format(minidialog, sizeof(minidialog),"INSERT INTO `banlist`  ( `bID`, `bUID`, `gpci`, `bReasoon`, `bAdmin`,`bNick`, `bDate`, `bRazban`,`bPodset`) VALUES ( NULL, %d, '%s', '%s', '%s', '%s', '%s', %d, '%d.%d')",
		Player[playerid][pSQLID],
		bGpci,
		reason,
		AdminName,
		Player[playerid][PlayerName],
		bDate,
		timeban,
		strval(splitt[0]),strval(splitt[1])
	);
	mysql_function_query(MYSQL, minidialog, false, "", "");*/
	minidialog = "";
	strcat(minidialog,"{FFFFFF}Ник:\t\t\t");
	strcat(minidialog,Player[playerid][PlayerName]);
	strcat(minidialog,"\n{00f5da}Дата бана:\t\t");
	strcat(minidialog,bDate);
	strcat(minidialog,"\n{FFFFFF}Причина:\t\t");
	strcat(minidialog,reason);
	strcat(minidialog,"\n{00f5da}Забанил:\t\t");
	strcat(minidialog,AdminName);
	strcat(minidialog,"\n{FFFFFF}Разбан через:\t\t");
	if(timeban == -1)
		strcat(minidialog,"Никогда");
	else
		strcat(minidialog,timec(timeban));
	ShowPlayerDialog(playerid,BAN_DIALOG,DIALOG_STYLE_MSGBOX,"{FFFFFF}Вы заблокированы на сервере.",minidialog,"Закрыть","");
}
AddBanEx(playerid,tumeunban){
	Player[playerid][pBanned] = true;
	new bGpci[65],
		bDate[26],
		year, month, day,
		ip[16],
		splitt[4][4];
	getdate(year, month, day);
	gettime(hour, minute);
	gpci(playerid,bGpci,64);
	format(bDate,sizeof(bDate),"%02d.%02d.%02d %02d:%02d",day,month,year,hour, minute);
	minidialog = "";
	GetPlayerIp(playerid,ip,sizeof(ip));
	split(ip,splitt,'.');	
	format(minidialog, sizeof(minidialog),"INSERT INTO `banlist`  ( `bID`, `bUID`, `gpci`, `bReasoon`, `bAdmin`,`bNick`, `bDate`, `bRazban`,`bPodset`) VALUES ( NULL, %d, '%s', '%s', '%s', '%s', '%s', %d, '%d.%d')",
		Player[playerid][pSQLID],
		bGpci,
		"Обход бана",
		"Drift Empire",
		Player[playerid][PlayerName],
		bDate,
		tumeunban,
		strval(splitt[0]),strval(splitt[1])
	);
	mysql_function_query(MYSQL, minidialog, false, "", "");
}
AddInFrend(playerid,giveplayerid){
	if(!LanglePlayer{playerid}){
	    if(!IsPlayerConnected(giveplayerid))
	        return SendClientMessage(playerid, -1, ""SERVER_MSG""NE_NA_SERVERE"");
	    if(Player[playerid][pFrinend][MAX_FRENDS-1])
	        return SendClientMessage(playerid, -1, ""SERVER_MSG"У Вас слишком много друзей, максимум "MAX_FRENDSs".");
		if(InBlackList(playerid,giveplayerid) || InBlackList(giveplayerid,playerid))
	        return SendClientMessage(playerid, -1, ""SERVER_MSG"Ошибка доступа.");
	}else{
	    if(!IsPlayerConnected(giveplayerid))
	        return SendClientMessage(playerid, -1, ""SERVER_MSG""NE_NA_SERVERE_EN"");
	    if(Player[playerid][pFrinend][MAX_FRENDS-1])
	        return SendClientMessage(playerid, -1, ""SERVER_MSG"You have too many friends, at most "MAX_FRENDSs".");
		if(InBlackList(playerid,giveplayerid) || InBlackList(giveplayerid,playerid))
	        return SendClientMessage(playerid, -1, ""SERVER_MSG"Access error.");
	}
	new msg[200];
	if(!LanglePlayer{giveplayerid}){
		format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s{FFFFFF} хочет добавить Вас в друзья.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
		SendClientMessage(giveplayerid,-1,msg);
		SendClientMessage(giveplayerid,-1,""SERVER_MSG"Принять или отклонить заявку можно в меню \"Списки\".");
	}else{
		format(msg,sizeof(msg),""SERVER_MSG"Player {%s}%s{FFFFFF} wants to add you as a friend.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
		SendClientMessage(giveplayerid,-1,msg);
		SendClientMessage(giveplayerid,-1,""SERVER_MSG"It is possible to accept or reject the request in the menu \"Lists\".");
	}
    minidialog = "";
 	format(minidialog, sizeof(minidialog),"INSERT INTO  "FRENDS_TABLE" ( `pUID`, `fUID`, `DateAdd`,`fName`,`pName`,Accepted) VALUES ( %i,%i, %d,'%s','%s',0)",
		Player[playerid][pSQLID],
		Player[giveplayerid][pSQLID],
	    gettime(),
	    Player[giveplayerid][PlayerName],
	    Player[playerid][PlayerName]
	);
	mysql_function_query(MYSQL, minidialog, true, "UpdateIDfb", "ii",playerid,giveplayerid);
	return true;
}
protected AddExFrende(playerid,giveuid){
	playerszayavkinses[playerid]--;
	activetedfrends[playerid]++;
	for(new f; f < MAX_FRENDS; f++){
		if(!Player[playerid][pFrinend][f]){
			Player[playerid][pFrinend][f] = giveuid;
			break;
		}
	}
	new giveplayerid = GetPlayerID(useduid[playerid]);
	if(giveplayerid != -1){
		noactivetedfrends[giveplayerid]--;
		activetedfrends[giveplayerid]++;
		for(new f; f < MAX_FRENDS; f++){
			if(!Player[giveplayerid][pFrinend][f]){
				Player[giveplayerid][pFrinend][f] = Player[playerid][pSQLID];
				break;
			}
		}
	}
	return false;
}
bool:IsFrende(playerid,giveplayerid){
	for(new f; f < MAX_FRENDS; f++)
		if(Player[playerid][pFrinend][f] == Player[giveplayerid][pSQLID])
			return true;
	return false;
}
bool:IsNoActFrende(playerid,giveplayerid){
	for(new f; f < MAX_FRENDS; f++)
		if(Player[playerid][pNoActFrinend][f] == Player[giveplayerid][pSQLID])
			return true;
	return false;
}
protected bool:InBlackList(playerid,giveplayerid){
	for(new f; f < MAX_FRENDS; f++)
		if(Player[playerid][pBlackList][f] == Player[giveplayerid][pSQLID])
			return true;
	return false;
}
bool:IsFrendeUID(playerid,giveuid){
	for(new f; f < MAX_FRENDS; f++)
		if(Player[playerid][pFrinend][f] == giveuid)
			return true;
	return false;
}
bool:IsNoActFrendeUID(playerid,giveuid){
	for(new f; f < MAX_FRENDS; f++)
		if(Player[playerid][pNoActFrinend][f] == giveuid)
			return true;
	return false;
}
bool:InBlackListUID(playerid,giveuid){
	for(new f; f < MAX_FRENDS; f++)
		if(Player[playerid][pBlackList][f] == giveuid)
			return true;
	return false;
}
RemoveInFrendUID(playerid,giveuid){//UID
    if(!IsFrendeUID(playerid,giveuid) && !IsNoActFrendeUID(playerid,giveuid))
        return true;
    minidialog = "";
 	format(minidialog, sizeof(minidialog),"DELETE FROM  "FRENDS_TABLE" WHERE `fUID` = %d && `pUID` = %d",giveuid,Player[playerid][pSQLID]);
	mysql_function_query(MYSQL, minidialog, false, "", "");
    minidialog = "";
 	format(minidialog, sizeof(minidialog),"DELETE FROM  "FRENDS_TABLE" WHERE `pUID` = %d && `fUID` = %d",giveuid,Player[playerid][pSQLID]);
	mysql_function_query(MYSQL, minidialog, true, "UpdateIDfb", "ii",playerid,giveuid);
	return true;
}
RemoveInBlackUID(playerid,giveuid){//UID
    if(!InBlackListUID(playerid,giveuid))
        return true;
    minidialog = "";
 	format(minidialog, sizeof(minidialog),"DELETE FROM  "BLACKLIST_TABLE" WHERE `bUID` = %d",giveuid);
	mysql_function_query(MYSQL, minidialog,  true, "UpdateIDfb", "ii",playerid,INVALID_PLAYER_ID);
	return true;
}
ShowActivitedFrends(playerid){
	if(!LanglePlayer{playerid}){
	    if(!activetedfrends[playerid] && !noactivetedfrends[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski""STRELKI"Список друзей","{FFFFFF}Ты пока что никого не добавил в друзья.","Закрыть", "" );
	}else{
	    if(!activetedfrends[playerid] && !noactivetedfrends[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski_EN""STRELKI"List of friends","{FFFFFF}You meanwhile added nobody as a friend.","Close", "" );
	}
    minidialog = "";
 	format(minidialog, sizeof minidialog, "SELECT * FROM `frends` WHERE `pUID`= %d && `Accepted`= 1 || `fUID`= %d && `Accepted`= 1",Player[playerid][pSQLID],Player[playerid][pSQLID]);
 	mysql_function_query(MYSQL, minidialog,  true, "ShowActivitedFrendss", "i",playerid);
	return true;
}
public ShowActivitedFrendss(playerid){
	new
		rows,
		fields,
		string[MAX_PLAYER_NAME]
	;
	cache_get_data(rows, fields);
	bigdialog = "";
	if(!rows)
	    strcat(bigdialog, "У Вас пока что нету друзей которые подтвердили заявку.");
	for(new i; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
	    string = "";
	    if(i)
 			strcat(bigdialog, "\n");
		if(i % 2)
			strcat(bigdialog, "{00f5da}");
		else
  			strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog, string);
		cache_get_field_content(i, "fName", string);
  		if(!strcmp(string,Player[playerid][PlayerName],false))
			cache_get_field_content(i, "pName", string);
	    strcat(bigdialog, string);
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, FREND_DIALOG+1, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Список друзей", bigdialog, "Выбрать", "Закрыть" );
	else
		ShowPlayerDialog(playerid, FREND_DIALOG+1, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Friend list", bigdialog, "Select", "Close" );
	return true;
}
ShowNoActivitedFrends(playerid){
	if(!LanglePlayer{playerid}){
	    if(!noactivetedfrends[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski""STRELKI"Список друзей","{FFFFFF}У тебя нету друзей, которые ещё не подтвердили заявку.","Закрыть", "" );
	}else{
	    if(!noactivetedfrends[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski_EN""STRELKI"Friend list","{FFFFFF}You have no friends who yet didn't confirm the request.","Close", "" );
	}
	minidialog = "";
 	format(minidialog, sizeof minidialog, "SELECT * FROM `frends` WHERE `pUID` = %d && `Accepted` = 0", Player[playerid][pSQLID]);
	mysql_function_query(MYSQL, minidialog,  true, "ShowNoActivitedFrendss", "i",playerid);
	return true;
}
public ShowNoActivitedFrendss(playerid){
	new
		rows,
		fields,
		string[MAX_PLAYER_NAME]
	;
	cache_get_data(rows, fields);
	bigdialog = "";
	if(!rows)
	    strcat(bigdialog, "У Вас нету друзей которые не подтвердили заявку.");
	for(new i; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
	    string = "";
	    if(i)
 			strcat(bigdialog, "\n");
		if(i % 2)
			strcat(bigdialog, "{00f5da}");
		else
  			strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog, string);
		cache_get_field_content(i, "fName", string);
	    strcat(bigdialog, string);
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, FREND_DIALOG+2, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Заявки", bigdialog, "Выбрать", "Закрыть" );
	else
		ShowPlayerDialog(playerid, FREND_DIALOG+2, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Requests", bigdialog, "Select", "Close" );
	return true;
}
ShowBlackListMini(playerid){
	if(!LanglePlayer{playerid}){
	    if(!playersinblacklist[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski""STRELKI"ЧС","{FFFFFF}У тебя нету людей в ЧС.","Закрыть", "" );
	}else{
	    if(!playersinblacklist[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski_EN""STRELKI"BL","{FFFFFF}You have no people in an emergency.","Close", "" );
	}
	minidialog = "";
 	format(minidialog, sizeof minidialog, "SELECT * FROM "BLACKLIST_TABLE" WHERE `pUID`= %d", Player[playerid][pSQLID]);
	mysql_function_query(MYSQL, minidialog,  true, "ShowBlackListMinii", "i",playerid);
	return true;
}
public ShowBlackListMinii(playerid){
	new
		rows,
		fields,
		string[MAX_PLAYER_NAME]
	;
	cache_get_data(rows, fields);
	bigdialog = "";
	if(!rows)
	    strcat(bigdialog, "У Вас пока что нету людей в ЧС.");
	for(new i; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
	    string = "";
	    if(i)
 			strcat(bigdialog, "\n");
		if(i % 2)
			strcat(bigdialog, "{00f5da}");
		else
  			strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog, string);
		cache_get_field_content(i, "bName", string);
	    strcat(bigdialog, string);
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, FREND_DIALOG+3, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Черный список", bigdialog, "Выбрать", "Закрыть" );
	else
		ShowPlayerDialog(playerid, FREND_DIALOG+3, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Black list", bigdialog, "Select", "Close" );
	return true;
}
ShowZaiyavkiInFrends(playerid){
	if(!LanglePlayer{playerid}){
	    if(!playerszayavkinses[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski""STRELKI"Список друзей","{FFFFFF}У тебя нету входящих заявок в друзья.","Закрыть", "" );
	}else{
	    if(!playerszayavkinses[playerid])
			return ShowPlayerDialog(playerid, FREND_DIALOG+20, DIALOG_STYLE_MSGBOX,""MENU_PRFX_Spiski_EN""STRELKI"Friend List","{FFFFFF}You have no entering requests in friends.","Close", "" );
	}
	minidialog = "";
 	format(minidialog, sizeof minidialog, "SELECT * FROM `frends` WHERE `fUID`= %d && `Accepted`= 0", Player[playerid][pSQLID]);
 	mysql_function_query(MYSQL, minidialog,  true, "ShowZaiyavkiInFrendss", "i",playerid);
	return true;
}
public ShowZaiyavkiInFrendss(playerid){
	new
		rows,
		fields,
		string[MAX_PLAYER_NAME]
	;
	cache_get_data(rows, fields);
	bigdialog = "";
	if(!rows)
	    strcat(bigdialog, "У Вас нету заявок в друзья.");
	for(new i; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
	    string = "";
	    if(i)
 			strcat(bigdialog, "\n");
		if(i % 2)
			strcat(bigdialog, "{00f5da}");
		else
  			strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog, string);
		cache_get_field_content(i, "pName", string);
	    strcat(bigdialog, string);
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, FREND_DIALOG+4, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Заявки в друзья", bigdialog, "Выбрать", "Закрыть" );
	else
		ShowPlayerDialog(playerid, FREND_DIALOG+4, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Requests in friends", bigdialog, "Select", "Close" );
	return true;
}
AddInBlackList(playerid,giveplayerid){
    if(!LanglePlayer{playerid}){
	    if(!IsPlayerConnected(giveplayerid))
	        return SendClientMessage(playerid, -1, ""SERVER_MSG""NE_NA_SERVERE"");
	    if(Player[playerid][pBlackList][MAX_FRENDS-1])
	        return SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_FREND_1" "MAX_FRENDSs".");
	}else{
	    if(!IsPlayerConnected(giveplayerid))
	        return SendClientMessage(playerid, -1, ""SERVER_MSG""NE_NA_SERVERE_EN"");
	    if(Player[playerid][pBlackList][MAX_FRENDS-1])
	        return SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_FR_1_EN" "MAX_FRENDSs".");
	}
    minidialog = "";
 	format(minidialog, sizeof(minidialog),"INSERT INTO  "BLACKLIST_TABLE" ( `pUID`, `bUID`, `DateAdd`,`bName`) VALUES ( %i,%i, %d,'%s')",
		Player[playerid][pSQLID],
		Player[giveplayerid][pSQLID],
	    gettime(),
	    Player[giveplayerid][PlayerName]
	);
	mysql_function_query(MYSQL, minidialog, true, "UpdateIDfb", "ii",playerid,INVALID_PLAYER_ID);
	return true;
}
public UpdateIDm(playerid){
	for(new i = 0; i < 10; i++){
	    messagesid[playerid][i] = 0;
	}
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM `messages` WHERE `pUID`= %d LIMIT 10",Player[playerid][pSQLID]);
	mysql_function_query(MYSQL,qString,true, "UpdateMID", "i",playerid);
}
public UpdateMID(playerid){
	new
		rows,
		fields,
		string[10]
	;
	messages[playerid] = 0;
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i++){
	    if(i >= 10) break;
	    cache_get_field_content(i, "ID", string);
	    messagesid[playerid][i] = strval(string);
		messages[playerid]++;
	}
	if(messages[playerid]){
	 	new stringEx[256];
	 	if(!LanglePlayer{playerid})
	 		format(stringEx, sizeof stringEx, ""SERVER_MSG""TEXT_FREND_2"",messages[playerid],FormatText("не прочитанное","непрочитанных","непрочитанных",messages[playerid]),FormatText("уведомление","уведомлений","уведомлений",messages[playerid]));
		else
	 		format(stringEx, sizeof stringEx, ""SERVER_MSG""TEXT_FREND_2_EN"",messages[playerid],FormatText("unread", "unread", "the unread",messages[playerid]),FormatText("notification message", "notification messages", "notification messages",messages[playerid]));
		SendClientMessage(playerid, -1, stringEx);
 	}
	return true;
}
ShowMessages(playerid){
    if(!messages[playerid])
        return SendClientMessage(playerid, -1, ""SERVER_MSG"У Вас нету непрочитанных уведомлений.");
    new string[64];
 	format(string, sizeof string, "SELECT * FROM `messages` WHERE `pUID`= %d LIMIT 10",Player[playerid][pSQLID]);
 	mysql_function_query(MYSQL, string,  true, "ShowMessagess", "i",playerid);
	return true;
}
public ShowMessagess(playerid){
	new
		rows,
		fields,
		string[48]
	;
	cache_get_data(rows, fields);
	bigdialog = "";
	for(new i; i < rows; i++){
	    if(i >= 10) break;
	    string = "";
	    if(i)
 			strcat(bigdialog, "\n");
		if(i % 2)
			strcat(bigdialog, "{00f5da}");
		else
  			strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog, string);
		cache_get_field_content(i, "MsgTheard", string);
	    strcat(bigdialog, string);
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, MESSAGES_LIST, DIALOG_STYLE_LIST, "Уведомления", bigdialog, "Читать", "Закрыть" );
	else
		ShowPlayerDialog(playerid, MESSAGES_LIST, DIALOG_STYLE_LIST, "Notification messages", bigdialog, "Read", "Close" );
	return true;
}			
ShowBankLog(playerid,keyclan){
    new string[80];
 	format(string, sizeof string, "SELECT * FROM `BankLog` WHERE `lClanID`= %d ORDER BY `lDate` DESC LIMIT 10",keyclan);
 	mysql_function_query(MYSQL, string,  true, "ShowLogBank", "id",playerid,keyclan);
	return true;
}
public ShowLogBank(playerid,keyclan){
	new
		rows,
		fields,
		string[48],
		clanid = ReturnClotBD(keyclan);
	cache_get_data(rows, fields);
	bigdialog = "";
	msgcheat = "";
	strcat(msgcheat,"{FFFFFF}..."STRELKI"");
	strcat(msgcheat,ReturnClanTag(clanid));
	strcat(msgcheat,""STRELKI"Банк"STRELKI"Операции");
	strcat(bigdialog, "{FFFFFF}");
	if(rows){
		for(new i; i < rows; i++){
			if(i >= 10) break;
			string = "";
			if(i) strcat(bigdialog, "\n");
			strcat(bigdialog, "[");
			cache_get_field_content(i, "lDate", string);
			strcat(bigdialog, timec(strval(string)));
			strcat(bigdialog, " назад]\t");
			cache_get_field_content(i, "lNick", string);
			strcat(bigdialog, string);
			strcat(bigdialog, " ");
			cache_get_field_content(i, "lText", string);
			strcat(bigdialog, string);
		}
	} else
	    strcat(bigdialog, "{FFFFFF}За прошедшую неделю операций небыло.");
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, CLAN_DIALOG-2, DIALOG_STYLE_MSGBOX, msgcheat, bigdialog, "Закрыть", "" );
	else
		ShowPlayerDialog(playerid, CLAN_DIALOG-2, DIALOG_STYLE_MSGBOX, msgcheat, bigdialog, "Close", "" );
	return true;
}
ShowMsg(playerid,msgid){
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM `messages` WHERE `ID`='%d'", msgid);
	mysql_function_query(MYSQL, qString, true, "showmsgs", "id", playerid,msgid);
}
public showmsgs(playerid,msgid) {
	new rows, fields;
	cache_get_data(rows, fields);
	if(rows)
	{
	    new text[256],
	        theard[48];
		cache_get_field_content(0, "Msg", text);
		cache_get_field_content(0, "MsgTheard", theard);
		ShowPlayerDialog(playerid, MESSAGES_LIST+1, DIALOG_STYLE_MSGBOX, theard, text, "Удалить","");
		theard = "";
		format(theard, sizeof(theard), "DELETE FROM `messages` WHERE `ID`='%d'", msgid);
		mysql_function_query(MYSQL, theard, true, "UpdateIDm", "i", playerid);
}	}
ShowPersTeleList(playerid){
    minidialog = "";
 	format(minidialog, sizeof minidialog, "SELECT * FROM `teleports` WHERE `pUID`= %d LIMIT 20",Player[playerid][pSQLID]);
 	mysql_function_query(MYSQL, minidialog,  true, "ShowPersTeleLis", "i",playerid);
	return true;
}
public ShowPersTeleLis(playerid){
	new
		rows,
		fields,
		string[48]
	;
	cache_get_data(rows, fields);
	Teleports[playerid] = 0;
	bigdialog = "";
	for(new i; i < rows; i++){
	    if(i > MAX_TELEPORTS) break;
	    Teleports[playerid]++;
	    cache_get_field_content(i, "tPosX", string);		Player[playerid][ptPosX][i] = floatstr(string);
	    cache_get_field_content(i, "tPosY", string);		Player[playerid][ptPosY][i] = floatstr(string);
	    cache_get_field_content(i, "tPosZ", string);		Player[playerid][ptPosZ][i] = floatstr(string);
	    cache_get_field_content(i, "tPosA", string);		Player[playerid][ptPosA][i] = floatstr(string);
	    cache_get_field_content(i, "tID", string);			Player[playerid][ptID][i] = strval(string);
	    string = "";
	    if(i)
 			strcat(bigdialog, "\n");
		if(i % 2)
			strcat(bigdialog, "{00f5da}");
		else
  			strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog, string);
		cache_get_field_content(i, "tName", string);
	    strcat(bigdialog, string);
	}
	if(Teleports[playerid] < MAX_TELEPORTS){
		if(!LanglePlayer{playerid})
			strcat(bigdialog,"\n"STRELKIEX"Пусто ({00f5da}Добавить{FFFFFF})");
		else
			strcat(bigdialog,"\n"STRELKIEX"Empty ({00f5da}Add{FFFFFF})");
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, TELEPORTS_LIST, DIALOG_STYLE_LIST, ""MENU_PRFX_TP""STRELKI"Мои телепорты", bigdialog, "Выбрать", "Назад" );
	else
		ShowPlayerDialog(playerid, TELEPORTS_LIST, DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN""STRELKI"My teleports", bigdialog, "Select", "Back" );
	return true;
}
protected AddTp(playerid,name[],Float:PosXEx,Float:PosYEx,Float:PosZEx,Float:PosA){
    if(strlen(name) > 24)
        return SendClientMessage(playerid, -1, ""SERVER_MSG"Слишком длинное название точки ТП."),1;
    minidialog = "";
	format(minidialog, sizeof(minidialog),"INSERT INTO  `teleports` ( `pUID`,`tPosX`, `tPosY`, `tPosZ`,`tPosA`,`tName`) VALUES ( %i,%f,%f,%f,%f,'%s')",
		Player[playerid][pSQLID],
		PosXEx,
		PosYEx,
		PosZEx,
		PosA,
	    name
	);
    mysql_function_query(MYSQL, minidialog, false, "", "");
	return true;
}
protected GetSquareDistance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2){
	x1-=x2;
	y1-=y2;
	z1-=z2;
	x1*=x1;
	y1*=y1;
	z1*=z1;
	return floatround(x1+y1+z1);
}
public UpdateIDfb(playerid,andplayerid){
	new qString[128];
    if(IsPlayerConnected(playerid)){
		for(new i = 0; i < MAX_FRENDS; i++){
		    Player[playerid][pBlackList][i] = 0;
		    Player[playerid][pFrinend][i] = 0;
		    Player[playerid][pNoActFrinend][i] = 0;
		    Player[playerid][pZayavki][i] = 0;
		}
		format(qString, sizeof qString, "SELECT * FROM "FRENDS_TABLE" WHERE `pUID`= %d || `fUID`= %d",Player[playerid][pSQLID],Player[playerid][pSQLID]);
	    mysql_function_query(MYSQL,qString,true, "UpdateFID", "i",playerid);
		qString = "";
		format(qString, sizeof qString, "SELECT * FROM "FRENDS_TABLE" WHERE `fUID`= %d && `Accepted`= 0", Player[playerid][pSQLID]);
	    mysql_function_query(MYSQL,qString,true, "UpdateZID", "i",playerid);
		qString = "";
		format(qString, sizeof qString, "SELECT * FROM "BLACKLIST_TABLE" WHERE `pUID`= %d", Player[playerid][pSQLID]);
	    mysql_function_query(MYSQL,qString,true, "UpdateBID", "i",playerid);
    }
    if(andplayerid != INVALID_PLAYER_ID && IsPlayerConnected(andplayerid) && andplayerid != playerid){
        qString = "";
		for(new i = 0; i < MAX_FRENDS; i++){
		    Player[andplayerid][pBlackList][i] = 0;
		    Player[andplayerid][pFrinend][i] = 0;
		    Player[andplayerid][pNoActFrinend][i] = 0;
		    Player[andplayerid][pZayavki][i] = 0;
		}
		format(qString, sizeof qString, "SELECT * FROM "FRENDS_TABLE" WHERE `pUID`= %d || `fUID`= %d",Player[andplayerid][pSQLID],Player[andplayerid][pSQLID]);
	    mysql_function_query(MYSQL,qString,true, "UpdateFID", "i",andplayerid);
		qString = "";
		format(qString, sizeof qString, "SELECT * FROM "FRENDS_TABLE" WHERE `fUID`= %d && `Accepted`= 0", Player[andplayerid][pSQLID]);
	    mysql_function_query(MYSQL,qString,true, "UpdateZID", "i",andplayerid);
		qString = "";
		format(qString, sizeof qString, "SELECT * FROM "BLACKLIST_TABLE" WHERE `pUID`= %d", Player[andplayerid][pSQLID]);
	    mysql_function_query(MYSQL,qString,true, "UpdateBID", "i",andplayerid);
    }
    return true;
}
public UpdateZID(playerid){
	new
		rows,
		fields,
		string[10]
	;
	playerszayavkinses[playerid] = 0;
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
	    cache_get_field_content(i, "pUID", string);
	    Player[playerid][pZayavki][i] = strval(string);
		playerszayavkinses[playerid]++;
	}
	return true;
}
public UpdateFID(playerid){
	new
		rows,
		fields,
		string[10],
		stringe[10]
	;
	activetedfrends[playerid] = 0;
	noactivetedfrends[playerid] = 0;
	cache_get_data(rows, fields);
	for(new i; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
   	    cache_get_field_content(i, "fUID", string);
   	    if(strval(string) == Player[playerid][pSQLID])
   	    	cache_get_field_content(i, "pUID", string);
	    cache_get_field_content(i, "Accepted", stringe);
	    if(strval(stringe)){
	  		Player[playerid][pFrinend][activetedfrends[playerid]] = strval(string);
	        activetedfrends[playerid]++;
		}else{
			new stri[MAX_PLAYER_NAME];
   	    	cache_get_field_content(i, "pName", stri);
		    if(!strcmp(stri,Player[playerid][PlayerName],false))
		    {
		  		Player[playerid][pNoActFrinend][noactivetedfrends[playerid]] = strval(string);
		        noactivetedfrends[playerid]++;
	}	}   }
	return true;
}
public UpdateBID(playerid){
	new
		rows,
		fields,
		string[10]
	;
	playersinblacklist[playerid] = 0;
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i++){
	    if(i >= MAX_FRENDS) break;
	    cache_get_field_content(i, "bUID", string);
	    Player[playerid][pBlackList][i] = strval(string);
		playersinblacklist[playerid]++;
	}
	return true;
}
SendClanMessage(clankey,text[]){
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f) || !Player[f][logged] || GetSlotClan(f,clankey) == -1 || Player[f][cRate][GetSlotClan(f,clankey)] < 1) continue;
		SendClientMessage(f,-1,text);	
	}
	return true;
}
t_SendClientMessageToAll(ct,color,text[],textEn[]){
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f) || !Player[f][logged] || Player[f][pCt] != ct && ct != -1)continue;
		if(!LanglePlayer{f} && text[0])
			SendClientMessage(f,color,text);
		else if(LanglePlayer{f} && textEn[0])
			SendClientMessage(f,color,textEn);
	}
	return true;
}
AutoFlip(vehid){
	new Float:Coord[5];
    GetVehicleRotationQuat(vehid, Coord[0], Coord[1], Coord[2], Coord[3]);
    GetVehicleHealth(vehid,Coord[4]);
    if(Coord[1] >= 0.1 || Coord[4] < 300.0){
	    GetVehicleZAngle(vehid, Coord[0]);
	    SetVehicleZAngle(vehid, Coord[0]);
}   }
t_RepairVehicle(vehid){
	if(GetVehicleDistanceFromPoint(vehid, 1675.0460205078,-1341.9420166016,160.88900756836) < 50) return true;
	RepairVehicle(vehid);
	SetVehicleHealth(vehid,1000);
	return true;
}
#define RepairVehicle t_RepairVehicle
#define SetPlayerWantedLevel t_SetPlayerWantedLevel
t_LinkVehicleToInterior(carid,interie){
	LinkVehicleToInterior(carid,interie);
	interier[carid] = interie;
	return true;
}
GetVehicleInterior(carid) return interier[carid];
t_CreateVehicle(car,Float:pos1,Float:pos2,Float:pos3,Float:Angled,Color1,Color2,seconded){
	seconded = -1;
	new carid = CreateVehicle(car,Float:pos1,Float:pos2,Float:pos3,Float:Angled,Color1,Color2,seconded);
	SetVehicleParamsEx(carid,0,(hour < 7 || hour > 21)?1:0,0,0,0,0,0);
	interier[carid] = 0;
	new string[25];
	format(string,sizeof(string),"{000000}[DE %04d]",carid);
	SetVehicleNumberPlate(carid,string);
	return carid;
}
t_SetPlayerPos( playerid, Float:x22, Float:y22, Float:z22 ){
    Player[playerid][pPos][0] = x22;
    Player[playerid][pPos][1] = y22;
    Player[playerid][pPos][2] = z22;
	SetPVarInt(playerid, "AntiBreik", 4+(GetPlayerPing(playerid)/35));
	TogglePlayerControllable(playerid, 0);
	SetPVarInt(playerid,"UnFreeze",1);
	SetPVarInt(playerid,"NoDrift",10);
	OldTP[playerid] = gettime();
	if(countid[playerid] != INVALID_COUNT_ID){
	    if(!LanglePlayer{playerid})
			SendClientMessage(playerid,-1,""SERVER_MSG"Ты покинул зону отсчета!"); else	SendClientMessage(playerid,-1,""SERVER_MSG"You left a counting zone!");
		if(countid[playerid] == playerid)
			StopCount(playerid);
		else
			countid[playerid] = INVALID_COUNT_ID;
	}
	return SetPlayerPos( playerid, x22, y22, z22+0.5);
}
t_SetVehiclePos(vehid, Float:x23, Float:y23, Float:z23 ){
	if(GetPlayerVehicleID(carowner[vehid]) != vehid || GetPlayerState(carowner[vehid]) != PLAYER_STATE_DRIVER)
		carowner[vehid] = INVALID_PLAYER_ID;
	if(carowner[vehid] == INVALID_PLAYER_ID){
		for(new i; i < MAX_PLAYERS; i++){
			if(!IsPlayerConnected(i)|| !Player[i][logged] || GetPlayerState(i) != PLAYER_STATE_DRIVER) continue;
			if(GetPlayerVehicleID(i) == vehid){
				carowner[vehid] = i;
				break;
	}	}	}
	UpdateVehiclePos(vehid, 0); 
	if(carowner[vehid] != INVALID_PLAYER_ID){
		TogglePlayerControllable(carowner[vehid], 0);
		SetPVarInt(carowner[vehid],"UnFreeze",1);
		if(countid[carowner[vehid]] != INVALID_COUNT_ID){
			if(!LanglePlayer{carowner[vehid]})
				SendClientMessage(carowner[vehid],-1,""SERVER_MSG"Ты покинул зону отсчета!"); else	SendClientMessage(carowner[vehid],-1,""SERVER_MSG"You left a counting zone!");
			if(countid[carowner[vehid]] == carowner[vehid])
				StopCount(carowner[vehid]);
			else
				countid[carowner[vehid]] = INVALID_COUNT_ID;
		}
		Player[carowner[vehid]][pPos][0] = x23;
		Player[carowner[vehid]][pPos][1] = y23;
		Player[carowner[vehid]][pPos][2] = z23;
		SetPVarInt(carowner[vehid], "AntiBreik", 4+(GetPlayerPing(carowner[vehid])/35));
		new Float:Coord;
		GetVehicleZAngle(vehid, Coord);
		SetVehicleZAngle(vehid, Coord);
	}
	return SetVehiclePos(vehid,x23,y23,z23+1.0);
}
t_SetPlayerVirtualWorld(playerid,virt){
	SetPVarInt(playerid,"FakeVirt",0);
	SetPlayerVirtualWorld(playerid,virt);
	SetPlayerTeam(playerid, virt*playerid);
	return true;
}
t_SetVehicleVirtualWorld(playerid,carid,virt){
	SetVehicleVirtualWorld(carid,virt);
	if(GetCarIdPoId(carid,playerid))
		Player[playerid][cWorld][PlayerCar[playerid]] = virt;
}
protected GetPlayerSpeed(const playerid, bool: check3d = true){
	new Float: coord[ 3 ];
	if( IsPlayerInAnyVehicle( playerid ) )
		return speedosl[playerid];
	else
		GetPlayerVelocity( playerid, coord[0], coord[1], coord[2] );
	return floatround( floatsqroot( ( check3d ) ? ( coord[ 0 ]*coord[ 0 ] + coord[ 1 ]*coord[ 1 ]+coord[ 2 ]*coord[ 2 ]) : ( coord[ 0 ]*coord[ 0 ] + coord[ 1 ]*coord[ 1 ] ) )*100.0*1.6 );
}
UpdatePlayerPosition(playerid){
	new Float:poss[4];
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		if(pvehs[f][playerid] != INVALID_VEHICLE_ID){
			GetVehiclePos(pvehs[f][playerid], poss[0], poss[1], poss[2]);
			GetVehicleZAngle(pvehs[f][playerid], poss[3]);
			Player[playerid][pAPos_x][f] = poss[0];
			Player[playerid][pAPos_y][f] = poss[1];
			Player[playerid][pAPos_z][f] = poss[2];
			Player[playerid][pAPos_a][f] = poss[3];
			Player[playerid][cWorld][f] = GetVehicleVirtualWorld(pvehs[f][playerid]);
		}	}
	return true;
}
IsCarOkoloDoma(playerid,carid){
	for(new i = 1; i < GetOwnedHouses(playerid)+1; i++){
		new hid = ReturnPlayerHouseID(playerid, i);
		if(hid != -1){
			if(GetVehicleDistanceFromPoint(carid,HouseInfo[hid][henterx], HouseInfo[hid][hentery], HouseInfo[hid][henterz]) < 20)
				return true;
		}else break;
	}
	return false;
}
protected SetCarsInVorld(playerid,world,any = 0){//Если any 0, то уберет везде кроме указанного
	new playercar = GetPlayerVehicleID(playerid);
	if(any){
		for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
			if(pvehs[f][playerid] == INVALID_VEHICLE_ID) continue;
			new worldcar = GetVehicleVirtualWorld(pvehs[f][playerid]);
        	if(worldcar == world && playercar != pvehs[f][playerid]){
				if(!worldcar && GetOwnedHouses(playerid)){
					if(IsCarOkoloDoma(playerid,pvehs[f][playerid]))
						continue;
				}
				SetCarInGarage(playerid,f);
			}
		}
	}else{
		for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
			if(pvehs[f][playerid] == INVALID_VEHICLE_ID) continue;
			new worldcar = GetVehicleVirtualWorld(pvehs[f][playerid]);
        	if(worldcar != world && playercar != pvehs[f][playerid]){
				if(!worldcar && GetOwnedHouses(playerid)){
					if(IsCarOkoloDoma(playerid,pvehs[f][playerid]))
						continue;
				}
				SetCarInGarage(playerid,f);
			}
	}	}
	return true;
}
SetCarInGarage(playerid,slot){
	DestroyVehicle(pvehs[slot][playerid]);
	pvehs[slot][playerid] = INVALID_VEHICLE_ID;
}
GetVehicleTunEx(model,slot)
	return (slot == 1)?(SlotOne[(model < 565)?(model - 558):5]):(SlotTwue[(model < 565)?(model - 558):5]);
GetPlayerCars(playerid){
	new cars;
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++)
		if(pvehs[f][playerid] != INVALID_VEHICLE_ID) cars++;
	return cars;
}
GiveLVLBonus(playerid,lvl){
	if(!(Player[playerid][pVIP] && Player[playerid][pStopVip] == 999999999)){
		switch(lvl){
			case 10,25,50,75,100,150,200:{
				new tImE;
				switch(lvl){
					case 10: 	tImE = 360*6;
					case 25: 	tImE = 360*12;
					case 50: 	tImE = 360*24;
					case 75: 	tImE = 360*36;
					case 100: 	tImE = 360*48;
					case 150: 	tImE = 360*72;
					case 200: 	tImE = 360*168;
				}
				if(Player[playerid][pVIP]){
					Player[playerid][pStopVip]+=tImE;
					if(!LanglePlayer{playerid})
						format(msgcheat, sizeof msgcheat, ""SERVER_MSG"Поздравляем, Вы получили %d уровень! Вам продлена VIP, на %s!",lvl,timec(gettime()+tImE));
					else
						format(msgcheat, sizeof msgcheat, ""SERVER_MSG"Congratulations! Your got %d level! Your give VIP on %s!",lvl,timecEn(gettime()+tImE));
				}else{
					Player[playerid][pVIP] = true;
					Player[playerid][pStopVip]= gettime()+tImE;
					if(!LanglePlayer{playerid})
						format(msgcheat, sizeof msgcheat, ""SERVER_MSG"Поздравляем, Вы получили %d уровень! Вам выдана VIP на %s!",lvl,timec(gettime()+tImE));
					else
						format(msgcheat, sizeof msgcheat, ""SERVER_MSG"Congratulations! Your got %d level! Your give VIP on %s!",lvl,timecEn(gettime()+tImE));
				}
				SendClientMessage(playerid, -1, msgcheat);
				return true;
			}
		}
	}
	new priz;
	if(!(lvl % 10)){
		priz = ((lvl/10)>5)?5:lvl/10;
		Player[playerid][pDonatM]+=priz;
	}else{
		priz = ((lvl*1000)>100000)?100000:lvl*1000;
		DaiEmyDeneg(playerid,priz);
	}
	if(!LanglePlayer{playerid})
		format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Поздравляем, Вы получили %d уровень! Бонус: %d%s!",lvl,priz,((lvl % 10)?("$"):("DM")));
	else
		format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Congratulations! Your got %d level! Bonus: %d%s!",lvl,priz,((lvl % 10)?("$"):("DM")));
	SendClientMessage(playerid, -1, msgcheat);
	return true;
}
UpdateScoreSystem(playerid){
	new counts = GetPlayerScore(playerid)/1900;
    for(new f; f < counts+1; f++){
		if(Player[playerid][pScore] >= 1900+(Player[playerid][pLevel]*100)){
	    	Player[playerid][pScore]-=1900+(Player[playerid][pLevel]*100);
	    	Player[playerid][pLevel]++;
			GiveLVLBonus(playerid,Player[playerid][pLevel]);
    	}else break;
	}
	new pos = GetInLevelTop(playerid);
 	if(pos && records[RECORD_LEVEL][pos-1] != Player[playerid][pLevel]){
  		records[RECORD_LEVEL][pos-1] = Player[playerid][pLevel];
		if(Player[playerid][pLevel] > records[RECORD_LEVEL][pos-2]){
	       	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
	       	    if(!IsPlayerConnected(i) || !Player[i][logged])continue;
				SaveScore(i);
	}	}   }
	if(!pos && Player[playerid][pLevel] > records[RECORD_LEVEL][9]){
       	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
   	    	if(!IsPlayerConnected(i) || !Player[i][logged])continue;
			SaveScore(i);
		}
		mysql_function_query(MYSQL, "SELECT `Nickname`, `level`,`id` FROM `accounts` ORDER BY `level` DESC LIMIT 10", true, "TopLevelUpdate", "");
	}
	UpdateEx(playerid);
	new color = ColorsScore[Player[playerid][pColorScore]];
	TextDrawBoxColor ( hpDraw[playerid], color);
	PlayerTextDrawColor(playerid,ScoreShow[playerid],color);
	PlayerTextDrawColor(playerid,LevelShow[playerid],color);
	PlayerTextDrawColor(playerid,DriftPointsShow[playerid],color);
	TextDrawBoxColor( hpDrawe[playerid],color);
	new str[36];
	format(str, sizeof(str),"%d/%d",GetPlayerScore(playerid),1900+(Player[playerid][pLevel]*100));
	PlayerTextDrawSetString(playerid,ScoreShow[playerid],str);
	format(str, sizeof(str),"LEVEL:%04d",Player[playerid][pLevel]);
	PlayerTextDrawSetString(playerid,LevelShow[playerid],str);
	if(GetPVarInt(playerid,"nick")){
		TextDrawShowForPlayer(playerid,hpDraw[playerid]),
		PlayerTextDrawShow(playerid,ScoreShow[playerid]),
		PlayerTextDrawShow(playerid,LevelShow[playerid]);
	}
	return 0;
}
UpdateSpeedSystem(playerid){
	new vehid = GetPlayerVehicleID(playerid),
		Float:posd[3],
		speed;
	if(vehid)
	{
		GetVehicleVelocity(vehid, posd[0], posd[1], posd[2]);
		speed = floatround(floatsqroot(posd[0]*posd[0]+posd[1]*posd[1]+posd[2]*posd[2])*225);
		if(speed-speedosl[playerid] > (12+(GetPlayerPing(playerid)/10)) && GetTickCount()-StatusUpdate[playerid] > 100){
			MaxRazgon[playerid]++;
			if(MaxRazgon[playerid] > 2){
				AddBan(playerid,INVALID_PLAYER_ID,"Cheat: SH #1",600);
				return SendClientMessage(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [SH #1]"), t_Kick(playerid);
			}
		}else if(MaxRazgon[playerid])
			MaxRazgon[playerid]--;
		speedosl[playerid] = speed;
		if(speedosl[playerid] > 1000 && -0.1 < posd[2]){
			new Float:dis = GetPlayerDistanceFromPoint(playerid, -832.0054,275.1918,1682.4478);
			if(dis > 50){
				AddBan(playerid,INVALID_PLAYER_ID,"Cheat: SH #2",3600);
				return SendClientMessage(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [SH #2]"), t_Kick(playerid);
	}	}	}
	return 0;
}
public UpdateSpeedom(playerid){
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)	{
		new count = COLORS_SPEEDOM,
			speed = Player[playerid][pMaxSpeed]/count,
			speedsl = speedosl[playerid]/speed;
		switch(Player[playerid][pSpeedom]){
			case 1:{
				new indocat[32];
				if(!LanglePlayer{playerid})
					format(indocat, sizeof(indocat),"KM/4: %03d",speedosl[playerid]);
				else	
					format(indocat, sizeof(indocat),"KM/h: %03d",speedosl[playerid]);
				PlayerTextDrawSetString(playerid,Speed2[playerid],indocat);
				if(count > speedsl && Player[playerid][pColorSpeedom] != 2){
					PlayerTextDrawColor(playerid,Speed2[playerid],speedcolors[Player[playerid][pColorSpeedom]][speedsl]);
					PlayerTextDrawShow(playerid,Speed2[playerid]);
			}	}
			case 2:{
				if(!OpenBox[playerid]){
					TextDrawShowForPlayer(playerid,Box);
					OpenBox[playerid] = true;
				}
				for(new i; i < count; i++) {
					if(speedsl >= i && speedosl[playerid] > 0){
						if(SpeedOpen[playerid][i]) continue;
						TextDrawShowForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
						SpeedOpen[playerid][i] = true;
					}else{
						if(!SpeedOpen[playerid][i]) continue;
						TextDrawHideForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
						SpeedOpen[playerid][i] = false;
}	}	}	}   }   }
public removpk(playerid){
	if(IsPlayerConnected(playerid)) return true;
	textmsg[playerid] = "";
	sizemsg[playerid][0] = 0;
	countid[playerid] = INVALID_COUNT_ID;
	GetSpectate[playerid] = INVALID_PLAYER_ID;
	UseEnter[playerid] = false;
	PlayerSpectate[playerid] = false;
	gocamera[playerid] = false;
	crash[playerid] = false;
	OpenBox[playerid] = false;
	AfkPlayer[playerid] = false;
	WaitSum[playerid] = false;
	Kicked[playerid] = false;
	ReConnect[playerid] = false;
	LoadCarsEx[playerid] = false;
	UpdSpd[playerid] = false;
	checkangle[playerid] = 0.0;
	OldPosZ[playerid] = 0.0;
	oldpickup[playerid] = -1;
	OLDVEH[playerid] = 0;
	OLDSEAT[playerid] = 0;
	IDVEH[playerid] = 0;
	IDSEAT[playerid] = 0;
	IDTICK[playerid] = 0;
	SpectateTimer[playerid] = 0;
	Jumping[playerid] = 0;
	PlayerDriftCancellation[playerid] = 0;
	jumped[playerid] = 0;
	ramped[playerid] = 0;
	timerramp[playerid] = 0;
	clickedplayeride[playerid] = 0;
	activetedfrends[playerid] = 0;
	noactivetedfrends[playerid] = 0;
	playersinblacklist[playerid] = 0;
	playerszayavkinses[playerid] = 0;
	useduid[playerid] = 0;
	usedrang[playerid] = 0;
	messages[playerid] = 0;
	AfkTime[playerid] = 0;
	Teleports[playerid] = 0;
	Warned[playerid] = 0;
	BonusDrift[playerid] = 0;
	BadWords[playerid] = 0;
	address[playerid] = 0;
	carsEx[playerid] = 0;
	TimeUpdate[playerid] = 0;
	starttime[playerid] = 0;
	checksdrift[playerid] = 0;
	players[playerid] = 0;
	TOTALAIR[playerid] = 0;
	MaxSpeeds[playerid] = 0;
	MaxRazgon[playerid] = 0;
	SumID[playerid] = 0;
	SumTIME[playerid] = 0;
	PrizDD[playerid] = 0;
	ask[playerid] = 0;
	ans[playerid] = 0;
	RaceID[playerid] = 0;
	SaceSlot[playerid] = 0;
	rRaceStatusEx[playerid] = 0;
	TPToTrack[playerid] = 0;
	usedkeyclan[playerid] = 0;
	usedrateclan[playerid] = 0;
	StatusUpdate[playerid] = 0;
	OldTP[playerid] = 0;
	PlayerCar[playerid] = 0;
	TPToTrackEx[playerid] = 0;
	for(new i; i < MAX_CLANS_ON_PLAYER; i++){
		Player[playerid][cClan][i] = 0;
		Player[playerid][cRate][i] = 0;
	}
	Player[playerid][pMuted] = false;
	Player[playerid][pJail] = false;
	Player[playerid][logged] = false;
	Player[playerid][pBanned] = false;
	Player[playerid][pDoubleDrift] = false;
	Player[playerid][pNoCrash] = false;
	Player[playerid][pRepair] = false;
	Player[playerid][pTags] = false;
	Player[playerid][pKeyMenu] = false;
	Player[playerid][pVIP] = false;
	Player[playerid][KeyTP] = false;
	Player[playerid][KeyStop] = false;
	Player[playerid][pSQLID] = 0;
	Player[playerid][pCashPlayer] = 0;
	Player[playerid][pScore] = 0;
	Player[playerid][pLevel] = 0;
	Player[playerid][pSkin] = 0;
	Player[playerid][pMuteTime] = 0;
	Player[playerid][pMutedAdm] = 0;
	Player[playerid][pVcar] = 0;
	Player[playerid][pJTime] = 0;
	Player[playerid][pJailAdm] = 0;
	Player[playerid][pAdminPlayer] = 0;
	Player[playerid][pDoubleDriftT] = 0;
	Player[playerid][pNoCrashTime] = 0;
	Player[playerid][pSpeedom] = 0;
	Player[playerid][pColorSpeedom] = 0;
	Player[playerid][pPmStatus] = 0;
	Player[playerid][pCheater] = 0;
	Player[playerid][pBonus_d] = 0;
	Player[playerid][pComboDays] = 0;
	Player[playerid][pJMin] = 0;
	Player[playerid][pInt] = 0;
	Player[playerid][pVirt] = 0;
	Player[playerid][pCt] = 0;
	Player[playerid][pCarslots] = 0;
	Player[playerid][pCarSpeed] = 0;
	Player[playerid][pMaxSpeed] = 0;
	Player[playerid][pDonatM] = 0;
	Player[playerid][pTimeOnline] = 0;
	Player[playerid][pTimeOnlineH] = 0;
	Player[playerid][pTimeOnlineD] = 0;
	Player[playerid][pStopAdmin] = 0;
	Player[playerid][pStopVip] = 0;
	Player[playerid][pTimeNewNick] = 0;
	Player[playerid][pColorScore] = 0;
	Player[playerid][pWeapons] = 0;
	Player[playerid][pColorText] = 0;
	Player[playerid][pColorPlayer] = 0;
	Player[playerid][pOldDuel] = 0;
	Player[playerid][pWinRace] = 0;
	Player[playerid][pLooseRace] = 0;
	format(Player[playerid][PlayerName], MAX_PLAYER_NAME, "");
	format(Player[playerid][PlayerPassword], MAX_PLAYER_NAME, "");
	for(new i; i < MAX_VEHICLES_FOR_PLAYER+1; i++){
		Player[playerid][pAutoUID][i] = 0;
		Player[playerid][pAuto][i] = 0;
		Player[playerid][pAPos_x][i] = 0.0;
		Player[playerid][pAPos_y][i] = 0.0;
		Player[playerid][pAPos_z][i] = 0.0;
		Player[playerid][pAPos_a][i] = 0.0;
		Player[playerid][pVinil][i] = -1;
		Player[playerid][pColor][i] = 1;
		Player[playerid][pColorTwo][i] = 0;
		Player[playerid][cGidravlika][i] = 0;
		Player[playerid][cWheels][i] = -1;
	}
	for(new i; i < MAX_FRENDS; i++){
		Player[playerid][pFrinend][i] = 0;
		Player[playerid][pNoActFrinend][i] = 0;
		Player[playerid][pBlackList][i] = 0;
		Player[playerid][pZayavki][i] = 0;
	}
	for(new i; i < MAX_TELEPORTS; i++){
		Player[playerid][ptPosX][i] = 0.0;
		Player[playerid][ptPosY][i] = 0.0;
		Player[playerid][ptPosZ][i] = 0.0;
		Player[playerid][ptPosA][i] = 0.0;
		Player[playerid][ptID][i] = 0;
	}
	for(new i; i < MAX_CLANS_ON_PLAYER; i++){
		Player[playerid][cClan][i] = 0;
		Player[playerid][cRate][i] = 0;
		Player[playerid][cMoneys][i] = 0;
		Player[playerid][cMDay][i] = 0;
	}
	for(new i; i < 2; i++)
		Player[playerid][pDriftPointsNow][i] = 0;
	for(new i; i < 4; i++)
		Player[playerid][pPos][i] = 0.0;
	/*
	format(Player[playerid][PlayerName], MAX_PLAYER_NAME, "");
	Player[playerid][pCashPlayer] = 0;
	Player[playerid][pCt] = 0;
	Player[playerid][logged] = false;
	Player[playerid][pSQLID] = 0;
	Player[playerid][pJail] = false;
	Player[playerid][pBanned] = false;
	Player[playerid][pVIP] = false;
	Player[playerid][pMuted] = false;
	Player[playerid][pJail] = false;
	Player[playerid][pBonus_d] = 0;
	Player[playerid][pComboDays] = 0;
	Player[playerid][pSpeedom] = 0;
	Player[playerid][pRepair] = false;
	Player[playerid][pDoubleDrift] = false;
	Player[playerid][pDoubleDriftT] = 0;
	Player[playerid][pNoCrash] = false;
	Player[playerid][pNoCrashTime] = 0;
	Player[playerid][pJTime] = 0;
	Player[playerid][pCheater] = 0;
	Player[playerid][pVcar] = 0;
	Player[playerid][pDonatM] = 0;
	Player[playerid][pJailAdm] = false;
	Player[playerid][pMutedAdm] = 0;
	Player[playerid][pCashPlayer] = 0;
	Player[playerid][pAdminPlayer] = 0;
	Player[playerid][pPos][0] =0;
	Player[playerid][pPos][1] =0;
	Player[playerid][pPos][2] =0;
	Player[playerid][pPos][3] =0;
	Player[playerid][pLevel] = 0;
	Player[playerid][pScore] = 0;
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		if(pvehs[f][playerid] != INVALID_VEHICLE_ID){
			Player[playerid][pVinil][f] = -1;
			Player[playerid][pColor][f] = 1;
			Player[playerid][pColorTwo][f] = 1;
			Player[playerid][pAuto][f] = 0;
			Player[playerid][pAPos_x][f] = 0;
			Player[playerid][pAPos_y][f] = 0;
			Player[playerid][pAPos_z][f] = 0;
			Player[playerid][pAPos_a][f] = 0;
	}	}
	*/
	return true;
}
timecs(timestamp, compare = -1) {
    if (compare == -1)
        compare = gettime();
    new
        d = ((timestamp > compare) ? timestamp - compare : compare - timestamp),
        returnstr[256],
        str[48],
        year,month,day,hours,minutes,
        bool:one;
    for(new f ; f < 100; f++){
        if(d >= 31556926) {d = d-31556926;year++;}
        else break;
    }
    for(new f ; f < 12; f++){
        if(d >= 2629743) {d = d-2629743;month++;}
        else break;
    }
    for(new f ; f < 31; f++){
        if(d >= 86400) {d = d-86400;day++;}
        else break;
    }
    for(new f ; f < 24; f++){
        if(d >= 3600) {d = d-3600;hours++;}
        else break;
    }
    for(new f ; f < 60; f++){
        if(d >= 60) {d = d-60;minutes++;}
        else break;
    }
    if(year){
        one = true;
		format(str, sizeof(str), "%d %s",year,FormatText("год","года","лет",year));
		strcat(returnstr, str);
	}
    if(month){
		if(one)strcat(returnstr,", ");else one = true;
		format(str, sizeof(str), "%d %s",month,FormatText("месяц","месяца","месяцев",month));
		strcat(returnstr, str);
	}
    if(day){
		if(one)strcat(returnstr,", ");else one = true;
	    format(str, sizeof(str), "%d %s",day,FormatText("день","дня","дней",day));
		strcat(returnstr, str);
	}
    if(hours){
		if(one)strcat(returnstr,", ");else one = true;
	    format(str, sizeof(str), "%d %s",hours,FormatText("час","часа","часов",hours));
		strcat(returnstr, str);
	}
    if(minutes){
		if(one)strcat(returnstr,", ");else one = true;
	    format(str, sizeof(str), "%d %s",minutes,FormatText("минуту","минуты","минут",minutes));
		strcat(returnstr, str);
	}
    if(d){
        if(one)strcat(returnstr,", ");
	    format(str, sizeof(str), "%d %s",d,FormatText("секунду","секунды","секунд",d));
		strcat(returnstr, str);
	}
    return returnstr;
}
timecEn(timestamp, compare = -1) {
    if (compare == -1)
        compare = gettime();
    new
        n,
        Float:d = (timestamp > compare) ? timestamp - compare : compare - timestamp,
        returnstr[48];
    if (d < 60) {
        format(returnstr, sizeof(returnstr), "< 1 minute");
        return returnstr;
    } else if (d < 3600) {
        n = floatround(floatdiv(d, 60.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("minute", "minutes", "minutes",n));
    } else if (d < 86400) {
        n = floatround(floatdiv(d, 3600.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("hour", "hour", "hours",n));
    } else if (d < 2592000) {
        n = floatround(floatdiv(d, 86400.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("day", "day", "days",n));
    } else if (d < 31536000) {
        n = floatround(floatdiv(d, 2592000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("month", "month", "months",n));
    } else {
        n = floatround(floatdiv(d, 31536000.0), floatround_floor);
        format(returnstr, sizeof(returnstr), "%s",FormatText("year", "year", "years",n));
    }
    format(returnstr, sizeof(returnstr), "%d %s", n, returnstr);
    return returnstr;
}
FormatText(form1[32],form2[32],form3[32],count){
    if(count>=0)
        count = count % 100;
        else
        count = count*-1 % 100;
    new lcount = count % 10;
    if (count >= 11 && count <= 19) return(form3);
    else if (lcount >= 2 && lcount <= 4) return(form2);
    else if (lcount == 1) return(form1);
    return form3;
}
GetVehicleTun(model,slot){
	if(model == 558) return AllTuning[slot][Uranus];
	else if(model == 559) return AllTuning[slot][Jester];
	else if(model == 560) return AllTuning[slot][Sultan];
	else if(model == 561) return AllTuning[slot][Stratum];
	else if(model == 562) return AllTuning[slot][Elegy];
	else return AllTuning[slot][Flash];
}
AddOne(comp){
	switch(comp){
	    //1
		case 1093: return 1095;
		case 1070: return 1072;
		case 1031: return 1030;
		case 1057: return 1063;
		case 1041: return 1039;
		case 1052: return 1048;
		//2
		case 1090: return 1094;
		case 1069: return 1071;
		case 1026: return 1027;
		case 1056: return 1062;
		case 1036: return 1040;
		case 1051: return 1047;
	}
	return -1;
}
FixText(string[]) {
	new result[256];
	for(new i=0; i < 256; i++) {
		switch(string[i]) {
		case 'а':result[i] = 'a';
		case 'А':result[i] = 'A';
		case 'б':result[i] = '—';
		case 'Б':result[i] = 'Ђ';
		case 'в':result[i] = 'ў';
		case 'В':result[i] = '‹';
		case 'г':result[i] = '™';
		case 'Г':result[i] = '‚';
		case 'д':result[i] = 'љ';
		case 'Д':result[i] = 'ѓ';
		case 'е':result[i] = 'e';
		case 'Е':result[i] = 'E';
		case 'ё':result[i] = 'e';
		case 'Ё':result[i] = 'E';
		case 'ж':result[i] = '›';
		case 'Ж':result[i] = '„';
		case 'з':result[i] = 'џ';
		case 'З':result[i] = '€';
		case 'и':result[i] = 'њ';
		case 'И':result[i] = '…';
		case 'й':result[i] = 'њ';
		case 'Й':result[i] = '…';
		case 'к':result[i] = 'k';
		case 'К':result[i] = 'K';
		case 'л':result[i] = 'ћ';
		case 'Л':result[i] = '‡';
		case 'м':result[i] = 'Ї';
		case 'М':result[i] = 'M';
		case 'н':result[i] = '®';
		case 'Н':result[i] = '­';
		case 'о':result[i] = 'o';
		case 'О':result[i] = 'O';
		case 'п':result[i] = 'Ј';
		case 'П':result[i] = 'Њ';
		case 'р':result[i] = 'p';
		case 'Р':result[i] = 'P';
		case 'с':result[i] = 'c';
		case 'С':result[i] = 'C';
		case 'т':result[i] = '¦';
		case 'Т':result[i] = 'Џ';
		case 'у':result[i] = 'y';
		case 'У':result[i] = 'Y';
		case 'ф':result[i] = '';
		case 'Ф':result[i] = 'Ѓ';
		case 'х':result[i] = 'x';
		case 'Х':result[i] = 'X';
		case 'ц':result[i] = ' ';
		case 'Ц':result[i] = '‰';
		case 'ч':result[i] = '¤';
		case 'Ч':result[i] = 'Ќ';
		case 'ш':result[i] = 'Ґ';
		case 'Ш':result[i] = 'Ћ';
		case 'щ':result[i] = 'Ў';
		case 'Щ':result[i] = 'Љ';
		case 'ь':result[i] = '©';
		case 'Ь':result[i] = '’';
		case 'ъ':result[i] = 'ђ';
		case 'Ъ':result[i] = '§';
		case 'ы':result[i] = 'Ё';
		case 'Ы':result[i] = '‘';
		case 'э':result[i] = 'Є';
		case 'Э':result[i] = '“';
		case 'ю':result[i] = '«';
		case 'Ю':result[i] = '”';
		case 'я':result[i] = '¬';
		case 'Я':result[i] = '•';
		default:result[i]=string[i];
		}
	}
	return result;
}
bool:TwoColours(model){
	switch(model){
    	case 496,541,542,480,466,492,494,502,503,400,517,
			467,404,603,489,479,442,549,491,555,499,422,
			498,483,508,444,423,582,525,552,554,431,437,
			515,428,424,532,522,448,471,495,429,439,416,
			407,544,427,596,598,599,597,472,473,493,595,
			484,452,446,539,577,511,512,593,553,476,460,
			513,417,487,488,563,469,447,497,409: return true;
		default: return false;
	}
	return false;
}
GetMaxRazgon(model){
	switch(model){
		case 486,531,574: return 10;
		case 406,432,456,457,530,532,572: return 12;
		case 408,418,423,431,443,448,455,471,474,475,478,479,498,549,551,552,573,583,604,609: return 14;
		case 401,403,404,405,407,413,414,420,421,422,445,462,463,468,482,483,489,491,496,499,508,514,516,518,524,526,529,542,550,554,555,580,585,588,589,596,598,600,602,603: return 16;
		case 433,434,436,440,442,458,459,461,477,485,521,527,533,534,535,543,544,545,546,547,561,562,582,586,601: return 18;
		case 402,412,415,416,419,424,444,466,467,490,494,505,506,507,517,523,525,528,556,557,558,559,565,566,567,568,575,576,577,578,579,581,599,605: return 20;
		case 427,428,429,437,438,439,480,492,495,500,501,502,503,504,587: return 22;
		case 400,426,470,515,522,536,541: return 24;
		case 411,451,560: return 26;
		default: return 22;
	}
	return 0;
}
SendMoney(priced,owner[]){
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM "TABLE_ACC" WHERE `Nickname`='%s'", owner);
	mysql_function_query(MYSQL, qString, true, "SendMoney2", "d", priced);
	return true;
}
SendMoneyUID(priced,uid){
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM "TABLE_ACC" WHERE `id`= '%d' LIMIT 1", uid);
	mysql_function_query(MYSQL, qString, true, "SendMoney2", "d", priced);
	return true;
}
public SendMoney2(priced){
	new rows, fields,string[12],idp,money,query[112];
	cache_get_data(rows, fields);
	if(rows)
	{
		cache_get_field_content(0,"id", string);
		sscanf(string, "d", idp);
		cache_get_field_content(0,"Money", string);
		sscanf(string, "d", money);
		format(query, sizeof(query),"UPDATE  "TABLE_ACC" SET `Money` = '%d' WHERE `id` = '%d'",money+priced,idp);
		mysql_function_query(MYSQL, query, false, "", "");
	}
	return true;
}
public BlackListe(playerid){
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM "BLACKLIST_TABLE" WHERE `PlayerUID`='%d'", Player[playerid][pSQLID]);
    mysql_function_query(MYSQL,qString,true, "BlackListShow", "i",playerid);
    return true;
}
public BlackListShow(playerid){
	new
		rows,
		fields,
		string[MAX_PLAYER_NAME],
		bool:n
	;
	cache_get_data(rows, fields);
	bigdialog = "";
	if(!rows)
	    strcat(bigdialog, "Черный список пуст");
	for(new i = 0; i < rows; i++){
	    string = "";
	    if(!n) n = true;
	    else strcat(bigdialog, "\n");
		switch(i){
			case 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99:
                strcat(bigdialog, "{00f5da}");
			default:
			    strcat(bigdialog, "{FFFFFF}");
		}
		strcat(bigdialog, string);
		cache_get_field_content(i, "NickName", string);
	    strcat(bigdialog, string);
	    cache_get_field_content(i, "IgnodeUID", string);
	    Player[playerid][pBlackList][i] = strval(string);
	}
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, FREND_DIALOG, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Черный список", bigdialog, "Выбрать", "Закрыть" );
	else
		ShowPlayerDialog(playerid, FREND_DIALOG, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski_EN""STRELKI"Black list", bigdialog, "Select", "Close" );
	return true;
}
AFKCheck(){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		if(AfkTime[i] > 1 && !AfkPlayer[i]){
			AFK_3DT[i] = Create3DTextLabel("AFK", T_COLOR, 0.00, 0.00, 10000.0, T_DIST, 0);
			Attach3DTextLabelToPlayer(AFK_3DT[i], i, 0.0, 0.0, 0.5);
			AfkPlayer[i] = true;
		}
		else if(AfkPlayer[i] && !AfkTime[i])
		{
			Delete3DTextLabel(AFK_3DT[i]);
			AfkPlayer[i] = false;
		}
		else if(AfkTime[i] > 600){
			if(!LanglePlayer{i})
				SendClientMessage(i, -1, ""SERVER_MSG""TEXT_KICK" [#44]");
			else
				SendClientMessage(i, -1, ""SERVER_MSG""TEXT_KICK_EN" [#44]");
			return t_Kick(i);
		}
		AfkTime[i]++;
	}
	return true;
}
new Float:Ang;
Float:ReturnPlayerAngle(playerid){
	GetVehicleZAngle(GetPlayerVehicleID(playerid), Ang);
	return Ang;
}
new Float:floa[8];
Float:GetPlayerTheoreticAngle(i)
{
	if(!IsPlayerConnected(i)) return 0.0;
	GetPlayerPos(i,floa[2],floa[3],floa[4]);
	floa[1] = floatsqroot(floatpower(floatabs(floatsub(floa[2],ppos[i][0])),2)+floatpower(floatabs(floatsub(floa[3],ppos[i][1])),2));
	floa[5]=(floa[2]>ppos[i][0])?(floa[2]-ppos[i][0]):(floa[5]=ppos[i][0]-floa[2]);
	floa[6]=(floa[3]>ppos[i][1])?(floa[3]-ppos[i][1]):(floa[6]=ppos[i][1]-floa[3]);
	if(ppos[i][1]>floa[3] && ppos[i][0]>floa[2]){
		floa[0] = asin(floa[5]/floa[1]);
		floa[7] = floatsub(floatsub(floatadd(floa[0], 90), floatmul(floa[0], 2)), -90.0);
	}
	else if(ppos[i][1]>floa[3] && ppos[i][0]<floa[2]){
		floa[7] = floatadd(asin(floa[5]/floa[1]), 180);
 	}
	else if(ppos[i][1]<floa[3] && ppos[i][0]>floa[2]){
		floa[7] = floatsub(floatadd(asin(floa[5]/floa[1]), 180), 180.0);
 	}
	else if(ppos[i][1]<floa[3] && ppos[i][0]<floa[2]){
		floa[0] = acos(floa[6]/floa[1]);
		floa[7] = floatsub(floatadd(floa[0], 360), floatmul(floa[0], 2));
 	}
	return ((floa[7]==0.0)?ReturnPlayerAngle(i):floa[7]);
}
protected UpdateDDTD(raceid){
	new winner = (DDInfo[raceid][rPoints][0] > DDInfo[raceid][rPoints][1])?DDInfo[raceid][rRacer][0]:DDInfo[raceid][rRacer][1],
		looser = (winner==DDInfo[raceid][rRacer][0])?DDInfo[raceid][rRacer][1]:DDInfo[raceid][rRacer][0],
		winnerSlot = (DDInfo[raceid][rPoints][0] > DDInfo[raceid][rPoints][1])?0:1,
		looserSlot = (winner==DDInfo[raceid][rRacer][0])?1:0,
		points[10],
		pointsEx[10];
	format(points,sizeof(points),"%04d",DDInfo[raceid][rPoints][winnerSlot]);
	format(pointsEx,sizeof(pointsEx),"%04d",DDInfo[raceid][rPoints][looserSlot]);
	TextDrawSetString(RaceTextDraw[raceid][DT_LEADER_POINTS],points);
	TextDrawSetString(RaceTextDraw[raceid][DT_LOOSER_POINTS],pointsEx);
	if(DDInfo[raceid][rWinner] != winner || DDInfo[raceid][rPoints][0] < 10 || DDInfo[raceid][rPoints][1] < 10){
		TextDrawHideForPlayer(winner,AllRaceTextDraw[7]);
		TextDrawHideForPlayer(winner,AllRaceTextDraw[8]);
		TextDrawHideForPlayer(looser,AllRaceTextDraw[7]);
		TextDrawHideForPlayer(looser,AllRaceTextDraw[8]);
		TextDrawShowForPlayer(winner,AllRaceTextDraw[7]);
		TextDrawShowForPlayer(looser,AllRaceTextDraw[8]);
		TextDrawSetString(RaceTextDraw[raceid][DT_LEADER_NAME],Player[winner][PlayerName]);
		TextDrawSetString(RaceTextDraw[raceid][DT_LOOSER_NAME],Player[looser][PlayerName]);
	}
	DDInfo[raceid][rWinner] = winner;
	if(DDInfo[raceid][rPoints][winnerSlot] > RaceInfo[DDInfo[RaceID[winner]][rTrackID]][Record]){
		RaceInfo[DDInfo[raceid][rTrackID]][Record] = DDInfo[raceid][rPoints][winnerSlot];
		RaceInfo[DDInfo[raceid][rTrackID]][RecordsmanUID] = DDInfo[raceid][rRacer][winnerSlot];
		TextDrawSetString(RaceTextDraw[raceid][DT_RECORDER_NAME],Player[winner][PlayerName]);
		TextDrawSetString(RaceTextDraw[raceid][DT_RECORDER_SCORE],points);
	}
	return true;
}
public DriftCheck(i,carid){
	if(!AfkPlayer[i]){
		new Float:Angle1=ReturnPlayerAngle(i),
			Float:Angle2=GetPlayerTheoreticAngle(i);
		if(GetPVarInt(i,"NoDrift")){
			if(Player[i][pDriftPointsNow][0])
				DriftExit(i);
			SetPVarInt(i,"NoDrift",GetPVarInt(i,"NoDrift")-1);
		}
		else if(IsCarEx[i] && MIN_SPEED < speedosl[i] < MAX_SPEED){
			new Float:angle = floatabs(floatsub(Angle1, Angle2));
			if(angle > 280.0)
				angle-=270.0;
			if(DRIFT_MINKAT < angle < DRIFT_MAXKAT && Player[i][pDriftPointsNow][0] < 5000){
				new Float:srednee=checksdrift[i]*checkangle[i];
				srednee+=angle;
				checksdrift[i]++;
				checkangle[i] = srednee/checksdrift[i];
				new Float: coord,
					Keys,ud,lr;
				GetVehicleVelocity( carid, coord, coord, coord);
				GetPlayerKeys(i,Keys,ud,lr);
				if(Keys == 136 && (lr == 128 || lr == -128))
					return true;
				if(-0.3 < coord < 0.08){
					new bool:StrLock;
					if((lr == -128 && floatsub(Angle1, Angle2) < 0) || (lr == 128 && floatsub(Angle1, Angle2)))
						StrLock = true;
					//new str[45];format(str,sizeof(str),"Angle = %f,",angle);SendClientMessage(i,-1,str);
					if(!Player[i][pDriftPointsNow][0]){
						if(GetPVarInt(i,"nick"))
						TextDrawShowForPlayer(i,hpDraweFon),
						TextDrawShowForPlayer(i,hpDrawe[i]),
						PlayerTextDrawShow(i,DriftPointsShow[i]);
						starttime[i]=gettime();
						if(!Player[i][pDoubleDrift] && !Player[i][pVIP])
							BonusDrift[i] = 1;
						else
							BonusDrift[i] = 2;						
					}
					if(rRaceStatusEx[i] == STATUS_RACE_STARTED && DDInfo[RaceID[i]][rTime] < 90){
						if(angle < 20.0)
							DDInfo[RaceID[i]][rPoints][SaceSlot[i]]++;
						else if(speedosl[i] > 150)
							DDInfo[RaceID[i]][rPoints][SaceSlot[i]]+=3;
						else
							DDInfo[RaceID[i]][rPoints][SaceSlot[i]]+=2;
						UpdateDDTD(RaceID[i]);
					}
					if(StrLock && angle > 30.0 && ShowStirLock[i] > 2){
						Player[i][pDriftPointsNow][0]+=2;
						Player[i][pDriftPointsNow][1]+=2;
					}else{
						Player[i][pDriftPointsNow][0]++;
						Player[i][pDriftPointsNow][1]++;
					}
					if(Player[i][pDriftPointsNow][1] >= 300){
						if(BonusDrift[i] < 8){
							if(coord > -0.2)
								BonusDrift[i]++;
							Player[i][pDriftPointsNow][1] = 0;
						}else Player[i][pDriftPointsNow][1] = 300;
					}
					UpdateDrift(i);
					if(StrLock && angle > 30.0){
						if(ShowStirLock[i] < 3)
							ShowStirLock[i]++;
						if(ShowStirLock[i] > 2 && GetPVarInt(i,"nick"))
							TextDrawShowForPlayer(i,StirLock[Player[i][pColorScore]]);
					}else if(ShowStirLock[i]){
						ShowStirLock[i]--;
						if(!ShowStirLock[i])
							TextDrawHideForPlayer(i,StirLock[Player[i][pColorScore]]);
					}
					PlayerDriftCancellation[i] = GetTickCount()+1500;
				}else if(ShowStirLock[i]){
					ShowStirLock[i]--;
					if(!ShowStirLock[i])
						TextDrawHideForPlayer(i,StirLock[Player[i][pColorScore]]);
				}
			}else if(ShowStirLock[i]){
				ShowStirLock[i]--;
				if(!ShowStirLock[i])
					TextDrawHideForPlayer(i,StirLock[Player[i][pColorScore]]);
			}
		}else if(ShowStirLock[i]){
			TextDrawHideForPlayer(i,StirLock[Player[i][pColorScore]]);
			ShowStirLock[i] = 0;
		}
	}
	return true;
}
GetMaxSpeed(model){
	if(ReturnVidVehicle(model) == SEA_TS || ReturnVidVehicle(model) == AIR_TS)
		return 320;
	switch(model)
	{
		case 574,530,572,486,531,583: return 75;
		case 432,423: return 85;
		case 408,456,485,457: return 90;
		case 406,413,414,444,471,498,508,573,588,601,609: return 95;
		case 403,418,433,532,556,557: return 100;
		case 478,514,552: return 105;
		case 443,483,499: return 110;
		case 404,410,431,459,524,578,582: return 115;
		case 424,440,442,479,489,492,500,505,515: return 120;
		case 401,420,422,438,466,467,547,550,554,568,604: return 125;
		case 407,419,474,491,527,540,543,544,545,546,600,605: return 130;
		case 409,416,421,437,470,482,490,458,516,517,526,529,535,549,551,555,558,566,575,576,579,580,585,599: return 135;
		case 405,427,428,434,445,496,507,518,542,561,565,587,448: return 140;
		case 412,439,455,525,533,534,560,589,602,603: return 145;
		case 426,462,468,475,504,506,562,567,596,598: return 150;
		case 461,523,528,559: return 155;
		case 402,477,480,495,521,536,581,586: return 160;
		case 415,451,463,541: return 170;
		case 429: return 175;
		case 494,502,503: return 185;
		case 411: return 190;
		case 522: return 200;
		default: return 170;
	}
	return 0;
}
GetCifri(text[]){
	new count;
	for (new i; i < strlen(text); i++)
	{
		if (text[i] >= '0' && text[i] <= '9') count++;
	}
	return count;
}
GetPlayerId(nick[]){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		if(!strcmp(nick,Player[i][PlayerName],false)) return i;
	}
	return -1;
}
t_Kick(playerid){
	SendClientMessage(playerid, -1, ""SERVER_MSG"Кикнуло типо");
	/*Kicked[playerid] = true;
	if(IsPlayerConnected(playerid)){
		for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		   	if(pvehs[f][playerid] != INVALID_VEHICLE_ID)
			{
				DestroyVehicle(pvehs[f][playerid]);
				pvehs[f][playerid] = INVALID_VEHICLE_ID;
			}
		}
		SetPlayerName(playerid,NameForAntiKick);
		SetTimerEx("v_Kick",100,false,"d",playerid);
	}*/
	return true;
}
public v_Kick(playerid){
	Kick(playerid);
	return true;
}
#define Kick t_Kick
GetPlayerNickId(nick[]){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		if(!strcmp(nick,Player[i][PlayerName],false)) return i;
	}
	return -1;
}
SetCarVinil(playerid,carid,vinil) Player[playerid][pVinil][carid] = vinil;
SetCarColor(playerid,carid,color,color2) {Player[playerid][pColor][carid] = color; Player[playerid][pColorTwo][carid] = color2;}
GetCarId(playerid){
	new VehID = GetPlayerVehicleID(playerid);
	if(!VehID) return 0;
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		if(!Player[playerid][pAuto][f] || VehID != pvehs[f][playerid]) continue;
		return f;
	}
	return 0;
}
GetCarIdForSlot(playerid,slot) return pvehs[slot][playerid];
GetCarIdPoId(VehID,playerid){
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		if(!Player[playerid][pAuto][f] || VehID != pvehs[f][playerid]) continue;
	 	return f;
	}
	return 0;
}
GetCarOwner(VehID){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++)
		{
			if(!Player[i][pAuto][f] || pvehs[f][i]!= VehID) continue;
			return i;
	}	}
	return -1;
}
ShowAdminMenu(playerid){
	minidialog = "";
	if(!LanglePlayer{playerid}){
		if(Player[playerid][pAdminPlayer] < LEVEL_KICK)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Кик\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_TP)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Наблюдение\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_TP)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"ТП к игроку\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_TP)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"ТП игрока к себе\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_WARN)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Выдать предупреждение\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_WARN)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Снять предупреждение");
		ShowPlayerDialog(playerid, 242, DIALOG_STYLE_LIST, "Выберите действие", minidialog, "Выбрать", "Отмена");
	}else{
		if(Player[playerid][pAdminPlayer] < LEVEL_KICK)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Kick\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_BANN)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Ban [Nick+IP]\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_BANN)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Ban subnet\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_TP)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Spec\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_TP)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"TP to player\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_TP)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"TP player to itself\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_WARN)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Give warning\n");
		if(Player[playerid][pAdminPlayer] < LEVEL_WARN)
	 		strcat(minidialog,"{808080}");
		strcat(minidialog,"Remove warning");
		ShowPlayerDialog(playerid, 242, DIALOG_STYLE_LIST, "Select action", minidialog, "Select", "Cancel");
	}
	return true;
}
ShowDialogDonat(playerid) {
	new menu[112];
	minidialog = "";
	if(!LanglePlayer{playerid}){
		strcat(minidialog, "Купить VIP");
	    format(menu, sizeof(menu), "\nКупить игровые деньги \t{00f5da}(%d DM за 1кк)",STOIMOST_DENEG);
		strcat(minidialog, menu);
	    format(menu, sizeof(menu), "\nКупить SCORE \t\t\t{00f5da}(%d DM за 1к)",STOIMOST_SCORE);
		strcat(minidialog, menu);
		strcat(minidialog, "\nВвести промо код\nПолучить промо код");
	    ShowPlayerDialog(playerid, DONATDIALOG, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Донат", minidialog, "Ок", "Назад");
	}else{
		strcat(minidialog, "Buy VIP");
	    format(menu, sizeof(menu), "\nBuy game money \t{00f5da}(%d DM for 1kk)",STOIMOST_DENEG);
		strcat(minidialog, menu);
	    format(menu, sizeof(menu), "\nBuy SCORE \t\t\t{00f5da}(%d DM for 1k)",STOIMOST_SCORE);
		strcat(minidialog, menu);
		strcat(minidialog, "\nEnter promo code\nReceive promo code");
	    ShowPlayerDialog(playerid, DONATDIALOG, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN""STRELKI"Donate", minidialog, "Ok", "Back");
	}
	return true;
}
new WebSites[][] ={".ws",".ru",".tk",".com","www.",".org",".net",".cc",".by",".biz",".su",".info"};
CheckString(string[]){
	new sait = 0,
	nesait = 0;
	if(strfind(string,"drift2.ru",true) != -1) sait++;
	if(strfind(string,"vk.com/driftemp",true) != -1) sait++;
	for(new i = 0;i<sizeof(WebSites);i++)
		if(strfind(string,WebSites[i],true) != -1)
			nesait++;
	if(nesait>sait)return true;
	return 0;
}
new delimiters[]={'.', ' ', ',', '*', '/', ';', '\\', '|'};
IsIP(const str[]){
	for(new cIP[4]; cIP[0] != strlen(str)+1; cIP[0]++){
		switch(str[cIP[0]]){
			case '.', ' ', ':', ',', '*', '/', ';', '\\', '|' : continue;
			case '0' .. '9': cIP[1]++;
		}
		if(cIP[1] ==1){ cIP[2] = cIP[0];}
		if(cIP[1] >= 8){
			new strx[16];
			new l[4][4];
			cIP[3] = cIP[0]+8;
			strmid(strx,str,cIP[2],cIP[3],16);
			for(new i =strlen(strx);i>8;i--){
				switch(strx[i]){
				case '0' .. '9','.', ' ', ':', ',', '*', '/', ';', '\\', '|': continue;
				default: strx[i] =0;
			}	}
			for(new i =0;i<sizeof(delimiters);i++){
				split(strx,l,delimiters[i]);
				if(strlen(l[0]) == 1 ||strlen(l[1]) == 1 ||strlen(l[2]) == 1 ||strlen(l[3]) == 1)
					continue;
				if(strlen(l[0]) >3 ||strlen(l[1]) >3 ||strlen(l[2]) >3)
					continue;
				else
					return true;
	}	}	}
	return 0;
}
bool:emptyMessage(const string[]){
	for(new i; string[i] != 0x0; i++){
	switch(string[i]){
			case 0x20,' ': continue;
			default: return false;
}	}
	return true;
}
bool: getprobel(const string[]){
	new probels;
	for(new i; string[i] != 0x0; i++){
		switch(string[i]){
		case 0x20,' ': probels++;
		default: probels--;
	}	}
	if(probels >= 0) return true;
	return false;
}
bool:Vinil(vid){
	switch(GetVehicleModel(vid)){case 483,534,535,536,558,559,560,561,562,565,567,575,576:return true;}
	return false;
}
bool:Gidravlic(vid){
	switch(GetVehicleModel(vid)){case 406..408,417,425,431..433,435,437,441,444,
		446..450,452..454,457,460..465,468,469,471,472,
		473,476,481,484..488,493,497,501,509..511,513,
		519..523,530..532,537..539,544,548,553,556,557,
		563,564,569..572,574,577..581,583,584,586,588,
		590..595,601,606,607,610,611: return false;}
	return true;
}
bool:Wheel(vid){
	switch(GetVehicleModel(vid)){case 417,425,430,432,435,441,444,446..450,452,453,454,
		460..465,468,469,472,473,476,481,484,486,487,488,
		493,497,501,509..513,519..523,532,537,538,539,548,
		553,556,557,563,564,569,570,577,581,584,590..595,606..611: return false;}
	return true;
}
bool:CheckStr(str[])
	return((strfind(str, "New_Player", true) != -1) ||(strfind(str, "Brutal", true) != -1))?true:false;
bool: tunings(playerid)
	return (IsPlayerInRangeOfPoint(playerid,10,615.2878,-124.2391,997.5602) || IsPlayerInRangeOfPoint(playerid,10,617.5355,-1.9899,1000.6155) || IsPlayerInRangeOfPoint(playerid,10,616.7834,-74.8151,997.7726))?true:false;
public OnVehicleRespray(playerid, vehicleid, color1, color2){
	SetPVarInt(playerid,"AntyColor",GetPVarInt(playerid,"AntyColor")+1);
	if(GetPVarInt(playerid,"AntyColor") > 8){
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#1]");
		else
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#1]");
		return t_Kick(playerid);
	}
	SetCarColor(playerid,GetCarIdPoId(vehicleid,playerid),color1,color2);
	return true;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid){
	SetPVarInt(playerid,"AntyColor",GetPVarInt(playerid,"AntyColor")+1);
	if(GetPVarInt(playerid,"AntyColor") > 8){
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#2]");
		else
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#2]");
		return t_Kick(playerid);
	}
	SetCarVinil(playerid,GetCarIdPoId(vehicleid,playerid),paintjobid);
	return true;
}
BanExPlayer(playerid,const reason[]){
	SetPlayerName(playerid,NameForAntiKick);
	return BanEx(playerid,reason);
}
#define BanEx BanExPlayer
protected BanPlayer(playerid)
{
	SetPlayerName(playerid,NameForAntiKick);
	return Ban(playerid);
}
#define Ban BanPlayer
public AntiKick(playerid) return Kick(playerid);
public WriteRusLog(log[], string[]){
	new write[144],year, month,day, File:hFile = fopen(log, io_append);
	getdate(year, month, day);
	gettime(hour, minute, second);
	format(write, sizeof(write), "Дата: [%02d:%02d:%02d] Время:[%02d:%02d:%02d] %s\r\n",day,month,year,hour,minute,second,string);
	for(new io=0; io<strlen(write); io++)fputchar(hFile, write[io], false);
	fclose(hFile);
}
SendAdminMessage(color, string[]){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(Player[i][pAdminPlayer] < 2|| !IsPlayerConnected(i) || !Player[i][logged])continue;
		SendClientMessage(i, color, string);
	}
	return true;
}
SendAllAdminMessage(color, string[]){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
 		if(!IsPlayerConnected(i) || !Player[i][logged] || !Player[i][pAdminPlayer])continue;
		SendClientMessage(i, color, string);
	}
	return true;
}
GetHelpersOnline(){
	new admins;
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!Player[i][pAdminPlayer] || !Player[i][logged] || !IsPlayerConnected(i)) continue;
		admins++;
	}
	return admins;
}
COMMAND:ask(playerid, params[]){
	if(Player[playerid][pAdminPlayer])
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Вы не можете задавать вопросы!");
	if(!GetHelpersOnline()){
		if(!LanglePlayer{playerid}) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"В сети нету помощников.");
		else return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Assistants offline.");
	}
	if(sscanf(params,"s[76]", params[0])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/ask [вопрос]");
	new timesd = gettime();
	if(timesd-ask[playerid] < 60) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Вопросы можно задавать только 1 раз в минуту");
	new msg[114];
	format(msg, sizeof(msg), ""SERVER_MSG"{%s}%s[%d]{ffffff} спрашивает: %s.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName], playerid,params[0]);
	SendAllAdminMessage(-1, msg);
	SendAllAdminMessage(-1, ""SERVER_MSG"Для ответа введите /ans [id] [текст].");
	printf("%s спросил: %s",Player[playerid][PlayerName],params[0]);
	ask[playerid] = timesd;
	if(!LanglePlayer{playerid})
		SendClientMessage(playerid, -1, ""SERVER_MSG"Ожидайте ответа!");
	else
		SendClientMessage(playerid, -1, ""SERVER_MSG"Wait response!");
	return true;
}
SendgAdminMessage(color, string[]){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(Player[i][pAdminPlayer] < 6 || !Player[i][logged] || !IsPlayerConnected(i)) continue;
		SendClientMessage(i, color, string);
	}
}
protected SpeedVehicle(playerid)
{
    new Float:ST[4];
	if(IsPlayerInAnyVehicle(playerid))
		GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
	else
		GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 213.3;
    return floatround(ST[3]);
}
protected strrest(const string[], &index){
	new
	length = strlen(string),
	offset = index,
	result[128]
	;
	while ((index < length) && (string[index] <= ' '))index++;
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
protected strtok(const string[], &index){
	new
	length = strlen(string),
	offset = index,
	result[20]
	;
	while ((index < length) && (string[index] <= ' '))index++;
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
t_SetPlayerScore(playerid,score){
    Player[playerid][pScore] = score;
    new counts = Player[playerid][pScore]/2000;
    for(new f; f < counts+1; f++){
		if(Player[playerid][pScore] >= 2000+(Player[playerid][pLevel]*100)){
	    	Player[playerid][pScore]-=2000+(Player[playerid][pLevel]*100);
	    	Player[playerid][pLevel]++;
			GiveLVLBonus(playerid,Player[playerid][pLevel]);
    	}else break;
	}
	new pos = GetInLevelTop(playerid);
 	if(pos && records[RECORD_LEVEL][pos-1] != Player[playerid][pLevel]){
  		records[RECORD_LEVEL][pos-1] = Player[playerid][pLevel];
  		if(pos != 1)
		if(Player[playerid][pLevel] > records[RECORD_LEVEL][pos-2]){
	       	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		 		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
				SaveScore(i);
	}	}   }
	if(!pos && Player[playerid][pLevel] > records[RECORD_LEVEL][9]){
       	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
			if(!IsPlayerConnected(i) || !Player[i][logged])continue;
			SaveScore(i);
		}
		mysql_function_query(MYSQL, "SELECT `Nickname`, `level`,`id` FROM `accounts` ORDER BY `level` DESC LIMIT 10", true, "TopLevelUpdate", "");
	}
	UpdateEx(playerid);
    SetPlayerScore(playerid,Player[playerid][pLevel]);
	return true;
}
GivePlayerScore(playerid,score){
	t_SetPlayerScore(playerid,GetPlayerScore(playerid)+score);
	UpdateScoreSystem(playerid);
    return true;
}
DaiEmyDeneg(playerid, money){
	if(!Player[playerid][logged])
	    Player[playerid][pCashPlayer] = 0;
	else
		Player[playerid][pCashPlayer] += money;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,Player[playerid][pCashPlayer]);
	if(GetPVarInt(playerid,"nick") && money != Player[playerid][pCashPlayer]){
		if(money > 25000 || money < -25000){
			new moneytext[24];
			if(money > 0)
				format(moneytext, sizeof(moneytext), "~g~+%d$",money);
			else
				format(moneytext, sizeof(moneytext), "~r~%d$",money);
			GameTextForPlayer(playerid, moneytext, 3000, 1);
	}   }
	if(money > 0){
		new pos = GetInMoneyTop(playerid);
	 	if(pos && records[RECORD_MONEY][pos-1] != Player[playerid][pCashPlayer]){
  			if(pos != 1)
			if(Player[playerid][pCashPlayer] > records[RECORD_MONEY][pos-2]){
		       	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
					if(!IsPlayerConnected(i) || !Player[i][logged])continue;
					SaveMoney(i);
				}
			}else
				records[RECORD_MONEY][pos-1] = Player[playerid][pCashPlayer];
  		}
		else if(!pos && Player[playerid][pCashPlayer] > records[RECORD_MONEY][9]){
	       	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
				if(!IsPlayerConnected(i) || !Player[i][logged])continue;
				SaveMoney(i);
			}
			mysql_function_query(MYSQL, "SELECT `Nickname`, `Money`,`id` FROM `accounts` ORDER BY `Money` DESC LIMIT 10", true, "TopMoneyUpdate", "");
	}	}
	return true;
}
GetPlayerCash(playerid) return Player[playerid][pCashPlayer];
ResetEmyDengi(playerid){
	Player[playerid][pCashPlayer] = 0;
	return true;
}
Float:GetRampDistance(playerid){
	new ping = GetPlayerPing(playerid), Float:dist;
	dist = floatpower(ping, 0.25);
	dist = dist*4.0;
	dist = dist+5.0;
	return dist;
}
GetOwnedHouses(playerid){
	new tmpcount;
	for(new i = TotalHouses-1; i != -1; --i)
	{
		if(HouseInfo[i][howneruid] != Player[playerid][pSQLID]) continue;
		tmpcount++;
	}
	return tmpcount;
}
ReturnPlayerHouseID(playerid, houseslot){
	new tmpcount;
	if(houseslot < 1 || houseslot > MAX_OWNED_HOUSES) return -1;
	for(new i; i < TotalHouses; i++)
	{
		if(HouseInfo[i][howneruid] != Player[playerid][pSQLID]) continue;
		tmpcount++;
		if(tmpcount == houseslot)
			return i;
	}
	return -1;
}
public OnPlayerEnterRaceCheckpoint(playerid){
	return true;
}
SaleCar(playerid,slot){
	DaiEmyDeneg(playerid,GetPrice(Player[playerid][pAuto][slot]));
	Player[playerid][pAuto][slot] = 0;
	return true;
}
protected SaleVIPCars(playerid){
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		if(Player[playerid][pAuto][f]){
			if(isVIPcar(Player[playerid][pAuto][f])){
				if(Player[playerid][pVcar] == f || Player[playerid][pVcar] == Player[playerid][pAutoUID][f])
					Player[playerid][pVcar] = 0;
				if(pvehs[f][playerid] != INVALID_VEHICLE_ID)
					DestroyVehicle(pvehs[f][playerid]);
				pvehs[f][playerid] = INVALID_VEHICLE_ID;
				new query[112];
				format(query, sizeof(query),"DELETE FROM  "CARS_TABLE" WHERE `cID` = %d",Player[playerid][pAutoUID][f]);
				mysql_function_query(MYSQL, query, false, "", "");
				pNumber[f][playerid] = "";
				SaleCar(playerid,f);
	}	}	}
	return true;
}
protected ReturnVidVehicle(model){
	switch(model)
	{
		case 509,481,510,462,448,581,522,461,521,523,463,586,468,471: 	return MOTO_TS; 	//Мотаки
		case 460,476,511,512,513,519,520,553,577,592,593: 				return AIR_TS; 		//Самолеты
		case 417,425,447,469,487,488,497,548,563: 						return MAVERICK_TS; //вертолеты
		case 472,473,493,595,484,430,453,452,446,454:					return SEA_TS; 		//Лодки
		default: 														return CAR_RS;      //Машины
	}
	return -1;
}
protected ReturnVidVehicleName(model){
    new vid = ReturnVidVehicle(model),
        vids[16];
    switch(vid)
    {
        case 	CAR_RS: 	strcat(vids," автомобиль ");
        case 	MOTO_TS: 	strcat(vids," мотоцикл ");
        case 	AIR_TS: 	strcat(vids," самолет ");
        case 	MAVERICK_TS:strcat(vids," вертолет ");
        case 	SEA_TS:  	strcat(vids," лодку ");
	}
	return vids;
}
protected ReturnVidVehicleNameEn(model){
    new vid = ReturnVidVehicle(model),
        vids[16];
    switch(vid)
    {
        case 	CAR_RS: 	strcat(vids," car ");
        case 	MOTO_TS: 	strcat(vids," motorcycle ");
        case 	AIR_TS: 	strcat(vids," plane ");
        case 	MAVERICK_TS:strcat(vids," helicopter ");
        case 	SEA_TS:  	strcat(vids," boat ");
	}
	return vids;
}
public CarMenu(playerid,slot){
	new msg[267],
		model = Player[playerid][pAuto][slot],
		carided = pvehs[slot][playerid];
    if(!LanglePlayer{playerid}){
		strcat(msg,"\rПереместить");
		strcat(msg,ReturnVidVehicleName(model));
		strcat(msg,"к себе.\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		strcat(msg,"Переместиться в");
		strcat(msg,ReturnVidVehicleName(model));
		strcat(msg,"\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		strcat(msg,"Убрать\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		else
	        strcat(msg,""STRELKIEX"");
		strcat(msg,"Тюнинг\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		else
	        strcat(msg,""STRELKIEX"");
		strcat(msg,"Настройки\r\n{FFFFFF}Продать");
		strcat(msg,ReturnVidVehicleName(model));
		new str[112];
		format(str, sizeof(str), ""MENU_PRFX_CARS""STRELKI"%s", VehicleNames[model-400]);
		ShowPlayerDialog(playerid,113, DIALOG_STYLE_LIST, str,msg, "Выбор", "Назад");
	}else{
		strcat(msg,"\rMove");
		strcat(msg,ReturnVidVehicleNameEn(model));
		strcat(msg,"to me.\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		strcat(msg,"Move in");
		strcat(msg,ReturnVidVehicleNameEn(model));
		strcat(msg,"\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		strcat(msg,"Hide\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		else
	        strcat(msg,""STRELKIEX"");
		strcat(msg,"Tunung\r\n");
	    if(!IsValidVehicle(carided))
	        strcat(msg,"{808080}");
		else
	        strcat(msg,""STRELKIEX"");
		strcat(msg,"Settings\r\n{FFFFFF}Sell");
		strcat(msg,ReturnVidVehicleNameEn(model));
		new str[112];
		format(str, sizeof(str), ""MENU_PRFX_CARS_EN""STRELKI"%s", VehicleNames[model-400]);
		ShowPlayerDialog(playerid,113, DIALOG_STYLE_LIST, str,msg, "Select", "Back");
	}
	return true;
}
BuyCar(playerid,slot,car){
    minidialog = "";
	format(minidialog, sizeof(minidialog),"INSERT INTO "CARS_TABLE" ( `cModel`, `cPos_x`, `cPos_y`, `cPos_z`, `cPos_a`, `cVirtWorld`, `cVinil`, `cColorOne`, `cColorTwo`, `cOwner`) VALUES ( %d,%f,%f,%f,%f,0,-1,1,0,%d)",
		car,
		PosInGarage[slot][pPosX],
		PosInGarage[slot][pPosY],
		PosInGarage[slot][pPosZ],
		PosInGarage[slot][pPosA],
		Player[playerid][pSQLID]
	);
	mysql_function_query(MYSQL, minidialog, true, "UpdateCarUID", "id",playerid,slot);
	Player[playerid][pAuto][slot] = car;
	Player[playerid][pColor][slot] = 1;
	Player[playerid][pColorTwo][slot] = 0;
	Player[playerid][pVinil][slot] = -1;
	pvehs[slot][playerid] = t_CreateVehicle(car,PosInGarage[slot][pPosX],PosInGarage[slot][pPosY],PosInGarage[slot][pPosZ]+1, PosInGarage[slot][pPosA],1,0,-1);
	format(pNumber[slot][playerid],25,"{000000}ID%d",random(10000));
	SetVehicleNumberPlate(pvehs[slot][playerid],pNumber[slot][playerid]);
	t_SetVehicleVirtualWorld(playerid,pvehs[slot][playerid],VIRT_GARAGE+playerid);
	CarMenu(playerid,slot);
	SetPVarInt(playerid,"CarIdMenu",slot);
	return true;
}
public UpdateCarUID(playerid,slot){
	Player[playerid][pAutoUID][slot] = cache_insert_id();
	if(slot == 1){
	 	new savecar[64];
		format(savecar, sizeof savecar, "UPDATE "TABLE_ACC" SET `Vmashine`= '%d' WHERE `id`='%d'",
		    Player[playerid][pAutoUID][slot],
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, savecar, false, "", "");
	}
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
protected RemovDDInfo(raceid){
	if(GetPlayerVirtualWorld(DDInfo[raceid][rRacer][0]) == DDInfo[raceid][rRacer][0]+100)
		t_SetPlayerVirtualWorld(DDInfo[raceid][rRacer][0],0);
	if(GetPlayerVirtualWorld(DDInfo[raceid][rRacer][1]) == DDInfo[raceid][rRacer][1]+100)
		t_SetPlayerVirtualWorld(DDInfo[raceid][rRacer][1],0);
	DDInfo[raceid][rRaceStatus] = RACE_STAT_NO;
	rRaceStatusEx[DDInfo[raceid][rRacer][0]] = STATUS_NO_RACE;
	rRaceStatusEx[DDInfo[raceid][rRacer][1]] = STATUS_NO_RACE;
	DDInfo[raceid][rTrackID] = -1;
	DDInfo[raceid][rPoints][0] = 0;
	DDInfo[raceid][rPoints][1] = 0;
	DDInfo[raceid][rTime] = -1;
	DDInfo[raceid][rPrize] = 0;
	DDInfo[raceid][rWinner] = INVALID_PLAYER_ID;
	if(DDInfo[raceid][DDcars][0] != INVALID_VEHICLE_ID){
		DestroyVehicle(DDInfo[raceid][DDcars][0]);
		DestroyVehicle(DDInfo[raceid][DDcars][1]);
		HideAllDDTD(DDInfo[raceid][rRacer][0]);
		HideAllDDTD(DDInfo[raceid][rRacer][1]);	
		DDInfo[raceid][DDcars][0] = INVALID_VEHICLE_ID;
		DDInfo[raceid][DDcars][1] = INVALID_VEHICLE_ID;
	}
	DDInfo[raceid][rRacer][0] = INVALID_PLAYER_ID;
	DDInfo[raceid][rRacer][1] = INVALID_PLAYER_ID;
}
protected ShowAllDDTD(raceid){
	new recordscore[10];
	format(recordscore,sizeof(recordscore),"%04d",RaceInfo[DDInfo[raceid][rTrackID]][Record]);	
	TextDrawSetString(RaceTextDraw[raceid][DT_RECORDER_NAME],RaceInfo[DDInfo[raceid][rTrackID]][Recordsman]);
	TextDrawSetString(RaceTextDraw[raceid][DT_RECORDER_SCORE],recordscore);
	new winner = DDInfo[raceid][rWinner],
		looser = GetDDSopernikID(DDInfo[raceid][rWinner]);
	TextDrawSetString(RaceTextDraw[raceid][DT_LEADER_NAME], Player[winner][PlayerName]);
	TextDrawSetString(RaceTextDraw[raceid][DT_LOOSER_NAME], Player[looser][PlayerName]);
	TextDrawSetString(RaceTextDraw[raceid][DT_LEADER_POINTS], "0000");
	TextDrawSetString(RaceTextDraw[raceid][DT_LOOSER_POINTS], "0000");
	TextDrawSetString(RaceTextDraw[raceid][DT_TIME_TEXT],"Time: 1:30");
	for(new i; i < 2; i++){
		new playerid = DDInfo[raceid][rRacer][i];
		for(new f; f < 7; f++)
			TextDrawShowForPlayer(playerid,RaceTextDraw[raceid][f]);
		for(new f; f < 7; f++)
			TextDrawShowForPlayer(playerid,AllRaceTextDraw[f]);
	}
	TextDrawShowForPlayer(winner,AllRaceTextDraw[7]);
	TextDrawShowForPlayer(looser,AllRaceTextDraw[8]);
}
protected StartDuel(raceid,&track = -1){
	if(track == -1)
		track = random(RACE_TRACKS);
	new racer1 = DDInfo[raceid][rRacer][0],
		racer2 = DDInfo[raceid][rRacer][1];
	DDInfo[raceid][rTrackID] = track;
	Player[racer1][pOldDuel] = gettime();
	Player[racer2][pOldDuel] = gettime();
	SaceSlot[racer1] = 0;
	SaceSlot[racer2] = 1;
	TPToTrack[racer1] = 0;
	TPToTrack[racer2] = 0;
	TPToTrackEx[racer1] = 0;
	TPToTrackEx[racer2] = 0;
	DDInfo[raceid][rWinner] = (racer1>racer2)?racer1:racer2;
	t_SetPlayerVirtualWorld(racer1,100+racer1);
	t_SetPlayerVirtualWorld(racer2,100+racer2);
	ShowAllDDTD(raceid);
	DDInfo[raceid][rRacer][0] = racer1;
	DDInfo[raceid][rRacer][1] = racer2;
	DDInfo[raceid][DDcars][0] = t_CreateVehicle(562,Starts[track][startX],Starts[track][startY],Starts[track][startZ],Starts[track][startA],random(255),1,-1);
	DDInfo[raceid][DDcars][1] = t_CreateVehicle(562,Starts[track][startX],Starts[track][startY],Starts[track][startZ],Starts[track][startA],random(255),1,-1);
	SetVehicleVirtualWorld(DDInfo[raceid][DDcars][0],100+racer1);
	SetVehicleVirtualWorld(DDInfo[raceid][DDcars][1],100+racer2);
	t_PutPlayerInVehicle(racer1, DDInfo[raceid][DDcars][0]);
	t_PutPlayerInVehicle(racer2, DDInfo[raceid][DDcars][1]);
	DDInfo[raceid][rTime] = 95;	
	DaiEmyDeneg(racer1,-(PrizDD[racer1]/4));
	DaiEmyDeneg(racer2,-(PrizDD[racer2]/4)); 
	DDInfo[raceid][rRaceStatus] = RACE_STAT_STARTED;
	rRaceStatusEx[racer1] = STATUS_RACE_STARTED;
	rRaceStatusEx[racer2] = STATUS_RACE_STARTED;
	if(!LanglePlayer{racer1})
		SendClientMessage(racer1,-1,""SERVER_MSG""DUEL_TEXT_1"");
		else SendClientMessage(racer1,-1,""SERVER_MSG""DUEL_TEXT_1_EN"");
	if(!LanglePlayer{racer2})
		SendClientMessage(racer2,-1,""SERVER_MSG""DUEL_TEXT_1"");
	else SendClientMessage(racer2,-1,""SERVER_MSG"Help: For return for the beginning of the route enter\"/rr\".");
	return true;
}
protected StopDuel(raceid){
	if(DDInfo[raceid][rTime] < 1){
		new winner = (DDInfo[raceid][rPoints][0] > DDInfo[raceid][rPoints][1])?DDInfo[raceid][rRacer][0]:DDInfo[raceid][rRacer][1],
			looser = (winner==DDInfo[raceid][rRacer][0])?DDInfo[raceid][rRacer][1]:DDInfo[raceid][rRacer][0],
			winnerSlot = (DDInfo[raceid][rPoints][0] > DDInfo[raceid][rPoints][1])?0:1,
			looserSlot = (winner==DDInfo[raceid][rRacer][0])?1:0;
		format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName],DDInfo[raceid][rPoints][winnerSlot]-DDInfo[raceid][rPoints][looserSlot]);
		format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"{%s}%s{FFFFFF} "LISTS_TEXT_EN"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName],DDInfo[raceid][rPoints][winnerSlot]-DDInfo[raceid][rPoints][looserSlot]);
		t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
		GameTextForPlayer(winner,"~g~Winner!",1000,6);
		GameTextForPlayer(looser,"~r~Looser!",1000,6);
		DaiEmyDeneg(looser,PrizDD[looser]/4);
		new winermoney = PrizDD[winner];
		if(DDInfo[raceid][rPoints][winnerSlot] == RaceInfo[DDInfo[raceid][rTrackID]][Record]){
			if(RaceInfo[DDInfo[raceid][rTrackID]][RecordsmanUID] != Player[winner][pSQLID])
				winermoney+=100000;
		}
		DaiEmyDeneg(winner,winermoney);
		Player[winner][pWinRace]++;
		if(Player[winner][cClan][0] != INVALID_CLAN_ID)
			GiveClanRate(Player[winner][cClan][0],1);
		if(Player[winner][cClan][1] != INVALID_CLAN_ID)
			GiveClanRate(Player[winner][cClan][1],1);
		Player[looser][pLooseRace]++;
		if(!LanglePlayer{winner})
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG""DUEL_TEXT_2"",winermoney);
		else
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG""DUEL_TEXT_2_EN"",winermoney);
		SendClientMessage(winner, -1, msgcheat);
		if(DDInfo[raceid][rPoints][winnerSlot] == RaceInfo[DDInfo[raceid][rTrackID]][Record]){
			RaceInfo[DDInfo[raceid][rTrackID]][Record] = DDInfo[raceid][rPoints][winnerSlot];
			if(RaceInfo[DDInfo[raceid][rTrackID]][RecordsmanUID] != Player[winner][pSQLID]){
				format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_3"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],DDInfo[raceid][rPoints][winnerSlot],Starts[DDInfo[raceid][rTrackID]][rName]);
				format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_3_EN"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],DDInfo[raceid][rPoints][winnerSlot],Starts[DDInfo[raceid][rTrackID]][rNameEn]);
			}else{
				format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_4"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],Starts[DDInfo[raceid][rTrackID]][rName],DDInfo[raceid][rPoints][winnerSlot]);
				format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_4_EN"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],Starts[DDInfo[raceid][rTrackID]][rName],DDInfo[raceid][rPoints][winnerSlot]);
			}
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
			RaceInfo[DDInfo[raceid][rTrackID]][RecordsmanUID] = Player[winner][pSQLID];
			format(RaceInfo[DDInfo[raceid][rTrackID]][Recordsman], MAX_PLAYER_NAME, Player[winner][PlayerName]);
			new savecar[128];
			format(savecar, sizeof savecar, "UPDATE `rRaceInfo` SET `rRecord`= '%d',`rRecorderUID`= '%d',`rRecorder`= '%s' WHERE `rID`='%d'",
				RaceInfo[DDInfo[RaceID[winner]][rTrackID]][Record],
				RaceInfo[DDInfo[RaceID[winner]][rTrackID]][RecordsmanUID],
				Player[winner][PlayerName],
				DDInfo[RaceID[winner]][rTrackID]+1
			);
			mysql_function_query(MYSQL, savecar, false, "", "");		
		}
	}
	RemovDDInfo(raceid);
	return true;
}
protected GetPrizeDD(racer1,racer2){
	new prize = 50000;
	for(new p = 1; p < 5; p++){
		if(Player[racer1][pLevel] >= p*10 && Player[racer2][pLevel] >= p*10 && GetPlayerCash(racer1) >= p*50000 && GetPlayerCash(racer2) >= p*50000){
			prize = p*50000;continue;
		}else
			break;
	}
	return prize;
}
protected FindSopernik(playerid){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i) || !Player[i][logged] || i == playerid || rRaceStatusEx[i] != STATUS_RACE_WAIT) continue;
		return i;
	}
	return INVALID_PLAYER_ID;
}
protected FindNoOwnedRace(){
	for(new r; r < MAX_RACE; r++)
		if(!DDInfo[r][rRaceStatus]) return r;
	return -1;
}
enum checks{
	Rradius,
	Float:checkX,
	Float:checkY,
	Float:checkZ
};
new const checksD1[37][checks] = {
    {60,-312.49301147461,1448.3459472656,58.532001495361},
    {60,-370.6960144043,1348.5989990234,41.798999786377},
    {60,-389.30099487305,1417.3649902344,23.58099937439},
    {25,-443.80200195313,1463.6810302734,26.66900062561},
    {25,-444.97900390625,1510.7320556641,22.986000061035},
    {25,-453.02600097656,1557.6629638672,31.128000259399},
    {25,-456.43301391602,1605.3120117188,31.857000350952},
    {25,-433.35101318359,1647.7939453125,32.568000793457},
    {25,-409.8330078125,1689.3070068359,33.743000030518},
    {25,-400.88000488281,1736.7669677734,38.13399887085},
    {60,-426.5539855957,1799.1839599609,37.826000213623},
    {60,-425.81399536133,1871.9809570313,53.859001159668},
    {60,-510.8630065918,1945.9510498047,54.25899887085},
    {70,-425.13900756836,2029.0760498047,58.340999603271},
    {25,-554.95300292969,2012.0799560547,58.132999420166},
    {25,-593.03002929688,2035.0469970703,58.382999420166},
    {25,-633.43402099609,2054.6899414063,58.828998565674},
    {25,-677.4580078125,2065.5439453125,58.186000823975},
    {25,-722.86297607422,2061.75390625,58.632999420166},
    {25,-767.91900634766,2058.2351074219,60.187999725342},
    {25,-794.74798583984,2040.5720214844,58.437999725342},
    {25,-835.80297851563,2028.458984375,58.187999725342},
    {25,-867.51098632813,1998.1080322266,57.882999420166},
    {25,-881.46301269531,1966.1209716797,56.89400100708},
    {25,-870.90197753906,1919.3669433594,59.953998565674},
    {25,-856.85797119141,1873.3719482422,59.404998779297},
    {25,-863.48199462891,1832.7600097656,57.145000457764},
    {25,-879.35302734375,1814.5870361328,55.870998382568},
    {25,-904.90197753906,1798.0219726563,56.495998382568},
    {25,-937.26202392578,1811.4580078125,59.814998626709},
    {25,-972.96002197266,1837.3950195313,57.543998718262},
    {25,-1014.2199707031,1852.2390136719,54.34700012207},
    {25,-1054.9350585938,1842.6379394531,44.363998413086},
    {25,-1091.1689453125,1818.5529785156,40.486000061035},
    {25,-1132.7399902344,1797.1340332031,41.256000518799},
    {25,-1179.6510009766,1798.8850097656,28.287000656128},
    {25,-1202.2580566406,1816.6099853516,26.409000396729}
};
new const checksD2[37][checks] = {
	{30,-2431.8520507813,-595.958984375,132.13900756836},
    {30,-2445.4331054688,-569.76800537109,126.58100128174},
    {30,-2454.2587890625,-539.6435546875,119.66100311279},
    {30,-2460.7041015625,-512.33502197266,109.93299865723},
    {30,-2479.0148925781,-484.99301147461,99.000999450684},
    {30,-2514.6630859375,-484.275390625,89.460998535156},
    {30,-2545.9050292969,-491.04501342773,80.651000976563},
    {50,-2613.625,-489.78515625,66.48999786377},
    {30,-2578.8310546875,-491.1220703125,76.25700378418},
    {30,-2569.3994140625,-468.337890625,68.251998901367},
    {30,-2536.416015625,-463.5078125,70.140998840332},
    {30,-2506.056640625,-453.0,74.272003173828},
    {30,-2478.4052734375,-436.837890625,79.981002807617},
    {30,-2448.919921875,-422.52499389648,84.633003234863},
    {30,-2417.7890625,-416.67001342773,85.505996704102},
    {30,-2390.08203125,-421.58099365234,83.278999328613},
    {30,-2357.1330566406,-403.26901245117,79.042999267578},
    {30,-2379.0710449219,-380.6130065918,76.397003173828},
    {30,-2407.6970214844,-371.91500854492,74.06600189209},
    {30,-2439.4790039063,-369.32800292969,70.801002502441},
    {30,-2469.9150390625,-367.27899169922,66.722999572754},
    {30,-2501.1474609375,-367.76953125,61.737998962402},
    {30,-2534.4399414063,-369.95001220703,56.035999298096},
    {30,-2559.5310058594,-366.93499755859,51.495998382568},
    {30,-2583.9150390625,-370.76000976563,47.095001220703},
    {30,-2607.8168945313,-375.49499511719,40.946998596191},
    {30,-2632.8259277344,-383.75799560547,36.638999938965},
    {30,-2660.6870117188,-399.87600708008,32.571998596191},
    {30,-2676.9079589844,-423.79800415039,31.978000640869},
    {30,-2678.8659667969,-454.9289855957,28.636999130249},
    {30,-2671.0930175781,-484.33099365234,23.111000061035},
    {30,-2676.6770019531,-515.00402832031,18.065999984741},
    {30,-2705.7670898438,-528.08001708984,11.840000152588},
    {30,-2735.8510742188,-519.14501953125,8.0530004501343},
    {30,-2761.0249023438,-502.5530090332,7.2379999160767},
    {30,-2785.2160644531,-486.19299316406,7.191999912262},
    {60,-2344.8811035156,-444.02899169922,78.634002685547}
};
new const checksD4[16][checks] = {
    {200,-1394.9040527344,382.58898925781,6.2170000076294},
    {35,-1315.6459960938,467.87200927734,7.188000202179},
    {85,-1262.5570068359,439.94198608398,7.188000202179},
    {35,-1460.1309814453,464.47698974609,7.188000202179},
    {35,-1492.1159667969,465.24398803711,7.188000202179},
    {35,-1525.8330078125,464.43899536133,7.188000202179},
    {35,-1547.6810302734,435.77600097656,7.1799998283386},
    {35,-1571.3270263672,407.77301025391,7.188000202179},
    {35,-1596.2299804688,380.09899902344,7.188000202179},
    {35,-1623.7790527344,353.52600097656,7.188000202179},
    {35,-1620.7590332031,315.07299804688,7.188000202179},
    {35,-1596.0579833984,285.11898803711,7.188000202179},
    {35,-1558.5999755859,274.71301269531,7.188000202179},
    {35,-1523.0789794922,274.53399658203,7.186999797821},
    {35,-1486.7370605469,273.66900634766,7.188000202179},
    {35,-1448.6999511719,275.66101074219,7.188000202179}
};
enum checksEx{
	Float:checkX,
	Float:checkY,
	Float:checkZ
};
new const checksD1Ex[18][checksEx] = {
    {-299.3116,1473.0765,74.6182},
    {-305.2440,1394.2413,71.9835},
    {-366.1528,1465.7395,62.8982},
    {-323.0908,1320.2822,52.9192},
    {-426.7885,1451.7140,33.9487},
    {-448.6060,1617.5502,35.3618},
    {-402.7701,1725.8013,40.7602},
    {-392.9504,1903.7494,57.3625},
    {-456.1992,1763.3264,71.9113},
    {-480.8072,1932.1510,86.0945},
    {-383.5000,2073.3281,60.5762},
    {-383.5000,2073.3281,60.5762},
    {-526.9953,1988.3735,60.0508},
    {-761.5449,2059.3879,59.9076},
    {-874.0538,1932.9331,59.8443},
    {-878.1665,1800.5734,59.8694},
    {-995.8288,1852.8228,62.7757},
    {-1179.5188,1798.4725,40.1880}
};
new const checksD2Ex[10][checksEx] = {
    {-2426.6187,-603.4324,132.2184},
    {-2484.7397,-482.0301,97.4924},
    {-2627.5005,-496.4293,69.9346},
    {-2416.9636,-416.5257,85.0950},
    {-2335.6357,-462.9105,79.6793},
    {-2324.2644,-455.6050,79.6815},
    {-2377.8330,-380.9350,76.1403},
    {-2625.6099,-380.5227,37.9607},
    {-2679.1096,-522.7261,16.9023},
    {-2782.3435,-489.4999,6.8460}
};
new const checksD4Ex[7][checksEx] = {
    {-1566.3076,272.2550,6.8462},
    {-1425.6057,296.4786,6.8411},
    {-1330.6388,339.0950,6.8454},
    {-1465.5387,391.7244,6.8477},
    {-1230.9652,439.5977,6.8456},
    {-1529.8633,471.5204,6.8454},
    {-1603.1110,382.8674,6.8411}
};
protected CheckDis(playerid,trackid){
	if(trackid == 0){
		for(new r; r < sizeof(checksD1); r++){
			if(GetPlayerDistanceFromPoint(playerid, checksD1[r][checkX], checksD1[r][checkY], checksD1[r][checkZ]) <= (checksD1[r][Rradius]+20))
				return true;
		}
	}
	else if(trackid == 1){
		for(new r; r < sizeof(checksD2); r++){
			if(GetPlayerDistanceFromPoint(playerid, checksD2[r][checkX], checksD2[r][checkY], checksD2[r][checkZ]) <= (checksD2[r][Rradius]+20))
				return true;
		}
	}
	else if(trackid == 2){
		for(new r; r < sizeof(checksD4); r++){
			if(GetPlayerDistanceFromPoint(playerid, checksD4[r][checkX], checksD4[r][checkY], checksD4[r][checkZ]) <= (checksD4[r][Rradius]+20))
				return true;
		}
	}
	else
		return true;
	return false;
}
protected GetMinCheckDis(playerid,trackid,&Float:pX,&Float:pY,&Float:pZ){
	new Float:distop,Float:distopEx;
	if(trackid == 0){
		for(new r; r < sizeof(checksD1Ex); r++){
			distopEx = GetPlayerDistanceFromPoint(playerid, checksD1Ex[r][checkX], checksD1Ex[r][checkY], checksD1Ex[r][checkZ]);
			if(r == 0 || distopEx < distop){
				distop = distopEx;
				pX = checksD1Ex[r][checkX];
				pY = checksD1Ex[r][checkY];
				pZ = checksD1Ex[r][checkZ];
			}
		}
	}
	else if(trackid == 1){
		for(new r; r < sizeof(checksD2Ex); r++){
			distopEx = GetPlayerDistanceFromPoint(playerid, checksD2Ex[r][checkX], checksD2Ex[r][checkY], checksD2Ex[r][checkZ]);
			if(r == 0 || distopEx < distop){
				distop = distopEx;
				pX = checksD2Ex[r][checkX];
				pY = checksD2Ex[r][checkY];
				pZ = checksD2Ex[r][checkZ];
			}
		}
	}
	else if(trackid == 2){
		for(new r; r < sizeof(checksD4Ex); r++){
			distopEx = GetPlayerDistanceFromPoint(playerid, checksD4Ex[r][checkX], checksD4Ex[r][checkY], checksD4Ex[r][checkZ]);
			if(r == 0 || distopEx < distop){
				distop = distopEx;
				pX = checksD4Ex[r][checkX];
				pY = checksD4Ex[r][checkY];
				pZ = checksD4Ex[r][checkZ];
			}
		}
	}
}
protected CheckDriftDuel(){
	new racer1 = INVALID_PLAYER_ID,
		racer2 = INVALID_PLAYER_ID;
	racer1 = FindSopernik(INVALID_PLAYER_ID);
	if(racer1 != INVALID_PLAYER_ID)
		racer2 = FindSopernik(racer1);
	new raceid = FindNoOwnedRace();
	if(racer1 != INVALID_PLAYER_ID && racer2 != INVALID_PLAYER_ID && raceid != -1){
		RaceID[racer1] = raceid;
		RaceID[racer2] = raceid;
		rRaceStatusEx[racer1] = STATUS_SEND_ACCEPT;
		rRaceStatusEx[racer2] = STATUS_SEND_ACCEPT;
		DDInfo[raceid][rRaceStatus] = RACE_STAT_WAIT;
		DDInfo[raceid][rRacer][0] = racer1;
		DDInfo[raceid][rRacer][1] = racer2;				
		DDInfo[raceid][rPrize] = GetPrizeDD(racer2,racer1);
		PrizDD[racer2]=DDInfo[raceid][rPrize];
		PrizDD[racer1]=DDInfo[raceid][rPrize];
		if(!LanglePlayer{racer1})
			ShowPlayerDialog(racer1,DIALOG_DRIFT_RACE,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5"","{FFFFFF}"DUEL_TEXT_6"","Стартуем","Отмена");
		else
			ShowPlayerDialog(racer1,DIALOG_DRIFT_RACE,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5_EN"","{FFFFFF}"DUEL_TEXT_6_EN"","Start","Cancel");
		if(!LanglePlayer{racer2})
			ShowPlayerDialog(racer2,DIALOG_DRIFT_RACE,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5"","{FFFFFF}"DUEL_TEXT_6"","Стартуем","Отмена");
		else
			ShowPlayerDialog(racer2,DIALOG_DRIFT_RACE,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5_EN"","{FFFFFF}"DUEL_TEXT_6_EN"","Start","Cancel");
	}
	for(new r; r < MAX_RACE; r++){
		if(DDInfo[r][rRaceStatus] == RACE_STAT_STARTED && rRaceStatusEx[DDInfo[r][rRacer][0]] == STATUS_NO_RACE || DDInfo[r][rRaceStatus] == RACE_STAT_STARTED &&  rRaceStatusEx[DDInfo[r][rRacer][1]] == STATUS_NO_RACE){
			if(RemovStatusRace[r] > 10)
				RemovDDInfo(r);
			else
				RemovStatusRace[r]++;
		}
		else if(DDInfo[r][rRaceStatus] == RACE_STAT_WAIT && rRaceStatusEx[DDInfo[r][rRacer][0]] == STATUS_NO_RACE || DDInfo[r][rRaceStatus] == RACE_STAT_WAIT &&  rRaceStatusEx[DDInfo[r][rRacer][1]] == STATUS_NO_RACE){
			if(RemovStatusRace[r] > 10)
				RemovDDInfo(r);
			else
				RemovStatusRace[r]++;
		}
		else if(RemovStatusRace[r])
			RemovStatusRace[r] = 0;
		if(DDInfo[r][rRaceStatus] != RACE_STAT_STARTED)continue;
		DDInfo[r][rTime]--;
		new timeEx = DDInfo[r][rTime];
		new TimeText[20];
		if(timeEx <= 0)
			StopDuel(r);
		else if(timeEx < 90){//
			format(TimeText,sizeof(TimeText),"Time: %d:%02d",timeEx >= 60?1:0,(timeEx >= 60)?(timeEx-60):timeEx);
			TextDrawSetString(RaceTextDraw[r][DT_TIME_TEXT],TimeText);
			if(Starts[DDInfo[r][rTrackID]][rChecks] && !CheckDis(DDInfo[r][rRacer][0],DDInfo[r][rTrackID])){
				TPToTrack[DDInfo[r][rRacer][0]]++;
				if(TPToTrack[DDInfo[r][rRacer][0]]){
					TPToTrack[DDInfo[r][rRacer][0]]=0;
					TPToTrackEx[DDInfo[r][rRacer][0]]++;
					if(TPToTrackEx[DDInfo[r][rRacer][0]] > 8){
						new winner = DDInfo[r][rRacer][1],
							looser = DDInfo[r][rRacer][0];
						format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_7"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName]);
						format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_7_EN"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName]);
						t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
						GameTextForPlayer(winner,"~g~Winner!",1000,6);
						GameTextForPlayer(looser,"~r~Looser!",1000,6);
						DaiEmyDeneg(winner,PrizDD[winner]);
						DaiEmyDeneg(looser,-PrizDD[looser]/4);
						Player[winner][pWinRace]++;
						Player[looser][pLooseRace]++;
						if(!LanglePlayer{winner})
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Приз за победу в дуэли: $%d",PrizDD[winner]);
						else
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Prize for winning the duel: $%d",PrizDD[winner]);
						SendClientMessage(winner, -1, msgcheat);
						if(!LanglePlayer{looser})
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Штраф за уход с дуэли: $%d",PrizDD[winner]/4);
						else
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Penalty for leaving the duel: $%d",PrizDD[winner]/4);
						SendClientMessage(looser, -1, msgcheat);
						StopDuel(r);	
					}
					new Float:pPosEx[3];
					GetMinCheckDis(DDInfo[r][rRacer][0],DDInfo[r][rTrackID],pPosEx[0],pPosEx[1],pPosEx[2]);
					t_SetVehiclePos(GetPlayerVehicleID(DDInfo[r][rRacer][0]),pPosEx[0],pPosEx[1],pPosEx[2]);
				}
			}
			if(Starts[DDInfo[r][rTrackID]][rChecks] && !CheckDis(DDInfo[r][rRacer][1],DDInfo[r][rTrackID])){
				TPToTrack[DDInfo[r][rRacer][1]]++;
				if(TPToTrack[DDInfo[r][rRacer][1]] > 0){
					TPToTrack[DDInfo[r][rRacer][1]]=0;
					TPToTrackEx[DDInfo[r][rRacer][1]]++;
					if(TPToTrackEx[DDInfo[r][rRacer][1]] > 4){
						new winner = DDInfo[r][rRacer][0],
							looser = DDInfo[r][rRacer][1];
						format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_7"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName]);
						format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_7_EN"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName]);
						t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
						GameTextForPlayer(winner,"~g~Winner!",1000,6);
						GameTextForPlayer(looser,"~r~Looser!",1000,6);
						DaiEmyDeneg(winner,PrizDD[winner]);
						DaiEmyDeneg(looser,-PrizDD[looser]/4);
						Player[winner][pWinRace]++;
						Player[looser][pLooseRace]++;
						if(!LanglePlayer{winner})
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Приз за победу в дуэли: $%d",PrizDD[winner]);
						else
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Prize for winning the duel: $%d",PrizDD[winner]);
						SendClientMessage(winner, -1, msgcheat);
						if(!LanglePlayer{looser})
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Штраф за уход с дуэли: $%d",PrizDD[winner]/4);
						else
							format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Penalty for leaving the duel: $%d",PrizDD[winner]/4);
						SendClientMessage(looser, -1, msgcheat);
						StopDuel(r);	
					}
					new Float:pPosEx[3];
					GetMinCheckDis(DDInfo[r][rRacer][1],DDInfo[r][rTrackID],pPosEx[0],pPosEx[1],pPosEx[2]);
					t_SetVehiclePos(GetPlayerVehicleID(DDInfo[r][rRacer][1]),pPosEx[0],pPosEx[1],pPosEx[2]);
				}
			}
		}else{
			if(timeEx != 90)
				format(TimeText,sizeof(TimeText),"Count: %d",timeEx-90);
			else{
				new Float:dis;
				dis = GetPlayerDistanceFromPoint(DDInfo[r][rRacer][0], Starts[DDInfo[r][rTrackID]][startX],Starts[DDInfo[r][rTrackID]][startY],Starts[DDInfo[r][rTrackID]][startZ]);
				if(dis > 10){
					t_SetVehiclePos(DDInfo[r][DDcars][0],Starts[DDInfo[r][rTrackID]][startX],Starts[DDInfo[r][rTrackID]][startY],Starts[DDInfo[r][rTrackID]][startZ]);
					SetVehicleZAngle(DDInfo[r][DDcars][0],Starts[DDInfo[r][rTrackID]][startA]);
				}
				dis = GetPlayerDistanceFromPoint(DDInfo[r][rRacer][1], Starts[DDInfo[r][rTrackID]][startX],Starts[DDInfo[r][rTrackID]][startY],Starts[DDInfo[r][rTrackID]][startZ]);
				if(dis > 10){
					t_SetVehiclePos(DDInfo[r][DDcars][1],Starts[DDInfo[r][rTrackID]][startX],Starts[DDInfo[r][rTrackID]][startY],Starts[DDInfo[r][rTrackID]][startZ]);
					SetVehicleZAngle(DDInfo[r][DDcars][1],Starts[DDInfo[r][rTrackID]][startA]);
				}
				SetVehicleParamsEx(DDInfo[r][DDcars][0],1,(hour < 7 || hour > 21)?1:0,0,0,0,0,0);
				SetVehicleParamsEx(DDInfo[r][DDcars][1],1,(hour < 7 || hour > 21)?1:0,0,0,0,0,0);
				strcat(TimeText,"~r~GO ~g~GO ~w~GO");
			}
			GameTextForPlayer(DDInfo[r][rRacer][0], TimeText, 1050, 6);
			GameTextForPlayer(DDInfo[r][rRacer][1], TimeText, 1050, 6);
		}
	}
	return true;
}
protected HideAllDDTD(playerid){
	for(new f; f < 7; f++)
		TextDrawHideForPlayer(playerid,RaceTextDraw[RaceID[playerid]][f]);
	for(new f; f < 9; f++)
		TextDrawHideForPlayer(playerid,AllRaceTextDraw[f]);
	RaceID[playerid] = -1;
	return true;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CarSetign(playerid,carided = 0){
	if(!carided)
	    carided = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
	new msg[267],
		panels,
		tires;
	GetVehicleDamageStatus(carided,panels,doors,lights,tires);
    GetVehicleParamsEx(carided,engine,lights,alarm,doors,bonnet,boot,objective);
    if(!LanglePlayer{playerid}){
		if(bonnet == 1) strcat(msg,"Капот\t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else strcat(msg,"Капот\t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(boot == 1) strcat(msg,"Багажник\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else strcat(msg,"Багажник\t\t[On/{0033CC}Off{FFFFFF}]\n");
	 	if(lights == 0 || lights == -1) strcat(msg,"Фары\t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		else strcat(msg,"Фары\t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		if(engine == 0) strcat(msg,"Двигатель\t\t[On/{0033CC}Off{FFFFFF}]\n");
		else strcat(msg,"Двигатель\t\t[{0033CC}On{FFFFFF}/Off]\n");
		if(doors == 1) strcat(msg,"Замок\t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else strcat(msg,"Замок\t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(tires == 0000) strcat(msg,"Спустить задние колеса\n");
		else strcat(msg,"Накачать задние колеса\n");
		strcat(msg,"Сменить номер\t[");
		strcat(msg,pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid]);
		strcat(msg,"{FFFFFF}]");
		new str[112];
		format(str, sizeof(str), ""MENU_PRFX_CARS""STRELKI"%s", VehicleNames[GetVehicleModel(carided)-400]);
		ShowPlayerDialog(playerid,114, DIALOG_STYLE_LIST, str,msg, "Выбор", "Назад");
	}else{
		if(bonnet == 1) strcat(msg,"Close cowl\r\n");
		else strcat(msg,"Open cowl\r\n");
		if(boot == 1) strcat(msg,"Close luggage\r\n");
		else strcat(msg,"Open luggage\r\n");
	 	if(lights == 0 || lights == -1) strcat(msg,"Include headlights\r\n");
		else strcat(msg,"switch off headlights\r\n");
		if(engine == 0) strcat(msg,"Start engine\r\n");
		else strcat(msg,"Damp engine\r\n");
		if(doors == 0) strcat(msg,"Close doors\r\n");
		else strcat(msg,"Open doors\r\n");
		if(tires == 0000) strcat(msg,"Lower back wheels\r\n");
		else strcat(msg,"Pump back wheels\r\n");
		strcat(msg,"Change number\t[");
		strcat(msg,pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid]);
		strcat(msg,"{FFFFFF}]");
		new str[112];
		format(str, sizeof(str), ""MENU_PRFX_CARS""STRELKI"%s", VehicleNames[GetVehicleModel(carided)-400]);
		ShowPlayerDialog(playerid,114, DIALOG_STYLE_LIST, str,msg, "Select", "Back");
	}
}
public LoadCars(playerid){
	new rows, fields, buffer[64];
	cache_get_data(rows, fields);
	carsEx[playerid] = rows;
	if(Player[playerid][pCarslots] < rows+1)
		Player[playerid][pCarslots] = rows+1;
	if(rows){
		for(new i; i < rows; i++)
		{
		    new f = i+1;
		    if(f > MAX_VEHICLES_FOR_PLAYER)
		        break;
			cache_get_field_content(i, "cModel",buffer);
			Player[playerid][pAuto][f] = strval(buffer);
			cache_get_field_content(i, "cPos_x",buffer);
			Player[playerid][pAPos_x][f] = floatstr(buffer);
			cache_get_field_content(i, "cPos_y", buffer);
			Player[playerid][pAPos_y][f] = floatstr(buffer);
			cache_get_field_content(i, "cPos_z", buffer);
			Player[playerid][pAPos_z][f] = floatstr(buffer);
			cache_get_field_content(i, "cPos_a", buffer);
			Player[playerid][pAPos_a][f] = floatstr(buffer);
			cache_get_field_content(i, "cVirtWorld", buffer);
			Player[playerid][cWorld][f] = strval(buffer);
			cache_get_field_content(i, "cVinil", buffer);
			Player[playerid][pVinil][f] = strval(buffer);
			cache_get_field_content(i, "cColorOne", buffer);
			Player[playerid][pColor][f] = strval(buffer);
			cache_get_field_content(i, "cColorTwo", buffer);
			Player[playerid][pColorTwo][f] = strval(buffer);
			cache_get_field_content(i, "cID", buffer);
			Player[playerid][pAutoUID][f] = strval(buffer);
			cache_get_field_content(i, "cGidravlika", buffer);
			Player[playerid][cGidravlika][f] = strval(buffer);
			cache_get_field_content(i, "cWheels", buffer);
			Player[playerid][cWheels][f] = strval(buffer);
			cache_get_field_content(i, "pNumber", pNumber[f][playerid]);
			if(!pNumber[f][playerid][0])
				format(pNumber[f][playerid],25,"{000000}ID%d",Player[playerid][pAutoUID][f]);
			if(12999 < Player[playerid][cWorld][f] < VIRT_GARAGE+MAX_PLAYERS){
				Player[playerid][pAPos_x][f] = 0.0;
				Player[playerid][pAPos_y][f] = 0.0;
				Player[playerid][pAPos_z][f] = 0.0;
				Player[playerid][pAPos_a][f] = 0.0;
				Player[playerid][cWorld][f] = 0;
			}
		}
		Player[playerid][pVcar] = GetCarSlotForUID(playerid,Player[playerid][pVcar]);
	}
	LoadCarsEx[playerid] = true;
	return true;
}
ShowBuyCarDialog(playerid){
	new str[128];
    bigdialog = "";
	for(new k = 1; k < MAX_VEHICLES_FOR_PLAYER; k++){
        if(Player[playerid][pCarslots] < k && Player[playerid][pCarslots] != MAX_VEHICLES_FOR_PLAYER) break;
		if(Player[playerid][pAuto][k]){
			format(str, sizeof(str), "%s",VehicleNames[Player[playerid][pAuto][k]-400]);
			strcat(bigdialog,str);
		}
		else{
		    if(!LanglePlayer{playerid})
				strcat(bigdialog,"{FFFFFF}Пусто ({00f5da}Купить{FFFFFF})");
			else
				strcat(bigdialog,"{FFFFFF}Empty ({00f5da}Buy{FFFFFF})");
		}
		strcat(bigdialog,"\n");
	}
	if(GetPlayerCars(playerid) >= Player[playerid][pCarslots] && Player[playerid][pCarslots] != MAX_VEHICLES_FOR_PLAYER) if(!LanglePlayer{playerid}) strcat(bigdialog,"\n"STRELKIEX"Докупить слот"); else strcat(bigdialog,"\n"STRELKIEX"Buy slot");
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid,Autos,DIALOG_STYLE_LIST,MENU_PRFX_CARS,bigdialog,"Выбрать","Назад");
	else
		ShowPlayerDialog(playerid,Autos,DIALOG_STYLE_LIST,MENU_PRFX_CARS_EN,bigdialog,"Select","Back");
	return true;
}
ShowListCars(playerid){
	minidialog = "";
	if(!LanglePlayer{playerid}){
		strcat(minidialog,""STRELKIEX"Автомобили для дрифтинга\n");
		if(Player[playerid][pLevel] < 2)
			strcat(minidialog,"{808080}Прочие легковые автомобили\t[Доступно на  2 уровне]\n");
		else
			strcat(minidialog,""STRELKIEX"Прочие легковые автомобили\n");
		if(Player[playerid][pLevel] < 3)
			strcat(minidialog,"{808080}Мотоциклы\t\t\t\t[Доступно на  3 уровне]\n");
		else
		    strcat(minidialog,""STRELKIEX"Мотоциклы\n");
	    if(Player[playerid][pLevel] < 4)
			strcat(minidialog,"{808080}Джипы\t\t\t\t\t[Доступно на  4 уровне]\n");
		else
			strcat(minidialog,""STRELKIEX"Джипы\n");
	    if(Player[playerid][pLevel] < 5)
			strcat(minidialog,"{808080}Разные\t\t\t\t[Доступно на  5 уровне]\n");
		else
			strcat(minidialog,""STRELKIEX"Разные\n");
		if(Player[playerid][pLevel] < 6)
			strcat(minidialog,"{808080}Полицейские\t\t\t\t[Доступно на  6 уровне]\n");
		else
			strcat(minidialog,""STRELKIEX"Полицейские\n");
		strcat(minidialog,"\n"STRELKIEX"VIP транспорт");
		ShowPlayerDialog(playerid, ALLCARMENU, DIALOG_STYLE_LIST, ""MENU_PRFX_CARS""STRELKI"Купить авто",minidialog, "Далее", "Назад");
	}else{
		strcat(minidialog,""STRELKIEX"Cars for drifting\n");
		if(Player[playerid][pLevel] < 2)
			strcat(minidialog,"{808080}Other passenger cars\t\t\t[Well on  2 level]\n");
		else
			strcat(minidialog,""STRELKIEX"Other passenger cars\n");
		if(Player[playerid][pLevel] < 3)
			strcat(minidialog,"{808080}Motorcycles\t\t\t\t[Well on  3 level]\n");
		else
		    strcat(minidialog,""STRELKIEX"Motorcycles\n");
	    if(Player[playerid][pLevel] < 4)
			strcat(minidialog,"{808080}Jeeps\t\t\t\t\t[Well on  4 level]\n");
		else
			strcat(minidialog,""STRELKIEX"Jeeps\n");
	    if(Player[playerid][pLevel] < 5)
			strcat(minidialog,"{808080}Other\t\t\t\t\t[Well on  5 level]\n");
		else
			strcat(minidialog,""STRELKIEX"Other\n");
		if(Player[playerid][pLevel] < 6)
			strcat(minidialog,"{808080}Police cars\t\t\t\t[Well on  6 level]\n");
		else
			strcat(minidialog,""STRELKIEX"Police cars\n");
		strcat(minidialog,"\n"STRELKIEX"VIP cars");
		ShowPlayerDialog(playerid, ALLCARMENU, DIALOG_STYLE_LIST, ""MENU_PRFX_CARS_EN""STRELKI"Buy auto",minidialog, "Select", "Back");
	}
	return true;
}
public LoadRecords(){
	new
		rows,
		fields,
		buffer[12];
	cache_get_data(rows, fields);
	if(rows){
		cache_get_field_content(0, "rRecordScore", buffer);		rRecordScore = strval(buffer);
		cache_get_field_content(0, "rRecordScoreUID", buffer);	rRecordScoreUID = strval(buffer);
		cache_get_field_content(0, "rRecordTime", buffer);		rRecordTime = strval(buffer);
		cache_get_field_content(0, "rRecordTimeUID", buffer);	rRecordTimeUID = strval(buffer);
		cache_get_field_content(0, "rRecordCombo", buffer);		rRecordCombo = floatstr(buffer);
		cache_get_field_content(0, "rRecordComboUID", buffer);	rRecordComboUID = strval(buffer);
		cache_get_field_content(0, "rDateReloadRecords", buffer);rDateReloadRecords = strval(buffer);
	}
	return true;
}
public LoadRecordsDD(){
	new
		rows,
		fields,
		buffer[12],
		id;
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i++){
		cache_get_field_content(i, "rID", buffer);			id = strval(buffer);
		cache_get_field_content(i, "rRecord", buffer);		RaceInfo[id-1][Record] = strval(buffer);
		cache_get_field_content(i, "rRecorderUID", buffer);	RaceInfo[id-1][RecordsmanUID] = strval(buffer);
		cache_get_field_content(i, "rRecorder", RaceInfo[id-1][Recordsman]);
	}
	for(new i; i < MAX_RACE; i++){
		RaceTextDraw[i][DT_LEADER_NAME] = TextDrawCreate(68.000000, 284.000000, "NULL");
		TextDrawAlignment(			RaceTextDraw[i][DT_LEADER_NAME], 2);
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_LEADER_NAME], 255);
		TextDrawFont(				RaceTextDraw[i][DT_LEADER_NAME], 1);
		TextDrawLetterSize(			RaceTextDraw[i][DT_LEADER_NAME], 0.250000, 1.200000);
		TextDrawColor(				RaceTextDraw[i][DT_LEADER_NAME], 0x00FF00FF);
		TextDrawSetOutline(			RaceTextDraw[i][DT_LEADER_NAME], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_LEADER_NAME], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_LEADER_NAME], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_LEADER_NAME], 0);
		RaceTextDraw[i][DT_LOOSER_NAME] = TextDrawCreate(68.000000, 294.000000, "NULL");
		TextDrawAlignment(			RaceTextDraw[i][DT_LOOSER_NAME], 2);
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_LOOSER_NAME], 255);
		TextDrawFont(				RaceTextDraw[i][DT_LOOSER_NAME], 1);
		TextDrawLetterSize(			RaceTextDraw[i][DT_LOOSER_NAME], 0.250000, 1.200000);
		TextDrawColor(				RaceTextDraw[i][DT_LOOSER_NAME], 0xFF0000FF);
		TextDrawSetOutline(			RaceTextDraw[i][DT_LOOSER_NAME], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_LOOSER_NAME], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_LOOSER_NAME], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_LOOSER_NAME], 0);
		RaceTextDraw[i][DT_LEADER_POINTS] = TextDrawCreate(120.000000, 285.000000, "0000");
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_LEADER_POINTS], 255);
		TextDrawFont(				RaceTextDraw[i][DT_LEADER_POINTS], 3);
		TextDrawLetterSize(			RaceTextDraw[i][DT_LEADER_POINTS], 0.389999, 1.000000);
		TextDrawColor(				RaceTextDraw[i][DT_LEADER_POINTS],0x00FF00FF);
		TextDrawSetOutline(			RaceTextDraw[i][DT_LEADER_POINTS], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_LEADER_POINTS], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_LEADER_POINTS], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_LEADER_POINTS], 0);
		RaceTextDraw[i][DT_LOOSER_POINTS] = TextDrawCreate(120.000000, 295.000000, "0000");
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_LOOSER_POINTS], 255);
		TextDrawFont(				RaceTextDraw[i][DT_LOOSER_POINTS], 3);
		TextDrawLetterSize(			RaceTextDraw[i][DT_LOOSER_POINTS], 0.389999, 1.000000);
		TextDrawColor(				RaceTextDraw[i][DT_LOOSER_POINTS], 0xFF0000FF);
		TextDrawSetOutline(			RaceTextDraw[i][DT_LOOSER_POINTS], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_LOOSER_POINTS], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_LOOSER_POINTS], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_LOOSER_POINTS], 0);
		RaceTextDraw[i][DT_RECORDER_NAME] = TextDrawCreate(67.000000, 323.000000, "NONE");
		TextDrawAlignment(			RaceTextDraw[i][DT_RECORDER_NAME], 2);
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_RECORDER_NAME], 255);
		TextDrawFont(				RaceTextDraw[i][DT_RECORDER_NAME], 1);
		TextDrawLetterSize(			RaceTextDraw[i][DT_RECORDER_NAME], 0.219999, 1.200000);
		TextDrawColor(				RaceTextDraw[i][DT_RECORDER_NAME], 16777215);
		TextDrawSetOutline(			RaceTextDraw[i][DT_RECORDER_NAME], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_RECORDER_NAME], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_RECORDER_NAME], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_RECORDER_NAME], 0);
		RaceTextDraw[i][DT_RECORDER_SCORE] = TextDrawCreate(120.000000, 324.000000, "0000");
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_RECORDER_SCORE], 255);
		TextDrawFont(				RaceTextDraw[i][DT_RECORDER_SCORE], 3);
		TextDrawLetterSize(			RaceTextDraw[i][DT_RECORDER_SCORE], 0.389999, 1.000000);
		TextDrawColor(				RaceTextDraw[i][DT_RECORDER_SCORE], 16777215);
		TextDrawSetOutline(			RaceTextDraw[i][DT_RECORDER_SCORE], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_RECORDER_SCORE], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_RECORDER_SCORE], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_RECORDER_SCORE], 0);
		RaceTextDraw[i][DT_TIME_TEXT] = TextDrawCreate(22.000000, 253.000000, "Time: 1:30");
		TextDrawBackgroundColor(	RaceTextDraw[i][DT_TIME_TEXT], 255);
		TextDrawFont(				RaceTextDraw[i][DT_TIME_TEXT], 1);
		TextDrawLetterSize(			RaceTextDraw[i][DT_TIME_TEXT], 0.419999, 1.000000);
		TextDrawColor(				RaceTextDraw[i][DT_TIME_TEXT], -1);
		TextDrawSetOutline(			RaceTextDraw[i][DT_TIME_TEXT], 0);
		TextDrawSetProportional(	RaceTextDraw[i][DT_TIME_TEXT], 1);
		TextDrawSetShadow(			RaceTextDraw[i][DT_TIME_TEXT], 1);
		TextDrawSetSelectable(		RaceTextDraw[i][DT_TIME_TEXT], 0);
	}
	return true;
}
public UpdateClanMembers(clanid){
	new
		rows,
		fields;
	cache_get_data(rows, fields);
	ClanInfo[clanid][cPlayers] = rows;
	new query[75];
	format(query, sizeof(query),"UPDATE  "TABLE_CLANS" SET `cPlayers` = '%d' WHERE `cID` = %d",
		ClanInfo[clanid][cPlayers],
		ClanInfo[clanid][cKey]
	);
	mysql_function_query(MYSQL, query, false, "", "");
	return true;
}
public LoadClansPlayer(playerid){
	new
		rows,
		fields,
		string[20];
	cache_get_data(rows, fields);
	for(new i; i < ((rows<MAX_CLANS_ON_PLAYER)?rows:2); i++){
		cache_get_field_content(i, "cClanID", string);
		sscanf(string, "d", Player[playerid][cClan][i]);
		cache_get_field_content(i, "cRang", string);
		sscanf(string, "d", Player[playerid][cRate][i]);
		cache_get_field_content(i, "cMoneys", string);
		sscanf(string, "d", Player[playerid][cMoneys][i]);
		cache_get_field_content(i, "cMDay", string);
		sscanf(string, "d", Player[playerid][cMDay][i]);
		if(getdate() != Player[playerid][cMDay][i]){
			Player[playerid][cMoneys][i] = 0;
			Player[playerid][cMDay][i] = getdate();
			new query[85];
			format(query, sizeof(query),"UPDATE  "TABLE_CLANS_P" SET `cMoneys` = '%d',`cMDay` = '%d' WHERE `cID` = %d",
				Player[playerid][cMoneys][i],
				Player[playerid][cMDay][i],
				Player[playerid][cClan][i]
			);
			mysql_function_query(MYSQL, query, false, "", "");
		}
	}
	UpdateNick(playerid);
	return true;
}
public LoadClans(){
	new
		rows,
		fields,
		string[20],
		qString[75];
	cache_get_data(rows, fields);
	for(new i; i < rows; i++)
	{
		cache_get_field_content(i, "cID", string);
		sscanf(string, "d", ClanInfo[i][cKey]);
		cache_get_field_content(i, "cTag", string);
		sscanf(string, "s[7]", ClanInfo[i][cTag]);
		cache_get_field_content(i, "cRate1", ClanInfo[i][cRate1]);
		cache_get_field_content(i, "cRate2", ClanInfo[i][cRate2]);
		cache_get_field_content(i, "cRate3", ClanInfo[i][cRate3]);
		cache_get_field_content(i, "cRate4", ClanInfo[i][cRate4]);
		cache_get_field_content(i, "cRate5", ClanInfo[i][cRate5]);
		cache_get_field_content(i, "cCreator", string);
		sscanf(string, "d", ClanInfo[i][cCreator]);
		cache_get_field_content(i, "cPrivate", string);
		sscanf(string, "d", ClanInfo[i][cPrivate]);
		format(qString, sizeof qString, "SELECT `cID` FROM  "TABLE_CLANS_P" WHERE `cClanID` = %d", ClanInfo[i][cKey]);
		mysql_function_query(MYSQL, qString, true, "UpdateClanMembers", "d",i); 	
		cache_get_field_content(i, "cCreator", string);
		sscanf(string, "d", ClanInfo[i][cCreator]);
		cache_get_field_content(i, "cCordX", string);
		sscanf(string, "f", ClanInfo[i][cCordBase][0]);
		cache_get_field_content(i, "cCordY", string);
		sscanf(string, "f", ClanInfo[i][cCordBase][1]);
		cache_get_field_content(i, "cCordZ", string);
		sscanf(string, "f", ClanInfo[i][cCordBase][2]);
		cache_get_field_content(i, "cColour", string);
		sscanf(string, "d", ClanInfo[i][cColour]);
		cache_get_field_content(i, "cTypeSkobok", string);
		sscanf(string, "d", ClanInfo[i][cTypeSkobok]);
		cache_get_field_content(i, "cRate", string);
		sscanf(string, "d", ClanInfo[i][cRate]);
		cache_get_field_content(i, "cMoney", string);
		sscanf(string, "d", ClanInfo[i][cMoney]);
		cache_get_field_content(i, "cMaxMoneys1", string);
		sscanf(string, "d", ClanInfo[i][cMaxMoneys][1]);
		cache_get_field_content(i, "cMaxMoneys2", string);
		sscanf(string, "d", ClanInfo[i][cMaxMoneys][2]);
		cache_get_field_content(i, "cMaxMoneys3", string);
		sscanf(string, "d", ClanInfo[i][cMaxMoneys][3]);
		cache_get_field_content(i, "cMaxMoneys4", string);
		sscanf(string, "d", ClanInfo[i][cMaxMoneys][4]);
		cache_get_field_content(i, "cInvite1", string);
		sscanf(string, "d", ClanInfo[i][cInvite][1]);
		cache_get_field_content(i, "cInvite2", string);
		sscanf(string, "d", ClanInfo[i][cInvite][2]);
		cache_get_field_content(i, "cInvite3", string);
		sscanf(string, "d", ClanInfo[i][cInvite][3]);
		cache_get_field_content(i, "cInvite4", string);
		sscanf(string, "d", ClanInfo[i][cInvite][4]);
		cache_get_field_content(i, "cKick2", string);
		sscanf(string, "d", ClanInfo[i][cKick][2]);
		cache_get_field_content(i, "cKick3", string);
		sscanf(string, "d", ClanInfo[i][cKick][3]);
		cache_get_field_content(i, "cKick4", string);
		sscanf(string, "d", ClanInfo[i][cKick][4]);
		cache_get_field_content(i, "cRangUP2", string);
		sscanf(string, "d", ClanInfo[i][cRangUP][2]);
		cache_get_field_content(i, "cRangUP3", string);
		sscanf(string, "d", ClanInfo[i][cRangUP][3]);
		cache_get_field_content(i, "cRangUP4", string);
		sscanf(string, "d", ClanInfo[i][cRangUP][4]);
		ClanInfo[i][cInvite][5] = 1;
		ClanInfo[i][cKick][5] = 1;
		ClanInfo[i][cKick][1] = 0;
		ClanInfo[i][cRangUP][1]= 0;
		ClanInfo[i][cRangUP][5] = 1;	
	}
	return true;
}
public LoadHouses(){
    houseson = true;
	new
		rows,
		fields,
		string[256],
		query[128],
		hide
	;
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i++)
	{
		cache_get_field_content(i, "hid", string);
		sscanf(string, "d", hide);
		if(hide > MAX_HOUSES || hide < 0) continue;
		#if defined OSNOVNOI_SERV
		if(hide != i+1){
			format(query, sizeof(query),"UPDATE  "HOUSE_TABLE" SET `hid` = '%d' WHERE `hid` = %d;",i+1,hide);
			mysql_function_query(MYSQL, query, false, "", "");
			hide = i+1;
		}
		#endif
		cache_get_field_content(i, "henterx", string);
		sscanf(string, "f", HouseInfo[hide][henterx]);
		cache_get_field_content(i, "hentery", string);
		sscanf(string, "f", HouseInfo[hide][hentery]);
		cache_get_field_content(i, "henterz", string);
		sscanf(string, "f", HouseInfo[hide][henterz]);
		cache_get_field_content(i, "henterza", string);
		sscanf(string, "f", HouseInfo[hide][henterza]);
		cache_get_field_content(i, "hexitx", string);
		sscanf(string, "f", HouseInfo[hide][hexitx]);
		cache_get_field_content(i, "hexity", string);
		sscanf(string, "f", HouseInfo[hide][hexity]);
		cache_get_field_content(i, "hexitz", string);
		sscanf(string, "f", HouseInfo[hide][hexitz]);
		cache_get_field_content(i, "hexitza", string);
		sscanf(string, "f", HouseInfo[hide][hexitza]);
		cache_get_field_content(i, "howner", HouseInfo[hide][howner]);
		cache_get_field_content(i, "howneruid", string);
		sscanf(string, "d", HouseInfo[hide][howneruid]);
		cache_get_field_content(i, "hprice", string);
		sscanf(string, "d", HouseInfo[hide][hprice]);
		cache_get_field_content(i, "hint", string);
		sscanf(string, "d", HouseInfo[hide][hint]);
		cache_get_field_content(i, "hlock", string);
		sscanf(string, "d", HouseInfo[hide][hlock]);
		cache_get_field_content(i, "hprice2", string);
		sscanf(string, "d", HouseInfo[hide][hprice2]);
		cache_get_field_content(i, "naprodaje", string);
		sscanf(string, "d", HouseInfo[hide][naprodaje]);
		if(!HouseInfo[hide][howneruid])
			format(string,sizeof(string),"{00BC00}Дом продается! \n{00BC00}Стоимость дома: {F6F6F6}$%d\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[hide][hprice] , hide);
		else if(!HouseInfo[hide][naprodaje])
			format(string,sizeof(string),"{00BC00}Владелец дома: {F6F6F6}%s\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[hide][howner] , hide);
		else
			format(string,sizeof(string),"{00BC00}Дом продается! \n{00BC00}Владелец дома: {F6F6F6}%s\n{00BC00}Стоимость дома: {F6F6F6}$%d\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[hide][howner] , HouseInfo[hide][hprice2] , hide);
		HouseInfo[hide][hpickup] = CreateDynamicPickup (((!HouseInfo[hide][howneruid] || HouseInfo[hide][naprodaje])?1273:1272), 1, HouseInfo[hide][henterx], HouseInfo[hide][hentery], HouseInfo[hide][henterz],0);
		HouseInfo[hide][hpickup2] = CreateDynamicPickup (1318, 1, HouseInfo[hide][hexitx], HouseInfo[hide][hexity], HouseInfo[hide][hexitz], hide+1000);
        pHID[HouseInfo[hide][hpickup2]] = hide;
        pHID[HouseInfo[hide][hpickup]] = hide;
		HouseInfo[hide][hlabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, HouseInfo[hide][henterx], HouseInfo[hide][hentery], HouseInfo[hide][henterz],25.00,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1,0,-1,-1,100.0);
	}
	format(query, sizeof(query),"ALTER TABLE "HOUSE_TABLE" AUTO_INCREMENT = %d",rows+1);
	mysql_function_query(MYSQL, query, false, "", "");
	TotalHouses = hide+1;
	return true;
}
public BuyingHouse(playerid, houseid){
	if(!houseson) return false;
	if(HouseInfo[houseid][howneruid] && !HouseInfo[houseid][naprodaje])
		return false;
	new string[64];
	sscanf(Player[playerid][PlayerName], "s[24]", HouseInfo[houseid][howner]);
	HouseInfo[houseid][howneruid] = Player[playerid][pSQLID];
	HouseInfo[houseid][naprodaje] = 0;
	printf("[#1337] Дом ID %d, купил %d",houseid,HouseInfo[houseid][howneruid]);
	if(!LanglePlayer{playerid}){
		format(string, sizeof(string), "Владелец дома: %s.", HouseInfo [houseid][howner]);
		ShowPlayerDialog(playerid, hdialogid, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", string, "Войти", "Отмена" );
	}else{
		format(string, sizeof(string), "House owner: %s.", HouseInfo [houseid][howner]);
		ShowPlayerDialog(playerid, hdialogid, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House_EN"", string, "Join", "Close" );
	}
	UpdateHouseInfo(houseid);
	return true;
}
public SaledHouse(playerid, houseid){
	if(!houseson) return false;
	format(HouseInfo[houseid][howner], MAX_PLAYER_NAME, "NULL");
	HouseInfo[houseid][howneruid] = 0;
	HouseInfo[houseid][hlock] = true;
	HouseInfo[houseid][naprodaje] = 0;
	if(playerid != -1)
	{
		DaiEmyDeneg(playerid,HouseInfo[houseid][hprice]);
		new msg[112];
		if(!LanglePlayer{playerid})
			format(msg,sizeof(msg),""SERVER_MSG"Ты продал свой дом (ID%d) за %d$",houseid,HouseInfo[houseid][hprice]);
		else
			format(msg,sizeof(msg),""SERVER_MSG"You sold the house (ID%d) for %d$",houseid,HouseInfo[houseid][hprice]);
		SendClientMessage(playerid,-1, msg);
	}
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f))continue;
 		if(!Player[f][logged])continue;
		if(GetPlayerVirtualWorld(f) == (houseid+1000))
		{
			SetPlayerInterior(f, 0);
			t_SetPlayerVirtualWorld(f, 0);
			SetPlayerFacingAngle(f, HouseInfo[houseid][henterza]);
			SetCameraBehindPlayer(f);
			t_SetPlayerPos(f,
			HouseInfo[houseid][henterx] + (1.5 * floatcos(HouseInfo[houseid][hexitza] + 90, degrees)),
			HouseInfo[houseid][hentery] + (1.5 * floatsin(HouseInfo[houseid][hexitza] + 90, degrees)),
			HouseInfo[houseid][henterz]
			);
		}
	}
	UpdateHouseInfo(houseid);
	return true;
}
COMMAND:createhouse(playerid){
	if(!houseson || Player[playerid][pJail] || Player[playerid][pAdminPlayer] < LEVEL_HOUSE) return 0;
	if(!LanglePlayer{playerid})
		ShowPlayerDialog(playerid, hdialogid+1, DIALOG_STYLE_INPUT, "Создание дома", "Введите цену дома\nОт 100 000 до 10 000 000", "Далее", "Отмена" );
	else
		ShowPlayerDialog(playerid, hdialogid+1, DIALOG_STYLE_INPUT, "Creating house", "Enter house price\nFrom 100 000 to 10 000 000", "Select", "Cancel" );
	return true;
}
COMMAND:house(playerid){
	if( Player[playerid][pJail]  || Player[playerid][pAdminPlayer] < LEVEL_HOUSE) return 0;
	if(!LanglePlayer{playerid}){
		if(!houseson)
			ShowPlayerDialog(playerid, hdialogid+9, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", "Включить дома?", "Да", "Отмена" );
		else
			ShowPlayerDialog(playerid, hdialogid+9, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", "Выключить дома?", "Да", "Отмена" );
	}else{
		if(!houseson)
			ShowPlayerDialog(playerid, hdialogid+9, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", "Include houses?", "Yes", "Cancel" );
		else
			ShowPlayerDialog(playerid, hdialogid+9, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", "Switch off houses?", "Yes", "Cancel" );
	}
	return true;
}
public CreateHouse(playerid){
	if(!houseson) return false;
	new uid = cache_insert_id();
	HouseInfo[uid][henterx] = GetPVarFloat(playerid,"HouseX");
	HouseInfo[uid][hentery] = GetPVarFloat(playerid,"HouseY");
	HouseInfo[uid][henterz] = GetPVarFloat(playerid,"HouseZ");
	HouseInfo[uid][hint] = GetPVarInt(playerid,"hint");
	HouseInfo[uid][hprice] = GetPVarInt(playerid,"HouseCena");
	HouseInfo[uid][naprodaje] = 0;
	HouseInfo[uid][hexitx] = InteriorInfoBuy[GetPVarInt(playerid,"CarIdMenu")][ix];
	HouseInfo[uid][hexity] = InteriorInfoBuy[GetPVarInt(playerid,"CarIdMenu")][iy];
	HouseInfo[uid][hexitz] = InteriorInfoBuy[GetPVarInt(playerid,"CarIdMenu")][iz];
	HouseInfo[uid][hexitza] = InteriorInfoBuy[GetPVarInt(playerid,"CarIdMenu")][iza];		
	format(HouseInfo[uid][howner], MAX_PLAYER_NAME, "NULL");
	HouseInfo[uid][howneruid] = 0;
	HouseInfo[uid][hpickup] = CreateDynamicPickup (((!HouseInfo[uid][howneruid] || HouseInfo[uid][naprodaje])?1273:1272), 1, HouseInfo[uid][henterx], HouseInfo[uid][hentery], HouseInfo[uid][henterz],0);
	pHID[HouseInfo[uid][hpickup]] = uid;
	HouseInfo[uid][hpickup2] = CreateDynamicPickup (1318, 1, HouseInfo[uid][hexitx], HouseInfo[uid][hexity], HouseInfo[uid][hexitz], uid+1000);
	pHID[HouseInfo[uid][hpickup2]] = uid;
	new string[256];
	format(string,sizeof(string),"{00BC00}Дом продается! \n{00BC00}Стоимость дома: {F6F6F6}$%d\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[uid][hprice] , uid);
	HouseInfo[uid][hlabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, HouseInfo[uid][henterx], HouseInfo[uid][hentery], HouseInfo[uid][henterz],25.00,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1,0,-1,-1,100.0);
	new msg[112];
	format(msg, sizeof(msg), "%s создал дом ID%d.",Player[playerid][PlayerName],uid);
	WriteRusLog("House.cfg", msg);
	TotalHouses = uid+1;
	return true;
}
public RemoveHouse(houid){
	if(!houseson) return false;
	format(HouseInfo[houid][howner], MAX_PLAYER_NAME, "NULL");
	printf("[#1337] Удален дом %d, владелец %d",houid,HouseInfo[houid][howneruid]);
	HouseInfo[houid][howneruid] = 0;
	DestroyDynamicPickup(HouseInfo[houid][hpickup]);
	DestroyDynamicPickup(HouseInfo[houid][hpickup2]);
	DestroyDynamic3DTextLabel(HouseInfo[houid][hlabel]);
	return true;
}
#define DIALOG_STG_2 230
ShowDialogSint(playerid){
    minidialog = "";
    if(!LanglePlayer{playerid}){
		strcat(minidialog, ""STRELKIEX"Настройки аккаунта\n"STRELKIEX"Доп. настройки\n");
		strcat(minidialog, ""STRELKIEX"{");
		strcat(minidialog, chatcolor[Player[playerid][pColorPlayer]]);
		strcat(minidialog, "}Сменить цвет ника\n"STRELKIEX"Донат\n"STRELKIEX"Интерфейс\n");
		if(Player[playerid][pTags])
			strcat(minidialog, "{FFFFFF}Теги\t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "{FFFFFF}Теги\t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(!Player[playerid][pPmStatus])
			strcat(minidialog, "Могут присылать ЛС\t[{0033CC}Все{FFFFFF}/Только друзья]");
		else
			strcat(minidialog, "Могут присылать ЛС\t[Все/{0033CC}Только друзья{FFFFFF}]");
		strcat(minidialog, "\nЦвет текста в чате \t");	
		if(Player[playerid][pColorText] == 0)
			strcat(minidialog, "[Белый]");
		else if(Player[playerid][pColorText] == 1)
			strcat(minidialog, "[{badcff}Синий{FFFFFF}]");
		else if(Player[playerid][pColorText] == 2)
			strcat(minidialog, "[{baffdd}Бирюзовый{FFFFFF}]");
		else
			strcat(minidialog, "[{ffedba}Желтый{FFFFFF}]");
		strcat(minidialog, "\nЯзык сервера \t\t[{0033CC}Rus{FFFFFF}/Eng]");
		ShowPlayerDialog(playerid, 229, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn"", minidialog, "Ок", "Назад");
	}else{
		strcat(minidialog, ""STRELKIEX"Account settings\n"STRELKIEX"Additional settings\n");
		strcat(minidialog, ""STRELKIEX"{");
		strcat(minidialog, chatcolor[Player[playerid][pColorPlayer]]);
		strcat(minidialog, "}Change colour nickname\n"STRELKIEX"Donate\n"STRELKIEX"Interface\n");
		if(Player[playerid][pTags])
			strcat(minidialog, "{FFFFFF}Tags\t\t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "{FFFFFF}Tags \t\t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(!Player[playerid][pPmStatus])
			strcat(minidialog, "Who can send PM \t\t[{0033CC}All{FFFFFF}/Only friends]");
		else
			strcat(minidialog, "Who can send PM \t\t[All/{0033CC}Only friends{FFFFFF}]");
		strcat(minidialog, "\nColor text in chat\t\t");	
		if(Player[playerid][pColorText] == 0)
			strcat(minidialog, "[White]");
		else if(Player[playerid][pColorText] == 1)
			strcat(minidialog, "[{badcff}Blue{FFFFFF}]");
		else if(Player[playerid][pColorText] == 2)
			strcat(minidialog, "[{baffdd}Turquoise{FFFFFF}]");
		else
			strcat(minidialog, "[{ffedba}Yellow{FFFFFF}]");
		strcat(minidialog, "\nServer language \t\t[Rus/{0033CC}Eng{FFFFFF}]");
		ShowPlayerDialog(playerid, 229, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN"", minidialog, "Ok", "Back");
	}
	return true;
}
ShowDialogSintEx(playerid){
    minidialog = "";
    if(!LanglePlayer{playerid}){
		strcat(minidialog, ""STRELKIEX"Погода\n"STRELKIEX"Время\n"STRELKIEX"Дрифт бонусы\n");
		if(GetPVarInt(playerid,"nick") == 0)
			strcat(minidialog, "{FFFFFF}Режим \"Мувик\" \t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "{FFFFFF}Режим \"Мувик\" \t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(Player[playerid][pRepair])
			strcat(minidialog, "Автопочинка \t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "Автопочинка \t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(!Player[playerid][pWeapons])
			strcat(minidialog, "Кнопка \"N\"\t\t\t[Classic/TP/{0033CC}Off{FFFFFF}]\n\n");
		else if(Player[playerid][pWeapons] == 1)
			strcat(minidialog, "Кнопка \"N\"\t\t\t[{0033CC}Classic{FFFFFF}/TP/Off]\n");
		else if(Player[playerid][pWeapons] == 2)
			strcat(minidialog, "Кнопка \"N\"\t\t\t[Classic/{0033CC}TP{FFFFFF}/Off]\n");
		if(Player[playerid][pKeyMenu])
			strcat(minidialog, "Кнопка вызова меню \t\t[{0033CC}Alt&2{FFFFFF}/Y]\n");
		else
			strcat(minidialog, "Кнопка вызова меню \t\t[Alt&2/{0033CC}Y{FFFFFF}]\n");
		if(Player[playerid][KeyTP])
			strcat(minidialog, "Комбинация Alt+Ctrl \t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "Комбинация Alt+Ctrl \t\t[On/{0033CC}Off{FFFFFF}]\n");	
		if(Player[playerid][KeyStop])
			strcat(minidialog, "ExtraStop \t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "ExtraStop \t\t\t[On/{0033CC}Off{FFFFFF}]\n");	
		strcat(minidialog, "");
		ShowPlayerDialog(playerid, DIALOG_STG_2, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKIEX"Доп.Возможности", minidialog, "Ок", "Назад");
	}else{
		strcat(minidialog, ""STRELKIEX"Weather\n"STRELKIEX"Time\n"STRELKIEX"Drift bonuses\n");
		if(GetPVarInt(playerid,"nick") == 0)
			strcat(minidialog, "Mode \"Moove\" \t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "Mode \"Moove\" \t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(Player[playerid][pRepair])
			strcat(minidialog, "Autorepair \t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "Autorepair \t\t\t[On/{0033CC}Off{FFFFFF}]\n");
		if(!Player[playerid][pWeapons])
			strcat(minidialog, "Key \"N\" \t[Classic/TP/{0033CC}Off{FFFFFF}]\n\n");
		else if(Player[playerid][pWeapons] == 1)
			strcat(minidialog, "Key \"N\"\t\t\t[{0033CC}Classic{FFFFFF}/TP/Off]\n");
		else if(Player[playerid][pWeapons] == 2)
			strcat(minidialog, "Key \"N\"\t\t\t[Classic/{0033CC}TP{FFFFFF}/Off]\n");
		if(Player[playerid][pKeyMenu])
			strcat(minidialog, "Key menu \t\t\t[{0033CC}Alt&2{FFFFFF}/Y]\n");
		else
			strcat(minidialog, "Key menu \t\t\t[Alt&2/{0033CC}Y{FFFFFF}]\n");
		if(Player[playerid][KeyTP])
			strcat(minidialog, "Combination Alt+Ctrl \t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "Combination Alt+Ctrl \t\t[On/{0033CC}Off{FFFFFF}]\n");	
		if(Player[playerid][KeyStop])
			strcat(minidialog, "ExtraStop \t\t\t[{0033CC}On{FFFFFF}/Off]\n");
		else
			strcat(minidialog, "ExtraStop \t\t\t[On/{0033CC}Off{FFFFFF}]\n");	
		ShowPlayerDialog(playerid, DIALOG_STG_2, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN"", minidialog, "Ok", "Back");
	}
	return true;
}
ShowDialogSintInterface(playerid){
	minidialog = "";
	if(!LanglePlayer{playerid}){
		if(Player[playerid][pSpeedom] == 1)
			strcat(minidialog,"Спидометр [{0033CC}Цифры{FFFFFF}/Шкала/Off]\n");
		else if(Player[playerid][pSpeedom] == 2)
			strcat(minidialog,"Спидометр [Цифры/{0033CC}Шкала{FFFFFF}/Off]\n");
		else
			strcat(minidialog,"Спидометр [Цифры/Шкала/{0033CC}Off{FFFFFF}]\n");
		strcat(minidialog,"Изменение цвета SCORE\n");
		if(Player[playerid][pColorSpeedom] == 0)
			strcat(minidialog,"Цвет спидометра [{0033CC}Классический{FFFFFF}/Грамурный/Белый]");
		else if(Player[playerid][pColorSpeedom] == 1)
			strcat(minidialog,"Цвет спидометра [Классический/{0033CC}Грамурный{FFFFFF}/Белый]");
		else
			strcat(minidialog,"Цвет спидометра [Классический/Грамурный/{0033CC}Белый{FFFFFF}]");
		ShowPlayerDialog(playerid, 232, DIALOG_STYLE_LIST,""MENU_PRFX_Stgn""STRELKI"Интерфейс", minidialog, "Ок", "Назад");
	}else{
		if(Player[playerid][pSpeedom] == 1)
			strcat(minidialog,"Speedometer [{0033CC}Numeral{FFFFFF}/Scale/Off]\n");
		else if(Player[playerid][pSpeedom] == 2)
			strcat(minidialog,"Speedometer [Numeral/{0033CC}Scale{FFFFFF}/Off]\n");
		else
			strcat(minidialog,"Speedometer [Numeral/Scale/{0033CC}Off{FFFFFF}]\n");
		strcat(minidialog,"Изменение цвета SCORE\n");
		if(Player[playerid][pColorSpeedom] == 0)
			strcat(minidialog,"Speedometer colour [{0033CC}Classic{FFFFFF}/Glamour/White]");
		else if(Player[playerid][pColorSpeedom] == 1)
			strcat(minidialog,"Speedometer colour [Classic/{0033CC}Glamour{FFFFFF}/White]");
		else
			strcat(minidialog,"Speedometer colour [Classic/Glamour/{0033CC}White{FFFFFF}]");
		ShowPlayerDialog(playerid, 232, DIALOG_STYLE_LIST,""MENU_PRFX_Stgn_EN""STRELKI"Interface", minidialog, "Ok", "Back");
	}
	return true;
}
ShowDialogTuning(playerid){
	minidialog = "";
	new carslot = GetPVarInt(playerid,"CarIdMenu"),
	    carid = GetCarIdForSlot(playerid,carslot);
	if(!Wheel(carid))
        strcat(minidialog,"{808080}");	
    if(!LanglePlayer{playerid}){
	    strcat(minidialog,"Диски			[10 000$]\n");
	    if(GetVehicleComponentInSlot(carid,9) == 1087 || !Gidravlic(carid))
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Гидравлика		[25 000$]\nЦвет			[5 000$]\n");
		if(!TwoColours(GetVehicleModel(carid)))
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Второй цвет		[5 000$]\n");
		if(!Vinil(carid))
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Винилы		[10 000$]\n");
		if(Player[playerid][pVinil][carslot] == -1 && !Player[playerid][cGidravlika][carslot] && Player[playerid][cWheels][carslot] == -1)
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Удалить весь тюнинг");
	   	new str[128];
		format(str, sizeof(str), ""MENU_PRFX_CARS""STRELKI"Тюнинг"STRELKI"%s", VehicleNames[GetVehicleModel(carid)-400]);
		ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, str, minidialog, "Выбрать", "Назад");
	}else{
	    strcat(minidialog,"Wheels			[10 000$]\n");
	    if(GetVehicleComponentInSlot(carid,9) == 1087 || !Gidravlic(carid))
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Hydraulics		[25 000$]\n");
		if(!TwoColours(GetVehicleModel(carid)))
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Two colour		[5 000$]\n");
		if(!Vinil(carid))
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Vinil		[10 000$]\n");
		if(Player[playerid][pVinil][carslot] == -1 && !Player[playerid][cGidravlika][carslot] && Player[playerid][cWheels][carslot] == -1)
	        strcat(minidialog,"{808080}");
	    strcat(minidialog,"Remov all tuning");
	   	new str[128];
		format(str, sizeof(str), ""MENU_PRFX_CARS_EN""STRELKI"Tuning"STRELKI"%s", VehicleNames[GetVehicleModel(carid)-400]);
		ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, str, minidialog, "Select", "Back");
	}
	return true;
}
public ShowDialogHouse(playerid){
	if(!houseson) return false;
	new h_ = GetPVarInt(playerid, "HouseID"),
	dialog[256];
	if(!LanglePlayer{playerid}){
		if(HouseInfo[h_][hlock] == false) strcat(dialog, "Закрыть дом\n");
		else strcat(dialog, "Открыть дом\n");
		if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[h_][hexitx], HouseInfo[h_][hexity], HouseInfo[h_][hexitz])) strcat(dialog, "Выйти из дома\n");
		else strcat(dialog, "Телепорт в дом\n");
		strcat(dialog, "Продать дом\n");
		if(HouseInfo[h_][naprodaje] == 0) strcat(dialog, ""STRELKIEX"Выставить на продажу\n");
		else strcat(dialog, "Снять с продажи\n");
		strcat(dialog, ""STRELKIEX"Сменить интерьер\nВыгнать всех гостей");
		ShowPlayerDialog(playerid, hdialogid+3, DIALOG_STYLE_LIST, ""MENU_PRFX_House""STRELKI"Опции дома", dialog, "Выбрать", "Отменить");
	}else{
		if(HouseInfo[h_][hlock] == false) strcat(dialog, "Close house\n");
		else strcat(dialog, "Open house\n");
		if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[h_][hexitx], HouseInfo[h_][hexity], HouseInfo[h_][hexitz])) strcat(dialog, "Exit from house\n");
		else strcat(dialog, "TP in house\n");
		strcat(dialog, "Sell house\n");
		if(HouseInfo[h_][naprodaje] == 0) strcat(dialog, ""STRELKIEX"Offer for sale\n");
		else strcat(dialog, "Remove from sale\n");
		strcat(dialog, ""STRELKIEX"Change interior\nExpel all guests");
		ShowPlayerDialog(playerid, hdialogid+3, DIALOG_STYLE_LIST, ""MENU_PRFX_House""STRELKI"House menu", dialog, "Select", "Close");
	}
	return true;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	new f = GetPVarInt(playerid,"CarIdMenu"),
		carid = pvehs[f][playerid];
	if(clickedid == ColorKeyBuy){
		if(GetPlayerCash(playerid)<5000){
			SelectTextDraw(playerid, 0xFFFFFFFF);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
			return true;
		}
		DaiEmyDeneg(playerid,-5000);
		PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
		if(UsedColorSlot[playerid] == 1)
			Player[playerid][pColor][f] = UsedColorID[playerid];
		else if(UsedColorSlot[playerid] == 2)
			Player[playerid][pColorTwo][f] = UsedColorID[playerid];
		TextDrawHideForPlayer(playerid, CarColorFon);
		TextDrawHideForPlayer(playerid, ColorKeyBuy);
		TextDrawHideForPlayer(playerid, ColorKeyCancel);
		for(new i; i < sizeof(VehicleColoursTableRGBA); i++)
			TextDrawHideForPlayer(playerid, CarColorTX[i]);
		CancelSelectTextDraw(playerid);
		DeletePVar(playerid,"PlayerReg");
		ShowDialogTuning(playerid);
		return true;
	}
	if(clickedid == ColorKeyCancel){
		ChangeVehicleColor(carid,Player[playerid][pColor][f],Player[playerid][pColorTwo][f]);
		CancelSelectTextDraw(playerid);
		DeletePVar(playerid,"PlayerReg");
		TextDrawHideForPlayer(playerid, CarColorFon);
		TextDrawHideForPlayer(playerid, ColorKeyBuy);
		TextDrawHideForPlayer(playerid, ColorKeyCancel);
		for(new i; i < sizeof(VehicleColoursTableRGBA); i++)
			TextDrawHideForPlayer(playerid, CarColorTX[i]);
		ShowDialogTuning(playerid);
		return true;
	}
	for(new i; i < sizeof(VehicleColoursTableRGBA); i++){
		if(clickedid == CarColorTX[i]){
			UsedColorID[playerid] = i;
			if(UsedColorSlot[playerid] == 1)
				ChangeVehicleColor(carid,i,Player[playerid][pColorTwo][f]);
			else if(UsedColorSlot[playerid] == 2)
				ChangeVehicleColor(carid,Player[playerid][pColor][f],i);
			return true;
		}
	}
    return 1;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid){
	if(GetPVarInt(playerid,"PlayerReg")){
		CancelSelectTextDraw(playerid);
		DeletePVar(playerid,"PlayerReg");
		for(new i; i < sizeof(Textdraw); i ++)
			TextDrawHideForPlayer(playerid, Textdraw[i]); 
		PlayerTextDrawDestroy(playerid, Elegy_NewPlayer[playerid]);
		PlayerTextDrawDestroy(playerid, Inf_NewPlayer[playerid]);
		PlayerTextDrawDestroy(playerid, Sul_NewPlayer[playerid]);
		if(!LanglePlayer{playerid}) SendClientMessage(playerid,-1,""SERVER_MSG"Ваш бонус:");
		else SendClientMessage(playerid,-1,""SERVER_MSG"Your bonus:");
		Player[playerid][pCashPlayer] = 0;
		Player[playerid][pDonatM] = 5;
		if(!LanglePlayer{playerid}){
			if(playertextid == Elegy_NewPlayer[playerid]){
				SendClientMessage(playerid,-1,""SERVER_MSG"Деньги: $50000");
				SendClientMessage(playerid,-1,""SERVER_MSG"Автомобиль: Elegy");
				DaiEmyDeneg(playerid,50000);
				Player[playerid][pAuto][1] = 562;
			}else if(playertextid == Inf_NewPlayer[playerid]){
				SendClientMessage(playerid,-1,""SERVER_MSG"Деньги: $50000");
				SendClientMessage(playerid,-1,""SERVER_MSG"Автомобиль: Banshee");
				DaiEmyDeneg(playerid,50000);
				Player[playerid][pAuto][1] = 429;
			}else{
				SendClientMessage(playerid,-1,""SERVER_MSG"Деньги: $50000");
				SendClientMessage(playerid,-1,""SERVER_MSG"Автомобиль: Sultan");
				DaiEmyDeneg(playerid,50000);
				Player[playerid][pAuto][1] = 560;
			}
		}else{
			if(playertextid == Elegy_NewPlayer[playerid]){
				SendClientMessage(playerid,-1,""SERVER_MSG"Money: $50000");
				SendClientMessage(playerid,-1,""SERVER_MSG"Car: Elegy");
				DaiEmyDeneg(playerid,50000);
				Player[playerid][pAuto][1] = 562;
			}else if(playertextid == Inf_NewPlayer[playerid]){
				SendClientMessage(playerid,-1,""SERVER_MSG"Money: $10000");
				SendClientMessage(playerid,-1,""SERVER_MSG"Car: Banshee");
				DaiEmyDeneg(playerid,50000);
				Player[playerid][pAuto][1] = 429;
			}else{
				SendClientMessage(playerid,-1,""SERVER_MSG"Money: $50000");
				SendClientMessage(playerid,-1,""SERVER_MSG"Car: Sultan");
				DaiEmyDeneg(playerid,50000);
				Player[playerid][pAuto][1] = 560;
			}
		}
		new query[112];
		format(query, sizeof(query),"DELETE FROM  "CARS_TABLE" WHERE `cOwner` = %d;",Player[playerid][pSQLID]);
		mysql_function_query(MYSQL, query, false, "", "");
		minidialog = "";
		format(minidialog, sizeof(minidialog),"INSERT INTO "CARS_TABLE" ( `cModel`, `cPos_x`, `cPos_y`, `cPos_z`, `cPos_a`, `cVirtWorld`, `cVinil`, `cColorOne`, `cColorTwo`, `cWheels`, `cOwner`) VALUES ( %d,%f,%f,%f,%f,0,-1,1,0,-1,%d)",
			Player[playerid][pAuto][1],
			1711.35,
			1460.81,
			10.40,
			163.75,
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, minidialog, true, "UpdateCarUID", "id",playerid,1);
		if(!LanglePlayer{playerid}) SendClientMessage(playerid,-1,""SERVER_MSG"Дополнительный бонус: 5 DM");
		else SendClientMessage(playerid,-1,""SERVER_MSG"Additional bonus: 5 DM");
		SetSpawnInfo(playerid,0,Player[playerid][pSkin],Player[playerid][pPos][0],Player[playerid][pPos][1],Player[playerid][pPos][2]+1,Player[playerid][pPos][3]);
		Streamer_UpdateEx(playerid, Player[playerid][pPos][0],Player[playerid][pPos][1],Player[playerid][pPos][2], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		TogglePlayerSpectating(playerid, false);
		LoadAkk(playerid);
		pvehs[1][playerid] = t_CreateVehicle(Player[playerid][pAuto][1],1711.35,1460.81,10.40,163.75,Player[playerid][pColor][1],Player[playerid][pColorTwo][1],-1);
		SetVehicleZAngle(pvehs[1][playerid],163.75);
		t_PutPlayerInVehicle(playerid, pvehs[1][playerid]);
		if(!LanglePlayer{playerid})
			return ShowPlayerDialog(playerid, START_INFO_DIALOG+3, DIALOG_STYLE_MSGBOX, "{00f5da}>>{ffffff} Спидометр", "Вам нужен спидометр?", "Да", "Нет"),true;
		else
			return ShowPlayerDialog(playerid, START_INFO_DIALOG+3, DIALOG_STYLE_MSGBOX, "{00f5da}>>{ffffff} Speedometer", "To switch off a speedometer?", "Yes", "No"),true;
	}
	return true;
}
public OnPlayerConnectEx(playerid){
	if(!IsPlayerConnected(playerid))
		return true;
	new qString[128];
	format(qString, sizeof qString, "SELECT * FROM "TABLE_ACC" WHERE `Nickname`='%s'", Player[playerid][PlayerName]);
	mysql_function_query(MYSQL, qString, true, "searchPlayer", "i", playerid);
	SetPVarInt(playerid, "AntiBreik", 500);
	TOTALAIR[playerid] = 0;
	players[playerid] = 0;
	MaxRazgon[playerid] = 0;
	MaxSpeeds[playerid] = 0;
	Player[playerid][pWeapons] = 0;
	Player[playerid][pColorText] = 0;
	Player[playerid][pColorSpeedom] = 0;
	WaitSum[playerid] = false;
	Kicked[playerid] = false;
	OpenBox[playerid] = false;
	ShowStirLock[playerid] = 0;
	SumID[playerid] = INVALID_PLAYER_ID;
	Jumping[playerid] = GetTickCount();
    Player[playerid][pPos][0] = 0;
	Player[playerid][pPos][1] = 0;
	Player[playerid][pPos][2] = 0;
	RaceID[playerid] = -1;
	SaceSlot[playerid] = -1;
	SetPVarInt(playerid,"LoadTime",gettime());
	SetPVarInt(playerid,"Timeon",1);
    BadWords[playerid] = false;
	rRaceStatusEx[playerid] = STATUS_NO_RACE;
	if(!ReConnect[playerid]){
		TogglePlayerSpectating(playerid, 1);
		gocamera[playerid] = false;
		if(!restarting)
			ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{FFFFFF}Загрузка сервера","{FFFFFF}Подождите, пока загрузится сервер.\n\nWait while it will be loaded server.","OK","");
		else
			ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{FFFFFF}Загрузка сервера","{FFFFFF}Происходит запуск сервера.Ожидайте.\n\nThere is a server start. Wait.","OK","");
		new camEx = random(sizeof(Cams));
		SetPlayerCameraPos(playerid,Cams[camEx][StartX],Cams[camEx][StartY],Cams[camEx][StartZ]);
		SetPlayerCameraLookAt(playerid,Cams[camEx][FinishX],Cams[camEx][FinishY],Cams[camEx][FinishZ]);
	}
 	ScoreShow[playerid] = CreatePlayerTextDraw(playerid,530.0, 98.5,"");
	PlayerTextDrawBackgroundColor(playerid,ScoreShow[playerid],0x000000ff);
	PlayerTextDrawLetterSize(playerid,ScoreShow[playerid],0.24,0.72);
	PlayerTextDrawFont(playerid,ScoreShow[playerid],1);
	PlayerTextDrawColor(playerid,ScoreShow[playerid],COLOR_YELLOW);
	PlayerTextDrawSetOutline(playerid,ScoreShow[playerid],1);
	PlayerTextDrawSetProportional(playerid,ScoreShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,ScoreShow[playerid],1);
	PlayerTextDrawAlignment(playerid,ScoreShow[playerid],2);
	DriftPointsShow[playerid] = CreatePlayerTextDraw(playerid,565.0, 107.0,"");
	PlayerTextDrawBackgroundColor(playerid,DriftPointsShow[playerid],0x000000ff);
	PlayerTextDrawLetterSize(playerid,DriftPointsShow[playerid],0.25,1.1);
	PlayerTextDrawFont(playerid,DriftPointsShow[playerid],3);
	PlayerTextDrawColor(playerid,DriftPointsShow[playerid],COLOR_YELLOW);
	PlayerTextDrawSetOutline(playerid,DriftPointsShow[playerid],1);
	PlayerTextDrawSetProportional(playerid,DriftPointsShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,DriftPointsShow[playerid],1);
	PlayerTextDrawAlignment(playerid,DriftPointsShow[playerid],1);
 	LevelShow[playerid] = CreatePlayerTextDraw(playerid,565.0, 97.0,"");
	PlayerTextDrawBackgroundColor(playerid,LevelShow[playerid],0x000000ff);
	PlayerTextDrawLetterSize(playerid,LevelShow[playerid],0.24,1.1);
	PlayerTextDrawFont(playerid,LevelShow[playerid],1);
	PlayerTextDrawColor(playerid,LevelShow[playerid],COLOR_YELLOW);
	PlayerTextDrawSetOutline(playerid,LevelShow[playerid],1);
	PlayerTextDrawSetProportional(playerid,LevelShow[playerid],1);
	PlayerTextDrawSetShadow(playerid,LevelShow[playerid],1);
	PlayerTextDrawAlignment(playerid,LevelShow[playerid],1);
	Speed2[playerid] = CreatePlayerTextDraw(playerid,540,420,"");
	PlayerTextDrawBackgroundColor(playerid,Speed2[playerid],0x000000ff);
	PlayerTextDrawLetterSize(playerid,Speed2[playerid],0.5,1.75);
	PlayerTextDrawFont(playerid,Speed2[playerid],3);
	PlayerTextDrawColor(playerid,Speed2[playerid],COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid,Speed2[playerid],2);
	PlayerTextDrawSetProportional(playerid,Speed2[playerid],1);
	PlayerTextDrawSetShadow(playerid,Speed2[playerid],1);
	Loggeds[playerid] = CreatePlayerTextDraw(playerid,230,120,"");
	PlayerTextDrawBackgroundColor(playerid,Loggeds[playerid],0x000000ff);
	PlayerTextDrawLetterSize(playerid,Loggeds[playerid],0.5,1.75);
	PlayerTextDrawFont(playerid,Loggeds[playerid],3);
	PlayerTextDrawColor(playerid,Loggeds[playerid],COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid,Loggeds[playerid],2);
	PlayerTextDrawSetProportional(playerid,Loggeds[playerid],1);
	PlayerTextDrawSetShadow(playerid,Loggeds[playerid],1);
	return true;
}
public OnPlayerConnect(playerid){
	if(!IsPlayerConnected(playerid))
		return true;
	LoadCarsEx[playerid] = false;
	GetPlayerName(playerid,Player[playerid][PlayerName],MAX_PLAYER_NAME);
	if(!strcmp("NULL",Player[playerid][PlayerName],false)){
		SendClientMessage(playerid, -1, "-Шутка. \"ReConnect\" запрещен на нашем сервере.");
		SendClientMessage(playerid, -1, ""SERVER_MSG"Ты забанен на нашем сервере!");
		SetTimerEx("AntiKick",500,false,"d",playerid);
		return true;
	}
	new dlinna = strlen(Player[playerid][PlayerName]);
	if(dlinna > 20)	{
		SendClientMessage(playerid, -1, ""SERVER_MSG"Слишком длинный ник!");
		SendClientMessage(playerid, -1, ""SERVER_MSG"Long nickname!");
		SetTimerEx("AntiKick",500,false,"d",playerid);
		return true;
	}
 	if(CheckStr(Player[playerid][PlayerName]))
	 	BanEx(playerid,"Рекламер");
	for(new i; i < sizeof(Logo); i ++)
		TextDrawShowForPlayer(playerid, Logo[i]);
	for(new i;i<50;i++)
		SendClientMessage(playerid,-1, "");
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		pvehs[f][playerid] = INVALID_VEHICLE_ID;
		Player[playerid][pAuto][f] = 0;
	}
	new uptime = GetTickCount();
	if(!ReConnect[playerid] && uptime-TimeStart < 5000){
		TogglePlayerSpectating(playerid, 1);
		ReConnect[playerid] = true;
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{FFFFFF}Загрузка сервера","{FFFFFF}Подождите, пока загрузится сервер.\nЭто может занять 5-10 секунд.\n\nWait load server. 5-10 seconds.","OK","");
		SetTimerEx("OnPlayerConnectEx",(5500+random(4500))-(uptime-TimeStart),false,"d",playerid);
		return true;
	}
	OnPlayerConnectEx(playerid);
	return true;
}
public changenickPlayerEx(playerid){
	new rows, fields;
	cache_get_data(rows, fields);
	if(rows){
		if(!LanglePlayer{playerid})
			ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Данный ник занят!", "Далее", "" );
		else
			ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Is nickname occupied!", "Next", "" );
		DeletePVar(playerid,"NewNick");
	}
	else
	{
		new qString2[112],newnick[MAX_PLAYER_NAME];
		GetPVarString(playerid,"NewNick",newnick,MAX_PLAYER_NAME);
		DeletePVar(playerid,"NewNick");
		if(SetPlayerName(playerid,newnick))
		{
			new msg[112];
			format(msg,sizeof(msg),""SERVER_MSG"\"%s\" сменил ник на \"%s\".",Player[playerid][PlayerName],newnick);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"\"%s\" replaced a nickname on \"%s\".",Player[playerid][PlayerName],newnick);
			t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
			format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `Nickname`='%s' WHERE `id`='%i'",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			if(GetOwnedHouses(playerid)){
				for (new i; i < TotalHouses; i++){
					if(HouseInfo[i][howneruid] != Player[playerid][pSQLID]) continue;
					format(HouseInfo[i][howner], MAX_PLAYER_NAME, "%s",newnick);
					UpdateHouseInfo(i);
			}   }  
			format(qString2, sizeof(qString2),"UPDATE  "HOUSE_TABLE" SET `howner` = '%s' WHERE `howneruid` = %d;",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof(qString2),"UPDATE "TABLE_CLANS" SET `cCreatorName` = '%s' WHERE `cCreator` = %d;",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `Nickname`='%s' WHERE `id`='%d'",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "FRENDS_TABLE" SET `fName`= '%s' WHERE `fUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "FRENDS_TABLE" SET `pName`= '%s' WHERE `pUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "BLACKLIST_TABLE" SET `bName`= '%s' WHERE `bUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE `ClansPlayer` SET `cNickName`= '%s' WHERE `cUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE `BankLog` SET `lNick`= '%s' WHERE `lNick` = '%s'",newnick,Player[playerid][PlayerName]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(msg,sizeof(msg),"\"%s\" сменил ник на \"%s\".",Player[playerid][PlayerName],newnick);
			WriteRusLog("NewNick.cfg", msg);
			format(Player[playerid][PlayerName], MAX_PLAYER_NAME, "%s", newnick);
		}
		else return SendClientMessage(playerid,-1,""SERVER_MSG"Данный ник недоступен в SAMP!");
	}
	return true;
}
public changenickPlayer(playerid){
	new rows, fields;
	cache_get_data(rows, fields);
	if(rows){
		DeletePVar(playerid,"NewNick");
		if(!LanglePlayer{playerid})
			return SendClientMessage(playerid,-1,""SERVER_MSG"Данный ник уже занят!");
		else
			return SendClientMessage(playerid,-1,""SERVER_MSG"This nickname is already occupied!");
	}
	else
	{
		new qString2[112],newnick[MAX_PLAYER_NAME];
		GetPVarString(playerid,"NewNick",newnick,MAX_PLAYER_NAME);
		DeletePVar(playerid,"NewNick");
		if(SetPlayerName(playerid,newnick))
		{
		    Player[playerid][pTimeNewNick] = gettime()+3600;
			new msg[112];
			format(msg,sizeof(msg),""SERVER_MSG"\"%s\" сменил ник на \"%s\".",Player[playerid][PlayerName],newnick);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"\"%s\" replaced a nickname on \"%s\".",Player[playerid][PlayerName],newnick);
			t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
			format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `Nickname`='%s' WHERE `id`='%i'",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			if(GetOwnedHouses(playerid)){
				for (new i = 0; i < TotalHouses; i++){
					if(HouseInfo[i][howneruid] != Player[playerid][pSQLID]) continue;
					new string[112];
					format(HouseInfo[i][howner], MAX_PLAYER_NAME, "%s",newnick);
					UpdateHouseInfo(i);
					format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `howner` = '%s' WHERE `hid` = %d;", newnick, i);
					mysql_function_query(MYSQL, string, false, "", "");
			}   } 
			format(qString2, sizeof(qString2),"UPDATE "TABLE_CLANS" SET `cCreatorName` = '%s' WHERE `cCreator` = %d;",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof(qString2),"UPDATE  "HOUSE_TABLE" SET `howner` = '%s' WHERE `howneruid` = %d;",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `Nickname`='%s' WHERE `id`='%d'",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "FRENDS_TABLE" SET `fName`= '%s' WHERE `fUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "FRENDS_TABLE" SET `pName`= '%s' WHERE `pUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE "BLACKLIST_TABLE" SET `bName`= '%s' WHERE `bUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE `ClansPlayer` SET `cNickName`= '%s' WHERE `cUID` = %d",newnick,Player[playerid][pSQLID]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(qString2, sizeof qString2, "UPDATE `BankLog` SET `lNick`= '%s' WHERE `lNick` = '%s'",newnick,Player[playerid][PlayerName]);
			mysql_function_query(MYSQL, qString2, false, "", "");
			format(msg,sizeof(msg),"\"%s\" сменил ник на \"%s\".",Player[playerid][PlayerName],newnick);
			WriteRusLog("NewNick.cfg", msg);
			format(Player[playerid][PlayerName], MAX_PLAYER_NAME, "%s", newnick);
		}
		else return SendClientMessage(playerid,-1,""SERVER_MSG"Данный ник недоступен в SAMP!");
	}
	return true;
}
public GetPromoEx(playerid) {
	new rows, fields, id,
		string[12];
	cache_get_data(rows, fields);
	if(rows)
	{
 		cache_get_field_content(0, "ID", string);
	    id = strval(string);
 		cache_get_field_content(0, "Bonuse", string);
	    Player[playerid][pDonatM] += strval(string);
		printf("%s выдало промо",Player[playerid][PlayerName]);
	    new str[112];
	    if(!LanglePlayer{playerid})
	    	format(str,sizeof(str),""SERVER_MSG"Ты успешно активировал промо код. Выдано %d DM. Теперь у тебя %d DM.",strval(string),Player[playerid][pDonatM]);
		else
	    	format(str,sizeof(str),""SERVER_MSG"You successfully activated a promo code. It is given out %d DM. Now at you %d DM.",strval(string),Player[playerid][pDonatM]);
	    SendClientMessage(playerid, COLOR_YELLOW,str);
   		format(str, sizeof(str), "DELETE FROM `promocods` WHERE `ID`='%d'", id);
		mysql_function_query(MYSQL, str, false, "", "");
	}
	else {
		SetPVarInt(playerid,"TimeNextPromo",gettime()+600);
		if(!LanglePlayer{playerid})
			ShowPlayerDialog(playerid, DONATDIALOG-DONATDIALOG, DIALOG_STYLE_MSGBOX,"{FFFFFF}Ввод промо кода","{FFFFFF}Промо код введен не верно. Следующая попытка ввода будет доступна через 10 минут.","Закрыть", "" );
		else
			ShowPlayerDialog(playerid, DONATDIALOG-DONATDIALOG, DIALOG_STYLE_MSGBOX,"{FFFFFF}Promo code input","{FFFFFF}The promo code is entered not truly. The following attempt of input will be available in 10 minutes.","Close", "" );
}	}
public searchPlayer(playerid) {
	if(!IsPlayerConnected(playerid))
		return true;
	new rows, fields,
		timenologged[64],
		buffer[20];
	cache_get_data(rows, fields);
	if(rows)
	{
		cache_get_field_content(0, "id", buffer);
		Player[playerid][pSQLID] = strval(buffer);
		loadmashines(playerid,Player[playerid][pSQLID]);
		SearchBan(playerid);
		cache_get_field_content(0, "Password", Player[playerid][PlayerPassword]);
		cache_get_field_content(0, "Money", buffer); 		Player[playerid][pCashPlayer] = strval(buffer);
		cache_get_field_content(0, "level", buffer);		Player[playerid][pLevel] = strval(buffer);
		cache_get_field_content(0, "Score", buffer);		Player[playerid][pScore] = strval(buffer);
		cache_get_field_content(0, "AdminEx", buffer);		Player[playerid][pAdminPlayer] = strval(buffer);
		cache_get_field_content(0, "Pos_x", buffer);		Player[playerid][pPos][0] = floatstr(buffer);
		cache_get_field_content(0, "Pos_y", buffer);		Player[playerid][pPos][1] = floatstr(buffer);
		cache_get_field_content(0, "Pos_z", buffer);		Player[playerid][pPos][2] = floatstr(buffer);
		cache_get_field_content(0, "Pos_f", buffer);		Player[playerid][pPos][3] = floatstr(buffer);
		cache_get_field_content(0, "JTime", buffer);		Player[playerid][pJTime] = strval(buffer);
		cache_get_field_content(0, "Speedom",buffer);		Player[playerid][pSpeedom] = strval(buffer);
		cache_get_field_content(0, "Virt", buffer);			Player[playerid][pVirt] = strval(buffer);
		cache_get_field_content(0, "Skin", buffer);			Player[playerid][pSkin] = strval(buffer);
		cache_get_field_content(0, "Banned", buffer);		if(!strval(buffer)) Player[playerid][pBanned] 		= 	false;	else Player[playerid][pBanned] 		= 	true;
		cache_get_field_content(0, "keymenu", buffer);		if(!strval(buffer)) Player[playerid][pKeyMenu] 		= 	false;	else Player[playerid][pKeyMenu] 	= 	true;
		cache_get_field_content(0, "KeyTP", buffer);		if(!strval(buffer)) Player[playerid][KeyTP] 		= 	false;	else Player[playerid][KeyTP] 		= 	true;
		cache_get_field_content(0, "KeyStop", buffer);		if(!strval(buffer)) Player[playerid][KeyStop] 		= 	false;	else Player[playerid][KeyStop] 		= 	true;
		cache_get_field_content(0, "Muted", buffer);		if(!strval(buffer)) Player[playerid][pMuted] 		= 	false;	else Player[playerid][pMuted] 		= 	true;
		cache_get_field_content(0, "Jail", buffer);			if(!strval(buffer)) Player[playerid][pJail] 		= 	false;	else Player[playerid][pJail] 		= 	true;
		cache_get_field_content(0, "NoCrash",buffer);		if(!strval(buffer)) Player[playerid][pNoCrash] 		=	false;	else Player[playerid][pNoCrash] 	= 	true;
		cache_get_field_content(0, "DoubleDrift",buffer);	if(!strval(buffer)) Player[playerid][pDoubleDrift] 	=	false;	else Player[playerid][pDoubleDrift]	=	true;
		cache_get_field_content(0, "Avtorepair", buffer);	if(!strval(buffer)) Player[playerid][pRepair] 		=	false;	else Player[playerid][pRepair]		=	true;
		cache_get_field_content(0, "pTags", buffer);		if(!strval(buffer)) Player[playerid][pTags] 		=	false;	else Player[playerid][pTags]		=	true;
		cache_get_field_content(0, "VIPg", buffer);			if(!strval(buffer)) Player[playerid][pVIP] 			=	false;	else Player[playerid][pVIP]			=	true;
		cache_get_field_content(0, "LangPlayer", buffer); 	if(!strval(buffer)) LanglePlayer{playerid} 			= 	false; 	else LanglePlayer{playerid} 		= 	true;
		cache_get_field_content(0, "carslots", buffer);		Player[playerid][pCarslots] = strval(buffer);
		if(!Player[playerid][pCarslots]) Player[playerid][pCarslots] = 3;
		cache_get_field_content(0, "CheaterEx", buffer);	Player[playerid][pCheater] = strval(buffer);
		cache_get_field_content(0, "Vmashine", buffer);		Player[playerid][pVcar] = strval(buffer);
		cache_get_field_content(0, "DonatM", buffer);		Player[playerid][pDonatM] = strval(buffer);
		cache_get_field_content(0, "MuteTime", buffer);		Player[playerid][pMuteTime] = strval(buffer);
		cache_get_field_content(0, "TimeOnServer", buffer);	Player[playerid][pTimeOnline] = strval(buffer);
		cache_get_field_content(0, "TimeOnServerH", buffer);Player[playerid][pTimeOnlineH] = strval(buffer);
		cache_get_field_content(0, "TimeOnServerD", buffer);Player[playerid][pTimeOnlineD] = strval(buffer);
		cache_get_field_content(0, "JailAdm", buffer);		Player[playerid][pJailAdm] = strval(buffer);
		cache_get_field_content(0, "MutedAdm", buffer);		Player[playerid][pMutedAdm] = strval(buffer);
		cache_get_field_content(0, "ColorSpeedom", buffer);	Player[playerid][pColorSpeedom] = strval(buffer);
		cache_get_field_content(0, "last_game", buffer);	Player[playerid][pBonus_d] = strval(buffer);
		cache_get_field_content(0, "combodays", buffer);	Player[playerid][pComboDays] = strval(buffer);
		cache_get_field_content(0, "PmStatus", buffer);		Player[playerid][pPmStatus] = strval(buffer);
		cache_get_field_content(0, "Int", buffer);			Player[playerid][pInt] = strval(buffer);
		cache_get_field_content(0, "DoubleDriftT",buffer);	Player[playerid][pDoubleDriftT] = strval(buffer);
		cache_get_field_content(0, "NoCrashTime",buffer);	Player[playerid][pNoCrashTime] = strval(buffer);
		cache_get_field_content(0, "Color",buffer);			Player[playerid][pColorPlayer] = strval(buffer);
		cache_get_field_content(0, "ColorScore",buffer);    Player[playerid][pColorScore] = strval(buffer);
		cache_get_field_content(0, "ExtraWeapons",buffer);	Player[playerid][pWeapons] = strval(buffer);
		cache_get_field_content(0, "pColorText",buffer);		Player[playerid][pColorText] = strval(buffer);
		cache_get_field_content(0, "StopAdmin",buffer);		Player[playerid][pStopAdmin] = strval(buffer);
		cache_get_field_content(0, "StopVip",buffer);		Player[playerid][pStopVip] = strval(buffer);
		cache_get_field_content(0, "OldDuel",buffer);		Player[playerid][pOldDuel] = strval(buffer);
		new lastgame;
		cache_get_field_content(0, "WinRace",buffer);		Player[playerid][pWinRace] = strval(buffer);
		cache_get_field_content(0, "LooseRace",buffer);		Player[playerid][pLooseRace] = strval(buffer);
		if((gettime()-lastgame) > 60){
			//Дом героина начало, 20.02.2014
			RemoveBuildingForPlayer(playerid, 8636, 2517.3906, 1543.2266, 10.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2492.7656, 1485.1016, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2439.1641, 1528.4141, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2439.0156, 1577.0000, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2538.7188, 1601.6563, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2595.7578, 1552.7656, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2521.9453, 1485.1016, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2454.1484, 1601.5547, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 8970, 2569.4531, 1561.6406, 16.1094, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2503.3125, 1580.6406, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2494.3984, 1560.8047, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2495.9922, 1545.8438, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2517.6328, 1537.2969, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2548.2891, 1535.8516, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 710, 2570.3516, 1519.3438, 25.2266, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2438.9141, 1510.0156, 9.7813, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2438.9688, 1552.7734, 9.7813, 0.25);
			RemoveBuildingForPlayer(playerid, 641, 2437.8984, 1563.3750, 7.5859, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2439.1563, 1542.1250, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2438.9297, 1597.4141, 9.7813, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2439.1484, 1584.5313, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2502.6797, 1519.1250, 11.3516, 0.25);
			RemoveBuildingForPlayer(playerid, 9034, 2491.8828, 1528.3516, 11.3828, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2508.3203, 1539.6406, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2474.3438, 1574.8516, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2471.7188, 1547.2969, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2494.8516, 1552.3828, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2498.5234, 1571.5078, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 641, 2445.2266, 1602.9297, 7.5781, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2465.3438, 1602.7031, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 8536, 2485.7813, 1598.8281, 17.0781, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2475.7422, 1602.9375, 9.7813, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2485.2266, 1595.4063, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2483.6484, 1600.2266, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 3461, 2488.2109, 1595.7344, 11.3516, 0.25);
			RemoveBuildingForPlayer(playerid, 3461, 2488.2109, 1601.6719, 11.3672, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2521.7500, 1602.9453, 9.7344, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2530.5156, 1602.6953, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2511.4922, 1591.4375, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2537.4141, 1537.5234, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 641, 2546.3281, 1602.9375, 7.5781, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2546.5391, 1511.5391, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2553.5391, 1602.9219, 9.7422, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2576.0234, 1508.3203, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2560.4219, 1532.0781, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 8535, 2569.4531, 1561.6406, 16.1094, 0.25);
			RemoveBuildingForPlayer(playerid, 8597, 2565.6484, 1561.6250, 13.0156, 0.25);
			RemoveBuildingForPlayer(playerid, 621, 2571.2031, 1601.5469, 9.5313, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2563.2500, 1602.6719, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 9035, 2571.6172, 1561.6484, 11.3516, 0.25);
			RemoveBuildingForPlayer(playerid, 641, 2596.8750, 1517.5391, 7.5859, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2598.1328, 1542.1250, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 641, 2596.8672, 1563.3750, 7.5859, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2597.0000, 1589.9609, 9.7813, 0.25);
			RemoveBuildingForPlayer(playerid, 641, 2586.4141, 1602.9297, 7.5781, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2598.1328, 1583.0938, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2596.7969, 1599.4141, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2439.4141, 1493.6406, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2455.9141, 1485.7031, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 620, 2467.8281, 1485.0469, 9.7813, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2480.3203, 1485.2969, 9.7422, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2508.2500, 1485.2188, 9.6016, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2535.7969, 1485.2266, 9.7422, 0.25);
			RemoveBuildingForPlayer(playerid, 621, 2546.7656, 1484.3672, 9.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2554.8516, 1492.0469, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2556.9375, 1485.2969, 9.7422, 0.25);
			RemoveBuildingForPlayer(playerid, 8537, 2580.4297, 1486.5469, 17.0781, 0.25);
			RemoveBuildingForPlayer(playerid, 3461, 2578.0313, 1485.1094, 11.3281, 0.25);
			RemoveBuildingForPlayer(playerid, 3461, 2578.0313, 1488.8359, 11.3281, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2582.3047, 1489.2578, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 647, 2583.2813, 1485.6563, 11.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 621, 2595.6172, 1506.8281, 9.4297, 0.25);
			RemoveBuildingForPlayer(playerid, 621, 2595.7031, 1485.1719, 9.5938, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2588.6016, 1485.2266, 9.7422, 0.25);
			RemoveBuildingForPlayer(playerid, 634, 2598.1328, 1495.6406, 9.6016, 0.25);
			//Дом героина конец, 20.02.2014
			RemoveBuildingForPlayer(playerid, 16395, -763.6328, 2307.4766, 136.8828, 0.25);
			RemoveBuildingForPlayer(playerid, 16403, -795.9297, 2395.0781, 153.6094, 0.25);
			RemoveBuildingForPlayer(playerid, 16411, -806.0078, 2387.6719, 153.5156, 0.25);
			RemoveBuildingForPlayer(playerid, 3275, -812.0547, 2406.4531, 155.9688, 0.25);
			RemoveBuildingForPlayer(playerid, 3275, -775.9922, 2408.3594, 156.8281, 0.25);
			RemoveBuildingForPlayer(playerid, 3350, -773.0391, 2419.6484, 155.9688, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -774.2266, 2421.2656, 157.0313, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -775.1953, 2424.9609, 157.0313, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -774.2031, 2425.3672, 159.2969, 0.25);
			RemoveBuildingForPlayer(playerid, 16404, -772.1641, 2424.2031, 157.9219, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -772.2734, 2422.0234, 159.5781, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -772.2578, 2425.3828, 159.3750, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -770.2422, 2421.2656, 157.0313, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -769.1563, 2424.7656, 157.0313, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -770.3359, 2422.0234, 159.5313, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -808.5469, 2428.9375, 159.2109, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -812.3281, 2428.1406, 159.3750, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -810.0859, 2426.1797, 156.8672, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -813.0859, 2428.2891, 156.8672, 0.25);
			RemoveBuildingForPlayer(playerid, 16405, -809.6953, 2429.2188, 157.7656, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -771.5547, 2425.9609, 157.0313, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -773.7500, 2426.0938, 157.0391, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -807.4063, 2430.1328, 156.8828, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -807.9609, 2430.7891, 159.1406, 0.25);
			RemoveBuildingForPlayer(playerid, 3302, -811.7344, 2429.9922, 159.4219, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -808.0391, 2431.8672, 156.8672, 0.25);
			RemoveBuildingForPlayer(playerid, 3260, -811.8516, 2432.0781, 156.8672, 0.25);
			//Деревня герыч кончилась
			RemoveBuildingForPlayer(playerid, 778,-2828.01562,102.5,8.72656,10.0);
			RemoveBuildingForPlayer(playerid, 1226, 1323.5156, -2052.6250, 60.5938, 0.25);
			RemoveBuildingForPlayer(playerid, 1226, 1312.8594, -1962.0078, 32.1875, 0.25);
			RemoveBuildingForPlayer(playerid, 1226, 1246.6172, -1926.1250, 34.1250, 0.25);
			RemoveBuildingForPlayer(playerid, 1226, 1306.5234, -1915.3906, 26.9375, 0.25);
			RemoveBuildingForPlayer(playerid, 1226, 1434.2266, -2015.5938, 54.5234, 0.25);
			RemoveBuildingForPlayer(playerid, 1226, 1394.1328, -1974.4375, 41.2500, 0.25);
			RemoveBuildingForPlayer(playerid, 1226, 1379.3438, -1930.4531, 21.3906, 0.25);
			RemoveBuildingForPlayer(playerid, 13861, 570.3047, -1097.7656, 72.6953, 0.25);
			RemoveBuildingForPlayer(playerid, 13878, 370.0156, -1236.7813, 61.7891, 0.25);
			RemoveBuildingForPlayer(playerid, 13748, 370.0156, -1236.7813, 61.7891, 0.25);
			RemoveBuildingForPlayer(playerid, 11372, -2076.4375, -107.9297, 36.9688, 0.25);
			RemoveBuildingForPlayer(playerid, 1278, -1246.6953, -289.4609, 25.3359, 0.25);
			RemoveBuildingForPlayer(playerid, 1278, -1405.3125, -132.1250, 25.3359, 0.25);
			RemoveBuildingForPlayer(playerid, 1278, -1297.9141, 480.6641, 20.3750, 0.25);
			RemoveBuildingForPlayer(playerid, 11014, -2076.4375, -107.9297, 36.9688, 0.25);
			RemoveBuildingForPlayer(playerid, 1278, -1244.9219, 5.1250, 25.3359, 0.25);
			RemoveBuildingForPlayer(playerid, 1278, -1283.2266, 53.6484, 25.3359, 0.25);
			RemoveBuildingForPlayer(playerid, 1290, -1223.2500, 64.7109, 19.3906, 0.25);
			RemoveBuildingForPlayer(playerid, 985, 2497.4063, 2777.0703, 11.5313, 0.25);
			RemoveBuildingForPlayer(playerid, 986, 2497.4063, 2769.1094, 11.5313, 0.25);
			//Деревня
			RemoveBuildingForPlayerEx(playerid, 7.110996723175,11447,-1309.60156,2492.47656,86.00781);
			RemoveBuildingForPlayerEx(playerid, 12.740976333618,11440,-1321.21094,2503.34375,85.46094);
			RemoveBuildingForPlayerEx(playerid, 6.6559662818909,11446,-1334.38281,2524.60156,86.16406);
			RemoveBuildingForPlayerEx(playerid, 6.6641035079956,11441,-1310.77344,2514.00781,86.16406);
			RemoveBuildingForPlayerEx(playerid, 7.111807346344,11444,-1325.67187,2527.70313,86.125);
			RemoveBuildingForPlayerEx(playerid, 10.151631355286,11442,-1314.83594,2526.46875,86.39844);
			RemoveBuildingForPlayerEx(playerid, 8.6534833908081,11458,-1316.85156,2542.67188,86.82813);
			RemoveBuildingForPlayerEx(playerid, 8.6534833908081,11443,-1301.71875,2527.49219,86.61719);
			RemoveBuildingForPlayerEx(playerid, 8.6534833908081,11445,-1289.36719,2513.60938,86.61719);
			RemoveBuildingForPlayerEx(playerid, 7.1115865707397,11459,-1292.79687,2529,86.53125);
			RemoveBuildingForPlayerEx(playerid, 12.7409324646,11457,-1303.77344,2550.23438,86.22656);
			RemoveBuildingForPlayerEx(playerid, 175.42169189453,13862,359.25,-1125.82812,80.85156);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-333.69531,-1434.83594,15.40625);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-328.96875,-1434.83594,15.17969);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-323.38281,-1434.83594,14.9375);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-315.84375,-1434.83594,14.75781);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-307.73437,-1434.83594,14.17188);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-372.17969,-1434.60937,25.51563);
			RemoveBuildingForPlayerEx(playerid, 3.3348772525787,1454,-366.20312,-1434.60937,25.4375);
			RemoveBuildingForPlayerEx(playerid, 14.748411178589,3425,-370.375,-1446.96875,35.95313);
			RemoveBuildingForPlayerEx(playerid, 16.577842712402,17000,-406.91406,-1448.96875,24.64063);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-380.78763,-1460.08362,25.31718);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-370.2334,-1455.16528,25.58934);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-362.79648,-1448.52625,25.51184);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-361.245,-1438.50916,24.6893);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-358.65591,-1423.87585,24.89588);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-356.84128,-1413.08765,25.32446);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-392.94058,-1410.89905,25.46024);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-405.65399,-1412.21558,24.87863);
			RemoveBuildingForPlayerEx(playerid, 8.2899265289307,3276,-417.06696,-1412.38562,23.27686);	
		}
		new bigdialog2[112],
			pGpciOld[65],
			pGpci[65];
		address[playerid] = GetAddres(playerid);
		cache_get_field_content(0, "LastAddres", buffer);
		cache_get_field_content(0, "gpci",pGpciOld);
		gpci(playerid,pGpci,64);
		if(address[playerid] == strval(buffer) && !strcmp(pGpciOld, pGpci, false )){
			SetTimerEx("ShowAutoLogin", 500, false, "i", playerid);			
			return true;
		}
		if(!LanglePlayer{playerid})
			format(timenologged,sizeof(timenologged),FixText("Осталось %d секунд."),60-GetPVarInt(playerid,"Loggedtime"));
		else
			format(timenologged,sizeof(timenologged),FixText("Were %d seconds."),60-GetPVarInt(playerid,"Loggedtime"));
		PlayerTextDrawSetString(playerid,Loggeds[playerid],timenologged);
		PlayerTextDrawShow(playerid,Loggeds[playerid]);
		if(!LanglePlayer{playerid}){
			format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Здравствуйте {%s}%s{FFFFFF}, введите пароль от вашего аккаунта:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
			ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Авторизация", bigdialog2, "Войти", ""); //если он есть, то авторизуем его
		}else{
			format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Hello {%s}%s{FFFFFF}, enter the password from your account:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
			ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Authorization", bigdialog2, "Join", ""); //если он есть, то авторизуем его
		}
	}
	else {
		SearchBan(playerid);
		/*
		for(new i; i < strlen(Player[playerid][PlayerName])-1; i++){
			switch(Player[playerid][PlayerName][i]){
				case '0'..'9','a'..'z','A'..'Z','.': continue;
				default:{
					SendClientMessage(playerid, COLOR_YELLOW,""SERVER_MSG"Извините, но данный ник не доступен на нашем сервере!");
					SendClientMessage(playerid, COLOR_YELLOW,""SERVER_MSG"Уберите из ника все теги и т.п., оставив только буквы, цифры или точки (по краям).");
					t_Kick(playerid);
					return true;
				}
			}
		}*/
		ShowPlayerDialog(playerid, START_INFO_DIALOG-2, DIALOG_STYLE_MSGBOX, "[Выбор языка | Language choice]","Выберите Ваш язык\n\t\t\tSelect your language", "Русский", "English" );
	}
	return true;
}
public  ShowAutoLogin(playerid){
	new bigdialog2[112];
	if(!LanglePlayer{playerid}){
		format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Здравствуйте {%s}%s {FFFFFF}, спасибо что вернулись!",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
		ShowPlayerDialog(playerid,DIALOG_STG_AKK+3,DIALOG_STYLE_MSGBOX,"{FFFFFF}Автоматическая авторизация",bigdialog2,"Спавн","");
	}else{
		format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Hello {%s}%s {FFFFFF}, thank you that came!",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
		ShowPlayerDialog(playerid,DIALOG_STG_AKK+3,DIALOG_STYLE_MSGBOX,"{FFFFFF}Automatic authorization",bigdialog2,"Spawn","");
	}
	return true;
}
ChowColorPanel(playerid){
    bigdialog = "";
	new ColorID[33];
    if(!LanglePlayer{playerid}){
		strcat(bigdialog,"{FFFFFF}Сейчас у тебя >{");
		strcat(bigdialog,chatcolor[Player[playerid][pColorPlayer]]);
		format(ColorID,sizeof(ColorID),"}такой [ID%d]{FFFFFF}< цвет\n",Player[playerid][pColorPlayer]);
		strcat(bigdialog,ColorID);
	}else{
		strcat(bigdialog,"{FFFFFF}Now you have >{");
		strcat(bigdialog,chatcolor[Player[playerid][pColorPlayer]]);
		format(ColorID,sizeof(ColorID),"}such [ID%d]{FFFFFF}< color\n",Player[playerid][pColorPlayer]);
		strcat(bigdialog,ColorID);
	}
	if(!LanglePlayer{playerid}){
		strcat(bigdialog,"{FFFFFF}Введи ID нужного цвета.\nДоступен диапазон от 1 до 510.\nВведите 0 для того что-бы система сама выдала тебе цвет");
		ShowPlayerDialog(playerid, 444, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Смена цвета ника",bigdialog, "Ок", "Назад" );
	}else{
		strcat(bigdialog,"{FFFFFF}Enter an ID necessary color.\nThe range from 1 to 510.\nIs available Enter 0 for this purpose that the system itself gave out you color.");
		ShowPlayerDialog(playerid, 444, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Change color nickname",bigdialog, "Ok", "Back" );
	}
	return true;
}
public OnPlayerDisconnect(playerid, reason){
	ReConnect[playerid] = false;
	if(Player[playerid][logged])
	{
		if(AfkPlayer[playerid]) { Delete3DTextLabel(AFK_3DT[playerid]); AfkPlayer[playerid] = false; }
		new qString2[70];
		format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `Online`='0' WHERE `id`='%i'",
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, qString2, false, "", "");
		SaveAccount(playerid);
		for(new f; f < MAX_FRENDS; f++){
			Player[playerid][pFrinend][f] = 0;
			Player[playerid][pBlackList][f] = 0;
			Player[playerid][pZayavki][f] = 0;
		}
		if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED){
			DaiEmyDeneg(GetDDSopernikID(playerid),PrizDD[playerid]/2);
			StopDuel(RaceID[playerid]);		
		}
		new msgconnect[100],msgconnectEn[100];
		format(msgconnect,sizeof msgconnect,""SERVER_MSG"{%s}%s {FFFFFF}вышел с сервера.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
		format(msgconnectEn,sizeof msgconnectEn,""SERVER_MSG"{%s}%s {FFFFFF}leave from server.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
		for(new f = 0, all = MAX_PLAYERS; f < all; f++){
			if(!IsPlayerConnected(f) || f == playerid)continue;
			if(IsFrende(f,playerid))
				if(!LanglePlayer{f}) SendClientMessage(f, -1, msgconnect); else SendClientMessage(f, -1, msgconnectEn);
	}	}
	for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++){
		if(pvehs[f][playerid] != INVALID_VEHICLE_ID)
		{
			DestroyVehicle(pvehs[f][playerid]);
			pvehs[f][playerid] = INVALID_VEHICLE_ID;
		}
	}
	if(countid[playerid] != INVALID_COUNT_ID){
		if(countid[playerid] == playerid)
			StopCount(playerid);
		else
			countid[playerid] = INVALID_COUNT_ID;
	}
	if(Player[playerid][pDriftPointsNow][0])
		DriftExit(playerid);
	IDVEH[playerid]=0;
	UseEnter{playerid} = false;
	AfkTime[playerid] = 0;
	StopSpectate(playerid);
	for(new i = 0, all = MAX_PLAYERS; i < all; i++) {
		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		if(GetSpectate[i] == playerid)
			StopSpectate(i);
	}
	SetTimerEx("removpk",1000,false,"d",playerid);
	return true;
}
public OnPlayerRequestClass(playerid, classid) {
	if(!Player[playerid][logged]){
		if(!gocamera[playerid]){
			new camEx = random(sizeof(Cams));
      		SetPlayerCameraPos(playerid,Cams[camEx][StartX],Cams[camEx][StartY],Cams[camEx][StartZ]);
			SetPlayerCameraLookAt(playerid,Cams[camEx][FinishX],Cams[camEx][FinishY],Cams[camEx][FinishZ]);
			InterpolateCameraPos(playerid,Cams[camEx][StartX],Cams[camEx][StartY],Cams[camEx][StartZ],Cams[camEx][FinishX],Cams[camEx][FinishY],Cams[camEx][FinishZ],50000, CAMERA_MOVE);
			gocamera[playerid] = true;
			gettime(hour, minute);
			SetPlayerTime(playerid,hour,minute);
		}
		return 0;
	}
	else{
		SetSpawnInfo(playerid,0,Player[playerid][pSkin],Player[playerid][pPos][0],Player[playerid][pPos][1],Player[playerid][pPos][2]+1,Player[playerid][pPos][3]);
		SpawnPlayer(playerid);
	}
	return 0;
}
public OnPlayerSpawn(playerid){
	if(!Player[playerid][logged]){
		AddBan(playerid,INVALID_PLAYER_ID,"No Login Spawn",600);
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#9]");
		else
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#9]");
		return t_Kick(playerid);
	}
	SetPVarInt(playerid, "AntiBreik", 4+(GetPlayerPing(playerid)/35));
	if(GetPVarInt(playerid,"Death")){
     	new spawn,Float:dis,Float:dise;
		for(new f ; f < SPAWNS; f++){
		    dis = GetPlayerDistanceFromPoint(playerid, Spawnse[f][xS], Spawnse[f][yS], Spawnse[f][xS]);
		    if(dis < dise || !f){
				spawn = f;
				dise = dis;
		}	}
		t_SetPlayerPos(playerid,Spawnse[spawn][xS],Spawnse[spawn][yS],Spawnse[spawn][zS]);
		SetPVarInt(playerid,"Death",0);
	}	
	SetPVarInt(playerid,"K_Times",0);
	SetPVarInt(playerid,"nick",1);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerArmour(playerid, 100.0);
	if(GetPlayerVirtualWorld(playerid) == 100+playerid)
		t_SetPlayerVirtualWorld(playerid, 0);
	else if(GetPlayerVirtualWorld(playerid) == 1024)
		t_SetPlayerVirtualWorld(playerid, 0);
	else if(GetPlayerInterior(playerid) && GetPlayerVirtualWorld(playerid) < 100 && !(12999 < GetPlayerVirtualWorld(playerid) <VIRT_GARAGE+MAX_PLAYERS))
		SetPlayerInterior(playerid,0);
	ac_GivePlayerWeapon(playerid,46,1);
	ac_GivePlayerWeapon(playerid,1,1);
	ac_GivePlayerWeapon(playerid,43,1000);
	if(Player[playerid][pJail]){
		SetPlayerInterior(playerid,6);
		t_SetPlayerVirtualWorld(playerid,789);
		t_SetPlayerPos(playerid,264.20001220703,77.800003051758,1001);
		SetPlayerCameraLookAt(playerid, 264.89999389648,77.199996948242,1001);
		SetPlayerCameraPos(playerid,262.5,79.599998474121,1003.4000244141);
		return true;
	}
	if(Player[playerid][pVcar] < 1)
		SetPlayerFacingAngle(playerid,Player[playerid][pPos][3]);
	return true;
}
UpperToLower(test_text[]){
	for (new i = 0; i < strlen(test_text); i++){
		if (test_text[i] > 64 && test_text[i] < 91 ) test_text[i] += 32;
		else if (test_text[i] > 191 && test_text[i] < 224 ) test_text[i] += 32;
		else if (test_text[i] == 168) test_text[i] = 184;
}   }
GetMiniBook(test_text[]){
	new books;
	for (new i = 0; i < strlen(test_text); i++){
		if (test_text[i] > 64 && test_text[i] < 91 ) books++;
		else if (test_text[i] > 191 && test_text[i] < 224 ) books++;
		else if (test_text[i] == 168) books++;
	}
	return books;
}
public OnGameModeInit(){
	for(new i; i < sizeof(ColorsScore); i ++){
		StirLock[i] = TextDrawCreate(565.000000, 117.000000, "STEERLOCK");
		TextDrawBackgroundColor(StirLock[i],0x000000ff);
		TextDrawLetterSize(StirLock[i],0.24,1.1);
		TextDrawFont(StirLock[i],1);
		TextDrawColor(StirLock[i],ColorsScore[i]);
		TextDrawSetOutline(StirLock[i],1);
		TextDrawSetProportional(StirLock[i],1);
		TextDrawSetShadow(StirLock[i],1);
		TextDrawAlignment(StirLock[i],1);
	}
	new created,
		ryad,
		Float:cX = 25.0,
		Float:cY = 352.0;
	CarColorFon = TextDrawCreate(24.000000, cY-1.0, "_");
	TextDrawBackgroundColor(CarColorFon, 255);
	TextDrawFont(CarColorFon, 1);
	TextDrawLetterSize(CarColorFon, 0.500000, 5.334999);
	TextDrawColor(CarColorFon, -1);
	TextDrawSetOutline(CarColorFon, 0);
	TextDrawSetProportional(CarColorFon, 1);
	TextDrawSetShadow(CarColorFon, 1);
	TextDrawUseBox(CarColorFon, 1);
	TextDrawBoxColor(CarColorFon, 153);
	TextDrawTextSize(CarColorFon, 604.000000, 3.000000);
	TextDrawSetSelectable(CarColorFon, 0);
	ColorKeyBuy = TextDrawCreate(509.000000, cY+40.0, "   Buy");
	TextDrawBackgroundColor(ColorKeyBuy, 255);
	TextDrawFont(ColorKeyBuy, 1);
	TextDrawLetterSize(ColorKeyBuy, 0.300000, 0.650000);
	TextDrawColor(ColorKeyBuy, -1);
	TextDrawSetOutline(ColorKeyBuy, 1);
	TextDrawSetProportional(ColorKeyBuy, 1);
	TextDrawUseBox(ColorKeyBuy, 1);
	TextDrawBoxColor(ColorKeyBuy, 255);
	TextDrawTextSize(ColorKeyBuy, 548.000000, 8.0);
	TextDrawSetSelectable(ColorKeyBuy, 1);
	ColorKeyCancel = TextDrawCreate(553.000000, cY+40.0, "  Cancel");
	TextDrawBackgroundColor(ColorKeyCancel, 255);
	TextDrawFont(ColorKeyCancel, 1);
	TextDrawLetterSize(ColorKeyCancel, 0.340000, 0.650000);
	TextDrawColor(ColorKeyCancel, -1);
	TextDrawSetOutline(ColorKeyCancel, 0);
	TextDrawSetProportional(ColorKeyCancel, 1);
	TextDrawSetShadow(ColorKeyCancel, 1);
	TextDrawUseBox(ColorKeyCancel, 1);
	TextDrawBoxColor(ColorKeyCancel, 255);
	TextDrawTextSize(ColorKeyCancel, 603.000000, 8.0);
	TextDrawSetSelectable(ColorKeyCancel, 1);
	for(new i; i < sizeof(VehicleColoursTableRGBA); i++){
		if(created > 52){
			created = 0;
			ryad++;
		}
		CarColorTX[i] = TextDrawCreate(cX+(created*11.0), cY+(10*ryad), ".");
		TextDrawFont(CarColorTX[i], 1);
		TextDrawLetterSize(CarColorTX[i], 0.500000, 0.65);
		TextDrawBackgroundColor(CarColorTX[i], VehicleColoursTableRGBA[i]);
		TextDrawColor(CarColorTX[i], VehicleColoursTableRGBA[i]);
		TextDrawBoxColor(CarColorTX[i], VehicleColoursTableRGBA[i]);
		TextDrawSetOutline(CarColorTX[i], 0);
		TextDrawSetProportional(CarColorTX[i], 1);
		TextDrawSetShadow(CarColorTX[i], 1);
		TextDrawUseBox(CarColorTX[i], 1);
		TextDrawTextSize(CarColorTX[i], (cX+6)+(created*11.0), 8.0);
		TextDrawSetSelectable(CarColorTX[i], 1);
		created++;
	}
	
	Textdraw[0] = TextDrawCreate(128.000000, 153.000000, "_");
	TextDrawBackgroundColor(Textdraw[0], 255);
	TextDrawFont(Textdraw[0], 1);
	TextDrawLetterSize(Textdraw[0], 0.500000, 15.699997);
	TextDrawColor(Textdraw[0], -1);
	TextDrawSetOutline(Textdraw[0], 0);
	TextDrawSetProportional(Textdraw[0], 1);
	TextDrawSetShadow(Textdraw[0], 1);
	TextDrawUseBox(Textdraw[0], 1);
	TextDrawBoxColor(Textdraw[0], 170);
	TextDrawTextSize(Textdraw[0], 478.000000, 77.000000);
	TextDrawSetSelectable(Textdraw[0], 0);
	Textdraw[1] = TextDrawCreate(145.000000, 146.000000, "Select bonus");
	TextDrawBackgroundColor(Textdraw[1], 255);
	TextDrawFont(Textdraw[1], 1);
	TextDrawLetterSize(Textdraw[1], 0.500000, 2.900000);
	TextDrawColor(Textdraw[1], -1);
	TextDrawSetOutline(Textdraw[1], 0);
	TextDrawSetProportional(Textdraw[1], 1);
	TextDrawSetShadow(Textdraw[1], 1);
	TextDrawSetSelectable(Textdraw[1], 0);
	Textdraw[2] = TextDrawCreate(130.000000, 160.000000, "-");
	TextDrawBackgroundColor(Textdraw[2], 255);
	TextDrawFont(Textdraw[2], 1);
	TextDrawLetterSize(Textdraw[2], 11.010004, 1.799998);
	TextDrawColor(Textdraw[2], -1);
	TextDrawSetOutline(Textdraw[2], 0);
	TextDrawSetProportional(Textdraw[2], 1);
	TextDrawSetShadow(Textdraw[2], 1);
	TextDrawSetSelectable(Textdraw[2], 0);
	Textdraw[3] = TextDrawCreate(210.000000, 160.000000, "-");
	TextDrawBackgroundColor(Textdraw[3], 255);
	TextDrawFont(Textdraw[3], 1);
	TextDrawLetterSize(Textdraw[3], 11.010004, 1.799998);
	TextDrawColor(Textdraw[3], -1);
	TextDrawSetOutline(Textdraw[3], 0);
	TextDrawSetProportional(Textdraw[3], 1);
	TextDrawSetShadow(Textdraw[3], 1);
	TextDrawSetSelectable(Textdraw[3], 0);
	Textdraw[4] = TextDrawCreate(290.000000, 160.000000, "-");
	TextDrawBackgroundColor(Textdraw[4], 255);
	TextDrawFont(Textdraw[4], 1);
	TextDrawLetterSize(Textdraw[4], 11.010004, 1.799998);
	TextDrawColor(Textdraw[4], -1);
	TextDrawSetOutline(Textdraw[4], 0);
	TextDrawSetProportional(Textdraw[4], 1);
	TextDrawSetShadow(Textdraw[4], 1);
	TextDrawSetSelectable(Textdraw[4], 0);
	Textdraw[5] = TextDrawCreate(358.000000, 160.000000, "-");
	TextDrawBackgroundColor(Textdraw[5], 255);
	TextDrawFont(Textdraw[5], 1);
	TextDrawLetterSize(Textdraw[5], 11.010004, 1.799998);
	TextDrawColor(Textdraw[5], -1);
	TextDrawSetOutline(Textdraw[5], 0);
	TextDrawSetProportional(Textdraw[5], 1);
	TextDrawSetShadow(Textdraw[5], 1);
	TextDrawSetSelectable(Textdraw[5], 0);
	Textdraw[6] = TextDrawCreate(159.000000, 184.000000, "Elegy");
	TextDrawBackgroundColor(Textdraw[6], 255);
	TextDrawFont(Textdraw[6], 0);
	TextDrawLetterSize(Textdraw[6], 0.500000, 1.000000);
	TextDrawColor(Textdraw[6], -1);
	TextDrawSetOutline(Textdraw[6], 0);
	TextDrawSetProportional(Textdraw[6], 1);
	TextDrawSetShadow(Textdraw[6], 1);
	TextDrawSetSelectable(Textdraw[6], 0);
	Textdraw[7] = TextDrawCreate(281.000000, 184.000000, "Banshee");
	TextDrawBackgroundColor(Textdraw[7], 255);
	TextDrawFont(Textdraw[7], 0);
	TextDrawLetterSize(Textdraw[7], 0.500000, 1.000000);
	TextDrawColor(Textdraw[7], -1);
	TextDrawSetOutline(Textdraw[7], 0);
	TextDrawSetProportional(Textdraw[7], 1);
	TextDrawSetShadow(Textdraw[7], 1);
	TextDrawSetSelectable(Textdraw[7], 0);
	Textdraw[8] = TextDrawCreate(401.000000, 184.000000, "Sultan");
	TextDrawBackgroundColor(Textdraw[8], 255);
	TextDrawFont(Textdraw[8], 0);
	TextDrawLetterSize(Textdraw[8], 0.500000, 1.000000);
	TextDrawColor(Textdraw[8], -1);
	TextDrawSetOutline(Textdraw[8], 0);
	TextDrawSetProportional(Textdraw[8], 1);
	TextDrawSetShadow(Textdraw[8], 1);
	TextDrawSetSelectable(Textdraw[8], 0);
	Textdraw[9] = TextDrawCreate(145.000000, 250.000000, "+50 000$");
	TextDrawBackgroundColor(Textdraw[9], 255);
	TextDrawFont(Textdraw[9], 1);
	TextDrawLetterSize(Textdraw[9], 0.500000, 1.000000);
	TextDrawColor(Textdraw[9], 1590320383);
	TextDrawSetOutline(Textdraw[9], 0);
	TextDrawSetProportional(Textdraw[9], 1);
	TextDrawSetShadow(Textdraw[9], 1);
	TextDrawSetSelectable(Textdraw[9], 0);
	Textdraw[10] = TextDrawCreate(268.000000, 250.000000, "+50 000$");
	TextDrawBackgroundColor(Textdraw[10], 255);
	TextDrawFont(Textdraw[10], 1);
	TextDrawLetterSize(Textdraw[10], 0.500000, 1.000000);
	TextDrawColor(Textdraw[10], 1590320383);
	TextDrawSetOutline(Textdraw[10], 0);
	TextDrawSetProportional(Textdraw[10], 1);
	TextDrawSetShadow(Textdraw[10], 1);
	TextDrawSetSelectable(Textdraw[10], 0);
	Textdraw[11] = TextDrawCreate(389.000000, 252.000000, "+50 000$");
	TextDrawBackgroundColor(Textdraw[11], 255);
	TextDrawFont(Textdraw[11], 1);
	TextDrawLetterSize(Textdraw[11], 0.500000, 1.000000);
	TextDrawColor(Textdraw[11], 1590320383);
	TextDrawSetOutline(Textdraw[11], 0);
	TextDrawSetProportional(Textdraw[11], 1);
	TextDrawSetShadow(Textdraw[11], 1);
	TextDrawSetSelectable(Textdraw[11], 0);
	Textdraw[12] = TextDrawCreate(154.000000, 266.000000, "+5 DM");
	TextDrawBackgroundColor(Textdraw[12], 255);
	TextDrawFont(Textdraw[12], 1);
	TextDrawLetterSize(Textdraw[12], 0.500000, 1.000000);
	TextDrawColor(Textdraw[12], -1);
	TextDrawSetOutline(Textdraw[12], 0);
	TextDrawSetProportional(Textdraw[12], 1);
	TextDrawSetShadow(Textdraw[12], 1);
	TextDrawSetSelectable(Textdraw[12], 0);
	Textdraw[13] = TextDrawCreate(277.000000, 266.000000, "+5 DM");
	TextDrawBackgroundColor(Textdraw[13], 255);
	TextDrawFont(Textdraw[13], 1);
	TextDrawLetterSize(Textdraw[13], 0.500000, 1.000000);
	TextDrawColor(Textdraw[13], -1);
	TextDrawSetOutline(Textdraw[13], 0);
	TextDrawSetProportional(Textdraw[13], 1);
	TextDrawSetShadow(Textdraw[13], 1);
	TextDrawSetSelectable(Textdraw[13], 0);
	Textdraw[14] = TextDrawCreate(399.000000, 268.000000, "+5 DM");
	TextDrawBackgroundColor(Textdraw[14], 255);
	TextDrawFont(Textdraw[14], 1);
	TextDrawLetterSize(Textdraw[14], 0.500000, 1.000000);
	TextDrawColor(Textdraw[14], -1);
	TextDrawSetOutline(Textdraw[14], 0);
	TextDrawSetProportional(Textdraw[14], 1);
	TextDrawSetShadow(Textdraw[14], 1);
	TextDrawSetSelectable(Textdraw[14], 0);
	Textdraw[15] = TextDrawCreate(234.000000, 179.000000, "_");
	TextDrawBackgroundColor(Textdraw[15], 255);
	TextDrawFont(Textdraw[15], 1);
	TextDrawLetterSize(Textdraw[15], 0.479999, 12.000000);
	TextDrawColor(Textdraw[15], -1);
	TextDrawSetOutline(Textdraw[15], 0);
	TextDrawSetProportional(Textdraw[15], 1);
	TextDrawSetShadow(Textdraw[15], 1);
	TextDrawUseBox(Textdraw[15], 1);
	TextDrawBoxColor(Textdraw[15], 0);
	TextDrawTextSize(Textdraw[15], 130.000000, 5.000000);
	TextDrawSetSelectable(Textdraw[15], 0);
	Textdraw[16] = TextDrawCreate(355.000000, 179.000000, "_");
	TextDrawBackgroundColor(Textdraw[16], 255);
	TextDrawFont(Textdraw[16], 1);
	TextDrawLetterSize(Textdraw[16], 0.479999, 12.000000);
	TextDrawColor(Textdraw[16], -1);
	TextDrawSetOutline(Textdraw[16], 0);
	TextDrawSetProportional(Textdraw[16], 1);
	TextDrawSetShadow(Textdraw[16], 1);
	TextDrawUseBox(Textdraw[16], 1);
	TextDrawBoxColor(Textdraw[16], 0);
	TextDrawTextSize(Textdraw[16], 251.000000, 7.000000);
	TextDrawSetSelectable(Textdraw[16], 0);
	Textdraw[17] = TextDrawCreate(476.000000, 179.000000, "_");
	TextDrawBackgroundColor(Textdraw[17], 255);
	TextDrawFont(Textdraw[17], 1);
	TextDrawLetterSize(Textdraw[17], 0.479999, 12.000000);
	TextDrawColor(Textdraw[17], -1);
	TextDrawSetOutline(Textdraw[17], 0);
	TextDrawSetProportional(Textdraw[17], 1);
	TextDrawSetShadow(Textdraw[17], 1);
	TextDrawUseBox(Textdraw[17], 1);
	TextDrawBoxColor(Textdraw[17], 0);
	TextDrawTextSize(Textdraw[17], 374.000000, 6.000000);
	TextDrawSetSelectable(Textdraw[17], 0);
	restarting = true;
	MYSQL = mysql_connect( MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASSWORD);
	mysql_function_query(MYSQL, "SET NAMES 'cp1251'",false, "", "");
 	mysql_set_charset("cp1251");
	mysql_function_query(MYSQL, "SELECT * FROM  "HOUSE_TABLE"", true, "LoadHouses", "");
	mysql_function_query(MYSQL, "SELECT * FROM  "TABLE_CLANS"", true, "LoadClans", "");
	mysql_function_query(MYSQL, "SELECT * FROM  `records`", true, "LoadRecords", "");
	mysql_function_query(MYSQL, "SELECT * FROM  `rRaceInfo`", true, "LoadRecordsDD", "");
	mysql_function_query(MYSQL, "SELECT `Nickname`,`WinRace` FROM `accounts` ORDER BY `WinRace` DESC LIMIT 1", true, "TopWins", "");
	mysql_function_query(MYSQL, "SELECT `Nickname`,`LooseRace` FROM `accounts` ORDER BY `LooseRace` DESC LIMIT 1", true, "TopLoose", "");
	mysql_function_query(MYSQL, "SELECT `Nickname`,`KoeffPobed` FROM `accounts` ORDER BY `KoeffPobed` DESC LIMIT 1", true, "TopKoeff", "");
	#if defined OSNOVNOI_SERV
	mysql_function_query(MYSQL, "UPDATE "TABLE_ACC" SET `Online`='0' WHERE `Online`='1'", false, "", "");
	#endif
	gTextDraw[0] = TextDrawCreate(270.000,350, "<<");
	TextDrawTextSize(gTextDraw[0],5.0, 15.6);
	TextDrawAlignment(gTextDraw[0],2);
	TextDrawBackgroundColor(gTextDraw[0],0x000000ff);
	TextDrawFont(gTextDraw[0],1);
	TextDrawLetterSize(gTextDraw[0],0.250000, 1.000000);
	TextDrawColor(gTextDraw[0],0xffffffff);
	TextDrawSetProportional(gTextDraw[0],1);
	TextDrawSetShadow(gTextDraw[0],1);
	TextDrawSetSelectable(gTextDraw[0], 1);
	gTextDraw[1] = TextDrawCreate(300.000,350, "Spawn");
	TextDrawTextSize(gTextDraw[1],10.0, 15.6);
	TextDrawAlignment(gTextDraw[1],2);
	TextDrawBackgroundColor(gTextDraw[1],0x000000ff);
	TextDrawFont(gTextDraw[1],1);
	TextDrawLetterSize(gTextDraw[1],0.250000, 1.000000);
	TextDrawColor(gTextDraw[1],0xffffffff);
	TextDrawSetProportional(gTextDraw[1],1);
	TextDrawSetShadow(gTextDraw[1],1);
	TextDrawSetSelectable(gTextDraw[1], 1);
	gTextDraw[2] = TextDrawCreate(330.000,350, ">>");
	TextDrawTextSize(gTextDraw[2],5.0, 15.6);
	TextDrawAlignment(gTextDraw[2],2);
	TextDrawBackgroundColor(gTextDraw[2],0x000000ff);
	TextDrawFont(gTextDraw[2],1);
	TextDrawLetterSize(gTextDraw[2],0.250000, 1.000000);
	TextDrawColor(gTextDraw[2],0xffffffff);
	TextDrawSetProportional(gTextDraw[2],1);
	TextDrawSetShadow(gTextDraw[2],1);
	TextDrawSetSelectable(gTextDraw[2], 1);
	DcT_Object();
	for(new i; i < sizeof(ColorsScore); i ++){
		txtTimeDisp[i] = TextDrawCreate(577.000000, 25.000000, "00:00");
		TextDrawAlignment(txtTimeDisp[i], 2);
		TextDrawBackgroundColor(txtTimeDisp[i], 0x000000FF);
		TextDrawFont(txtTimeDisp[i], 3);
		TextDrawLetterSize(txtTimeDisp[i], 0.519999, 2.000000);
		TextDrawColor(txtTimeDisp[i], ColorsScore[i]);
		TextDrawSetOutline(txtTimeDisp[i], 2);
		TextDrawSetProportional(txtTimeDisp[i], 1);
		TextDrawSetSelectable(txtTimeDisp[i], 0);
	}
	Logo[0] = TextDrawCreate(2.000000, 435.000000, "Drift");
	Logo[1] = TextDrawCreate(44.000000, 435.000000, "Empire");
	Logo[2] = TextDrawCreate(42.500000, 434.500000, "Empire");
	Logo[3] = TextDrawCreate(0.500000, 434.500000, "Drift");
	TextDrawColor(Logo[0], -16777166);
	TextDrawColor(Logo[1], -16777166);
	TextDrawColor(Logo[2], 16711730);
	TextDrawColor(Logo[3], 16711730);
	for(new i; i < sizeof(Logo); i ++){
		TextDrawBackgroundColor(Logo[i], 16843263);
		TextDrawFont(Logo[i], 1);
		TextDrawLetterSize(Logo[i], 0.559998, 1.200000);
		TextDrawSetOutline(Logo[i], 0);
		TextDrawSetProportional(Logo[i], 1);
		TextDrawSetShadow(Logo[i], 0);
	}
	AllRaceTextDraw[0] = TextDrawCreate(165.000000, 252.000000, "_");
	TextDrawBackgroundColor(AllRaceTextDraw[0], 255);
	TextDrawFont(AllRaceTextDraw[0], 1);
	TextDrawLetterSize(AllRaceTextDraw[0], 0.100000, 9.299995);
	TextDrawColor(AllRaceTextDraw[0], 16777215);
	TextDrawSetOutline(AllRaceTextDraw[0], 0);
	TextDrawSetProportional(AllRaceTextDraw[0], 1);
	TextDrawSetShadow(AllRaceTextDraw[0], 1);
	TextDrawUseBox(AllRaceTextDraw[0], 1);
	TextDrawBoxColor(AllRaceTextDraw[0], 102);
	TextDrawTextSize(AllRaceTextDraw[0], 14.000000, 22.000000);
	TextDrawSetSelectable(AllRaceTextDraw[0], 0);
	AllRaceTextDraw[1] = TextDrawCreate(87.000000, 268.000000, "Drift Duel");
	TextDrawAlignment(AllRaceTextDraw[1], 2);
	TextDrawBackgroundColor(AllRaceTextDraw[1], 255);
	TextDrawFont(AllRaceTextDraw[1], 2);
	TextDrawLetterSize(AllRaceTextDraw[1], 0.519999, 1.000000);
	TextDrawColor(AllRaceTextDraw[1], -1);
	TextDrawSetOutline(AllRaceTextDraw[1], 0);
	TextDrawSetProportional(AllRaceTextDraw[1], 1);
	TextDrawSetShadow(AllRaceTextDraw[1], 2);
	TextDrawSetSelectable(AllRaceTextDraw[1], 0);
	AllRaceTextDraw[2] = TextDrawCreate(113.000000, 275.000000, "-");
	TextDrawAlignment(AllRaceTextDraw[2], 2);
	TextDrawBackgroundColor(AllRaceTextDraw[2], 255);
	TextDrawFont(AllRaceTextDraw[2], 1);
	TextDrawLetterSize(AllRaceTextDraw[2], 14.110018, 1.000000);
	TextDrawColor(AllRaceTextDraw[2], -1);
	TextDrawSetOutline(AllRaceTextDraw[2], 1);
	TextDrawSetProportional(AllRaceTextDraw[2], 1);
	TextDrawSetSelectable(AllRaceTextDraw[2], 0);
	AllRaceTextDraw[3] = TextDrawCreate(113.000000, 303.000000, "-");
	TextDrawAlignment(AllRaceTextDraw[3], 2);
	TextDrawBackgroundColor(AllRaceTextDraw[3], 255);
	TextDrawFont(AllRaceTextDraw[3], 1);
	TextDrawLetterSize(AllRaceTextDraw[3], 14.110018, 1.000000);
	TextDrawColor(AllRaceTextDraw[3], -1);
	TextDrawSetOutline(AllRaceTextDraw[3], 1);
	TextDrawSetProportional(AllRaceTextDraw[3], 1);
	TextDrawSetSelectable(AllRaceTextDraw[3], 0);
	AllRaceTextDraw[4] = TextDrawCreate(87.000000, 310.000000, "Record");
	TextDrawAlignment(AllRaceTextDraw[4], 2);
	TextDrawBackgroundColor(AllRaceTextDraw[4], 255);
	TextDrawFont(AllRaceTextDraw[4], 2);
	TextDrawLetterSize(AllRaceTextDraw[4], 0.490000, 1.000000);
	TextDrawColor(AllRaceTextDraw[4], -1);
	TextDrawSetOutline(AllRaceTextDraw[4], 0);
	TextDrawSetProportional(AllRaceTextDraw[4], 1);
	TextDrawSetShadow(AllRaceTextDraw[4], 2);
	TextDrawSetSelectable(AllRaceTextDraw[4], 0);
	AllRaceTextDraw[5] = TextDrawCreate(113.000000, 261.000000, "-");
	TextDrawAlignment(AllRaceTextDraw[5], 2);
	TextDrawBackgroundColor(AllRaceTextDraw[5], 255);
	TextDrawFont(AllRaceTextDraw[5], 1);
	TextDrawLetterSize(AllRaceTextDraw[5], 14.110018, 1.000000);
	TextDrawColor(AllRaceTextDraw[5], -1);
	TextDrawSetOutline(AllRaceTextDraw[5], 1);
	TextDrawSetProportional(AllRaceTextDraw[5], 1);
	TextDrawSetSelectable(AllRaceTextDraw[5], 0);
	AllRaceTextDraw[6] = TextDrawCreate(113.000000, 316.000000, "-");
	TextDrawAlignment(AllRaceTextDraw[6], 2);
	TextDrawBackgroundColor(AllRaceTextDraw[6], 255);
	TextDrawFont(AllRaceTextDraw[6], 1);
	TextDrawLetterSize(AllRaceTextDraw[6], 14.110018, 1.000000);
	TextDrawColor(AllRaceTextDraw[6], -1);
	TextDrawSetOutline(AllRaceTextDraw[6], 1);
	TextDrawSetProportional(AllRaceTextDraw[6], 1);
	TextDrawSetSelectable(AllRaceTextDraw[6], 0);
	AllRaceTextDraw[7] = TextDrawCreate(158.000000, 253.000000, "Postition: ~g~1");
	TextDrawAlignment(AllRaceTextDraw[7], 3);
	TextDrawBackgroundColor	(AllRaceTextDraw[7], 255);
	TextDrawFont(AllRaceTextDraw[7], 1);
	TextDrawLetterSize(AllRaceTextDraw[7], 0.389999, 1.000000);
	TextDrawColor(AllRaceTextDraw[7], -1);
	TextDrawSetOutline(AllRaceTextDraw[7], 0);
	TextDrawSetProportional(AllRaceTextDraw[7], 1);
	TextDrawSetShadow(AllRaceTextDraw[7], 1);
	TextDrawSetSelectable(AllRaceTextDraw[7], 0);
	AllRaceTextDraw[8] = TextDrawCreate(158.000000, 253.000000, "Postition: ~r~2");
	TextDrawAlignment(			AllRaceTextDraw[8], 3);
	TextDrawBackgroundColor	(	AllRaceTextDraw[8], 255);
	TextDrawFont(				AllRaceTextDraw[8], 1);
	TextDrawLetterSize(			AllRaceTextDraw[8], 0.389999, 1.000000);
	TextDrawColor(				AllRaceTextDraw[8], -1);
	TextDrawSetOutline(			AllRaceTextDraw[8], 0);
	TextDrawSetProportional(	AllRaceTextDraw[8], 1);
	TextDrawSetShadow(			AllRaceTextDraw[8], 1);
	TextDrawSetSelectable(		AllRaceTextDraw[8], 0);
	Starts[0][rChecks] = true;
	Starts[1][rChecks] = true;
	Starts[2][rChecks] = true;
	new Float:Pos_Sped_Z = 425,//верх-низ
	    Float:Pos_Sped_X = 575,//лево-право
	    Float:Pos_Popr_X = 1, // Промежуток между делениями
	    Float:Shirina = -2;//0.4; // Ширина делений
	Box = TextDrawCreate(Pos_Sped_X,Pos_Sped_Z,"_");
	TextDrawSetShadow(Box, 0);
	TextDrawAlignment(Box,1);
	TextDrawFont(Box,1);
	TextDrawUseBox(Box, 1);
	TextDrawBoxColor(Box,0x00000050);
	TextDrawSetProportional(Box,0);
	TextDrawTextSize(Box, Pos_Sped_X+(Pos_Popr_X*(COLORS_SPEEDOM-1))+Shirina, 0.000000);	
	for(new i=0; i < COLORS_SPEEDOM; i++) {
	    Speed[0][i] = 	TextDrawCreate(Pos_Sped_X+(Pos_Popr_X*i),Pos_Sped_Z,"_");
	    Speed[1][i] = 	TextDrawCreate(Pos_Sped_X+(Pos_Popr_X*i),Pos_Sped_Z,"_");
	    Speed[2][i] = 	TextDrawCreate(Pos_Sped_X+(Pos_Popr_X*i),Pos_Sped_Z,"_");
		TextDrawFont(Speed[1][i],1);
		TextDrawFont(Speed[0][i],1);
		TextDrawFont(Speed[2][i],1);
		TextDrawAlignment(Speed[1][i],1);
		TextDrawAlignment(Speed[0][i],1);
		TextDrawAlignment(Speed[2][i],1);
		TextDrawSetProportional(Speed[0][i],0);
		TextDrawSetProportional(Speed[1][i],0);
		TextDrawSetProportional(Speed[2][i],0);
		TextDrawSetShadow(Speed[0][i], 0);
		TextDrawSetShadow(Speed[1][i], 0);
		TextDrawSetShadow(Speed[2][i], 0);
		TextDrawUseBox(Speed[0][i], 1);
		TextDrawUseBox(Speed[1][i], 1);
		TextDrawUseBox(Speed[2][i], 1);
		TextDrawTextSize(Speed[0][i], Pos_Sped_X+(Pos_Popr_X*i)+Shirina, 0.000000);
		TextDrawTextSize(Speed[1][i], Pos_Sped_X+(Pos_Popr_X*i)+Shirina, 0.000000);
		TextDrawTextSize(Speed[2][i], Pos_Sped_X+(Pos_Popr_X*i)+Shirina, 0.000000);
		TextDrawBoxColor(Speed[0][i],	speedcolors[0][i]);
		TextDrawBoxColor(Speed[1][i],	speedcolors[1][i]);
		TextDrawBoxColor(Speed[2][i],	COLOR_WHITE);
	}
	hpDrawFon = TextDrawCreate 	( 	499.0,100.0,"." 	),
	TextDrawBackgroundColor 	( 	hpDrawFon, -1 		),
	TextDrawFont 				( 	hpDrawFon, 2		),
	TextDrawLetterSize 			(	hpDrawFon, 0.0, 0.55 ),
	TextDrawColor 				( 	hpDrawFon, -1 		),
	TextDrawSetOutline 			(	hpDrawFon, 0 		),
	TextDrawSetProportional 	( 	hpDrawFon, 1 		),
	TextDrawSetShadow 			( 	hpDrawFon, 0 		),
	TextDrawUseBox 				( 	hpDrawFon, 1 		),
	TextDrawBoxColor 			( 	hpDrawFon, 0x000000ff ),
	TextDrawTextSize 			( 	hpDrawFon, 561, 0.0 );
	hpDraweFon = TextDrawCreate 	( 	499.0,110.0,"." 	),
	TextDrawBackgroundColor 		( 	hpDraweFon, -1 		),
	TextDrawFont 					( 	hpDraweFon, 2		),
	TextDrawLetterSize 				(	hpDraweFon, 0.0, 0.55 ),
	TextDrawColor 					( 	hpDraweFon, -1 		),
	TextDrawSetOutline 				(	hpDraweFon, 0 		),
	TextDrawSetProportional 		( 	hpDraweFon, 1 		),
	TextDrawSetShadow 				( 	hpDraweFon, 0 		),
	TextDrawUseBox 					( 	hpDraweFon, 1 		),
	TextDrawBoxColor 				( 	hpDraweFon, 0x000000ff ),
	TextDrawTextSize 				( 	hpDraweFon, 561, 0.0 );
	SendRconCommand("reloadbans");
	SendRconCommand("weburl www.DRIFT2.ru");
	forEx(MAX_PLAYERS,playerid)
	{
		hpDraw[playerid] = TextDrawCreate ( 501.0, 102.0, "." ),
		TextDrawBackgroundColor ( hpDraw[playerid], -1 ),
		TextDrawFont ( hpDraw[playerid], 2),
		TextDrawLetterSize ( hpDraw[playerid], 0.0, 0.10000 ),
		TextDrawColor ( hpDraw[playerid], -1 ),
		TextDrawSetOutline ( hpDraw[playerid], 0 ),
		TextDrawSetProportional ( hpDraw[playerid], 1 ),
		TextDrawSetShadow ( hpDraw[playerid], 0 ),
		TextDrawUseBox ( hpDraw[playerid], 1 ),
		TextDrawBoxColor ( hpDraw[playerid], COLOR_YELLOW ),
		TextDrawTextSize ( hpDraw[playerid], 503, 0.0 ) ;
		hpDrawe[playerid] = TextDrawCreate ( 501.0, 112.0, "." ),
		TextDrawBackgroundColor ( hpDrawe[playerid], -1 ),
		TextDrawFont ( hpDrawe[playerid], 2),
		TextDrawLetterSize ( hpDrawe[playerid], 0.0, 0.10000 ),
		TextDrawColor ( hpDrawe[playerid], -1 ),
		TextDrawSetOutline ( hpDrawe[playerid], 0 ),
		TextDrawSetProportional ( hpDrawe[playerid], 1 ),
		TextDrawSetShadow ( hpDrawe[playerid], 0 ),
		TextDrawUseBox ( hpDrawe[playerid], 1 ),
		TextDrawBoxColor ( hpDrawe[playerid], COLOR_YELLOW ),
		TextDrawTextSize ( hpDrawe[playerid], 503, 0.0 ) ;
	}
	for(new i; i <= 299; i++){
		AddPlayerClass(i, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	}
	UpdateTime();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights(); 
	UsePlayerPedAnims();
	//EnableVehicleFriendlyFire();
	SetNameTagDrawDistance(30.0);
 	SetTimer("Update", 1000, 1);
	SetTimer("driftcheckEx", 150, true);
	SetTimer("UpdateAngleEx", 200, true);
	antysh = SetTimer("AntySpeed", 240, true);
	SetTimer("updateangle", 175, true);
	antyshtwo = SetTimer("AntySH", 990, true);
	SetGameModeText("Empire Drifters v1.0.2 + Clans[BETA]");
	SendRconCommand("mapname Empire of drifters");	
    //skinlist = LoadModelSelectionMenu("skins.txt");
	restarting = false;
	timemsg = gettime();
	SetWeather(13);
	gettime(hour);
	SetWorldTime(hour);
	mysql_function_query(MYSQL, "SELECT `Nickname`, `level`,`id` FROM `accounts` ORDER BY `level` DESC LIMIT 10", true, "TopLevelUpdate", "");
	mysql_function_query(MYSQL, "SELECT `Nickname`, `Money`, `id` FROM `accounts` ORDER BY `Money` DESC LIMIT 10", true, "TopMoneyUpdate", "");
	//CreateObjectsX(25,3458,4431.19140625,-2660.3740234375,2433.402343, 0.0, 333.0, 45, 42.75, 360.0, true);
	SetTimer("ClearAccount", 30000, 0);
	return true;
}
public ClearAccount(){
	new qString[128];
	format(qString, sizeof qString, "SELECT `id` FROM "TABLE_ACC" WHERE `EndOnline` < %d LIMIT 2", gettime()-2629743);	
	mysql_function_query(MYSQL, qString, true, "RemovAccounts", "");
	return true;
}
public RemovAccounts(){
	new rows, fields;
	cache_get_data(rows, fields);
	if(!rows)
		return print("Нет старых акков");
	new buffer[20],
		qString2[156],
		sqlid;
	for(new i; i < rows; i++){
		cache_get_field_content(i, "id", buffer);
		sqlid = strval(buffer);
		format(qString2, sizeof qString2, "DELETE FROM "TABLE_ACC" WHERE `id`='%d'",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof(qString2),"UPDATE  "HOUSE_TABLE" SET `howner` = 'NULL',howneruid` = '0',`hLock` = '0',`naprodaje` = '0' WHERE WHERE `howneruid` = %d;",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof(qString2),"DELETE FROM `cars` WHERE `cOwner` = %d;",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof(qString2),"DELETE FROM `messages`  WHERE `pUID` = %d;",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof qString2, "DELETE FROM "FRENDS_TABLE" WHERE `fUID` = %d",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof qString2, "DELETE FROM "FRENDS_TABLE" WHERE `pUID` = %d",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof qString2, "DELETE FROM "BLACKLIST_TABLE" WHERE `bUID` = %d",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
		format(qString2, sizeof qString2, "DELETE FROM `ClansPlayer` WHERE `cUID` = %d",sqlid);
		mysql_function_query(MYSQL, qString2, false, "", "");
	}
	SetTimer("ClearAccount", 5000, 0);
	return true;
}
public OnGameModeExit(){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++) {	
		if(!IsPlayerConnected(i))continue;
		SetPlayerName(i,Player[i][PlayerName]);
		Delete3DTextLabel(AFK_3DT[i]);
		if(!restarting){
			if(!LanglePlayer{i}){
				SendClientMessage(i, -1, ""SERVER_MSG"Сообщите о данной проблеме глав. админу. (skype: Alpano.)!");
    			SendClientMessage(i, -1, ""SERVER_MSG""TEXT_KICK" [#10]");
			}else{
   				SendClientMessage (i,-1, ""SERVER_MSG" Report about this problem of heads. to the administrator. (skype: Alpano.)! ");
           		SendClientMessage (i,-1, ""TEXT_KICK_EN" [#10]");
			}
			t_Kick(i);
		}else{
  		if(!LanglePlayer{i})
		 	SendClientMessage(i, -1, ""SERVER_MSG"Обновление сервера!");
		else
			SendClientMessage(i, -1, ""SERVER_MSG"Server up-dating!");
	}   }
	TextDrawDestroy(gTextDraw[0]);
	TextDrawDestroy(gTextDraw[1]);
	TextDrawDestroy(gTextDraw[2]);
	for(new i; i < sizeof(Logo); i ++)
		TextDrawDestroy(Logo[i]);
	KillTimer(antysh);
	KillTimer(antyshtwo);
	UnLoadHouses();
	new tveh = t_CreateVehicle(400, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
	DestroyVehicle(tveh);
	for(new d; d < tveh; d++)
	{
		if(!GetVehicleModel(d)) continue;
		DestroyVehicle(d);
	}
	new Text: TD = TextDrawCreate(-10.0, -10.0, " ");
	TextDrawDestroy(TD);
	for(new Text: i; i < TD; i++)
	{
		TextDrawHideForAll(i);
		TextDrawDestroy(i);
	}
	new testobj = CreateDynamicObject(971, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	DestroyDynamicObject(testobj);
	for(new i; i < testobj; i++)
	{
		if(!IsValidObject(i)) continue;
		DestroyDynamicObject(i);
	}
	return true;
}
public ac_OnPlayerDeath(playerid, killerid, reason){
	SetPVarInt(playerid,"K_Times",GetPVarInt(playerid,"K_Times") + 1);
	if(GetPVarInt(playerid,"K_Times") > 1){
		AddBan(playerid,INVALID_PLAYER_ID,"Death flood",600);
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#9]");
		else
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#9]");
	 	return t_Kick(playerid);
	}
	SetPVarInt(playerid, "AntiBreik", 4+(GetPlayerPing(playerid)/35));
    if(IsPlayerInAnyVehicle(playerid))
		RemovePlayerFromVehicle(playerid);
	new spawn,Float:dis,Float:dise;
	for(new f ; f < SPAWNS; f++){
	    dis = GetPlayerDistanceFromPoint(playerid, Spawnse[f][xS], Spawnse[f][yS], Spawnse[f][xS]);
	    if(dis < dise || !f){
			spawn = f;
			dise = dis;
	}	}
	SetSpawnInfo(playerid,0,Player[playerid][pSkin],Spawnse[spawn][xS], Spawnse[spawn][yS], Spawnse[spawn][xS]+1,Spawnse[spawn][aS]);
	GameTextForPlayer(playerid, FixText("~r~Потрачено"), 3000, 4);
	SetPVarInt(playerid,"Death",1);
	Player[playerid][pVcar] = 0;
	Player[playerid][pVirt] = 0;
	if(GetPlayerVirtualWorld(playerid) == 1024)
		t_SetPlayerVirtualWorld(playerid, 0);
	return true;
}
public OnVehicleSpawn(vehicleid){
	SetVehicleParamsEx(vehicleid,0,(hour < 7 || hour > 21)?1:0,0,0,0,0,0);
	t_LinkVehicleToInterior(vehicleid,0);
	for(new playerid = 0, all = MAX_PLAYERS; playerid < all; playerid++){
		if(!IsPlayerConnected(playerid))continue;
		new f = GetCarIdPoId(vehicleid,playerid);
		if(f){
			SetVehicleNumberPlate(vehicleid,pNumber[f][playerid]);
			ChangeVehicleColor(pvehs[f][playerid],Player[playerid][pColor][f],Player[playerid][pColorTwo][f]);
			if(Player[playerid][pVinil][f] >= 0) ChangeVehiclePaintjob(pvehs[f][playerid],Player[playerid][pVinil][f]);
			if(Player[playerid][cGidravlika][f])
				AddVehicleComponent(pvehs[f][playerid], 1087);
			if(Player[playerid][cWheels][f] != -1)
				AddVehicleComponent(pvehs[f][playerid], Wheels[Player[playerid][cWheels][f]]);	
			SetCarInGarage(playerid,f);
			return true;
	}   }
	new string[25];
	format(string,sizeof(string),"{000000}[DE %04d]",vehicleid);
	SetVehicleNumberPlate(vehicleid,string);
	return true;
}
Translate(character){
	switch(character){
	case 0xE0: character = 0x66;
	case 0xC0: character = 0x46;
	case 0xE2: character = 0x64;
	case 0xC2: character = 0x44;
	case 0xE3: character = 'u';
	case 0xC3: character = 'U';
	case 0xE4: character = 'l';
	case 0xC4: character = 'L';
	case 0xE5: character = 't';
	case 'Е': character = 'T';
	case 0xE7: character = 'p';
	case 'З': character = 'P';
	case 0xE8: character = 'b';
	case 'И': character = 'B';
	case 0xE9: character = 'q';
	case 'Й': character = 'Q';
	case 0xEA: character = 'r';
	case 'К': character = 'R';
	case 'л': character = 'k';
	case 'Л': character = 'K';
	case 'м': character = 'v';
	case 'М': character = 'V';
	case 'н': character = 'y';
	case 'Н': character = 'Y';
	case 'о': character = 'j';
	case 'О': character = 'J';
	case 'п': character = 'g';
	case 'П': character = 'G';
	case 'р': character = 'h';
	case 'Р': character = 'H';
	case 'с': character = 'c';
	case 'С': character = 'C';
	case 'т': character = 'n';
	case 'Т': character = 'N';
	case 'у': character = 'e';
	case 'У': character = 'E';
	case 'ф': character = 'a';
	case 'Ф': character = 'A';
	case 'ц': character = 'w';
	case 'Ц': character = 'W';
	case 'ч': character = 'x';
	case 'Ч': character = 'X';
	case 'ш': character = 'i';
	case 'Ш': character = 'I';
	case 'щ': character = 'o';
	case 'Щ': character = 'O';
	case 'ь': character = 'm';
	case 'Ь': character = 'M';
	case 'ы': character = 's';
	case 'Ы': character = 'S';
	case 'ю': character = '.';
	case 'Я': character = 'z';
	case 'я': character = 'Z';
	}
	return character;
}
// Переворачиваем команду //
SendInWorldMessage(playerid,Float:max_radius,text[],colour1){
	new Float:posed[3],
	    world=GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid,posed[0],posed[1],posed[2]);
	for(new i = 0, all = MAX_PLAYERS; i < all; i++) {
		if(!IsPlayerConnected(i) || !Player[i][logged] || GetPlayerVirtualWorld(i) != world)continue;
		if(IsPlayerInRangeOfPoint(i,max_radius,posed[0],posed[1],posed[2])){
			SendClientMessage(i,colour1,text);
	}	}
	return 1;
}
/*
	    numpos = -1;
	if(strfind(text,"#",true) != -1) numpos = strfind(text, "#");
	else if(strfind(text,"№",true) != -1) numpos = strfind(text, "№");
	if(numpos != -1)
	{
		new line[256];
	    if('0' <= text[++numpos] <= '9')
	    {
			for(new i = GetMAX_PLAYERS() - 1; i != -1; i--)
			{
				if(!Player[i][logged] || i != strval(text[numpos + 1])) continue;
				strcat(line, text[numpos], 256);
				new pos = (strfind(line, " ") != -1) ? strfind(line, " ") : strlen(line);
				strdel(line, 0, pos);
				strdel(text, numpos++, 256);
*/
NameString(playerid,texted[])
{
	new color[7];
	if(Player[playerid][pColorText] == 0)
		color = #FFFFFF;
	else if(Player[playerid][pColorText] == 1)
		color = #badcff;
	else if(Player[playerid][pColorText] == 2)
		color = #baffdd;
	else if(Player[playerid][pColorText] == 3)
		color = #ffedba;
	new text[256];
	strcat(text, texted);
	new pos = -1, max_names;
 	for(new i; i < 5; i++){
		if((pos = strfind(text, "#", false, pos+1)) != -1 || (pos = strfind(text, "№", false, pos+1)) != -1){
			if(max_names == 3) break;
			new tmp1[45], cp = pos+1;
			strmid(tmp1, text, cp, cp+3);
			new id = strval(tmp1);
			if((0 <= id <= 1000) && ('0' <= text[cp] <= '9')){
				max_names++;
				new xpos = id < 10 ? cp+1 : id < 100 ? cp+2 : cp+3;
				strdel(text, pos, xpos);
				if(IsPlayerConnected(id)){
					format(tmp1, sizeof(tmp1), "{%s}%s{%s}", chatcolor[Player[id][pColorPlayer]], Player[id][PlayerName],color);
				}
				else format(tmp1, sizeof(tmp1), "ID%d", id);
				strins(text, tmp1, pos);
	}	}	}
	new string[256],
		id[8];
	if(ChatOn || Player[playerid][pAdminPlayer] > LEVEL_CHAT){
		if(Player[playerid][pTags] && Player[playerid][cClan][0] != INVALID_CLAN_ID && Player[playerid][cRate][0] > 0){
			strcat(string,ReturnClanTag(ReturnClotBD(Player[playerid][cClan][0])));
			strcat(string," ");
		}
		strcat(string,"{");
		strcat(string,chatcolor[Player[playerid][pColorPlayer]]);
		strcat(string,"}");
		strcat(string,Player[playerid][PlayerName]);
		format(id,sizeof(id),"[%d]",playerid);
		strcat(string,id);
		if(Player[playerid][pTags] && Player[playerid][cClan][1] != INVALID_CLAN_ID && Player[playerid][cRate][1] > 0){
			strcat(string," ");
			strcat(string,ReturnClanTag(ReturnClotBD(Player[playerid][cClan][1])));
		}
		strcat(string,"{");
		strcat(string,color);
		strcat(string,"}: ");
		strcat(string,text);
		if(LanglePlayer{playerid})
			t_SendClientMessageToAll(Player[playerid][pCt],-1, "",string);
		else
			t_SendClientMessageToAll(Player[playerid][pCt],-1, string,"");
	}
	else
		if(!LanglePlayer{playerid}) SendClientMessage(playerid,-1, ""SERVER_MSG"Чат отключен администратором!");else SendClientMessage(playerid,-1, ""SERVER_MSG"Chat blocked by administrator!");
	return false;
}
protected StripNewLine(string[]){
    new len = strlen(string);
    if (string [0] == 0)return;
    if ((string [len - 1] == '\n') || (string [len - 1] == '\r')){
        string [len - 1] = 0;
        if (string [0] == 0)return;
        if ((string [len - 2] == '\n') || (string [len - 2] == '\r'))string [len - 2] = 0;
    }
} 
public OnPlayerText(playerid, text[]){
	if(!Player[playerid][logged] || !IsPlayerConnected(playerid)){
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#14]"); else SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#14]");
		t_Kick(playerid);
		return false;
	}
	if(incorrectCmdAttempt(playerid,text)) return false;
	new strlens = strlen(text);
	if(Player[playerid][pMuted]){
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"У тебя отключен чат!");
		else
			SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Chat is blocked!");
		SetPVarInt(playerid,"cheat",GetPVarInt(playerid,"cheat")+1);
		if(GetPVarInt(playerid,"cheat") > 3){
			if(!LanglePlayer{playerid})
				{SendClientMessage(playerid,-1, ""SERVER_MSG"Ты кикнут за флуд!");SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#12]");}else{SendClientMessage(playerid,-1, ""SERVER_MSG"You kicked for flood!");SendClientMessage(playerid,-1, ""TEXT_KICK_EN" [#12]");}
			t_Kick(playerid);
		}
		return false;
	}
	//---------------------
	if(strlens > 100)
 		if(!LanglePlayer{playerid})return SendClientMessage(playerid,-1, ""SERVER_MSG"Слишком длинное сообщение!"), false; else return SendClientMessage(playerid,-1, ""SERVER_MSG"Too long message!"), false;
	if(!strlen(text) || emptyMessage(text)) return false;
 	if(strlens > 5)
		if(GetMiniBook(text) >= strlens/2) UpperToLower(text);
	if(getprobel(text))
		return SendClientMessage(playerid,-1, ""SERVER_MSG"Слишком много пробелов!"), false;
	//---------------------
	if(gettime() <  sizemsg[playerid][1] && Player[playerid][pAdminPlayer] <= LEVEL_CHAT){
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid,-1, ""SERVER_MSG"Сообщения можно отправлять 1 раз в 2 секунды");
		else
			SendClientMessage(playerid,-1, ""SERVER_MSG"It is possible to send messages of 1 time in 2 seconds");
		SetPVarInt(playerid,"ShatFlood",GetPVarInt(playerid,"ShatFlood")+1);
		if(GetPVarInt(playerid,"ShatFlood") > 5){
			if(!LanglePlayer{playerid}){SendClientMessage(playerid,-1, ""SERVER_MSG"Ты кикнут за флуд!");SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#12]");}else{SendClientMessage(playerid,-1, ""SERVER_MSG"You kicked for flood!");SendClientMessage(playerid,-1, ""TEXT_KICK_EN" [#12]");}
			return t_Kick(playerid);
	}	}else{
		new string[144];
		for(new i, c; text[i]; ++i)
			if((0x61 <= text[i] <= 0x7A) || (0x41 <= text[i] <= 0x5A) || (0xC0 <= text[i] <= 0xFF))
				string[c++] = text[i];
		for(new i, posExL; i < sizeof(exep_arr); ++i)
			if((posExL = strfind(string, exep_arr[i], true)) != -1){
				for(new len = strlen(exep_arr[i]); len--; string[posExL++] = '.'){}
				i = 0;
			}
		for(new i, posExL; i < sizeof(word_arr); ++i)
			if((posExL = strfind(string, word_arr[i], true)) != -1){
				BadWords[playerid]++;
				for(new len = strlen(word_arr[i]); len--; string[posExL++] = '*'){}
				i = 0;
			}
		for(new i, c; text[i]; ++i)
			if((0x61 <= text[i] <= 0x7A) || (0x41 <= text[i] <= 0x5A) || (0xC0 <= text[i] <= 0xFF))
				if(string[c++] == '*')
					text[i] = '*';
		SetPVarInt(playerid,"ShatFlood",0);
		sizemsg[playerid][1] = gettime()+INTERVAL_SMG;
		if(GetCifri(text) > 8 || CheckString(text)){
			Player[playerid][pMuted] = true;
			Player[playerid][pMuteTime] += 5;
			if(!LanglePlayer{playerid})
				SendClientMessage(playerid,-1, ""SERVER_MSG"Вам автоматически отключен чат на 5 минут! Причина: Подозрение на рекламу.");
			else
				SendClientMessage(playerid,-1, ""SERVER_MSG"It is forbidden to send messages for 5 minutes! Reason: Suspicion on advertizing.");
			return false;
		}else if(BadWords[playerid] > 5){
			BadWords[playerid] = 0;
			Player[playerid][pMuted] = true;
			Player[playerid][pMuteTime] += 5;
			if(!LanglePlayer{playerid})
				SendClientMessage(playerid,-1, ""SERVER_MSG"Вам автоматически отключен чат на 5 минут! Причина: Мат.");
			else
				SendClientMessage(playerid,-1, ""SERVER_MSG"It is forbidden to send messages for 5 minutes! Reason: Censorship.");
			return false;
		}
		new sovpal;
		if(strlens == sizemsg[playerid][0])
		    sovpal++;
		if(text[0] == textmsg[playerid][0] && text[0] != '#' && text[0] != '@')
		    sovpal++;
		if(strlens > 2)
			if(text[strlens-1] == textmsg[playerid][1])
		    	sovpal++;
		if(strlens > 6)
			if(text[4] == textmsg[playerid][2])
		    	sovpal++;
		if(sovpal > 3)
			if(!LanglePlayer{playerid})
				return SendClientMessage(playerid,-1, ""SERVER_MSG"Данное сообщение слишком похоже на предыдущее."),false;
			else
				return SendClientMessage(playerid,-1, ""SERVER_MSG"This message is too similar to the previous."),false;
		if(text[0] == '!'){
			format(string, sizeof(string), "[!] %s: {FFFFFF}%s", Player[playerid][PlayerName], text[1]);
			SendInWorldMessage(playerid,30,string,-1);
			SetPlayerChatBubble(playerid,text[1],-1,20.0,10000);
			return 0;
		}
		#if defined OSNOVNOI_SERV
		if (Player[playerid][pTimeOnlineD] <1 && Player[playerid][pTimeOnlineH] < 1 && Player[playerid][pTimeOnline] < 5){
			if(!LanglePlayer{playerid}){
				SendClientMessage(playerid, -1, ""SERVER_MSG"Извините, Вам рано использовать данную функцию! Необходимое время - 5 минут.");
				SendClientMessage(playerid, -1, ""SERVER_MSG"Если у Вас проблемы, введите /help, или задайте вопрос с помощью \"/ask\".");
				return false;
			}else{
				SendClientMessage(playerid, -1, ""SERVER_MSG"Excuse, to you early to use this function! Necessary time - 5 minutes.");
				SendClientMessage(playerid, -1, ""SERVER_MSG"If you have problems, enter /help, or ask a question through \"/ask\".");
				return false;
			}
		}
		#endif
		NameString(playerid,text);
		sizemsg[playerid][0] = strlens;
		textmsg[playerid][0] = text[0];
		if(strlens > 2)
			textmsg[playerid][1] = text[strlens-1];
		if(strlens > 6)
			textmsg[playerid][2] = text[4];
	}
	return 0;
}
split(const strsrc[], strdest[][], delimiter){
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
		if(strsrc[i]==delimiter || i==strlen(strsrc)){
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return true;
}
createAccount(playerid, password[]) {
	new qString[512];
	new strdate[11], year, month, day;
	getdate(year, month, day);
	format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
	format(qString, sizeof qString, "INSERT INTO "TABLE_ACC" \
	(`Nickname`,`Password`,`Money`,`Score`,`Pos_x`,`Pos_y`,`Pos_z`,`Pos_f`,`Skin`,`RegDate`,`Speedom`,`Int`,`Virt`,`ChangeNickName` \
	) VALUES ('%s','%s','50000','0','1711.350219','1460.810791', '10.400911','163.757095','299','%s','1','0','0','2')"
	, Player[playerid][PlayerName], password, strdate);
	//=========================================================================
	Player[playerid][pColor][1] = 	1;
	Player[playerid][cWheels][1] = 	-1;
	Player[playerid][pVinil][1]= 	-1;
	Player[playerid][pColorTwo][1]= 0;
	Player[playerid][pAuto][1] =    562;
	Player[playerid][pAPos_x][1] = 	1711.350219;
	Player[playerid][pAPos_y][1] = 	1460.810791;
	Player[playerid][pAPos_z][1] = 	10.400911;
	Player[playerid][pAPos_a][1] = 	163.757095;
	Player[playerid][cWorld][1] = 0;
	//=========================================================================
	mysql_function_query(MYSQL, qString, false, "searchID", "i", playerid);
	Player[playerid][logged] = true;
	//=========================================================================
	Player[playerid][pPos][0] =		1711.350219;
	Player[playerid][pPos][1] =		1460.810791;
	Player[playerid][pPos][2] =		10.400911;
	Player[playerid][pPos][3] =		163.757095;
	Player[playerid][pBanned] 	= 	false;
	Player[playerid][pVIP] 		= 	false;
	Player[playerid][pMuted] 	= 	false;
	Player[playerid][pJail] 	= 	false;
	Player[playerid][pDoubleDrift]=	false;
	Player[playerid][pNoCrash] = 	false;
	Player[playerid][pRepair] = 	true;
	Player[playerid][pTags] =	 	false;
	Player[playerid][pInt] = 		0;
	Player[playerid][pVirt] = 		0;
	Player[playerid][pSkin] = 		299;
	Player[playerid][pBonus_d] = 	0;
	Player[playerid][pComboDays] = 	0;
	Player[playerid][pSpeedom] = 	2;
	Player[playerid][pPmStatus] = 	0;
	Player[playerid][pDoubleDriftT]=0;
	Player[playerid][pNoCrashTime] =0;
	Player[playerid][pJTime] = 		0;
	Player[playerid][pCheater] = 	0;
	Player[playerid][pVcar] = 		1;
	Player[playerid][pMuteTime] = 	0;
	Player[playerid][pJailAdm] = 	0;
	Player[playerid][pMutedAdm] = 	0;
	Player[playerid][pCarslots] = 	3;
	Player[playerid][pColorScore] = 3;
	Player[playerid][pAdminPlayer]= 0,
	Player[playerid][pTimeOnline]= 	0;
	Player[playerid][pTimeOnlineH]= 0;
	Player[playerid][pTimeOnlineD]= 0;
	Player[playerid][pLevel] = 		1;
	address[playerid] = GetAddres(playerid);
	DaiEmyDeneg(playerid,50000);
	for(new f = 2; f < MAX_VEHICLES_FOR_PLAYER; f++){
		Player[playerid][pVinil][f] = -1;
		Player[playerid][pColor][f] = 1;
		Player[playerid][pColorTwo][f] = 0;
		Player[playerid][pAuto][f] = 0;
		Player[playerid][cGidravlika][f] = 0;
		Player[playerid][cWheels][f] = -1;
		Player[playerid][pAPos_x][f] = 0;
		Player[playerid][pAPos_y][f] = 0;
		Player[playerid][pAPos_z][f] = 0;
		Player[playerid][pAPos_a][f] = 0;
		Player[playerid][cWorld][f] = 0;
		pNumber[f][playerid] = "";
	}
	PlayerTextDrawHide(playerid,Loggeds[playerid]);
	bigdialog ="";
	if(!LanglePlayer{playerid}){
		strcat(bigdialog, "{FFFFFF}\t\t----| Используйте меню: |----\n");
		strcat(bigdialog, "Большинство функций сервера есть в меню\n");
		strcat(bigdialog, "\tчтобы оно открылось нужно\n");
		if(Player[playerid][pKeyMenu])
			strcat(bigdialog, "\t\tНажать кнопку \"{00f5da}Alt / 2{FFFFFF}\"\n");
		else
			strcat(bigdialog, "\t\tНажать кнопку \"{00f5da}Y{FFFFFF}\"\n");
		strcat(bigdialog, "\t\t----| Дополнительно: |----\n");
		strcat(bigdialog, "\"{00f5da}/topmoney{FFFFFF}\"\t\t[TOP] Самых богатых людей на сервере\n");
		strcat(bigdialog, "\"{00f5da}/toplevel{FFFFFF}\"\t\t[TOP] Игроков по уровням\n");
		strcat(bigdialog, "\"{00f5da}/count (3-10){FFFFFF}\"\t\tОтсчет\n");
		strcat(bigdialog, "\"{00f5da}/f{FFFFFF}\"\t\t\tПеревернуть авто [Флипнуть]\n");
		strcat(bigdialog, "\"{00f5da}/drag (1-2){FFFFFF}\"\t\tТелепорт на драг трассы\n");
		strcat(bigdialog, "\"{00f5da}/drift (1-16){FFFFFF}\"\t\tТелепорт на дрифт трассы\n");
		strcat(bigdialog, "\"{00f5da}/dt (0-99){FFFFFF}\"\t\tСменить виртуальный мир\n");
		strcat(bigdialog, "\"{00f5da}/ct (0-1000){FFFFFF}\"\t\tСменить чат комнату\n");
		strcat(bigdialog, "\"{00f5da}/alldt{FFFFFF}\"\t\t\tОбщий виртуальный мир\n");
		strcat(bigdialog, "\"{00f5da}/textur{FFFFFF}\"\t\tВернуть текстуры [на случай если пропадут]\n");
		strcat(bigdialog, "\"{00f5da}/kill{FFFFFF}\"\t\t\tСамоубийство\n");
		strcat(bigdialog, "\"{00f5da}/time{FFFFFF}\"\t\t\tВремя: Кастов, Остатка VIP, Ареста\n");
		strcat(bigdialog, "\"{00f5da}/admins{FFFFFF}\"\t\tСписок администраторов\n");
		strcat(bigdialog, "\"{00f5da}/vips{FFFFFF}\"\t\t\t"TEXT_CLAN_11" о VIP\n");
		strcat(bigdialog, "\"{00f5da}/kickme{FFFFFF}\"\t\tКикнуть себя\n");
		strcat(bigdialog, "\"{00f5da}/help{FFFFFF}\"\t\t\tПомощь по серверу\n");
		strcat(bigdialog, "\"{00f5da}/ask{FFFFFF}\"\t\t\tВопрос по игре\n");
		strcat(bigdialog, "\"{00f5da}/rules{FFFFFF}\"\t\tПравила сервера\n");
		strcat(bigdialog, "\"{00f5da}/ccme{FFFFFF}\"\t\tОчистить свой чат\n");
		strcat(bigdialog, "\"{00f5da}/moove{FFFFFF}\"\t\tРежим Moovie [Режим для снятия видео]\n");
		strcat(bigdialog, "\"{00f5da}/mystat{FFFFFF}\"\t\tСтатистика аккаунта\n");
		strcat(bigdialog, "\"{00f5da}/remov (ID){FFFFFF}\"\t\tВыгнать человека из авто\n");
		strcat(bigdialog, "\"{00f5da}/ob (text){FFFFFF}\"\t\tПодать объявление\n");
		strcat(bigdialog, "\"{00f5da}/givecash{FFFFFF}\"\t\tПередать деньги\n");
		strcat(bigdialog, "\"{00f5da}/mydt{FFFFFF}\"\t\t\tУзнать свой виртуальный мир");
		ShowPlayerDialog(playerid, START_INFO_DIALOG, DIALOG_STYLE_MSGBOX, "HELP по серверу", bigdialog, "Ок", "");
	}else{
		strcat(bigdialog, "{FFFFFF}\t\t----| Used menu: |----\n");
		strcat(bigdialog, "The majority of functions of the server is in the menu\n");
		strcat(bigdialog, "\tit would open it is necessary\n");
		if(Player[playerid][pKeyMenu])
			strcat(bigdialog, "\t\tTo press the button \"{00f5da}Alt / 2{FFFFFF}\"\n");
		else
			strcat(bigdialog, "\t\tTo press the button \"{00f5da}Y{FFFFFF}\"\n");
		strcat(bigdialog, "\t\t----| Additional: |----\n");
		strcat(bigdialog, "\"{00f5da}/topmoney{FFFFFF}\"\t\t[TOP] The richest people on the server\n");
		strcat(bigdialog, "\"{00f5da}/toplevel{FFFFFF}\"\t\t[TOP] Players on levels\n");
		strcat(bigdialog, "\"{00f5da}/count (3-10){FFFFFF}\"\t\tCount\n");
		strcat(bigdialog, "\"{00f5da}/f{FFFFFF}\"\t\t\tTo turn a car [flipped]\n");
		strcat(bigdialog, "\"{00f5da}/drag (1-2){FFFFFF}\"\t\tTeleport on route drags\n");
		strcat(bigdialog, "\"{00f5da}/drift (1-16){FFFFFF}\"\t\tTeleport on a route drift\n");
		strcat(bigdialog, "\"{00f5da}/dt (0-99){FFFFFF}\"\t\tTo replace the virtual world\n");
		strcat(bigdialog, "\"{00f5da}/ct (0-1000){FFFFFF}\"\t\tTo replace a chat the room\n");
		strcat(bigdialog, "\"{00f5da}/alldt{FFFFFF}\"\t\t\tGeneral virtual world\n");
		strcat(bigdialog, "\"{00f5da}/textur{FFFFFF}\"\t\tTo return textures [on a case if are gone]\n");
		strcat(bigdialog, "\"{00f5da}/kill{FFFFFF}\"\t\t\tSuicide\n");
		strcat(bigdialog, "\"{00f5da}/time{FFFFFF}\"\t\t\tTime: Additions, Residual VIP, Arresting\n");
		strcat(bigdialog, "\"{00f5da}/admins{FFFFFF}\"\t\tList of administrators\n");
		strcat(bigdialog, "\"{00f5da}/vips{FFFFFF}\"\t\t\tInformation about the VIP\n");
		strcat(bigdialog, "\"{00f5da}/kickme{FFFFFF}\"\t\tKick itself\n");
		strcat(bigdialog, "\"{00f5da}/help{FFFFFF}\"\t\t\tHelp with the server\n");
		strcat(bigdialog, "\"{00f5da}/ask{FFFFFF}\"\t\t\tAsk on game\n");
		strcat(bigdialog, "\"{00f5da}/rules{FFFFFF}\"\t\tServer rules\n");
		strcat(bigdialog, "\"{00f5da}/ccme{FFFFFF}\"\t\tTo clear the chat\n");
		strcat(bigdialog, "\"{00f5da}/moove{FFFFFF}\"\t\tThe Moovie mode [A mode for video removal]\n");
		strcat(bigdialog, "\"{00f5da}/mystat{FFFFFF}\"\t\tStatistics of an account\n");
		strcat(bigdialog, "\"{00f5da}/remov (ID){FFFFFF}\"\t\tTo expel the person from a car\n");
		strcat(bigdialog, "\"{00f5da}/ob (text){FFFFFF}\"\t\tTo give declaration\n");
		strcat(bigdialog, "\"{00f5da}/givecash{FFFFFF}\"\t\tTo transfer money\n");
		strcat(bigdialog, "\"{00f5da}/mydt{FFFFFF}\"\t\tTo learn the virtual world");
		ShowPlayerDialog(playerid, START_INFO_DIALOG, DIALOG_STYLE_MSGBOX, "HELP on the server", bigdialog, "Ok", "");
	}
	//=========================================================================
	UpdateScoreSystem(playerid);
	Player[playerid][pColorPlayer] = random(sizeof(PlayerColors));
	SetPlayerColor(playerid, PlayerColors[Player[playerid][pColorPlayer]]);
	return true;
}
public searchID(playerid) {
	new qString[128];
	format(qString, sizeof qString, "SELECT `id` FROM "TABLE_ACC" WHERE `Nickname`='%s'", Player[playerid][PlayerName]);	
	mysql_function_query(MYSQL, qString, true, "searchIDFinish", "i", playerid);
}
public loadmashines(playerid,uid){
	new msgconnect[128];
	format(msgconnect, sizeof msgconnect, "SELECT * FROM "CARS_TABLE" WHERE `cOwner`= %d", uid);
	mysql_function_query(MYSQL, msgconnect, true, "LoadCars", "i", playerid);
	return true;
}
public searchIDFinish(playerid) {
	new rows, fields;
	cache_get_data(rows, fields);
	if(rows) {
		new buffer[20];
		cache_get_field_content(0, "id", buffer);
		Player[playerid][pSQLID] = strval(buffer);
		new msgsend[512];
	 	format(msgsend,sizeof(msgsend),"INSERT INTO  `messages` ( `pUID`, `Msg`,`MsgTheard`) VALUES ( %i,'{FFFFFF}Рады тебя видеть у нас, надеемся тебе у нас понравится.\nЕсли у тебя есть промокод, введи его в меню \"Донат\"\nОн находится в меню \"Настройки\".','{FFFFFF}Добро пожаловать %s!')",
	  		Player[playerid][pSQLID],
			Player[playerid][PlayerName]
		);
	 	mysql_function_query(MYSQL,msgsend, true, "UpdateIDm", "i",playerid);
	   	msgsend = "";
		format(msgsend, sizeof(msgsend),"INSERT INTO "CARS_TABLE" ( `cModel`, `cPos_x`, `cPos_y`, `cPos_z`, `cPos_a`, `cVirtWorld`, `cVinil`, `cColorOne`, `cColorTwo`, `cOwner`) VALUES ( 562,1711.35,1460.81,10.40,163.75,0,-1,1,0,%d)",
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, msgsend, true, "UpdateCarUID", "id",playerid,1);
		format(msgsend, sizeof msgsend, "UPDATE "TABLE_ACC" SET `Online` = '1' WHERE `id`='%i'",
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, msgsend, false, "", "");
		SaveAccount(playerid);
}	}
public CreateCars(playerid){
	if(!IsPlayerConnected(playerid))
		return true;
	if(!LoadCarsEx[playerid]){
		SetTimerEx("CreateCars", 300, false, "d",playerid);
		return true;
	}
	new Float:xv,Float:yv,Float:zv;
	if(Player[playerid][pVcar]){
		new f = Player[playerid][pVcar];
		if(f > MAX_VEHICLES_FOR_PLAYER)
			f = GetCarSlotForUID(playerid,Player[playerid][pVcar]);
		if(f){
			if(!Player[playerid][pAPos_x][f] && !Player[playerid][cWorld][f])
				return true;
			xv = Player[playerid][pAPos_x][f];
			yv = Player[playerid][pAPos_y][f];
			zv = Player[playerid][pAPos_z][f]+1;
			pvehs[f][playerid] = t_CreateVehicle(Player[playerid][pAuto][f],xv,yv,zv,Player[playerid][pAPos_a][f],Player[playerid][pColor][f],Player[playerid][pColorTwo][f],-1);
			SetVehicleNumberPlate(pvehs[f][playerid],pNumber[f][playerid]);
			SetVehicleZAngle(pvehs[f][playerid],Player[playerid][pAPos_a][f]);
			if(Player[playerid][pVinil][f] >= 0) ChangeVehiclePaintjob(pvehs[f][playerid],Player[playerid][pVinil][f]);			
			if(Player[playerid][cGidravlika][f])
				AddVehicleComponent(pvehs[f][playerid], 1087);
			if(Player[playerid][cWheels][f] != -1)
				AddVehicleComponent(pvehs[f][playerid], Wheels[Player[playerid][cWheels][f]]);	
			if(Player[playerid][cWorld][f] != 1024)
				SetVehicleVirtualWorld(pvehs[f][playerid],Player[playerid][cWorld][f]);
			t_PutPlayerInVehicle(playerid, pvehs[f][playerid]);
		}
	}
	for(new f = 1; f < carsEx[playerid]+1; f++)
	{
		if(f > MAX_VEHICLES_FOR_PLAYER)
			break;
		if(!Player[playerid][pAuto][f] || Player[playerid][pVcar] == f) continue;
		if(!Player[playerid][pAPos_x][f] && !Player[playerid][cWorld][f]) continue;
		xv = Player[playerid][pAPos_x][f];
		yv = Player[playerid][pAPos_y][f];
		zv = Player[playerid][pAPos_z][f]+0.5;
		pvehs[f][playerid] = t_CreateVehicle(Player[playerid][pAuto][f],xv,yv,zv,Player[playerid][pAPos_a][f],Player[playerid][pColor][f],Player[playerid][pColorTwo][f],-1);
		SetVehicleNumberPlate(pvehs[f][playerid],pNumber[f][playerid]);
		SetVehicleZAngle(pvehs[f][playerid],Player[playerid][pAPos_a][f]);
		if(Player[playerid][pVinil][f] >= 0) ChangeVehiclePaintjob(pvehs[f][playerid],Player[playerid][pVinil][f]);
		if(Player[playerid][cGidravlika][f])
			AddVehicleComponent(pvehs[f][playerid], 1087);
		if(Player[playerid][cWheels][f] != -1)
			AddVehicleComponent(pvehs[f][playerid], Wheels[Player[playerid][cWheels][f]]);	
		if(Player[playerid][cWorld][f] != 1024)
			SetVehicleVirtualWorld(pvehs[f][playerid],Player[playerid][cWorld][f]);
	}
	return true;
}
protected UpdateClanTagEx(clankey){
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f))continue;
		if(GetSlotClan(f,clankey) != -1)
			UpdateNick(f);
	}
	return true;
}
protected UpdateNick(playerid){
	new nick[24],
		clanid;
	if(Player[playerid][cClan][0] != INVALID_CLAN_ID && Player[playerid][cRate][0]){
		clanid = ReturnClotBD(Player[playerid][cClan][0]);
		strcat(nick,skobka1[ClanInfo[clanid][cTypeSkobok]]);
		strcat(nick,ClanInfo[clanid][cTag]);
		strcat(nick,skobka2[ClanInfo[clanid][cTypeSkobok]]);
	}
	strcat(nick,Player[playerid][PlayerName]);
	if(Player[playerid][cClan][1] != INVALID_CLAN_ID && Player[playerid][cRate][1]){
		clanid = ReturnClotBD(Player[playerid][cClan][1]);
		strcat(nick,skobka1[ClanInfo[clanid][cTypeSkobok]]);
		strcat(nick,ClanInfo[clanid][cTag]);
		strcat(nick,skobka2[ClanInfo[clanid][cTypeSkobok]]);
	}
	if(strlen(nick) > 3)
		SetPlayerName(playerid,nick);
	return true;
}
public loadAccount(playerid) {
	Player[playerid][logged] = true;
	SetPlayerScore(playerid,Player[playerid][pLevel]);
	new qString[75];
	format(qString, sizeof qString, "SELECT * FROM  "TABLE_CLANS_P" WHERE `cUID` = %d LIMIT 2", Player[playerid][pSQLID]);
	mysql_function_query(MYSQL, qString, true, "LoadClansPlayer", "d",playerid); 		
	UpdateScoreSystem(playerid);
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,Player[playerid][pCashPlayer]);
	SetSpawnInfo(playerid,0,Player[playerid][pSkin],Player[playerid][pPos][0],Player[playerid][pPos][1],Player[playerid][pPos][2]+1,Player[playerid][pPos][3]);
	Streamer_UpdateEx(playerid, Player[playerid][pPos][0],Player[playerid][pPos][1],Player[playerid][pPos][2], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	TogglePlayerSpectating(playerid, false);
	SetPlayerColor(playerid, PlayerColors[Player[playerid][pColorPlayer]]);
	UpdateIDfb(playerid,INVALID_PLAYER_ID);
	UpdateIDm(playerid);
	PlayerTextDrawHide(playerid,Loggeds[playerid]);
	new msgconnect[100],
		msgconnectEn[100];
	format(msgconnect,sizeof msgconnect,""SERVER_MSG"{%s}%s{FFFFFF} зашел на сервер.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
	format(msgconnectEn,sizeof msgconnectEn,""SERVER_MSG"{%s}%s{FFFFFF} joined to server.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f))continue;
		if(f == playerid)
			continue;
		if(IsFrende(f,playerid)){
			if(!LanglePlayer{f})
				SendClientMessage(f, -1, msgconnect);
			else
				SendClientMessage(f, -1, msgconnectEn);
		}
	}
	format(msgconnect, sizeof msgconnect, "UPDATE "TABLE_ACC" SET `Online` = '1' WHERE `id`='%i'",
		Player[playerid][pSQLID]
	);
	mysql_function_query(MYSQL, msgconnect, false, "", "");
	new qString2[156];
	new day = getdate();
	if(!LanglePlayer{playerid}){
		if(!Player[playerid][pBonus_d] || Player[playerid][pBonus_d] != day && Player[playerid][pBonus_d]){
			if(Player[playerid][pBonus_d] == day-1 || day < Player[playerid][pBonus_d] && Player[playerid][pBonus_d] >= 365)
				Player[playerid][pComboDays]++;
			else
				Player[playerid][pComboDays] = 0;
			SendClientMessage(playerid, -1, "");
			if(Player[playerid][pComboDays] >= 6){
				Player[playerid][pComboDays] = 0;
				Player[playerid][pDonatM]++;
				SendClientMessage(playerid, -1, ""SERVER_MSG"Твой бонус за вход 7 дней подряд - 1 DM!");
			}else if(Player[playerid][pComboDays] == 5){
				DaiEmyDeneg(playerid,50000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Твой бонус за вход 6 дней подряд - $100 000!");
			}else if(Player[playerid][pComboDays] == 4){
				DaiEmyDeneg(playerid,40000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Твой бонус за вход 5 дней подряд - $75 000!");
			}else if(Player[playerid][pComboDays] == 3){
				DaiEmyDeneg(playerid,30000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Твой бонус за вход 4 дня подряд - $50 000!");
			}else if(Player[playerid][pComboDays] == 2){
				DaiEmyDeneg(playerid,10000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Твой бонус за вход 3 дня подряд - $25 000!");
			}else if(Player[playerid][pComboDays] == 1){
				DaiEmyDeneg(playerid,5000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Твой бонус за вход 2 дня подряд - $10 000!");
			}
			Player[playerid][pBonus_d] = day;
			if(GetInLevelTop(playerid)){
				new bonus = 200000/GetInLevelTop(playerid);
				DaiEmyDeneg(playerid,bonus);
				format(qString2, sizeof qString2, ""SERVER_MSG"Твоя позиция в ТОПе по уровню: %d, бонус: $%d.",GetInLevelTop(playerid),bonus);
				SendClientMessage(playerid, -1, qString2);
			}
			if(GetInMoneyTop(playerid)){
				new bonus = 200000/GetInMoneyTop(playerid);
				DaiEmyDeneg(playerid,bonus);
				format(qString2, sizeof qString2, ""SERVER_MSG"Твоя позиция в ТОПе богачей: %d, бонус: $%d.",GetInMoneyTop(playerid),bonus);
				SendClientMessage(playerid, -1, qString2);
			}
		}else{
			if(GetInLevelTop(playerid)){
				format(qString2, sizeof qString2, ""SERVER_MSG"Твоя позиция в ТОПе по уровню: %d.",GetInLevelTop(playerid));
				SendClientMessage(playerid, -1, qString2);
			}
			if(GetInMoneyTop(playerid)){
				format(qString2, sizeof qString2, ""SERVER_MSG"Твоя позиция в ТОПе богачей: %d.",GetInMoneyTop(playerid));
				SendClientMessage(playerid, -1, qString2);
		}	}
	}else{
		if(!Player[playerid][pBonus_d] || Player[playerid][pBonus_d] != day && Player[playerid][pBonus_d]){
			if(Player[playerid][pBonus_d] == day-1 || day < Player[playerid][pBonus_d] && Player[playerid][pBonus_d] >= 365)
				Player[playerid][pComboDays]++;
			else
				Player[playerid][pComboDays] = 0;
			SendClientMessage(playerid, -1, "");
			if(Player[playerid][pComboDays] >= 6){
				Player[playerid][pComboDays] = 0;
				Player[playerid][pDonatM]++;
				SendClientMessage(playerid, -1, ""SERVER_MSG"Your bonus for an entrance of 7 days in a row - 1 DM!");
			}else if(Player[playerid][pComboDays] == 5){
				DaiEmyDeneg(playerid,50000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Your bonus for an entrance of 6 days in a row - $100 000!");
			}else if(Player[playerid][pComboDays] == 4){
				DaiEmyDeneg(playerid,40000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Your bonus for an entrance of 5 days in a row - $75 000!");
			}else if(Player[playerid][pComboDays] == 3){
				DaiEmyDeneg(playerid,30000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Your bonus for an entrance of 4 days in a row - $50 000!");
			}else if(Player[playerid][pComboDays] == 2){
				DaiEmyDeneg(playerid,20000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Your bonus for an entrance of 3 days in a row - $25 000!");
			}else if(Player[playerid][pComboDays] == 1){
				DaiEmyDeneg(playerid,10000);
				SendClientMessage(playerid, -1, ""SERVER_MSG"Your bonus for an entrance of 2 days in a row - $10 000!");
			}
			Player[playerid][pBonus_d] = day;
			if(GetInLevelTop(playerid)){
				new bonus = 200000/GetInLevelTop(playerid);
				DaiEmyDeneg(playerid,bonus);
				format(qString2, sizeof qString2, ""SERVER_MSG"Your position in the TOP on level: %d, bonus: $%d.",GetInLevelTop(playerid),bonus);
				SendClientMessage(playerid, -1, qString2);
			}
			if(GetInMoneyTop(playerid)){
				new bonus = 200000/GetInMoneyTop(playerid);
				DaiEmyDeneg(playerid,bonus);
				format(qString2, sizeof qString2, ""SERVER_MSG"Your position in the TOP of rich: %d, bonus: $%d.",GetInMoneyTop(playerid),bonus);
				SendClientMessage(playerid, -1, qString2);
			}
		}else{
			if(GetInLevelTop(playerid)){
				format(qString2, sizeof qString2, ""SERVER_MSG"Your position in the TOP on level: %d.",GetInLevelTop(playerid));
				SendClientMessage(playerid, -1, qString2);
			}
			if(GetInMoneyTop(playerid)){
				format(qString2, sizeof qString2, ""SERVER_MSG"Your position in the TOP of rich: %d.",GetInMoneyTop(playerid));
				SendClientMessage(playerid, -1, qString2);
	}	}	}
	for(new i; i < strlen(Player[playerid][PlayerName])-1; i++){
		switch(Player[playerid][PlayerName][i]){
			case '0'..'9','a'..'z','A'..'Z','.': continue;
			default:{	
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!", "Далее", "" );
				else
					ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
				break;
			}
		}
	}
	return LoadAkk(playerid);
}
ShowMenuForPlayerEx(playerid){
	minidialog = "";
	if(!LanglePlayer{playerid}){
		strcat(minidialog,TEXT_MENU);
		if(messages[playerid] + playerszayavkinses[playerid]){
			new msgs[20];
			format(msgs,sizeof(msgs)," {ff0000}[%d]",messages[playerid] + playerszayavkinses[playerid]); // playerszayavkinses[playerid] // noactivetedfrends[playerid]
			strcat(minidialog,msgs);
		}
		if(rRaceStatusEx[playerid] != STATUS_RACE_WAIT)
			strcat(minidialog,"\n"STRELKIEX"Поиск соперника для дуэли");
		else
			strcat(minidialog,"\n"STRELKIEX"Выйти из очереди");
		return ShowPlayerDialog(playerid, 228, DIALOG_STYLE_LIST, ""MENU_PRFX"", minidialog, "Выбрать", "Выход"),true;
	}else{
		strcat(minidialog,TEXT_MENU_EN);
		if(messages[playerid] + playerszayavkinses[playerid]){
			new msgs[20];
			format(msgs,sizeof(msgs)," {ff0000}[%d]",messages[playerid] + playerszayavkinses[playerid]); // playerszayavkinses[playerid] // noactivetedfrends[playerid]
			strcat(minidialog,msgs);
		}
		if(rRaceStatusEx[playerid] != STATUS_RACE_WAIT)
			strcat(minidialog,"\n"STRELKIEX"Search of the rival for duel");
		else
			strcat(minidialog,"\n"STRELKIEX"To quit queue");
		return ShowPlayerDialog(playerid, 228, DIALOG_STYLE_LIST, ""MENU_PRFX_EN"", minidialog, "Select", "Close"),true;
}   }
ShowAllTeleports(playerid){
	if(!LanglePlayer{playerid})
		return ShowPlayerDialog(playerid, TELEPORTS, DIALOG_STYLE_LIST, ""MENU_PRFX_TP"", TELE_TEXT, "Выбрать", "Назад"),true;
	else
		return ShowPlayerDialog(playerid, TELEPORTS, DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN"", TELE_TEXT_EN, "Select", "Back"),true;
}
ShowMenuChar(playerid){
	if(!LanglePlayer{playerid})
		return ShowPlayerDialog(playerid, 8, DIALOG_STYLE_LIST, ""MENU_PRFX_PrsMnu"", TEXT_PLAYER_MENU, "OK", "Назад");
	else
		return ShowPlayerDialog(playerid, 8, DIALOG_STYLE_LIST, ""MENU_PRFX_PrsMnu_EN"", TEXT_PLAYER_MENU_EN, "Ok", "Back");
}
protected ReloadRecords(){
	rDateReloadRecords = getdate();
	mysql_function_query(MYSQL, "UPDATE `rRaceInfo` SET `rRecord`=0,`rRecorderUID`=0,`rRecorder`='NULL'", false, "", "");
	mysql_function_query(MYSQL, "UPDATE `records` SET `rRecordScore`=100,`rRecordTime`=60,`rRecordCombo`=20.0,`rRecordScoreName`='NULL',`rRecordTimeName`='NULL',`rRecordComboName`='NULL',`rRecordScoreUID`=0,`rRecordTimeUID`=0,`rRecordComboUID`=0", false, "", "");
	rRecordScore = 100;
	rRecordScoreUID = 0;
	rRecordTime = 60;
	rRecordTimeUID = 0;
	rRecordCombo = 20.0;
	rRecordComboUID = 0;
	for(new i = 0; i < RACE_TRACKS; i++){
		RaceInfo[i][Record] = 0;
		RaceInfo[i][RecordsmanUID] = 0;
		format(RaceInfo[i][Recordsman],MAX_PLAYER_NAME,"%s","NULL");
	}
	new savecar[70];
	format(savecar, sizeof savecar, "UPDATE `records` SET `rDateReloadRecords`= '%d'",rDateReloadRecords);
	mysql_function_query(MYSQL, savecar, false, "", "");
	t_SendClientMessageToAll(-1, -1, ""SERVER_MSG"Рекорды сброшены!", ""SERVER_MSG"Scores are reset!");
	return true;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	for(new i=0;i<strlen(inputtext);i++)
		if(inputtext[i]=='%')
		    inputtext[i] = '#';
	#if defined OSNOVNOI_SERV
	if(GetPVarInt(playerid,"DialogID") != dialogid && dialogid || !GetPVarInt(playerid,"OpenDialog") && dialogid)
		return false;
	#endif
	SetPVarInt(playerid,"OpenDialog",0);
	if(IsPlayerInAnyVehicle(playerid)){
		GetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z);
		GetVehicleZAngle(GetPlayerVehicleID(playerid),Angle);
	}else{
		GetPlayerPos(playerid,X,Y,Z);
		GetPlayerFacingAngle(playerid,Angle);
	}
	new string[512];
	switch(dialogid)
	{
		case DIALOG_RULES:
		{
			if(!response) return true;
			bigdialog = "";
			if(listitem == 0){
				if(!LanglePlayer{playerid}){
					strcat(bigdialog, "{FFFFFF}\t\tПравила игрового сервера "SERVER_NAME"\n");
					strcat(bigdialog, "1) НЕ использовать программы/читы/настройки игрового клиента дающие преимущество над игроками\n");
					strcat(bigdialog, "2) НЕ оскорблять игроков, их близких и родственников.\n");
					strcat(bigdialog, "3) Запрещен спам, флуд *offtop* в чат или личку\n");
					strcat(bigdialog, "4) Запрещены игр. Ники не имеющие смысла типо*abija* или Ники с нецензурной лексикой.\n");
					strcat(bigdialog, "5) Запрещено намеренно убивать игроков.\n");
					strcat(bigdialog, "6) Запрещено использовать *баг* сервера.\n");
					strcat(bigdialog, "7) Запрещены угрозы в адрес сервера/администратора.\n");
					strcat(bigdialog, "8) Запрещены попытки навредить серверу.\n");
					strcat(bigdialog, "9) Если ты снимаешь мув./ тренируешься, уйди в /dt а не проси остальных делать это.\n");
					strcat(bigdialog, "10) Запрещено попрошайничество – денег, скорэ, админки.\n");
					strcat(bigdialog, "11) Если ты увидел читера сообщи администратору НЕ в чат, а через Репорт (/rep id причина)\n");
					strcat(bigdialog, "12) Если ты устраиваешь гонки, попроси Администратора помочь тебе. Во избежание недоразумений!\n");
					strcat(bigdialog, "13) Запрещен подбор паролей через сайт.\n");
					strcat(bigdialog, "14) Запрещено обсуждение действий администратора.\n");
					strcat(bigdialog, "\t\tНезнание правил НЕ освобождает вас от ответственности\n");
				}else{
					strcat(bigdialog, "{FFFFFF}\t\t"SERVER_NAME" Rules\n");
					strcat(bigdialog, "1) Don't use programs/cheats/setup of the game client that give priority at over players\n");
					strcat(bigdialog, "2) Don't offend players, their relatives.\n");
					strcat(bigdialog, "3) Don't spam, flood *offtop* in a chat/pm\n");
					strcat(bigdialog, "4) Forbidden Nicknames, which doesn't making sense or Nicknames with obscene lexicon.\n");
					strcat(bigdialog, "5) Forbidden special kill players\n");
					strcat(bigdialog, "6) Forbidden use server bugs.\n");
					strcat(bigdialog, "7) Forbidden threats to the server/administrator.\n");
					strcat(bigdialog, "8) Forbidden attempts a herm this server.\n");
					strcat(bigdialog, "9) If you make a video/training you skill, please change your virtual world (/dt)\n");
					strcat(bigdialog, "10) Forbidden begging – money, level, admin level.\n");
					strcat(bigdialog, "11) If you saw a cheater, send report in /rep, don't write it to chat\n");
					strcat(bigdialog, "12) If you arrange races, ask the Administrator to help you.\n");
					strcat(bigdialog, "13) Forbidden selection of passwords through a site.\n");
					strcat(bigdialog, "14) Forbidden discussion of actions of the administrator.\n");
					strcat(bigdialog, "\t\tIgnorance of rules NOT exempts you from liability\n");
				}
			}else{
				for(new i; i < 3; i++){
					switch(listitem){
						case 1: strcat(bigdialog,rules_drag[i]);
						case 2: strcat(bigdialog,rules_drift[i]);
						case 3: strcat(bigdialog,rules_derby[i]);
						case 4: strcat(bigdialog,rules_poiskauto[i]);
						case 5: strcat(bigdialog,rules_probeg[i]);
						case 6: strcat(bigdialog,rules_dd[i]);
						case 7: strcat(bigdialog,rules_tochka[i]);
			}	}	}
			if(!LanglePlayer{playerid})
				ShowPlayerDialog(playerid, DIALOG_RULES+1, DIALOG_STYLE_MSGBOX, "Правила", bigdialog, "Назад", "");
			else
				ShowPlayerDialog(playerid, DIALOG_RULES+1, DIALOG_STYLE_MSGBOX, "Rules", bigdialog, "Back", "");
		}
	case DIALOG_RULES+1:
		ShowPlayerDialog(playerid,DIALOG_RULES,DIALOG_STYLE_LIST,"Правила","{ffffff}Правила сервера "SERVER_NAME"\n{ffffff}Правила мероприятия:\tДРАГ\nПравила мероприятия:\tДРИФТ\n{ffffff}Правила мероприятия:\tДЕРБИ\n{ffffff}Правила мероприятия:\tПОИСК АВТО\n{ffffff}Правила мероприятия:\tАВТО ПРОБЕГ\n{ffffff}Правила мероприятия:\tДРИФТ ДУЭЛЬ\n{ffffff}Правила мероприятия:\tДОБЕРИСЬ ДО ТОЧКИ","Выбрать","Отмена");
	case BAN_DIALOG:
		return true;
	case CLAN_DIALOG+16:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new slotEx = GetSlotClan(playerid,usedkeyclan[playerid]);
		if(listitem == 0 &&	Player[playerid][cRate][slotEx] > 1)
			UpdateRate(useduid[playerid],usedkeyclan[playerid],1);
		else if(listitem == 1 &&	Player[playerid][cRate][slotEx] > 2)
			UpdateRate(useduid[playerid],usedkeyclan[playerid],2);
		else if(listitem == 2 &&	Player[playerid][cRate][slotEx] > 3)
			UpdateRate(useduid[playerid],usedkeyclan[playerid],3);
		else if(listitem == 3 &&	Player[playerid][cRate][slotEx] > 4)
			UpdateRate(useduid[playerid],usedkeyclan[playerid],4);
		else{
			msgcheat = "";
			if(Player[playerid][cRate][slotEx] > 1) strcat(msgcheat,"{7df9ff}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],1));
			strcat(msgcheat,"\n");
			if(Player[playerid][cRate][slotEx] > 2) strcat(msgcheat,"{ffff00}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],2));
			strcat(msgcheat,"\n");
			if(Player[playerid][cRate][slotEx] > 3) strcat(msgcheat,"{2fff00}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],3));
			strcat(msgcheat,"\n");
			if(Player[playerid][cRate][slotEx] > 4) strcat(msgcheat,"{0000ff}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],4));	
			ShowPlayerDialog(playerid,CLAN_DIALOG+16,DIALOG_STYLE_LIST,"Изменение ранга",msgcheat,"Выбрать","Отмена");
		}
		return true;
	}
	case CLAN_DIALOG+15:{
		if(!response) return ShowClanMembers(playerid,usedkeyclan[playerid]);
		new slotEx = GetSlotClan(playerid,usedkeyclan[playerid]),
			clanid = ReturnClotBD(usedkeyclan[playerid]),
			mogetkickat,
			mogetpovishat;
		if(slotEx != -1){
			mogetkickat = (Player[playerid][cRate][slotEx] > 1)?ClanInfo[clanid][cKick][Player[playerid][cRate][slotEx]]:0,
			mogetpovishat = (Player[playerid][cRate][slotEx] > 1)?ClanInfo[clanid][cRangUP][Player[playerid][cRate][slotEx]]:0;
		}
		if(listitem == 0)
			ShowPlayerInfoToUID(playerid,useduid[playerid]);
		else if(listitem == 1){
			if(slotEx == -1 || Player[playerid][cRate][slotEx] <= usedrang[playerid] || !mogetkickat){
				if(slotEx == -1)
					SendClientMessage(playerid,-1,""SERVER_MSG"Вы не состоите в данном клане.");
				else if(mogetkickat == -1)
					SendClientMessage(playerid,-1,""SERVER_MSG"У Вас нету прав на исключения из клана.");
				else
					SendClientMessage(playerid,-1,""SERVER_MSG"У Вас слишком низкий ранг для исключения данного игрока.");
				return true;
			}
			KickPlayerFromClan(useduid[playerid],usedkeyclan[playerid]);
		}else if(listitem == 2){
			if(slotEx == -1 || Player[playerid][cRate][slotEx] <= usedrang[playerid] || !mogetpovishat){
				if(slotEx == -1)
					SendClientMessage(playerid,-1,""SERVER_MSG"Вы не состоите в данном клане");
				else if(mogetpovishat == -1)
					SendClientMessage(playerid,-1,""SERVER_MSG"У Вас нету прав на повышение ранга в клане.");
				else
					SendClientMessage(playerid,-1,""SERVER_MSG"У Вас слишком низкий ранг для изменения ранга данного игрока.");
				return true;
			}
			msgcheat = "";
			if(Player[playerid][cRate][slotEx] > 1) strcat(msgcheat,"{7df9ff}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],1));
			strcat(msgcheat,"\n");
			if(Player[playerid][cRate][slotEx] > 2) strcat(msgcheat,"{ffff00}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],2));
			strcat(msgcheat,"\n");
			if(Player[playerid][cRate][slotEx] > 3) strcat(msgcheat,"{2fff00}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],3));
			strcat(msgcheat,"\n");
			if(Player[playerid][cRate][slotEx] > 4) strcat(msgcheat,"{0000ff}");
			else strcat(msgcheat,"{808080}");
			strcat(msgcheat,ReturnRateClan(usedkeyclan[playerid],4));	
			ShowPlayerDialog(playerid,CLAN_DIALOG+16,DIALOG_STYLE_LIST,"Изменение ранга",msgcheat,"Выбрать","Отмена");
		}
		return true;
	}
	case CLAN_DIALOG+14:{
		if(!response || !listitem) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new nameX[MAX_PLAYER_NAME],
			getprobele;
		strcat(nameX,inputtext[9]);
		for (new i; i < strlen(nameX); i++){
			switch(nameX[i]){
				case '	': {getprobele = i;break;}
				default: continue;
			}
		}
		strdel(nameX,getprobele,strlen(inputtext));
		useduid[playerid] = strval(inputtext[1]);
		usedrang[playerid] = strval(inputtext[getprobele+11]);
		msgcheat = "";
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
		strcat(msgcheat,ReturnClanTag(clanid));
		strcat(msgcheat,""STRELKI"Состав"STRELKI"");
		strcat(msgcheat,nameX);
		new slotEx = GetSlotClan(playerid,usedkeyclan[playerid]);
		msgcheatEn = "";
		strcat(msgcheatEn,"{FFFFFF}"TEXT_CLAN_11"\n{FFFFFF}");
		if(slotEx == -1 || Player[playerid][cRate][slotEx] <= usedrang[playerid])
	        strcat(msgcheatEn,"{808080}");
		strcat(msgcheatEn,"Исключить из клана\n{FFFFFF}");
		if(slotEx == -1 || Player[playerid][cRate][slotEx] <= usedrang[playerid])
	        strcat(msgcheatEn,"{808080}");
		strcat(msgcheatEn,"Изменить звание");
		ShowPlayerDialog(playerid,CLAN_DIALOG+15,DIALOG_STYLE_LIST,msgcheat,msgcheatEn,"Выбрать","Отмена");
		return true;
	}		
	case CLAN_DIALOG+13:{
		if(!response)
			KickPlayerFromClan(Player[playerid][pSQLID],usedkeyclan[playerid]);
		else{
			UpdateRate(Player[playerid][pSQLID],usedkeyclan[playerid],1);
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} вступил в клан %s{FFFFFF}.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],ReturnClanTag(ReturnClotBD(usedkeyclan[playerid])));
			SendClanMessage(usedkeyclan[playerid],msgcheat);
		}
		return true;
	}
	case CLAN_DIALOG:{
		if(!response) return ShowMenuForPlayerEx(playerid),true;
		if(listitem == MAX_CLANS_ON_PLAYER)
			return ShowPlayerDialog(playerid, CLAN_DIALOG+1, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Поиск", "Введите тег клана, или его часть. Не более 3х символов.", "Далее", "Назад" );
		else if(listitem == MAX_CLANS_ON_PLAYER+1){
			mysql_function_query(MYSQL, "SELECT `cID`, `cMoney` FROM `Clans` ORDER BY `cMoney` DESC LIMIT 10", true, "TopClansMoney", "d", playerid);
			return true;
		}
		else if(listitem == MAX_CLANS_ON_PLAYER+2){
			mysql_function_query(MYSQL, "SELECT `cID`, `cRate` FROM `Clans` ORDER BY `cRate` DESC LIMIT 10", true, "TopClansStrong", "d", playerid);
			return true;
		}
		else if(Player[playerid][cClan][listitem]){
			usedkeyclan[playerid] = Player[playerid][cClan][listitem];
			new clanid = ReturnClotBD(usedkeyclan[playerid]);
			if(!Player[playerid][cRate][listitem]){
				msgcheat = "";
				strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
				strcat(msgcheat,ReturnClanTag(clanid));
				strcat(msgcheat,""STRELKI"Вступление");
				format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}Вас пригласили в клан: {%s}%s%s%s{FFFFFF}.\nВступить в клан?.",chatcolor[ClanInfo[clanid][cColour]],skobka1[ClanInfo[clanid][cTypeSkobok]],ClanInfo[clanid][cTag],skobka2[ClanInfo[clanid][cTypeSkobok]]);
				ShowPlayerDialog(playerid,CLAN_DIALOG+13,DIALOG_STYLE_MSGBOX,msgcheat,msgcheatEn,"Да","Нет");
				return true;
			}
			ShowClanDialog(playerid,CLAN_DIALOG+2,clanid);
			return true;
		}else{ 
			if(GetPlayerCash(playerid) < PRICE_CLAN)
				return ShowPlayerDialog(playerid,CLAN_DIALOG+4,DIALOG_STYLE_MSGBOX,""MENU_PRFX_Klani""STRELKI"Ошибка","{FFFFFF}Извините, у вас недостаточно денег для создания клана.\nДля создания клана необходимо $1000000.","Стартуем",""),true;
			if(Player[playerid][pLevel] < 20)
				return ShowPlayerDialog(playerid,CLAN_DIALOG+4,DIALOG_STYLE_MSGBOX,""MENU_PRFX_Klani""STRELKI"Ошибка","{FFFFFF}Извините, у вас недостаточный уровень для создания клана.\nДля создания клана необходим 20-й уровень.","Стартуем",""),true;
			ShowPlayerDialog(playerid, CLAN_DIALOG+3, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Создание", "{FFFFFF}Введите тег клана. От 2 до 5 букв/цифр.\nКрайне не советуем занимать теги чужих кланов, клан будет отобран без возврата денег.", "Далее", "Назад" );
		}
		ShowPlayerDialog(playerid, CLAN_DIALOG+3, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Создание", "{FFFFFF}Введите тег клана. От 2 до 5 букв/цифр.", "Далее", "Назад" );
		return true;
	}	
	case CLAN_DIALOG+1:{
		if(!response) return ShowPlayerClans(playerid);
		new NaidenoClanov,
			searhed[256];
		if(strlen(inputtext) < 1 || strlen(inputtext) > 3)
			return ShowPlayerDialog(playerid, CLAN_DIALOG+1, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Поиск", "Введите тег клана, или его часть. Не более 3х символов.", "Далее", "Назад" );
		for(new i; i < MAX_CLANS; i++){
			if(ClanInfo[i][cCreator] != 0){
				if(strfind(ClanInfo[i][cTag],inputtext,true) != -1){
					format(searhed,sizeof(searhed),"%s{FFFFFF}%d] {00f5da}%04d %s\n",searhed,NaidenoClanov+1,ClanInfo[i][cKey],ReturnClanTag(i));
					NaidenoClanov++;
		}	}	}
		if(!NaidenoClanov)
			ShowPlayerDialog(playerid,CLAN_DIALOG-2,DIALOG_STYLE_MSGBOX,""MENU_PRFX_Klani""STRELKI"Поиск","{FFFFFF}Совпадений не найдено.","Назад","");
		else
			ShowPlayerDialog(playerid, CLAN_DIALOG+22, DIALOG_STYLE_LIST, ""MENU_PRFX_Klani""STRELKI"Поиск", searhed, "Выбрать", "Назад" );
		return true;
	}	
	case CLAN_DIALOG+22:{
		if(!response) return ShowPlayerClans(playerid);
		usedkeyclan[playerid] = strval(inputtext[3]);
		ShowClanDialog(playerid,CLAN_DIALOG+2);
		return true;
	}
	case CLAN_DIALOG+24:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		if(strval(inputtext) < 0 || strval(inputtext) > MAX_PLAYERS){
			ShowPlayerDialog(playerid, CLAN_DIALOG+24, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Админ функции", "{FFFFFF}Введите ID человека которому отдать клан.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Не верный ID."),true;
		}
		if(!IsPlayerConnected(strval(inputtext))){
			ShowPlayerDialog(playerid, CLAN_DIALOG+24, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Админ функции", "{FFFFFF}Введите ID человека которому отдать клан.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Указанный ID не в сети."),true;
		}
		if(SearchNoOwnedSlot(strval(inputtext)) == -1){
			ShowPlayerDialog(playerid, CLAN_DIALOG+24, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Админ функции", "{FFFFFF}Введите ID человека которому отдать клан.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Данный игрок уже стоит в максимальном кол-ве кланов."),true;
		}
		if(GetSlotClan(strval(inputtext),usedkeyclan[playerid])	!= -1){
			ShowPlayerDialog(playerid, CLAN_DIALOG+24, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Админ функции", "{FFFFFF}Введите ID человека которому отдать клан.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Данный игрок уже стоит в этом клане или его уже пригласили."),true;
		}	
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		KickPlayerFromClan(ClanInfo[clanid][cCreator],usedkeyclan[playerid]);
		AddPlayerInClan(strval(inputtext),usedkeyclan[playerid],5);
		ClanInfo[clanid][cCreator] = Player[strval(inputtext)][pSQLID];
		new query[112];
		format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cCreator` = '%d',`cCreatorName` = '%s' WHERE `cID` = %d;",
			ClanInfo[clanid][cCreator],
			Player[strval(inputtext)][PlayerName],
			usedkeyclan[playerid]
		);
		mysql_function_query(MYSQL, query, false, "", "");
		return true;
	}
	case CLAN_DIALOG+17:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		if(strval(inputtext) < 0 || strval(inputtext) > MAX_PLAYERS || strval(inputtext) == playerid){
			ShowPlayerDialog(playerid, CLAN_DIALOG+17, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Приглашение в клан", "{FFFFFF}Введите ID человека которого вы хотите пригласить.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Не верный ID."),true;
		}
		if(!IsPlayerConnected(strval(inputtext))){
			ShowPlayerDialog(playerid, CLAN_DIALOG+17, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Приглашение в клан", "{FFFFFF}Введите ID человека которого вы хотите пригласить.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Указанный ID не в сети."),true;
		}
		if(SearchNoOwnedSlot(strval(inputtext)) == -1){
			ShowPlayerDialog(playerid, CLAN_DIALOG+17, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Приглашение в клан", "{FFFFFF}Введите ID человека которого вы хотите пригласить.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Данный игрок уже стоит в максимальном кол-ве кланов."),true;
		}
		if(GetSlotClan(strval(inputtext),usedkeyclan[playerid])	!= -1){
			ShowPlayerDialog(playerid, CLAN_DIALOG+17, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Приглашение в клан", "{FFFFFF}Введите ID человека которого вы хотите пригласить.", "Далее", "Отмена" );
			return SendClientMessage(playerid,-1,""SERVER_MSG"Данный игрок уже стоит в этом клане или его уже пригласили."),true;
		}
		format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} пригласил Вас в клан %s{FFFFFF}. Принять приглашение можно в меню \"Кланы\".",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],ReturnClanTag(ReturnClotBD(usedkeyclan[playerid])));
		SendClientMessage(strval(inputtext),-1,msgcheat);
		AddPlayerInClan(strval(inputtext),usedkeyclan[playerid],0);
		return true;
	}
	case CLAN_DIALOG+19:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+18);
		new clanid = ReturnClotBD(usedkeyclan[playerid]),
			slotEx = GetSlotClan(playerid,usedkeyclan[playerid]);
		if(strval(inputtext) < 1 || ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]] && Player[playerid][cRate][slotEx] < 5 && ((ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]]-Player[playerid][cMoneys][slotEx]-strval(inputtext)) < 0) || (ClanInfo[clanid][cMoney] - strval(inputtext)) < 0){
			if(strval(inputtext) < 1)
				SendClientMessage(playerid,-1,""SERVER_MSG"Кол-во денег не может быть меньше 1.");
			else if(ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]] == -1)
				SendClientMessage(playerid,-1,""SERVER_MSG"Вам запрещено снимать наличные.");
			else if(Player[playerid][cRate][slotEx] < 5 && ((ClanInfo[clanid][cMaxMoneys][Player[playerid][cRate][slotEx]]-strval(inputtext)) < 0))
				SendClientMessage(playerid,-1,""SERVER_MSG"Ограничение ранга не позволяет снять такое кол-во денег.");
			else
				SendClientMessage(playerid,-1,""SERVER_MSG"В Банке нет такого кол-ва денег.");
			ShowClanDialog(playerid,CLAN_DIALOG+19,clanid);
			return true;
		}
		GiveClanMoney(usedkeyclan[playerid],-strval(inputtext));
		new msgsend[256];
	 	format(msgsend,sizeof(msgsend),"INSERT INTO  `BankLog` ( `lClanID`, `lDate`, `lText`, `lNick`) VALUES (%d,%d,'снял %d$.','%s')",
	  		usedkeyclan[playerid],
			gettime(),
			strval(inputtext),
			Player[playerid][PlayerName]
		);
	 	mysql_function_query(MYSQL,msgsend, false, "", "");
		DaiEmyDeneg(playerid,strval(inputtext));
		Player[playerid][cMoneys][slotEx] += strval(inputtext);
		Player[playerid][cMDay][slotEx]=getdate();
		new query[128];
		format(query, sizeof(query),"UPDATE  "TABLE_CLANS_P" SET `cMoneys` = '%d',`cMDay` = '%d' WHERE `cClanID` = %d && `cUID` = %d",
			Player[playerid][cMoneys][slotEx],
			Player[playerid][cMDay][slotEx],
			Player[playerid][cClan][slotEx],
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, query, false, "", "");
		ShowClanDialog(playerid,CLAN_DIALOG+19);
		return true;
	}
	case CLAN_DIALOG+20:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+18);
		if(strval(inputtext) < 1 || (GetPlayerCash(playerid)-strval(inputtext)) < 0){
			if(strval(inputtext) < 1)
				SendClientMessage(playerid,-1,""SERVER_MSG"Кол-во денег не может быть меньше 1.");
			else
				SendClientMessage(playerid,-1,""SERVER_MSG"У Вас недостаточно денег.");
			ShowClanDialog(playerid,CLAN_DIALOG+20);
			return true;
		}
		GiveClanMoney(usedkeyclan[playerid],strval(inputtext));
		new msgsend[256];
	 	format(msgsend,sizeof(msgsend),"INSERT INTO  `BankLog` ( `lClanID`, `lDate`, `lText`, `lNick`) VALUES (%d,%d,'положил %d$.','%s')",
	  		usedkeyclan[playerid],
			gettime(),
			strval(inputtext),
			Player[playerid][PlayerName]
		);
	 	mysql_function_query(MYSQL,msgsend, false, "", "");
		DaiEmyDeneg(playerid,-strval(inputtext));
		ShowClanDialog(playerid,CLAN_DIALOG+20);
		return true;
	}
	case CLAN_DIALOG+18:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		if(listitem == 0)
			ShowClanDialog(playerid,CLAN_DIALOG+19);
		else if(listitem == 1)
			ShowClanDialog(playerid,CLAN_DIALOG+20);
		else if(listitem == 2)
			ShowBankLog(playerid,usedkeyclan[playerid]);
		return true;
	}
	case CLAN_DIALOG-3:{
		if(!response) return ShowPlayerClans(playerid);
		format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} покинул клан %s{FFFFFF}.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],ReturnClanTag(ReturnClotBD(usedkeyclan[playerid])));
		SendClanMessage(usedkeyclan[playerid],msgcheat);
		KickPlayerFromClan(Player[playerid][pSQLID],usedkeyclan[playerid]);
	}
	case CLAN_DIALOG-2:
		ShowPlayerClans(playerid);
	case CLAN_DIALOG-1:
		ShowClanDialog(playerid,CLAN_DIALOG+2);
	case CLAN_DIALOG+2:{
		if(!response) return ShowPlayerClans(playerid);
		new clanid = ReturnClotBD(usedkeyclan[playerid]),
			slotEx = GetSlotClan(playerid,usedkeyclan[playerid]),
			mogetinvait;
		if(slotEx != -1)
			mogetinvait = (Player[playerid][cRate][slotEx] > 1)?ClanInfo[clanid][cInvite][Player[playerid][cRate][slotEx]]:0;
		if(listitem == 0){
			ShowClanInfo(playerid,usedkeyclan[playerid]);
		}else if(listitem == 1){
			ShowClanMembers(playerid,usedkeyclan[playerid]);
		}else if(listitem == 2){
			if(slotEx == -1 && Player[playerid][pAdminPlayer] < 5) return SendClientMessage(playerid,-1,""SERVER_MSG"Ошибка доступа."),ShowClanDialog(playerid,CLAN_DIALOG+2);
			ShowClanDialog(playerid,CLAN_DIALOG+18,clanid);
		}else if(listitem == 3){
			if(slotEx == -1 || !mogetinvait) return SendClientMessage(playerid,-1,""SERVER_MSG"Ошибка доступа."),ShowClanDialog(playerid,CLAN_DIALOG+2);
			ShowPlayerDialog(playerid, CLAN_DIALOG+17, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Приглашение в клан", "{FFFFFF}Введите ID человека которого вы хотите пригласить.", "Далее", "Отмена" );
		}else if(listitem == 4){
			if(slotEx == -1 || Player[playerid][cRate][slotEx] < 4) return SendClientMessage(playerid,-1,""SERVER_MSG"Ошибка доступа."),ShowClanDialog(playerid,CLAN_DIALOG+2);
			minidialog = "";
			msgcheat = "";
			strcat(minidialog,"Изменить спавн\nИзменить тег\t\t");
			strcat(minidialog,ReturnClanTag(clanid));
			strcat(minidialog,"\nИзменить цвет тега\nИзменить рамки тега\nНастройка званий\nУдалить клан");
			strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление");
			ShowPlayerDialog(playerid, CLAN_DIALOG+5,DIALOG_STYLE_LIST,msgcheat,minidialog,"Выбрать","Отмена");
		}else if(listitem == 5){
			if(slotEx == -1 || Player[playerid][cRate][slotEx] == 5) return SendClientMessage(playerid,-1,""SERVER_MSG"Вы не можете покинуть данный клан."),ShowClanDialog(playerid,CLAN_DIALOG+2);
			msgcheatEn = "";
			msgcheat = "";
			strcat(msgcheatEn,"{FFFFFF}Вы уверены что хотите покинуть клан ");
			strcat(msgcheatEn,ReturnClanTag(clanid));
			strcat(msgcheatEn,"{FFFFFF} ?");
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Покинуть клан");
			ShowPlayerDialog(playerid, CLAN_DIALOG-3,DIALOG_STYLE_MSGBOX,msgcheat,msgcheatEn,"Да","Отмена");
		}else if(listitem == 6){
			if(Player[playerid][pAdminPlayer] < 5) return true;
			ShowPlayerDialog(playerid, CLAN_DIALOG+24, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Админ функции", "{FFFFFF}Введите ID человека которому отдать клан.", "Далее", "Отмена" );
		}if(listitem == 7){
			if(Player[playerid][pAdminPlayer] < 5) return true;
			msgcheat = "";
			msgcheatEn = "";
			strcat(msgcheatEn,"{FFFFFF}Вы действительно хотите безвозвратно удалить клан ");
			strcat(msgcheatEn,ReturnClanTag(clanid));
			strcat(msgcheatEn,"{FFFFFF} ?");
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Удаление");
			ShowPlayerDialog(playerid, CLAN_DIALOG+23,DIALOG_STYLE_MSGBOX,msgcheat,msgcheatEn,"Да","Отмена");
		}
	}	
	case CLAN_DIALOG+3:{
		if(!response) return ShowPlayerClans(playerid);
		new bool:nebukva;
		for (new i; i < strlen(inputtext); i++){
			switch(inputtext[i]){
				case 'а'..'я','А'..'Я','a'..'z','A'..'Z','0'..'9','@': continue;
				default: {nebukva = true; break;}
			}
		}
		for(new i; i < MAX_CLANS; i++){
			if(ClanInfo[i][cCreator] != 0){
				if(ClanInfo[i][cCreator] == Player[playerid][pSQLID]){
					ShowPlayerClans(playerid);
					SendClientMessage(playerid,-1,""SERVER_MSG"Вы уже являетесь создателем клана.");
					return true;
				}
				else if(!strcmp(ClanInfo[i][cTag],inputtext, true)){
					ShowPlayerDialog(playerid, CLAN_DIALOG+3, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Создание", "{FFFFFF}Введите тег клана. От 2 до 6 букв/цифр.", "Далее", "Отмена" );
					SendClientMessage(playerid,-1,""SERVER_MSG"Данный тег уже занят.");
					return true;
		}	}	}
		if(strlen(inputtext) > 5 || strlen(inputtext) < 2 || nebukva){
			ShowPlayerDialog(playerid, CLAN_DIALOG+3, DIALOG_STYLE_INPUT, ""MENU_PRFX_Klani""STRELKI"Создание", "{FFFFFF}Введите тег клана. От 2 до 6 букв/цифр.", "Далее", "Отмена" );
			return true;
		}
		DaiEmyDeneg(playerid,-PRICE_CLAN);
		CreateClan(playerid,inputtext);
	}
	case CLAN_DIALOG+4:
		ShowPlayerClans(playerid);	
	case CLAN_DIALOG+8:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new bool:nebukva,
			clanid = ReturnClotBD(usedkeyclan[playerid]);
		for (new i; i < strlen(inputtext); i++){
			switch(inputtext[i]){
				case 'а'..'я','А'..'Я','a'..'z','A'..'Z','0'..'9','@': continue;
				default: {nebukva = true; break;}
			}
		}
		for(new i; i < MAX_CLANS; i++){
			if(ClanInfo[i][cCreator] != 0){
				if(!strcmp(ClanInfo[i][cTag],inputtext, true)){
					SendClientMessage(playerid,-1,""SERVER_MSG"Данный тег уже занят.");
					nebukva = true;
					break;
		}	}	}
		if(strlen(inputtext) > 6 || strlen(inputtext) < 2 || nebukva){
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Смена тега");
			format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}В данный момент тег: %s{FFFFFF} .\nВведите новый тег. От 2 до 6 букв/цифр.",ReturnClanTag(clanid));
			ShowPlayerDialog(playerid, CLAN_DIALOG+8, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
			return true;
		}
		UpdateClanTag(usedkeyclan[playerid],inputtext);
		return true;
	}
	case CLAN_DIALOG+21:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		if(listitem == 0)
			PlayerGoToBase(playerid,usedkeyclan[playerid]);
		else if(listitem == 1){
			new Float:PosEx[3];
			GetPlayerPos(playerid,PosEx[0],PosEx[1],PosEx[2]);
			UpdateClanSpawn(usedkeyclan[playerid],PosEx[0],PosEx[1],PosEx[2]);
		}
		ShowClanDialog(playerid,CLAN_DIALOG+2);
		return true;
	}
	case CLAN_DIALOG+5:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		if(listitem == 0){
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Спавн");
			ShowPlayerDialog(playerid, CLAN_DIALOG+21,DIALOG_STYLE_LIST,msgcheat,"{FFFFFF}Телепорт на место спавна\n{FFFFFF}Поставить спавн на текущую позицию.","Выбрать","Отмена");
		}else if(listitem == 1){
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Смена тега");
			format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}В данный момент тег: %s{FFFFFF} .\nВведите новый тег. От 2 до 5 букв/цифр.",ReturnClanTag(clanid));
			ShowPlayerDialog(playerid, CLAN_DIALOG+8, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
		}else if(listitem == 2){
			ChowClanColorPanel(playerid,clanid);
		}else if(listitem == 3){
			msgcheatEn = "";
			for(new i; i < sizeof(skobka1); i++){
				if(i)
					strcat(msgcheatEn,"\n");
				strcat(msgcheatEn,"{");
				strcat(msgcheatEn,chatcolor[ClanInfo[clanid][cColour]]);
				strcat(msgcheatEn,"}");
				strcat(msgcheatEn,skobka1[i]);
				strcat(msgcheatEn,ClanInfo[clanid][cTag]);
				strcat(msgcheatEn,skobka2[i]);
			}
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Ограничители");
			ShowPlayerDialog(playerid, CLAN_DIALOG+11,DIALOG_STYLE_LIST,msgcheat,msgcheatEn,"Выбрать","Отмена");
		}else if(listitem == 4){
			minidialog = "";
			strcat(minidialog,ReturnColorRateClan(usedkeyclan[playerid],1));
			strcat(minidialog,"\n");
			strcat(minidialog,ReturnColorRateClan(usedkeyclan[playerid],2));
			strcat(minidialog,"\n");
			strcat(minidialog,ReturnColorRateClan(usedkeyclan[playerid],3));
			strcat(minidialog,"\n");
			strcat(minidialog,ReturnColorRateClan(usedkeyclan[playerid],4));
			strcat(minidialog,"\n");
			strcat(minidialog,ReturnColorRateClan(usedkeyclan[playerid],5));
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Звания");
			ShowPlayerDialog(playerid, CLAN_DIALOG+7,DIALOG_STYLE_LIST,msgcheat,minidialog,"Выбрать","Отмена");
		}else if(listitem == 5){
			msgcheat = "";
			msgcheatEn = "";
			strcat(msgcheatEn,"{FFFFFF}Вы действительно хотите безвозвратно удалить клан ");
			strcat(msgcheatEn,ReturnClanTag(clanid));
			strcat(msgcheatEn,"{FFFFFF} ?");
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Удаление");
			ShowPlayerDialog(playerid, CLAN_DIALOG+23,DIALOG_STYLE_MSGBOX,msgcheat,msgcheatEn,"Да","Отмена");
		}
		return true;
	}
	case CLAN_DIALOG+23:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		KickAllFromClan(usedkeyclan[playerid]);
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		ClanInfo[clanid][cKey] = 0;
		ClanInfo[clanid][cCreator] = 0;
		ClanInfo[clanid][cPlayers] = 0;
		ClanInfo[clanid][cColour] = 0;
		ClanInfo[clanid][cTypeSkobok] = 0;
		format(ClanInfo[clanid][cTag],7,"%s","");
		format(ClanInfo[clanid][cRate1],13,"%s","");
		format(ClanInfo[clanid][cRate2],13,"%s","");
		format(ClanInfo[clanid][cRate3],13,"%s","");
		format(ClanInfo[clanid][cRate4],13,"%s","");
		format(ClanInfo[clanid][cRate5],13,"%s","");
		ClanInfo[clanid][cMoney] = 0;
		ClanInfo[clanid][cRate] = 0;
		ClanInfo[clanid][cMaxMoneys][1] = 0;
		ClanInfo[clanid][cMaxMoneys][2] = 0;
		ClanInfo[clanid][cMaxMoneys][3] = 0;
		ClanInfo[clanid][cMaxMoneys][4] = 0;
		ClanInfo[clanid][cMaxMoneys][5] = 0;
		ClanInfo[clanid][cInvite][1] = 0;
		ClanInfo[clanid][cInvite][2] = 0;
		ClanInfo[clanid][cInvite][3] = 0;
		ClanInfo[clanid][cInvite][4] = 0;
		ClanInfo[clanid][cInvite][5] = 0;
		ClanInfo[clanid][cKick][1] = 0;
		ClanInfo[clanid][cKick][2] = 0;
		ClanInfo[clanid][cKick][3] = 0;
		ClanInfo[clanid][cKick][4] = 0;
		ClanInfo[clanid][cKick][5] = 0;
		ClanInfo[clanid][cRangUP][1] = 0;
		ClanInfo[clanid][cRangUP][2] = 0;
		ClanInfo[clanid][cRangUP][3] = 0;
		ClanInfo[clanid][cRangUP][4] = 0;
		ClanInfo[clanid][cRangUP][5] = 0;
		return true;
	}
	case CLAN_DIALOG+7:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		usedrateclan[playerid] = listitem+1;
		ShowClanDialog(playerid,CLAN_DIALOG+6);
		return true;
	}
	case CLAN_DIALOG+9:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+6);
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		if(strval(inputtext) < 10000 || strval(inputtext) > 1000000){
			msgcheat = "";
			strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Звания");
			format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}В данный момент лимит снятия наличных для \"%s{FFFFFF}\": {0033CC}[Off]{FFFFFF}.\nВведите ограничение на снятие наличных.\n\tОт 10к до 1кк.",ReturnColorRateClan(usedkeyclan[playerid],usedrateclan[playerid]));
			ShowPlayerDialog(playerid, CLAN_DIALOG+9, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
			return true;
		}
		ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] = strval(inputtext);
		new query[112];
		format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cMaxMoneys%d` = '%d' WHERE `cID` = %d;",
			usedrateclan[playerid],
			strval(inputtext),
			usedkeyclan[playerid]
		);
		mysql_function_query(MYSQL, query, false, "", "");	
		ShowClanDialog(playerid,CLAN_DIALOG+6);
		return true;
	}
	case CLAN_DIALOG+12:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+6);
		new bool:nebukva,
			clanid = ReturnClotBD(usedkeyclan[playerid]);
		for (new i; i < strlen(inputtext); i++){
			switch(inputtext[i]){
				case 'а'..'я','А'..'Я','a'..'z','A'..'Z','0'..'9',',',' ': continue;
				default: {nebukva = true; break;}
			}
		}
		if(strlen(inputtext) > 12 || strlen(inputtext) < 3 || nebukva){
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Звания");
			format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}В данный момент звание: %s{FFFFFF}.\nВведите новое звание. От 3 до 12 букв/цифр.",ReturnColorRateClan(usedkeyclan[playerid],usedrateclan[playerid]));
			ShowPlayerDialog(playerid, CLAN_DIALOG+12, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
			return true;
		}
		ShangeRateClan(usedkeyclan[playerid],usedrateclan[playerid],inputtext);
		ShowClanDialog(playerid,CLAN_DIALOG+6);
		return true;
	}
	case CLAN_DIALOG+6:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		if(listitem == 0){
			msgcheat = "";
			strcat(msgcheat,"{FFFFFF}..."STRELKI"");
			strcat(msgcheat,ReturnClanTag(clanid));
			strcat(msgcheat,""STRELKI"Управление"STRELKI"Звания");
			format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}В данный момент звание: %s{FFFFFF}.\nВведите новое звание. От 3 до 10 букв/цифр.",ReturnColorRateClan(usedkeyclan[playerid],usedrateclan[playerid]));
			ShowPlayerDialog(playerid, CLAN_DIALOG+12, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
			return true;
		}
		new query[112];
		if(listitem == 1){
			if(usedrateclan[playerid] == 5) return ShowClanDialog(playerid,CLAN_DIALOG+6);
			if(ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] == -1){
				msgcheat = "";
				strcat(msgcheat,""MENU_PRFX_Klani""STRELKI"");
				strcat(msgcheat,ReturnClanTag(clanid));
				strcat(msgcheat,""STRELKI"Управление"STRELKI"Звания");
				format(msgcheatEn,sizeof(msgcheatEn),"{FFFFFF}В данный момент лимит снятия наличных для \"%s{FFFFFF}\": {0033CC}[Off]{FFFFFF}.\nВведите ограничение на снятие наличных.\n\tОт 10к до 1кк.",ReturnColorRateClan(usedkeyclan[playerid],usedrateclan[playerid]));
				ShowPlayerDialog(playerid, CLAN_DIALOG+9, DIALOG_STYLE_INPUT, msgcheat, msgcheatEn, "Далее", "Отмена" );
			}else if(ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] > 0){
				ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] = 0;
				format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cMaxMoneys%d` = '0' WHERE `cID` = %d;",
					usedrateclan[playerid],
					usedkeyclan[playerid]
				);
				mysql_function_query(MYSQL, query, false, "", "");	
				ShowClanDialog(playerid,CLAN_DIALOG+6);
			}else if(ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] == 0){
				ClanInfo[clanid][cMaxMoneys][usedrateclan[playerid]] = -1;
				format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cMaxMoneys%d` = '-1' WHERE `cID` = %d;",
					usedrateclan[playerid],
					usedkeyclan[playerid]
				);
				mysql_function_query(MYSQL, query, false, "", "");	
				ShowClanDialog(playerid,CLAN_DIALOG+6);
			}
		}
		else if(listitem == 2){
			if(usedrateclan[playerid] == 5) return true;
			if(ClanInfo[clanid][cInvite][usedrateclan[playerid]])
				ClanInfo[clanid][cInvite][usedrateclan[playerid]] = 0;
			else
				ClanInfo[clanid][cInvite][usedrateclan[playerid]] = 1;
			format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cInvite%d` = '%d' WHERE `cID` = %d;",
				usedrateclan[playerid],
				ClanInfo[clanid][cInvite][usedrateclan[playerid]],
				usedkeyclan[playerid]
			);
			mysql_function_query(MYSQL, query, false, "", "");
			ShowClanDialog(playerid,CLAN_DIALOG+6);
		}else if(listitem == 3){
			if(usedrateclan[playerid] == 5 || usedrateclan[playerid] == 1) return ShowClanDialog(playerid,CLAN_DIALOG+6);
			if(ClanInfo[clanid][cKick][usedrateclan[playerid]])
				ClanInfo[clanid][cKick][usedrateclan[playerid]] = 0;
			else
				ClanInfo[clanid][cKick][usedrateclan[playerid]] = 1;
			format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cKick%d` = '%d' WHERE `cID` = %d;",
				usedrateclan[playerid],
				ClanInfo[clanid][cKick][usedrateclan[playerid]],
				usedkeyclan[playerid]
			);
			mysql_function_query(MYSQL, query, false, "", "");	
			ShowClanDialog(playerid,CLAN_DIALOG+6);
		}else if(listitem == 4){
			if(usedrateclan[playerid] == 5 || usedrateclan[playerid] == 1) return ShowClanDialog(playerid,CLAN_DIALOG+6);
			if(ClanInfo[clanid][cRangUP][usedrateclan[playerid]])
				ClanInfo[clanid][cRangUP][usedrateclan[playerid]] = 0;
			else
				ClanInfo[clanid][cRangUP][usedrateclan[playerid]] = 1;
			format(query, sizeof(query),"UPDATE "TABLE_CLANS" SET `cRangUP%d` = '%d' WHERE `cID` = %d;",
				usedrateclan[playerid],
				ClanInfo[clanid][cRangUP][usedrateclan[playerid]],
				usedkeyclan[playerid]
			);
			mysql_function_query(MYSQL, query, false, "", "");
			ShowClanDialog(playerid,CLAN_DIALOG+6);	
		}
	}
	case CLAN_DIALOG+10:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		if(strval(inputtext) > (sizeof(PlayerColors)-1) || strval(inputtext) < 0) return ChowClanColorPanel(playerid,clanid);
		new color = ((!strval(inputtext))?random(sizeof(PlayerColors)):strval(inputtext));
		ClanInfo[clanid][cColour] = color;
		UpdClanColor(usedkeyclan[playerid],color);
		ChowClanColorPanel(playerid,clanid);
	}
	case CLAN_DIALOG+11:{
		if(!response) return ShowClanDialog(playerid,CLAN_DIALOG+2);
		new clanid = ReturnClotBD(usedkeyclan[playerid]);
		ClanInfo[clanid][cTypeSkobok] = listitem;
		ShangeSkobkiClan(usedkeyclan[playerid],listitem);
	}
	case DIALOG_SUMMON:
		{
			SendClientMessage(SumID[playerid], COLOR_WHITE, ""SERVER_MSG"Игрок отменил предложение!");
			WaitSum[SumID[playerid]] = false;
			WaitSum[playerid] = false;
			SumID[SumID[playerid]] = INVALID_PLAYER_ID;
			SumID[playerid] = INVALID_PLAYER_ID;
		}
	case 1:
		{
			if(response) // проверка на кнопку "ОК" и Enter
			{
				if(strlen(inputtext) < 6 || strlen(inputtext) > 20 || strfind(inputtext,"/",true) != -1){
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Регистрация", "{FFFFFF}Пожалуйста, придумайте {ffff00}сложный{FFFFFF} пароль,\nчто бы избежать возможного взлома вашего аккуанта,\nНе сообщайте пароль даже доверенным лицам без крайней необходимости\n\nВведите пароль:", "Дальше", "");
					else
						ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Registration", "{FFFFFF}Please, think up the {ffff00}difficult{FFFFFF} password,\nto avoid possible breaking of your account,\ndon't tell the password even to authorized representatives without emergency\n\nEnter the password:", "Select", "");
					return true;
				}
				for(new f; f < sizeof(BadPasswords); f++){
					if(!strcmp(BadPasswords[f], inputtext, true )){
						if(!LanglePlayer{playerid})
							ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Регистрация", "{FFFFFF}Пожалуйста, придумайте {ffff00}сложный{FFFFFF} пароль,\nчто бы избежать возможного взлома вашего аккуанта,\nНе сообщайте пароль даже доверенным лицам без крайней необходимости\n\nВведите пароль:", "Дальше", "");
						else
							ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Registration", "{FFFFFF}Please, think up the {ffff00}difficult{FFFFFF} password,\nto avoid possible breaking of your account,\ndon't tell the password even to authorized representatives without emergency\n\nEnter the password:", "Select", "");
						return true;	
					}
				}
				createAccount(playerid, inputtext);
			}
			else ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Регистрация", "Ты должен зарегистрироваться \n \nПридумай сложный пароль, чтобы избежать взлома аккаунта \n"STRELKIEX"Введите ваш пароль:", "Далее", "");
		}
	case 2:
		{
			new bigdialog2[112];
			if(response) // проверка на кнопку "ОК" и Enter
			{
				if(IsPlayerNPC(playerid))return true;
				if(!strlen(inputtext)){
					if(!LanglePlayer{playerid}){
						format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Здравствуйте {%s}%s{FFFFFF}, введите пароль от вашего аккаунта:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
						ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Авторизация", bigdialog2, "Войти", ""); //если он есть, то авторизуем его
					}else{
						format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Hello {%s}%s{FFFFFF}, enter the password from your account:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
						ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Authorization", bigdialog2, "Join", ""); //если он есть, то авторизуем его
					}
				    return true;
				}
				if(!strcmp(Player[playerid][PlayerPassword], inputtext, true )){
					loadAccount(playerid);
					CreateCars(playerid);
				}else{
					Player[playerid][logged] = false;
					SetPVarInt(playerid,"error",GetPVarInt(playerid,"error")+1);
					SendClientMessage(playerid, -1, "");
					if(!LanglePlayer{playerid}){
						SendClientMessage(playerid, 0xFFFFFFFF, ""SERVER_MSG"Неверный пароль! Если ты его забыл то обратитесь в скайп глав.админу{FF0000} [Alpano.]");
						SendClientMessage(playerid, 0xFFFFFFFF, ""SERVER_MSG"Проверьте, на верном ли языке стоит ваша раскладка?");
					}else{
						SendClientMessage(playerid, 0xFFFFFFFF, ""SERVER_MSG"Incorrect password! If you forgot it that address in Skype to the chief manager: {FF0000} [Alpano.]");
						SendClientMessage(playerid, 0xFFFFFFFF, ""SERVER_MSG"Check, whether in correct language there is your layout?");
					}
					if(GetPVarInt(playerid,"error") >= 3) {
						if(!LanglePlayer{playerid}){
							SendClientMessage(playerid,0xFFFFFFFF,""SERVER_MSG"Ты был кикнут за подбор пароля к аккаунту.");
							SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#15]");
						}else{
							SendClientMessage(playerid,0xFFFFFFFF,""SERVER_MSG"You were kicked for password guessing to an account.");
							SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#15]");
						}
						t_Kick(playerid);
						return true;
					}
					if(!LanglePlayer{playerid}){
						format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Здравствуйте {%s}%s{FFFFFF}, введите пароль от вашего аккаунта:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
						ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Авторизация", bigdialog2, "Войти", ""); //если он есть, то авторизуем его
					}else{
						format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Hello {%s}%s{FFFFFF}, enter the password from your account:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
						ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Authorization", bigdialog2, "Join", ""); //если он есть, то авторизуем его
					}
				}
			}else{
				Player[playerid][logged] = false;
				if(!LanglePlayer{playerid}){
					format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Здравствуйте {%s}%s{FFFFFF}, введите пароль от вашего аккаунта:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
					ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Авторизация", bigdialog2, "Войти", ""); //если он есть, то авторизуем его
				}else{
					format(bigdialog2,sizeof(bigdialog2),"{FFFFFF}Hello {%s}%s{FFFFFF}, enter the password from your account:",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
					ShowPlayerDialog(playerid,2,DIALOG_STYLE_PASSWORD, "{FFFFFF}Authorization", bigdialog2, "Join", ""); //если он есть, то авторизуем его
				}
			}
			return 0;
		}
	case DIALOG_DRIFT_RACE:
		{
			if(response && !AfkPlayer[GetDDSopernikID(playerid)]){
				rRaceStatusEx[playerid] = STATUS_ACCEPT_RACE;
				if(rRaceStatusEx[DDInfo[RaceID[playerid]][rRacer][0]] == STATUS_ACCEPT_RACE && rRaceStatusEx[DDInfo[RaceID[playerid]][rRacer][1]] == STATUS_ACCEPT_RACE){
					StartDuel(RaceID[playerid],DDInfo[RaceID[playerid]][rTrackID]);
					ShowPlayerDialog(GetDDSopernikID(playerid),-1,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5"","{FFFFFF}"DUEL_TEXT_6"","Стартуем","");
				}
				else{
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Ожидание соперника.","Подождите пока соперник примет приглашение\nЕсли вы желаете, вы можете отменить дуэль.\nВыйти из режима ожидания?","Выйти","");
					else
						ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Waiting opponent.","Wait until the opponent accepts the invitation\nIf you wish, you can cancel the duel.\nExit from idle mode?","Exit","");
				}
			}else{
				if(AfkPlayer[GetDDSopernikID(playerid)]){
					if(!LanglePlayer{GetDDSopernikID(playerid)}) SendClientMessage(GetDDSopernikID(playerid),-1,""SERVER_MSG"Cоперник ушел в AFK!"); else SendClientMessage(GetDDSopernikID(playerid),-1,""SERVER_MSG"Rival in AFK!.");
					return true;
				}
				if(rRaceStatusEx[GetDDSopernikID(playerid)] == STATUS_ACCEPT_RACE)
					ShowPlayerDialog(GetDDSopernikID(playerid),DIALOG_DRIFT_RACE+2,DIALOG_STYLE_MSGBOX,"{FFFFFF}Cоперник отказался от дуэли.","Cоперник отказался от дуэли\nЖдать другого соперника?","Ждать","Выйти");
				else{
					ShowPlayerDialog(GetDDSopernikID(playerid),-1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Cоперник отказался от дуэли.","{FFFFFF}Cоперник отказался от дуэли \"Стартуем\"","Стартуем","");
					if(!LanglePlayer{GetDDSopernikID(playerid)}) SendClientMessage(GetDDSopernikID(playerid),-1,""SERVER_MSG"Cоперник отказался от дуэли!"); else SendClientMessage(GetDDSopernikID(playerid),-1,""SERVER_MSG"Rival refused to duel!.");
				}
				rRaceStatusEx[playerid] = STATUS_NO_RACE;
				rRaceStatusEx[GetDDSopernikID(playerid)] = STATUS_NO_RACE;
				RemovDDInfo(RaceID[playerid]);
			}
			return true;
		}
	case DIALOG_DRIFT_RACE+1:
		{
			if(!response){
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Ожидание соперника.","Подождите пока соперник примет приглашение\nЕсли вы желаете, вы можете отменить дуэль.\nВыйти из режима ожидания?","Выйти","");
				else
					ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Waiting opponent.","Wait until the opponent accepts the invitation\nIf you wish, you can cancel the duel.\nExit from idle mode?","Exit","");
			}else{
				if(rRaceStatusEx[GetDDSopernikID(playerid)] == STATUS_ACCEPT_RACE)
					ShowPlayerDialog(GetDDSopernikID(playerid),DIALOG_DRIFT_RACE+2,DIALOG_STYLE_MSGBOX,"{FFFFFF}Cоперник отказался от дуэли.","Cоперник отказался от дуэли\nЖдать другого соперника?","Ждать","Выйти");
				else{
					ShowPlayerDialog(GetDDSopernikID(playerid),-1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Cоперник отказался от дуэли.","{FFFFFF}Cоперник отказался от дуэли \"Стартуем\"","Стартуем","");
					if(!LanglePlayer{GetDDSopernikID(playerid)}) SendClientMessage(GetDDSopernikID(playerid),-1,""SERVER_MSG"Cоперник отказался от дуэли!"); else SendClientMessage(GetDDSopernikID(playerid),-1,""SERVER_MSG"Rival refused to duel!.");
				}
				rRaceStatusEx[playerid] = STATUS_NO_RACE;
				rRaceStatusEx[GetDDSopernikID(playerid)] = STATUS_NO_RACE;
				RemovDDInfo(RaceID[playerid]);
			}
			return true;
		}
	case DIALOG_DRIFT_RACE+2:
		{
			if(response) rRaceStatusEx[playerid] = STATUS_RACE_WAIT;
			else rRaceStatusEx[playerid] = STATUS_NO_RACE;
			return true;
		}
	case DIALOG_DRIFT_RACE+3:	
		{
			if(!response) return true;
			new playe = clickedplayeride[playerid];
			if(rRaceStatusEx[playe] != STATUS_NO_RACE && rRaceStatusEx[playe] != STATUS_RACE_WAIT){
				if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Игрок уже в гонке."); else return SendClientMessage(playerid,-1,""SERVER_MSG"Player in race!.");
			}else if(AfkPlayer[playe]){
				if(!LanglePlayer{playerid})
					SendClientMessage(playerid,-1,""SERVER_MSG"Данный человек AFK.");
				else
					SendClientMessage(playerid,-1,""SERVER_MSG"This player in AFK.");
				return true;
			}
			new raceid = FindNoOwnedRace();
			if(raceid != -1){
				RaceID[playerid] = raceid;
				RaceID[playe] = raceid;
				rRaceStatusEx[playerid] = STATUS_ACCEPT_RACE;
				rRaceStatusEx[playe] = STATUS_SEND_ACCEPT;
				DDInfo[raceid][rTrackID] = listitem;
				DDInfo[raceid][rRaceStatus] = RACE_STAT_WAIT;
				DDInfo[raceid][rRacer][0] = playerid;
				DDInfo[raceid][rRacer][1] = playe;				
				DDInfo[raceid][rPrize] = GetPrizeDD(playe,playerid)/2;
				PrizDD[playe]=DDInfo[raceid][rPrize];
				PrizDD[playerid]=DDInfo[raceid][rPrize];
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Ожидание соперника.","Подождите пока соперник примет приглашение\nЕсли вы желаете, вы можете отменить дуэль.\nВыйти из режима ожидания?","Выйти","");
				else
					ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+1,DIALOG_STYLE_MSGBOX,"{FFFFFF}Waiting opponent.","Wait until the opponent accepts the invitation\nIf you wish, you can cancel the duel.\nExit from idle mode?","Exit","");
				if(!LanglePlayer{playe})
					format(string,sizeof(string),""SERVER_MSG"{%s}%s {FFFFFF}вызвал(а) тебя на дуэль! "TEXT_CLAN_11": \"/dd\".",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
				else
					format(string,sizeof(string),""SERVER_MSG"{%s}%s {FFFFFF}called you to a duel! information: \"/dd\".",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
				SendClientMessage(playe,-1,string);
				}else
					return SendClientMessage(playerid,-1,""SERVER_MSG"В данный момент активно слишком много гонок.");
		}	
	case START_INFO_DIALOG-2:
		{
			if(response)
				LanglePlayer{playerid} = false;			
			else
				LanglePlayer{playerid} = true;
			SetPVarInt(playerid,"Loggedtime",0);
			new timenologged[64];
			if(!LanglePlayer{playerid})
				format(timenologged,sizeof(timenologged),FixText("Осталось %d секунд."),60-GetPVarInt(playerid,"Loggedtime"));
			else
				format(timenologged,sizeof(timenologged),FixText("Were %d seconds."),60-GetPVarInt(playerid,"Loggedtime"));
			PlayerTextDrawSetString(playerid,Loggeds[playerid],timenologged);
			PlayerTextDrawShow(playerid,Loggeds[playerid]);
			if(!LanglePlayer{playerid})
				ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Регистрация", "{FFFFFF}Пожалуйста, придумайте сложный пароль,\nчто бы избежать возможного взлома вашего аккуанта,\nНе сообщайте пароль даже доверенным лицам без крайней необходимости\n\nВведите пароль:", "Дальше", "");
			else
				ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD, ""SERVER_MSG"Registration", "{FFFFFF}Please, think up the difficult password,\nto avoid possible breaking of your account,\ndon't tell the password even to authorized representatives without emergency\n\nEnter the password:", "Select", "");
		}
 	case TELEPORTS_LIST: // Оболочка меню тп
	    {
			if(rRaceStatusEx	[playerid] == STATUS_RACE_STARTED) return false;
			if(!response){
               	SetPVarInt(playerid,"GoToTele",0);
				return ShowAllTeleports(playerid),true;
			}
			if(listitem == Teleports[playerid]){
			    if(!LanglePlayer{playerid})
			    	return ShowPlayerDialog(playerid, TELEPORTS_LIST+2, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Создание телепорта", "Введите название телепорта. Не более 24 символов", "Далее", "Отмена" ),true;
				else
			    	return ShowPlayerDialog(playerid, TELEPORTS_LIST+2, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Create", "nEnter the teleport name. No more than 24 symbols.", "Next", "Cancel" ),true;
			}
			if(GetPVarInt(playerid,"GoToTele")){
               	SetPVarInt(playerid,"GoToTele",0);
	        	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_SetVehiclePos(GetPlayerVehicleID(playerid),Player[playerid][ptPosX][listitem],Player[playerid][ptPosY][listitem],Player[playerid][ptPosZ][listitem]);
					SetVehicleZAngle(GetPlayerVehicleID(playerid),Player[playerid][ptPosA][listitem]);
				}else{
					t_SetPlayerPos(playerid, Player[playerid][ptPosX][listitem],Player[playerid][ptPosY][listitem],Player[playerid][ptPosZ][listitem]);
					SetPlayerFacingAngle(playerid, Player[playerid][ptPosA][listitem]);
				}
			}else{
				SetPVarInt(playerid,"CarIdMenu",listitem);
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid, TELEPORTS_LIST+1, DIALOG_STYLE_LIST, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Меню телепорта", "Телепортироватся\nПереименовать\nУдалить", "Выбрать", "Отмена");
				else
					ShowPlayerDialog(playerid, TELEPORTS_LIST+1, DIALOG_STYLE_LIST, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Options", "Teleport\nRename\nRemove", "Select", "Cancel");
	    }   }
	case TELEPORTS_LIST+1: // Начинка меню тп
	    {
			if(rRaceStatusEx	[playerid] == STATUS_RACE_STARTED) return false;
			if(!response) return ShowAllTeleports(playerid),true;
	        new IseTP = GetPVarInt(playerid,"CarIdMenu");
	        if(listitem == 0){
	        	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_SetVehiclePos(GetPlayerVehicleID(playerid),Player[playerid][ptPosX][IseTP],Player[playerid][ptPosY][IseTP],Player[playerid][ptPosZ][IseTP]);
					SetVehicleZAngle(GetPlayerVehicleID(playerid),Player[playerid][ptPosA][IseTP]);
				}else{
					t_SetPlayerPos(playerid, Player[playerid][ptPosX][IseTP],Player[playerid][ptPosY][IseTP],Player[playerid][ptPosZ][IseTP]);
					SetPlayerFacingAngle(playerid, Player[playerid][ptPosA][IseTP]);
				}
	        }else if(listitem == 1){
	            if(!LanglePlayer{playerid})
	            	return ShowPlayerDialog(playerid, TELEPORTS_LIST+5, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Переименовать", "Введите название телепорта\nНе более 24 символов", "Далее", "Отмена" ),true;
				else
	            	return ShowPlayerDialog(playerid, TELEPORTS_LIST+5, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Rename", "Enter the name teleport\nNo more than 24 symbols", "Select", "Cancel" ),true;
 			}else if(listitem == 2){
				new theard[112];
  	    		format(theard, sizeof(theard), "DELETE FROM `teleports` WHERE `tID`='%d'", Player[playerid][ptID][IseTP]);
				mysql_function_query(MYSQL, theard, false, "", "");
				if(!LanglePlayer{playerid})
	            	ShowPlayerDialog(playerid, TELEPORTS_LIST+4, DIALOG_STYLE_MSGBOX, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Удаление телепорта", "Телепорт успешно удален", "Ок", "");
				else
	            	ShowPlayerDialog(playerid, TELEPORTS_LIST+4, DIALOG_STYLE_MSGBOX, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Remove", "Teleport is successfully removed", "Ok", "");
	    }   }
   case TELEPORTS_LIST+2: // добавление
        {
			if(!response)
				return ShowAllTeleports(playerid),true;
			if(!strlen(inputtext)){
	            if(!LanglePlayer{playerid})
					return ShowPlayerDialog(playerid, TELEPORTS_LIST+2, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Создание телепорта", "Введите название телепорта. Не более 24 символов", "Далее", "Отмена" ),true;
				else
	  				return ShowPlayerDialog(playerid, TELEPORTS_LIST+2, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Create", "nter the teleport name. No more than 24 symbols.", "Next", "Cancel" ),true;
			}
			new Float:coord[3]; GetPlayerPos(playerid, coord[0], coord[1], coord[2]);
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle);
			else
				GetPlayerFacingAngle(playerid, Angle);
			AddTp(playerid,inputtext,coord[0], coord[1], coord[2],Angle);
   			ShowPlayerDialog(playerid, TELEPORTS_LIST+6, DIALOG_STYLE_MSGBOX, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Создание телепорта", "Телепорт успешно добавлен", "Ок", "");
		}
	case TELEPORTS_LIST+3: // добавление
        {
			if(!response) return ShowAllTeleports(playerid),true;
            if(!LanglePlayer{playerid})
				return ShowPlayerDialog(playerid, TELEPORTS_LIST+2, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Создание телепорта", "Введите название телепорта. Не более 24 символов", "Далее", "Отмена" ),true;
			else
  				return ShowPlayerDialog(playerid, TELEPORTS_LIST+2, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Create", "nter the teleport name. No more than 24 symbols.", "Next", "Cancel" ),true;
		}
	case TELEPORTS_LIST+4: // после удаления
		return ShowAllTeleports(playerid),true;
	case TELEPORTS_LIST+5:{ // после удаления
		if(!response)
			return ShowAllTeleports(playerid),true;
		if(strlen(inputtext) > 24 || !strlen(inputtext)){
			if(!LanglePlayer{playerid})
				return ShowPlayerDialog(playerid, TELEPORTS_LIST+5, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Переименовать", "Введите название телепорта\nНе более 24 символов", "Далее", "Отмена" ),true;
			else
	            return ShowPlayerDialog(playerid, TELEPORTS_LIST+5, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Rename", "Enter the name teleport\nNo more than 24 symbols", "Select", "Cancel" ),true;
		}
		new qString2[112];
		format(qString2, sizeof qString2, "UPDATE `teleports` SET `tName`='%s' WHERE `tID`='%d'",inputtext, Player[playerid][ptID][GetPVarInt(playerid,"CarIdMenu")]);
		mysql_function_query(MYSQL, qString2, false, "", "");
		if(!LanglePlayer{playerid})
   			ShowPlayerDialog(playerid, TELEPORTS_LIST+6, DIALOG_STYLE_MSGBOX, "{FFFFFF}..."STRELKI"Личные телепорты"STRELKI"Изменение названия", "Телепорт успешно переименован", "Ок", "");
		else
   			ShowPlayerDialog(playerid, TELEPORTS_LIST+6, DIALOG_STYLE_MSGBOX, "{FFFFFF}..."STRELKI"Personal teleports"STRELKI"Rename", "Teleport is successfully renamed", "Ok", "");
	}
	case TELEPORTS_LIST+6: // после удаления
		return ShowPersTeleList(playerid);
	case DONATDIALOG:
		{
			if(response){
				switch(listitem)
				{
				case 0:{
				    if(!LanglePlayer{playerid})
         				ShowPlayerDialog(playerid, DONATDIALOG+3, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Донат"STRELKI"Покупка VIP", "Купить VIP на 1 нед.\tЦена: 15 DM.\nКупить VIP на 1 мес.\tЦена: 50 DM.\tБонус:2kk.", "Ок", "Назад");
					else
         				ShowPlayerDialog(playerid, DONATDIALOG+3, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN""STRELKI"Donat"STRELKI"Buy VIP", "Buy VIP for 1 week.\tPrice: 15 DM.\nBuy VIP for 1 month.\tPrice: 50 DM.\tBonus:2kk.", "Ok", "Back");
				}case 1:
					{
						new textdia[256];
				    	if(!LanglePlayer{playerid}){
							format(textdia, sizeof(textdia),"{FFFFFF}Укажите, сколько игровых денег ты собираешься купить?\n{00f5da}(вводите в миллионах, введенная 1 равна 1 000 000){FFFFFF}\nНа данный момент 1 000 000 игровых денег стоит {00f5da}%d DM.\nУ вас %d DM.",STOIMOST_DENEG,Player[playerid][pDonatM]);
							ShowPlayerDialog(playerid, DONATDIALOG+1, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Покупка игровых денег",textdia,"Далее", "Назад" );
						}else{
							format(textdia, sizeof(textdia),"{FFFFFF}Specify, how many game money you prepare to buy?\n{00f5da}(enter in millions, entered 1 it is equal 1 000 000){FFFFFF}\nAt present 1 000 000 game money cost{00f5da}%d DM.\nAt you %d DM.",STOIMOST_DENEG,Player[playerid][pDonatM]);
							ShowPlayerDialog(playerid, DONATDIALOG+1, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Donat"STRELKI"Buy game money",textdia,"Select", "Back" );
						}
					}
				case 2:
					{
						new textdia[256];
						if(!LanglePlayer{playerid}){
							format(textdia, sizeof(textdia),"{FFFFFF}Укажите, сколько SCORE ты собираешься купить?\n{00f5da}(вводите в тысячах, введенная 1 равна 1 000){FFFFFF}\nНа данный момент 1 000 SCORE стоит {00f5da}%d DM.\nУ вас %d DM.",STOIMOST_SCORE,Player[playerid][pDonatM]);
							ShowPlayerDialog(playerid, DONATDIALOG+2, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Покупка SCORE",textdia,"Далее", "Назад" );
						}else{
							format(textdia, sizeof(textdia),"{FFFFFF}Specify, how many SCORE you prepare to buy?\n{00f5da}(you enter in thousands, entered 1 it is equal 1 000){FFFFFF}\nAt present 1 000 SCORE cost {00f5da}%d DM.\nAt you %d DM.",STOIMOST_SCORE,Player[playerid][pDonatM]);
							ShowPlayerDialog(playerid, DONATDIALOG+2, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Покупка SCORE",textdia,"Select", "Back" );
						}
					}
				case 3:
				    {
				        if(!LanglePlayer{playerid}){
	   						if(GetPVarInt(playerid,"TimeNextPromo") > gettime()){
								new textdia[256];
								format(textdia, sizeof(textdia),"{FFFFFF}Промокод введен не верно. Следующая попытка ввода будет доступна через %s.",timec(GetPVarInt(playerid,"TimeNextPromo")));
					            return ShowPlayerDialog(playerid, DONATDIALOG-DONATDIALOG, DIALOG_STYLE_MSGBOX,"{FFFFFF}Ввод промокода",textdia,"Закрыть", "" );
							}
							ShowPlayerDialog(playerid, DONATDIALOG+4, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Ввод промокода","{FFFFFF}Введи свой промокод.\nУчти, количество попыток ограничено.","Далее", "Назад" );
			            }else{
	   						if(GetPVarInt(playerid,"TimeNextPromo") > gettime()){
								new textdia[256];
								format(textdia, sizeof(textdia),"{FFFFFF}The promo code is entered not truly. The following attempt of input will be available through %s.",timecEn(GetPVarInt(playerid,"TimeNextPromo")));
					            return ShowPlayerDialog(playerid, DONATDIALOG-DONATDIALOG, DIALOG_STYLE_MSGBOX,"{FFFFFF}Promo code input",textdia,"Close", "" );
							}
							ShowPlayerDialog(playerid, DONATDIALOG+4, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Donat"STRELKI"Promo code input","{FFFFFF}Consider, the number of attempts is limited.","Select", "Back" );
			            }
					}
				case 4:
					{
						minidialog = "";
						if(!LanglePlayer{playerid}){
							strcat(minidialog, "{FFFFFF}\tЕсть 2 способа получить промокод:\n");
							strcat(minidialog, "1) Участвовать в акциях в нашей группе VK: {00f5da}vk.com/driftemp{FFFFFF}\n");
							strcat(minidialog, "2) Купить. 1 DM = 1 RUB. Для покупки обратитесь в скайп: {00f5da}Alpano.{FFFFFF}(с точкой)");
							ShowPlayerDialog(playerid, 190, DIALOG_STYLE_MSGBOX, "Способы получения промо", minidialog, "Ок", "");
						}else{
							strcat(minidialog, "{FFFFFF}\tThere are 2 methods to receive a promo code\n");
							strcat(minidialog, "1) To participate in actions in our VK group: {00f5da}vk.com/driftemp{FFFFFF}\n");
							strcat(minidialog, "2) Buy. 1 Dollar = 1 DM. For purchase address in Skype: {00f5da}Alpano.{FFFFFF}(with a point)");
							ShowPlayerDialog(playerid, 190, DIALOG_STYLE_MSGBOX, "Receiving methods promo", minidialog, "Ok", "");
						}
					}
				}
			}
			else ShowDialogSint(playerid);
		}
	case DONATDIALOG+1:
		{
			if(response){
				if(strval(inputtext) > 1000 || (strval(inputtext)*STOIMOST_DENEG) > Player[playerid][pDonatM] || strval(inputtext) < 1){
					new textdia[256];
				   	if(!LanglePlayer{playerid}){
						format(textdia, sizeof(textdia),"{FFFFFF}Укажите, сколько игровых денег ты собираешься купить?\n{00f5da}(вводите в миллионах, введенная 1 равна 1 000 000){FFFFFF}\nНа данный момент 1 000 000 игровых денег стоит {00f5da}%d DM.\nУ вас %d DM.",STOIMOST_DENEG,Player[playerid][pDonatM]);
						ShowPlayerDialog(playerid, DONATDIALOG+1, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Покупка игровых денег",textdia,"Далее", "Назад" );
                    	SendClientMessage(playerid,-1,""SERVER_MSG"Неверное Кол-во.");
					}else{
						format(textdia, sizeof(textdia),"{FFFFFF}Specify, how many game money you prepare to buy?\n{00f5da}(enter in millions, entered 1 it is equal 1 000 000){FFFFFF}\nAt present 1 000 000 game money cost{00f5da}%d DM.\nAt you %d DM.",STOIMOST_DENEG,Player[playerid][pDonatM]);
						ShowPlayerDialog(playerid, DONATDIALOG+1, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Donat"STRELKI"Buy game money",textdia,"Select", "Back" );
                    	SendClientMessage(playerid,-1,""SERVER_MSG"Incorrect Quantity.");
					}
					return true;
				}
				else{
				    Player[playerid][pDonatM] -= (STOIMOST_DENEG*strval(inputtext));
				    DaiEmyDeneg(playerid,strval(inputtext)*1000000);
					new qString[128];
					if(!LanglePlayer{playerid})
						format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдано %dкк игровых денег, у вас осталось {00f5da}%d DM.",strval(inputtext),Player[playerid][pDonatM]);
					else
						format(qString, sizeof qString, ""SERVER_MSG"Thanks for purchase! To you it is given out %dkk game money, at us remained {00f5da}%d DM.",strval(inputtext),Player[playerid][pDonatM]);
					SendClientMessage(playerid,-1,qString);
					return ShowDialogDonat(playerid);
				}
			}
			else ShowDialogDonat(playerid);
		}
	case DONATDIALOG+2:
		{
			if(response){
				if(strval(inputtext) > 1000 || (strval(inputtext)*STOIMOST_SCORE) > Player[playerid][pDonatM] || strval(inputtext) < 1){
					new textdia[256];
     				if(!LanglePlayer{playerid}){
						format(textdia, sizeof(textdia),"{FFFFFF}Укажите, сколько SCORE ты собираешься купить?\n{00f5da}(вводите в тысячах, введенная 1 равна 1 000){FFFFFF}\nНа данный момент 1 000 SCORE стоит {00f5da}%d DM.\nУ вас %d DM.",STOIMOST_SCORE,Player[playerid][pDonatM]);
						ShowPlayerDialog(playerid, DONATDIALOG+2, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Покупка SCORE",textdia,"Далее", "Назад" );
                    	SendClientMessage(playerid,-1,""SERVER_MSG"Неверное Кол-во.");
					}else{
						format(textdia, sizeof(textdia),"{FFFFFF}Specify, how many SCORE you prepare to buy?\n{00f5da}(you enter in thousands, entered 1 it is equal 1 000){FFFFFF}\nAt present 1 000 SCORE cost {00f5da}%d DM.\nAt you %d DM.",STOIMOST_SCORE,Player[playerid][pDonatM]);
						ShowPlayerDialog(playerid, DONATDIALOG+2, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Покупка SCORE",textdia,"Select", "Back" );
                    	SendClientMessage(playerid,-1,""SERVER_MSG"Incorrect Quantity.");
					}
					return true;
				}
				else{
				    Player[playerid][pDonatM] -= (STOIMOST_SCORE*strval(inputtext));
					GivePlayerScore(playerid,(strval(inputtext)*1000));
					new qString[128];
					if(!LanglePlayer{playerid})
						format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдано %dк SCORE, у вас осталось {00f5da}%d DM.",strval(inputtext),Player[playerid][pDonatM]);
					else
						format(qString, sizeof qString, ""SERVER_MSG"Thanks for purchase! To you it is given out %dk SCORE, at us remained {00f5da}%d DM.",strval(inputtext),Player[playerid][pDonatM]);
					SendClientMessage(playerid,-1,qString);
					return ShowDialogDonat(playerid);
				}
			}
			else ShowDialogDonat(playerid);
		}
	case DONATDIALOG+3:
		{
		    if(!response) return ShowDialogDonat(playerid);
			if(Player[playerid][pVIP] && Player[playerid][pStopVip] == 999999999){
				if(!LanglePlayer{playerid})
					SendClientMessage(playerid,-1,""SERVER_MSG"Чувак! У тебя и так бесконечная вип, куда круче?");
				else
					SendClientMessage(playerid,-1,""SERVER_MSG"Dude! At you and so the infinite VIP, where more steep?");
				ShowDialogDonat(playerid);
				return true;
			}
			new qString[128];
			if(listitem == 0){
				if(Player[playerid][pDonatM] < 15){
					if(!LanglePlayer{playerid})
						format(qString, sizeof qString, ""SERVER_MSG"Извините, у вас %d DM а для покупки VIP необходимо {00f5da}%d DM.",Player[playerid][pDonatM],15);
					else
						format(qString, sizeof qString, ""SERVER_MSG"Excuse, at you %d DM for purchase the VIP is necessary {00f5da}%d DM.",Player[playerid][pDonatM],15);
					SendClientMessage(playerid,-1,qString);
				}else{
	   				Player[playerid][pDonatM] -= 15;
				    if(Player[playerid][pVIP]){
						Player[playerid][pStopVip] += 604800;
						format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдана ещё 1 нед.VIP, у нас осталось {00f5da}%d DM.",Player[playerid][pDonatM]);
					}else{
	       				format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдана 1 нед.VIP, у нас осталось {00f5da}%d DM.",Player[playerid][pDonatM]);
	    				Player[playerid][pVIP] = true;
						Player[playerid][pStopVip] = gettime()+604800;
					}
					SendClientMessage(playerid,-1,qString);
				}
				return ShowDialogDonat(playerid);
		    }
		    if(listitem == 1){
				if(Player[playerid][pDonatM] < STOIMOST_VIP){
					if(!LanglePlayer{playerid})
						format(qString, sizeof qString, ""SERVER_MSG"Извините, у вас %d DM а для покупки VIP необходимо {00f5da}%d DM.",Player[playerid][pDonatM],STOIMOST_VIP);
					else
						format(qString, sizeof qString, ""SERVER_MSG"Excuse, at you %d DM for purchase the VIP is necessary {00f5da}%d DM.",Player[playerid][pDonatM],STOIMOST_VIP);
					SendClientMessage(playerid,-1,qString);
				}else{
	   				Player[playerid][pDonatM] -= STOIMOST_VIP;
				    if(Player[playerid][pVIP]){
						Player[playerid][pStopVip] += 2629743;
						if(!LanglePlayer{playerid})
							format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдан ещё 1 мес.VIP, у нас осталось {00f5da}%d DM.",Player[playerid][pDonatM]);
						else
							format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдан ещё 1 мес.VIP, у нас осталось {00f5da}%d DM.",Player[playerid][pDonatM]);
					}else{
	       				format(qString, sizeof qString, ""SERVER_MSG"Спасибо за покупку! Вам выдан 1 мес.VIP, у нас осталось {00f5da}%d DM.",Player[playerid][pDonatM]);
	    				Player[playerid][pVIP] = true;
						Player[playerid][pStopVip] = gettime()+2629743;
					}
					SendClientMessage(playerid,-1,qString);
					DaiEmyDeneg(playerid,2000000);
				}
				return ShowDialogDonat(playerid);
		    }
		}
	case DONATDIALOG+4:
		{
		    if(!response) return ShowDialogDonat(playerid);
			if(strlen(inputtext) != 6)
				return ShowPlayerDialog(playerid, DONATDIALOG+4, DIALOG_STYLE_INPUT,"{FFFFFF}..."STRELKI"Донат"STRELKI"Ввод промокода","{FFFFFF}Введи свой промокод.\nУчти, количество попыток ограничено.","Далее", "Назад" );
		  	new qString[128];
			format(qString, sizeof qString, "SELECT * FROM `promocods` WHERE `Kode`='%s' LIMIT 1", inputtext);
			mysql_function_query(MYSQL, qString, true, "GetPromoEx", "i", playerid);
			return true;
		}
	case DONATDIALOG+5:
		{
		    if(!response) return ShowMenuForPlayerEx(playerid);		
			if(!LanglePlayer{playerid})
				ShowPlayerDialog(playerid, DONATDIALOG+3, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Донат"STRELKI"Покупка VIP", "Купить VIP на 1 нед.\tЦена: 15 DM.\nКупить VIP на 1 мес.\tЦена: 50 DM.\tБонус:2kk.", "Ок", "Назад");
			else
				ShowPlayerDialog(playerid, DONATDIALOG+3, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN""STRELKI"Donat"STRELKI"Buy VIP", "Buy VIP for 1 week.\tPrice: 15 DM.\nBuy VIP for 1 month.\tPrice: 50 DM.\tBonus:2kk.", "Ok", "Back");
			return true;
		}
	case DONATDIALOG+6:
		{		
			ShowDialogDonat(playerid);
		}
	case 1000:
		{
			if(response && Player[playerid][pAdminPlayer] > LEVEL_BANN){
				switch(listitem)
				{
					case 0:
						ShowPlayerDialog(playerid,1006,DIALOG_STYLE_INPUT,"Разбан ип:","Кого разбанивать будем?!","Unban","Cancel");
					case 1:
					{
						SendRconCommand("reloadbans");
						SendClientMessage(playerid,-1,"SERVER: Перезагрузка банов!");
					}
					case 2:
					{
						t_SendClientMessageToAll(-1,-1, ""SERVER_MSG"Обновление сервера, через 5 секунд! Не выходите!",""SERVER_MSG"Обновление сервера, через 5 секунд! Не выходите!");
						for(new f = 0, all = MAX_PLAYERS; f < all; f++){
	 						if(!IsPlayerConnected(f) || !Player[f][logged])continue;
							SaveAccount(f);
						}
						SetTimer("restart", 5000, 0);
					}
					case 3:
							ShowPlayerDialog(playerid,1005,DIALOG_STYLE_INPUT,"Бан ип:","Кого будем банить?!","Ban","Cancel");
					case 4:
							ShowPlayerDialog(playerid,1010,DIALOG_STYLE_INPUT,"Сказать всем:","Введи своё сообщение!","Отправить","Отмена");
					case 5:
							ShowPlayerDialog(playerid,1011,DIALOG_STYLE_INPUT,"Изменение гравитрации:","Введите нужную гравитацию (сток 0.008)","Изменить","Отмена");
					case 6:
							ShowPlayerDialog(playerid,1009,DIALOG_STYLE_INPUT,"Изменить МапНейм:","Введи новый мапнейм!","Change","Cancel");
					case 7:
					{
						SendRconCommand("reloadlog");
						SendClientMessage(playerid,-1,"SERVER: Лог перезагружен!");
					}
					case 8:
					{
						SendRconCommand("exit");
						t_SendClientMessageToAll(-1,-1,""SERVER_MSG"Выключение",""SERVER_MSG"Shut-down server");
					}
					case 9:
						ShowPlayerDialog(playerid,1007,DIALOG_STYLE_INPUT,"Изменить название сервера:","Введи новое название сервера!","Change","Cancel");
				}   }
			return true;
		}
	case 1005:
		{
			format(string,sizeof(string),"banip %s",inputtext);
			SendRconCommand(string);
			SendClientMessage(playerid,-1,"SERVER: IP banned!");
		}
	case 1006:
		{
			format(string,sizeof(string),"unbanip %s",inputtext);
			SendRconCommand(string);
			SendClientMessage(playerid,-1,"SERVER: IP unbanned!");
		}
	case 1007:
		{
			format(string,sizeof(string),"hostname %s",inputtext);
			SendRconCommand(string);
			SendClientMessage(playerid,-1,"SERVER: Hostname changed!");
		}
	case 1009:
		{
			format(string,sizeof(string),"mapname %s",inputtext);
			SendRconCommand(string);
			SendClientMessage(playerid,-1,"SERVER: Map name changed!");
		}
	case 1010:
		{
			format(string,sizeof(string),"say %s",inputtext);
			SendRconCommand(string);
		}
	case 1011:
		{
			format(string,sizeof(string),"gravity %s",inputtext);
			SendRconCommand(string);
			SendClientMessage(playerid,-1,"SERVER: Gravity changed!");
		}
		//Личные авто
	case Autos+2:
		{
			if(response)
			{
				ShowBuyCarDialog(playerid);
			}
		}
	case Autos+3:
		{
			if(response)
			{
			    new model = GetPVarInt(playerid,"BuyModel");
	   			if(GetPrice(model) > GetPlayerCash(playerid)){
	   			    new msg[128];
	                format(msg, sizeof(msg), "Увы, но для покупки авто \"%s\" у вас недостаточно денег.\nЕё стоимость %d$.", VehicleNames[model-400],GetPrice(model));
	            	return ShowPlayerDialog(playerid, Autos+2 , DIALOG_STYLE_MSGBOX, ""MENU_PRFX_CARS""STRELKI"Покупка авто", msg, "Назад", "Закрыть");
             	}
				DaiEmyDeneg(playerid,-GetPrice(model));
			   	BuyCar(playerid,GetPVarInt(playerid,"CarIdMenu"),model);
			}
			else ShowBuyCarDialog(playerid);
		}
	case Autos+1:
		{
			if(response)
			{
				new cenaslota,scoreslota;
				if(Player[playerid][pCarslots] == 3){
					cenaslota = 100000;
					scoreslota = 5;
				}
				else if(Player[playerid][pCarslots] == 4){
					cenaslota = 200000;
					scoreslota = 10;
				}
				else if(Player[playerid][pCarslots] == 5){
					cenaslota = 300000;
					scoreslota = 25;
				}
				else if(Player[playerid][pCarslots] == 6){
					cenaslota = 400000;
					scoreslota = 50;
				}
				else if(Player[playerid][pCarslots] >= 7)
					cenaslota = 500000;
				if(Player[playerid][pLevel] < scoreslota || GetPlayerCash(playerid) < cenaslota) return ShowPlayerDialog(playerid, Autos+2 , DIALOG_STYLE_MSGBOX, "{FFFFFF}..."STRELKI"Покупка слота", "Вам не доступен данный слот", "Назад", "Закрыть");
				else
				{
					if(!Player[playerid][pVIP] && Player[playerid][pCarslots] >= 7) return ShowPlayerDialog(playerid, Autos+2 , DIALOG_STYLE_MSGBOX, "{FFFFFF}... {00f5da}>>{FFFFFF}"STRELKI"Покупка слота", "Вам не доступен данный слот", "Назад", "Закрыть");
					DaiEmyDeneg(playerid,-cenaslota);
					Player[playerid][pCarslots] = Player[playerid][pCarslots]+1;
					SendClientMessage(playerid,-1,""SERVER_MSG"Ты успешно купил ещё 1 слот для транспорта!");
				}
			}
			ShowBuyCarDialog(playerid);
		}
	case Autos:
		{
			if(response)
			{
				new carslot = listitem+1;
				SetPVarInt(playerid,"CarIdMenu",carslot);
				if(carslot == (Player[playerid][pCarslots]+1))
				{
					new cenaslota,scoreslota;
					if(Player[playerid][pCarslots] == 3){
						cenaslota = 100000;
						scoreslota = 5;
					}
					else if(Player[playerid][pCarslots] == 4){
						cenaslota = 200000;
						scoreslota = 10;
					}
					else if(Player[playerid][pCarslots] == 5){
						cenaslota = 300000;
						scoreslota = 25;
					}
					else if(Player[playerid][pCarslots] == 6){
						cenaslota = 400000;
						scoreslota = 50;
					}
					if(Player[playerid][pCarslots] >= 7){
						cenaslota = 500000;
						format(string,sizeof(string),"Цена %d-го слота: $%d.\nУсловие: Иметь VIP.",Player[playerid][pCarslots]+1,cenaslota);
					}
					else format(string,sizeof(string),"Цена %d-го слота: $%d.\nУсловие: Иметь %d уровень или более.",Player[playerid][pCarslots]+1,cenaslota,scoreslota);
					ShowPlayerDialog(playerid, Autos+1 , DIALOG_STYLE_MSGBOX, "{FFFFFF}... {00f5da}>>{FFFFFF}"STRELKI"Покупка слота", string, "Купить", "Назад");
					return true;
				}
				else if(Player[playerid][pAuto][carslot])
					CarMenu(playerid,carslot);
				else
				    ShowListCars(playerid);
			}
			else
				ShowMenuForPlayerEx(playerid);
		}
		//=======================================
	case 113:
		{
			if(response)
			{
				new carid = pvehs[GetPVarInt(playerid,"CarIdMenu")][playerid];
				if(listitem == 0)
				{
				    new stated = GetPlayerState(playerid),
	    				caride = GetPlayerVehicleID(playerid),
						bool:createcar;
					if(IsValidVehicle(carid) && caride == carid) return CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
					if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED){			
						if(!LanglePlayer{playerid})
							SendClientMessage(playerid,-1,""SERVER_MSG"Вы в дуэли!");
						else
							SendClientMessage(playerid,-1,""SERVER_MSG"You'r in duel!");
					}
					else if(GetPlayerVirtualWorld(playerid) == 0){					
						if(ReturnVidVehicle(Player[playerid][pAuto][GetPVarInt(playerid,"CarIdMenu")]) == AIR_TS){
							if(!LanglePlayer{playerid})
								SendClientMessage(playerid,-1,""SERVER_MSG"Данное ТС нельзя вызывать в общий вирт. мир!");
							else
								SendClientMessage(playerid,-1,""SERVER_MSG"This HARDWARE can't be called in the general virtual world!");
							return CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
					}	}
					if(!IsValidVehicle(carid)){
						createcar = true;
						new f = GetPVarInt(playerid,"CarIdMenu");
						carid = CreateVehicle(Player[playerid][pAuto][f],X,Y,Z, Angle,Player[playerid][pColor][f],Player[playerid][pColorTwo][f],-1);
						SetVehicleNumberPlate(carid,pNumber[f][playerid]);
						SetVehicleParamsEx(carid,	carstate[0],		carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
						if(Player[playerid][cGidravlika][f])
							AddVehicleComponent(carid, 1087);
						if(Player[playerid][cWheels][f] != -1)
							AddVehicleComponent(carid, Wheels[Player[playerid][cWheels][f]]);	
						if(Player[playerid][pVinil][f] >= 0)
							ChangeVehiclePaintjob(carid,Player[playerid][pVinil][f]);
					}else createcar = false;
					if(stated == PLAYER_STATE_DRIVER){
						new slotEx = GetCarIdPoId(caride,playerid);
						if(slotEx){
							RemovePlayerFromVehicle(playerid);
							SetVehicleVirtualWorld(caride,1337);
							pvehs[slotEx][playerid] = INVALID_VEHICLE_ID;
							DestroyVehicle(caride);
							SetPVarInt(playerid,"posadi",1);
						}
					}
					pvehs[GetPVarInt(playerid,"CarIdMenu")][playerid] = carid;
					t_SetVehicleVirtualWorld(playerid,carid,GetPlayerVirtualWorld(playerid));
					t_LinkVehicleToInterior(carid,GetPlayerInterior(playerid));
					if(stated == PLAYER_STATE_ONFOOT || stated == PLAYER_STATE_DRIVER){
						if(!createcar){
							RemovCarDriver(carid);
							t_SetVehiclePos(carid,X,Y,Z);
						}
						t_PutPlayerInVehicle(playerid,carid);
					}else{
						RemovCarDriver(carid);
						t_SetVehiclePos(carid,X,Y+3,Z);
					}
					SetVehicleZAngle(carid,Angle);
					SetPVarInt(playerid,"posadi",0);
					if(GetPlayerVirtualWorld(playerid) == 0)
					    SetCarsInVorld(playerid,GetPlayerVirtualWorld(playerid),true);
				}
				else if(listitem == 1)
				{
				    new slot = GetCarId(playerid);
					if(slot == GetPVarInt(playerid,"CarIdMenu") || !IsValidVehicle(carid)) return CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
					if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED){					
						if(ReturnVidVehicle(GetVehicleModel(carid)) == AIR_TS){
							if(!LanglePlayer{playerid})
								SendClientMessage(playerid,-1,""SERVER_MSG"Вы в дуэли!");
							else
								SendClientMessage(playerid,-1,""SERVER_MSG"You'r in duel!");
					}	}
					t_SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(carid));
					if(GetVehicleModel(carid) != 435){
						RemovCarDriver(carid);
						t_PutPlayerInVehicle(playerid,carid);
					}
					else{
						RemovCarDriver(carid);
						new Float:X1,Float:Y1,Float:Z1;
						GetVehiclePos(carid,X1,Y1,Z1);
					 	t_SetPlayerPos(playerid,X1,Y1+3,Z1);
					 }
				}
				else if(listitem == 2){
					if(IsValidVehicle(carid))
						SetCarInGarage(playerid,GetPVarInt(playerid,"CarIdMenu"));
					else
					    CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
				}
				else if(listitem == 3){
					if(!IsValidVehicle(carid))
					    return CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
					ShowDialogTuning(playerid);
				}else if(listitem == 4){
					if(!IsValidVehicle(carid))
					    return CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
					CarSetign(playerid);
				}else if(listitem == 5)
				{
					new slot = GetPVarInt(playerid,"CarIdMenu");
					Player[playerid][pVinil][slot] = -1;
					Player[playerid][pColor][slot] = 1;
					Player[playerid][pColorTwo][slot] = 0;
					Player[playerid][cGidravlika][slot] = 0;
					Player[playerid][cWheels][slot] = -1;
					Player[playerid][pAPos_x][slot] = 0;
					Player[playerid][pAPos_y][slot] = 0;
					Player[playerid][pAPos_z][slot] = 0;
					Player[playerid][pAPos_a][slot] = 0;
					Player[playerid][cWorld][slot] = 0;
					pNumber[slot][playerid] = "";
					pvehs[slot][playerid] = INVALID_VEHICLE_ID;
					new query[112];
					format(query, sizeof(query),"DELETE FROM  "CARS_TABLE" WHERE `cID` = %d",Player[playerid][pAutoUID][slot]);
					mysql_function_query(MYSQL, query, false, "", "");
					Player[playerid][pAutoUID][slot] = 0;
					SaleCar(playerid,slot);
					if(IsValidVehicle(carid))
						DestroyVehicle(carid);
				}
			}
			else ShowBuyCarDialog(playerid);
		}
	case 114:
		{
			new carid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
			if(response)
			{
				GetVehicleParamsEx(carid,engine,lights,alarm,doors,	bonnet,	boot,objective);
				if(listitem == 0)
					SetVehicleParamsEx(carid,engine,lights,alarm,doors,	(bonnet == 0)?1:0,	boot,objective);
				else if(listitem == 1)//абагажник
					SetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,	(boot == 0)?1:0,	objective);
				else if(listitem == 2)//фары
					SetVehicleParamsEx(carid,engine,(lights == 0 || lights == -1)?1:0,	alarm,doors,bonnet,boot,objective);
				else if(listitem == 3)//движок
					SetVehicleParamsEx(carid,(engine == 0)?1:0,	lights,alarm,doors,bonnet,boot,objective);
				else if(listitem == 4)//двери
					SetVehicleParamsEx(	carid,engine,lights,alarm,(doors == 0)?1:0,	bonnet,boot,objective);
				else if(listitem == 5)//Колеса
				{
				    new panels,tires;
					GetVehicleDamageStatus(carid,panels,doors,lights,tires);
					if(tires == 0000){// strcat(msg,"Спустить задние колеса\r\n");
					   	if(Player[playerid][pRepair]){
					   	    SetPVarInt(playerid,"NoRepair",1);
							UpdateVehicleDamageStatus(carid, panels,doors,lights,0101);
						}
						else UpdateVehicleDamageStatus(carid, panels,doors,lights,0101);
					}
					else// strcat(msg,"Накачать дание колеса\r\n");
						UpdateVehicleDamageStatus(carid, panels,doors,lights,0000);
				}
				else if(listitem == 6)//Номера
				{
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid,115,DIALOG_STYLE_LIST,"Настройка номера","Смена цвета\nСмена знаков","Далее","Отмена");
					else
						ShowPlayerDialog(playerid,115,DIALOG_STYLE_LIST,"Setting number","Change colour\nChange signs","Next","Cancel");
					return true;
				}
				CarSetign(playerid);	
			}
			else CarMenu(playerid,GetPVarInt(playerid,"CarIdMenu"));
		}
	case 115:
		{
			if(!response) CarSetign(playerid);
			if(listitem == 0){
				minidialog = "";
				if(!LanglePlayer{playerid}){
					strcat(minidialog,"{000000}Черный\n{00f5da}Бирюзовый\n{ff0000}Красный\n{8b00ff}Фиолетовый\n");
					strcat(minidialog,"{ffff00}Желтый\n{00ff00}Зеленый\n{0012ff}Синий\n{fc0fc0}Ярко-розовый");
					ShowPlayerDialog(playerid,116,DIALOG_STYLE_LIST,"Выбор цвета",minidialog,"Далее","Отмена");
				}else{
					strcat(minidialog,"{000000}Black\n{00f5da}Turquoise\n{ff0000}Red\n{8b00ff}Purple\n");
					strcat(minidialog,"{ffff00}Yellow\n{00ff00}Green\n{0012ff}Blue\n{fc0fc0}Bright pink");
					ShowPlayerDialog(playerid,116,DIALOG_STYLE_LIST,"Select colour",minidialog,"Next","Cancel");
				}
			}
			else if(listitem == 1)
						ShowPlayerDialog(playerid,117,DIALOG_STYLE_INPUT,"{FFFFFF}Изменить номера:","{FFFFFF}Номера могут содержать:\n-Буквы (русские/английские)\n-Цифры\n-Знаки \"=\",\":\" и \"-\"\n\nДлинна не менее 2х символов и не более 12ти.","Далее","Отмена");
			return true;
		}
	case 116:
		{
			if(!response) CarSetign(playerid);
			strdel(pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid],0,8);
			new numberEx[25];
			if(listitem == 0)		strcat(numberEx,"{000000}");
			else if(listitem == 1) 	strcat(numberEx,"{00f5da}");
			else if(listitem == 2) 	strcat(numberEx,"{ff0000}");
			else if(listitem == 3) 	strcat(numberEx,"{8b00ff}");
			else if(listitem == 4) 	strcat(numberEx,"{ffff00}");
			else if(listitem == 5) 	strcat(numberEx,"{00ff00}");
			else if(listitem == 6) 	strcat(numberEx,"{0012ff}");
			else if(listitem == 7) 	strcat(numberEx,"{fc0fc0}");
			strcat(numberEx,pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid]);
			format(pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid],25,"%s",numberEx);
			SendClientMessage(playerid, -1, ""SERVER_MSG"Убери/Верни машину, или взорви её для обновления номеров.");
			CarSetign(playerid);
			return true;
		}
	case 117:
		{
			if(!response) CarSetign(playerid);
			if(strlen(inputtext) < 2 || strlen(inputtext) > 15 || emptyMessage(inputtext))
				ShowPlayerDialog(playerid,117,DIALOG_STYLE_INPUT,"{FFFFFF}Изменить номера:","{FFFFFF}Номера могут содержать:\n-Буквы (русские/английские)\n-Цифры\n-Знаки \"=\",\":\" и \"-\"\n\nДлинна не менее 2х символов и не более 12ти.","Далее","Отмена");
			for (new i = 0; i < strlen(inputtext); i++){
				switch(inputtext[i]){
					case 'а'..'я','А'..'Я','A'..'Z','a'..'z','0'..'9','=','-',':',' ':
						continue;
					default:{
						ShowPlayerDialog(playerid,117,DIALOG_STYLE_INPUT,"{FFFFFF}Изменить номера:","{FFFFFF}Номера могут содержать:\n-Буквы (русские/английские)\n-Цифры\n-Знаки \"=\",\":\" и \"-\"\n\nДлинна не менее 2х символов и не более 12ти.","Далее","Отмена");
						return true;
					}
				}
			}
			strdel(pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid],8,strlen(pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid]));
			strcat(pNumber[GetPVarInt(playerid,"CarIdMenu")][playerid],inputtext);
			SendClientMessage(playerid, -1, ""SERVER_MSG"Убери/Верни машину, или взорви её для обновления номеров.");
			CarSetign(playerid);
			return true;
		}
	/*case ALLCARMENU:
		{
			if(response)
			{
				if(0 < listitem < 6)
				    if(Player[playerid][pLevel] < listitem+1)
						return ShowListCars(playerid);
				if(listitem == 0)
					ShowModelSelectionMenuEx(playerid, driftcars, sizeof(driftcars), FixText("Авто для дрифтинга"), ALLCARMENU+1, -16.0, 0.0, -55.0);
				else if(listitem == 1)
					ShowModelSelectionMenuEx(playerid, otherlightavto, sizeof(otherlightavto), FixText("Все авто"), ALLCARMENU+1, -16.0, 0.0, -55.0);
				else if(listitem == 2)
					ShowModelSelectionMenuEx(playerid, bikes, sizeof(bikes), FixText("Мотоциклы"), ALLCARMENU+1, -16.0, 0.0, -55.0);
				else if(listitem == 3)
					ShowModelSelectionMenuEx(playerid, djeepcars, sizeof(djeepcars), FixText("Джипы"), ALLCARMENU+1, -16.0, 0.0, -55.0);
				else if(listitem == 4)
					ShowModelSelectionMenuEx(playerid, allcars, sizeof(allcars), FixText("Разные"), ALLCARMENU+1, -16.0, 0.0, -55.0);
				else if(listitem == 5)
					ShowModelSelectionMenuEx(playerid, copsavto, sizeof(copsavto), FixText("Полицейские"), ALLCARMENU+1, -16.0, 0.0, -55.0);
				else if(listitem == 6)
					ShowModelSelectionMenuEx(playerid, vipcars, sizeof(vipcars), FixText("VIP транспорт"), ALLCARMENU+1, -16.0, 0.0, -55.0);
			}
			return true;
		}*/
		//Личные авто
	case 238:
		{
			new params[1];
			params[0] = clickedplayeride[playerid];
			if (Player[playerid][pTimeOnlineD] <1 && Player[playerid][pTimeOnlineH] < 1 && Player[playerid][pTimeOnline] < 10)
				return SendClientMessage(playerid, -1, ""SERVER_MSG"Извините, вам рано использовать данную функцию! Необходимое время - 10 минут.");
			if(!IsPlayerConnected(params[0]))
				return SendClientMessage(playerid,-1,""SERVER_MSG"Данного игрока нет на сервере!"),true;
			if(InBlackList(playerid,params[0]) || InBlackList(params[0],playerid) || (Player[params[0]][pPmStatus] && !IsFrende(params[0],playerid)))
				return SendClientMessage(playerid,-1,""SERVER_MSG"Ошибка доступа."),true;
			new msg[256];
			if(strlen(inputtext) > 5)
				if(GetMiniBook(inputtext) >= strlen(inputtext)/2) UpperToLower(inputtext);
			format(msg,sizeof(msg),"{00f5da}для{%s} %s(%d){FFFFFF}: %s",chatcolor[Player[params[0]][pColorPlayer]],Player[params[0]][PlayerName],params[0],inputtext);
			SendClientMessage(playerid,PM_OUTGOING_COLOR,msg);
			msg = "";
			if(GetCifri(inputtext) < 9 && !CheckString(inputtext))
			{
				format(msg,sizeof(msg),"{00f5da}от{%s} %s(%d){FFFFFF}: %s",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],playerid,inputtext);
				SendClientMessage(params[0],PM_INCOMING_COLOR,msg);
				PlayerPlaySound(params[0],1085,0.0,0.0,0.0);
		}	}
	case 239:
		{
			if(!response) return true;
			new playe = clickedplayeride[playerid];
			if(!IsPlayerConnected(playe)) return SendClientMessage(playerid,0xFFFFFFFF, ""SERVER_MSG"Игрока нет на сервере!");
			if(listitem == 0)
				ShowPlayerDialog(playerid,238,DIALOG_STYLE_INPUT,"Отправка личного сообщения.","Введите текст сообщения","Отправить","Отмена");
			else if(listitem == 1)
				ShowPlayerDialog(playerid,244,DIALOG_STYLE_INPUT,"Передача денег.","Введите сумму","Передать","Отмена");
			else if(listitem == 2){
				if(rRaceStatusEx[playe] != STATUS_NO_RACE && rRaceStatusEx[playe] != STATUS_RACE_WAIT){
					if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Игрок уже в гонке."); else return SendClientMessage(playerid,-1,""SERVER_MSG"Player in race!.");
				}
				if(Player[playerid][pLevel] < 10){
					if(!LanglePlayer{playerid})
						SendClientMessage(playerid,-1,""SERVER_MSG"Для участия в дуэли необходим 10 уровень!");
					else
						SendClientMessage(playerid,-1,""SERVER_MSG"The 10th level is necessary for involvement in duel!");
					return true;
				}else if(Player[playe][pLevel] < 10){
					if(!LanglePlayer{playerid})
						SendClientMessage(playerid,-1,""SERVER_MSG"Соперник слишком низкого уровня!");
					else
						SendClientMessage(playerid,-1,""SERVER_MSG"Rival of too low level!");
					return true;
				}else if(gettime()-Player[playerid][pOldDuel] < PERETIV_VEJDU_DD){
					new msg[112];
					if(!LanglePlayer{playerid})
						format(msg, sizeof(msg), ""SERVER_MSG"Следующая дуэль доступна через %s.", timec(Player[playerid][pOldDuel]+PERETIV_VEJDU_DD));
					else
						format(msg, sizeof(msg), ""SERVER_MSG"The following duel is available through %s.", timecEn(Player[playerid][pOldDuel]+PERETIV_VEJDU_DD));
					SendClientMessage(playerid,-1,msg);
					return true;
				}else if(gettime()-Player[playe][pOldDuel] < PERETIV_VEJDU_DD){
					if(!LanglePlayer{playerid})
						SendClientMessage(playerid,-1,""SERVER_MSG"Соперник недавно участвовал в дуэли.");
					else
						SendClientMessage(playerid,-1,""SERVER_MSG"Rival recently participated in a duel.");
					return true;
				}else if(AfkPlayer[playe]){
					if(!LanglePlayer{playerid})
						SendClientMessage(playerid,-1,""SERVER_MSG"Данный человек AFK.");
					else
						SendClientMessage(playerid,-1,""SERVER_MSG"This player in AFK.");
					return true;
				}
				for(new i = 0; i < RACE_TRACKS; i++){
					if(!LanglePlayer{playerid})
						strcat(string, Starts[i][rName]);
					else
						strcat(string, Starts[i][rNameEn]);
					if(i !=	(RACE_TRACKS-1))
						strcat(string, "\n");
				}
				ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE+3,DIALOG_STYLE_LIST,"Выбор трассы",string,"Далее","Отмена");	
			}else if(listitem == 3){
				if(!Player[playerid][pAdminPlayer])
					ShowPlayerDialog(playerid,240,DIALOG_STYLE_INPUT,"Пожаловатся на игрока.","Введите текст жалобы","Отправить","Отмена");
				else
					ShowAdminMenu(playerid);
				return true;
			}
			else if(listitem == 4){
    			minidialog = "";
				new status[24],sheater[10];
				if(Player[playe][pAdminPlayer] > 1)
					strcat(status,"Админ");
				else if(Player[playe][pAdminPlayer])
					strcat(status,"Помощник");
				else if(Player[playe][pVIP])
				    strcat(status,"VIP");
				else
				    strcat(status,"Игрок");
				if(Player[playe][pCheater])
				    strcat(sheater,"Да");
				else
				    strcat(sheater,"Нет");
				if(!Player[playerid][pAdminPlayer])
					format(minidialog, sizeof(minidialog), "=============================\n\nНик:\t\t\t%s\nДенег:\t\t\t%d\nСтатус:\t\t\t%s\n\n=============================",Player[playe][PlayerName],GetPlayerCash(playe),status);
				else
					format(minidialog, sizeof(minidialog), "=============================\n\nНик:\t\t\t%s\nДенег:\t\t\t%d\nСтатус:\t\t\t%s\nCкин:\t\t\t%d\nМолчанка:\t\t%d\nПредупреждений:\t%d\nВиртуальный мир:\t%d\nЧитер:\t\t\t%s\n\n=============================",Player[playe][PlayerName],GetPlayerCash(playe), status,GetPlayerSkin(playe),Player[playe][pMuted],GetPVarInt(playe,"warn"),GetPlayerVirtualWorld(playe),sheater);
				ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Статистика игрока.",minidialog,"Закрыть","");
				return true;
			}
			else if(listitem == 5){
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,COLOR_RED,""SERVER_MSG"Ты не водитель транспортного средства.");
				if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(playe)) return SendClientMessage(playerid,COLOR_RED,""SERVER_MSG"Извините, игрок с указанным ID сидит не в вашем авто.");
				RemovePlayerFromVehicle(playe);
				SendClientMessage(playe,COLOR_RED,""SERVER_MSG"Водитель выгнал тебя из транспортного средства.");
				return true;
			}
			else if(listitem == 6){
				new bool:stat[3],
					msg[112];
				stat[0] = IsFrende(playerid,playe);
				stat[1] = InBlackList(playerid,playe);
				stat[2] = IsNoActFrende(playerid,playe);
				if(!stat[0] &&!stat[1] &&  !stat[2])
				    AddInFrend(playerid,playe);
			    else if(stat[0] || stat[2]){
					RemoveInFrendUID(playerid,Player[playe][pSQLID]);
					RemoveInFrendUID(playe,Player[playerid][pSQLID]);
					if(stat[0])
						format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s {FFFFFF}удалил Вас из друзей.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
					else
						format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s {FFFFFF}отменил заявку в друзья.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
					SendClientMessage(playe,-1,msg);
				}
			    else
			        RemoveInBlackUID(playerid,Player[playe][pSQLID]);
			}
			else if(listitem == 7)
				AddInBlackList(playerid,playe);
		}
	case MESSAGES_LIST:
	    {
			if(!response) return ShowSpiski(playerid);
			useduid[playerid] = messagesid[playerid][listitem];
			ShowMsg(playerid,messagesid[playerid][listitem]);
	    }
	case FREND_DIALOG+1:
	    {
			if(!response) return ShowSpiski(playerid);
			useduid[playerid] = Player[playerid][pFrinend][listitem];
			ShowPlayerDialog(playerid, FREND_DIALOG+1+10, DIALOG_STYLE_LIST, "{FFFFFF}..."STRELKI"Список друзей"STRELKI"Опции", ""TEXT_CLAN_11"\nПередать деньги\nУдалить из друзей", "Выбрать", "Отмена");
	    }
	case FREND_DIALOG+1+10:
	    {
			if(!response) return ShowActivitedFrends(playerid);
			if(listitem == 0)
				ShowPlayerInfoToUID(playerid,useduid[playerid]);
			new msg[112];
			if(listitem == 1){
				format(msg,sizeof(msg),"Укажи, сколько денег ты хочешь передать?\nНе менее 100 и не более %d$.",GetPlayerCash(playerid));
				ShowPlayerDialog(playerid, FREND_DIALOG+1+14, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Список друзей"STRELKI"Передача денег", msg, "Далее", "Отмена" );
			}
			if(listitem == 2){
				RemoveInFrendUID(playerid,useduid[playerid]);
				format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s {FFFFFF}удалил Вас из друзей.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
				SendClientMessageToUID(useduid[playerid],-1,msg);
				ShowActivitedFrends(playerid);
			}
	    }
	case FREND_DIALOG+1+14:
	    {
			if(!response) return ShowActivitedFrends(playerid);
			new money = strval(inputtext),
				msgsend[256];
			if(!strlen(inputtext) || money < 100 || money > GetPlayerCash(playerid)){
				format(msgsend,sizeof(msgsend),"Укажи, сколько денег ты хочешь передать?\nНе менее 100 и не более %d$.",GetPlayerCash(playerid));
				return ShowPlayerDialog(playerid, FREND_DIALOG+1+14, DIALOG_STYLE_INPUT, "{FFFFFF}..."STRELKI"Список друзей"STRELKI"Передача денег", msgsend, "Далее", "Отмена" );
			}
            DaiEmyDeneg(playerid, -money);
			msgsend="";
            new id = GetPlayerID(useduid[playerid]);
            if(id == INVALID_PLAYER_ID){
	            format(msgsend,sizeof(msgsend),"INSERT INTO  `messages` ( `pUID`, `Msg`,`MsgTheard`) VALUES ( %i,'%s прислал Вам %d$\nОни были зачислены на Ваш счет автоматически при входе на сервер.\nПриятной игры.','%s прислал Вам деньги')",
	                useduid[playerid],
					Player[playerid][PlayerName],money,
					Player[playerid][PlayerName]
				);
	            mysql_function_query(MYSQL,msgsend, false, "", "");
				SendMoneyUID(money,useduid[playerid]);
			}
			else{
            	DaiEmyDeneg(id, money);
				format(msgsend, sizeof(msgsend), ""SERVER_MSG"Ты получил %d$ от друга {%s}%s{FFFFFF}.", money,chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
				SendClientMessage(id, -1, msgsend);
			}
	    }
	case FREND_DIALOG+2:
	    {
			if(!response) return ShowSpiski(playerid);
			useduid[playerid] = Player[playerid][pNoActFrinend][listitem];
			ShowPlayerDialog(playerid, FREND_DIALOG+2+10, DIALOG_STYLE_LIST, "Опции", ""MENU_PRFX_Spiski""STRELKI"Отменить заявку", "Выбрать", "Отмена");
	    }
	case FREND_DIALOG+2+10:
	    {
			if(!response) return ShowSpiski(playerid);
			if(listitem == 0){
				RemoveInFrendUID(playerid,useduid[playerid]);
				new msg[112];
				format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s {FFFFFF}отменил заявку в друзья.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
				SendClientMessageToUID(useduid[playerid],-1,msg);
			}
	    }
	case FREND_DIALOG+3:
	    {
			if(!response) return ShowSpiski(playerid);
			useduid[playerid] = Player[playerid][pBlackList][listitem];
			ShowPlayerDialog(playerid, FREND_DIALOG+3+10, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Опции", "Убрать из ЧС", "Выбрать", "Отмена");
	    }
	case FREND_DIALOG+3+10:
	    {
			if(!response) return ShowSpiski(playerid);
			if(listitem == 0)
				RemoveInBlackUID(playerid,useduid[playerid]);
	    }
	case FREND_DIALOG+4:
	    {
			if(!response) return ShowSpiski(playerid);
			useduid[playerid] = Player[playerid][pZayavki][listitem];
			ShowPlayerDialog(playerid, FREND_DIALOG+4+10, DIALOG_STYLE_LIST, ""MENU_PRFX_Spiski""STRELKI"Опции", "Принять заявку\nОтклонить заявку", "Выбрать", "Отмена");
	    }
	case FREND_DIALOG+20:
		ShowSpiski(playerid);
	case FREND_DIALOG+4+10:
	    {
			if(!response) return ShowSpiski(playerid);
			if(listitem == 0){
			    if(Player[playerid][pFrinend][MAX_FRENDS-1])
			        return SendClientMessage(playerid, -1, ""SERVER_MSG"У Вас слишком много друзей, максимум "MAX_FRENDSs".");
			   	format(string, sizeof(string),"UPDATE  "FRENDS_TABLE" SET `Accepted` = 1 WHERE `fUID` = %d && `pUID` = %d",Player[playerid][pSQLID],useduid[playerid]);
				mysql_function_query(MYSQL, string, true, "UpdateIDfb", "ii",playerid,useduid[playerid]);
				AddExFrende(playerid,useduid[playerid]);
				new msg[112];
				format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s {FFFFFF}принял Вашу заявку в друзья.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
				SendClientMessageToUID(useduid[playerid],-1,msg);
			}
			if(listitem == 1){
			   	format(string, sizeof(string),"DELETE FROM  "FRENDS_TABLE" WHERE `fUID` = %d && `pUID` = %d",Player[playerid][pSQLID],useduid[playerid]);
				mysql_function_query(MYSQL, string, true, "UpdateIDfb", "ii",playerid,useduid[playerid]);
				playerszayavkinses[playerid]--;
				new usedplayerid = GetPlayerID(useduid[playerid]);
				if(usedplayerid != -1){
					noactivetedfrends[usedplayerid]--;
					new msg[112];
					format(msg,sizeof(msg),""SERVER_MSG"Игрок {%s}%s {FFFFFF}отклонил Вашу заявку в друзья.",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName]);
					SendClientMessage(usedplayerid,-1,msg);
				}
			}
	    }
	case 240:
		{
			if(response)
			{
				if(!IsPlayerConnected(clickedplayeride[playerid])) SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
				new msg[256];
				format(msg, sizeof(msg), ""SERVER_MSG"ВНИМАНИЕ! Игрок %s(%d) жалуется на игрока %s(%d). Причина: {ff0000}%s", Player[playerid][PlayerName], playerid,Player[clickedplayeride[playerid]][PlayerName],clickedplayeride[playerid],inputtext);
				SendAdminMessage(COLOR_WHITE, msg);
				msg = "";
				format(msg, sizeof(msg), ""SERVER_MSG"Ты пожаловался на игрока {%s}%s(%d)",chatcolor[Player[clickedplayeride[playerid]][pColorPlayer]],Player[clickedplayeride[playerid]][PlayerName],clickedplayeride[playerid]);
				SendClientMessage(playerid, COLOR_WHITE, msg);
				msg = "";
				format(msg, sizeof(msg), ""SERVER_MSG"Причина: {a3ff9e}%s",inputtext);
				SendClientMessage(playerid, COLOR_WHITE, msg);
			}
		}
	case 244:
	    {
			if(response)
			{
		 		if(!IsPlayerConnected(clickedplayeride[playerid]) || !Player[clickedplayeride[playerid]][logged])
					return SendClientMessage(playerid,COLOR_WHITE,""SERVER_MSG"Этого игрока нет на сервере либо он не авторизован!");
				if (Player[playerid][pTimeOnlineD] <1 && Player[playerid][pTimeOnlineH] < 1 && Player[playerid][pTimeOnline] < 20)
					return SendClientMessage(playerid, -1, ""SERVER_MSG"Извините, вам рано использовать данную функцию! Необходимое время - 20 мин.");		
       			if(!strlen(inputtext)) return ShowPlayerDialog(playerid,244,DIALOG_STYLE_INPUT,"Передача денег.","Введите сумму","Передать","Отмена");
				if(strval(inputtext) < 1 || strval(inputtext) > GetPlayerCash(playerid)) return ShowPlayerDialog(playerid,244,DIALOG_STYLE_INPUT,"Передача денег.","Введите сумму","Передать","Отмена");
   			   	new msg[256];
   			   	new params[2];
   			   	params[0] = clickedplayeride[playerid];
   			   	params[1] = strval(inputtext);
				DaiEmyDeneg(playerid,-params[1]);
				DaiEmyDeneg(params[0], params[1]);
				printf("%s получил деньги от %s (%d)",Player[params[0]][PlayerName],Player[playerid][PlayerName],params[1]);//chatcolor[Player[playerid][pColorPlayer]],
				format(msg, sizeof(msg), ""SERVER_MSG"Ты отправил {%s}%s{FFFFFF}[ID: %d] $%d.",chatcolor[Player[params[0]][pColorPlayer]], Player[params[0]][PlayerName],params[0], params[1]);
				SendClientMessage(playerid, -1, msg);
				msg = "";
				format(msg, sizeof(msg), ""SERVER_MSG"Ты получил $%d от {%s}%s{FFFFFF}[ID: %d].", params[1],chatcolor[Player[playerid][pColorPlayer]], Player[playerid][PlayerName], playerid);
				SendClientMessage(params[0], -1, msg);
			}
	    }
	case 242:
		{
			if(!response)
				return true;
		    new playe = clickedplayeride[playerid];
			if(!IsPlayerConnected(playe))
				return SendClientMessage(playerid,COLOR_WHITE,""SERVER_MSG"Этого игрока нет на сервере!");
			else if(listitem == 0 && Player[playerid][pAdminPlayer] >= LEVEL_KICK)
				ShowPlayerDialog(playerid,243,DIALOG_STYLE_INPUT,"Кикнуть игрока","Укажите причину кика","Ок","Отмена");
			else if(listitem == 1 && Player[playerid][pAdminPlayer] >= LEVEL_TP)
			{
				if(!PlayerSpectate[playerid])
				{
					if(GetPVarInt(playe,"specc")) return SendClientMessage(playerid, -1, ""SERVER_MSG"Этот игрок за кем-то наблюдает!");
					SetPVarInt(playerid,"specc",0);
					UpdatePlayerPosition(playerid);
					SpectateTimer[playerid] = SetTimerEx("StartSpectate", 1000, true, "ii", playerid, playe);
					SendClientMessage(playerid, -1, "Ты успешно начал наблюдение!");
				}else{
					SetPVarInt(playerid,"specc",0);
					StopSpectate(playerid);
					SendClientMessage(playerid, -1, ""SERVER_MSG"Ты успешно закончил наблюдение!");
				}
			}
			else if(listitem == 2 && Player[playerid][pAdminPlayer] >= LEVEL_TP)
			{
				if(rRaceStatusEx	[playe] == STATUS_RACE_STARTED) return SendClientMessage(playerid,COLOR_WHITE,""SERVER_MSG"Этот игрок находится на дуэли!");
				new Float:plocx,Float:plocy,Float:plocz;
				if(Player[playerid][pAdminPlayer] >= LEVEL_TP)
				{
					GetPlayerPos(playe,plocx,plocy,plocz);
					if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
						t_SetVehiclePos(GetPlayerVehicleID(playerid), plocx, plocy+4, plocz);
					else
						t_SetPlayerPos(playerid,plocx,plocy+2, plocz);
					SetPlayerInterior(playerid,GetPlayerInterior(playe));
					t_SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(playe));
					SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Ты был телепортирован к игроку.");
				}
			}
			else if(listitem == 3 && Player[playerid][pAdminPlayer] >= LEVEL_TP)
			{
				if(rRaceStatusEx	[playe] == STATUS_RACE_STARTED) return SendClientMessage(playerid,COLOR_WHITE,""SERVER_MSG"Этот игрок находится на дуэли!");
				if(!GetPVarInt(playe,"nick")) return SendClientMessage(playerid,COLOR_WHITE,""SERVER_MSG"Этот игрок находится в режиме 'Мувик'!");
				new Float:plocx,Float:plocy,Float:plocz;
				GetPlayerPos(playerid, plocx, plocy, plocz);
				if(GetPlayerState(playe) == PLAYER_STATE_DRIVER)
					t_SetVehiclePos(GetPlayerVehicleID(playe), plocx, plocy+4, plocz);
				else
					t_SetPlayerPos(playe,plocx,plocy+2, plocz);
				SetPlayerInterior(playe,GetPlayerInterior(playerid));
				t_SetPlayerVirtualWorld(playe,GetPlayerVirtualWorld(playerid));
				SendClientMessage(playe, COLOR_WHITE, ""SERVER_MSG"Ты был телепортирован администратором.");
			}
			else if(listitem == 4 && Player[playerid][pAdminPlayer] >= LEVEL_WARN)
				ShowPlayerDialog(playerid,250,DIALOG_STYLE_INPUT,"Выдать предупреждение","Укажите причину предупреждения","Ок","Отмена");
			else if(listitem == 5 && Player[playerid][pAdminPlayer] >= LEVEL_WARN)
			{
				if(!GetPVarInt(playe,"warn"))
					format( string, sizeof(string), ""SERVER_MSG"У %s и так 0 предупреждений!",Player[playe][PlayerName]);
				else if(GetPVarInt(playe,"warn") > 0)
				{
					SetPVarInt(playe,"warn",GetPVarInt(playe,"warn")-1);
					format( string, sizeof(string), ""SERVER_MSG"Администратор %s снял с тебя 1 предупреждение.",Player[playerid][PlayerName]);
					SendClientMessage(playe,PM_INCOMING_COLOR,string);
					string = "";
					format( string, sizeof(string), ""SERVER_MSG"Ты снял с %s 1 предупреждение.",Player[playe][PlayerName]);
				}
				SendClientMessage(playerid,PM_INCOMING_COLOR,string);
			}
			else
				ShowAdminMenu(playerid);
		}
	case 243:
		{
			if(!response) return false;
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid,243,DIALOG_STYLE_INPUT,"Кикнуть игрока","Укажите причину кика","Ок","Отмена");
			KickPlayer(playerid,clickedplayeride[playerid],inputtext);
		}
	case hdialogid:
		{
			if(!houseson || !response) return true;
			new i = GetPVarInt(playerid, "HouseID");
			if(GetPlayerVirtualWorld(playerid) != i+1000){
				if(!HouseInfo[i][howneruid])
				{
					new houses = GetOwnedHouses(playerid);
					if(Player[playerid][pLevel] < 5)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 5 уровня для покупки дома!");
					else if(Player[playerid][pLevel] < 10 && houses == 1)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 10 уровня для покупки ещё одного дома!");
					else if(Player[playerid][pLevel] < 15 && houses >= 2)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 15 уровня для покупки ещё одного дома!");
					if(houses >= MAX_OWNED_HOUSES)
						return SendClientMessage(playerid, -1, ""SERVER_MSG"У тебя слишком много домов!Продайте один из домов если хотите купить новый!");
					if(GetPlayerCash(playerid) < HouseInfo[i][hprice])
						return SendClientMessage(playerid, -1, ""SERVER_MSG"У тебя недостаточно денег для покупки данной недвижимости!");
					DaiEmyDeneg(playerid, -(HouseInfo[i][hprice]));
					format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `howner` = '%s',`howneruid` = '%d' WHERE `hid` = %d;", Player[playerid][PlayerName],Player[playerid][pSQLID], i);
					mysql_function_query(MYSQL, string, true, "BuyingHouse", "dd", playerid, i);
					return UpdateHouseInfo(i);
				}
				else if(!HouseInfo[i][naprodaje] || HouseInfo[i][howneruid] == Player[playerid][pSQLID])
				{
					if(HouseInfo[i][hlock] && HouseInfo[i][howneruid] != Player[playerid][pSQLID])
						return SendClientMessage(playerid, -1, "Данный дом закрыт от посещений");
					SetPlayerInterior(playerid, HouseInfo[i][hint]);
					t_SetPlayerVirtualWorld(playerid, i+1000);
					SetPlayerFacingAngle(playerid, HouseInfo[i][hexitza]);
					SetCameraBehindPlayer(playerid);
					t_SetPlayerPos(playerid,HouseInfo[i][hexitx],HouseInfo[i][hexity],HouseInfo[i][hexitz]);
				}
				else ShowPlayerDialog(playerid, hdialogid+7 , DIALOG_STYLE_LIST, "Меню недвижимости","Войти в дом\nКупить дом", "Ок", "Отмена");
			}else{
				if(HouseInfo[i][howneruid] == Player[playerid][pSQLID])
				{
					SetPVarInt(playerid, "HouseID",i);
					ShowDialogHouse(playerid);
				}else{
					SetPlayerInterior(playerid, HouseInfo[i][hint]);
					t_SetPlayerVirtualWorld(playerid, i+1000);
					SetPlayerFacingAngle(playerid, HouseInfo[i][hexitza]);
					SetCameraBehindPlayer(playerid);
					t_SetPlayerPos(playerid,HouseInfo[i][henterx], HouseInfo[i][hentery], HouseInfo[i][henterz]);
				}
			}
		}
	case hdialogid+1:
		{
			if(!houseson) return false;
			if(response)
			{
				if(!strlen(inputtext)|| strval(inputtext) < 100000 || strval(inputtext) > 10000000)
					return ShowPlayerDialog(playerid, hdialogid+1, DIALOG_STYLE_INPUT, "Создание дома", "Введите цену дома\nОт 100 000 до 10 000 000", "Далее", "Отмена" ),true;
				SetPVarInt(playerid,"HouseCena",strval(inputtext));
				for(new i = 0; i < sizeof(InteriorInfoBuy); i++)
				{
					strcat(string, InteriorInfoBuy[i][iname]);
				}
				ShowPlayerDialog(playerid, hdialogid+2 , DIALOG_STYLE_LIST, ""MENU_PRFX_House""STRELKI"Смена интерьера", string, "Готово", "Отмена");
			}
		}
	case hdialogid+2:
		{
			if(!houseson) return false;
			if(response)
			{
				new Float:coords;
				GetPlayerFacingAngle(playerid, coords);
				SetPVarFloat(playerid,"HouseX",X);
				SetPVarFloat(playerid,"HouseY",Y);
				SetPVarFloat(playerid,"HouseZ",Z);
				SetPVarFloat(playerid,"henterZa",coords);
				SetPVarInt(playerid,"CarIdMenu",listitem);
				SetPVarInt(playerid,"hint",InteriorInfoBuy[listitem][iint]);
    			bigdialog = "";
				format(bigdialog, sizeof(bigdialog),"INSERT INTO  "HOUSE_TABLE" ( `hid`, `henterx`, `hentery`, `henterz`, `henterza`, `hexitx`, `hexity`, `hexitz`, `hexitza`, `howner`, `hprice`, `hint`, `hlock`, `naprodaje`) VALUES ( NULL, %f, %f, %f, %f, %f, %f, %f, %f, NULL, %d, %d, 0, 0)",
					X,
					Y,
					Z,
					coords,
					InteriorInfoBuy[listitem][ix],
					InteriorInfoBuy[listitem][iy],
					InteriorInfoBuy[listitem][iz],
					InteriorInfoBuy[listitem][iza],
					GetPVarInt(playerid,"HouseCena"),
					InteriorInfoBuy[listitem][iint]
				);
				mysql_function_query(MYSQL, bigdialog, true, "CreateHouse", "d",playerid);
			}
		}
	case hdialogid+3:
		{
			if(!houseson) return false;
			if(response)
			{
				switch(listitem)
				{
				case 0:
					{
						if(HouseInfo[GetPVarInt(playerid,"HouseID")][hlock] == false)
						{
							HouseInfo[GetPVarInt(playerid,"HouseID")][hlock] = true;
							format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `hlock` = '1' WHERE `hid` = %d;", GetPVarInt(playerid,"HouseID"));
						}
						else
						{
							HouseInfo[GetPVarInt(playerid,"HouseID")][hlock] = false;
							format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `hlock` = '0' WHERE `hid` = %d;", GetPVarInt(playerid,"HouseID"));
						}
						mysql_function_query(MYSQL, string, false, "","");
						ShowDialogHouse(playerid);
					}
				case 1:
					{
						new i_ = GetPVarInt(playerid,"HouseID");
						if(GetPlayerInterior(playerid) == 0)
						{
							t_SetPlayerPos(playerid,HouseInfo[i_][hexitx],HouseInfo[i_][hexity],HouseInfo[i_][hexitz]);
							SetPlayerFacingAngle(playerid, HouseInfo[i_][hexitza]);
							t_SetPlayerVirtualWorld(playerid, i_+1000);
							SetPlayerInterior(playerid,HouseInfo[i_][hint]);
						}
						else
						{
							SetPlayerInterior(playerid, 0);
							t_SetPlayerVirtualWorld(playerid, 0);
							SetPlayerFacingAngle(playerid, HouseInfo[i_][henterza]);
							SetCameraBehindPlayer(playerid);
							t_SetPlayerPos(playerid,HouseInfo[i_][henterx],HouseInfo[i_][hentery],HouseInfo[i_][henterz]);
						}
					}
				case 2:
					{
						new query[128],i_ = GetPVarInt(playerid,"HouseID");
						if(HouseInfo[i_][howneruid] != Player[playerid][pSQLID]) return 0;
						format(query, sizeof(query),"UPDATE  "HOUSE_TABLE" SET `howner` = 'NULL',`howneruid` = '0',`hLock` = 0 WHERE `hid` = %d;",i_);
						mysql_function_query(MYSQL, query, true, "SaledHouse", "dd", playerid, i_);
					}
				case 3:
					{
						new i_ = GetPVarInt(playerid,"HouseID"),
							textdia[128];
						if(HouseInfo[i_][naprodaje] == 0){
							format(textdia, sizeof(textdia),"Укажите цену дома.\nУчтите, цена этого дома не может быть меньше чем %d.",HouseInfo[i_][hprice]);
							ShowPlayerDialog(playerid, hdialogid+6, DIALOG_STYLE_INPUT, ""MENU_PRFX_House""STRELKI"Выставить дом на продажу",textdia, "Далее", "Отмена" );
						}else{
							HouseInfo[i_][naprodaje] = 0;
							format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `naprodaje` = '0' WHERE `hid` = %d;", GetPVarInt(playerid,"HouseID"));
							mysql_function_query(MYSQL, string, false, "","");
							UpdateHouseInfo(i_);
							ShowDialogHouse(playerid);
						}
						return true;
					}
				case 4:
					{
						for(new i = 0; i < sizeof(InteriorInfoBuy); i++)
						{
							strcat(string, InteriorInfoBuy[i][iname]);
						}
						ShowPlayerDialog(playerid, hdialogid+5 , DIALOG_STYLE_LIST, ""MENU_PRFX_House""STRELKI"Смена интерьера", string, "Готово", "Отмена");
					}
				case 5:
					{
						new i_ = GetPVarInt(playerid,"HouseID");
						for(new f = 0, all = MAX_PLAYERS; f < all; f++){
							if(!IsPlayerConnected(f) || !Player[f][logged])continue;
							if(GetPlayerVirtualWorld(f) == (i_+1000)){
								if(HouseInfo[i_][howneruid] != Player[playerid][pSQLID]){
									t_SetPlayerPos(playerid,HouseInfo[i_][henterx],HouseInfo[i_][hentery],HouseInfo[i_][henterz]);
									SetPlayerFacingAngle(f,InteriorInfoBuy[i_][iza]);
									SetPlayerInterior(f,InteriorInfoBuy[i_][iint]);
		}	}	}	}	}	}	}
	case hdialogid+4:
		{
			if(!houseson) return false;
			if(response)
			{
				SetPVarInt(playerid, "HouseID", ReturnPlayerHouseID(playerid, (listitem + 1)));
				ShowDialogHouse(playerid);
			}
		}
	case hdialogid+5:
		{
			if(!houseson) return false;
			if(response)
			{
				if(GetPlayerCash(playerid) < InteriorInfoBuy[listitem][price])
				{
					for(new i = 0; i < MAX_INTERIOR; i++)
					{
						strcat(string, InteriorInfoBuy[i][iname]);
					}
					ShowPlayerDialog(playerid, hdialogid+5 , DIALOG_STYLE_LIST, ""MENU_PRFX_House""STRELKI"Смена интерьера", string, "Готово", "Отмена");
					return SendClientMessage(playerid,-1,""SERVER_MSG"У тебя недостаточно денег для покупки данного интерьера.");
				}
				else
				{
					DaiEmyDeneg(playerid,-InteriorInfoBuy[listitem][price]);
					new i_ = GetPVarInt(playerid,"HouseID");
     				for(new f = 0, all = MAX_PLAYERS; f < all; f++)
					{
						if(!IsPlayerConnected(f))continue;
 						if(!Player[f][logged])continue;
						if(GetPlayerVirtualWorld(f) == (i_+1000))
						{
							t_SetPlayerPos(f,InteriorInfoBuy[listitem][ix],InteriorInfoBuy[listitem][iy],InteriorInfoBuy[listitem][iz]);
							SetPlayerFacingAngle(f,InteriorInfoBuy[listitem][iza]);
							SetPlayerInterior(f,InteriorInfoBuy[listitem][iint]);
						}
					}
					HouseInfo[i_][hexitx] = InteriorInfoBuy[listitem][ix];
					HouseInfo[i_][hexity] = InteriorInfoBuy[listitem][iy];
					HouseInfo[i_][hexitz] = InteriorInfoBuy[listitem][iz];
					HouseInfo[i_][hexitza] = InteriorInfoBuy[listitem][iza];
					HouseInfo[i_][hint] = InteriorInfoBuy[listitem][iint];
					DestroyDynamicPickup(HouseInfo[i_][hpickup2]);
					HouseInfo[i_][hpickup2] = CreateDynamicPickup (1318, 1, HouseInfo[i_][hexitx], HouseInfo[i_][hexity], HouseInfo[i_][hexitz], i_+1000);
					pHID[HouseInfo[i_][hpickup2]] = i_;
					new query[256];
					format(query, sizeof(query),"UPDATE  "HOUSE_TABLE" SET `hexitx` = %f, `hexity` = %f, `hexitz` = %f, `hexitza` = %f,`hint` = %d WHERE `hid` = %d;",
					InteriorInfoBuy[listitem][ix],
					InteriorInfoBuy[listitem][iy],
					InteriorInfoBuy[listitem][iz],
					InteriorInfoBuy[listitem][iza],
					InteriorInfoBuy[listitem][iint],
					i_
					);
					mysql_function_query(MYSQL, query, false, "", "");
				}
			}
			ShowDialogHouse(playerid);
		}
	case hdialogid+6:
		{
			if(!houseson) return false;
			if(response)
			{
				new i_ = GetPVarInt(playerid,"HouseID");
				if(strval(inputtext) < HouseInfo[i_][hprice])
				{
					SendClientMessage(playerid,-1,""SERVER_MSG"Недопустимая цена дома!");
					new textdia[128];
					format(textdia, sizeof(textdia),"Укажите цену дома.\nУчтите, цена этого дома не может быть меньше чем %d.",HouseInfo[i_][hprice]);
					ShowPlayerDialog(playerid, hdialogid+6, DIALOG_STYLE_INPUT, ""MENU_PRFX_House""STRELKI"Выставить дом на продажу",textdia, "Далее", "Отмена" );
				}
				else
				{
					HouseInfo[i_][hprice2] = strval(inputtext);
					HouseInfo[i_][naprodaje] = 1;
					format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `hprice2` = '%d' , `naprodaje` = 1 WHERE `hid` = %d;", strval(inputtext), i_);
					mysql_function_query(MYSQL, string, false, "","");
					UpdateHouseInfo(i_);
					ShowDialogHouse(playerid);
				}
			}else
				ShowDialogHouse(playerid);
			return true;
		}
	case hdialogid+7:
		{
			if(!houseson) return false;
			if(response)
			{
				new
					i_ = GetPVarInt(playerid,"HouseID"),
					strings[128];
				switch(listitem)
				{
					case 0:
					{
						if(HouseInfo[i_][hlock] && HouseInfo[i_][howneruid] != Player[playerid][pSQLID])
							return SendClientMessage(playerid, -1, ""SERVER_MSG"Данный дом закрыт от посещений");
						SetPlayerInterior(playerid, HouseInfo[i_][hint]);
						t_SetPlayerVirtualWorld(playerid, i_+1000);
						SetPlayerFacingAngle(playerid, HouseInfo[i_][hexitza]);
						SetCameraBehindPlayer(playerid);
						t_SetPlayerPos(playerid,HouseInfo[i_][hexitx],HouseInfo[i_][hexity],HouseInfo[i_][hexitz]
						);
					}
					case 1:
					{
						if(GetPlayerCash(playerid) < HouseInfo[i_][hprice2])
							return SendClientMessage(playerid,-1, ""SERVER_MSG"У тебя недостаточно денег!");
						format(strings, sizeof(strings),"Ты действительно хочешь приобрести данный дом (ID%d) за %d$ ?",i_, HouseInfo[i_][hprice2]);
						ShowPlayerDialog(playerid, hdialogid+8, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"",strings, "Да", "Отмена" );
						SetPVarInt(playerid,"hprice2",HouseInfo[i_][hprice2]);
					}
				}
			}
			return true;
		}
	case hdialogid+8:
		{
			if(!houseson) return false;
			if(response)
			{
				new houses = GetOwnedHouses(playerid);
			    if(Player[playerid][pLevel] < 5)
			        return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 5 уровня для покупки дома!");
			    else if(Player[playerid][pLevel] < 10 && houses == 1)
			        return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 10 уровня для покупки ещё одного дома!");
			    else if(Player[playerid][pLevel] < 15 && houses >= 2)
			        return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 15 уровня для покупки ещё одного дома!");
				new
					i_ = GetPVarInt(playerid,"HouseID"),
					owner = GetPlayerNickId(HouseInfo[i_][howner])
				;
				if(!strcmp(HouseInfo[i_][howner], "NULL", false)) return 0;
				if(GetOwnedHouses(playerid) >= MAX_OWNED_HOUSES)
					return SendClientMessage(playerid, -1, ""SERVER_MSG"У тебя слишком много домов!Продайте один из домов если хотите купить новый!");
				if(GetPlayerCash(playerid) < HouseInfo[i_][hprice2])
					return SendClientMessage(playerid,-1, ""SERVER_MSG"У тебя недостаточно денег!");
				if(owner < 0)
					SendMoney(HouseInfo[i_][hprice2],HouseInfo[i_][howner]);
				else
				    DaiEmyDeneg(owner, GetPVarInt(playerid,"hprice2"));
				DaiEmyDeneg(playerid, -(GetPVarInt(playerid,"hprice2")));
				format(string, sizeof(string),"UPDATE  "HOUSE_TABLE" SET `howner` = '%s',`howneruid` = '%d',`naprodaje` = '0' WHERE `hid` = %d;", Player[playerid][PlayerName],Player[playerid][pSQLID], i_);
				mysql_function_query(MYSQL, string, true, "BuyingHouse", "dd", playerid, i_);
				return true;
			}
		}
	case hdialogid+9:
		{
			if(response)
			{
    			new msg[112];
				if(!houseson){
					format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s Включил дома.", Player[playerid][PlayerName]);
					format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s  include houses.", Player[playerid][PlayerName]);
					t_SendClientMessageToAll(-1,-1,msg,msgcheatEn);
					mysql_function_query(MYSQL, "SELECT * FROM  "HOUSE_TABLE"", true, "LoadHouses", "");
				}
				else{
					format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s Выключил дома.", Player[playerid][PlayerName]);
					format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s  switch off houses.", Player[playerid][PlayerName]);
					t_SendClientMessageToAll(-1,-1,msg,msgcheatEn);
					UnLoadHouses();
				}
				return true;
			}
		}
	case 250:
		{
			if(!response) return true;
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid,250,DIALOG_STYLE_INPUT,"Предупредить игрока","Укажите причину предупреждения","Ок","Отмена");
			GiveWarn(playerid,clickedplayeride[playerid],inputtext);
			return true;
		}
	case 251:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(GetPlayerCash(playerid) < 1000000)
					{
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
						return 0;
					}
					if(Player[playerid][pVIP])
						return SendClientMessage(playerid,-1,""SERVER_MSG"У VIP бесконечные касты!");
					DaiEmyDeneg(playerid,-1000000);
					Player[playerid][pDoubleDriftT] = Player[playerid][pDoubleDriftT]+60;
					if(Player[playerid][pDoubleDrift] == false)
					{
						Player[playerid][pDoubleDrift] = true;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Ты успешно купил каст 'DoubleDrift' на 1 час!");
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Теперь тебе будет выдаваться в 2 раза больше очков дрифта!");
						ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
					}
					else
					{
						new msg[112];
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Ты успешно продлил каст 'DoubleDrift' на 1 час!");
						format( msg, sizeof(msg), ""SERVER_MSG"Теперь общее время каста %d минут",Player[playerid][pDoubleDriftT]);
						SendClientMessage(playerid,-1, msg);
						ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
					}
				}
				else if(listitem == 1)
				{
					if(GetPlayerCash(playerid) < 500000)
					{
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
						return 0;
					}
					if(Player[playerid][pVIP])
						return SendClientMessage(playerid,-1,""SERVER_MSG"У VIP бесконечные касты!");
					DaiEmyDeneg(playerid,-500000);
					Player[playerid][pNoCrashTime] = Player[playerid][pNoCrashTime]+60;
					if(Player[playerid][pNoCrash] == false)
					{
						Player[playerid][pNoCrash] = true;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Ты успешно купил каст 'NoCrash' на 1 час!");
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Теперь ты можешь врезаться, и это не оборвет дрифт!");
						ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"Ты успешно продлил каст 'NoCrash' на 1 час!");
						new msg[112];
						format( msg, sizeof(msg), ""SERVER_MSG"Теперь общее время каста %d минут",Player[playerid][pNoCrashTime]);
						SendClientMessage(playerid,-1, msg);
						ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
					}
				}
			}
			else ShowDialogSintEx(playerid);
	}
	case 191:
				ShowMenuForPlayerEx(playerid);
	case 228:
		{
			if(!response) return true;
			else if(listitem == 0)
				ShowBuyCarDialog(playerid);
			else if(listitem == 1)
				ShowAllTeleports(playerid);
			else if(listitem == 2)
				ShowMenuChar(playerid);
			else if(listitem == 3){
    			bigdialog = "";
				if(!LanglePlayer{playerid}){
					strcat(bigdialog, "{FFFFFF}\t\t----| Используйте меню: |----\n");
					strcat(bigdialog, "Большинство функций сервера есть в меню\n");
					strcat(bigdialog, "\tчтобы оно открылось нужно\n");
					if(Player[playerid][pKeyMenu])
						strcat(bigdialog, "\t\tНажать кнопку \"{00f5da}Alt / 2{FFFFFF}\"\n");
					else
						strcat(bigdialog, "\t\tНажать кнопку \"{00f5da}Y{FFFFFF}\"\n");
					strcat(bigdialog, "\t\t----| Дополнительно: |----\n");
					strcat(bigdialog, "\"{00f5da}/topmoney{FFFFFF}\"\t\t[TOP] Самых богатых людей на сервере\n");
					strcat(bigdialog, "\"{00f5da}/toplevel{FFFFFF}\"\t\t[TOP] Игроков по уровням\n");
					strcat(bigdialog, "\"{00f5da}/count (3-10){FFFFFF}\"\t\tОтсчет\n");
					strcat(bigdialog, "\"{00f5da}/f{FFFFFF}\"\t\t\tПеревернуть авто [Флипнуть]\n");
					strcat(bigdialog, "\"{00f5da}/drag (1-2){FFFFFF}\"\t\tТелепорт на драг трассы\n");
					strcat(bigdialog, "\"{00f5da}/drift (1-16){FFFFFF}\"\t\tТелепорт на дрифт трассы\n");
					strcat(bigdialog, "\"{00f5da}/dt (0-99){FFFFFF}\"\t\tСменить виртуальный мир\n");
					strcat(bigdialog, "\"{00f5da}/ct (0-1000){FFFFFF}\"\t\tСменить чат комнату\n");
					strcat(bigdialog, "\"{00f5da}/alldt{FFFFFF}\"\t\t\tОбщий виртуальный мир\n");
					strcat(bigdialog, "\"{00f5da}/textur{FFFFFF}\"\t\tВернуть текстуры [на случай если пропадут]\n");
					strcat(bigdialog, "\"{00f5da}/kill{FFFFFF}\"\t\t\tСамоубийство\n");
					strcat(bigdialog, "\"{00f5da}/time{FFFFFF}\"\t\t\tВремя: Кастов, Остатка VIP, Ареста\n");
					strcat(bigdialog, "\"{00f5da}/admins{FFFFFF}\"\t\tСписок администраторов\n");
					strcat(bigdialog, "\"{00f5da}/vips{FFFFFF}\"\t\t\t"TEXT_CLAN_11" о VIP\n");
					strcat(bigdialog, "\"{00f5da}/kickme{FFFFFF}\"\t\tКикнуть себя\n");
					strcat(bigdialog, "\"{00f5da}/help{FFFFFF}\"\t\t\tПомощь по серверу\n");
					strcat(bigdialog, "\"{00f5da}/ask{FFFFFF}\"\t\t\tВопрос по игре\n");
					strcat(bigdialog, "\"{00f5da}/rules{FFFFFF}\"\t\tПравила сервера\n");
					strcat(bigdialog, "\"{00f5da}/ccme{FFFFFF}\"\t\tОчистить свой чат\n");
					strcat(bigdialog, "\"{00f5da}/moove{FFFFFF}\"\t\tРежим Moovie [Режим для снятия видео]\n");
					strcat(bigdialog, "\"{00f5da}/mystat{FFFFFF}\"\t\tСтатистика аккаунта\n");
					strcat(bigdialog, "\"{00f5da}/remov (ID){FFFFFF}\"\t\tВыгнать человека из авто\n");
					strcat(bigdialog, "\"{00f5da}/ob (text){FFFFFF}\"\t\tПодать объявление\n");
					strcat(bigdialog, "\"{00f5da}/givecash{FFFFFF}\"\t\tПередать деньги\n");
					strcat(bigdialog, "\"{00f5da}/mydt{FFFFFF}\"\t\t\tУзнать свой виртуальный мир");
					return ShowPlayerDialog(playerid, 191, DIALOG_STYLE_MSGBOX, "HELP по серверу", bigdialog, "Ок", "");
				}else{
					strcat(bigdialog, "{FFFFFF}\t\t----| Used menu: |----\n");
					strcat(bigdialog, "The majority of functions of the server is in the menu\n");
					strcat(bigdialog, "\tit would open it is necessary\n");
					if(Player[playerid][pKeyMenu])
						strcat(bigdialog, "\t\tTo press the button \"{00f5da}Alt / 2{FFFFFF}\"\n");
					else
						strcat(bigdialog, "\t\tTo press the button \"{00f5da}Y{FFFFFF}\"\n");
					strcat(bigdialog, "\t\t----| Additional: |----\n");
					strcat(bigdialog, "\"{00f5da}/topmoney{FFFFFF}\"\t\t[TOP] The richest people on the server\n");
					strcat(bigdialog, "\"{00f5da}/toplevel{FFFFFF}\"\t\t[TOP] Players on levels\n");
					strcat(bigdialog, "\"{00f5da}/count (3-10){FFFFFF}\"\t\tCount\n");
					strcat(bigdialog, "\"{00f5da}/f{FFFFFF}\"\t\t\tTo turn a car [flipped]\n");
					strcat(bigdialog, "\"{00f5da}/drag (1-2){FFFFFF}\"\t\tTeleport on route drags\n");
					strcat(bigdialog, "\"{00f5da}/drift (1-16){FFFFFF}\"\t\tTeleport on a route drift\n");
					strcat(bigdialog, "\"{00f5da}/dt (0-99){FFFFFF}\"\t\tTo replace the virtual world\n");
					strcat(bigdialog, "\"{00f5da}/ct (0-1000){FFFFFF}\"\t\tTo replace a chat the room\n");
					strcat(bigdialog, "\"{00f5da}/alldt{FFFFFF}\"\t\t\tGeneral virtual world\n");
					strcat(bigdialog, "\"{00f5da}/textur{FFFFFF}\"\t\tTo return textures [on a case if are gone]\n");
					strcat(bigdialog, "\"{00f5da}/kill{FFFFFF}\"\t\t\tSuicide\n");
					strcat(bigdialog, "\"{00f5da}/time{FFFFFF}\"\t\t\tTime: Additions, Residual VIP, Arresting\n");
					strcat(bigdialog, "\"{00f5da}/admins{FFFFFF}\"\t\tList of administrators\n");
					strcat(bigdialog, "\"{00f5da}/vips{FFFFFF}\"\t\t\tInformation about the VIP\n");
					strcat(bigdialog, "\"{00f5da}/kickme{FFFFFF}\"\t\tKick itself\n");
					strcat(bigdialog, "\"{00f5da}/help{FFFFFF}\"\t\t\tHelp with the server\n");
					strcat(bigdialog, "\"{00f5da}/ask{FFFFFF}\"\t\t\tAsk on game\n");
					strcat(bigdialog, "\"{00f5da}/rules{FFFFFF}\"\t\tServer rules\n");
					strcat(bigdialog, "\"{00f5da}/ccme{FFFFFF}\"\t\tTo clear the chat\n");
					strcat(bigdialog, "\"{00f5da}/moove{FFFFFF}\"\t\tThe Moovie mode [A mode for video removal]\n");
					strcat(bigdialog, "\"{00f5da}/mystat{FFFFFF}\"\t\tStatistics of an account\n");
					strcat(bigdialog, "\"{00f5da}/remov (ID){FFFFFF}\"\t\tTo expel the person from a car\n");
					strcat(bigdialog, "\"{00f5da}/ob (text){FFFFFF}\"\t\tTo give declaration\n");
					strcat(bigdialog, "\"{00f5da}/givecash{FFFFFF}\"\t\tTo transfer money\n");
					strcat(bigdialog, "\"{00f5da}/mydt{FFFFFF}\"\t\tTo learn the virtual world");
					return ShowPlayerDialog(playerid, 191, DIALOG_STYLE_MSGBOX, "HELP on the server", bigdialog, "Ok", "");
				}
			}
			else if(listitem == 4)
				ShowDialogSint(playerid);
			else if(listitem == 5)
				ShowPlayerClans(playerid);
			else if(listitem == 6){
			   	if(!houseson){
					if(!LanglePlayer{playerid}) return ShowPlayerDialog(playerid, 191, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"","{F6F6F6}Извините, дома отключены администратором.", "Ок", "");
					else return ShowPlayerDialog(playerid, 191, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House_EN"","{F6F6F6}Excuse, houses Are switched off by the administrator.", "Ok", "");
				}
				new count = GetOwnedHouses(playerid);
				if(count < 1){
					if(!LanglePlayer{playerid}) return ShowPlayerDialog(playerid, 191, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"","{F6F6F6}Ты не являешься владельцем дома.", "Ок", "");
					else return ShowPlayerDialog(playerid, 191, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House_EN"","{F6F6F6}You aren't the owner of the house.", "Ok", "");
				}
				new h = 1, _tmpstring[128];
    			minidialog = "";
				for(new i = 0; i < TotalHouses; i++){
					if(HouseInfo[i][howneruid] != Player[playerid][pSQLID]) continue;
					if(h == count)format(_tmpstring, sizeof(_tmpstring), "{FFFFFF}%d]\t{00f5da} [ID %d]", h, i);
					else format(_tmpstring, sizeof(_tmpstring), "{FFFFFF}%d]\t{00f5da} [ID %d]\n", h, i);
					strcat(minidialog, _tmpstring);
					h += 1;
				}
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid, hdialogid+4, DIALOG_STYLE_LIST, ""MENU_PRFX_House"", minidialog, "Выбрать", "Отмена");
				else
					ShowPlayerDialog(playerid, hdialogid+4, DIALOG_STYLE_LIST, ""MENU_PRFX_House_EN"", minidialog, "Select", "Cancel");
	           }
			else if(listitem == 7)
				ShowSpiski(playerid);
			else if(listitem == 8){
				if(rRaceStatusEx[playerid] == STATUS_RACE_WAIT)
					rRaceStatusEx[playerid] = STATUS_NO_RACE;
				else if(rRaceStatusEx[playerid] == STATUS_NO_RACE){
					if(Player[playerid][pLevel] < 10){
						if(!LanglePlayer{playerid})
							SendClientMessage(playerid,-1,""SERVER_MSG"Для участия в дуэли необходим 10 уровень!");
						else
							SendClientMessage(playerid,-1,""SERVER_MSG"The 10th level is necessary for involvement in duel!");
						return true;
					}
					if(gettime()-Player[playerid][pOldDuel] < PERETIV_VEJDU_DD){
						new msg[112];
						if(!LanglePlayer{playerid}){
							format(msg, sizeof(msg), ""SERVER_MSG"Следующая дуэль доступна через %s.", timec(Player[playerid][pOldDuel]+PERETIV_VEJDU_DD));
							SendClientMessage(playerid,-1,msg);
						}else{
							format(msg, sizeof(msg), ""SERVER_MSG"The following duel is available through %s.", timecEn(Player[playerid][pOldDuel]+PERETIV_VEJDU_DD));
							SendClientMessage(playerid,-1,msg);
						}
						return true;
					}	
					if(GetPlayerCash(playerid) < 12500){
						if(!LanglePlayer{playerid})
							SendClientMessage(playerid, -1, ""SERVER_MSG"У тебя недостаточно денег даже для минимальной ставки (12500$)!");
						else
							SendClientMessage(playerid, -1, ""SERVER_MSG"You haven't enough money even for the minimum rate (12500$)!");
						return true;
					}
					rRaceStatusEx[playerid] = STATUS_RACE_WAIT;
					if(!LanglePlayer{playerid})
						SendClientMessage(playerid, -1, ""SERVER_MSG"Ожидайте пока система подберет вам соперника!");
					else
						SendClientMessage(playerid, -1, ""SERVER_MSG"Expect system will find to you the rival!");
		}	}	}
	case 260:
		{
		    if(!response)
				return ShowMenuForPlayerEx(playerid);
		    if(listitem == 0)
				ShowActivitedFrends(playerid);
		    else if(listitem == 1)
				ShowNoActivitedFrends(playerid);
		    else if(listitem == 2)
				ShowBlackListMini(playerid);
			else if(listitem == 3)
                ShowZaiyavkiInFrends(playerid);
			else if(listitem == 4)
			    ShowMessages(playerid);
		}
	case 302:
	    {
	        if(!response) return true;
         	//ShowModelSelectionMenu(playerid, skinlist, FixText("Смена скина"));
	    }
	case START_INFO_DIALOG:
	    {
			bigdialog = "";
			if(!LanglePlayer{playerid}){
				strcat(bigdialog, "{FFFFFF}\t\tПравила игрового сервера "SERVER_NAME"\n");
				strcat(bigdialog, "1) НЕ использовать программы/читы/настройки игрового клиента дающие преимущество над игроками\n");
				strcat(bigdialog, "2) НЕ оскорблять игроков, их близких и родственников.\n");
				strcat(bigdialog, "3) Запрещен спам, флуд *offtop* в чат или личку\n");
				strcat(bigdialog, "4) Запрещены игр. Ники не имеющие смысла типо*abija* или Ники с нецензурной лексикой.\n");
				strcat(bigdialog, "5) Запрещено намеренно убивать игроков.\n");
				strcat(bigdialog, "6) Запрещено использовать *баг* сервера.\n");
				strcat(bigdialog, "7) Запрещены угрозы в адрес сервера/администратора.\n");
				strcat(bigdialog, "8) Запрещены попытки навредить серверу.\n");
				strcat(bigdialog, "9) Если ты снимаешь мув./ тренируешься, уйди в /dt а не проси остальных делать это.\n");
				strcat(bigdialog, "10) Запрещено попрошайничество – денег, скорэ, админки.\n");
				strcat(bigdialog, "11) Если ты увидел читера сообщи администратору НЕ в чат, а через Репорт (/rep id причина)\n");
				strcat(bigdialog, "12) Если ты устраиваешь гонки, попроси Администратора помочь тебе. Во избежание недоразумений!\n");
				strcat(bigdialog, "13) Запрещен подбор паролей через сайт.\n");
				strcat(bigdialog, "14) Запрещено обсуждение действий администратора.\n");
				strcat(bigdialog, "\t\tНезнание правил НЕ освобождает вас от ответственности\n");
				ShowPlayerDialog(playerid, START_INFO_DIALOG+1, DIALOG_STYLE_MSGBOX, "{00f5da}>>{ffffff} Правила сервера", bigdialog, "Ок", "");
			}else{
				strcat(bigdialog, "{FFFFFF}\t\t"SERVER_NAME" Rules\n");
				strcat(bigdialog, "1) Don't use programs/cheats/setup of the game client that give priority at over players\n");
				strcat(bigdialog, "2) Don't offend players, their relatives.\n");
				strcat(bigdialog, "3) Don't spam, flood *offtop* in a chat/pm\n");
				strcat(bigdialog, "4) Forbidden Nicknames, which doesn't making sense or Nicknames with obscene lexicon.\n");
				strcat(bigdialog, "5) Forbidden special kill players\n");
				strcat(bigdialog, "6) Forbidden use server bugs.\n");
				strcat(bigdialog, "7) Forbidden threats to the server/administrator.\n");
				strcat(bigdialog, "8) Forbidden attempts a herm this server.\n");
				strcat(bigdialog, "9) If you make a video/training you skill, please change your virtual world (/dt)\n");
				strcat(bigdialog, "10) Forbidden begging – money, level, admin level.\n");
				strcat(bigdialog, "11) If you saw a cheater, send report in /rep, don't write it to chat\n");
				strcat(bigdialog, "12) If you arrange races, ask the Administrator to help you.\n");
				strcat(bigdialog, "13) Forbidden selection of passwords through a site.\n");
				strcat(bigdialog, "14) Forbidden discussion of actions of the administrator.\n");
				strcat(bigdialog, "\t\tIgnorance of rules NOT exempts you from liability\n");
				ShowPlayerDialog(playerid, START_INFO_DIALOG+1, DIALOG_STYLE_MSGBOX, "{00f5da}>>{ffffff} Rules", bigdialog, "Ок", "");
			}
		}
	case START_INFO_DIALOG+1:
		{
			SetPVarInt(playerid,"PlayerReg",1);
			SelectTextDraw(playerid, 0xFFFFFFFF);
			Inf_NewPlayer[playerid] = CreatePlayerTextDraw(playerid,256.000000, 180.000000, "_"); 
			PlayerTextDrawAlignment(playerid,Inf_NewPlayer[playerid], 2); 
			PlayerTextDrawBackgroundColor(playerid,Inf_NewPlayer[playerid], 0x00000000); 
			PlayerTextDrawFont(playerid,Inf_NewPlayer[playerid], 5); 
			PlayerTextDrawLetterSize(playerid,Inf_NewPlayer[playerid], 1.809999, 7.699995); 
			PlayerTextDrawColor(playerid,Inf_NewPlayer[playerid], -1); 
			PlayerTextDrawSetOutline(playerid,Inf_NewPlayer[playerid], 1); 
			PlayerTextDrawSetProportional(playerid,Inf_NewPlayer[playerid], 1); 
			PlayerTextDrawUseBox(playerid,Inf_NewPlayer[playerid], 1); 
			PlayerTextDrawBoxColor(playerid,Inf_NewPlayer[playerid], 0x00000000); 
			PlayerTextDrawTextSize(playerid,Inf_NewPlayer[playerid], 94.000000, 72.000000); 
			//PlayerTextDrawSetPreviewModel(playerid, Inf_NewPlayer[playerid], 429);
			//PlayerTextDrawSetPreviewVehCol(playerid, Inf_NewPlayer[playerid], 1,1);
			//PlayerTextDrawSetPreviewRot(playerid, Inf_NewPlayer[playerid],  -16.0, 0.0, -55.0, 0.9);
			PlayerTextDrawSetSelectable(playerid,Inf_NewPlayer[playerid], 1); 
			Elegy_NewPlayer[playerid] = CreatePlayerTextDraw(playerid,135.000000, 180.000000, "_"); 
			PlayerTextDrawAlignment(playerid,Elegy_NewPlayer[playerid], 2); 
			PlayerTextDrawBackgroundColor(playerid,Elegy_NewPlayer[playerid], 0x00000000); 
			PlayerTextDrawFont(playerid,Elegy_NewPlayer[playerid], 5); 
			PlayerTextDrawLetterSize(playerid,Elegy_NewPlayer[playerid], 1.809999, 7.699995); 
			PlayerTextDrawColor(playerid,Elegy_NewPlayer[playerid], -1); 
			PlayerTextDrawSetOutline(playerid,Elegy_NewPlayer[playerid], 1); 
			PlayerTextDrawSetProportional(playerid,Elegy_NewPlayer[playerid], 1); 
			PlayerTextDrawUseBox(playerid,Elegy_NewPlayer[playerid], 1); 
			PlayerTextDrawBoxColor(playerid,Elegy_NewPlayer[playerid], 0x00000000); 
			PlayerTextDrawTextSize(playerid,Elegy_NewPlayer[playerid], 94.000000, 72.000000); 
			//PlayerTextDrawSetPreviewModel(playerid, Elegy_NewPlayer[playerid], 562);
			//PlayerTextDrawSetPreviewVehCol(playerid, Elegy_NewPlayer[playerid], 1,1);
			//PlayerTextDrawSetPreviewRot(playerid, Elegy_NewPlayer[playerid],  -16.0, 0.0, -55.0, 0.9);
			PlayerTextDrawSetSelectable(playerid,Elegy_NewPlayer[playerid], 1); 
			Sul_NewPlayer[playerid] = CreatePlayerTextDraw(playerid,377.000000, 180.000000, "_"); 
			PlayerTextDrawAlignment(playerid,Sul_NewPlayer[playerid], 2); 
			PlayerTextDrawBackgroundColor(playerid,Sul_NewPlayer[playerid], 0x00000000); 
			PlayerTextDrawFont(playerid,Sul_NewPlayer[playerid], 5); 
			PlayerTextDrawLetterSize(playerid,Sul_NewPlayer[playerid], 1.809999, 7.699995); 
			PlayerTextDrawColor(playerid,Sul_NewPlayer[playerid], -1); 
			PlayerTextDrawSetOutline(playerid,Sul_NewPlayer[playerid], 1); 
			PlayerTextDrawSetProportional(playerid,Sul_NewPlayer[playerid], 1); 
			PlayerTextDrawUseBox(playerid,Sul_NewPlayer[playerid], 1); 
			PlayerTextDrawBoxColor(playerid,Sul_NewPlayer[playerid], 0x00000000); 
			PlayerTextDrawTextSize(playerid,Sul_NewPlayer[playerid], 94.000000, 72.000000); 
			//PlayerTextDrawSetPreviewModel(playerid, Sul_NewPlayer[playerid], 560);
			//PlayerTextDrawSetPreviewVehCol(playerid, Sul_NewPlayer[playerid], 1,1);
			//PlayerTextDrawSetPreviewRot(playerid, Sul_NewPlayer[playerid],  -16.0, 0.0, -55.0, 0.9);
			PlayerTextDrawSetSelectable(playerid,Sul_NewPlayer[playerid], 1);
			PlayerTextDrawShow(playerid, Inf_NewPlayer[playerid]);
			PlayerTextDrawShow(playerid, Elegy_NewPlayer[playerid]);
			PlayerTextDrawShow(playerid, Sul_NewPlayer[playerid]);
			for(new i; i < sizeof(Textdraw); i ++)
				TextDrawShowForPlayer(playerid, Textdraw[i]); 
		}	
	case START_INFO_DIALOG+3:{
		    if(!response){
				Player[playerid][pSpeedom] = 0;
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					PlayerTextDrawHide(playerid,Speed2[playerid]);
			}	}
			for(new i; i < strlen(Player[playerid][PlayerName])-1; i++){
				switch(Player[playerid][PlayerName][i]){
					case '0'..'9','a'..'z','A'..'Z','.': continue;
					default:{
						if(!LanglePlayer{playerid})
							ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!", "Далее", "" );
						else
							ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
						return true;
					}
				}
			}
	    }
	case 444:{
			if(response)
			{
				if(strval(inputtext) > (sizeof(PlayerColors)-1) || strval(inputtext) < 0) return ChowColorPanel(playerid);
				new color = ((!strval(inputtext))?random(sizeof(PlayerColors)):strval(inputtext));
				SetPlayerColor(playerid, PlayerColors[color]);
				Player[playerid][pColorPlayer] = color;
				ChowColorPanel(playerid);
			}
			else ShowDialogSint(playerid);
		}
	case 446:{
			if(response)
			{
				TextDrawHideForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
				Player[playerid][pColorScore] = listitem;
				UpdateScoreSystem(playerid);
				if(GetPVarInt(playerid,"nick"))
					TextDrawShowForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid, 446, DIALOG_STYLE_LIST, "Цвет индикаторов", "{00f5da}Бирюзовый\n{3caa3c}Зеленый\n{003399}Синий\n{FFFFFF}Белый\n{ff0000}Красный\n{9966cc}Фиолетовый\n{ffff00}Желтый", "Выбрать", "Назад");
				else
					ShowPlayerDialog(playerid, 446, DIALOG_STYLE_LIST, "Indicators color", "{00f5da}Turquoise\n{3caa3c}Green\n{003399}Blue\n{FFFFFF}White\n{ff0000}Red\n{9966cc}Violet\n{ffff00}Yellow","Select", "Back");
			}else
   				ShowDialogSintInterface(playerid);
		}
	case DIALOG_STG_AKK:{
			if(response)
			{
				if(listitem == 0){
				   	new qString[256];
					if(Player[playerid][pTimeNewNick] > gettime()){
				 		format(qString, sizeof qString, "Извините, менять ник можно только 1 раз в час.\nСменить ник можно будет через: %s.", timecs(gettime(),Player[playerid][pTimeNewNick]));
						ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,""MENU_PRFX_Stgn""STRELKI"Смена ника",qString,"Закрыть","");
					}
					else ShowPlayerDialog(playerid, DIALOG_STG_AKK+1, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена ника", "{FFFFFF}Введите новый ник. От 4 до 20 символов.", "Далее", "Отмена" );
				}
				else
				    ShowPlayerDialog(playerid, DIALOG_STG_AKK+2, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена пароля", "{FFFFFF}Введите новый пароль. От 6 до 20 символов.", "Далее", "Отмена" );
			}
			else ShowDialogSint(playerid);
		}
  	case CHANGE_NICK:{
			if(response)
			{
				if(strlen(inputtext) < 4 || strlen(inputtext) > 20){
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!", "Далее", "" );
					else
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
					return true;
				}		
				if(GetPlayerId(inputtext) >= 0){		
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!\n\n\t\t{e32636}Недопустимый ник!\n\n\t\t{e32636}Данный ник занят!", "Далее", "" );
					else
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Is nickname occupied!", "Next", "" );
					return SendClientMessage(playerid,-1,""SERVER_MSG"Данный ник уже занят!");
				}
				if(!strcmp("NULL",inputtext,false))
				{
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!", "Далее", "" );
					else
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
					return true;
				}
				new count;
				for(new i; i < strlen(inputtext); i++){
					switch(inputtext[i]){
						case '0'..'9': {count++;continue;}
						case 'a'..'z','A'..'Z','.': continue;
						default:{
							if(!LanglePlayer{playerid})
								ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!", "Далее", "" );
							else
								ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
							return true;
						}
					}
				}
				if(count > 2){
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Много цифр!", "Далее", "" );
					else
						ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
					return true;
				}
				SetPVarString(playerid,"NewNick",inputtext);
				new qString[112];
				format(qString, sizeof qString, "SELECT id FROM "TABLE_ACC" WHERE `Nickname`='%s'", inputtext);
				mysql_function_query(MYSQL, qString, true, "changenickPlayerEx", "i", playerid);
			}
			else{
				if(!LanglePlayer{playerid})
					ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Смена ника", "{FFFFFF}У Вас недопустимый ник для игры на нашем сервере!\n\tВведите новый ник. От 4 до 20 символов.\n\tРазрешены: Буквы, Цифры и точки.\n\n\t\tПример: \"{00f5da}.Ya.Antosha.{ffffff}\".\n\n\t\t{e32636}Недопустимый ник!", "Далее", "" );
				else
					ShowPlayerDialog(playerid, CHANGE_NICK, DIALOG_STYLE_INPUT, "{FFFFFF}Shange nick", "{FFFFFF}Uncorrect nickname. Change your nickname for playing on the server.\n\tWrite your new nickname. 4-20 symbols only.\n\t\tAllowed: 'A'..'Z','0..9','.'.\n\n\t\tExample: \"{00f5da}.Me.Antonio.{ffffff}\".\n\n\t\t{e32636}Uncorrect nickname!", "Next", "" );
			}
		}
  	case DIALOG_STG_AKK+1:{
			if(response)
			{
				if(strlen(inputtext) < 4 || strlen(inputtext) > 20)
					return SendClientMessage(playerid,-1,""SERVER_MSG"Ник не может быть короче 4-х символов и длинее 20!");
				if(GetPlayerId(inputtext) >= 0)
					return SendClientMessage(playerid,-1,""SERVER_MSG"Данный ник уже занят!");
				if(!strcmp("NULL",inputtext,false))
				{
					SendClientMessage(playerid, -1, ""SERVER_MSG"Данный ник нельзя использовать на нашем сервере!");
					return ShowPlayerDialog(playerid, DIALOG_STG_AKK+1, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена ника", "Введите новый ник. От 4 до 20 символов.", "Далее", "Отмена" );
				}
				new count;
				for(new i; i < strlen(inputtext); i++){
					switch(inputtext[i]){
						case '0'..'9': {count++;continue;}
						case 'a'..'z','A'..'Z','.': continue;
						default:{
							ShowPlayerDialog(playerid, DIALOG_STG_AKK+1, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена ника", "Введите новый ник. Введенный вами ник не допустим в SAMP!", "Далее", "Отмена" );
							return true;
						}
					}
				}
				if(count > 2){
					ShowPlayerDialog(playerid, DIALOG_STG_AKK+1, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена ника", "Введите новый ник. Введенный вами ник не допустим в SAMP!", "Далее", "Отмена" );
					return true;
				}
				SetPVarString(playerid,"NewNick",inputtext);
				new qString[112];
				format(qString, sizeof qString, "SELECT id FROM "TABLE_ACC" WHERE `Nickname`='%s'", inputtext);
				mysql_function_query(MYSQL, qString, true, "changenickPlayer", "i", playerid);
			}
			ShowDialogSint(playerid);
			return true;
		}
	case DIALOG_STG_AKK+2:{
			if(response)
			{
				if(strlen(inputtext) < 6 || strlen(inputtext) > 20)
					return 	ShowPlayerDialog(playerid, DIALOG_STG_AKK+2, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена пароля", "Введите новый пароль. От 6 до 20 символов.", "Далее", "Отмена" );
				if(strfind(inputtext,"/",true) != -1)
					return 	ShowPlayerDialog(playerid, DIALOG_STG_AKK+2, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Смена пароля", "Введите новый пароль. От 6 до 20 символов.", "Далее", "Отмена" );
				new qString[128];
				format(qString, sizeof qString, "UPDATE "TABLE_ACC" SET `Password`='%s' WHERE `id`='%i'",inputtext,Player[playerid][pSQLID]);
				mysql_function_query(MYSQL, qString, false, "", "");
				SendClientMessage(playerid,-1,""SERVER_MSG"Пароль успешно сменен!");
				ShowDialogSint(playerid);
			}
			ShowDialogSint(playerid);
			return true;
		}
	case DIALOG_STG_AKK+3:{
			loadAccount(playerid);
			CreateCars(playerid);
			return true;
		}
	case 232:{
			if(response)
			{
				if(listitem == 0)
				{
					Player[playerid][pSpeedom]++;
					if(Player[playerid][pSpeedom] == 1)
					{
			      		for(new i; i < COLORS_SPEEDOM; i++) {
						    if(!SpeedOpen[playerid][i]) continue;
							TextDrawHideForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
							SpeedOpen[playerid][i] = false;
						}
						if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
							PlayerTextDrawShow(playerid,Speed2[playerid]);
					}	}
					else if(Player[playerid][pSpeedom] == 2)
						PlayerTextDrawHide(playerid,Speed2[playerid]);
					else if(Player[playerid][pSpeedom] == 3){
						if(OpenBox[playerid]){
							TextDrawHideForPlayer(playerid,Box);
							OpenBox[playerid] = false;
						}
			      		for(new i; i < COLORS_SPEEDOM; i++) {
						    if(!SpeedOpen[playerid][i]) continue;
							TextDrawHideForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
							SpeedOpen[playerid][i] = false;
						}
						Player[playerid][pSpeedom] = 0;
						PlayerTextDrawHide(playerid,Speed2[playerid]);
					}
					ShowDialogSintInterface(playerid);
				}
				else if(listitem == 1) {
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, 446, DIALOG_STYLE_LIST, "Цвет индикаторов", "{00f5da}Бирюзовый\n{3caa3c}Зеленый\n{003399}Синий\n{FFFFFF}Белый\n{ff0000}Красный\n{9966cc}Фиолетовый\n{ffff00}Желтый", "Выбрать", "Назад");
					else
						ShowPlayerDialog(playerid, 446, DIALOG_STYLE_LIST, "Indicators color", "{00f5da}Turquoise\n{3caa3c}Green\n{003399}Blue\n{FFFFFF}White\n{ff0000}Red\n{9966cc}Violet\n{ffff00}Yellow","Select", "Back");
					return true;
				}
				else if(listitem == 2){
				    new newcolor = Player[playerid][pColorSpeedom];
					newcolor++;
				    if(newcolor >= 3)
						newcolor = 0;
					if(Player[playerid][pSpeedom] == 1){
					    if(newcolor == 2)
					    	PlayerTextDrawColor(playerid,Speed2[playerid],COLOR_WHITE);
						else
					    	PlayerTextDrawColor(playerid,Speed2[playerid],speedcolors[newcolor][0]);
					    PlayerTextDrawShow(playerid,Speed2[playerid]);
					}
					else if(Player[playerid][pSpeedom] == 2){
	    				for(new i; i < COLORS_SPEEDOM; i++) {
							if(!SpeedOpen[playerid][i]) continue;
							TextDrawHideForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
							TextDrawShowForPlayer(playerid,Speed[newcolor][i]);
					}	}
					Player[playerid][pColorSpeedom] = newcolor;
					ShowDialogSintInterface(playerid);
			}	}
			else ShowMenuForPlayerEx(playerid);
		}
	case DIALOG_STG_2:
		{
			if(response)
			{
				if(!LanglePlayer{playerid}){
					if(listitem == 0)
						ShowPlayerDialog(playerid, 45, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Погода", "Введите номер нужной вам погоды. [0-20]\n\tСтандартная погода: 13.", "Далее", "Назад");
					else if(listitem == 1) ShowPlayerDialog(playerid, 46, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Время", "Сколько часов Вам поставить? [1-24]\nВведите 0 или оставьте поле пустым для времени сервера.", "Далее", "Назад");
					else if(listitem == 2) ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Дрифт бонусы", "DoubleDrift\t(1 час)		{00f5da}1 000 000$\nNoCrash\t(1 час)		{00f5da}500 000$", "Выбрать", "Отмена");
					else if(listitem == 3){
						if(GetPVarInt(playerid,"nick") == 1){
							SendClientMessage(playerid,-1,""SERVER_MSG"Режим 'Мувик' включен.");
							SetPVarInt(playerid,"nick",0);
							for(new i = 0, all = MAX_PLAYERS; i < all; i++){
								ShowPlayerNameTagForPlayer(playerid, i, false);
							}
							TextDrawHideForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
							PlayerTextDrawHide(playerid,ScoreShow[playerid]);
							PlayerTextDrawHide(playerid,LevelShow[playerid]);
							TextDrawHideForPlayer(playerid,hpDrawFon);
							TextDrawHideForPlayer(playerid,hpDraw[playerid]);
							TextDrawHideForPlayer(playerid,hpDraweFon);
							TextDrawHideForPlayer(playerid,hpDrawe[playerid]);
							PlayerTextDrawHide(playerid,DriftPointsShow[playerid]);
							if(ShowStirLock[playerid]){
								TextDrawHideForPlayer(playerid,StirLock[Player[playerid][pColorScore]]);
								ShowStirLock[playerid] = 0;
							}
						}
						else{
							SendClientMessage(playerid,-1,""SERVER_MSG"Режим 'Мувик' выключен.");
							SetPVarInt(playerid,"nick",1);
							for(new i = 0, all = MAX_PLAYERS; i < all; i++){
								ShowPlayerNameTagForPlayer(playerid, i, true);
							}
							TextDrawShowForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
							if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
								PlayerTextDrawShow(playerid,ScoreShow[playerid]);
								PlayerTextDrawShow(playerid,LevelShow[playerid]);
								TextDrawShowForPlayer(playerid,hpDrawFon);
								TextDrawShowForPlayer(playerid,hpDraw[playerid]);
							}
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 4){
						if(Player[playerid][pRepair]){
							SendClientMessage(playerid,-1,""SERVER_MSG"Автопочинка выключена.");
							Player[playerid][pRepair] = false;
							ShowDialogSintEx(playerid);
						}else{
							SendClientMessage(playerid,-1,""SERVER_MSG"Автопочинка включена.");
							Player[playerid][pRepair] = true;
							ShowDialogSintEx(playerid);
					}	}
					else if(listitem == 5)
					{
						if(!Player[playerid][pWeapons])
						{
							if(Player[playerid][pLevel] < 30){
								SendClientMessage(playerid,-1,""SERVER_MSG"Дополнительные возможности  доступны только с 30 уровня.");
								ShowDialogSintEx(playerid);
							}else{
								SendClientMessage(playerid,-1,""SERVER_MSG"Дополнительные возможности. Режим: Classic. Использование: Нажмите \"N\".");
								Player[playerid][pWeapons] = 1;
								ShowDialogSintEx(playerid);
							}
						}else if(Player[playerid][pWeapons] == 1){
							Player[playerid][pWeapons] = 2;
							SendClientMessage(playerid,-1,""SERVER_MSG"Дополнительные возможности. Режим: TP. Использование: Нажмите \"N\".");
						}else if(Player[playerid][pWeapons] == 2){
							Player[playerid][pWeapons] = 0;
							SendClientMessage(playerid,-1,""SERVER_MSG"Дополнительные возможности выключены.");
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 6)
					{
						if(!Player[playerid][pKeyMenu])
						{
							Player[playerid][pKeyMenu] = true;
							SendClientMessage(playerid,-1,""SERVER_MSG"Клавиша вызова меню перенесена на кнопки \"Alt\" и \"2\".");
						}
						else
						{
							Player[playerid][pKeyMenu] = false;
							SendClientMessage(playerid,-1,""SERVER_MSG"Клавиша вызова меню перенесена на кнопку \"Y\".");
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 7)
					{
						if(!Player[playerid][KeyTP]){
							Player[playerid][KeyTP] = true;
							SendClientMessage(playerid,-1,""SERVER_MSG"Данная функция является аналогом комманд \"/s\" и \"/r\".");
						}
						else
							Player[playerid][KeyTP] = false;
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 8)
					{
						if(!Player[playerid][KeyStop]){
							Player[playerid][KeyStop] = true;
							SendClientMessage(playerid,-1,""SERVER_MSG"Данная функция останавливает ТС при зажатии пробела и кнопки тормоза.");
						}
						else
							Player[playerid][KeyStop] = false;
						ShowDialogSintEx(playerid);
					}
				}else{
					if(listitem == 0) ShowPlayerDialog(playerid, 45, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn_EN""STRELKI"Weather", "Enter number of the weather necessary to you. [0-20]\n\tStandard weather: 13.", "Next", "Back");
					else if(listitem == 1) ShowPlayerDialog(playerid, 46, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Time", "How many clock to you to put? [1-24]\nEnter 0 or leave a field empty for server time.", "Next", "Back");
					else if(listitem == 2) ShowPlayerDialog(playerid, 251, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN""STRELKI"Drift bonuses", "DoubleDrift\t(1 hour)		{00f5da}1 000 000$\nNoCrash\t(1 hour)		{00f5da}500 000$", "Select", "Back");
					else if(listitem == 3){
						if(GetPVarInt(playerid,"nick") == 1){
							SendClientMessage(playerid,-1,""SERVER_MSG"Mode 'Moove' included.");
							SetPVarInt(playerid,"nick",0);
							for(new i = 0, all = MAX_PLAYERS; i < all; i++){
								ShowPlayerNameTagForPlayer(playerid, i, false);
							}
							TextDrawHideForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
							PlayerTextDrawHide(playerid,ScoreShow[playerid]);
							PlayerTextDrawHide(playerid,LevelShow[playerid]);
							TextDrawHideForPlayer(playerid,hpDrawFon);
							TextDrawHideForPlayer(playerid,hpDraw[playerid]);
							TextDrawHideForPlayer(playerid,hpDraweFon);
							TextDrawHideForPlayer(playerid,hpDrawe[playerid]);
							PlayerTextDrawHide(playerid,DriftPointsShow[playerid]);
							if(ShowStirLock[playerid]){
								TextDrawHideForPlayer(playerid,StirLock[Player[playerid][pColorScore]]);
								ShowStirLock[playerid] = 0;
							}
						}
						else{
							SendClientMessage(playerid,-1,""SERVER_MSG"Mode 'Moove' switch off.");
							SetPVarInt(playerid,"nick",1);
							for(new i = 0, all = MAX_PLAYERS; i < all; i++){
								ShowPlayerNameTagForPlayer(playerid, i, true);
							}
							TextDrawShowForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
							if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
								PlayerTextDrawShow(playerid,ScoreShow[playerid]);
								PlayerTextDrawShow(playerid,LevelShow[playerid]);
								TextDrawShowForPlayer(playerid,hpDrawFon);
								TextDrawShowForPlayer(playerid,hpDraw[playerid]);
							}
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 4){
						if(Player[playerid][pRepair]){
							SendClientMessage(playerid,-1,""SERVER_MSG"Autorepair switch off.");
							Player[playerid][pRepair] = false;
						}else{
							SendClientMessage(playerid,-1,""SERVER_MSG"Autorepair included.");
							Player[playerid][pRepair] = true;
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 5)
					{
						if(!Player[playerid][pWeapons])
						{
							if(Player[playerid][pLevel] < 30){
								SendClientMessage(playerid,-1,""SERVER_MSG"Additional opportunities are available only from the 30th level.");
								ShowDialogSintEx(playerid);
							}else{
								SendClientMessage(playerid,-1,""SERVER_MSG"Additional opportunities. Mode: Classic. Use: Press \"N\".");
								Player[playerid][pWeapons] = 1;
								ShowDialogSintEx(playerid);
							}
						}else if(Player[playerid][pWeapons] == 1){
							Player[playerid][pWeapons] = 2;
							SendClientMessage(playerid,-1,""SERVER_MSG"Additional opportunities. Mode: TP. Use: Press \"N\".");
						}else if(Player[playerid][pWeapons] == 2){
							Player[playerid][pWeapons] = 0;
							SendClientMessage(playerid,-1,""SERVER_MSG"Additional opportunities switch off.");
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 6)
					{
						if(!Player[playerid][pKeyMenu])
						{
							Player[playerid][pKeyMenu] = true;
							SendClientMessage(playerid,-1,""SERVER_MSG"The invoke key of the menu is postponed for buttons \"Alt\" и \"2\".");
						}
						else
						{
							Player[playerid][pKeyMenu] = false;
							SendClientMessage(playerid,-1,""SERVER_MSG"The invoke key of the menu is postponed for the button \"Y\".");
						}
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 7)
					{
						if(!Player[playerid][KeyTP]){
							Player[playerid][KeyTP] = true;
							SendClientMessage(playerid,-1,""SERVER_MSG"This function is analog of command \"/s\" и \"/r\".");
						}else
							Player[playerid][KeyTP] = false;
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 8)
					{
						if(!Player[playerid][KeyStop]){
							Player[playerid][KeyStop] = true;
							SendClientMessage(playerid,-1,""SERVER_MSG"This function has stoped vehicle, press gap + brake.");
						}
						else
							Player[playerid][KeyStop] = false;
						ShowDialogSintEx(playerid);
					}
					else if(listitem == 9) {ShowDialogSintInterface(playerid);return true;}
				}
			}
			else
				ShowDialogSint(playerid);
		}
	case 229:
		{
			if(response)
			{
				if(!LanglePlayer{playerid}){
					if(listitem == 0) ShowPlayerDialog(playerid, DIALOG_STG_AKK, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn""STRELKI"Настройки аккаунта", "Смена ника\nСмена пароля", "Ок", "Назад");
					else if(listitem == 1) ShowDialogSintEx(playerid);
					else if(listitem == 2) {ChowColorPanel(playerid);return true;}
					else if(listitem == 3) {ShowDialogDonat(playerid);return true;}
					else if(listitem == 4) {ShowDialogSintInterface(playerid);return true;}
					else if(listitem == 5){
						if(Player[playerid][pTags])
							Player[playerid][pTags] = false;
						else
							Player[playerid][pTags] = true;
						ShowDialogSint(playerid);
					}
					else if(listitem == 6)
					{
						if(!Player[playerid][pPmStatus])
						{
							Player[playerid][pPmStatus] = 1;
							SendClientMessage(playerid,-1,""SERVER_MSG"Теперь тебе будут приходить ЛС только от друзей.");
						}
						else
						{
							Player[playerid][pPmStatus] = 0;
							SendClientMessage(playerid,-1,""SERVER_MSG"Теперь тебе будут приходить ЛС от всех кроме людей из ЧС.");
						}
						ShowDialogSint(playerid);
					}
					else if(listitem == 7){
						if(!Player[playerid][pVIP])
							SendClientMessage(playerid,-1,""SERVER_MSG"Изменение цвета текста доступно только VIP игрокам.");
						else if(Player[playerid][pColorText] == 0)
							Player[playerid][pColorText] = 1;
						else if(Player[playerid][pColorText] == 1)
							Player[playerid][pColorText] = 2;
						else if(Player[playerid][pColorText] == 2)
							Player[playerid][pColorText] = 3;
						else
							Player[playerid][pColorText] = 0;
						ShowDialogSint(playerid);
						return true;
					}
					else if(listitem == 8) {LanglePlayer{playerid} = true;ShowDialogSint(playerid);}
				}else{
					if(listitem == 0) ShowPlayerDialog(playerid, DIALOG_STG_AKK, DIALOG_STYLE_LIST, ""MENU_PRFX_Stgn_EN""STRELKI"Account settings", "Change nickname\nChange password", "Continue", "Back");
					else if(listitem == 1) ShowDialogSintEx(playerid);
					else if(listitem == 2) {ChowColorPanel(playerid);return true;}
					else if(listitem == 3) {ShowDialogDonat(playerid);return true;}
					else if(listitem == 4) {ShowDialogSintInterface(playerid);return true;}
					else if(listitem == 5){
						if(Player[playerid][pTags])
							Player[playerid][pTags] = false;
						else
							Player[playerid][pTags] = true;
						ShowDialogSint(playerid);
					}
					else if(listitem == 6)
					{
						if(!Player[playerid][pPmStatus])
						{
							Player[playerid][pPmStatus] = 1;
							SendClientMessage(playerid,-1,""SERVER_MSG"Now to you will come a PM only from friends.");
						}
						else
						{
							Player[playerid][pPmStatus] = 0;
							SendClientMessage(playerid,-1,""SERVER_MSG"Now to you will come a PM from all except people from a black list.");
						}
						ShowDialogSint(playerid);
					}
					else if(listitem == 7){
						if(!Player[playerid][pVIP])
							SendClientMessage(playerid,-1,""SERVER_MSG"Change of color of the text available only VIP players.");
						else if(Player[playerid][pColorText] == 0)
							Player[playerid][pColorText] = 1;
						else if(Player[playerid][pColorText] == 1)
							Player[playerid][pColorText] = 2;
						else if(Player[playerid][pColorText] == 2)
							Player[playerid][pColorText] = 3;
						else
							Player[playerid][pColorText] = 0;
						ShowDialogSint(playerid);
						return true;
					}
					else if(listitem == 8) {LanglePlayer{playerid} = false;ShowDialogSint(playerid);}
				}
			}
			else
				ShowMenuForPlayerEx(playerid);
		}
	case 4:{
			if(response)
			{
				new carid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
				if(listitem == 0)
				{
        			if(!Wheel(GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"))))
        			    return ShowDialogTuning(playerid);
					if(GetPlayerCash(playerid)<10000){
						ShowDialogTuning(playerid);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						return true;
					}
					ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "Список дисков", "Shadow\nMega\nWires\nClassic\nRimshine\nCutter\nTwist\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic", "OK", "Назад");
				}
				else if(listitem == 1)
				{
					if(GetPlayerCash(playerid)<25000){
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						return true;
					}
					if(GetVehicleComponentInSlot(carid,9) == 1087 || !Gidravlic(carid))
						return ShowDialogTuning(playerid);
					AddVehicleComponent(carid,1087);
					Player[playerid][cGidravlika][GetPVarInt(playerid,"CarIdMenu")] = 1;
					PlayerPlaySound(playerid, 1133, 0, 0, 0);
					DaiEmyDeneg(playerid,-25000);
					ShowDialogTuning(playerid);
				}
				else if(listitem == 2)
				{
					if(GetPlayerCash(playerid)<5000){
						ShowDialogTuning(playerid);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						return true;
					}
					TextDrawShowForPlayer(playerid, CarColorFon);
					TextDrawShowForPlayer(playerid, ColorKeyBuy);
					TextDrawShowForPlayer(playerid, ColorKeyCancel);
					for(new i; i < sizeof(VehicleColoursTableRGBA); i++)
						TextDrawShowForPlayer(playerid, CarColorTX[i]);
					SelectTextDraw(playerid, 0xFFFFFFFF);
					SetPVarInt(playerid,"PlayerReg",1);
					UsedColorSlot[playerid] = 1;
					return true;
				}
				else if(listitem == 3)
				{
				    if(!TwoColours(GetVehicleModel(carid)))
						return ShowDialogTuning(playerid);
					if(GetPlayerCash(playerid)<5000){
						ShowDialogTuning(playerid);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						return true;
					}
					TextDrawShowForPlayer(playerid, CarColorFon);
					TextDrawShowForPlayer(playerid, ColorKeyBuy);
					TextDrawShowForPlayer(playerid, ColorKeyCancel);
					for(new i; i < sizeof(VehicleColoursTableRGBA); i++)
						TextDrawShowForPlayer(playerid, CarColorTX[i]);
					SelectTextDraw(playerid, 0xFFFFFFFF);
					SetPVarInt(playerid,"PlayerReg",1);
					UsedColorSlot[playerid] = 2;
					return true;
				}
				else if(listitem == 4)
				{
					if(GetPlayerCash(playerid)<10000){
						ShowDialogTuning(playerid);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
						return true;
					}
		   			if(!Vinil(carid))
				        return ShowDialogTuning(playerid);
					ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "Выбор винила", "Винил №1 \nВинил №2 \nВинил №3\nВинил №4 ", "ОК", "Назад");
				}
				else if(listitem == 5)
				{
					new carslot = GetPVarInt(playerid,"CarIdMenu");
					if(Player[playerid][pVinil][carslot] == -1 && !Player[playerid][cGidravlika][carslot])
						return ShowDialogTuning(playerid);
					if(Player[playerid][cGidravlika][carslot]){
						RemoveVehicleComponent(carid,1087);
						Player[playerid][cGidravlika][carslot] = 0;
					}
					if(Player[playerid][pVinil][carslot] != -1){
						ChangeVehiclePaintjob(carid,3);
						SetCarVinil(playerid,carslot,-1);
					}
					ShowDialogTuning(playerid);
				}
			}
			else CarMenu(playerid,GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu")));
		}
	case 11:{
			if(response)
			{
				if(GetPlayerCash(playerid)<10000){
					ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "Список дисков", "Shadow\nMega\nWires\nClassic\nRimshine\nCutter\nTwist\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic", "OK", "Назад");
					SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
				}
				new wheel = Wheels[listitem],
					carid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
				Player[playerid][cWheels][GetPVarInt(playerid,"CarIdMenu")] = listitem;			
				AddVehicleComponent(carid,wheel);
				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				DaiEmyDeneg(playerid,-10000);
				ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "Список дисков", "Shadow\nMega\nWires\nClassic\nRimshine\nCutter\nTwist\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic", "OK", "Назад");
			}
			else ShowDialogTuning(playerid);
		}
	case 13:{
			if(response)
			{
				if(GetPlayerCash(playerid)<5000){
					ShowDialogTuning(playerid);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
					return true;
				}
				new Color;
				new vehicleid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
				Color = colorcars[listitem];
				ChangeVehicleColor(vehicleid,Color,Player[playerid][pColorTwo][GetPVarInt(playerid,"CarIdMenu")]);
				SetCarColor(playerid,GetPVarInt(playerid,"CarIdMenu"),Color,Player[playerid][pColorTwo][GetPVarInt(playerid,"CarIdMenu")]);
				DaiEmyDeneg(playerid,-5000);
				PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
    			bigdialog = "";
				new colours;
				for(new i = 0; i < sizeof(colorcars); i++){
	    			if(colours)
	    				strcat(bigdialog, "\n");
					new str[24];
					format(str, sizeof(str), "{%s}||||||||||||||",vehicleColorMenuText[colorcars[i]]);
					strcat(bigdialog, str);
					colours++;
				}
				ShowPlayerDialog(playerid, 13, DIALOG_STYLE_LIST, ""MENU_PRFX_CARS""STRELKI"Смена цвета авто", bigdialog, "Выбрать", "Закрыть" );
			}
			else ShowDialogTuning(playerid);
		}
	case 39:{
			if(response)
			{
				if(GetPlayerCash(playerid)<5000){
					ShowDialogTuning(playerid);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
					return true;
				}
				new Color;
				new vehicleid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
				Color = colorcars[listitem];
				ChangeVehicleColor(vehicleid,Player[playerid][pColor][GetPVarInt(playerid,"CarIdMenu")],Color);
				SetCarColor(playerid,GetPVarInt(playerid,"CarIdMenu"),Player[playerid][pColor][GetPVarInt(playerid,"CarIdMenu")],Color);
				DaiEmyDeneg(playerid,-5000);
				PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
    			bigdialog = "";
				new colours;
				for(new i = 0; i < sizeof(colorcars); i++){
	    			if(colours)
	    				strcat(bigdialog, "\n");
					new str[24];
					format(str, sizeof(str), "{%s}||||||||||||||",vehicleColorMenuText[colorcars[i]]);
					strcat(bigdialog, str);
					colours++;
				}
				ShowPlayerDialog(playerid, 39, DIALOG_STYLE_LIST, ""MENU_PRFX_CARS""STRELKI"Смена цвета авто", bigdialog, "Выбрать", "Закрыть" );
			}
			else ShowDialogTuning(playerid);
		}
	case 14:{
			if(response)
			{
				if(GetPlayerCash(playerid)<10000){
					ShowDialogTuning(playerid);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
					return ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "Выбор винила", "Винил №1 \nВинил №2 \nВинил №3 \nВинил №4", "ОК", "Назад");
				}
				new vehicleid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu"));
				ChangeVehiclePaintjob(vehicleid,listitem);
				SetCarVinil(playerid,GetPVarInt(playerid,"CarIdMenu"),listitem);
				PlayerPlaySound(playerid,1134,0.0,0.0,0.0);
				DaiEmyDeneg(playerid,-10000);
				ShowPlayerDialog(playerid, 14, DIALOG_STYLE_LIST, "Выбор винила", "Винил №1 \nВинил №2 \nВинил №3 \nВинил №4", "ОК", "Назад");
			}
			else ShowDialogTuning(playerid);
		}
	case 12:{
			if(response)
			{
				if(GetPlayerCash(playerid)<25000){
					ShowDialogTuning(playerid);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, ""SERVER_MSG"У тебя недостаточно денег.");
					return true;
				}
				new vehicleid = GetCarIdForSlot(playerid,GetPVarInt(playerid,"CarIdMenu")),
					cartype = GetVehicleModel(vehicleid);
				if(listitem == 0)// wc_x front
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 1)//alien front
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 2)//wc_x rear
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 3)//alien rear
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 4)//wc_x spoiler
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 5)//alien spoiler
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 6){//wc_x side
					AddVehicleComponent(vehicleid,GetVehicleTunEx(cartype,1));
					AddVehicleComponent(vehicleid,AddOne(GetVehicleTunEx(cartype,1)));
					AddVehicleComponent(vehicleid,GetVehicleTunEx(cartype,1));
    				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
					DaiEmyDeneg(playerid,-25000);
					return ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
				}
				else if(listitem == 7){//alien side
					AddVehicleComponent(vehicleid,GetVehicleTunEx(cartype,2));
					AddVehicleComponent(vehicleid,AddOne(GetVehicleTunEx(cartype,2)));
					AddVehicleComponent(vehicleid,GetVehicleTunEx(cartype,2));
    				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
					DaiEmyDeneg(playerid,-25000);
					return ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
				}
				else if(listitem == 8)//wc_x roof
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 9)//alien roof
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 10)//wc_x echaust
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				else if(listitem == 11)//alien echaust
					AddVehicleComponent(vehicleid,GetVehicleTun(cartype,listitem));
				PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
				ShowPlayerDialog(playerid, 12, DIALOG_STYLE_LIST, "Тюнинг Wheel Arch Angels", "Передний бампер X-flow\nПередний бампер Alien\nЗадний бампер X-Flow\nЗадний бампер Alien\nСпойлер X-Flow \nСпойлер Alien \nБоковая юбка X-Flow \nБоковая юбка Alien\nВоздухозаборник X-Flow\nВоздухозаборник Alien\nВыхлоп X-flow\nВыхлоп Alien", "OK", "Назад");
				DaiEmyDeneg(playerid,-25000);
			}
			else ShowDialogTuning(playerid);
			return true;
		}
	case 45:{
			if(response)
			{
				if(strval(inputtext) < 0 || strval(inputtext) > 20)
					return ShowPlayerDialog(playerid, 45, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Погода", "Введите номер нужной вам погоды.\n\tСтандартная погода: 13.", "Далее", "Назад");
				SetPlayerWeather(playerid, strval(inputtext));	
			}
			ShowDialogSintEx(playerid);
		}
	case 46:{
			if(response)
			{
				if(strval(inputtext) < 0 || strval(inputtext) > 24)
					return ShowPlayerDialog(playerid, 46, DIALOG_STYLE_INPUT, ""MENU_PRFX_Stgn""STRELKI"Время", "Сколько часов Вам поставить? [1-24]\nВведите 0 или оставьте поле пустым для времени сервера.", "Далее", "Назад");
				if(strval(inputtext) == 0){
					SetPVarInt(playerid,"Timeon",1);
					gettime(hour, minute);
					SetPlayerTime(playerid,hour,0);
					return true;
				}
				SetPVarInt(playerid,"Timeon",2);
				SetPlayerTime(playerid,strval(inputtext),0);
			}
			ShowDialogSintEx(playerid);
		}
	case 8:{
			if(response){
				if(listitem == 0){
					SetPlayerArmour(playerid,100);
					PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
				else if(listitem == 1){
					SetPlayerHealth(playerid,100);
					PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
				else if(listitem == 2)
				{
				    //ShowModelSelectionMenu(playerid, skinlist, FixText("Смена скина"));
					return true;
				}
				else if(listitem == 3){
					if(IsPlayerInAnyVehicle(playerid))
						RemovePlayerFromVehicle(playerid);
					SetPlayerHealth(playerid,0);
					PlayerPlaySound(playerid,1149,0.0,0.0,0.0);
				}
				else if(listitem == 4){
					ShowMenuChar(playerid);
					cmd_alldt(playerid);
					return true;
				}
				else if(listitem == 5){
					if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Анимации не доступны в авто.");
					ShowPlayerDialog(playerid, 909, DIALOG_STYLE_LIST, "{00f5da}>>{ffffff} Персонаж"STRELKI"Анимации", "Напитки и Cигареты\nТанцевать\nЗвонить\nОстановить анимацию", "Выбрать", "Назад");
					return true;
				}
				ShowMenuChar(playerid);
			}
			else
				ShowMenuForPlayerEx(playerid);
		}
	case 456:{
			if(response)
			{
				if(listitem == 0)
				{
					SetPlayerFightingStyle(playerid, 5);
					SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Теперь у тебя стиль боя 'Бокс'");
				}
				else if(listitem == 1)
				{
					SetPlayerFightingStyle(playerid, 6);
					SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Теперь у тебя стиль боя 'KUNFU'");
				}
				else if(listitem == 2)
				{
					SetPlayerFightingStyle(playerid, 7);
					SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Теперь у тебя стиль боя 'GRABKICK'");
				}
			}
			else
				ShowMenuChar(playerid);
		}
	case 909:{
			if(response)
			{
				if(listitem == 0)ShowPlayerDialog(playerid, 15, DIALOG_STYLE_LIST, "{FFFFFF}..."STRELKI"Анимации"STRELKI"Напитки и Cигареты", "Пиво\nСигареты\nВино\nСпрайт", "OK", "Назад");
				else if(listitem == 1)ShowPlayerDialog(playerid, 16, DIALOG_STYLE_LIST, "{FFFFFF}..."STRELKI"Анимации"STRELKI"Танцевать", "Танец - 1\nТанец - 2\nТанец - 3\nТанец - 4\nРуки Вверх", "OK", "Назад");
				else if(listitem == 2)ShowPlayerDialog(playerid, 17, DIALOG_STYLE_LIST, "{FFFFFF}..."STRELKI"Анимации"STRELKI"Звонить", "Звонить\nБухой с трубой", "OK", "Назад");
				else if(listitem == 3)
				{
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
					SetPlayerDrunkLevel(playerid, 0);
					SetPlayerSpecialAction (playerid, 13 - SPECIAL_ACTION_STOPUSECELLPHONE);
					SendClientMessage(playerid, 0xFFFFFFAA, ""SERVER_MSG"Ты остановил анимацию можеш двигаться!");
				}
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}else
				ShowMenuChar(playerid);
		}
	case 15:{
			if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Анимации не доступны в авто.");
			if(response)
			{
				if(listitem == 0) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_BEER );
				else if(listitem == 1) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_SMOKE_CIGGY );
				else if(listitem == 2) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_WINE );
				else if(listitem == 3) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_SPRUNK );
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else ShowPlayerDialog(playerid, 909, DIALOG_STYLE_LIST, "{00f5da}>>{ffffff} Персонаж"STRELKI"Анимации", "Напитки и Cигареты\nТанцевать\nЗвонить\nОстановить анимацию", "OK", "Назад");
		}
	case 16:{
			if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Анимации не доступны в авто.");
			if(response)
			{
				if(listitem == 0) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE1);
				else if(listitem == 1) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE2);
				else if(listitem == 2) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE3);
				else if(listitem == 3)SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DANCE4);
				else if(listitem == 4) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_HANDSUP);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else ShowPlayerDialog(playerid, 909, DIALOG_STYLE_LIST, "{00f5da}>>{ffffff} Персонаж"STRELKI"Анимации", "Напитки и Cигареты\nТанцевать\nЗвонить\nОстановить анимацию", "OK", "Назад");
		}
	case 17:{
			if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREEN, ""SERVER_MSG"Анимации не доступны в авто.");
			if(response)
			{
				if(listitem == 0) SetPlayerSpecialAction (playerid, SPECIAL_ACTION_USECELLPHONE);
				else if(listitem == 1) SetPlayerDrunkLevel(playerid, 2323000);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else ShowPlayerDialog(playerid, 909, DIALOG_STYLE_LIST, "{00f5da}>>{ffffff} Персонаж"STRELKI"Анимации", "Напитки и Cигареты\nТанцевать\nЗвонить\nОстановить анимацию", "OK", "Назад");
		}
	case TELEPORTS:{
			if(response)
			{
			 	bigdialog="";
			    if(listitem == 0){
					for(new i = 0; i < DRIFTRACK; i++){
					    if(i != DRIFTRACK)
							strcat(bigdialog, "\n");
						strcat(bigdialog, DriftTeleports[i][dtlocat]);
						strcat(bigdialog, "\t");
						strcat(bigdialog, DriftTeleports[i][number]);
						strcat(bigdialog, "\t");
						if(!LanglePlayer{playerid})
							strcat(bigdialog, DriftTeleports[i][dtName]);
						else
							strcat(bigdialog, DriftTeleports[i][dtNameEn]);
					}
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, TELEPORTS+1 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP""STRELKI"Дрифт трассы", bigdialog, "Выбрать", "Отмена");
					else
						ShowPlayerDialog(playerid, TELEPORTS+1 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN""STRELKI"Drift tracks", bigdialog, "Select", "Cancel");
			    }else if(listitem == 1){
					for(new i = 0; i < DRAGRACK; i++){
					    if(i != DRAGRACK)
							strcat(bigdialog, "\n");
						strcat(bigdialog, DragTeleports[i][dglocat]);
						strcat(bigdialog, "\t");
						strcat(bigdialog, DragTeleports[i][number]);
						strcat(bigdialog, "\t");
						if(!LanglePlayer{playerid})
							strcat(bigdialog, DragTeleports[i][dgName]);
						else
							strcat(bigdialog, DragTeleports[i][dgNameEn]);
					}
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, TELEPORTS+2 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP""STRELKI"Драг треки", bigdialog, "Выбрать", "Отмена");
					else
						ShowPlayerDialog(playerid, TELEPORTS+2 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN""STRELKI"Drag tracks", bigdialog, "Select", "Cancel");
			    }else if(listitem == 2){
					if(!LanglePlayer{playerid})
						strcat(bigdialog, ""STRELKIEX"MapPack\n"STRELKIEX"Деревни\n");
					else
						strcat(bigdialog, ""STRELKIEX"MapPack\n"STRELKIEX"Villages\n");
					for(new i = 0; i < sizeof(AllTeleports); i++){
					    if(i != sizeof(AllTeleports))
							strcat(bigdialog, "\n");
						strcat(bigdialog, AllTeleports[i][alocat]);
						strcat(bigdialog, "\t");
						if(!LanglePlayer{playerid})
							strcat(bigdialog, AllTeleports[i][tname]);
						else
							strcat(bigdialog, AllTeleports[i][tnameEn]);
					}
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, TELEPORTS+3 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP""STRELKI"Другое", bigdialog, "Выбрать", "Отмена");
					else
						ShowPlayerDialog(playerid, TELEPORTS+3 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN""STRELKI"Others", bigdialog, "Select", "Cancel");
				}else
					ShowPersTeleList(playerid);
			}
			else
				ShowMenuForPlayerEx(playerid);
		}
	case TELEPORTS+1:{
			if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
			if(response)
			{
				if(Player[playerid][pJail]) return 0;
				new vehid = GetPlayerVehicleID(playerid),
					rand = random(3),
					Float:Xtp = (rand==0?DriftTeleports[listitem][pPosX1]:((rand==1)?DriftTeleports[listitem][pPosX2]:DriftTeleports[listitem][pPosX3])),
					Float:Ytp = (rand==0?DriftTeleports[listitem][pPosY1]:((rand==1)?DriftTeleports[listitem][pPosY2]:DriftTeleports[listitem][pPosY3]));
				SetPlayerInterior(playerid, 0);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_LinkVehicleToInterior(vehid, 0);
					t_SetVehiclePos(vehid, Xtp,Ytp,DriftTeleports[listitem][pPosZ]);
					SetVehicleZAngle(vehid, DriftTeleports[listitem][pPosA]);
				}
				else
					t_SetPlayerPos(playerid, Xtp,Ytp,DriftTeleports[listitem][pPosZ]);
				if(!LanglePlayer{playerid})
					format(string, sizeof(string), ""SERVER_MSG"Ты телепортирован на \"%s\" [%d].", DriftTeleports[listitem][dtName], listitem+1);
				else
					format(string, sizeof(string), ""SERVER_MSG"You are teleported to \"%s\" [%d].", DriftTeleports[listitem][dtNameEn], listitem+1);
				SendClientMessage(playerid,-1,string);
			}
			else ShowAllTeleports(playerid);
		}
	case TELEPORTS+2:{
			if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
			if(response)
			{
				if(Player[playerid][pJail]) return 0;
			   	new vehid = GetPlayerVehicleID(playerid);
			   	SetPlayerInterior(playerid, 0);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_LinkVehicleToInterior(vehid, 0);
					t_SetVehiclePos(vehid, DragTeleports[listitem][dx],DragTeleports[listitem][dy],DragTeleports[listitem][dz]);
					SetVehicleZAngle(vehid, DragTeleports[listitem][da]);
				}
				else
					t_SetPlayerPos(playerid, DragTeleports[listitem][dx],DragTeleports[listitem][dy],DragTeleports[listitem][dz]);
				if(!LanglePlayer{playerid})
					format(string, sizeof(string), ""SERVER_MSG"Ты телепортирован на \"%s\" [%d].", DragTeleports[listitem][dgName], listitem+1);
				else
					format(string, sizeof(string), ""SERVER_MSG"You are teleported to \"%s\" [%d].", DragTeleports[listitem][dgNameEn], listitem+1);
				SendClientMessage(playerid,-1,string);
			}
			else ShowAllTeleports(playerid);
		}
	case TELEPORTS+3:{
			if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
			if(response)
			{
				if(Player[playerid][pJail]) return 0;
				if(listitem == 0){
					minidialog = "";
					for(new i; i < sizeof(tpMapPack); i++){
					    if(i != sizeof(tpMapPack))
							strcat(minidialog, "\n");
						strcat(minidialog, tpMapPack[i][nameMap]);
					}
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, TELEPORTS+4 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP""STRELKI"Другое"STRELKI"MapPack", minidialog, "Выбрать", "Отмена");
					else
						ShowPlayerDialog(playerid, TELEPORTS+4 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN""STRELKI"Others"STRELKI"MapPack", minidialog, "Select", "Cancel");
					return true;
				}
				else if(listitem == 1){
					minidialog = "";
					for(new i; i < sizeof(tpDerevni); i++){
					    if(i != sizeof(tpDerevni))
							strcat(minidialog, "\n");
						strcat(minidialog, tpDerevni[i][nameD]);
					}
					if(!LanglePlayer{playerid})
						ShowPlayerDialog(playerid, TELEPORTS+5 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP""STRELKI"Другое"STRELKI"Деревни", minidialog, "Выбрать", "Отмена");
					else
						ShowPlayerDialog(playerid, TELEPORTS+5 , DIALOG_STYLE_LIST, ""MENU_PRFX_TP_EN""STRELKI"Others"STRELKI"Villages", minidialog, "Select", "Cancel");
					return true;
				}
			   	new vehid = GetPlayerVehicleID(playerid);
			   	SetPlayerInterior(playerid, 0);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_LinkVehicleToInterior(vehid, 0);
					t_SetVehiclePos(vehid, AllTeleports[listitem-2][ix],AllTeleports[listitem-2][iy],AllTeleports[listitem-2][iz]);
				}
				else
					t_SetPlayerPos(playerid, AllTeleports[listitem-2][ix],AllTeleports[listitem-2][iy],AllTeleports[listitem-2][iz]);
				if(!LanglePlayer{playerid})
					format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\" [%d].", AllTeleports[listitem-2][tname], listitem-2);
				else
					format(string, sizeof(string), ""SERVER_MSG"You are teleported to \"%s\" [%d].", AllTeleports[listitem-2][tnameEn], listitem-2);
				SendClientMessage(playerid,-1,string);
			}
			else ShowAllTeleports(playerid);
		}
	case TELEPORTS+4:
		{
			if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
			if(response)
			{
				if(Player[playerid][pJail]) return 0;
				new vehid = GetPlayerVehicleID(playerid);
				SetPlayerInterior(playerid, 0);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_LinkVehicleToInterior(vehid, 0);
					t_SetVehiclePos(vehid, tpMapPack[listitem][pPosX],tpMapPack[listitem][pPosY],tpMapPack[listitem][pPosZ]);
					SetVehicleZAngle(vehid, tpMapPack[listitem][pPosA]);
				}
				else
					t_SetPlayerPos(playerid, tpMapPack[listitem][pPosX],tpMapPack[listitem][pPosY],tpMapPack[listitem][pPosZ]);
				if(!LanglePlayer{playerid})
					format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\" [%d].", tpMapPack[listitem][nameMap], listitem);
				else
					format(string, sizeof(string), ""SERVER_MSG"You are teleported to \"%s\" [%d].", tpMapPack[listitem][nameMap], listitem);
				SendClientMessage(playerid,-1,string);
			}
			return true;
		}
	case TELEPORTS+5:
		{
			if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
			if(response)
			{
				if(Player[playerid][pJail]) return 0;
				new vehid = GetPlayerVehicleID(playerid);
				SetPlayerInterior(playerid, 0);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
					t_LinkVehicleToInterior(vehid, 0);
					t_SetVehiclePos(vehid, tpDerevni[listitem][pPosX],tpDerevni[listitem][pPosY],tpDerevni[listitem][pPosZ]);
				}
				else
					t_SetPlayerPos(playerid, tpDerevni[listitem][pPosX],tpDerevni[listitem][pPosY],tpDerevni[listitem][pPosZ]);
				if(!LanglePlayer{playerid})
					format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\" [%d].", tpDerevni[listitem][nameD], listitem);
				else
					format(string, sizeof(string), ""SERVER_MSG"You are teleported to \"%s\" [%d].", tpDerevni[listitem][nameD], listitem);
				SendClientMessage(playerid,-1,string);
			}
			return true;
		}
		default: return false;
	}
	return 0;
}
COMMAND:topduel(playerid){
	if(Player[playerid][pJail]) return 0;
	bigdialog = "";
	new buffer[128];
	strcat(bigdialog,"{FFFFFF}\t\t\tОбщие рекорды\n{00f5da}Тип рекорда\t\t\tРекорд\tНик\n");
	format(buffer,sizeof(buffer),"{FFFFFF}Количество побед\t\t%d\t\t%s\n",RecordSkolk[RECORD_WINS],RecorderName[RECORD_WINS]);
	strcat(bigdialog,buffer);
	format(buffer,sizeof(buffer),"{00f5da}Количество проигрышей\t%d\t\t%s\n",RecordSkolk[RECORD_LOOS],RecorderName[RECORD_LOOS]);
	strcat(bigdialog,buffer);
	format(buffer,sizeof(buffer),"{FFFFFF}Коэффициент побед\t\t%0.2f\t\t%s\n",RecordKoeff,RecorderName[RECORD_KOEF]);
	strcat(bigdialog,buffer);
	strcat(bigdialog,"{FFFFFF}\t\t\tРекорды на треках\n{00f5da}Имя трека\t\t\tРекорд\tНик\n");
	for(new i; i < RACE_TRACKS; i++){
		if(!(i%2) || i == 0)
			strcat(bigdialog,"{FFFFFF}");//(
		else
			strcat(bigdialog,"{00f5da}");
		format(buffer,sizeof(buffer),"%21s%s%04d\t\t%s",Starts[i][rName],(strlen(Starts[i][rName])<17)?("\t\t"):("\t"),RaceInfo[i][Record],RaceInfo[i][Recordsman]);
		strcat(bigdialog,buffer);
		if(i < RACE_TRACKS-1)
			strcat(bigdialog,"\n");
	}
	ShowPlayerDialog(playerid, 3213, DIALOG_STYLE_MSGBOX, "Топ дуэлянтов", bigdialog, "Закрыть", "" );
	return true;
}
COMMAND:topmoney(playerid){
	if(Player[playerid][pJail]) return 0;
	mysql_function_query(MYSQL, "SELECT `Nickname`, `Money`, `id` FROM `accounts` ORDER BY `Money` DESC LIMIT 10", true, "TopMoney", "d", playerid);
	return true;
}
public TopMoney(playerid){
	new rows, fields, string[32],member = 1;
	cache_get_data(rows, fields);
	if(!rows)
	return print("No Connect");
	bigdialog = "";
	strcat(bigdialog,"{ffffff}\tДеньги\tНик\n");
	for(new i; i < rows; i++){
		if(!(i%2))
			strcat(bigdialog, "{00f5da}");
		else
			strcat(bigdialog, "{FFFFFF}");
		if(member != rows)
			strcat(bigdialog,"  ");
		format(string, sizeof(string), "%d]\t",member);
		strcat(bigdialog, string);
		cache_get_field_content(i, "Money", string);
		strcat(bigdialog, string);
		records[RECORD_MONEY][i] = strval(string);
		strcat(bigdialog, "\t");
		if(records[RECORD_MONEY][i] < 1000000)
			strcat(bigdialog, "\t");
		cache_get_field_content(i, "Nickname", string);
		strcat(bigdialog, string);
		if(member != rows)
			strcat(bigdialog, "\n");
		member++;
	}
	ShowPlayerDialog(playerid, 3213, DIALOG_STYLE_MSGBOX, "Топ богачей", bigdialog, "Закрыть", "" );
	return true;
}
public TopMoneyUpdate(){
	new rows, fields, string[32];
	cache_get_data(rows, fields);
	for(new i; i < rows; i++){
		cache_get_field_content(i, "id", string);
		recorder[RECORD_MONEY][i] = strval(string);
		cache_get_field_content(i, "Money", string);
		records[RECORD_MONEY][i] = strval(string);
	}
	return true;
}
public TopWins(){
	new rows, fields,buffer[10];
	cache_get_data(rows, fields);
	if(rows){
		cache_get_field_content(0, "Nickname", RecorderName[RECORD_WINS]);
		cache_get_field_content(0, "WinRace", buffer); RecordSkolk[RECORD_WINS] = strval(buffer);
	}
	return true;
}
public TopLoose(){
	new rows, fields,buffer[10];
	cache_get_data(rows, fields);
	if(rows){
		cache_get_field_content(0, "Nickname", RecorderName[RECORD_LOOS]);
		cache_get_field_content(0, "LooseRace", buffer); RecordSkolk[RECORD_LOOS] = strval(buffer);
	}
	return true;
}
public TopKoeff(){
	new rows, fields,buffer[10];
	cache_get_data(rows, fields);
	if(rows){
		cache_get_field_content(0, "Nickname", RecorderName[RECORD_KOEF]);
		cache_get_field_content(0, "KoeffPobed", buffer); RecordKoeff = floatstr(buffer);
	}
	return true;
}
public TopClansMoney(playerid){
	new rows, fields, clanid, string[32],member = 1;
	cache_get_data(rows, fields);
	if(!rows)
	return print("No Connect");
	bigdialog = "";
	strcat(bigdialog,"{FFFFFF}\tДеньги\tТег\n");
	for(new i; i < rows; i++){
		if(i)		strcat(bigdialog, "\n");
		if(!(i%2)) 	strcat(bigdialog, "{00f5da}");
		else 		strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog,"  ");
		if(member < 10)
			strcat(bigdialog,"  ");
		format(string, sizeof(string), "%d]\t",member);
		strcat(bigdialog, string);
		cache_get_field_content(i, "cMoney", string);
		strcat(bigdialog,string);
		strcat(bigdialog,"\t");
		cache_get_field_content(i, "cID", string);
		clanid = strval(string);
		strcat(bigdialog,ReturnClanTag(ReturnClotBD(clanid)));
		member++;
	}
	ShowPlayerDialog(playerid, CLAN_DIALOG-2, DIALOG_STYLE_MSGBOX, "{FFFFFF}Топ самых богатых кланов", bigdialog, "Закрыть", "" );
	return true;
}
public TopClansStrong(playerid){
	new rows, fields, clanid, string[32],member = 1;
	cache_get_data(rows, fields);
	if(!rows)
	return print("No Connect");
	bigdialog = "";
	strcat(bigdialog,"{FFFFFF}\tРепутация\tТег\n");
	for(new i; i < rows; i++){
		if(i)		strcat(bigdialog, "\n");
		if(!(i%2)) 	strcat(bigdialog, "{00f5da}");
		else 		strcat(bigdialog, "{FFFFFF}");
		strcat(bigdialog,"  ");
		if(member < 10)
			strcat(bigdialog,"  ");
		format(string, sizeof(string), "%d]\t",member);
		strcat(bigdialog, string);
		cache_get_field_content(i, "cRate", string);
		strcat(bigdialog,string);
		strcat(bigdialog,"\t\t");
		cache_get_field_content(i, "cID", string);
		clanid = strval(string);
		strcat(bigdialog,ReturnClanTag(ReturnClotBD(clanid)));
		member++;
	}
	ShowPlayerDialog(playerid, CLAN_DIALOG-2, DIALOG_STYLE_MSGBOX, "{FFFFFF}Топ самых сильных кланов", bigdialog, "Закрыть", "" );
	return true;
}
COMMAND:toplevel(playerid){
	if(Player[playerid][pJail]) return 0;
	mysql_function_query(MYSQL, "SELECT `Nickname`,`level` FROM `accounts` ORDER BY `level` DESC LIMIT 10", true, "TopLevel", "d", playerid);
	return true;
}
GetInLevelTop(playerid){
	for(new i; i < 10; i++){
        if(Player[playerid][pSQLID] == recorder[RECORD_LEVEL][i])
            return i+1;
	}
	return 0;
}
GetInMoneyTop(playerid){
	for(new i; i < 10; i++){
        if(Player[playerid][pSQLID] == recorder[RECORD_MONEY][i])
            return i+1;
	}
	return 0;
}
public TopLevelUpdate(){
	new rows, fields, string[32];
	cache_get_data(rows, fields);
	for(new i; i < rows; i++){
		cache_get_field_content(i, "id", string);
		recorder[RECORD_LEVEL][i] = strval(string);
		cache_get_field_content(i, "level", string);
		records[RECORD_LEVEL][i] = strval(string);
	}
	return true;
}
public TopLevel(playerid){
	new rows, fields, string[32],member = 1;
	cache_get_data(rows, fields);
	if(!rows)
	return print("No Connect");
	bigdialog = "";
	strcat(bigdialog,"{FFFFFF}\tLEVEL\t\tНик\n");
	for(new i; i < rows; i++){
		if(!(i%2))
			strcat(bigdialog, "{00f5da}");
		else
			strcat(bigdialog, "{FFFFFF}");
		if(member != rows)
			strcat(bigdialog,"  ");
		format(string, sizeof(string), "%d]\t",member);
		strcat(bigdialog, string);
		cache_get_field_content(i, "level", string);
		strcat(bigdialog, string);
		records[RECORD_LEVEL][i] = strval(string);
		strcat(bigdialog, "\t\t");
		cache_get_field_content(i, "Nickname", string);
		strcat(bigdialog, string);
		if(member != rows)
			strcat(bigdialog, "\n");
		member++;
	}
	ShowPlayerDialog(playerid, 3213, DIALOG_STYLE_MSGBOX, "Топ игроков по уровню", bigdialog, "Закрыть", "" );
	return true;
}
StopCount(playerid){
	if(AllCounts[playerid][started]){
		AllCounts[playerid][started] = false;
	    AllCounts[playerid][xC] = 0;
		AllCounts[playerid][yC] = 0;
		AllCounts[playerid][zC] = 0;
		AllCounts[playerid][time] = 0;
		AllCounts[playerid][timestart] = 0;
		for(new f = 0, all = MAX_PLAYERS; f < all; f++){
			if(!IsPlayerConnected(f))continue;
	 		if(!Player[f][logged])continue;
	 		if(countid[f] == playerid)
	 			countid[f] = INVALID_COUNT_ID;
}	}	}
COMMAND:count(playerid, params[]){
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]))
	    params[0] = 5;
	if(countid[playerid] != INVALID_COUNT_ID) return SendClientMessage(playerid,-1,""SERVER_MSG"Кто-то рядом уже запустил отсчет!");
	if(AllCounts[playerid][started]) return SendClientMessage(playerid,-1,""SERVER_MSG"Вы уже запустили отсчет!");
	if(!(2 < params[0] < 11)) return SendClientMessage(playerid,-1,""SERVER_MSG"Допустимый предел отсчета: 3-10!");
	AllCounts[playerid][started] = true;
	GetPlayerPos(playerid,AllCounts[playerid][xC],AllCounts[playerid][yC],AllCounts[playerid][zC]);
	AllCounts[playerid][time] = params[0];
	countid[playerid] = playerid;
	AllCounts[playerid][timestart] = gettime();
	new Float:dis,msg[112];
	format(msg,sizeof(msg),""SERVER_MSG"{%s}%s{FFFFFF} начал отсчет от %d.",chatcolor[Player[playerid][pColorPlayer]], Player[playerid][PlayerName],params[0]);
	new world = GetPlayerVirtualWorld(playerid);
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f))continue;
 		if(!Player[f][logged] || (countid[f] != INVALID_COUNT_ID && f != playerid) || world != GetPlayerVirtualWorld(f)) continue;
		dis = GetPlayerDistanceFromPoint(f, AllCounts[playerid][xC],AllCounts[playerid][yC],AllCounts[playerid][zC]);
		if(dis > 20) continue;
		countid[f] = playerid;
		SendClientMessage(f,-1,msg);
		new showtime = 980-(GetTickCount()-timetimer);
		if(showtime > 10)
			GameTextForPlayer(f,"COUNT",showtime,6);
	}
	return true;
}
COMMAND:f(playerid){
	if(Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new Float:Coord;
		GetVehicleZAngle(GetPlayerVehicleID(playerid), Coord);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), Coord);
	}else
		SendClientMessage(playerid, -1, ""SERVER_MSG"Вы не водитель транспортного средства.");
	return true;
}
COMMAND:drag(playerid, params[]){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]) || params[0] > DRAGRACK || params[0] < 1) return SendClientMessage(playerid, -1, ""SERVER_MSG"/drag [1..."DRAGRACKE"]");
	new vehid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, DragTeleports[params[0]-1][dx],DragTeleports[params[0]-1][dy],DragTeleports[params[0]-1][dz]);
		SetVehicleZAngle(vehid, DragTeleports[params[0]-1][da]);
	}
	else
		t_SetPlayerPos(playerid, DragTeleports[params[0]-1][dx],DragTeleports[params[0]-1][dy],DragTeleports[params[0]-1][dz]);
	new msg[112];
	if(!LanglePlayer{playerid})
		format(msg, sizeof(msg), ""SERVER_MSG"Вы телепортированы на \"%s\" [%d].", DragTeleports[params[0]-1][dgName], params[0]);
	else
		format(msg, sizeof(msg), ""SERVER_MSG"You are teleported to \"%s\" [%d].", DragTeleports[params[0]-1][dgNameEn], params[0]);
	SendClientMessage(playerid,-1,msg);
	SetPlayerInterior(playerid, 0);
	t_LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
	return true;
}
COMMAND:drift(playerid, params[]){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]) || params[0] > DRIFTRACK || params[0] < 1) return SendClientMessage(playerid, -1, ""SERVER_MSG"/drift [1..."DRIFTRACKE"]");
	new vehid = GetPlayerVehicleID(playerid),
		rand = random(3),
		Float:Xtp = (rand==0?DriftTeleports[params[0]-1][pPosX1]:((rand==1)?DriftTeleports[params[0]-1][pPosX2]:DriftTeleports[params[0]-1][pPosX3])),
		Float:Ytp = (rand==0?DriftTeleports[params[0]-1][pPosY1]:((rand==1)?DriftTeleports[params[0]-1][pPosY2]:DriftTeleports[params[0]-1][pPosY3]));
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, Xtp,Ytp,DriftTeleports[params[0]-1][pPosZ]);
		SetVehicleZAngle(vehid, DriftTeleports[params[0]-1][pPosA]);
	}
	else
		t_SetPlayerPos(playerid, Xtp,Ytp,DriftTeleports[params[0]-1][pPosZ]);
	new string[112];
	if(!LanglePlayer{playerid})
		format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\" [%d].", DriftTeleports[params[0]-1][dtName], params[0]);
	else
		format(string, sizeof(string), ""SERVER_MSG"You are teleported to \"%s\" [%d].", DriftTeleports[params[0]-1][dtNameEn], params[0]);
	SendClientMessage(playerid,-1,string);
	SetPlayerInterior(playerid, 0);
	return true;
}
COMMAND:gtp(playerid){
	if(Player[playerid][pJail]) return 0;
	ShowPersTeleList(playerid);
	SetPVarInt(playerid,"GoToTele",1);
	return true;
}
COMMAND:s(playerid){
	new Float:coord[3]; GetPlayerPos(playerid, coord[0], coord[1], coord[2]);
	SetPVarFloat(playerid, "CoordX", coord[0]);
	SetPVarFloat(playerid, "CoordY", coord[1]);
	SetPVarFloat(playerid, "CoordZ", coord[2]);
	SetPVarFloat(playerid, "tpest", 1);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle);
	else
		GetPlayerFacingAngle(playerid, Angle);
	SetPVarFloat(playerid, "zAngle", Angle);
	SendClientMessage(playerid, COLOR_WHITE,""SERVER_MSG"Для телепорта на эту точку, пропишите '/r'");
	return 1;
}
COMMAND:r(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(GetPVarFloat(playerid, "tpest"))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
			t_SetVehiclePos(GetPlayerVehicleID(playerid),GetPVarFloat(playerid, "CoordX"), GetPVarFloat(playerid, "CoordY"), GetPVarFloat(playerid, "CoordZ")+2);
			SetVehicleZAngle(GetPlayerVehicleID(playerid),GetPVarFloat(playerid, "zAngle"));
		}else{
	 		t_SetPlayerPos(playerid, GetPVarFloat(playerid, "CoordX"), GetPVarFloat(playerid, "CoordY"), GetPVarFloat(playerid, "CoordZ")+2);
	  		SetPlayerFacingAngle(playerid, GetPVarFloat(playerid, "zAngle"));
	}	}
    else SendClientMessage(playerid, COLOR_WHITE,""SERVER_MSG"У вас нет точки ТП!");
 	return 1;
}
COMMAND:beath(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehid = GetPlayerVehicleID(playerid);
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, -2191.1953,-2766.7981,34.9733);
	}
	else
		t_SetPlayerPos(playerid, -2191.1953,-2766.7981,34.9733);
	SendClientMessage(playerid,-1,""SERVER_MSG"Вы телепортированы на \"Пляж\".");
	return true;
}
COMMAND:island(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED || Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehid = GetPlayerVehicleID(playerid);
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, -668.6948,1946.1688,4.2720);
	}
	else
		t_SetPlayerPos(playerid, -668.6948,1946.1688,4.2720);
	SendClientMessage(playerid,-1,""SERVER_MSG"Вы телепортированы на \"Остров\".");
	return true;
}
COMMAND:ls(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehid = GetPlayerVehicleID(playerid);
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, 1856.6,-1382.3,13.3);
	}
	else
		t_SetPlayerPos(playerid, 1856.6,-1382.3,13.3);
	SendClientMessage(playerid,-1,""SERVER_MSG"Вы телепортированы в \"Los Santos\".");
	return true;
}
COMMAND:rr(playerid){
	if(Player[playerid][pJail] || rRaceStatusEx[playerid] != STATUS_RACE_STARTED)
		return SendClientMessage(playerid,-1,""SERVER_MSG"Вы не участвуете в дуэли!"),false;
	t_SetVehiclePos(GetPlayerVehicleID(playerid),Starts[DDInfo[RaceID[playerid]][rTrackID]][startX],Starts[DDInfo[RaceID[playerid]][rTrackID]][startY],Starts[DDInfo[RaceID[playerid]][rTrackID]][startZ]);
	SetVehicleZAngle(GetPlayerVehicleID(playerid),Starts[DDInfo[RaceID[playerid]][rTrackID]][startA]);
	return true;
}
COMMAND:dd(playerid){
	if(Player[playerid][pJail] || rRaceStatusEx[playerid] != STATUS_SEND_ACCEPT)
		return SendClientMessage(playerid,-1,""SERVER_MSG"Вы не участвуете в дуэли!"),false;
	new info[256];
	if(!LanglePlayer{playerid}){
		format(info,sizeof(info),"{FFFFFF}Тебя вызвали на дуэль!\nСоперник:\t\t%s\nТрасса:\t\t\t%s\n\tНажмите \"Стартуем\"",Player[GetDDSopernikID(playerid)][PlayerName],Starts[DDInfo[RaceID[playerid]][rTrackID]][rName]);
		ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5"",info,"Стартуем","Отмена");
	}else{
		format(info,sizeof(info),"{FFFFFF}You were called to a duel! \nOpponent:\t\t%s\nTrack:\t\t\t%s\n\tPress \"Start\"",Player[GetDDSopernikID(playerid)][PlayerName],Starts[DDInfo[RaceID[playerid]][rTrackID]][rNameEn]);
		ShowPlayerDialog(playerid,DIALOG_DRIFT_RACE,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5_EN"",info,"Start","Cancel");
	}
	return true;
}
COMMAND:lv(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehid = GetPlayerVehicleID(playerid);
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, 2037.6,1347,10.6);
	}
	else
		t_SetPlayerPos(playerid, 2037.6,1347,10.6);
	SendClientMessage(playerid,-1,""SERVER_MSG"Вы телепортированы в \"Las Venturas\".");
	return true;
}
COMMAND:sp(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehid = GetPlayerVehicleID(playerid);
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, 4328.4165,-2657.7395,2454.3135);
		SetVehicleZAngle(vehid, 18.4718);
	}
	else
		t_SetPlayerPos(playerid, 4328.4165,-2657.7395,2454.3135);
	SendClientMessage(playerid,-1,""SERVER_MSG"Вы телепортированы на \"Спираль\".");
	return true;
}
COMMAND:sf(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		new vehid = GetPlayerVehicleID(playerid);
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, -1771,-570.7,16.1);
	}
	else
		t_SetPlayerPos(playerid, -1771,-570.7,16.1);
	SendClientMessage(playerid,-1,""SERVER_MSG"Вы телепортированы в \"San Fierro\".");
	return true;
}
COMMAND:mp(playerid, params[]){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]) || params[0] > sizeof(tpMapPack) || params[0] < 1) return SendClientMessage(playerid, -1, ""SERVER_MSG"/d [1...22]");
	new vehid = GetPlayerVehicleID(playerid),
		i = params[0]-1;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, tpMapPack[i][pPosX],tpMapPack[i][pPosY],tpMapPack[i][pPosZ]);
		SetVehicleZAngle(vehid, tpMapPack[i][pPosA]);
	}
	else
		t_SetPlayerPos(playerid, tpMapPack[i][pPosX],tpMapPack[i][pPosY],tpMapPack[i][pPosZ]);
	new string[112];
	format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\".", tpMapPack[i][nameMap]);
	SendClientMessage(playerid,-1,string);
	SetPlayerInterior(playerid, 0);
	return true;
}
COMMAND:dr(playerid, params[]){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]) || params[0] > sizeof(tpDerevni) || params[0] < 1) return SendClientMessage(playerid, -1, ""SERVER_MSG"/dr [1...7]");
	new vehid = GetPlayerVehicleID(playerid),
		i = params[0]-1;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, tpDerevni[i][pPosX],tpDerevni[i][pPosY],tpDerevni[i][pPosZ]);
	}
	else
		t_SetPlayerPos(playerid, tpDerevni[i][pPosX],tpDerevni[i][pPosY],tpDerevni[i][pPosZ]);
	new string[112];
	format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\".", tpDerevni[i][nameD]);
	SendClientMessage(playerid,-1,string);
	SetPlayerInterior(playerid, 0);
	return true;
}
COMMAND:d(playerid, params[]){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]) || params[0] > DRIFTRACK || params[0] < 1) return SendClientMessage(playerid, -1, ""SERVER_MSG"/d [1..."DRIFTRACKE"]");
	new vehid = GetPlayerVehicleID(playerid),
		rand = random(3),
		Float:Xtp = (rand==0?DriftTeleports[params[0]-1][pPosX1]:((rand==1)?DriftTeleports[params[0]-1][pPosX2]:DriftTeleports[params[0]-1][pPosX3])),
		Float:Ytp = (rand==0?DriftTeleports[params[0]-1][pPosY1]:((rand==1)?DriftTeleports[params[0]-1][pPosY2]:DriftTeleports[params[0]-1][pPosY3]));
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
		t_LinkVehicleToInterior(vehid, 0);
		t_SetVehiclePos(vehid, Xtp,Ytp,DriftTeleports[params[0]-1][pPosZ]);
		SetVehicleZAngle(vehid, DriftTeleports[params[0]-1][pPosA]);
	}
	else
		t_SetPlayerPos(playerid, Xtp,Ytp,DriftTeleports[params[0]-1][pPosZ]);
	new string[112];
	format(string, sizeof(string), ""SERVER_MSG"Вы телепортированы на \"%s\" [%d].", DriftTeleports[params[0]-1][dtName], params[0]);
	SendClientMessage(playerid,-1,string);
	SetPlayerInterior(playerid, 0);
	return true;
}
COMMAND:alldt(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	if(!GetPlayerVirtualWorld(playerid)) return SendClientMessage(playerid,-1, ""SERVER_MSG"Вы в данный момент находитесь в общем виртуальном мире.");
	if(ReturnVidVehicle(GetVehicleModel(GetPlayerVehicleID(playerid))) == AIR_TS){
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid,-1,""SERVER_MSG"Данное ТС нельзя вызывать в общий вирт. мир!");
		else
			SendClientMessage(playerid,-1,""SERVER_MSG"This HARDWARE can't be called in the general virtual world!");
		return true;
	}
	t_SetPlayerVirtualWorld(playerid, 0);
	SetCarsInVorld(playerid,0);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		t_SetVehicleVirtualWorld(playerid,GetPlayerVehicleID(playerid), 0);
	SendClientMessage(playerid,-1, ""SERVER_MSG"Вы перемещены в общий виртуальный мир.");
	return true;
}
COMMAND:textur(playerid){
	if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED) return false;
	if(Player[playerid][pJail]) return 0;
	SetPlayerInterior(playerid, 0);
	t_LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {t_SetVehicleVirtualWorld(playerid,GetPlayerVehicleID(playerid), 0);}
	SendClientMessage(playerid,-1, ""SERVER_MSG"Текстуры восстановлены.");
	return true;
}
public restart(){
	restarting = true;
	t_SendClientMessageToAll(-1,-1, ""SERVER_MSG"Обновление сервера, не выходите!", ""SERVER_MSG"Server up-dating, you don't quit!");
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f))continue;
		ShowPlayerDialog(f,0,DIALOG_STYLE_MSGBOX,"{FFFFFF}Рестарт сервера","{FFFFFF}Подождите несколько секунд, пока перезапустится сервер.","Okay (-_-)","");
	}
	SendRconCommand("gmx");
}
COMMAND:kill(playerid, params[]){
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d",params[0]))  {
		if(IsPlayerInAnyVehicle(playerid))
			RemovePlayerFromVehicle(playerid);
		return SetPlayerHealth(playerid,0);
	}
	if (Player[playerid][pAdminPlayer] < LEVEL_WARN) return SendClientMessage(playerid,-1, ""SERVER_MSG"Вам не доступна данная функция!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
	if(IsPlayerInAnyVehicle(params[0]))
		RemovePlayerFromVehicle(params[0]);
	SetPlayerHealth(params[0],0);
	new msg[256];
	format(msg, sizeof(msg), ""SERVER_MSG"%s убил через админку %s.", Player[playerid][PlayerName], Player[params[0]][PlayerName]);
	SendAdminMessage(COLOR_WHITE, msg);
	msg="";
	format(msg, sizeof(msg), ""SERVER_MSG"Вас убил через админку %s.", Player[playerid][PlayerName]);
	SendClientMessage(params[0],-1, msg);
	return true;
}
COMMAND:time(playerid){
	if(!Player[playerid][pDoubleDrift] && !Player[playerid][pNoCrash] && !Player[playerid][pJail] && !Player[playerid][pVIP])
	return SendClientMessage(playerid,-1,""SERVER_MSG"У тебя нет временных дополнений!");
	new msg[256];
	if(Player[playerid][pJail]){
		format(msg, sizeof(msg), ""SERVER_MSG"Осталось сидеть в тюрьме %d минут.", Player[playerid][pJTime]);
		SendClientMessage(playerid,-1,msg);
		return true;
	}
	if(Player[playerid][pNoCrash] && !Player[playerid][pVIP]){
		msg = "";
		format(msg, sizeof(msg), ""SERVER_MSG"Действует каст: 'NoCrash', осталось %d минут.", Player[playerid][pNoCrashTime]);
		SendClientMessage(playerid,-1,msg);
	}
	if(Player[playerid][pDoubleDrift] && !Player[playerid][pVIP]){
		msg = "";
		format(msg, sizeof(msg), ""SERVER_MSG"Действует каст: 'DoubleDrift', осталось %d минут.", Player[playerid][pDoubleDriftT]);
		SendClientMessage(playerid,-1,msg);
	}
	if(Player[playerid][pVIP] && Player[playerid][pStopVip] != 999999999){
		msg = "";
		format(msg, sizeof(msg), ""SERVER_MSG"VIP кончится через: %s.", timec(Player[playerid][pStopVip]));
		SendClientMessage(playerid,-1,msg);
	}
	return true;
}
COMMAND:admins(playerid){
	mysql_function_query(MYSQL, "SELECT `Nickname`, `Online` FROM `accounts` WHERE `AdminEx` > 1 ORDER BY `Online` DESC", true, "AdminsEx", "d", playerid);
	return true;
}
public AdminsEx(playerid){
	new rows, fields, string[32];
	cache_get_data(rows, fields);
	minidialog = "";
	for(new i; i < rows; i++){
	    if(rows)
			strcat(minidialog, "\n");
		if(!(i%2))
			strcat(minidialog, "{00f5da}");
		else
			strcat(minidialog, "{FFFFFF}");
		cache_get_field_content(i, "Online", string);
        if(string[0] == '1')
			strcat(minidialog, "{00ff00}[Online]\t{FFFFFF}");
		else
			strcat(minidialog, "{ff0000}[Offline]\t{FFFFFF}");
		cache_get_field_content(i, "Nickname", string);
		strcat(minidialog, string);
	}
	ShowPlayerDialog(playerid, 3213, DIALOG_STYLE_MSGBOX, "Администраторы сервера", minidialog, "Закрыть", "" );
	return true;
}
COMMAND:kickme(playerid){
	if(!LanglePlayer{playerid})
		SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#21]");
	else
		SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#21]");
	t_Kick(playerid);
	return true;
}
COMMAND:getplayer(playerid, params[]){
	if(sscanf(params,"s[24]",params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/rkick [Часть ника]");
	new sting2[64],
	admins = 0;
	minidialog = "";
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		if(strfind(Player[i][PlayerName],params[0],true) != -1){
			admins += 1;
			format(sting2,sizeof(sting2),"[ID %d] {%s} %s\n",i,chatcolor[Player[i][pColorPlayer]],Player[i][PlayerName]);
			strcat(minidialog, sting2);
	}	}
	if(!admins) return ShowPlayerDialog(playerid,1001, DIALOG_STYLE_MSGBOX, "Find player's:", "Игроков с таким ником не найдено.", "Закрыть", "");
	ShowPlayerDialog(playerid,1001, DIALOG_STYLE_MSGBOX, "Find player's:", minidialog, "Закрыть", "");
	return true;
}
COMMAND:help(playerid){
	bigdialog ="";
	if(!LanglePlayer{playerid}){
		strcat(bigdialog, "{FFFFFF}\t\t----| Используйте меню: |----\n");
		strcat(bigdialog, "Большинство функций сервера есть в меню\n");
		strcat(bigdialog, "\tчтобы оно открылось нужно\n");
		if(Player[playerid][pKeyMenu])
			strcat(bigdialog, "\t\tНажать кнопку \"{00f5da}Alt / 2{FFFFFF}\"\n");
		else
			strcat(bigdialog, "\t\tНажать кнопку \"{00f5da}Y{FFFFFF}\"\n");
		strcat(bigdialog, "\t\t----| Дополнительно: |----\n");
		strcat(bigdialog, "\"{00f5da}/topmoney{FFFFFF}\"\t\t[TOP] Самых богатых людей на сервере\n");
		strcat(bigdialog, "\"{00f5da}/toplevel{FFFFFF}\"\t\t[TOP] Игроков по уровням\n");
		strcat(bigdialog, "\"{00f5da}/count (3-10){FFFFFF}\"\t\tОтсчет\n");
		strcat(bigdialog, "\"{00f5da}/f{FFFFFF}\"\t\t\tПеревернуть авто [Флипнуть]\n");
		strcat(bigdialog, "\"{00f5da}/drag (1-2){FFFFFF}\"\t\tТелепорт на драг трассы\n");
		strcat(bigdialog, "\"{00f5da}/drift (1-16){FFFFFF}\"\t\tТелепорт на дрифт трассы\n");
		strcat(bigdialog, "\"{00f5da}/dt (0-99){FFFFFF}\"\t\tСменить виртуальный мир\n");
		strcat(bigdialog, "\"{00f5da}/ct (0-1000){FFFFFF}\"\t\tСменить чат комнату\n");
		strcat(bigdialog, "\"{00f5da}/alldt{FFFFFF}\"\t\t\tОбщий виртуальный мир\n");
		strcat(bigdialog, "\"{00f5da}/textur{FFFFFF}\"\t\tВернуть текстуры [на случай если пропадут]\n");
		strcat(bigdialog, "\"{00f5da}/kill{FFFFFF}\"\t\t\tСамоубийство\n");
		strcat(bigdialog, "\"{00f5da}/time{FFFFFF}\"\t\t\tВремя: Кастов, Остатка VIP, Ареста\n");
		strcat(bigdialog, "\"{00f5da}/admins{FFFFFF}\"\t\tСписок администраторов\n");
		strcat(bigdialog, "\"{00f5da}/vips{FFFFFF}\"\t\t\t"TEXT_CLAN_11" о VIP\n");
		strcat(bigdialog, "\"{00f5da}/kickme{FFFFFF}\"\t\tКикнуть себя\n");
		strcat(bigdialog, "\"{00f5da}/help{FFFFFF}\"\t\t\tПомощь по серверу\n");
		strcat(bigdialog, "\"{00f5da}/ask{FFFFFF}\"\t\t\tВопрос по игре\n");
		strcat(bigdialog, "\"{00f5da}/rules{FFFFFF}\"\t\tПравила сервера\n");
		strcat(bigdialog, "\"{00f5da}/ccme{FFFFFF}\"\t\tОчистить свой чат\n");
		strcat(bigdialog, "\"{00f5da}/moove{FFFFFF}\"\t\tРежим Moovie [Режим для снятия видео]\n");
		strcat(bigdialog, "\"{00f5da}/mystat{FFFFFF}\"\t\tСтатистика аккаунта\n");
		strcat(bigdialog, "\"{00f5da}/remov (ID){FFFFFF}\"\t\tВыгнать человека из авто\n");
		strcat(bigdialog, "\"{00f5da}/ob (text){FFFFFF}\"\t\tПодать объявление\n");
		strcat(bigdialog, "\"{00f5da}/givecash{FFFFFF}\"\t\tПередать деньги\n");
		strcat(bigdialog, "\"{00f5da}/mydt{FFFFFF}\"\t\t\tУзнать свой виртуальный мир");
		return ShowPlayerDialog(playerid, 190, DIALOG_STYLE_MSGBOX, "HELP по серверу", bigdialog, "Ок", "");
	}else{
		strcat(bigdialog, "{FFFFFF}\t\t----| Used menu: |----\n");
		strcat(bigdialog, "The majority of functions of the server is in the menu\n");
		strcat(bigdialog, "\tit would open it is necessary\n");
		if(Player[playerid][pKeyMenu])
			strcat(bigdialog, "\t\tTo press the button \"{00f5da}Alt / 2{FFFFFF}\"\n");
		else
			strcat(bigdialog, "\t\tTo press the button \"{00f5da}Y{FFFFFF}\"\n");
		strcat(bigdialog, "\t\t----| Additional: |----\n");
		strcat(bigdialog, "\"{00f5da}/topmoney{FFFFFF}\"\t\t[TOP] The richest people on the server\n");
		strcat(bigdialog, "\"{00f5da}/toplevel{FFFFFF}\"\t\t[TOP] Players on levels\n");
		strcat(bigdialog, "\"{00f5da}/count (3-10){FFFFFF}\"\t\tCount\n");
		strcat(bigdialog, "\"{00f5da}/f{FFFFFF}\"\t\t\tTo turn a car [flipped]\n");
		strcat(bigdialog, "\"{00f5da}/drag (1-2){FFFFFF}\"\t\tTeleport on route drags\n");
		strcat(bigdialog, "\"{00f5da}/drift (1-16){FFFFFF}\"\t\tTeleport on a route drift\n");
		strcat(bigdialog, "\"{00f5da}/dt (0-99){FFFFFF}\"\t\tTo replace the virtual world\n");
		strcat(bigdialog, "\"{00f5da}/ct (0-1000){FFFFFF}\"\t\tTo replace a chat the room\n");
		strcat(bigdialog, "\"{00f5da}/alldt{FFFFFF}\"\t\t\tGeneral virtual world\n");
		strcat(bigdialog, "\"{00f5da}/textur{FFFFFF}\"\t\tTo return textures [on a case if are gone]\n");
		strcat(bigdialog, "\"{00f5da}/kill{FFFFFF}\"\t\t\tSuicide\n");
		strcat(bigdialog, "\"{00f5da}/time{FFFFFF}\"\t\t\tTime: Additions, Residual VIP, Arresting\n");
		strcat(bigdialog, "\"{00f5da}/admins{FFFFFF}\"\t\tList of administrators\n");
		strcat(bigdialog, "\"{00f5da}/vips{FFFFFF}\"\t\t\tInformation about the VIP\n");
		strcat(bigdialog, "\"{00f5da}/kickme{FFFFFF}\"\t\tKick itself\n");
		strcat(bigdialog, "\"{00f5da}/help{FFFFFF}\"\t\t\tHelp with the server\n");
		strcat(bigdialog, "\"{00f5da}/ask{FFFFFF}\"\t\t\tAsk on game\n");
		strcat(bigdialog, "\"{00f5da}/rules{FFFFFF}\"\t\tServer rules\n");
		strcat(bigdialog, "\"{00f5da}/ccme{FFFFFF}\"\t\tTo clear the chat\n");
		strcat(bigdialog, "\"{00f5da}/moove{FFFFFF}\"\t\tThe Moovie mode [A mode for video removal]\n");
		strcat(bigdialog, "\"{00f5da}/mystat{FFFFFF}\"\t\tStatistics of an account\n");
		strcat(bigdialog, "\"{00f5da}/remov (ID){FFFFFF}\"\t\tTo expel the person from a car\n");
		strcat(bigdialog, "\"{00f5da}/ob (text){FFFFFF}\"\t\tTo give declaration\n");
		strcat(bigdialog, "\"{00f5da}/givecash{FFFFFF}\"\t\tTo transfer money\n");
		strcat(bigdialog, "\"{00f5da}/mydt{FFFFFF}\"\t\tTo learn the virtual world");
		return ShowPlayerDialog(playerid, 190, DIALOG_STYLE_MSGBOX, "HELP on the server", bigdialog, "Ok", "");
	}
}
COMMAND:rules(playerid){
	ShowPlayerDialog(playerid,DIALOG_RULES,DIALOG_STYLE_LIST,"Правила","{ffffff}Правила сервера "SERVER_NAME"\n{ffffff}Правила мероприятия:\tДРАГ\nПравила мероприятия:\tДРИФТ\n{ffffff}Правила мероприятия:\tДЕРБИ\n{ffffff}Правила мероприятия:\tПОИСК АВТО\n{ffffff}Правила мероприятия:\tАВТО ПРОБЕГ\n{ffffff}Правила мероприятия:\tДРИФТ ДУЭЛЬ\n{ffffff}Правила мероприятия:\tДОБЕРИСЬ ДО ТОЧКИ","Выбрать","Отмена");
	return true;
}
COMMAND:ahelp(playerid){
	if (Player[playerid][pAdminPlayer] >= 1)
	bigdialog = "";
	strcat(bigdialog, "		-=команды админов=-\n");
	strcat(bigdialog, "/setmoney [ID игрока] [Деньги] (с "LEVEL_MONEY_EX" уровня) - Установить деньги игроку \n");
	strcat(bigdialog, "/givemoney [ID игрока] [Деньги] (с "LEVEL_MONEY_EX" уровня) - Дать деньги игроку \n");
	strcat(bigdialog, "/giveallmoney [Деньги (1 - 100000)] (с "LEVEL_MONEY_EX" уровня) - Дать деньги всем игрокам \n");
	strcat(bigdialog, "/asay [Текст] (с "LEVEL_CHAT_EX" уровня) - Написать сообщение от администратора \n");
	strcat(bigdialog, "/cc (с "LEVEL_CHAT_EX" уровня) - Очистить чат \n");
	strcat(bigdialog, "/mute [ID игрока] [Время (в минутах)] (с "LEVEL_MUTE_EX" уровня) - Заткнуть игрока \n");
	strcat(bigdialog, "/jail [ID игрока] [Время (в минутах)] (с "LEVEL_JAIL_EX" уровня) - Посадить игрока в тюрьму\n");
	strcat(bigdialog, "/a [Текст] - Админ чат\n");
	strcat(bigdialog, "/setlevel [ID игрока] [SCORE] (с "LEVEL_SCORE_EX" уровня) - Установить кол-во SCORE игроку\n");
	strcat(bigdialog, "/ans [ID игрока] [текст]  - ответить на репорт\n");
	strcat(bigdialog, "/ooc [Время (в секундах)] (с "LEVEL_CHAT_EX" уровня) - Выкл/Вкл главный чат\n");
	strcat(bigdialog, "/tod [0-24](с "LEVEL_WORLD_EX" уровня) - Изменить время на сервере\n");
	strcat(bigdialog, "/wea [0-45](с "LEVEL_WORLD_EX" уровня) - Изменить погоду на сервере\n");
	strcat(bigdialog, "/admost - Телепорт на админ. остров.\n");
	strcat(bigdialog, "/freeze [ID] [Время] (с "LEVEL_FREEZ_EX" уровня) заморозить игрока.\n");
	strcat(bigdialog, "/setdt [ID] [DT] (с "LEVEL_TP_EX" уровня) телепортировать игрока в виртульный мир.\n");
	strcat(bigdialog, "/del - Удалить авто.\n");
	strcat(bigdialog, "/house - Включить/Выключить дома (с "LEVEL_HOUSE_EX" уровня).\n");
	strcat(bigdialog, "/warn [ID игрока] [причина] - Выдать предупреждение(с "LEVEL_WARN_EX" уровня).\n");
	strcat(bigdialog, "/ban [ID игрока] [время, (-1 = навсегда)] [причина] - (с "LEVEL_BANN_EX" уровня).\n");
	strcat(bigdialog, "/kick [ID игрока] [причина] - Кикнуть игрока (с "LEVEL_KICK_EX" уровня).\n");
	return ShowPlayerDialog(playerid, 190, DIALOG_STYLE_MSGBOX, "AdminEx Help", bigdialog, "Ок", "");
}
COMMAND:cc(playerid){
	if(Player[playerid][pAdminPlayer] >= LEVEL_CHAT){
		for(new i;i<50;i++) { t_SendClientMessageToAll(-1,-1, " "," "); }
		new msg[112];
		format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s(%d) очистил чат",Player[playerid][PlayerName],playerid);
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s(%d) clean chat",Player[playerid][PlayerName],playerid);
		t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	}
	return true;
}
COMMAND:ccme(playerid){
	for(new i;i<50;i++)
		SendClientMessage(playerid,-1, "");
	SendClientMessage(playerid,-1, ""SERVER_MSG"Вы очистили свой чат!");
	return true;
}
COMMAND:vips(playerid){
	new cops = 0;
	bigdialog = "";
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i))continue;
 		if(!Player[i][logged] || !Player[i][pVIP]) continue;
		cops += 1;
		format(bigdialog,sizeof(bigdialog),"%s{%s} %s[%d]\n",bigdialog,chatcolor[Player[i][pColorPlayer]],Player[i][PlayerName],i);
	}
	if(!cops) return ShowPlayerDialog(playerid,1001, DIALOG_STYLE_MSGBOX, "VIP's Online:", "VIP-ов нет в сети", "Закрыть", "");
	ShowPlayerDialog(playerid,1001, DIALOG_STYLE_MSGBOX, "VIP's Online:", bigdialog, "Закрыть", "");
	return true;
}
COMMAND:moove(playerid){
	if(Player[playerid][pJail]) return 0;
	if(GetPVarInt(playerid,"nick")){
		SendClientMessage(playerid,-1,""SERVER_MSG"Режим 'Мувик' включен.");
		SetPVarInt(playerid,"nick",0);
		for(new i = 0, all = MAX_PLAYERS; i < all; i++){
			if(!IsPlayerConnected(i))continue;
			ShowPlayerNameTagForPlayer(playerid, i, false);
		}
		TextDrawHideForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
		PlayerTextDrawHide(playerid,ScoreShow[playerid]);
		PlayerTextDrawHide(playerid,LevelShow[playerid]);
		TextDrawHideForPlayer(playerid,hpDrawFon);
		TextDrawHideForPlayer(playerid,hpDraw[playerid]);
		TextDrawHideForPlayer(playerid,hpDraweFon);
		TextDrawHideForPlayer(playerid,hpDrawe[playerid]);
		PlayerTextDrawHide(playerid,DriftPointsShow[playerid]);
		if(ShowStirLock[playerid]){
			TextDrawHideForPlayer(playerid,StirLock[Player[playerid][pColorScore]]);
			ShowStirLock[playerid] = 0;
		}
	}else{
		SendClientMessage(playerid,-1,""SERVER_MSG"Режим 'Мувик' выключен.");
		SetPVarInt(playerid,"nick",1);
		for(new i = 0, all = MAX_PLAYERS; i < all; i++){
			if(!IsPlayerConnected(i))continue;
			ShowPlayerNameTagForPlayer(playerid, i, true);
		}
		TextDrawShowForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
			PlayerTextDrawShow(playerid,ScoreShow[playerid]);
			PlayerTextDrawShow(playerid,LevelShow[playerid]);
			TextDrawShowForPlayer(playerid,hpDrawFon);
 			TextDrawShowForPlayer(playerid,hpDraw[playerid]);
		}
	}
	return true;
}
COMMAND:mystat(playerid){
	new name[MAX_PLAYER_NAME];
	minidialog = "";
	strcat(name, Player[playerid][PlayerName]);
	if(!LanglePlayer{playerid}){
		strcat(minidialog, "{FFFFFF}================================\n\nНик:\t\t{");
		strcat(minidialog, chatcolor[Player[playerid][pColorPlayer]]);
		format(minidialog, sizeof(minidialog), "%s}%s\n{00f5da}Денег:\t\t\t\t%d\n{FFFFFF}Уровень:\t\t\t%d\n{00f5da}Уровень админки:\t\t%d\n{FFFFFF}Скин:\t\t\t\t%d\n{00f5da}Молчанка:\t\t\t%d\n{FFFFFF}Предупреждений:\t\t%d\n{00f5da}Виртуальный мир:\t\t%d", minidialog,name, GetPlayerCash(playerid), Player[playerid][pLevel], (Player[playerid][pAdminPlayer] > 1)?Player[playerid][pAdminPlayer]:0, Player[playerid][pSkin],Player[playerid][pMuted],GetPVarInt(playerid,"warn"),GetPlayerVirtualWorld(playerid));
		new msg[112];
		format(msg, sizeof(msg), "\n{FFFFFF}Время на сервере:\tДней:\t%d\n\t\t\tЧасов:\t%d\n\t\t\tМинут:\t%d",Player[playerid][pTimeOnlineD],Player[playerid][pTimeOnlineH],Player[playerid][pTimeOnline]);
		strcat(minidialog, msg);
		format(msg, sizeof(msg), "\n{00f5da}Побед в дуэлях\t\t%d\n{FFFFFF}Проигрышей в дуэлях\t%d\n{00f5da}Коэффициент побед\t\t%0.2f",Player[playerid][pWinRace],Player[playerid][pLooseRace],(Player[playerid][pWinRace]+0.001)/(Player[playerid][pLooseRace]+0.001));
		strcat(minidialog, msg);
		strcat(minidialog, "\n\n{FFFFFF}================================");
		ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Ваша статистика.",minidialog,"Закрыть","");
	}else{
		strcat(minidialog, "{FFFFFF}================================\n\nNick:\t\t\t\t{");
		strcat(minidialog, chatcolor[Player[playerid][pColorPlayer]]);
		format(minidialog, sizeof(minidialog), "%s}%s\n{00f5da}Money:\t\t\t%d\n{FFFFFF}Level:\t\t\t\t%d\n{00f5da}AdminEx level:\t\t\t%d\n{FFFFFF}Skin:\t\t\t\t%d\n{00f5da}Mute:\t\t\t\t%d\n{FFFFFF}Warn's:\t\t\t%d\n{00f5da}Virtual world:\t\t\t%d", minidialog,name, GetPlayerCash(playerid), Player[playerid][pLevel], (Player[playerid][pAdminPlayer] > 1)?Player[playerid][pAdminPlayer]:0, Player[playerid][pSkin],Player[playerid][pMuted],GetPVarInt(playerid,"warn"),GetPlayerVirtualWorld(playerid));
		new msg[112];
		format(msg, sizeof(msg), "\n{FFFFFF}Time on server: Day's:\t%d\n\t\t  Hour's:\t%d\n\t\t  Minut's:\t%d",Player[playerid][pTimeOnlineD],Player[playerid][pTimeOnlineH],Player[playerid][pTimeOnline]);
		strcat(minidialog, msg);
		format(msg, sizeof(msg), "\n{00f5da}Win's on duel\t\t\t%d\n{FFFFFF}Loose's on duel\t\t%d\n{00f5da}Coefficient victories\t\t%0.2f",Player[playerid][pWinRace],Player[playerid][pLooseRace],(Player[playerid][pWinRace]+0.001)/(Player[playerid][pLooseRace]+0.001));
		strcat(minidialog, msg);
		strcat(minidialog, "\n\n{FFFFFF}================================");
		ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Your statistics.",minidialog,"Close","");
	}
	return true;
}
COMMAND:remov(playerid,params[]){
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"/remov [id]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"Этот игрок оффлайн!");
	if(params[0] == playerid) return SendClientMessage(playerid, -1, ""SERVER_MSG"Самому себя выгонять нельзя!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,-1,""SERVER_MSG"Ты не водитель транспортного средства.");
	if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(params[0])) return SendClientMessage(playerid,-1,""SERVER_MSG"Извините, игрок с указанным ID сидит не в вашем авто.");
	RemovePlayerFromVehicle(params[0]);
	SendClientMessage(params[0],-1,""SERVER_MSG"Водитель выгнал тебя из авто.");
	return true;
}
COMMAND:ob(playerid, params[]){
	if(Player[playerid][pTimeOnlineD] <1 && Player[playerid][pTimeOnlineH] < 2)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Извините, вам рано использовать данную функцию! Необходимое время - 2 часа.");
	if(GetPlayerCash(playerid) < 50000)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Стоимость объявления $50 000. У Вас недостаточно денег.");
	if(timemsg > gettime()) return SendClientMessage(playerid, -1, ""SERVER_MSG"Объявления можно посылать не чаще чем раз в 45 секунд.");
	if(Player[playerid][pMuted]) return SendClientMessage(playerid, -1, ""SERVER_MSG"У тебя бан чата!");
	if(sscanf(params,"s[67]", params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/ob [текст]");
	if(strlen(params[0]) > 64) return SendClientMessage(playerid, -1, ""SERVER_MSG"Слишком много текста");
	if(strlen(params[0]) < 6) return SendClientMessage(playerid, -1, ""SERVER_MSG"Слишком мало текста");
	if(GetMiniBook(params[0]) >= strlen(params[0])/2)
		UpperToLower(params[0]);
	if(IsIP(params[0]) || CheckString(params[0])) return 0;
	new ob[250],
		obEn[250];
	DaiEmyDeneg(playerid,-50000);
	format(ob, 250, ""SERVER_MSG"Объявление: \"%s\" ({00f5da}Отправитель: {%s}%s [%d]{FFFFFF})", params[0],chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],playerid);
	format(obEn, 250, ""SERVER_MSG"Announcement: \"%s\" ({00f5da}Sender: {%s}%s [%d]{FFFFFF})", params[0],chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],playerid);
	t_SendClientMessageToAll(-1,-1," "," ");
	t_SendClientMessageToAll(-1,-1,ob,obEn);
	timemsg=gettime()+44;
	return true;
}
COMMAND:c(playerid, params[]){
	if(Player[playerid][cClan][0] == INVALID_CLAN_ID && Player[playerid][cClan][1] == INVALID_CLAN_ID) return 0;
	if(sscanf(params,"ds[114]", params[0], params[1])) return SendClientMessage(playerid, -1, "/c [номер в списке] [текст]");
	if(params[0] == 1 && Player[playerid][cClan][0] == INVALID_CLAN_ID || params[0] == 2 && Player[playerid][cClan][1] == INVALID_CLAN_ID)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"/c [номер в списке] [текст]");
	new clankey = (params[0] == 1)?Player[playerid][cClan][0]:Player[playerid][cClan][1];
	new msg[256];
	format(msg, sizeof(msg), "{%s}%s %s{FFFF00}: %s",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],ReturnClanTag(ReturnClotBD(clankey)),params[1]);
	SendClanMessage(clankey,msg);
	return true;
}
COMMAND:a(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < 2) return 0;
	if(sscanf(params,"s[114]", params[0])) return SendClientMessage(playerid, COLOR_WHITE, "/a [text]");
	new msg[256];
	format(msg, sizeof(msg), "[Админ-Чат] %s: %s",Player[playerid][PlayerName],params[0]);
	SendAdminMessage(COLOR_YELLOW, msg);
	return true;
}
COMMAND:ans(playerid, params[]){
	if(!Player[playerid][pAdminPlayer]) return 0;
	if(sscanf(params,"ds[256]", params[0],params[1]))
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/ans [ид] [текст]");
	if(!IsPlayerConnected(params[0]))
		return SendClientMessage(playerid,-1,""SERVER_MSG"Этого игрока нет на сервере!");
	if(ans[params[0]] < ask[params[0]])
		DaiEmyDeneg(playerid,25000);
	ans[params[0]] = gettime();
	new msg[256];
	format(msg, sizeof(msg), ""SERVER_MSG"{%s}%s[%d]{ffffff} ответил: %s",chatcolor[Player[params[0]][pColorPlayer]],Player[playerid][PlayerName],playerid, params[1]);
	SendClientMessage(params[0], COLOR_LIGHTBLUE, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"Вы ответили %s[%d]: %s",Player[params[0]][PlayerName], params[0],params[1]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
	printf("%s ответил: %s",Player[playerid][PlayerName],params[1]);
	return true;
}
COMMAND:givemoney(playerid,params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_MONEY) return 0;
	if(sscanf(params,"dd",params[0],params[1])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/givemoney id значение");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"Этот игрок оффлайн!");
	DaiEmyDeneg(params[0],params[1]);
	new msg[256];
	format(msg, sizeof(msg), ""SERVER_MSG"Вы получили %d денег от Администратора %s",params[1],Player[playerid][PlayerName]);
	SendClientMessage(params[0], 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"Вы выдали %d денег %s",params[1],Player[params[0]][PlayerName]);
	SendClientMessage(playerid, 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), "%s прописал %d денег %s.",Player[playerid][PlayerName],params[1],Player[params[0]][PlayerName]);
	WriteRusLog("money.cfg", msg);
	return true;
}
COMMAND:givedonat(playerid,params[]){
	if(Player[playerid][pAdminPlayer] < 6) return 0;
	if(sscanf(params,"dd",params[0],params[1])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/givedonat id значение");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"Этот игрок оффлайн!");
	Player[params[0]][pDonatM] += params[1];
	new msg[256];
	format(msg, sizeof(msg), ""SERVER_MSG"Вы получили %d DM от Администратора %s",params[1],Player[playerid][PlayerName]);
	SendClientMessage(params[0], 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"Вы выдали %d DM %s",params[1],Player[params[0]][PlayerName]);
	SendClientMessage(playerid, 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), "%s прописал %d DM %s.",Player[playerid][PlayerName],params[1],Player[params[0]][PlayerName]);
	WriteRusLog("money.cfg", msg);
	return true;
}
COMMAND:setmoney(playerid,params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_MONEY) return 0;
	if(sscanf(params,"dd",params[0],params[1])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/setmoney id значение");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"Этот игрок оффлайн!");
	ResetEmyDengi(params[0]);
	DaiEmyDeneg(params[0],params[1]);
	new msg[256];
	format(msg, sizeof(msg), ""SERVER_MSG"Вам установили %d денег от Администратора %s",params[1],Player[playerid][PlayerName]);
	SendClientMessage(params[0], 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"Вы устанивили %d денег %s",params[1],Player[params[0]][PlayerName]);
	SendClientMessage(playerid, 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"%s[%d] установил %d денег %s[%d].",Player[playerid][PlayerName],playerid,params[1],Player[params[0]][PlayerName],params[0]);
	SendgAdminMessage(0xFF8000AA, msg);
	WriteRusLog("money.cfg", msg);
	return true;
}
COMMAND:mute(playerid,params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_MUTE) return 0;
	if(sscanf(params,"dds[112]",params[0],params[1],params[2]))return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"Юзай: /mute [id] [time] [причина]");
	if (params[1] > 1200 && Player[playerid][pAdminPlayer] < 6) return SendClientMessage(playerid,-1,""SERVER_MSG"Время мута не может быть больше 1200.");
	if (params[1] < 1) return SendClientMessage(playerid,-1,""SERVER_MSG"Время мута не может быть меньше 1.");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
	new msgjail[256];
	if(Player[params[0]][pMuted] == false){
		Player[params[0]][pMuted] = true;
		Player[params[0]][pMutedAdm] = Player[playerid][pAdminPlayer];
		Player[params[0]][pMuteTime] = params[1];
		format(msgjail, sizeof(msgjail), ""SERVER_MSG"Администратор %s(%d) отключил чат игроку %s(%d) на %d минут.",Player[playerid][PlayerName], playerid,Player[params[0]][PlayerName], params[0],params[1]);
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s(%d) has muted %s(%d) for %d minutes.",Player[playerid][PlayerName], playerid,Player[params[0]][PlayerName], params[0],params[1]);
		t_SendClientMessageToAll(-1,-1, msgjail, msgcheatEn);
		format( msgjail, sizeof(msgjail), ""SERVER_MSG"Причина:\"%s\"",params[2]);
		format( msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Reason:\"%s\"",params[2]);
		t_SendClientMessageToAll(-1,-1, msgjail, msgcheatEn);
	}else{
		if(Player[playerid][pAdminPlayer] < Player[params[0]][pMutedAdm]) return SendClientMessage(playerid,-1,""SERVER_MSG"Ваш уровень админки слишком мал чтоб включить чат этому игроку!");
		if(params[0] == playerid && Player[playerid][pAdminPlayer] < 6) return SendClientMessage(playerid,-1,""SERVER_MSG"Не не не! Самому себе чат включать нельзя!");
		Player[params[0]][pMuteTime] = 0;
		Player[params[0]][pMuted] = false;
		format(msgjail, sizeof(msgjail), ""SERVER_MSG"Администратор %s(%d) включил чат игроку %s(%d)",Player[playerid][PlayerName],playerid,Player[params[0]][PlayerName],params[0]);
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s(%d) has unmuted %s(%d)",Player[playerid][PlayerName],playerid,Player[params[0]][PlayerName],params[0]);
		t_SendClientMessageToAll(-1,-1, msgjail,msgcheatEn);
	}
	return true;
}
COMMAND:jail(playerid,params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_JAIL) return 0;
	if(sscanf(params,"dds[64]",params[0],params[1],params[2]))return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"Юзай: /jail [id] [time] [причина]");
	if (params[1] > 120) return SendClientMessage(playerid,-1,""SERVER_MSG"Время тюрьмы не может быть больше 120.");
	if (params[1] < 1) return SendClientMessage(playerid,-1,""SERVER_MSG"Время тюрьмы не может быть меньше 1.");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
	if(!Player[params[0]][pJail]){
		new msgjail[256];
		format(msgjail, sizeof(msgjail), ""SERVER_MSG"Администратор %s(%d) посадил в тюрьму игрока %s(%d) на %d минут. Причина: %s",Player[playerid][PlayerName], playerid,Player[params[0]][PlayerName], params[0],params[1],params[2]);
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s(%d) has jailed %s(%d) for %d minutes. Reason: %s",Player[playerid][PlayerName], playerid,Player[params[0]][PlayerName], params[0],params[1],params[2]);
		t_SendClientMessageToAll(-1,-1, msgjail,msgcheatEn);
		Player[params[0]][pJailAdm] = Player[playerid][pAdminPlayer];
		Player[params[0]][pJail] = true;
		Player[params[0]][pJTime] = params[1];
		SetPlayerInterior(params[0],6);
		t_SetPlayerVirtualWorld(params[0],789);
		t_SetPlayerPos(params[0],264.20001220703,77.800003051758,1001);
		SetPlayerCameraLookAt(params[0], 264.89999389648,77.199996948242,1001);
		SetPlayerCameraPos(params[0],262.5,79.599998474121,1003.4000244141);
	}else{
		if(params[0] == playerid && Player[playerid][pAdminPlayer] < 6) return SendClientMessage(playerid,-1,""SERVER_MSG"Не не не! Самого себя выпускать нельзя!");
		if(Player[playerid][pAdminPlayer] < Player[params[0]][pJailAdm] && Player[playerid][pAdminPlayer] < 6) return SendClientMessage(playerid,-1,""SERVER_MSG"Ваш уровень админки слишком мал чтобы выпустить его из тюрьмы!");
		UnJails(params[0]);
	}
	return true;
}
COMMAND:freeze(playerid, params[]){
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"Используйте: /freeze [id]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
	if(Player[playerid][pAdminPlayer] >= LEVEL_FREEZ){
		if(IsPlayerConnected(params[0])){
			new msg[256];
		    if(GetPVarInt(params[0],"FreezeEx")){
				DeletePVar(params[0],"FreezeEx");
				TogglePlayerControllable(params[0], 1);
				format(msg, sizeof(msg), ""SERVER_MSG"%s разморожен администратором %s",Player[params[0]][PlayerName] ,Player[playerid][PlayerName]);
				format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"%s defrosted by administrator %s",Player[params[0]][PlayerName] ,Player[playerid][PlayerName]);
				t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
		    }else{
				SetPVarInt(params[0],"FreezeEx",1);
				TogglePlayerControllable(params[0], 0);
				format(msg, sizeof(msg), ""SERVER_MSG"%s заморожен администратором %s",Player[params[0]][PlayerName] ,Player[playerid][PlayerName]);
				format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"%s frosted by administrator %s",Player[params[0]][PlayerName] ,Player[playerid][PlayerName]);
				t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	}	}   }
	else
		SendClientMessage(playerid, COLOR_GRAD1, ""SERVER_MSG"Извините, вы не уполномочены выполнять данное действие.");
	return true;
}
COMMAND:setdt(playerid, params[]){
	if(sscanf(params,"dd",params[0],params[1]))return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"USE: /setdt [id] [dt]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
	if(Player[params[0]][pJail] != false) return 0;
	if (Player[playerid][pAdminPlayer] >= LEVEL_TP){
		if(IsPlayerConnected(params[0])){
			if(params[0] != INVALID_PLAYER_ID){
				new msg[256];
				if(GetPlayerState(params[0]) == PLAYER_STATE_DRIVER) {t_SetVehicleVirtualWorld(params[0],GetPlayerVehicleID(params[0]), params[1]);}
				t_SetPlayerVirtualWorld(params[0], params[1]);
				format(msg, sizeof(msg), ""SERVER_MSG"Ты поставил виртуальный мир %s на %d.", Player[params[0]][PlayerName], params[1]);
				SendClientMessage(playerid, COLOR_GRAD1, msg);
				msg = "";
				format(msg, sizeof(msg), ""SERVER_MSG"%s поставил твой виртуальный мир на %d.", Player[playerid][PlayerName], params[1]);
				SendClientMessage(params[0], COLOR_GRAD1, msg);
	}	}	}
	else
		SendClientMessage(playerid, COLOR_GRAD1, ""SERVER_MSG"Извините, вы не уполномочены выполнять данное действие.");
	return true;
}
COMMAND:lang(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < 5) return 0;
	if(sscanf(params,"d",params[0]))return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"USE: /lang [id]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1, ""SERVER_MSG"Игрока нет на сервере!");
	if(!LanglePlayer{params[0]}) LanglePlayer{params[0]} = true;
	else LanglePlayer{params[0]} = false;
	new msg[256];
	if(LanglePlayer{params[0]})
		format(msg, sizeof(msg), ""SERVER_MSG"Ты изменил язык %s на английский.", Player[params[0]][PlayerName]);
	else
		format(msg, sizeof(msg), ""SERVER_MSG"Ты изменил язык %s на русский.", Player[params[0]][PlayerName]);
	SendClientMessage(playerid, -1, msg);
	return true;
}
COMMAND:givecash(playerid,params[]){
	if (Player[playerid][pTimeOnlineD] <1 && Player[playerid][pTimeOnlineH] < 1 && Player[playerid][pTimeOnline] < 20)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Извините, вам рано использовать данную функцию! Необходимое время - 20 мин.");
	if(sscanf(params,"dd",params[0],params[1]))
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/givecash id сумма");
	if(params[0] == playerid) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Сам себе деньги передать решил? О_о");
	if(!IsPlayerConnected(params[0]) || !Player[params[0]][logged])
		return SendClientMessage(playerid,-1,""SERVER_MSG"Человека с указанным ID нет на сервере либо он не авторизован!");
	if(!(params[1] > 0 && GetPlayerCash(playerid) >= params[1]))
		return SendClientMessage(playerid, -1,""SERVER_MSG"Неверная сумма");
	DaiEmyDeneg(playerid, -params[1]);
	DaiEmyDeneg(params[0], params[1]);
	printf("%s получил деньги от %s(%d)",Player[params[0]][PlayerName],Player[playerid][PlayerName],params[1]);
	new msg[256];
	if(!LanglePlayer{playerid})
		format(msg, sizeof(msg), ""SERVER_MSG"Вы отправили %s[ID: %d] $%d.", Player[params[0]][PlayerName],params[0], params[1]);
	else
		format(msg, sizeof(msg), ""SERVER_MSG"You sent %s[ID: %d] $%d.", Player[params[0]][PlayerName],params[0], params[1]);
	SendClientMessage(playerid, -1, msg);
	msg = "";
	if(!LanglePlayer{params[0]})
		format(msg, sizeof(msg), ""SERVER_MSG"Вы получили $%d от %s[ID: %d].", params[1], Player[playerid][PlayerName], playerid);
	else
		format(msg, sizeof(msg), ""SERVER_MSG"You received $%d by %s[ID: %d].", params[1], Player[playerid][PlayerName], playerid);
	SendClientMessage(params[0], -1, msg);
	return true;
}
COMMAND:pm(playerid,params[]){
	if(sscanf(params,"ds[256]",params[0],params[1]))
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/pm id текст"),true;
	if(!IsPlayerConnected(params[0]))
		return SendClientMessage(playerid,-1,""SERVER_MSG"Данного игрока нет на сервере!"),true;
  	if(params[0] == playerid)
	  	return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Сам себе написать решил? О_о"),true;
	if(InBlackList(playerid,params[0]) || InBlackList(params[0],playerid) || (Player[params[0]][pPmStatus] && !IsFrende(params[0],playerid)))
		return SendClientMessage(playerid,-1,""SERVER_MSG"Ошибка доступа."),true;
	if (Player[playerid][pTimeOnlineD] <1 && Player[playerid][pTimeOnlineH] < 1 && Player[playerid][pTimeOnline] < 10)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Извините, вам рано использовать данную функцию! Необходимое время - 10 минут.");	
	new msg[256];
	if(strlen(params[1]) > 5)
		if(GetMiniBook(params[1]) >= strlen(params[1])/2)
			UpperToLower(params[1]);
	format(msg,sizeof(msg),"{00f5da}для{%s} %s(%d){FFFFFF}: %s",chatcolor[Player[params[0]][pColorPlayer]],Player[params[0]][PlayerName],params[0],params[1]);
	SendClientMessage(playerid,PM_OUTGOING_COLOR,msg);
	msg = "";
	if(GetCifri(params[1]) < 9 && !CheckString(params[1]))
	{
		format(msg,sizeof(msg),"{00f5da}от{%s} %s(%d){FFFFFF}: %s",chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],playerid,params[1]);
		SendClientMessage(params[0],PM_INCOMING_COLOR,msg);
		PlayerPlaySound(params[0],1085,0.0,0.0,0.0);
	}
	return true;
}
COMMAND:asay(playerid, params[]){
	if (Player[playerid][pAdminPlayer] < LEVEL_CHAT) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Извините, вы не уполномочены выполнять данное действие.");
	if(Player[playerid][pMuted]) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"У тебя бан чата!");
	if(sscanf(params,"s[256]", params[0])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/asay [текст]");
    if(strlen(params[0]) > 5)
		if(GetMiniBook(params[0]) >= strlen(params[0])/2) UpperToLower(params[0]);
	if(IsIP(params[0]) || CheckString(params[0])) return 0;
	new msg[312];
	format(msg, sizeof(msg), "{00f5da}Администратор %s:{FFFFFF} %s",Player[playerid][PlayerName], params[0]);	
	format(msgcheatEn, sizeof(msgcheatEn), "{00f5da}Administrator %s:{FFFFFF} %s",Player[playerid][PlayerName], params[0]);
	t_SendClientMessageToAll(-1,-1," "," ");
	t_SendClientMessageToAll(-1,-1,msg,msgcheatEn);
	t_SendClientMessageToAll(-1,-1," "," ");
	return true;
}
COMMAND:del(playerid){
	if(!Player[playerid][pAdminPlayer]) return 0;
	new msg[256];
	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Доступно только в авто");
	new carid = GetPlayerVehicleID(playerid),
	owner = GetCarOwner(carid),
	slot = GetCarIdPoId(carid,owner);
	if(!IsValidVehicle(carid)) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Данное авто уже удалено");
	if(carid == GetPlayerVehicleID(owner)) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Игрок находится в этом авто.");
	format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s удалил ваше авто %s.",Player[playerid][PlayerName],VehicleNames[GetVehicleModel(carid)-400]);
	SendClientMessage(owner, COLOR_LIGHTBLUE, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"Вы успешно удалили авто %s. (Владелец авто %s)",VehicleNames[GetVehicleModel(carid)-400],Player[owner][PlayerName]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
	SetCarInGarage(owner,slot);
	return true;
}
COMMAND:giveallmoney(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_MONEY) return 0;
	if(sscanf(params,"d", params[0]))
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/giveallmoney [сумма]");
	if(0 > params[0] || 500000 < params[0])
		return SendClientMessage(playerid,-1,""SERVER_MSG"Неверное значение!");
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i) || !Player[i][logged]) continue;
		DaiEmyDeneg(i,params[0]);
	}
	new msg[112];
	format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s раздал всем по %d денег.",Player[playerid][PlayerName],params[0]);
	format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"The %s administrator distributed to all on %d of money.",Player[playerid][PlayerName],params[0]);
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	WriteRusLog("money.cfg", msg);
	return true;
}
COMMAND:makeadmin(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < 6) return 0;
	if(sscanf(params,"dd", params[0], params[1])) return SendClientMessage(playerid, COLOR_WHITE, "/makeadmin [ид] [уровень]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid,-1,""SERVER_MSG"Этого игрока нет на сервере!");
	if(params[1] > 11 || params[1] < 0) return SendClientMessage(playerid,-1,""SERVER_MSG"Нельзя больше 10 и меньше 0!");
	Player[params[0]][pAdminPlayer] = params[1];
	SaveAdmin(params[0]);
	new msg[112];
	format(msg, sizeof(msg), ""SERVER_MSG"Ты выдал админку %d уровня %s.",params[1],Player[params[0]][PlayerName]);
	SendClientMessage(playerid,-1,msg);
	format(msg, sizeof(msg), "%s дал %s админку %d уровня.",Player[playerid][PlayerName],Player[params[0]][PlayerName], params[1]);
	WriteRusLog("MakeAdmins.cfg", msg);
	return true;
}
COMMAND:setlevel(playerid,params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_SCORE) return 0;
	if(sscanf(params,"dd",params[0],params[1])) return SendClientMessage(playerid, COLOR_WHITE, "/setlevel id значение");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"Этот игрок оффлайн!");
	Player[params[0]][pLevel] = params[1];
	Player[params[0]][pScore] = 0;
	UpdateScoreSystem(params[0]);
	new msg[256];
	format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s установил ваш LEVEL %d",Player[playerid][PlayerName],params[1]);
	SendClientMessage(params[0], 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), ""SERVER_MSG"Вы установили %s %d LEVEL",Player[params[0]][PlayerName],params[1]);
	SendClientMessage(playerid, 0xFF0000FF, msg);
	msg = "";
	format(msg, sizeof(msg), "%s прописал %d LEVEL %s.",Player[playerid][PlayerName],params[1],Player[params[0]][PlayerName]);
	WriteRusLog("score.cfg", msg);
	return true;
}
COMMAND:removhouse(playerid, params[]){
	if(!houseson ||  Player[playerid][pJail] || Player[playerid][pAdminPlayer] < LEVEL_HOUSE) return 0;
	if(sscanf(params,"d",params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/removhouse [ID дома]");
	new query[128];
	new housid = params[0];
	if(housid < 0) return SendClientMessage(playerid, -1, ""SERVER_MSG"Данный дом ещё не создан или уже удален!");
	new msg[112];
	format(query, sizeof(query),"DELETE FROM  "HOUSE_TABLE" WHERE `hid` = %d;",params[0]);
	mysql_function_query(MYSQL, query, true, "RemoveHouse", "d",housid);
	format(msg, sizeof(msg), "%s удалил дом ID%d.",Player[playerid][PlayerName],housid);
	WriteRusLog("House.cfg", msg);
	return true;
}
COMMAND:sellhouse(playerid, params[]){
	if(!houseson ||  Player[playerid][pJail] || Player[playerid][pAdminPlayer] < LEVEL_HOUSE) return 0;
	if(sscanf(params,"d",params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/salehouse [ID дома]");
	new query[128];
	new housid = params[0];
	if(housid < 0) return SendClientMessage(playerid, -1, ""SERVER_MSG"Данный дом ещё не создан или уже удален!");
	if(!HouseInfo[housid][howneruid]) return SendClientMessage(playerid, -1, ""SERVER_MSG"Данный дом уже стоит на продаже!");
	format(query, sizeof(query),"UPDATE  "HOUSE_TABLE" SET `howner` = 'NULL',howneruid` = '0',`hLock` = '0',`naprodaje` = '0' WHERE `hid` = %d;",housid);
	mysql_function_query(MYSQL, query, false, "", "");
	SaledHouse(-1,housid);
	new msg[112];
	format(msg, sizeof(msg), "%s продал дом ID%d.",Player[playerid][PlayerName],housid);
	WriteRusLog("House.cfg", msg);
	return true;
}	
COMMAND:setprice(playerid, params[]){
	if(!houseson ||  Player[playerid][pJail] || Player[playerid][pAdminPlayer] < LEVEL_HOUSE) return 0;
	if(sscanf(params,"dd",params[0],params[1])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/setprice [ID дома] [цена]");
	new query[128];
	new housid = params[0];
	if(params[1] < 100000)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Слишком низкая цена!");
	else if(params[1] > 10000000)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Слишком высокая цена!");
	if(housid < 0)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Данный дом ещё не создан или уже удален!");
	format(query, sizeof(query),"UPDATE  "HOUSE_TABLE" SET `hprice` = '%d' WHERE `hid` = %d",params[1],housid);
	mysql_function_query(MYSQL, query, false, "", "");
	HouseInfo[housid][hprice] = params[1];
	UpdateHouseInfo(housid);
	new msg[112];
	format(msg, sizeof(msg), "%s изменил цену дома ID%d на %d.",Player[playerid][PlayerName],housid,params[1]);
	WriteRusLog("House.cfg", msg);
	return true;
}
COMMAND:ban(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_BANN) return 0;
	if(sscanf(params,"dds[30]",params[0],params[1],params[2])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/ban [ID] [Время (в днях) [если -1,навсегда]] [причина]");
	if(!params[1])
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Время бана не может быть равен 0!");
	BanIPex(playerid,params[0],params[2],params[1]);
	return true;
}
COMMAND:kick(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_KICK) return 0;
	if(sscanf(params,"ds[30]",params[0],params[1])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/kick [ID] [причина]");
	KickPlayer(playerid,params[0],params[1]);
	return true;
}
COMMAND:warn(playerid, params[]){
	if(Player[playerid][pAdminPlayer] < LEVEL_WARN) return 0;
	if(sscanf(params,"ds[30]",params[0],params[1])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/warn [ID] [причина]");
	GiveWarn(playerid,params[0],params[1]);
	return true;
}
COMMAND:loginadmin(playerid){
	if(Player[playerid][pAdminPlayer] < 5) return 0;
	else if(Player[playerid][pAdminPlayer] > 5) ShowPlayerDialog(playerid,1000,DIALOG_STYLE_LIST,"RCON CONSOLE:","Разбан подсети\nПерезагрузка банов\nРестарт\nБан IP\nСказать всем\nИзменение гравитрации\nИзменить МапНейм\nПерезагрузить лог\nВыключение\nИзменить название сервера","Select","Cancel");
	else ShowPlayerDialog(playerid,1000,DIALOG_STYLE_LIST,"RCON CONSOLE:","Разбан подсети\nПерезагрузка банов\nРестарт\nБан IP\nСказать всем\nИзменение гравитрации","Выбрать","Отмена");
	return true;
}
#if !defined OSNOVNOI_SERV
COMMAND:kd(playerid){
	new Float:pos[4];
	SetPlayerVelocity(playerid,0.001,0.001,0.1);
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	SetPlayerPos(playerid,pos[0],pos[1],pos[2]+2000.0);
	return true;
}
COMMAND:kk(playerid, params[]){
	if(sscanf(params,"s[60]",params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/kk [name]");
	new Float:pos[4];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
	printf("%f,%f,%f,%f //%s",pos[0],pos[1],pos[2], pos[3],params[0]);
	return true;
}
#endif
COMMAND:ooc(playerid, params[]){
	if(Player[playerid][pJail] || Player[playerid][pAdminPlayer] < LEVEL_CHAT) return 0;
	if(sscanf(params,"d",params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/ooc [время] (в минутах, до 20 минут)");
	if(!(2 <params[0] < 20)) return SendClientMessage(playerid, -1, ""SERVER_MSG"/ooc [время] (в минутах, от 2 до 20 минут)");
	new msg[112];
	if(ChatOn){
		ChatOn = false;
		timechaton = gettime()+(params[0]*60);
		format(msg, sizeof(msg), ""SERVER_MSG"Чат выключен администратором %s на %s.", Player[playerid][PlayerName],timecs(timechaton));
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"The chat is switched off by the %s on %s.", Player[playerid][PlayerName],timecsEn(timechaton));
	}else{
		ChatOn = true;
		format(msg, sizeof(msg), ""SERVER_MSG"Чат включен администратором %s.", Player[playerid][PlayerName]);
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"The chat is included by %s.", Player[playerid][PlayerName]);
	}
	t_SendClientMessageToAll(-1,-1,msg,msgcheatEn);
	return true;
}
COMMAND:goto(playerid, params[]){
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/goto [id]");
	if(params[0] == playerid)
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Неверный ID!");
	if(!Player[params[0]][logged] || !IsPlayerConnected(params[0]))
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Телепортироваться к нему невозможно!");
	if(Player[playerid][pAdminPlayer] < LEVEL_TP){
		if(Player[params[0]][pJail])
			return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Данный игрок в тюрьме!");
		if(SumID[params[0]] != playerid || !WaitSum[params[0]])
			return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Игрок не предлагал вам телепортироваться!");
		WaitSum[SumID[playerid]] = false;
		WaitSum[playerid] = false;
		SumID[SumID[playerid]] = INVALID_PLAYER_ID;
		SumID[playerid] = INVALID_PLAYER_ID;
		ShowPlayerDialog(params[0],-1,DIALOG_STYLE_MSGBOX,"{FFFFFF}"DUEL_TEXT_5"","{FFFFFF}"DUEL_TEXT_6"","Стартуем","");
		TeleportPlayerToPlayer(playerid,params[0]);
		return true;
	}
	TeleportPlayerToPlayer(playerid,params[0]);
	return true;
}
COMMAND:sum(playerid, params[]){
	if(Player[playerid][pJail]) return 0;
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"/sum [id]");
	if(params[0] == playerid)
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Неверный ID!");
	if(!Player[params[0]][logged] || !IsPlayerConnected(params[0]))
		return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Телепортировать этого игрока невозможно!");
	if(Player[playerid][pAdminPlayer] < LEVEL_TP){
		if(SumID[params[0]] != INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Игроку уже кто-то предложил телепортироваться!");
		if(SumID[playerid] != INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Ты уже кому-то предложил телепортироваться!");
		if(gettime()-SumTIME[playerid] < 60)
			return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Предлогать телепорт можно не чаще чем 1 раз в минуту!");
		ShowPlayerDialog(playerid,DIALOG_SUMMON,DIALOG_STYLE_MSGBOX,"{FFFFFF}Телепортация игрока.","{FFFFFF}Ожидайте пока игрок примет приглашение","Отменить","");
		SumID[params[0]] = playerid;
		SumID[playerid] = params[0];
		SumTIME[playerid] = gettime();
		WaitSum[playerid] = true;
		new msg[156];
		if(!LanglePlayer{params[0]})
			format(msg, sizeof(msg), ""SERVER_MSG"{%s}%s{FFFFFF} предложил тебе телепортироваться к нему. Принять: [/goto %d].", chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],playerid);
		else
			format(msg, sizeof(msg), ""SERVER_MSG"{%s}%s{FFFFFF} suggested you to teleport to it. Accept [/goto %d].", chatcolor[Player[playerid][pColorPlayer]],Player[playerid][PlayerName],playerid);
		SendClientMessage(params[0], -1,msg);
		return true;
	}
	if(!GetPVarInt(params[0],"nick")){
		if(!LanglePlayer{params[0]}) return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"Этот игрок находится в режиме 'Мувик'!");
		else return SendClientMessage(playerid, COLOR_WHITE, ""SERVER_MSG"This player is in a mode 'Moove'!");}
	TeleportPlayerToPlayer(params[0],playerid);
	if(!LanglePlayer{params[0]}) SendClientMessage(params[0], COLOR_WHITE, ""SERVER_MSG"Ты был телепортирован администратором.");
	else SendClientMessage(params[0], COLOR_WHITE, ""SERVER_MSG"You were attracted by administrator.");
	return true;
}		
COMMAND:tod(playerid,params[]){
	if (Player[playerid][pAdminPlayer] >= LEVEL_WORLD)
	{
		if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"/tod [time]");
		if(0 > params[0] || 24 < params[0]){
			if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Неверное значение!");
			else return SendClientMessage(playerid,-1,""SERVER_MSG"Incorrect value!");
		}
		if(params[0] == 0){
			gettime(hour, minute);
			for(new f = 0, all = MAX_PLAYERS; f < all; f++){
				if(!IsPlayerConnected(f) || !Player[f][logged] || GetPVarInt(f,"Timeon") == 2)continue;
				SetPlayerTime(f,hour,minute);
				SetPVarInt(f,"Timeon",1);
				if(!LanglePlayer{f}) SendClientMessage(f,-1,""SERVER_MSG"Администратор установил всем серверное время!");
				else SendClientMessage(f,-1,""SERVER_MSG"Administrator set all server time!");
			}
			return true;
		}
		new msg[112];
		format(msg, sizeof(msg), ""SERVER_MSG"Текущее время: %d часов. Установил %s.", params[0],Player[playerid][PlayerName]);
		format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Current time: %d hours. I set %s.", params[0],Player[playerid][PlayerName]);
		t_SendClientMessageToAll(-1,0xFF0000FF, msg,msgcheatEn);
		for(new f = 0, all = MAX_PLAYERS; f < all; f++){
			if(!Player[f][logged] || !IsPlayerConnected(f) || GetPVarInt(f,"Timeon") == 2)continue;
			SetPlayerTime(f,params[0],0);
			SetPVarInt(f,"Timeon",0);
		}
	}
	else SendClientMessage(playerid, 0xFF0000FF, ""SERVER_MSG"Недостаточно прав для использования команды.");
	return true;
}
COMMAND:wea(playerid,params[]){
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"/wea [ID_weather]");
	if(0 > params[0] || 17 < params[0] || params[0] == 25){
		if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Неверное значение!");
		else return SendClientMessage(playerid,-1,""SERVER_MSG"Incorrect value!");
	}
	if (Player[playerid][pAdminPlayer] < LEVEL_WORLD)  return false;
	SetWeather(params[0]);
	new msg[112];
	format(msg, sizeof(msg), ""SERVER_MSG"Администратор %s установил новую погоду.",Player[playerid][PlayerName]);
	format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Administrator %s set new weather.",Player[playerid][PlayerName]);
	t_SendClientMessageToAll(-1,0xFF0000FF, msg, msgcheatEn);
	return true;
}
COMMAND:dt(playerid,params[]){
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, -1, ""SERVER_MSG"/dt [id]");
	if (params[0] > 99 || params[0] < 0)
		if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Миры доступны от 0 до 99!");else return SendClientMessage(playerid,-1,""SERVER_MSG"Patterns are available from 0 to 99!");
	if(GetPlayerVirtualWorld(playerid) == params[0])
		if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Вы уже находитесь в данном вирт.мире!");else return SendClientMessage(playerid,-1,""SERVER_MSG"You already are in this virtual world!");
	if(params[0] == 0){
		if(ReturnVidVehicle(GetVehicleModel(GetPlayerVehicleID(playerid))) == AIR_TS){
			if(!LanglePlayer{playerid})
				SendClientMessage(playerid,-1,""SERVER_MSG"Данное ТС нельзя вызывать в общий вирт. мир!");
			else
				SendClientMessage(playerid,-1,""SERVER_MSG"This HARDWARE can't be called in the general virtual world!");
			return true;
	}	}
	t_SetPlayerVirtualWorld(playerid, params[0]);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		t_SetVehicleVirtualWorld(playerid,GetPlayerVehicleID(playerid), params[0]);
	SetCarsInVorld(playerid,params[0]);
	new playersindt;
	for(new i = 0, all = MAX_PLAYERS; i < all; i++) {
		if(!IsPlayerConnected(i) || !Player[i][logged] || i == playerid || GetPlayerVirtualWorld(i) != params[0])continue;
		playersindt++;
	}
	new msg[112];
	if(playersindt){
		if(!LanglePlayer{playerid}) format(msg, sizeof(msg), ""SERVER_MSG"Ваш виртуальный мир %d, в нем %d человек.",params[0],playersindt);
		else format(msg, sizeof(msg), ""SERVER_MSG"Your virtual world of %d, in it %d of people.",params[0],playersindt);
		SendClientMessage(playerid,-1, msg);
	}else{
		if(!LanglePlayer{playerid}) format(msg, sizeof(msg), ""SERVER_MSG"Ваш виртуальный мир %d, в нем вы одни.",params[0]);
		else format(msg, sizeof(msg), ""SERVER_MSG"Your virtual world of %d, in it you one.",params[0]);
		SendClientMessage(playerid,-1, msg);
	}
	return true;
}
COMMAND:ct(playerid,params[]){
	if(sscanf(params,"d", params[0])) return SendClientMessage(playerid, 0xFF0000AA, ""SERVER_MSG"/ct [id]");
	if (params[0] > 999 || params[0] < 0)
		if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Чат комнаты доступны от 0 до 999!");
		else return SendClientMessage(playerid,-1,""SERVER_MSG"Chat of the room are available from 0 to 999!");
	if(Player[playerid][pCt] == params[0])
		if(!LanglePlayer{playerid}) return SendClientMessage(playerid,-1,""SERVER_MSG"Вы уже находитесь в данной чат комнате!");
		else return SendClientMessage(playerid,-1,""SERVER_MSG"You already are in the room this a chat!");
	Player[playerid][pCt] = params[0];
	new playersindt;
	for(new i = 0, all = MAX_PLAYERS; i < all; i++) {
		if(!IsPlayerConnected(i))continue;
 		if(!Player[i][logged])continue;
		if(i != playerid){
			if(Player[i][pCt] == params[0]) playersindt++;
	}	}
	new msg[112];
	if(playersindt){
		if(!LanglePlayer{playerid}) format(msg, sizeof(msg), ""SERVER_MSG"Ваша чат комната %d, в ней %d человек.",params[0],playersindt);
		else format(msg, sizeof(msg), ""SERVER_MSG"Yours a chat %d room, in it %d of people.",params[0],playersindt);
		SendClientMessage(playerid,-1, msg);
	}else{
		if(!LanglePlayer{playerid}) format(msg, sizeof(msg), ""SERVER_MSG"Ваша чат комната %d, в ней вы одни.",params[0]);
		else format(msg, sizeof(msg), ""SERVER_MSG"Yours a chat %d room, in it you one.",params[0]);
		SendClientMessage(playerid,-1, msg);
	}
	return true;
}
COMMAND:mydt(playerid){
	new playersindt,
	playervirt = GetPlayerVirtualWorld(playerid);
	for(new i = 0, all = MAX_PLAYERS; i < all; i++) {
		if(!IsPlayerConnected(i))continue;
 		if(!Player[i][logged])continue;
		if(i != playerid){
			if(GetPlayerVirtualWorld(i) == playervirt) playersindt++;
	}	}
	new msg[112];
	if(playersindt){
		if(!LanglePlayer{playerid})
			format(msg, sizeof(msg), ""SERVER_MSG"Ваш виртуальный мир %d, в нем %d человек.",playervirt,playersindt);
		else
			format(msg, sizeof(msg), ""SERVER_MSG"Your virtual world of %d, in it %d of people.",playervirt,playersindt);
		SendClientMessage(playerid,-1, msg);
	}else{
		if(!LanglePlayer{playerid})
			format(msg, sizeof(msg), ""SERVER_MSG"Ваш виртуальный мир %d, в нем вы одни.",playervirt);
		else
			format(msg, sizeof(msg), ""SERVER_MSG"Your virtual world of %d, in it you one.",playervirt);
		SendClientMessage(playerid,-1, msg);
	}
	return true;
}
t_SetPlayerSkin(playerid, modelid){
	new veh = GetPlayerVehicleID(playerid);
	if(veh){
		new seat = GetPlayerVehicleSeat(playerid),
			Float:Pos[3];
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid)+3000);
        GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
        t_SetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]+1);
		SetPlayerSkin(playerid, modelid);
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid)-3000);
        SetTimerEx("PutPlayer", 150, false, "idd", playerid, veh, seat);
	}
	else SetPlayerSkin(playerid, modelid);
}
public PutPlayer(playerid, veh, seat)
    t_PutPlayerInVehicle(playerid, veh, seat);
#define SetPlayerSkin t_SetPlayerSkin

public OnPlayerPickUpDynamicPickup(playerid, pickupid){
		new gittime = gettime();
		if(GetPVarInt(playerid,"OldPickUP") == pickupid && (gittime-GetPVarInt(playerid,"OldPickTime") < 1))
		    return true;
		SetPVarInt(playerid,"OldPickUP",pickupid);
		SetPVarInt(playerid,"OldPickTime",gittime);
		if(pickupid == oldpickup[playerid]) return true;
		oldpickup[playerid] = pickupid;
		new
	Float:z,
	Float:poss[2],
		string[256]
		;
		GetPlayerPos(playerid, poss[0], poss[1], z);
		SetPVarFloat(playerid, "PickupX", poss[0]);
		SetPVarFloat(playerid, "PickupY", poss[1]);
		if(gittime-OldTP[playerid] < 2){
			oldpickup[playerid] = pickupid;
			SetPVarFloat(playerid, "PickupX", poss[0]);
			SetPVarFloat(playerid, "PickupY", poss[1]);
			SetPVarInt(playerid,"OldPickUP",pickupid);
			SetPVarInt(playerid,"OldPickTime",gittime);
			return true;
		}
		new i = pHID[pickupid];
		SetPVarInt(playerid, "HouseID",i);
		if(pickupid == HouseInfo[i][hpickup])
		{
			SetPVarInt(playerid, "HouseID",i);
			if(!HouseInfo[i][howneruid])
			{
				new houses = GetOwnedHouses(playerid);
				if(!LanglePlayer{playerid}){
					if(Player[playerid][pLevel] < 5)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 5 уровня для покупки дома!");
					else if(Player[playerid][pLevel] < 10 && houses == 1)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 10 уровня для покупки ещё одного дома!");
					else if(Player[playerid][pLevel] < 15 && houses == 2)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Достигните 15 уровня для покупки ещё одного дома!");//ID 00016
					format(string, sizeof(string), "Дом продается.\nВы можете его купить.\nЦена дома: %d.", HouseInfo[i][hprice]);
					return ShowPlayerDialog(playerid, hdialogid, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", string, "Купить", "Отмена");
				}else{
					if(Player[playerid][pLevel] < 5)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Reach 5 level to buy a house!");
					else if(Player[playerid][pLevel] < 10 && houses == 1)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Reach 10 level to buy anhdialogidother house!");
					else if(Player[playerid][pLevel] < 15 && houses == 2)
						return SendClientMessage(playerid,-1, ""SERVER_MSG"Reach 15 level to buy another house!");//ID 00016
					format(string, sizeof(string), "The house is on sale.\nYou can buy it.\nHouse Price: %d.", HouseInfo[i][hprice]);
					return ShowPlayerDialog(playerid, hdialogid, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House_EN"", string, "Buy", "Cancel");
				}
			}
			else if(!HouseInfo[i][naprodaje] || HouseInfo[i][howneruid] == Player[playerid][pSQLID])
			{
				if(!LanglePlayer{playerid}){
					format(string, sizeof(string), "Владелец дома: %s.", HouseInfo [i][howner]);
					return ShowPlayerDialog(playerid, hdialogid, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House"", string, "Войти", "Отмена" );
				}else{
					format(string, sizeof(string), "House owner: %s.", HouseInfo [i][howner]);
					return ShowPlayerDialog(playerid, hdialogid, DIALOG_STYLE_MSGBOX, ""MENU_PRFX_House_EN"", string, "Join", "Cancel" );
				}
			}
			else{
				if(!LanglePlayer{playerid})
					return ShowPlayerDialog(playerid, hdialogid+7 , DIALOG_STYLE_LIST, "Меню дома","Войти в дом\nКупить дом", "Ок", "Отмена");
				else
					return ShowPlayerDialog(playerid, hdialogid+7 , DIALOG_STYLE_LIST, "House menu","Enter into house \nBuy the house", "Ok", "Cancel");
		}	}
		else if(pickupid == HouseInfo[i][hpickup2])
		{
			if(HouseInfo[i][howneruid] == Player[playerid][pSQLID])
			{
				SetPVarInt(playerid, "HouseID",i);
				return ShowDialogHouse(playerid);
			}
			else
			{
				SetPlayerInterior(playerid, 0);
				t_SetPlayerVirtualWorld(playerid, 0);
				SetPlayerFacingAngle(playerid, HouseInfo[i][henterza]);
				SetCameraBehindPlayer(playerid);
				return t_SetPlayerPos(playerid,HouseInfo[i][henterx], HouseInfo[i][hentery], HouseInfo[i][henterz]);
			}
		}
		//else continue;
	//}
		return true;
}
public UpdateTime(){
	new timestr[32];
	gettime(hour, minute);
	format(timestr,16,"%02d:%02d",hour,minute);
	for(new f = 0, all = sizeof(ColorsScore); f < all; f++)
		TextDrawSetString(txtTimeDisp[f],timestr);
	if(!(minute % 5)){
		for(new f = 0, all = MAX_PLAYERS; f < all; f++)
		{
			if(!IsPlayerConnected(f) || !Player[f][logged] || GetPVarInt(f,"Timeon") != 1) continue;
			SetPlayerTime(f,hour,minute);
	}	}
	return true;
}
public UnLoadHouses(){
	houseson = false;
	for(new i = TotalHouses-1; i != -1; --i)
	{
		if(!HouseInfo[i][howner]) continue;
		DestroyDynamicPickup(HouseInfo[i][hpickup]);
		DestroyDynamicPickup(HouseInfo[i][hpickup2]);
		DestroyDynamic3DTextLabel(HouseInfo[i][hlabel]);
	}
	return true;
}
public SaveAccounts(){
	timesaver++;
	if(timesaver >= 10){
		for(new f = 0, all = MAX_PLAYERS; f < all; f++){
			if(!IsPlayerConnected(f) || !Player[f][logged])continue;
			SaveAccount(f);
		}
		timesaver = 0;
	}
	new getdat=getdate();
	if(!(getdat%3) && rDateReloadRecords != getdat){
		new theard[64];
		format(theard, sizeof(theard), "DELETE FROM `BankLog` WHERE `lDate` < %d", gettime()-86400);
		mysql_function_query(MYSQL, theard, false, "", "");
		ReloadRecords();
	}
	new ttime = gettime();
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f) || !Player[f][logged]) continue;
		SaveWins(f);
		SaveScore(f);
		SaveKoeff(f);
		if(!AfkPlayer[f]){
			Player[f][pTimeOnline]++;
			if(Player[f][pTimeOnline] >= 2400){
			    Player[f][pTimeOnlineH]+=40;
			    Player[f][pTimeOnline] -= 2200;
			}
			if(Player[f][pTimeOnline] >= 1200){
			    Player[f][pTimeOnlineH]+=20;
			    Player[f][pTimeOnline] -= 1200;
			}
			if(Player[f][pTimeOnline] >= 60){
			    Player[f][pTimeOnlineH]++;
			    Player[f][pTimeOnline] -= 60;
			}
			if(Player[f][pTimeOnlineH] >= 48){
			    Player[f][pTimeOnlineD]+=2;
			    Player[f][pTimeOnlineH]-=48;
			}
			if(Player[f][pTimeOnlineH] >= 24){
			    Player[f][pTimeOnlineD]++;
			    Player[f][pTimeOnlineH]-=24;
		}	}
		if(ttime > Player[f][pStopVip] && Player[f][pVIP] && Player[f][pStopVip] != 999999999){
  			Player[f][pVIP] = false;
			Player[f][pStopVip] = -1;
			Player[f][pColorText] = 0;
			SaleVIPCars(f);
			SendClientMessage(f,-1,""SERVER_MSG"У вас кончилась VIP.");
		}
		SetPVarInt(f,"WEAPONCHEAT",0);
		SetPVarInt(f,"Fly",0);
		SetPVarInt(f,"cheat",0);
		SetPVarInt(f,"fuelspeed",0);
		SetPVarInt(f,"vernut",0);
		new msg[112];
		if(Player[f][pMuted] != false){
			Player[f][pMuteTime]--;
			if(Player[f][pMuteTime] >= 1){
				format(msg, sizeof(msg), ""SERVER_MSG"Осталось молчать %d минут.",Player[f][pMuteTime]);
				SendClientMessage(f,-1,msg);
			}
			if(Player[f][pMuteTime] <= 0){
				Player[f][pMuted] = false;
				SendClientMessage(f,-1,""SERVER_MSG"Вам автоматически включен чат.");
		}	}
		if(Player[f][pJail]){
      		if(AfkTime[f] > 120){
				if(!LanglePlayer{f}){
					SendClientMessage(f,-1,""SERVER_MSG"Вы кикнуты за AFK в тюрьме!");
					SendClientMessage(f, -1, ""SERVER_MSG""TEXT_KICK" [#23]");
				}else{
					SendClientMessage(f,-1,""SERVER_MSG"Your kicked for AFK in jail!");
					SendClientMessage(f,-1, ""SERVER_MSG""TEXT_KICK_EN" [#22]");
				}
				t_Kick(f);
			}
			Player[f][pJTime] = Player[f][pJTime]-1;
			if(Player[f][pJTime] <= 0) UnJails(f);
			else{
				format(msg, sizeof(msg), ""SERVER_MSG"Осталось сидеть в тюрьме %d минут.",Player[f][pJTime]);
				SendClientMessage(f,-1,msg);
		}	}
		if(GetPlayerState(f) == PLAYER_STATE_DRIVER){
			if(Player[f][pDoubleDrift] && !Player[f][pVIP]){
				Player[f][pDoubleDriftT] = Player[f][pDoubleDriftT]-1;
				if(Player[f][pDoubleDriftT] < 1){
					Player[f][pDoubleDrift] = false;
					SendClientMessage(f,-1,""SERVER_MSG"Время каста 'DoubleDrift' кончилось.");
			}	}
			if(Player[f][pNoCrash] && !Player[f][pVIP]){
				Player[f][pNoCrashTime] = Player[f][pNoCrashTime]-1;
				if(Player[f][pNoCrashTime] < 1){
					Player[f][pNoCrash] = false;
					SendClientMessage(f,-1,""SERVER_MSG"Время каста 'NoCrash' кончилось.");
	}	}	}	}
	return true;
}
public Jailed(){
	if(servername){
		SendRconCommand("hostname °• [RUS/ENG] • DriftEmpire • [0.3z] •°");
		SendRconCommand("weburl www.vk.com/driftemp");
		servername = false;
	}else{
		SendRconCommand("hostname °• [ENG/RUS] • DriftEmpire • [0.3z] •°");
		SendRconCommand("weburl www.DRIFT2.ru");
		servername = true;
	}
	for(new f = 0, all = MAX_PLAYERS; f < all; f++){
		if(!IsPlayerConnected(f) || !Player[f][logged]) continue;
		SetPVarInt(f,"count",0);
  		new ping = GetPlayerPing(f);
		if(ping > MAX_PING){
			SetPVarInt(f,"Pinger",GetPVarInt(f,"Pinger")+1);
			if(GetPVarInt(f,"Pinger") > 2){
				if(!LanglePlayer{f}){
					SendClientMessage(f,-1,""SERVER_MSG"Выключите программы скачивания, и проверьте компьютер на вирусы!");
					SendClientMessage(f,-1,""SERVER_MSG"Вы были кикнуты из-за слишком высокого пинга!");
					SendClientMessage(f, -1, ""SERVER_MSG""TEXT_KICK" [#33]");
				}else{
					SendClientMessage(f,-1,""SERVER_MSG"Switch off downloading programs, and check the computer on viruses!");
					SendClientMessage(f,-1,""SERVER_MSG"You were kicked because of too high Ping!");
					SendClientMessage(f, -1, ""SERVER_MSG""TEXT_KICK_EN" [#33]");
				}
				t_Kick(f);
				continue;
			}
		}
		else if(GetPVarInt(f,"Pinger") > 0)
			SetPVarInt(f,"Pinger",GetPVarInt(f,"Pinger")-1);
		if(Player[f][pJail])
		{
			if(GetPlayerInterior(f) != 6 || !IsPlayerInRangeOfPoint(f, 40, 264.20001220703,77.800003051758,1001))
			{
				SetPlayerInterior(f,6);
				t_SetPlayerVirtualWorld(f,789);
				t_SetPlayerPos(f,264.20001220703,77.800003051758,1001);
				SetPlayerCameraLookAt(f, 264.89999389648,77.199996948242,1001);
				SetPlayerCameraPos(f,262.5,79.599998474121,1003.4000244141);
				SendClientMessage(f,-1,""SERVER_MSG"Даже не пытайтесь убежать.");
				SetPVarInt(f,"vjail",GetPVarInt(f,"vjail")+1);
				if(GetPVarInt(f,"vjail") >= 3){
				    if(!LanglePlayer{f})
						{SendClientMessage(f, -1, ""SERVER_MSG""TEXT_KICK" [#25]"); return t_Kick(f);}
					else
						{SendClientMessage(f, -1, ""SERVER_MSG""TEXT_KICK_EN" [#25]"); return t_Kick(f);}
	}	}	}   }
	return true;
}
/*public Jails(playerid){
	if(GetPVarInt(playerid,"avtoriz") || PlayerSpectate[playerid]) return 0;
	if(!Player[playerid][pJail]){
		Player[playerid][pJail] = true;
		SetPlayerInterior(playerid,6);
		t_SetPlayerVirtualWorld(playerid,789);
		t_SetPlayerPos(playerid,264.20001220703,77.800003051758,1001);
		ClearAnimations(playerid);
		Player[playerid][pCheater] = Player[playerid][pCheater]+1;
		Player[playerid][pJailAdm] = LEVEL_JAIL;
		Player[playerid][pJTime] = 60;
		SetPlayerCameraLookAt(playerid, 264.89999389648,77.199996948242,1001);
		SetPlayerCameraPos(playerid,262.5,79.599998474121,1003.4000244141);
		Player[playerid][pPos][0] =264.20001220703;
		Player[playerid][pPos][1] =77.800003051758;
		Player[playerid][pPos][2] =1001;
		Player[playerid][pInt] = 6;
		Player[playerid][pVirt] = 789;
	}else{
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#26]");
		else
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#26]");
		t_Kick(playerid);
		return false;
	}
	return true;
}*/
public LoadAkk(playerid){
	if(!LanglePlayer{playerid})
		SendClientMessage(playerid, COLOR_WHITE,""SERVER_MSG"Добро пожаловать на "SERVER_NAME"!");
	else
		SendClientMessage(playerid, COLOR_WHITE,""SERVER_MSG"Welcome to "SERVER_NAME"!");	
	SetPVarInt(playerid,"avtoriz",1);
	SetTimerEx("avtoriz",5000,0,"d",playerid);
	TextDrawShowForPlayer(playerid,txtTimeDisp[Player[playerid][pColorScore]]);
	SetPVarInt(playerid,"Count",0);
	SetPVarInt(playerid,"Oos",0);
    SetPlayerScore(playerid,Player[playerid][pLevel]);
	SetPlayerInterior(playerid,Player[playerid][pInt]);
	t_SetPlayerVirtualWorld(playerid,Player[playerid][pVirt]);
	return true;
}
public UnJails(playerid){
    if(!IsPlayerConnected(playerid)) return true;
	new msg[112];
	format(msg, sizeof(msg), ""SERVER_MSG"Игрок %s(%d) выпущен из тюрьмы.",Player[playerid][PlayerName], playerid);
	format(msgcheatEn, sizeof(msgcheatEn), ""SERVER_MSG"Player %s (%d) is released from prison.",Player[playerid][PlayerName], playerid);
	t_SendClientMessageToAll(-1,-1, msg,msgcheatEn);
	Player[playerid][pJTime] = 0;
	Player[playerid][pJail] = false;
	t_SetPlayerPos(playerid,1545.8699,-1675.6434,13.5612);
	SetPlayerFacingAngle(playerid,87.5806);
	SetPlayerInterior(playerid, 0);
	t_SetPlayerVirtualWorld(playerid,0);
	SetCameraBehindPlayer(playerid);
	return true;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(Player[playerid][logged] && !Player[playerid][pJail]){
		if(newkeys == 264201 && Player[playerid][pDriftPointsNow][0]){
			//AddBan(playerid,INVALID_PLAYER_ID,"Cheat: Sobeit #1",3600);
			SendClientMessage(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [Sobeit #1]"), t_Kick(playerid);
			return true;
		}
	    //new str[50];format(str,sizeof(str),"%d - newkeys, %d - oldkeys",newkeys,oldkeys);SendClientMessage(playerid,-1,str);
		new Car = GetPlayerVehicleID(playerid);
		if(newkeys == 3 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
			GetVehicleParamsEx(Car,engine,lights,alarm,doors,	bonnet,	boot,objective);
			SetVehicleParamsEx(Car,engine,(lights == 0 || lights == -1)?1:0,	alarm,doors,bonnet,boot,objective);
		}
		if(newkeys & KEY_CROUCH && GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
			new Float:health;
			GetVehicleHealth(Car, health);
			if(health != 1000){
				RepairVehicle(Car);
				if(health < 300){
					new Float:Coord;
					GetVehicleZAngle(Car, Coord);
					SetVehicleZAngle(Car, Coord);	
				}
			}
		}
		if(newkeys == 1 || newkeys == 9 || newkeys == 33 && oldkeys != 1 || oldkeys != 9 || oldkeys != 33)
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		if(!Player[playerid][pKeyMenu] && rRaceStatusEx[playerid] != STATUS_RACE_STARTED){
			if(newkeys & 65536)
				ShowMenuForPlayerEx(playerid);
		}else if(rRaceStatusEx[playerid] != STATUS_RACE_STARTED){
			if ((newkeys==KEY_SUBMISSION) && Car)
				ShowMenuForPlayerEx(playerid);
			if ((newkeys==KEY_WALK) && !Car)
				ShowMenuForPlayerEx(playerid);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && Player[playerid][KeyStop] && newkeys == 160){
			new Float:coord;
			GetVehicleVelocity(GetPlayerVehicleID(playerid),coord,coord,coord);
			SetVehicleVelocity(GetPlayerVehicleID(playerid),0,0,coord);
		}
		if(Player[playerid][KeyTP] && rRaceStatusEx[playerid] != STATUS_RACE_STARTED){
			if(newkeys == 5 && oldkeys == 4){
				new Float:coord[3];
				GetPlayerPos(playerid, coord[0], coord[1], coord[2]);
				SetPVarFloat(playerid, "CoordX", coord[0]);
				SetPVarFloat(playerid, "CoordY", coord[1]);
				SetPVarFloat(playerid, "CoordZ", coord[2]);
				SetPVarFloat(playerid, "tpest", 1);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
					GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle);
				else
					GetPlayerFacingAngle(playerid, Angle);
				SetPVarFloat(playerid, "zAngle", Angle);	
			}
			else if(Player[playerid][KeyTP] && newkeys == 5 && oldkeys == 1){
				if(GetPVarFloat(playerid, "tpest"))
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
						t_SetVehiclePos(GetPlayerVehicleID(playerid),GetPVarFloat(playerid, "CoordX"), GetPVarFloat(playerid, "CoordY"), GetPVarFloat(playerid, "CoordZ")+2);
						SetVehicleZAngle(GetPlayerVehicleID(playerid),GetPVarFloat(playerid, "zAngle"));
					}else{
						t_SetPlayerPos(playerid, GetPVarFloat(playerid, "CoordX"), GetPVarFloat(playerid, "CoordY"), GetPVarFloat(playerid, "CoordZ")+2);
						SetPlayerFacingAngle(playerid, GetPVarFloat(playerid, "zAngle"));
				}	}
				else SendClientMessage(playerid, COLOR_WHITE,""SERVER_MSG"У вас нет точки ТП!");
			}
		}
		if(newkeys == 8)
			SetPVarInt(playerid,"NoRemov",5);
		if(Player[playerid][pWeapons]&& rRaceStatusEx[playerid] != STATUS_RACE_STARTED){
			if(newkeys & KEY_FIRE && Player[playerid][pWeapons] == 1&& GetPlayerState(playerid) == PLAYER_STATE_DRIVER){
				new
					Float:z, Float:angle,
					Model = GetVehicleModel(Car)
				;
				switch(Model){
				case 481,509,510,581,462,521,522,461,448,468,586:{
						if (ramped[playerid]){
							KillTimer(timerramp[playerid]);
							DestroyDynamicObject(jumped[playerid]);
							ramped[playerid]=0;
						}
						GetPlayerPos(playerid, wc_x, wc_y, z);
						angle = GetPosInFrontOfPlayer(playerid, wc_x, wc_y, GetRampDistance(playerid)); //()
						jumped[playerid] = CreateDynamicObject(1632, wc_x, wc_y, z - 0.5, 0.0, 0.0, angle,GetPlayerVirtualWorld(playerid),GetPlayerInterior(playerid),playerid);
						ramped[playerid] = 1;
						timerramp[playerid] = SetTimerEx("DeleteRamp", 2000, 0, "d", playerid);
			}	}	}
			else if(newkeys & 131072 && Player[playerid][pWeapons] == 1){
				new Model = GetVehicleModel(Car);
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && Player[playerid][logged]){
					if(Jumping[playerid]+1000 < GetTickCount()){
						switch(Model){
						case 481,509,510,581,462,521,522,461,448,468,586: return false;
						default:{
								new Float:posd[3];
								GetVehicleVelocity(Car, posd[0], posd[1], posd[2]);
								SetVehicleVelocity(Car, posd[0], posd[1], posd[2]+0.15);
								Jumping[playerid] = GetTickCount();
							}
						}
					}
				}
			}
			else if(newkeys & 131072 && Player[playerid][pWeapons] == 2 && Jumping[playerid]+2500 < GetTickCount()){
				new Float:sped[3],
					Float:pPosEx[3];
				GetVehicleVelocity(Car, sped[0], sped[1], sped[2]);
				GetCoordBonnetVehicle(Car, pPosEx[0],pPosEx[1],pPosEx[2]);
				SetVehiclePos(Car,pPosEx[0],pPosEx[1],pPosEx[2]+1.0);
				SetVehicleVelocity(Car, sped[0]+0.01, sped[1]+0.01, sped[2]+0.01);
				Jumping[playerid] = GetTickCount();
			}
		}
	}
	return false;
}
public DeleteRamp(playerid){
	if (ramped[playerid])
	{
		DestroyDynamicObject(jumped[playerid]);
		ramped[playerid]=0;
	}
}
public OnPlayerUpdate(playerid){
	if(Kicked[playerid])
		return false;
	if(Player[playerid][logged]){
	    AfkTime[playerid] = 0;
		new State = GetPlayerState(playerid);
		if(State==PLAYER_STATE_DRIVER || State==PLAYER_STATE_PASSENGER){
			new CarID = GetPlayerVehicleID(playerid),
				Seat = GetPlayerVehicleSeat(playerid);
			Seat=(Seat==0)?0:1;
			if(State == PLAYER_STATE_DRIVER){
				UpdateSpeedSystem(playerid);
				if(Player[playerid][pSpeedom]){
					if(!UpdSpd[playerid]){
						UpdSpd[playerid] = true;
						UpdateSpeedom(playerid);
					}else UpdSpd[playerid] = false;
				}
			}
			if(OLDVEH[playerid] != CarID || OLDSEAT[playerid] != Seat){
				if((Seat != IDSEAT[playerid] || IDVEH[playerid] != CarID) && GetTickCount()-IDTICK[playerid] > 300+GetPlayerPing(playerid)){
					AddBan(playerid,INVALID_PLAYER_ID,"Cheat: CarJailed #1",600);
					SendClientMessage(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [CarJailed #1]"), t_Kick(playerid);
					return false;
				}
				OLDVEH[playerid] = CarID;
				OLDSEAT[playerid] = Seat;
			}
		}
	}
	return true;
}
public 	OnPlayerWeaponCht(playerid,weapon){
	if(Player[playerid][logged] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
		if(weapon == 46 || weapon == 1 || weapon == 43) return true;
		ResetPlayerWeapons(playerid);
		if(!GetPVarInt(playerid,"WEAPONCHEAT")){
			ac_GivePlayerWeapon(playerid,46,1);
			ac_GivePlayerWeapon(playerid,1,1);
			ac_GivePlayerWeapon(playerid,43,1000);
			SetPVarInt(playerid,"WEAPONCHEAT",1);
			return true;
		}
		else{
			AddBan(playerid,INVALID_PLAYER_ID,"Cheat: Weapon #1",3600);
			return SendClientMessage(playerid, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [Weapon #1]"), t_Kick(playerid);
		}
	}
	return true;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source){
	if(!Player[playerid][logged]) return true;
	minidialog = "";
	clickedplayeride[playerid] = clickedplayerid;
	if(playerid==clickedplayerid)
	{
		new name[MAX_PLAYER_NAME];
		minidialog = "";
		strcat(name, Player[playerid][PlayerName]);
		if(!LanglePlayer{playerid}){
			strcat(minidialog, "{FFFFFF}================================\n\nНик:\t\t{");
			strcat(minidialog, chatcolor[Player[playerid][pColorPlayer]]);
			format(minidialog, sizeof(minidialog), "%s}%s\n{00f5da}Денег:\t\t\t\t%d\n{FFFFFF}Уровень:\t\t\t%d\n{00f5da}Уровень админки:\t\t%d\n{FFFFFF}Скин:\t\t\t\t%d\n{00f5da}Молчанка:\t\t\t%d\n{FFFFFF}Предупреждений:\t\t%d\n{00f5da}Виртуальный мир:\t\t%d", minidialog,name, GetPlayerCash(playerid), Player[playerid][pLevel], (Player[playerid][pAdminPlayer] > 1)?Player[playerid][pAdminPlayer]:0, Player[playerid][pSkin],Player[playerid][pMuted],GetPVarInt(playerid,"warn"),GetPlayerVirtualWorld(playerid));
			new msg[112];
			format(msg, sizeof(msg), "\n{FFFFFF}Время на сервере:\tДней:\t%d\n\t\t\tЧасов:\t%d\n\t\t\tМинут:\t%d",Player[playerid][pTimeOnlineD],Player[playerid][pTimeOnlineH],Player[playerid][pTimeOnline]);
			strcat(minidialog, msg);
			format(msg, sizeof(msg), "\n{00f5da}Побед в дуэлях\t\t%d\n{FFFFFF}Проигрышей в дуэлях\t%d\n{00f5da}Коэффициент побед\t\t%0.2f",Player[playerid][pWinRace],Player[playerid][pLooseRace],(Player[playerid][pWinRace]+0.001)/(Player[playerid][pLooseRace]+0.001));
			strcat(minidialog, msg);
			strcat(minidialog, "\n\n{FFFFFF}================================");
			ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Ваша статистика.",minidialog,"Закрыть","");
		}else{
			strcat(minidialog, "{FFFFFF}================================\n\nNick:\t\t\t{");
			strcat(minidialog, chatcolor[Player[playerid][pColorPlayer]]);
			format(minidialog, sizeof(minidialog), "%s}%s\n{00f5da}Money:\t\t\t%d\n{FFFFFF}Level:\t\t\t\t%d\n{00f5da}AdminEx level:\t\t\t%d\n{FFFFFF}Skin:\t\t\t\t%d\n{00f5da}Mute:\t\t\t\t%d\n{FFFFFF}Warn's:\t\t\t%d\n{00f5da}Virtual world:\t\t\t%d", minidialog,name, GetPlayerCash(playerid), Player[playerid][pLevel], (Player[playerid][pAdminPlayer] > 1)?Player[playerid][pAdminPlayer]:0, Player[playerid][pSkin],Player[playerid][pMuted],GetPVarInt(playerid,"warn"),GetPlayerVirtualWorld(playerid));
			new msg[112];
			format(msg, sizeof(msg), "\n{FFFFFF}Time on server: Day's:\t%d\n\t\tHour's:\t%d\n\t\tMinut's:\t%d",Player[playerid][pTimeOnlineD],Player[playerid][pTimeOnlineH],Player[playerid][pTimeOnline]);
			strcat(minidialog, msg);
			format(msg, sizeof(msg), "\n{00f5da}Win's on duel\t\t\t%d\n{FFFFFF}Loose's on duel\t\t%d\n{00f5da}Coefficient victories\t\t%0.2f",Player[playerid][pWinRace],Player[playerid][pLooseRace],(Player[playerid][pWinRace]+0.001)/(Player[playerid][pLooseRace]+0.001));
			strcat(minidialog, msg);
			strcat(minidialog, "\n\n{FFFFFF}================================");
			ShowPlayerDialog(playerid,435,DIALOG_STYLE_MSGBOX,"{FFFFFF}Your statistics.",minidialog,"Close","");
		}
		return true;
	}
	if(!LanglePlayer{playerid}){
		if(!Player[playerid][pAdminPlayer])
			strcat(minidialog,"Написать PM\nПередать деньги\nВызвать на дуэль\nПожаловатся админам\nПосмотреть информацию\nВыгнать из авто\n");
		else
			strcat(minidialog,"Написать PM\nПередать деньги\nВызвать на дуэль\nАдмин меню\nПосмотреть информацию\nВыгнать из авто\n");
		if(IsFrende(playerid,clickedplayerid))
			strcat(minidialog,"Удалить из друзей");
		else if(IsNoActFrende(playerid,clickedplayerid))
			strcat(minidialog,"Отменить заявку в друзья");
		else if(InBlackList(playerid,clickedplayerid))
			strcat(minidialog,"Убрать из ЧС");
		else
			strcat(minidialog,"Добавить в друзья\nДобавить в ЧС");
		ShowPlayerDialog(playerid, 239, DIALOG_STYLE_LIST, "Выберите действие", minidialog, "Ок", "Отмена");	
	}else{
		if(!Player[playerid][pAdminPlayer])
			strcat(minidialog,"Write PM\nGive money\nDuel\nComplain\nSee info\nKick out the car\n");
		else
			strcat(minidialog,"Write PM\nGive money\nDuel\nAdmin menu\nSee info\nKick out the car\n");
		if(IsFrende(playerid,clickedplayerid))
			strcat(minidialog,"Delete from friends");
		else if(IsNoActFrende(playerid,clickedplayerid))
			strcat(minidialog,"Cancel a request in friends");
		else if(InBlackList(playerid,clickedplayerid))
			strcat(minidialog,"Remove from Black list");
		else
			strcat(minidialog,"Add to Friends\nAdd to Black list");
		ShowPlayerDialog(playerid, 239, DIALOG_STYLE_LIST, "Select operation", minidialog, "Ok", "Cancel");	
	}	
	return true;
}
public SaveScore(playerid){
	if(Player[playerid][logged])
	{
		new qString2[112];
		format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `level`='%i' WHERE `id`='%i'",
			Player[playerid][pLevel],
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, qString2, false, "", "");
	}
	return true;
}
public SaveKoeff(playerid){
	if(Player[playerid][logged] && Player[playerid][pLooseRace] > 3)
	{
		new Float:KoeffPobed = (Player[playerid][pWinRace]+0.001)/(Player[playerid][pLooseRace]+0.001);
		if(KoeffPobed > RecordKoeff){
			new qString2[112];
			format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `KoeffPobed`='%0.2f' WHERE `id`='%i'",
				KoeffPobed,
				Player[playerid][pSQLID]
			);
			mysql_function_query(MYSQL, qString2, false, "", "");
			mysql_function_query(MYSQL, "SELECT `Nickname`,`KoeffPobed` FROM `accounts` ORDER BY `KoeffPobed` DESC LIMIT 1", true, "TopKoeff", "");
		}
	}
	return true;
}
public SaveWins(playerid){
	if(Player[playerid][logged] && Player[playerid][pWinRace] > RecordSkolk[RECORD_WINS])
	{
		new qString2[112];
		format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `WinRace`='%i' WHERE `id`='%i'",
			Player[playerid][pWinRace],
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, qString2, false, "", "");
		mysql_function_query(MYSQL, "SELECT `Nickname`,`WinRace` FROM `accounts` ORDER BY `WinRace` DESC LIMIT 1", true, "TopWins", "");
	}
	return true;
}
public SaveLoose(playerid){
	if(Player[playerid][logged] && Player[playerid][pLooseRace] > RecordSkolk[RECORD_LOOS])
	{
		new qString2[112];
		format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `LooseRace`='%i' WHERE `id`='%i'",
			Player[playerid][pLooseRace],
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, qString2, false, "", "");
		mysql_function_query(MYSQL, "SELECT `Nickname`,`LooseRace` FROM `accounts` ORDER BY `LooseRace` DESC LIMIT 1", true, "TopLoose", "");
	}
	return true;
}
public SaveMoney(playerid){
	if(Player[playerid][logged])
	{
		new qString2[112];
		format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `Money`='%i' WHERE `id`='%i'",
			GetPlayerCash(playerid),
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, qString2, false, "", "");
	}
	return true;
}
public SaveAdmin(playerid){
	if(Player[playerid][logged]){
		new qString2[112];
		format(qString2, sizeof qString2, "UPDATE "TABLE_ACC" SET `AdminEx`='%i' WHERE `id`='%i'",
			Player[playerid][pAdminPlayer],
			Player[playerid][pSQLID]
		);
		mysql_function_query(MYSQL, qString2, false, "", "");
	}
	return true;
}
public SaveAccount(playerid){
	if(!restarting){
		UpdatePlayerPosition(playerid);
		new qString2[750],
			savecar[500],
			pGpci[65];
		new Float:KoeffPobed = (Player[playerid][pWinRace]+0.001)/(Player[playerid][pLooseRace]+0.001);
		gpci(playerid,pGpci,64);
		format(savecar, sizeof savecar, "UPDATE "TABLE_ACC" SET `Banned`='%i',`VIPg`='%i',`Muted`='%i',`Jail`='%i', \
		`last_game`='%i',`combodays`='%i',`Speedom`='%i',`Avtorepair`='%i',`pTags`='%i',`Int`='%i',`Virt`='%i',`WinRace`='%i',`LooseRace`='%i',`KoeffPobed`='%0.2f',",
			Player[playerid][pBanned],
			Player[playerid][pVIP],
			Player[playerid][pMuted],
			Player[playerid][pJail],
			Player[playerid][pBonus_d],
			Player[playerid][pComboDays],
			Player[playerid][pSpeedom],
			Player[playerid][pRepair],
			Player[playerid][pTags],
			t_GetPlayerInterior(playerid),
			t_GetPlayerVirtualWorld(playerid),
			Player[playerid][pWinRace],
			Player[playerid][pLooseRace],
			(Player[playerid][pLooseRace] > 3)?KoeffPobed:0.00
		);
		strcat(qString2, savecar);
		format(savecar, sizeof savecar, "`DoubleDrift`='%i',`DoubleDriftT`='%i',`NoCrash`='%i',`NoCrashTime`='%i',`Skin`='%i',`Score`='%i', \
		`level`='%i',`keymenu`='%i',`KeyTP`='%i',`KeyStop`='%i',`TimeOnServer`='%i',`TimeOnServerH`='%i',`TimeOnServerD`='%i',`StopAdmin`='%d',`StopVip`='%d',`EndOnline`='%d',`TimeNewNick`='%d',`ColorSpeedom`='%d' WHERE `id`='%i'",		
			Player[playerid][pDoubleDrift],
			Player[playerid][pDoubleDriftT],
			Player[playerid][pNoCrash],
			Player[playerid][pNoCrashTime],
			Player[playerid][pSkin],
			GetPlayerScore(playerid),
			Player[playerid][pLevel],
			Player[playerid][pKeyMenu],
			Player[playerid][KeyTP],
			Player[playerid][KeyStop],
			Player[playerid][pTimeOnline],
			Player[playerid][pTimeOnlineH],
			Player[playerid][pTimeOnlineD],
			Player[playerid][pStopAdmin],
			Player[playerid][pStopVip],
			gettime(),
			Player[playerid][pTimeNewNick],
			Player[playerid][pColorSpeedom],
			Player[playerid][pSQLID]
		);
		strcat(qString2, savecar);
		mysql_function_query(MYSQL, qString2, false, "", "");
		qString2 = "";
		savecar = "";
		format(savecar, sizeof savecar, "UPDATE "TABLE_ACC" SET `JTime`='%i',`CheaterEx`='%i',`Vmashine`='%i',\
		`MuteTime`='%i',`JailAdm`='%i',`MutedAdm`='%i',`Money`='%i',`AdminEx`='%i',`Pos_x`='%f',`Pos_y`='%f',`Pos_z`='%f',`Pos_f`='%f'",
			Player[playerid][pJTime],
			Player[playerid][pCheater],
			Player[playerid][pAutoUID][GetCarId(playerid)],
			Player[playerid][pMuteTime],
			Player[playerid][pJailAdm],
			Player[playerid][pMutedAdm],
			GetPlayerCash(playerid),
			Player[playerid][pAdminPlayer],
			Player[playerid][pPos][0],
			Player[playerid][pPos][1],
			Player[playerid][pPos][2],
			Player[playerid][pPos][3]
		);
		strcat(qString2, savecar);
		format(savecar, sizeof savecar, ",`Color`='%d',`ColorScore`='%i',`ExtraWeapons`='%i',`pColorText`='%i',`carslots`='%i',`DonatM`='%i',`PmStatus`='%d',`LangPlayer`='%d',`LastAddres`='%d',`gpci`='%s',`OldDuel`='%d' WHERE `id`='%i'",			
			Player[playerid][pColorPlayer],
			Player[playerid][pColorScore],
			Player[playerid][pWeapons],
			Player[playerid][pColorText],
			Player[playerid][pCarslots],
			Player[playerid][pDonatM],
			Player[playerid][pPmStatus],
			LanglePlayer{playerid},
			(!Player[playerid][pBanned]?address[playerid]:1000),
			pGpci,
			Player[playerid][pOldDuel],
			Player[playerid][pSQLID]
		);
		strcat(qString2, savecar);
		mysql_function_query(MYSQL, qString2, false, "", "");
		qString2 = "";
		savecar = "";
		for(new f = 1; f < MAX_VEHICLES_FOR_PLAYER; f++)
		{
			if(!Player[playerid][pAuto][f])
				continue;
			if(IsValidVehicle(pvehs[f][playerid])){
		        GetVehiclePos(pvehs[f][playerid],Player[playerid][pAPos_x][f],Player[playerid][pAPos_y][f],Player[playerid][pAPos_z][f]);
                GetVehicleZAngle(pvehs[f][playerid], Player[playerid][pAPos_a][f]);
			}else{
				Player[playerid][pAPos_x][f] = 0.0;
				Player[playerid][pAPos_y][f] = 0.0;
				Player[playerid][pAPos_z][f] = 0.0;
				Player[playerid][pAPos_a][f] = 0.0;
				Player[playerid][cWorld][f] = 0;
			}
			format(savecar, sizeof savecar, "UPDATE "CARS_TABLE" SET \
				`cModel`='%d',`cPos_x`='%f',`cPos_y`='%f',`cPos_z`='%f',`cPos_a`='%f',`cVirtWorld`='%i',`cGidravlika`='%d',`pNumber`='%s',`cVinil`='%d',`cColorOne`='%d',`cColorTwo`='%d',`cWheels`='%d' WHERE `cID`='%d'",
				Player[playerid][pAuto][f],
				Player[playerid][pAPos_x][f],
				Player[playerid][pAPos_y][f],
				Player[playerid][pAPos_z][f],
				Player[playerid][pAPos_a][f],
				Player[playerid][cWorld][f],
				Player[playerid][cGidravlika][f],
				pNumber[f][playerid],
				Player[playerid][pVinil][f],
				Player[playerid][pColor][f],
				Player[playerid][pColorTwo][f],
				Player[playerid][cWheels][f],
				Player[playerid][pAutoUID][f]	
			);
			mysql_function_query(MYSQL, savecar, false, "", "");
			savecar = "";
}	}	}
public StartSpectate(playerid, specid){
	if(!GetPVarInt(playerid,"specc") ||GetPVarInt(playerid,"specstate") != GetPlayerState(specid) && GetPVarInt(playerid,"specc") == 1)
	{
		SetPVarInt(playerid,"specstate",GetPlayerState(specid));
		TogglePlayerSpectating(playerid, 1);
		SetPlayerInterior(playerid, GetPlayerInterior(specid));
		t_SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		if(IsPlayerInAnyVehicle(specid))
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specid));
		else
			PlayerSpectatePlayer(playerid, specid);
		GetSpectate[playerid] = specid;
		SetPVarInt(playerid,"specc",1);
		PlayerSpectate[playerid] = true;
	}
	return true;
}
public StopSpectate(playerid){
	if(PlayerSpectate[playerid]){
		SetPVarInt(playerid,"NoCheater",5);
		TogglePlayerSpectating(playerid, 0);
		GetSpectate[playerid] = INVALID_PLAYER_ID;
		PlayerSpectate[playerid] = false;
		GameTextForPlayer(playerid,"SPECTATE OFF", 1000, 3);
		KillTimer(SpectateTimer[playerid]);
		SpawnPlayer(playerid);
	}
	return true;
}
public OnVehicleMod(playerid,vehicleid,componentid){
	if(GetPVarInt(playerid,"addcomp") != 1  && tunings(playerid) == false)
	{
		RemoveVehicleComponent(vehicleid,componentid);
		if(!LanglePlayer{playerid})
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#28]");
		else
			SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK_EN" [#28]");
		return t_Kick(playerid);
	}
	else SetPVarInt(playerid,"addcomp",0);
	return true;
}
public OnPlayerEnterCheckpoint(playerid){
	return true;
}
public DriftExit(playerid){
	if(Player[playerid][pDriftPointsNow][0])
	{
		DaiEmyDeneg(playerid, Player[playerid][pDriftPointsNow][0]*10);
		GivePlayerScore(playerid,Player[playerid][pDriftPointsNow][0]*BonusDrift[playerid]);
		TextDrawHideForPlayer(playerid,hpDraweFon);
		TextDrawHideForPlayer(playerid,hpDrawe[playerid]);
		PlayerTextDrawHide(playerid,DriftPointsShow[playerid]);
		if(ShowStirLock[playerid]){
			TextDrawHideForPlayer(playerid,StirLock[Player[playerid][pColorScore]]);
			ShowStirLock[playerid] = 0;
		}
		UpdateScoreSystem(playerid);
	}
	if(Player[playerid][pDriftPointsNow][0]){
		if(gettime()-starttime[playerid] > rRecordTime){
			new oldrecord = rRecordTime;
			rRecordTime = gettime()-starttime[playerid];
			rRecordTimeUID = Player[playerid][pSQLID];
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"%s установил новый рекорд по длительности 1 серии заносов.",Player[playerid][PlayerName]);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"%s set a new record for the longest one series drifts.",Player[playerid][PlayerName]);//ID 00003
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Старый рекорд %d сек, новый %d сек!",oldrecord,rRecordTime);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"Old record %d sec, new %d sec!",oldrecord,rRecordTime);//ID 00003
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
			DaiEmyDeneg(playerid,100000);
			if(!LanglePlayer{playerid})
				SendClientMessage(playerid, -1, ""SERVER_MSG"Поздравляем с установлением нового рекорда, твой бонус 100000$!");
			else
				SendClientMessage(playerid, -1, ""SERVER_MSG"We congratulate on establishment of a new record, your bonus of $100000!");
		 	new savecar[128];
			format(savecar, sizeof savecar, "UPDATE `records` SET `rRecordTime`= '%d',`rRecordTimeUID`= '%d',`rRecordTimeName`= '%s'",
				rRecordTime,
				rRecordTimeUID,
				Player[playerid][PlayerName]
			);
			mysql_function_query(MYSQL, savecar, false, "", "");
		}
		if(Player[playerid][pDriftPointsNow][0] > rRecordScore){
			new oldrecord = rRecordScore;
			rRecordScore = Player[playerid][pDriftPointsNow][0];
			rRecordScoreUID = Player[playerid][pSQLID];
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"%s установил новый рекорд кол-ву очков за 1 серию заносов.",Player[playerid][PlayerName]);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"%s I set a new record to a quantity of points for 1 series of drifts.",Player[playerid][PlayerName]);//ID 00003
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Старый рекорд %d очков, новый %d очков!",oldrecord,rRecordScore);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"Old record %d points, new %d points!",oldrecord,rRecordScore);//ID 00003
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
			DaiEmyDeneg(playerid,100000);
			if(!LanglePlayer{playerid})
				SendClientMessage(playerid, -1, ""SERVER_MSG"Поздравляем с установлением нового рекорда, твой бонус 100000$!");
			else
				SendClientMessage(playerid, -1, ""SERVER_MSG"We congratulate on establishment of a new record, your bonus of $100000!");
		 	new savecar[128];
			format(savecar, sizeof savecar, "UPDATE `records` SET `rRecordScore`= '%d',`rRecordScoreUID`= '%d',`rRecordScoreName`= '%s'",
				rRecordScore,
				rRecordScoreUID,
				Player[playerid][PlayerName]
			);
			mysql_function_query(MYSQL, savecar, false, "", "");
		}
		if(checkangle[playerid] > rRecordCombo && Player[playerid][pDriftPointsNow][0] > 50){
			new Float:oldrecord = rRecordCombo;
			rRecordCombo = checkangle[playerid];
			rRecordComboUID = Player[playerid][pSQLID];
			DaiEmyDeneg(playerid,100000);
			if(!LanglePlayer{playerid})
				SendClientMessage(playerid, -1, ""SERVER_MSG"Поздравляем с установлением нового рекорда, твой бонус 100000$!");
			else
				SendClientMessage(playerid, -1, ""SERVER_MSG"We congratulate on establishment of a new record, your bonus of $100000!");
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"%s установил новый рекорд по максимальному среднему углу заноса.",Player[playerid][PlayerName]);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"%s set a new record on the maximum average angle of drift.",Player[playerid][PlayerName]);//ID 00003
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
			format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Старый рекорд %f , новый %f!",oldrecord,rRecordCombo);
			format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"Old record %f, new %f!",oldrecord,rRecordCombo);//ID 00003
			t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
		 	new savecar[156];
			format(savecar, sizeof(savecar), "UPDATE `records` SET `rRecordCombo`= '%f',`rRecordComboUID`= '%d',`rRecordComboName`= '%s'",
				rRecordCombo,
				rRecordComboUID,
				Player[playerid][PlayerName]
			);
			mysql_function_query(MYSQL, savecar, false, "", "");
		}
	}	
	Player[playerid][pDriftPointsNow][0] = 0;
	Player[playerid][pDriftPointsNow][1] = 0;
	checkangle[playerid] = 0.0;
	BonusDrift[playerid] = 0;
}
public OnPlayerStateChange(playerid,newstate,oldstate){
    if(!Player[playerid][logged]) return true;
	new
		Car = GetPlayerVehicleID(playerid),
		Float:px,
		Float:py,
		Float:pz;
	if(Car)
		GetVehiclePos(Car,px,py,pz);
	else
		GetPlayerPos(playerid,px,py,pz);
	Player[playerid][pPos][0] = px;
	Player[playerid][pPos][1] = py;
	Player[playerid][pPos][2] = pz;
	if(Player[playerid][pDriftPointsNow][0])
		DriftExit(playerid);
	switch(newstate){
		case PLAYER_STATE_DRIVER:{
		    carowner[Car] = playerid;
			if(oldstate == PLAYER_STATE_PASSENGER && IDVEH[playerid] != Car || (newstate == PLAYER_STATE_PASSENGER && oldstate == PLAYER_STATE_DRIVER && IDVEH[playerid] != Car))
				return SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#29]"), t_Kick(playerid);
			switch(Player[playerid][pSpeedom]){
				case 1:PlayerTextDrawShow(playerid,Speed2[playerid]);
				case 2:PlayerTextDrawHide(playerid,Speed2[playerid]);
			}
   			new count = COLORS_SPEEDOM,
				speed = Player[playerid][pMaxSpeed]/count,
				speedsl = speedosl[playerid]/speed;
			switch(Player[playerid][pSpeedom]){
				case 1:{
				new indocat[32];
				format(indocat, sizeof(indocat),"KM/¤: %03d",speedosl[playerid]);
				PlayerTextDrawSetString(playerid,Speed2[playerid],indocat);
				if(count > speedsl && Player[playerid][pColorSpeedom] != 2){
					PlayerTextDrawColor(playerid,Speed2[playerid],speedcolors[Player[playerid][pColorSpeedom]][speedsl]);
					PlayerTextDrawShow(playerid,Speed2[playerid]);
			}	}
				case 2:{
				if(!OpenBox[playerid]){
					TextDrawShowForPlayer(playerid,Box);
					OpenBox[playerid] = true;
				}
				for(new i; i < count; i++) {
					if(speedsl >= i && speedosl[playerid] > 0){
						if(SpeedOpen[playerid][i]) continue;
						TextDrawShowForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
						SpeedOpen[playerid][i] = true;
					}else{
						if(!SpeedOpen[playerid][i]) continue;
						TextDrawHideForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
						SpeedOpen[playerid][i] = false;
			}	}   }   }
			UseEnter{playerid} = false;
			if(GetPVarInt(playerid,"nick") == 1){
				PlayerTextDrawShow(playerid,ScoreShow[playerid]);
				PlayerTextDrawShow(playerid,LevelShow[playerid]);
				TextDrawShowForPlayer(playerid,hpDrawFon);
	 			TextDrawShowForPlayer(playerid,hpDraw[playerid]);
			}
		}
		case PLAYER_STATE_PASSENGER:
		{
			UseEnter{playerid} = false;
			new Float:Poseds[3];
			GetVehiclePos(Car,Poseds[0],Poseds[1],Poseds[2]);
			SetPVarFloat(playerid,"CarPos_x",Poseds[0]);
			SetPVarFloat(playerid,"CarPos_y",Poseds[1]);
			SetPVarFloat(playerid,"CarPos_z",Poseds[2]);
	}	}
	switch(oldstate){
	    case PLAYER_STATE_DRIVER:{
			if(BanCar[IDVEH[playerid]])
				KillTimer(TimeUpdate[playerid]); 
			UpdateVehiclePos(IDVEH[playerid], 0); 
            TimeUpdate[playerid] = SetTimerEx("UpdateVehiclePos", 10000, false, "ii", IDVEH[playerid], 1); 
            BanCar[IDVEH[playerid]] = true; 
			if(rRaceStatusEx[playerid] == STATUS_RACE_STARTED && (newstate != PLAYER_STATE_DRIVER || GetCarIdPoId(Car,playerid))){
				new raceid = RaceID[playerid];
				new winner = (playerid == DDInfo[raceid][rRacer][0])?DDInfo[raceid][rRacer][1]:DDInfo[raceid][rRacer][0],
					looser = (winner==DDInfo[raceid][rRacer][0])?DDInfo[raceid][rRacer][1]:DDInfo[raceid][rRacer][0];
				format(msgcheat,sizeof(msgcheat),""SERVER_MSG"{%s}%s{FFFFFF} "DUEL_TEXT_7"",chatcolor[Player[winner][pColorPlayer]],Player[winner][PlayerName],chatcolor[Player[looser][pColorPlayer]],Player[looser][PlayerName]);
				format(msgcheatEn,sizeof(msgcheatEn),""SERVER_MSG"%s win duel with %s (technical victory).",Player[winner][PlayerName],Player[looser][PlayerName]);
				t_SendClientMessageToAll(-1,-1,msgcheat,msgcheatEn);
				GameTextForPlayer(winner,"~g~Winner!",1000,6);
				GameTextForPlayer(looser,"~r~Looser!",1000,6);
				DaiEmyDeneg(winner,PrizDD[winner]);
				DaiEmyDeneg(looser,-PrizDD[looser]/4);
				Player[winner][pWinRace]++;
				Player[looser][pLooseRace]++;
				if(!LanglePlayer{winner})
					format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Приз за победу в дуэли: $%d",PrizDD[winner]);
				else
					format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Prize for winning the duel: $%d",PrizDD[winner]);
				SendClientMessage(winner, -1, msgcheat);
				if(!LanglePlayer{looser})
					format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Штраф за уход с дуэли: $%d",PrizDD[winner]/4);
				else
					format(msgcheat,sizeof(msgcheat),""SERVER_MSG"Penalty for leaving the duel: $%d",PrizDD[winner]/4);
				SendClientMessage(looser, -1, msgcheat);
				StopDuel(raceid);		
			}
			Player[playerid][pDriftPointsNow][0] = 0;
			Player[playerid][pDriftPointsNow][1] = 0;
			if(OpenBox[playerid]){
				TextDrawHideForPlayer(playerid,Box);
				OpenBox[playerid] = false;
			}
			for(new i; i < COLORS_SPEEDOM; i++) {
			    if(!SpeedOpen[playerid][i]) continue;
				TextDrawHideForPlayer(playerid,Speed[Player[playerid][pColorSpeedom]][i]);
				SpeedOpen[playerid][i] = false;
			}
			if(newstate !=PLAYER_STATE_DRIVER){
				PlayerTextDrawHide(playerid,ScoreShow[playerid]);//убрать
				PlayerTextDrawHide(playerid,LevelShow[playerid]);//убрать
				PlayerTextDrawHide(playerid,Speed2[playerid]);
				TextDrawHideForPlayer(playerid,hpDrawFon);
				TextDrawHideForPlayer(playerid,hpDraw[playerid]);
			}
		}
		case PLAYER_STATE_PASSENGER:{
			if(newstate !=PLAYER_STATE_DRIVER){
				PlayerTextDrawHide(playerid,ScoreShow[playerid]);//убрать
				PlayerTextDrawHide(playerid,LevelShow[playerid]);//убрать
				TextDrawHideForPlayer(playerid,hpDrawFon);
				TextDrawHideForPlayer(playerid,hpDraw[playerid]);
	}	}	}
	return true;
}
public avtoriz(playerid)SetPVarInt(playerid,"avtoriz",0);
public updateangle(){
	new tick = GetTickCount();
	for(new i; i < MAX_PLAYERS; i++){
		if(!IsPlayerConnected(i) || GetPlayerState(i) != PLAYER_STATE_DRIVER || !IsCarEx[i])continue;
		if(Player[i][pDriftPointsNow][0] && PlayerDriftCancellation[i] < tick)
			DriftExit(i);
	}
	return true;
}
public driftcheckEx(){
	for(new i; i < MAX_PLAYERS; i++){
		if(!IsPlayerConnected(i) || GetPlayerState(i) != PLAYER_STATE_DRIVER) continue;
		new carid = GetPlayerVehicleID(i);
		if(carid && GetPlayerState(i) == PLAYER_STATE_DRIVER){
			if(PlayerCar[i] || rRaceStatusEx[i] == STATUS_RACE_STARTED){
				DriftCheck(i,carid);
	}	} 	}
	return true;
}
public UpdateAngleEx(){
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i))continue;
		new carid = GetPlayerVehicleID(i);
		if(carid && GetPlayerState(i) == PLAYER_STATE_DRIVER){
			if(PlayerCar[i] || rRaceStatusEx[i] == STATUS_RACE_STARTED)
				GetVehiclePos(carid, ppos[i][0], ppos[i][1], ppos[i][2]);
	}	} 
	return true;
}
public AntySpeed(){
	UpdateTime();
	new timerh = gettime();
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i))continue;
 		if(!Player[i][logged]){
			if(!gocamera[i]){
				new camEx = random(sizeof(Cams));
				SetPlayerCameraPos(i,Cams[camEx][StartX],Cams[camEx][StartY],Cams[camEx][StartZ]);
				SetPlayerCameraLookAt(i,Cams[camEx][FinishX],Cams[camEx][FinishY],Cams[camEx][FinishZ]);
				InterpolateCameraPos(i,Cams[camEx][StartX],Cams[camEx][StartY],Cams[camEx][StartZ],Cams[camEx][FinishX],Cams[camEx][FinishY],Cams[camEx][FinishZ],50000, CAMERA_MOVE);
				gocamera[i] = true;
				gettime(hour, minute);
				SetPlayerTime(i,hour,minute);
			}
			continue;
 		}
		if(GetPVarInt(i,"PlayerReg"))
			SelectTextDraw(i, 0xFFFFFFFF);
		if(countid[i] != INVALID_COUNT_ID){
			new count = (AllCounts[countid[i]][timestart]+AllCounts[countid[i]][time])-timerh;
			if(GetPlayerDistanceFromPoint(i, AllCounts[countid[i]][xC],AllCounts[countid[i]][yC],AllCounts[countid[i]][zC]) > 20 && count > 0){
				SendClientMessage(i,-1,""SERVER_MSG"Вы покинули зону отсчета!");
				if(countid[i] == i)
					StopCount(i);
				else
					countid[i] = INVALID_COUNT_ID;
			}
			else{
				if(count > 1){
					new timem[8];
					format(timem,sizeof(timem),"~g~%d",count);
					GameTextForPlayer(i,timem,1000,6);
				}
				else if(count == 1)
					GameTextForPlayer(i,"~y~1",1000,6);
				else if(!count) GameTextForPlayer(i,"~r~Go!",1000,6);
		}   }
		if(AllCounts[i][started]){
			if((AllCounts[i][timestart]+AllCounts[i][time])-timerh < 0)
				StopCount(i);
		}
	}
	return true;
}
public AntySH(){
	AFKCheck();
	CheckDriftDuel();
   	timejail += 1;
	if(timejail >= 3){
		timejail = 0;
		Jailed();
	}
	new timerh = gettime();
	if(!ChatOn){
		if(timerh >= timechaton){
		    ChatOn = true;
		    t_SendClientMessageToAll(-1, -1, ""SERVER_MSG"Чат автоматически включен", ""SERVER_MSG"Chat on");
	}   }
 	timetimer = GetTickCount();
	for(new i = 0, all = MAX_PLAYERS; i < all; i++){
		if(!IsPlayerConnected(i))continue;
		if(!Player[i][logged]){
			SetPVarInt(i,"Loggedtime",GetPVarInt(i,"Loggedtime")+1);
			if(GetPVarInt(i,"Loggedtime") >= 60){
				PlayerTextDrawHide(i,Loggeds[i]);
				if(!LanglePlayer{i}){
					SendClientMessage(i,-1,""SERVER_MSG"Вы кикнуты за AFK при авторизации.");
					SendClientMessage(i, -1, ""SERVER_MSG""TEXT_KICK" [#31]");
				}else{
					SendClientMessage(i,-1,""SERVER_MSG"You have been kicked for AFK at authorization.");//ID 00007
					SendClientMessage(i, -1, ""SERVER_MSG""TEXT_KICK_EN" [#31]");//ID 00008
				}
				t_Kick(i);
			}
			new timenologged[64];
			if(!LanglePlayer{i})
				format(timenologged,sizeof(timenologged),FixText("Осталось %d секунд."),60-GetPVarInt(i,"Loggedtime"));
			else
				format(timenologged,sizeof(timenologged),FixText("Were %d seconds."),60-GetPVarInt(i,"Loggedtime"));
			PlayerTextDrawSetString(i,Loggeds[i],timenologged);
			continue;
		}else{
		    SetPVarInt(i,"AntyFlood",0);
		    SetPVarInt(i,"AntyColor",0);
			if(oldpickup[i] != -1){
				new Float:z;
				GetPlayerPos(i, z, z, z);
				if(!IsPlayerInRangeOfPoint(i,1.3,GetPVarFloat(i,"PickupX"),GetPVarFloat(i,"PickupY"),z)) oldpickup[i] = -1;
			}
			new
				Float:posx,
				Float:posy,
				Float:posz,
				carid = GetPlayerVehicleID(i),
				State = GetPlayerState(i)
			;
			if(State == PLAYER_STATE_ONFOOT){
				if(GetPVarInt(i,"NoRemov"))
					SetPVarInt(i,"NoRemov",GetPVarInt(i,"NoRemov")-1);
				else
					RemovePlayerFromVehicle(i);
			}
			if(GetPVarInt(i,"UnFreeze")){
				SetPVarInt(i,"UnFreeze",GetPVarInt(i,"UnFreeze")-1);
				if(GetPVarInt(i,"UnFreeze") <= 0){
					TogglePlayerControllable(i, 1);
					SetPVarInt(i,"UnFreeze",0);
			}	}
			if(carid){
				GetVehiclePos(carid,posx, posy, posz);
				if(Player[i][pRepair]){
					new Float:health;
					GetVehicleHealth(carid, health);
					if(health < 300){
						RepairVehicle(carid);
					    AutoFlip(carid);
	}	}	}	}	}
	timesave += 1;
	if(timesave >= 60){
		timesave = 0;
		SaveAccounts();
	}
	return true;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
	if(GetCarIdPoId(vehicleid,playerid)){
		GetVehicleParamsEx(vehicleid,	carstate[0],	carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
		SetVehicleParamsEx(vehicleid,	true,		carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
	}
	SetPVarInt(playerid,"NoRemov",5);
	UseEnter{playerid} = true;
	IDVEH[playerid]=vehicleid;
	IDSEAT[playerid] = ispassenger;
	IDTICK[playerid] = GetTickCount();
	IsCarEx[playerid] = IsCar(vehicleid);
	PlayerCar[playerid] = GetCarIdPoId(vehicleid,playerid);
	if(!ispassenger)
		carowner[vehicleid]=playerid;
	Player[playerid][pCarSpeed] = GetMaxRazgon(GetVehicleModel(vehicleid))*5;
	Player[playerid][pMaxSpeed] = GetMaxSpeed(GetVehicleModel(vehicleid))/2*3;
	return true;
}
public OnPlayerExitVehicle(playerid, vehicleid){
	if(!GetPlayersInCar(vehicleid,playerid))
		NoOwned[vehicleid] = true;
	else{
		NoOwned[vehicleid] = false;
		TimeNoOwned[vehicleid] = gettime();
	}
	if(PlayerCar[playerid]){
		GetVehicleParamsEx(vehicleid,	carstate[0],	carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
		SetVehicleParamsEx(vehicleid,	false,		carstate[1],	carstate[2],	carstate[3],	carstate[4],	carstate[5],	carstate[6]);
	}
	return true;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success){
	if(!success)
	{
		minidialog = "";
		if(!LanglePlayer{playerid}){
	    	if(Player[playerid][pJail])
				format(minidialog,sizeof(minidialog),""SERVER_MSG"Извините, но команда \"%s\" не доступна в тюрьме, либо её просто нет!",cmdtext[1]);
			else
				format(minidialog,sizeof(minidialog),""SERVER_MSG"Извините, но команды \"%s\" нет на нашем сервере, или она вам не доступна!",cmdtext[1]);
		}else{
	    	if(Player[playerid][pJail])
				format(minidialog,sizeof(minidialog),""SERVER_MSG"Sorry, but the command \"%s\" is not available in prison, or it is not!",cmdtext[1]); //ID 00001
			else
				format(minidialog,sizeof(minidialog),""SERVER_MSG"Sorry, but the command \"%s\" not on our server, or it is not available to you!",cmdtext[1]); //ID 00002
		}
		SendClientMessage(playerid,-1,minidialog);
	}
	return true;
}
public OnPlayerCommandReceived(playerid, cmdtext[]){
	SetPVarInt(playerid,"AntyFlood",GetPVarInt(playerid,"AntyFlood")+1);
	if(Player[playerid][pAdminPlayer] > 6 || !Player[playerid][logged] || GetPVarInt(playerid,"AntyFlood") > 5){
		if(Player[playerid][logged])
			AddBan(playerid,INVALID_PLAYER_ID,"Flood",600);
		SendClientMessage(playerid, -1, ""SERVER_MSG""TEXT_KICK" [#34]");
		t_Kick(playerid);
		return false;
	}
	if(GetPVarInt(playerid,"OpenDialog") && GetPVarInt(playerid,"DialogID") != -1)
		return SendClientMessage(playerid, -1, ""SERVER_MSG"Закройте диалог для использования комманд!"),false;
	return true;
}
public OnRconLoginAttempt(ip[], password[], success){
    new ips[16];
    if(!success)
    {
		#if defined RconE
		for(new i = GetMaxPlayers() - 1; i != -1; i--)
		{
			GetPlayerIp(i, ips, sizeof(ips));
			if(strcmp(ip, ips, true)) return true;
			players[i]++;
			if(players[i] == Eror)
			{
				AddBan(i,INVALID_PLAYER_ID,"Rcon",3600);
				switch(NoRcon)
				{
					case 0: return true;
					case 1: return SendClientMessage(i, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [Rcon #1]"), t_Kick(i);
					case 2: return SendClientMessage(i, -1, SendBan), Ban(i);
					case 3: {
						format(msgcheat, sizeof(msgcheat), SendRcon ,Player[i][PlayerName], i);
						return SendAdminMessage(-1, msgcheat);
					}
				}
			}
		}
		#endif
	}
    return true;
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid){
	StatusUpdate[playerid] = GetTickCount();
	if(!Player[playerid][pNoCrash] && !Player[playerid][pVIP] && GetPlayerState(playerid)==PLAYER_STATE_DRIVER && Player[playerid][pDriftPointsNow][0]){
		DriftExit(playerid);
		SetPVarInt(playerid,"NoDrift",2);
		if(GetPVarInt(playerid,"nick") && !crash[playerid]){
			crash[playerid] = true;
	}   }
	if(GetPVarInt(playerid,"NoRepair"))
		SetPVarInt(playerid,"NoRepair",0);
	else if(Player[playerid][pRepair])
		RepairVehicle(vehicleid);
	return true;
}
UpdateHouseInfo(houseid){
	new string[256];
	DestroyDynamicPickup(HouseInfo[houseid][hpickup]);
	HouseInfo[houseid][hpickup] = CreateDynamicPickup (((!HouseInfo[houseid][howneruid] || HouseInfo[houseid][naprodaje])?1273:1272), 1, HouseInfo[houseid][henterx], HouseInfo[houseid][hentery], HouseInfo[houseid][henterz],0);
	pHID[HouseInfo[houseid][hpickup]] = houseid;
	if(!HouseInfo[houseid][howneruid])
		format(string,sizeof(string),"{00BC00}Дом продается! \n{00BC00}Стоимость дома: {F6F6F6}$%d\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[houseid][hprice] , houseid);
	else if(!HouseInfo[houseid][naprodaje])
		format(string,sizeof(string),"{00BC00}Владелец дома: {F6F6F6}%s\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[houseid][howner] , houseid);
	else
		format(string,sizeof(string),"{00BC00}Дом продается!\n{00BC00}Владелец дома: {F6F6F6}%s\n{00BC00}Стоимость дома: {F6F6F6}$%d\n{00BC00}ID дома: {F6F6F6}%d", HouseInfo[houseid][howner] , HouseInfo[houseid][hprice2] , houseid);
	return UpdateDynamic3DTextLabelText(HouseInfo[houseid][hlabel], -1, string);
}
public UpdateEx(i){
	new Float:player_hp=GetPlayerScore(i)/(20+Player[i][pLevel]);
	if(player_hp>100)player_hp=100;
	TextDrawTextSize(hpDraw[i],498+player_hp*0.62,0.0);
	return 1;
}
public UpdateDrift(i){
    if(GetPVarInt(i,"nick")){
		new Float:player_hp = Player[i][pDriftPointsNow][1]/3,
			str[36];
		if(player_hp>100)
			player_hp=100;
		TextDrawTextSize(hpDrawe[i],498+player_hp*0.62,0.0);
		format(str, sizeof(str),"+%04d x%02d",Player[i][pDriftPointsNow][0],BonusDrift[i]);
		PlayerTextDrawSetString(i,DriftPointsShow[i],str);
		PlayerTextDrawShow(i,DriftPointsShow[i]);
		TextDrawShowForPlayer(i,hpDrawe[i]);
	}
	return 1;
}
bool: animki(animname[]) return (!strcmp(animname, "SWIM_crawl", true) || !strcmp(animname, "SWIM_BREAST", true)|| !strcmp(animname, "SWIM_TREAD", true))?true:false;
public Update(){
	for(new i = GetMaxPlayers() - 1; i != -1; i--)
	{
		if(!IsPlayerConnected(i) || !Player[i][logged])continue;
		#if defined AirBrekE
		AirBrk(i);
	    if(GetPVarInt(i, "AntiBreik") > 0)
			SetPVarInt(i, "AntiBreik", GetPVarInt(i, "AntiBreik") - 1);
		#endif
		#if defined SwimE
		new animlib[30], animname[30];
		GetAnimationName(GetPlayerAnimationIndex(i), animlib, sizeof(animlib), animname, sizeof(animname));
		if(!IsPlayerInAnyVehicle(i) && GetPlayerState(i) != 9 && !GetPVarInt(i, "AntiBreik")){
			new Float:Cord[4];
			GetPlayerPos(i, Cord[0], Cord[1], Cord[2]);
			GetPlayerHealth(i, Cord[3]);
			if(Cord[2] >= 2 && Cord[3] > 0){
				GetPlayerVelocity( i, Cord[ 0 ], Cord[ 1 ], Cord[ 2 ] );
				new Float:rtn = floatsqroot(floatabs(floatpower(Cord[ 0 ] + Cord[ 1 ] + Cord[ 2 ],2))),
					speed = floatround(rtn * 100 * 1.61);
				if(strcmp(animlib, "SWIM", true) == 0 && animki(animname) && speed > 40){
					AddBan(i,INVALID_PLAYER_ID,"Cheat: Fly #1",600);
					switch(Fly){
						case 0: return true;
						case 1: SendClientMessage(i, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [#Fly]"), t_Kick(i);
						case 2: SendClientMessage(i, -1, SendBan), Ban(i);
						case 3: { format(msgcheat, sizeof(msgcheat), SendAdm ,Player[i][PlayerName], i); return SendAdminMessage(-1, msgcheat); }
		}	}	}	}
		#endif
		#if defined SpeedE
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER){
			new Float:posz;
			GetVehicleVelocity(GetPlayerVehicleID(i), posz, posz, posz);
			if(speedosl[i] > (Player[i][pMaxSpeed]+5) && posz > -0.04 && !AfkPlayer[i]){
				if(ReturnVidVehicle(GetVehicleModel(GetPlayerVehicleID(i))) == MOTO_TS){
					if(speedosl[i] < (Player[i][pMaxSpeed]+25))
						return true;
				}
				MaxSpeeds[i]++;
				if(MaxSpeeds[i] > 3){
					AddBan(i,INVALID_PLAYER_ID,"Cheat: SH #3",600);
					switch(MaxSpeedE)
					{
						case 0: return true;
						case 1: SendClientMessage(i, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [SH #3]"), t_Kick(i);
						case 2: SendClientMessage(i, -1, SendBan), Ban(i);
						case 3:
						{
							format(msgcheat, sizeof(msgcheat), SendAdm ,Player[i][PlayerName], i);
							return SendAdminMessage(-1, msgcheat);
						}
					}
				}
			}
			else if(MaxSpeeds[i])
				MaxSpeeds[i]--;
			OldPosZ[i] = posz;
		}
		#endif
		#if defined JetE
		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		{
			AddBan(i,INVALID_PLAYER_ID,"Cheat: JetPack",3600);
			switch(Sobeit)
			{
				case 0: return true;
				case 1: SendClientMessage(i, -1, ""SERVER_MSG"Вы кикнуты по подозрению в читерстве! [#JetPack #1]"), t_Kick(i);
				case 2: SendClientMessage(i, -1, SendBan), Ban(i);
				case 3: { format(msgcheat, sizeof(msgcheat), SendAdm ,Player[i][PlayerName], i); return SendAdminMessage(-1, msgcheat); }
			}
		}
		#endif
	}
	return true;
}
public OnVehicleStreamIn(vehicleid, forplayerid) { 
	UpdateVehiclePos(vehicleid, 0); 
	return 1; 
}
public UpdateVehiclePos(vehicleid, type) { 
        if(type == 1) 
        { 
            /*if(!StopCar(vehicleid)) 
            { 
                SetTimerEx("UpdateVehiclePos", 10000, false, "ii", vehicleid, 1); 
                return 1; 
            }*/ 
            BanCar[vehicleid] = false; 
        } 
        GetVehiclePos(vehicleid, VehPos[vehicleid][0], VehPos[vehicleid][1], VehPos[vehicleid][2]); 
        GetVehicleZAngle(vehicleid, VehPos[vehicleid][3]); 
        return 1; 
}
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat) {
	if(passenger_seat && (NoOwned[vehicleid] || !NoOwned[vehicleid] && gettime()-TimeNoOwned[vehicleid] > 10))
		SetVehicleToRespawn(vehicleid);
	else if(!passenger_seat){
		if(!GetPlayersInCar(vehicleid,playerid)){
			NoOwned[vehicleid] = true;
		}
		else{
			NoOwned[vehicleid] = false;
			TimeNoOwned[vehicleid] = gettime();
		}
	}
	new Float:Pos[3]; 
	GetVehiclePos(vehicleid, Pos[0], Pos[1], Pos[2]); 
	new Float:Count[2]; 
	Count[0] = Difference(Pos[0],VehPos[vehicleid][0]); 
	Count[1] = Difference(Pos[1],VehPos[vehicleid][1]); 
	switch(GetVehicleModel(vehicleid)) 
	{ 
		case 435, 450, 584, 591, 606..608, 610,611: goto UPDATE; 
	} 
	if((Count[0] > 5 || Count[1] > 5) && !UseCar(vehicleid) && !BanCar[vehicleid]) 
	{ 
		SetVehiclePos(vehicleid, VehPos[vehicleid][0], VehPos[vehicleid][1], VehPos[vehicleid][2]); 
		SetVehicleZAngle(vehicleid, VehPos[vehicleid][3]); 
	} 
	else 
	{ 
		UPDATE: 
		UpdateVehiclePos(vehicleid, 0); 
	} 
	return 1; 
} 
