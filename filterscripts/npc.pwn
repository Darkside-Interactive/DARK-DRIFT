//Includes
#include <a_samp>
#include <FCNPC>
//

///Переменные
new npc_timer; //создаем переменную для таймера NPC, чтобы можно было его контролировать, а именно - удалить после отгрузки скрипта
//

//Enums
enum npcInfo {
	npc_Name[MAX_PLAYER_NAME], //имя бота
	npc_Skin, //скин бота
	npc_FightStyle, //стиль боя бота
	Float:npc_X, //координата появления по Х
	Float:npc_Y, //координата появления по Y
	Float:npc_Z, //координата появления по Z
	Float:npc_A, //координата угла поворота при появлении
	weaponnpcid, //оружие бота
	npc_ID, //идентификатор бота
}

new npc[][npcInfo] = {
	{"Zomby_1", 14, FIGHT_STYLE_BOXING, 2059.5801,-1157.5491,23.8662,0.5298,0},
	{"Zomby_2", 11, FIGHT_STYLE_BOXING, 2127.4988,-1102.7822,25.3332,260.4813,0},
	{"Zomby_3", 12, FIGHT_STYLE_BOXING, 2363.3071,-1168.7085,27.6058,180.8306,0},
	{"Zomby_4", 13, FIGHT_STYLE_BOXING, 2650.0571,-1143.9971,53.3072,271.0841,0},
	{"Zomby_5", 14, FIGHT_STYLE_BOXING, 2865.8940,-1236.5001,22.5378,189.6527,0},
	{"Zomby_6", 16, FIGHT_STYLE_BOXING, 2851.2549,-1642.1361,11.0572,166.7453,0},
	{"Zomby_7", 17, FIGHT_STYLE_BOXING, 2868.0349,-1766.6456,11.0391,176.1350,0},
	{"Zomby_8", 19, FIGHT_STYLE_BOXING, 2801.0439,-1882.4718,11.0904,90.3332,0},
	{"Zomby_9", 21, FIGHT_STYLE_BOXING, 2777.5903,-1911.7109,12.3201,178.8871,0},
	{"Zomby_10", 23, FIGHT_STYLE_BOXING, 2721.1719,-2072.1953,12.5096,179.3726,0},
	{"Zomby_11", 29, FIGHT_STYLE_BOXING, 2687.5691,-2146.8684,11.0807,90.0093,0},
	{"Zomby_12", 32, FIGHT_STYLE_BOXING, 2278.8521,-2307.7031,13.5469,135.2575,0},
	{"Zomby_13", 37, FIGHT_STYLE_BOXING, 2415.4519,-2422.2761,13.5468,46.5049,0},
	{"Zomby_14", 87, FIGHT_STYLE_BOXING, 2612.0659,-2397.4255,13.6234,269.9502,0},
	{"Zomby_15", 190, FIGHT_STYLE_BOXING, 2653.8110,-2509.6152,13.6641,89.8468,0},
	{"Zomby_16", 22, FIGHT_STYLE_BOXING, 2492.4121,-2539.4854,13.6484,180.5055,0},
	{"Zomby_17", 45, FIGHT_STYLE_BOXING, 2352.8142,-2657.3120,13.6641,90.2517,0},
	{"Zomby_18", 51, FIGHT_STYLE_BOXING, 1787.1633,-2105.5969,13.5469,90.4945,0},
    {"Zomby_19", 57, FIGHT_STYLE_BOXING, 1898.6639,-2044.9250,13.5391,270.1486,0},
    {"Zomby_20", 82, FIGHT_STYLE_BOXING, 1561.8365,-1809.5038,13.5469,0.8074,0},
    {"Zomby_21", 41, FIGHT_STYLE_BOXING, 1394.9033,-1978.8240,38.9383,80.2145,0},
    {"Zomby_22", 36, FIGHT_STYLE_BOXING, 1363.7147,-2062.9316,56.4625,90.8993,0},
    {"Zomby_23", 90, FIGHT_STYLE_BOXING, 977.8323,-2156.4092,13.0859,354.2509,0},
    {"Zomby_24", 196, FIGHT_STYLE_BOXING, 741.9531,-1857.4498,7.5391,270.8773,0},
    {"Zomby_25", 1, FIGHT_STYLE_BOXING, 603.9210,-1849.9021,5.6328,90.0899,0},
    {"Zomby_26", 76, FIGHT_STYLE_BOXING, 318.7112,-1887.4933,1.9245,85.3951,0},
    {"Zomby_27", 77, FIGHT_STYLE_BOXING, 152.7257,-1845.0684,3.7734,0.4836,0},
    {"Zomby_28", 88, FIGHT_STYLE_BOXING, 177.4322,-1496.0409,12.5709,324.5444,0},
    {"Zomby_29", 99, FIGHT_STYLE_BOXING, 424.7956,-1321.6266,15.0034,305.5220,0},
    {"Zomby_30", 100, FIGHT_STYLE_BOXING, 642.9724,-1241.5078,17.7261,182.0993,0},
    {"Zomby_31", 101, FIGHT_STYLE_BOXING, 667.9777,-1168.1235,15.5562,331.0385,0},
    {"Zomby_32", 102, FIGHT_STYLE_BOXING, 863.1838,-1132.6553,23.8281,269.7627,0},
    {"Zomby_33", 103, FIGHT_STYLE_BOXING, 1075.0334,-1128.4857,23.9014,359.6927,0},
    {"Zomby_34", 104, FIGHT_STYLE_BOXING, 1187.4536,-1299.2046,13.5481,181.1276,0},
   	{"Zomby_35", 177, FIGHT_STYLE_BOXING, 2176.4783,-1742.8016,13.5469,356.4384,0},
	{"Zomby_36", 278, FIGHT_STYLE_BOXING, 2231.7578,-1724.0999,13.5559,270.4745,0},
	{"Zomby_37", 264, FIGHT_STYLE_BOXING, 2517.8650,-2008.7996,13.2813,90.3785,0},
	{"Zomby_38", 170, FIGHT_STYLE_BOXING, 2335.0234,-1548.8733,23.9974,0.4858,0},
	{"Zomby_39", 160, FIGHT_STYLE_BOXING, 2363.9253,-1373.2711,24.0129,0.7286,0},
	{"Zomby_40", 158, FIGHT_STYLE_BOXING, 2260.2737,-1308.6377,23.9844,90.4968,0},
	{"Zomby_41", 149, FIGHT_STYLE_BOXING, 2247.5181,-1376.7397,23.9804,90.6145,0},
	{"Zomby_42", 273, FIGHT_STYLE_BOXING, 2139.2954,-1376.5815,23.9844,91.6668,0},
	{"Zomby_43", 300, FIGHT_STYLE_BOXING, 2052.1946,-1348.7114,23.9844,90.6587,0},
	{"Zomby_44", 12, FIGHT_STYLE_BOXING, 2054.8513,-1268.5797,23.9844,90.0920,0},
	{"Zomby_45", 305, FIGHT_STYLE_BOXING, 1319.8391,-1745.9955,13.5469,179.1982,0},
	{"Zomby_46", 291, FIGHT_STYLE_BOXING, 1829.7932,-1923.6587,13.5469,1.1936,0},
	{"Zomby_47", 304, FIGHT_STYLE_BOXING, 2092.9392,-1902.8859,13.5469,270.4538,0},
	{"Zomby_48", 303, FIGHT_STYLE_BOXING, 2509.4226,-1822.3273,13.5391,179.0526,0},
	{"Zomby_49", 172, FIGHT_STYLE_BOXING, 2523.4680,-1834.0782,13.5469,179.3660,0},
	{"Zomby_50", 215, FIGHT_STYLE_BOXING, 2542.7017,-1925.9927,13.5469,269.6070,0},
	{"Zomby_51", 152, FIGHT_STYLE_BOXING, 2081.7803,-1760.1702,13.5625,89.3426,0},
	/////////////////////////////////////////////////////////////////////////////

	///////////////////////////////ЛАС-ВЕНТУРАС///////////////////////////////////
	{"Zomby_52", 1, FIGHT_STYLE_BOXING, 1250.5149,790.0477,10.8203,93.0426,0},
	{"Zomby_53", 2, FIGHT_STYLE_BOXING, 1500.2626,955.2888,10.8203,0.5670,0},
	{"Zomby_54", 3, FIGHT_STYLE_BOXING, 1879.1792,940.6086,10.8203,270.7180,0},
	{"Zomby_55", 4, FIGHT_STYLE_BOXING, 2119.1450,980.9487,10.8203,270.7181,0},
	{"Zomby_56", 5, FIGHT_STYLE_BOXING, 2339.4934,1025.9950,10.8203,359.8387,0},
	{"Zomby_57", 6, FIGHT_STYLE_BOXING, 2450.0581,960.3638,10.8203,269.5849,0},
	{"Zomby_58", 7, FIGHT_STYLE_BOXING, 2591.1453,1185.2911,10.8203,89.1213,0},
	{"Zomby_59", 8, FIGHT_STYLE_BOXING, 2380.1509,1200.2634,10.8203,89.7689,0},
	{"Zomby_60", 9, FIGHT_STYLE_BOXING, 2175.8252,1365.7859,10.8203,270.3943,0},
	{"Zomby_61", 10, FIGHT_STYLE_BOXING, 2258.4863,1525.7576,10.8203,269.7465,0},
	{"Zomby_62", 11, FIGHT_STYLE_BOXING, 2421.8279,1620.3629,10.7881,89.9308,0},
	{"Zomby_63", 12, FIGHT_STYLE_BOXING, 2499.1208,1729.1166,10.8203,0.2434,0},
	{"Zomby_64", 13, FIGHT_STYLE_BOXING, 2446.6216,1965.3469,10.8203,90.2545,0},
	{"Zomby_65", 14, FIGHT_STYLE_BOXING, 2535.0581,2187.2302,10.8203,0.4051,0},
	{"Zomby_66", 15, FIGHT_STYLE_BOXING, 2454.1348,2421.1238,10.8125,90.3351,0},
	{"Zomby_67", 16, FIGHT_STYLE_BOXING, 2209.7527,2445.8345,10.8203,90.0922,0},
	{"Zomby_68", 17, FIGHT_STYLE_BOXING, 2020.2131,2508.4021,11.8385,0.1622,0},
	{"Zomby_69", 18, FIGHT_STYLE_BOXING, 1979.7169,2635.9048,10.8203,89.6067,0},
	{"Zomby_70", 19, FIGHT_STYLE_BOXING, 1670.8789,2725.3127,10.8203,90.0923,0},
	{"Zomby_71", 20, FIGHT_STYLE_BOXING, 1345.3442,2581.9526,10.8203,89.8861,0},
	{"Zomby_72", 21, FIGHT_STYLE_BOXING, 1398.5051,2320.4431,10.8203,270.1880,0},
	{"Zomby_73", 22, FIGHT_STYLE_BOXING, 1519.5756,2143.1763,10.8203,180.4196,0},
	{"Zomby_74", 23, FIGHT_STYLE_BOXING, 1495.3964,1948.0508,10.8203,180.2575,0},
	{"Zomby_75", 24, FIGHT_STYLE_BOXING, 1395.0160,1968.8717,10.6779,0.3164,0},
	{"Zomby_76", 25, FIGHT_STYLE_BOXING, 1015.3405,1838.1201,10.8203,0.3973,0},
	{"Zomby_77", 26, FIGHT_STYLE_BOXING, 999.4326,1705.9674,10.9219,179.8528,0},
	{"Zomby_78", 27, FIGHT_STYLE_BOXING, 1014.6409,1507.3297,10.8203,180.0147,0},
	{"Zomby_79", 28, FIGHT_STYLE_BOXING, 999.9213,1314.9604,10.8203,180.3384,0},
	{"Zomby_80", 29, FIGHT_STYLE_BOXING, 1045.2173,1185.9701,10.8203,270.2686,0},
	{"Zomby_81", 30, FIGHT_STYLE_BOXING, 1333.4371,1185.1455,10.8203,270.2686,0},
	{"Zomby_82", 31, FIGHT_STYLE_BOXING, 1466.2374,1140.4878,10.8203,269.7831,0},
	{"Zomby_83", 32, FIGHT_STYLE_BOXING, 1588.0394,1140.4592,10.8125,269.5400,0},
	{"Zomby_84", 33, FIGHT_STYLE_BOXING, 1688.5476,1140.3832,10.8203,269.8637,0},
	{"Zomby_85", 34, FIGHT_STYLE_BOXING, 1831.5267,1265.4098,12.6282,89.4000,0},
	{"Zomby_86", 35, FIGHT_STYLE_BOXING, 1886.8296,1280.5950,10.8203,270.4299,0},
	{"Zomby_87", 36, FIGHT_STYLE_BOXING, 1981.0396,1460.3553,10.8203,90.4520,0},
	{"Zomby_89", 37, FIGHT_STYLE_BOXING, 2015.8407,1700.1545,10.8203,89.3997,0},
	{"Zomby_90", 38, FIGHT_STYLE_BOXING, 2103.3291,2029.3054,10.8203,89.6425,0},
	{"Zomby_91", 39, FIGHT_STYLE_BOXING, 2109.7253,2105.0999,10.8203,89.6424,0},
	{"Zomby_92", 40, FIGHT_STYLE_BOXING, 2046.8573,2275.7983,10.8203,90.0029,0},
	{"Zomby_93", 41, FIGHT_STYLE_BOXING, 1919.6548,2306.3672,10.8203,179.4474,0},
	{"Zomby_94", 42, FIGHT_STYLE_BOXING, 1802.6858,2280.0271,12.5896,90.8934,0},
	{"Zomby_95", 43, FIGHT_STYLE_BOXING, 1728.6693,2310.1016,10.8203,8.0055,0},
	{"Zomby_96", 44, FIGHT_STYLE_BOXING, 1616.2184,2266.4893,10.8203,89.5983,0},
	{"Zomby_97", 45, FIGHT_STYLE_BOXING, 398.8468,1915.5275,17.6406,358.5465,0},
	{"Zomby_98", 46, FIGHT_STYLE_BOXING, 110.3911,2481.0620,16.4844,271.6281,0},
	{"Zomby_99", 47, FIGHT_STYLE_BOXING, 1376.6896,2581.6975,10.8203,89.7602,0},
	{"Zomby_100", 48, FIGHT_STYLE_BOXING, 1256.0396,2597.8669,10.8125,1.4490,0}
};
//

//Main publics
public OnFilterScriptInit()
{

	SetTimer("spawnNPC",1500,0); //через 1.5 секунды после загрузки скрипта начнем создавать бота
}
public OnFilterScriptExit()
{
    for (new npcid = 0; npcid < sizeof(npc); npcid++) { //при отгрузке скрипта, удаляем всех созданных нами ботов
		FCNPC_Destroy(npc[npcid][npc_ID]);
	}
	KillTimer(npc_timer); // при отгрузке скрипта, удаляем таймер, чтобы не было лишней нагрузки
    return 1;
}
//

//Main NPC Public
forward spawnNPC();
public spawnNPC()
{
	for (new npcid = 0; npcid < sizeof(npc); npcid++)
	{
  		npc[npcid][npc_ID] = FCNPC_Create(npc[npcid][npc_Name]); //присваиваем имя нашему боту то, что мы ввели в enum'е
  		FCNPC_Spawn(npc[npcid][npc_ID], npc[npcid][npc_Skin], npc[npcid][npc_X], npc[npcid][npc_Y], npc[npcid][npc_Z]); //создаем бота со скином и координатами по x,y,z, указанными в enum'е
  		SetPlayerFightingStyle(npc[npcid][npc_ID], npc[npcid][npc_FightStyle]); //задаем боту стиль боя, указанный в enum'е
  		FCNPC_Stop(npc[npcid][npc_ID]); //так как плагин связан с хаком памяти, боты вначале при подгрузке могут делать странные вещи, случайная анимация или атака, убираем всё это
  		FCNPC_StopAttack(npc[npcid][npc_ID]); //тоже самое, что и строка выше
  		FCNPC_SetWeapon(npc[npcid][npc_ID],npc[npcid][weaponnpcid]); //выдаем боту оружие, согласно enum'у
  		FCNPC_SetQuaternion(npc[npcid][npc_ID],0.0,0.0,0.0,0.0); //кватернион - угол поворота в пространстве, чтобы наш бот заспавнился "нормально", то есть с 0 углами наклона относительно осей
  		FCNPC_SetAngle(npc[npcid][npc_ID], npc[npcid][npc_A]); //задаем боту угол поворота, согласно enum'у, важно, чтобы данная строка стояли только после кватерниона
	}
	{
	npc_timer = SetTimer("npc_timer_public",100,1);
	}
	for (new npcid = 0; npcid < sizeof(npc); npcid++) {
	SetPVarFloat(npc[npcid][npc_ID],"x",npc[npcid][npc_X]);
	SetPVarFloat(npc[npcid][npc_ID],"y",npc[npcid][npc_Y]);
	SetPVarFloat(npc[npcid][npc_ID],"z",npc[npcid][npc_Z]); //запоминаем координаты спавна для NPC
	SetPVarInt(npc[npcid][npc_ID],"condition",0); //задаем для NPC из первой строчки значение pvar'а состояния равным одному
	//создаем таймер с глобальной переменной, в котором будут обновляться действия NPC каждые 100 миллисекунд
}
}
//

//Нахождения расстояния между NPC и игроком
static stock GetClosestPlayer(playerid, &Float:cdist)
{
	new cid = INVALID_PLAYER_ID;
	new Float:dist;
	new Float:x,Float:y,Float:z;
	new Float:mx,Float:my,Float:mz;

	cdist = 65000.0;
	GetPlayerPos(playerid,mx,my,mz);

	for(new i = GetMaxPlayers();i >= 0;i--)
	{
		if(playerid == i) continue;
		if(!IsPlayerConnected(i)) continue;
		if (IsPlayerNPC(i)) continue;
		GetPlayerPos(i,x,y,z);
		x -= mx;
		y -= my;
		z -= mz;

		dist = floatsqroot(x*x + y*y + z*z);

		if(dist < cdist)
		{
			cdist = dist;
			cid = i;
		}
	}

	return cid;
}
//

//Сток для разворота NPC лицом к игроку
stock FCNPC_Player_Angle(npcid, playerid)
{
	new Float:player_pos[3];
	GetPlayerPos(playerid, player_pos[0], player_pos[1], player_pos[2]);

	new Float:npc_pos[3];
	FCNPC_GetPosition(npcid, npc_pos[0], npc_pos[1], npc_pos[2]);

	FCNPC_SetAngle(npcid, 180.0 - atan2(npc_pos[0] - player_pos[0], npc_pos[1] - player_pos[1]));
	return 1;
}
//


//Паблик обновления действий NPC
forward npc_timer_public();
public npc_timer_public()
{
    for (new npcid = 0; npcid < sizeof(npc); npcid++) {
	new Float:dist; //переменная дистанции, которая будет использована для определения расстояния между NPC и ближайшим к нему игроком
    new pid = GetClosestPlayer(npc[npcid][npc_ID],dist); //находим ближайшего игрока к NPC и получаем дистанцию между ними
    if(GetPlayerVirtualWorld(pid) == GetPlayerVirtualWorld(npc[npcid][npc_ID])) //если виртуальный мир игрока и бота одинаков
    {
  		if(GetPVarInt(npc[npcid][npc_ID],"condition")==0 && dist > 10.0) //если состояние равно единице и расстояние между ботом и игроком менее 25 метров
		{
	    	SetPVarInt(npc[npcid][npc_ID],"condition",1); //переключаем состояние боту
	    	CallLocalFunction("FCNPC_OnReachDestination", "i", npc[npcid][npc_ID]); //посылаем в паблик
		}
		if(GetPVarInt(npc[npcid][npc_ID],"condition")==0 && dist < 10.0) //если состояние равно единице и расстояние между ботом и игроком менее 25 метров
		{
	    	SetPVarInt(npc[npcid][npc_ID],"condition",2); //переключаем состояние боту
		}
		if(GetPVarInt(npc[npcid][npc_ID],"condition")==1 && dist < 10.0) //если состояние равно единице и расстояние между ботом и игроком менее 25 метров
		{
	    	SetPVarInt(npc[npcid][npc_ID],"condition",2); //переключаем состояние боту
		}
		if(GetPVarInt(npc[npcid][npc_ID],"condition")==2 && dist < 10.0) //если состояние равно двум и расстояние между ботом и игроком менее 25 метров
		{
			new Float:x, Float:y, Float:z; //создаем переменные, в которые будем записывать координаты ближайшего игрока
			GetPlayerPos(pid,x,y,z); //записываем координаты ближайшего игрока
			FCNPC_GoTo(npc[npcid][npc_ID],x,y,z,MOVE_TYPE_RUN,0,0); //направляем нашего NPC по координатам игрока бегом
		}
		if(GetPVarInt(npc[npcid][npc_ID],"condition")==2 && dist < 0.8) //если состояние равно двум и расстояние между ботом и игроком менее 0.8 метров
		{
			SetPVarInt(npc[npcid][npc_ID],"condition",3); //переключаем состояние боту
		}
		if(GetPVarInt(npc[npcid][npc_ID],"condition")==3 && dist < 0.8) //если состояние равно трем и расстояние между ботом и игроком менее 0.8 метров
		{
			FCNPC_Player_Angle(npc[npcid][npc_ID], pid); //разворачиваем NPC лицом к игроку
			switch(random(3)) // заставляем бота использовать одну из трех комбинаций кнопок, случайный образом: 2 комбинации атаки и один блок
			{
				case 0: FCNPC_SetKeys(npc[npcid][npc_ID],KEY_HANDBRAKE+KEY_FIRE);
				case 1: FCNPC_SetKeys(npc[npcid][npc_ID],KEY_HANDBRAKE+KEY_SECONDARY_ATTACK);
				case 2: FCNPC_SetKeys(npc[npcid][npc_ID],KEY_HANDBRAKE+KEY_JUMP);
			}
		}
		if(GetPVarInt(npc[npcid][npc_ID],"condition")==3 && dist > 0.8) //если состояние равно трем и расстояние между ботом и игроком более 0.8 метров
		{
			SetPVarInt(npc[npcid][npc_ID],"condition",2); //переключаем расстояние
		}
		if(dist > 25.0 && GetPVarInt(npc[npcid][npc_ID],"condition")==2) // если состояние равно двум и дистанция более 25 метров
		{
	    	SetPVarInt(npc[npcid][npc_ID],"condition",4); //переключаем состояние
	    	FCNPC_Stop(npc[npcid][npc_ID]); //останавливаем бота
	    	new Float:x, Float:y, Float:z;
	    	FCNPC_GetPosition(npc[npcid][npc_ID],x,y,z);
	    	SetPVarFloat(npc[npcid][npc_ID],"x",x), SetPVarFloat(npc[npcid][npc_ID],"y",y), SetPVarFloat(npc[npcid][npc_ID],"z",z);
	    	SetPVarInt(npc[npcid][npc_ID],"condition",1);
	    	CallLocalFunction("FCNPC_OnReachDestination", "i", npc[npcid][npc_ID]); //посылаем в паблик
	    	}
		}
	}
}
//



//Паблик проверяется тогда, когда NPC завершил перемещение
public FCNPC_OnReachDestination(npcid)
{
	if(GetPVarInt(npcid,"condition")==1)
	{
	    new Float:distance;
    	distance = GetPlayerDistanceFromPoint(npcid, GetPVarFloat(npcid,"x"),GetPVarFloat(npcid,"y"),GetPVarFloat(npcid,"z"));
    	if(distance > 20.0)
		{
			FCNPC_GoTo(npcid,GetPVarFloat(npcid,"x"),GetPVarFloat(npcid,"y"),GetPVarFloat(npcid,"z"),MOVE_TYPE_WALK,0.0,0);
		}
    	else if(distance <20.0)
		{
		    new Float:x, Float:y, Float:z;
		    FCNPC_GetPosition(npcid,x,y,z);
		    x += (21.0 * floatsin(-FCNPC_GetAngle(npcid), degrees));
			y += (21.0 * floatcos(-FCNPC_GetAngle(npcid), degrees));
			FCNPC_GoTo(npcid,x,y,z,MOVE_TYPE_WALK,0.0,0);
		}
	}
	
}
//

// Паблик получения урона, используется как для игроков, так и для NPC
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if (IsPlayerNPC(damagedid) && GetPVarInt(damagedid,"evade")!=1) //если тот, кто получил урон это NPC и у него нет иммунитета к урону
	{
	    if(GetPlayerWeapon(playerid) ==0) // если оружие игрока - кулаки
	    {
	        FCNPC_SetHealth(damagedid, FCNPC_GetHealth(damagedid) - 5.0); // задаем боту жизней столько, сколько у него и было минус 5 единиц
	    }
	}
}
//

//Паблик вызывается, когда NPC умирает
public FCNPC_OnDeath(npcid)
{
	if(GetPVarInt(npcid,"condition")!=0)
	{
	    DeletePVar(npcid,"condition"); // удаляем pvar, чтобы нагрузка не шла, когда NPC мертв
	}
	SetTimerEx("hidebody",7500,0,"i",npcid); //создаем специализированный одноразовый таймер для того, чтобы скрыть тело бота
	SetTimerEx("respawn",15000,0,"i",npcid); //создаем специализированный одноразовый таймер для того, чтобы воскресить бота
}
//

//Скрываем тело NPC в другом виртуальном мире, чтобы не кикать его с сервера
forward hidebody(npcid);
public hidebody(npcid)
{
	SetPlayerVirtualWorld(npcid,1); //посылаем NPC в 1ый виртуальный мир (по стандарту все игроки находят в нулевом)
}
//

//Воскрешаем NPC и возвращаем его в мир игроков
forward respawn(npcid);
public respawn(npcid)
{
	DeletePVar(npcid,"evade"); //удаляем пвар убегания на всякий случай
	SetPVarInt(npcid,"condition",2); //так как мы будем респавнить бота с той позиции, на которой он умер, задаем второе состояние, чтобы в случае чего, бот убежал на точку появления
	FCNPC_Respawn(npcid); //воскрешаем бота
	SetPlayerVirtualWorld(npcid,0); //посылаем NPC в мир к игрокам
}
//

//Паблик, срабатывающий на команды
public OnPlayerCommandText(playerid, cmdtext[])
{
    if (!strcmp(cmdtext, "/teleport", true)) {
        new Float:x, Float:y, Float:z;
        FCNPC_GetPosition(npc[0][npc_ID],x,y,z);
        SetPlayerPos(playerid,x,y,z);
		return 1;
	}
	if (!strcmp(cmdtext, "/tp", true)) {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid,x,y,z);
        FCNPC_SetPosition(npc[0][npc_ID],x+2.0,y,z);
		return 1;
	}
	return 0;
}
//
