/*Система домов

HouseInfo - максимально допустимое кол-во домов
Найдите GetPlayerHouseInterior и SetPlayerHouseInterior, там я расписал как делать интерьеры, если не разберётесь пишите на samp-rus
*/
#define MAX_HOUSE 150	//Максимальное кол-во домов
enum hInfo
{
	hOwner,				//ID банды-владельца
	hPrice,				//Цена дома
	Float:hOutPos_x,	//Позиция X снаружи
	Float:hOutPos_y,	//Позиция Y снаружи
	Float:hOutPos_z,	//Позиция Z снаружи
	Float:hOutAngle,	//Поворот игрока снаружи
	hHouseInterior,		//"Наш" интерьер
	hLocked,			//Замок закрыт
	//Не сохраняются
	hPickup,//Пикап от дома
	Text3D:hLabel,//Надпись над домом
};
new HouseInfo[MAX_HOUSE][hInfo];
stock SetPlayerHouseInterior(playerid,interiorid)
{
	if(interiorid == 0)
	{
	    SetPlayerInterior(playerid,2);
	    SetPlayerPos(playerid,2468.3701,-1698.1267,1013.5078);
	    SetPlayerFacingAngle(playerid,87.0940);
	}
	else if(interiorid == 1)
	{
	    SetPlayerInterior(playerid,3);
	    SetPlayerPos(playerid,2495.9368,-1692.6628,1014.7422);
	    SetPlayerFacingAngle(playerid,182.3483);

	}
	else if(interiorid == 2)
	{
	    SetPlayerInterior(playerid,5);
	    SetPlayerPos(playerid,2233.8728,-1114.5892,1050.8828);
	    SetPlayerFacingAngle(playerid,2.7833);
	}
	else if(interiorid == 3)
	{
	    SetPlayerInterior(playerid,6);
	    SetPlayerPos(playerid,2196.2932,-1204.2164,1049.0234);
	    SetPlayerFacingAngle(playerid,92.0841);
	}
	else if(interiorid == 4)
	{
	    SetPlayerInterior(playerid,9);
	    SetPlayerPos(playerid,2318.0532,-1026.1620,1050.2109);
	    SetPlayerFacingAngle(playerid,4.3733);
	}
 	else if(interiorid == 5)
	{
	    SetPlayerInterior(playerid,10);
	    SetPlayerPos(playerid,2259.8894,-1135.5386,1050.6328);
	    SetPlayerFacingAngle(playerid,274.7826);
	}
	else if(interiorid == 6)
	{
	    SetPlayerInterior(playerid,8);
	    SetPlayerPos(playerid,2365.0913,-1134.9622,1050.8750);
	    SetPlayerFacingAngle(playerid,357.8401);
	}
	else if(interiorid == 7)
	{
	    SetPlayerInterior(playerid,11);
	    SetPlayerPos(playerid,2283.4558,-1139.5868,1050.8984);
	    SetPlayerFacingAngle(playerid,2.2268);
	}
	else if(interiorid == 8)
	{
	    SetPlayerInterior(playerid,1);
	    SetPlayerPos(playerid,2217.5801,-1075.7186,1050.4844);
	    SetPlayerFacingAngle(playerid,91.8410);
	}
	else if(interiorid == 9)
	{
	    SetPlayerInterior(playerid,1);
	    SetPlayerPos(playerid,244.2633,305.1776,999.1484);
	    SetPlayerFacingAngle(playerid,275.4327);
	}
	else if(interiorid == 10)
	{
	    SetPlayerInterior(playerid,2);
	    SetPlayerPos(playerid,267.0089,304.9504,999.1484);
	    SetPlayerFacingAngle(playerid,264.1527);
	}
	else if(interiorid == 11)
	{
	    SetPlayerInterior(playerid,3);
	    SetPlayerPos(playerid,235.4259,1187.1754,1080.2578);
	    SetPlayerFacingAngle(playerid,356.9470);
	}
	else if(interiorid == 12)
	{
	    SetPlayerInterior(playerid,2);
	    SetPlayerPos(playerid,226.3336,1240.0363,1082.1406);
	    SetPlayerFacingAngle(playerid,93.1412);
	}
	else if(interiorid == 13)
	{
	    SetPlayerInterior(playerid,1);
	    SetPlayerPos(playerid,223.3103,1287.3929,1082.1406);
	    SetPlayerFacingAngle(playerid,357.8870);
	}
	else if(interiorid == 14)
	{
	    SetPlayerInterior(playerid,5);
	    SetPlayerPos(playerid,226.7142,1114.3087,1080.9951);
	    SetPlayerFacingAngle(playerid,264.2462);
 	}
	else if(interiorid == 15)
	{
	    SetPlayerInterior(playerid,15);
	    SetPlayerPos(playerid,295.5774,1472.6558,1080.2578);
	    SetPlayerFacingAngle(playerid,0.1271);
	}
	else if(interiorid == 16)
	{
	    SetPlayerInterior(playerid,4);
	    SetPlayerPos(playerid,260.8918,1284.7347,1080.2578);
	    SetPlayerFacingAngle(playerid,354.3465);
	}
	else if(interiorid == 17)
	{
	    SetPlayerInterior(playerid,10);
	    SetPlayerPos(playerid,24.3465,1340.5371,1084.3750);
	    SetPlayerFacingAngle(playerid,4.0598);
	}
	else if(interiorid == 18)
	{
	    SetPlayerInterior(playerid,4);
	    SetPlayerPos(playerid,-260.9048,1456.7821,1084.3672);
	    SetPlayerFacingAngle(playerid,96.1806);
	}
	else if(interiorid == 19)
	{
	    SetPlayerInterior(playerid,5);
	    SetPlayerPos(playerid,140.3034,1366.3802,1083.8594);
	    SetPlayerFacingAngle(playerid,355.5997);
	}
	else if(interiorid == 20)
	{
	    SetPlayerInterior(playerid,6);
	    SetPlayerPos(playerid,-69.0937,1351.6519,1080.2109);
	    SetPlayerFacingAngle(playerid,359.0464);
	}
	else if(interiorid == 21)
	{
	    SetPlayerInterior(playerid,15);
	    SetPlayerPos(playerid,-284.1492,1470.7615,1084.3750);
	    SetPlayerFacingAngle(playerid,86.1539);
	}
	else if(interiorid == 22)
	{
	    SetPlayerInterior(playerid,8);
	    SetPlayerPos(playerid,-42.6183,1405.8876,1084.4297);
	    SetPlayerFacingAngle(playerid,0.0098);
	}
	else if(interiorid == 23)
	{
	    SetPlayerInterior(playerid,9);
	    SetPlayerPos(playerid,83.1937,1322.6996,1083.8662);
	    SetPlayerFacingAngle(playerid,356.5630);
	}
	else if(interiorid == 24)
	{
	    SetPlayerInterior(playerid,9);
	    SetPlayerPos(playerid,260.6850,1237.5959,1084.2578);
	    SetPlayerFacingAngle(playerid,349.7164);
	}
	//Интерьеры-объекты без объектов
	else if(interiorid == 25)
	{
	    SetPlayerInterior(playerid,101);
	    SetPlayerPos(playerid,92.5492,114.6084,197.2188);
	    SetPlayerFacingAngle(playerid,281.7228);
	}
	else if(interiorid == 26)
	{
	    SetPlayerInterior(playerid,102);
	    SetPlayerPos(playerid,101.9485,107.1089,201.0078);
	    SetPlayerFacingAngle(playerid,176.4418);
	}
	else if(interiorid == 27)
	{
	    SetPlayerInterior(playerid,103);
	    SetPlayerPos(playerid,98.7605,99.8216,199.1470);
	    SetPlayerFacingAngle(playerid,16.5187);
	}
	else if(interiorid == 28)
	{
	    SetPlayerInterior(playerid,104);
	    SetPlayerPos(playerid,105.8511,101.7744,196.3750);
	    SetPlayerFacingAngle(playerid,160.6768);
	}
	else if(interiorid == 29)//Не рабочий
	{
	    SetPlayerInterior(playerid,105);
	    SetPlayerPos(playerid,260.6850,1237.5959,1084.2578);
	    SetPlayerFacingAngle(playerid,349.7164);
	}
	else if(interiorid == 30)
	{
	    SetPlayerInterior(playerid,106);
	    SetPlayerPos(playerid,103.1474,93.3198,199.4297);
	    SetPlayerFacingAngle(playerid,358.3404);
	}
	else if(interiorid == 31)
	{
	    SetPlayerInterior(playerid,107);
	    SetPlayerPos(playerid,105.1231,93.8668,199.2031);
	    SetPlayerFacingAngle(playerid,3.2604);
	}
	else if(interiorid == 32)
	{
	    SetPlayerInterior(playerid,108);
	    SetPlayerPos(playerid,100.0235,96.7729,199.5000);
	    SetPlayerFacingAngle(playerid,6.6837);
	}
	else if(interiorid == 33)
	{
	    SetPlayerInterior(playerid,109);
	    SetPlayerPos(playerid,99.6681,89.3366,198.9410);
	    SetPlayerFacingAngle(playerid,359.4770);
	}
	else if(interiorid == 34)
	{
	    SetPlayerInterior(playerid,110);
	    SetPlayerPos(playerid,102.5989,86.9171,196.7031);
	    SetPlayerFacingAngle(playerid,356.6570);
	}
	else if(interiorid == 35)
	{
	    SetPlayerInterior(playerid,111);
	    SetPlayerPos(playerid,102.6533,86.5670,196.7031);
	    SetPlayerFacingAngle(playerid,359.4771);
	}
	else if(interiorid == 36)
	{
	    SetPlayerInterior(playerid,112);
	    SetPlayerPos(playerid,98.7225,109.6781,197.8214);
	    SetPlayerFacingAngle(playerid,182.8022);
	}
	else if(interiorid == 37)
	{
	    SetPlayerInterior(playerid,113);
	    SetPlayerPos(playerid,99.9912,91.8216,199.1953);
	    SetPlayerFacingAngle(playerid,356.0772);
	}
	else if(interiorid == 38)
	{
	    SetPlayerInterior(playerid,114);
	    SetPlayerPos(playerid,103.0633,94.2993,199.2656);
	    SetPlayerFacingAngle(playerid,83.8348);
	}
	else if(interiorid == 39)//Не рабочий
	{
	    SetPlayerInterior(playerid,115);
	    SetPlayerPos(playerid,260.6850,1237.5959,1084.2578);
	    SetPlayerFacingAngle(playerid,349.7164);
	}
	else if(interiorid == 40)
	{
	    SetPlayerInterior(playerid,116);
	    SetPlayerPos(playerid,98.9934,91.0892,199.2351);
	    SetPlayerFacingAngle(playerid,1.3526);
	}
	else if(interiorid == 41)
	{
	    SetPlayerInterior(playerid,117);
	    SetPlayerPos(playerid,98.9390,90.0368,199.5313);
	    SetPlayerFacingAngle(playerid,0.1226);
	}
	else if(interiorid == 42)
	{
	    SetPlayerInterior(playerid,118);
	    SetPlayerPos(playerid,109.3487,96.8932,199.4844);
	    SetPlayerFacingAngle(playerid,92.7485);
	}
	else if(interiorid == 43)
	{
	    SetPlayerInterior(playerid,119);
	    SetPlayerPos(playerid,108.7035,107.4051,199.4059);
	    SetPlayerFacingAngle(playerid,89.6151);
	}
	else if(interiorid == 44)
	{
	    SetPlayerInterior(playerid,120);
	    SetPlayerPos(playerid,103.0394,94.9384,201.0078);
	    SetPlayerFacingAngle(playerid,1.8809);
	}
	else if(interiorid == 45)
	{
	    SetPlayerInterior(playerid,121);
	    SetPlayerPos(playerid,83.5271,93.2593,199.3750);
	    SetPlayerFacingAngle(playerid,354.3700);
	}
	else if(interiorid == 46)
	{
	    SetPlayerInterior(playerid,122);
	    SetPlayerPos(playerid,104.3752,104.1811,199.2188);
	    SetPlayerFacingAngle(playerid,102.4710);
	}
	else if(interiorid == 47)
	{
	    SetPlayerInterior(playerid,123);
	    SetPlayerPos(playerid,104.6026,98.2819,199.0073);
	    SetPlayerFacingAngle(playerid,92.1309);
	}
	else if(interiorid == 48)
	{
	    SetPlayerInterior(playerid,124);
	    SetPlayerPos(playerid,96.7157,91.0210,194.5000);
	    SetPlayerFacingAngle(playerid,0.9735);
	}
	else if(interiorid == 49)
	{
	    SetPlayerInterior(playerid,125);
	    SetPlayerPos(playerid,97.2519,91.6240,197.0615);
	    SetPlayerFacingAngle(playerid,358.4668);
	}
	else if(interiorid == 50)
	{
	    SetPlayerInterior(playerid,126);
	    SetPlayerPos(playerid,99.9544,108.1927,199.7500);
	    SetPlayerFacingAngle(playerid,0.2019);
	}
	else if(interiorid == 51)
	{
	    SetPlayerInterior(playerid,127);
	    SetPlayerPos(playerid,100.2408,100.0931,199.0000);
	    SetPlayerFacingAngle(playerid,93.4312);
	}
	else if(interiorid == 52)
	{
	    SetPlayerInterior(playerid,128);
	    SetPlayerPos(playerid,100.8736,100.2769,199.1250);
	    SetPlayerFacingAngle(playerid,0.3937);
	}
	else if(interiorid == 53)
	{
	    SetPlayerInterior(playerid,129);
	    SetPlayerPos(playerid,108.4220,92.7676,194.5000);
	    SetPlayerFacingAngle(playerid,85.9343);
	}
	else if(interiorid == 54)
	{
	    SetPlayerInterior(playerid,130);
	    SetPlayerPos(playerid,103.3600,107.3253,199.0000);
	    SetPlayerFacingAngle(playerid,92.5144);
	}
	else if(interiorid == 55)
	{
	    SetPlayerInterior(playerid,131);
	    SetPlayerPos(playerid,97.7103,100.8397,199.0000);
	    SetPlayerFacingAngle(playerid,272.0795);
	}
	else if(interiorid == 56)
	{
	    SetPlayerInterior(playerid,132);
	    SetPlayerPos(playerid,96.7537,99.2769,199.0000);
	    SetPlayerFacingAngle(playerid,277.5512);
	}
	else if(interiorid == 57)
	{
	    SetPlayerInterior(playerid,133);
	    SetPlayerPos(playerid,97.9762,100.0432,199.7575);
	    SetPlayerFacingAngle(playerid,89.0910);
	}
	else if(interiorid == 58)
	{
	    SetPlayerInterior(playerid,134);
	    SetPlayerPos(playerid,96.2124,91.2678,197.0694);
	    SetPlayerFacingAngle(playerid,3.2603);
	}
	else if(interiorid == 59)
	{
	    SetPlayerInterior(playerid,135);
	    SetPlayerPos(playerid,105.9930,98.0533,201.0000);
	    SetPlayerFacingAngle(playerid,92.2244);
	}
	else if(interiorid == 60)
	{
	    SetPlayerInterior(playerid,136);
	    SetPlayerPos(playerid,97.5185,102.5553,199.0073);
	    SetPlayerFacingAngle(playerid,182.1753);
	}
	else if(interiorid == 61)
	{
	    SetPlayerInterior(playerid,137);
	    SetPlayerPos(playerid,102.2155,111.4793,199.7500);
	    SetPlayerFacingAngle(playerid,93.1877);
	}
	else if(interiorid == 62)
	{
	    SetPlayerInterior(playerid,138);
	    SetPlayerPos(playerid,104.4686,102.4698,199.00004);
	    SetPlayerFacingAngle(playerid,87.2577);
	}
	return 1;
}
stock GetPlayerHouseInterior(playerid)
{
	new Float:x,Float:y,Float:z, result = -1;
	GetPlayerPos(playerid,x,y,z);
	new interior = GetPlayerInterior(playerid);
	if(IsPlayerInRangeOfPoint(playerid,5,2468.3701,-1698.1267,1013.5078))//Сюда подставь координаты для 0 интерьера, которые ты записал выше
	result = 0;
	else if(IsPlayerInRangeOfPoint(playerid,5,2495.9368,-1692.6628,1014.7422))//Сюда подставь координаты для 1 интерьера, которые ты записал выше
	result = 1;
	else if(IsPlayerInRangeOfPoint(playerid,5,2233.8728,-1114.5892,1050.8828))//Сюда подставь координаты для 2 интерьера, которые ты записал выше
	result = 2;
 	else if(IsPlayerInRangeOfPoint(playerid,5,2196.2932,-1204.2164,1049.0234))//Сюда подставь координаты для 3 интерьера, которые ты записал выше
	result = 3;
	else if(IsPlayerInRangeOfPoint(playerid,5,2318.0532,-1026.1620,1050.2109))//Сюда подставь координаты для 4 интерьера, которые ты записал выше
	result = 4;
	else if(IsPlayerInRangeOfPoint(playerid,5,2259.8894,-1135.5386,1050.6328))//Сюда подставь координаты для 5 интерьера, которые ты записал выше
	result = 5;
	else if(IsPlayerInRangeOfPoint(playerid,5,2365.0913,-1134.9622,1050.8750))//Сюда подставь координаты для 6 интерьера, которые ты записал выше
	result = 6;
	else if(IsPlayerInRangeOfPoint(playerid,5,2283.4558,-1139.5868,1050.8984))//Сюда подставь координаты для 7 интерьера, которые ты записал выше
	result = 7;
	else if(IsPlayerInRangeOfPoint(playerid,5,2217.5801,-1075.7186,1050.4844))//Сюда подставь координаты для 8 интерьера, которые ты записал выше
	result = 8;
	else if(IsPlayerInRangeOfPoint(playerid,5,244.2633,305.1776,999.1484))//Сюда подставь координаты для 9 интерьера, которые ты записал выше
	result = 9;
 	else if(IsPlayerInRangeOfPoint(playerid,5,267.0089,304.9504,999.1484))//Сюда подставь координаты для 10 интерьера, которые ты записал выше
	result = 10;
 	else if(IsPlayerInRangeOfPoint(playerid,5,235.4259,1187.1754,1080.2578))//Сюда подставь координаты для 11 интерьера, которые ты записал выше
	result = 11;
 	else if(IsPlayerInRangeOfPoint(playerid,5,226.3336,1240.0363,1082.1406))//Сюда подставь координаты для 12 интерьера, которые ты записал выше
	result = 12;
 	else if(IsPlayerInRangeOfPoint(playerid,5,223.3103,1287.3929,1082.1406))//Сюда подставь координаты для 13 интерьера, которые ты записал выше
	result = 13;
 	else if(IsPlayerInRangeOfPoint(playerid,5,226.7142,1114.3087,1080.9951))//Сюда подставь координаты для 14интерьера, которые ты записал выше
	result = 14;
	else if(IsPlayerInRangeOfPoint(playerid,5,295.5774,1472.6558,1080.2578))//Сюда подставь координаты для 15 интерьера, которые ты записал выше
	result = 15;
	else if(IsPlayerInRangeOfPoint(playerid,5,260.8918,1284.7347,1080.2578))//Сюда подставь координаты для 16 интерьера, которые ты записал выше
	result = 16;
	else if(IsPlayerInRangeOfPoint(playerid,5,24.3465,1340.5371,1084.3750))//Сюда подставь координаты для 17 интерьера, которые ты записал выше
	result = 17;
	else if(IsPlayerInRangeOfPoint(playerid,5,-260.9048,1456.7821,1084.3672))//Сюда подставь координаты для 18 интерьера, которые ты записал выше
	result = 18;
	else if(IsPlayerInRangeOfPoint(playerid,5,140.3034,1366.3802,1083.8594))//Сюда подставь координаты для 19 интерьера, которые ты записал выше
	result = 19;
	else if(IsPlayerInRangeOfPoint(playerid,5,-69.0937,1351.6519,1080.2109))//Сюда подставь координаты для 20 интерьера, которые ты записал выше
	result = 20;
	else if(IsPlayerInRangeOfPoint(playerid,5,-284.1492,1470.7615,1084.3750))//Сюда подставь координаты для 21 интерьера, которые ты записал выше
	result = 21;
	else if(IsPlayerInRangeOfPoint(playerid,5,-42.6183,1405.8876,1084.4297))//Сюда подставь координаты для 22 интерьера, которые ты записал выше
	result = 22;
	else if(IsPlayerInRangeOfPoint(playerid,5,83.1937,1322.6996,1083.8662))//Сюда подставь координаты для 23 интерьера, которые ты записал выше
	result = 23;
	else if(IsPlayerInRangeOfPoint(playerid,5,260.6850,1237.5959,1084.2578))//Сюда подставь координаты для 24 интерьера, которые ты записал выше
	result = 24;
	//Интерьеры-объекты без объектов, у каждого из них интерьер > 100
	else if(IsPlayerInRangeOfPoint(playerid,5.0,92.5492,114.6084,197.2188) && interior == 101)//Сюда подставь координаты для 25 интерьера, которые ты записал выше
	result = 25;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,101.9485,107.1089,201.0078) && interior == 102)//Сюда подставь координаты для 26 интерьера, которые ты записал выше
	result = 26;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,98.7605,99.8216,199.1470) && interior == 103)//Сюда подставь координаты для 27 интерьера, которые ты записал выше
	result = 27;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,105.8511,101.7744,196.3750) && interior == 104)//Сюда подставь координаты для 28 интерьера, которые ты записал выше
	result = 28;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 105)//Сюда подставь координаты для 29 интерьера, которые ты записал выше
	result = 29;//пустой
	else if(IsPlayerInRangeOfPoint(playerid,5.0,103.1474,93.3198,199.4297) && interior == 106)//Сюда подставь координаты для 30 интерьера, которые ты записал выше
	result = 30;
	
	else if(IsPlayerInRangeOfPoint(playerid,5.0,105.1231,93.8668,199.2031) && interior == 107)//Сюда подставь координаты для 31 интерьера, которые ты записал выше
	result = 31;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0235,96.7729,199.5000) && interior == 108)//Сюда подставь координаты для 32 интерьера, которые ты записал выше
	result = 32;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,99.6681,89.3366,198.9410) && interior == 109)//Сюда подставь координаты для 33 интерьера, которые ты записал выше
	result = 33;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,102.5989,86.9171,196.7031) && interior == 110)//Сюда подставь координаты для 34 интерьера, которые ты записал выше
	result = 34;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,102.6533,86.5670,196.7031) && interior == 111)//Сюда подставь координаты для 35 интерьера, которые ты записал выше
	result = 35;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,98.7225,109.6781,197.8214) && interior == 112)//Сюда подставь координаты для 36 интерьера, которые ты записал выше
	result = 36;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,99.9912,91.8216,199.1953) && interior == 113)//Сюда подставь координаты для 37 интерьера, которые ты записал выше
	result = 37;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,103.0633,94.2993,199.2656) && interior == 114)//Сюда подставь координаты для 38 интерьера, которые ты записал выше
	result = 38;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,98.9934,91.0892,199.2351) && interior == 115)//Сюда подставь координаты для 39 интерьера, которые ты записал выше
	result = 39;//Пустой
	else if(IsPlayerInRangeOfPoint(playerid,5.0,98.9934,91.0892,199.2351) && interior == 116)//Сюда подставь координаты для 40 интерьера, которые ты записал выше
	result = 40;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,98.9390,90.0368,199.5313) && interior == 117)//Сюда подставь координаты для 41 интерьера, которые ты записал выше
	result = 41;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,109.3487,96.8932,199.4844) && interior == 118)//Сюда подставь координаты для 42 интерьера, которые ты записал выше
	result = 42;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,108.7035,107.4051,199.4059) && interior == 119)//Сюда подставь координаты для 43 интерьера, которые ты записал выше
	result = 43;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,103.0394,94.9384,201.0078) && interior == 120)//Сюда подставь координаты для 44 интерьера, которые ты записал выше
	result = 44;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,83.5271,93.2593,199.3750) && interior == 121)//Сюда подставь координаты для 45 интерьера, которые ты записал выше
	result = 45;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,104.3752,104.1811,199.2188) && interior == 122)//Сюда подставь координаты для 46 интерьера, которые ты записал выше
	result = 46;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,104.6026,98.2819,199.0073) && interior == 123)//Сюда подставь координаты для 47 интерьера, которые ты записал выше
	result = 47;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,96.7157,91.0210,194.5000) && interior == 124)//Сюда подставь координаты для 48 интерьера, которые ты записал выше
	result = 48;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,97.2519,91.6240,197.0615) && interior == 125)//Сюда подставь координаты для 49 интерьера, которые ты записал выше
	result = 49;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,99.9544,108.1927,199.7500) && interior == 126)//Сюда подставь координаты для 550 интерьера, которые ты записал выше
	result = 50;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.2408,100.0931,199.0000) && interior == 127)//Сюда подставь координаты для 51 интерьера, которые ты записал выше
	result = 51;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.8736,100.2769,199.1250) && interior == 128)//Сюда подставь координаты для 52 интерьера, которые ты записал выше
	result = 52;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,108.4220,92.7676,194.5000) && interior == 129)//Сюда подставь координаты для 53 интерьера, которые ты записал выше
	result = 53;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,103.3600,107.3253,199.0000) && interior == 130)//Сюда подставь координаты для 54 интерьера, которые ты записал выше
	result = 54;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,97.7103,100.8397,199.0000) && interior == 131)//Сюда подставь координаты для 55 интерьера, которые ты записал выше
	result = 55;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,96.7537,99.2769,199.0000) && interior == 132)//Сюда подставь координаты для 56 интерьера, которые ты записал выше
	result = 56;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,97.9762,100.0432,199.7575) && interior == 133)//Сюда подставь координаты для 57 интерьера, которые ты записал выше
	result = 57;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,96.2124,91.2678,197.0694) && interior == 134)//Сюда подставь координаты для 58 интерьера, которые ты записал выше
	result = 58;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,105.9930,98.0533,201.0000) && interior == 135)//Сюда подставь координаты для 59 интерьера, которые ты записал выше
	result = 59;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,97.5185,102.5553,199.0073) && interior == 136)//Сюда подставь координаты для 60 интерьера, которые ты записал выше
	result = 60;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,102.2155,111.4793,199.7500) && interior == 137)//Сюда подставь координаты для 61 интерьера, которые ты записал выше
	result = 61;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,104.4686,102.4698,199.0000) && interior == 138)//Сюда подставь координаты для 62 интерьера, которые ты записал выше
	result = 62;


	return result;
}
stock GetPlayerHouse(playerid)
{
	new Float:x,Float:y,Float:z, result = -1;
	GetPlayerPos(playerid,x,y,z);//Будем узнавать координаты и интерьер игрока
	new interior = GetPlayerInterior(playerid);
	if(IsPlayerInRangeOfPoint(playerid,100,2468.3701,-1698.1267,1013.5078) && interior == 2)//Сюда подставь координаты для 0 интерьера, которые ты записал выше
	result = 0;
	else if(IsPlayerInRangeOfPoint(playerid,100,2495.9368,-1692.6628,1014.7422) && interior == 3)//Сюда подставь координаты для 1 интерьера, которые ты записал выше
	result = 1;
	else if(IsPlayerInRangeOfPoint(playerid,100,2233.8728,-1114.5892,1050.8828) && interior == 5)//Сюда подставь координаты для 2 интерьера, которые ты записал выше
	result = 2;
 	else if(IsPlayerInRangeOfPoint(playerid,100,2196.2932,-1204.2164,1049.0234) && interior == 6)//Сюда подставь координаты для 3 интерьера, которые ты записал выше
	result = 3;
	else if(IsPlayerInRangeOfPoint(playerid,100,2318.0532,-1026.1620,1050.2109) && interior == 9)//Сюда подставь координаты для 4 интерьера, которые ты записал выше
	result = 4;
	else if(IsPlayerInRangeOfPoint(playerid,100,2259.8894,-1135.5386,1050.6328) && interior == 10)//Сюда подставь координаты для 5 интерьера, которые ты записал выше
	result = 5;
	else if(IsPlayerInRangeOfPoint(playerid,100,2365.0913,-1134.9622,1050.8750) && interior == 8)//Сюда подставь координаты для 6 интерьера, которые ты записал выше
	result = 6;
	else if(IsPlayerInRangeOfPoint(playerid,100,2283.4558,-1139.5868,1050.8984) && interior == 11)//Сюда подставь координаты для 7 интерьера, которые ты записал выше
	result = 7;
	else if(IsPlayerInRangeOfPoint(playerid,100,2217.5801,-1075.7186,1050.4844) && interior == 1)//Сюда подставь координаты для 8 интерьера, которые ты записал выше
	result = 8;
	else if(IsPlayerInRangeOfPoint(playerid,100,244.2633,305.1776,999.1484) && interior == 1)//Сюда подставь координаты для 9 интерьера, которые ты записал выше
	result = 9;
 	else if(IsPlayerInRangeOfPoint(playerid,100,267.0089,304.9504,999.1484) && interior == 2)//Сюда подставь координаты для 10 интерьера, которые ты записал выше
	result = 10;
 	else if(IsPlayerInRangeOfPoint(playerid,100,235.4259,1187.1754,1080.2578) && interior == 3)//Сюда подставь координаты для 11 интерьера, которые ты записал выше
	result = 11;
 	else if(IsPlayerInRangeOfPoint(playerid,100,226.3336,1240.0363,1082.1406) && interior == 2)//Сюда подставь координаты для 12 интерьера, которые ты записал выше
	result = 12;
 	else if(IsPlayerInRangeOfPoint(playerid,100,223.3103,1287.3929,1082.1406) && interior == 1)//Сюда подставь координаты для 13 интерьера, которые ты записал выше
	result = 13;
 	else if(IsPlayerInRangeOfPoint(playerid,100,226.7142,1114.3087,1080.9951) && interior == 5)//Сюда подставь координаты для 14 интерьера, которые ты записал выше
	result = 14;
	else if(IsPlayerInRangeOfPoint(playerid,100,295.5774,1472.6558,1080.2578) && interior == 15)//Сюда подставь координаты для 15 интерьера, которые ты записал выше
	result = 15;
	else if(IsPlayerInRangeOfPoint(playerid,100,260.8918,1284.7347,1080.2578) && interior == 4)//Сюда подставь координаты для 16 интерьера, которые ты записал выше
	result = 16;
	else if(IsPlayerInRangeOfPoint(playerid,100,24.3465,1340.5371,1084.3750) && interior == 10)//Сюда подставь координаты для 17 интерьера, которые ты записал выше
	result = 17;
	else if(IsPlayerInRangeOfPoint(playerid,100,-260.9048,1456.7821,1084.3672) && interior == 4)//Сюда подставь координаты для 18 интерьера, которые ты записал выше
	result = 18;
	else if(IsPlayerInRangeOfPoint(playerid,100,140.3034,1366.3802,1083.8594) && interior == 5)//Сюда подставь координаты для 19 интерьера, которые ты записал выше
	result = 19;
	else if(IsPlayerInRangeOfPoint(playerid,100,-69.0937,1351.6519,1080.2109) && interior == 6)//Сюда подставь координаты для 20 интерьера, которые ты записал выше
	result = 20;
	else if(IsPlayerInRangeOfPoint(playerid,100,-284.1492,1470.7615,1084.3750) && interior == 15)//Сюда подставь координаты для 21 интерьера, которые ты записал выше
	result = 21;
	else if(IsPlayerInRangeOfPoint(playerid,100,-42.6183,1405.8876,1084.4297) && interior == 8)//Сюда подставь координаты для 22 интерьера, которые ты записал выше
	result = 22;
	else if(IsPlayerInRangeOfPoint(playerid,100,83.1937,1322.6996,1083.8662) && interior == 9)//Сюда подставь координаты для 23 интерьера, которые ты записал выше
	result = 23;
	else if(IsPlayerInRangeOfPoint(playerid,100,260.6850,1237.5959,1084.2578) && interior == 9)//Сюда подставь координаты для 24 интерьера, которые ты записал выше
	result = 24;
	//Интерьеры-объекты без объектов, у каждого из них интерьер > 100
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 101)//Сюда подставь координаты для 25 интерьера, которые ты записал выше
	result = 25;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 102)//Сюда подставь координаты для 26 интерьера, которые ты записал выше
	result = 26;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 103)//Сюда подставь координаты для 27 интерьера, которые ты записал выше
	result = 27;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 104)//Сюда подставь координаты для 28 интерьера, которые ты записал выше
	result = 28;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 105)//Сюда подставь координаты для 29 интерьера, которые ты записал выше
	result = 29;//Не рабочий
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 106)//Сюда подставь координаты для 30 интерьера, которые ты записал выше
	result = 30;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 107)//Сюда подставь координаты для 31 интерьера, которые ты записал выше
	result = 31;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 108)//Сюда подставь координаты для 32 интерьера, которые ты записал выше
	result = 32;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 109)//Сюда подставь координаты для 33 интерьера, которые ты записал выше
	result = 33;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 110)//Сюда подставь координаты для 34 интерьера, которые ты записал выше
	result = 34;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 111)//Сюда подставь координаты для 35 интерьера, которые ты записал выше
	result = 35;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 112)//Сюда подставь координаты для 36 интерьера, которые ты записал выше
	result = 36;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 113)//Сюда подставь координаты для 37 интерьера, которые ты записал выше
	result = 37;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 114)//Сюда подставь координаты для 38 интерьера, которые ты записал выше
	result = 38;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 115)//Сюда подставь координаты для 39 интерьера, которые ты записал выше
	result = 39;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 116)//Сюда подставь координаты для 40 интерьера, которые ты записал выше
	result = 40;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 117)//Сюда подставь координаты для 41 интерьера, которые ты записал выше
	result = 41;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 118)//Сюда подставь координаты для 42 интерьера, которые ты записал выше
	result = 42;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 119)//Сюда подставь координаты для 43 интерьера, которые ты записал выше
	result = 43;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 120)//Сюда подставь координаты для 44 интерьера, которые ты записал выше
	result = 44;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 121)//Сюда подставь координаты для 45 интерьера, которые ты записал выше
	result = 45;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 122)//Сюда подставь координаты для 46 интерьера, которые ты записал выше
	result = 46;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 123)//Сюда подставь координаты для 47 интерьера, которые ты записал выше
	result = 47;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 124)//Сюда подставь координаты для 48 интерьера, которые ты записал выше
	result = 48;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 125)//Сюда подставь координаты для 49 интерьера, которые ты записал выше
	result = 49;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 126)//Сюда подставь координаты для 50 интерьера, которые ты записал выше
	result = 50;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 127)//Сюда подставь координаты для 51 интерьера, которые ты записал выше
	result = 51;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 128)//Сюда подставь координаты для 52 интерьера, которые ты записал выше
	result = 52;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 129)//Сюда подставь координаты для 53 интерьера, которые ты записал выше
	result = 53;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 130)//Сюда подставь координаты для 54 интерьера, которые ты записал выше
	result = 54;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 131)//Сюда подставь координаты для 55 интерьера, которые ты записал выше
	result = 55;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 132)//Сюда подставь координаты для 56 интерьера, которые ты записал выше
	result = 56;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 133)//Сюда подставь координаты для 57 интерьера, которые ты записал выше
	result = 57;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 134)//Сюда подставь координаты для 58 интерьера, которые ты записал выше
	result = 58;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 135)//Сюда подставь координаты для 59 интерьера, которые ты записал выше
	result = 59;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 136)//Сюда подставь координаты для 60 интерьера, которые ты записал выше
	result = 60;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 137)//Сюда подставь координаты для 61 интерьера, которые ты записал выше
	result = 61;
	else if(IsPlayerInRangeOfPoint(playerid,5.0,100.0,100.0,1000.0) && interior == 138)//Сюда подставь координаты для 62 интерьера, которые ты записал выше
	result = 62;
	return result;
}
stock LoadHouses()
{
	new File:house, data[64], name[32], value[32];
	print("Убежища:");
	for(new houseid; houseid < Config[MaxHouseAmount_cfg]; houseid ++)
	{
		format(data,sizeof(data),"houses/ID%d.ini",houseid);
		house = fopen(data,io_read);
		if(house)
		{
			while(fread(house,data,sizeof(data)))//Пока в файле есть непрочитанная информация
			{
			    name	= 	GetLeftSideOfString(data,"=");
			    value	= 	GetRightSideOfString(data,"=");
				if(!strcmp("Владелец",name,true))  			HouseInfo[houseid][hOwner] = strval(value);
				else if(!strcmp("Цена",name,true))  		HouseInfo[houseid][hPrice] = strval(value);
				else if(!strcmp("Снаружи_икс",name,true))  	HouseInfo[houseid][hOutPos_x] = floatstr(value);
				else if(!strcmp("Снаружи_игрек",name,true)) HouseInfo[houseid][hOutPos_y] = floatstr(value);
				else if(!strcmp("Снаружи_зет",name,true))  	HouseInfo[houseid][hOutPos_z] = floatstr(value);
				else if(!strcmp("Снаужи_угол",name,true))  	HouseInfo[houseid][hOutAngle] = floatstr(value);
				else if(!strcmp("Интерьер",name,true))  	HouseInfo[houseid][hHouseInterior] = strval(value);
				else if(!strcmp("Замок",name,true))  		HouseInfo[houseid][hLocked] = strval(value);
			}
			fclose(house);
			printf("Убежище: ID %d, Банда-владелец: ID %d",houseid,HouseInfo[houseid][hOwner]);
		}
	}
	return 1;
}
stock SaveHouse(houseid)
{
    new File:house,	data[64];
	if(houseid == -1)//Сохранить все дома
	{
		for(houseid = 0; houseid < Config[MaxHouseAmount_cfg]; houseid++)
		{
		    format(data,sizeof(data),"houses/ID%d.ini",houseid);
		    house = fopen(data,io_write);
			format(data,sizeof(data),"Владелец=%d\n",HouseInfo[houseid][hOwner] );				fwriteRUS(house,data);
			format(data,sizeof(data),"Цена=%d\n",HouseInfo[houseid][hPrice] );					fwriteRUS(house,data);
			format(data,sizeof(data),"Снаружи_икс=%f\n",HouseInfo[houseid][hOutPos_x] );		fwriteRUS(house,data);
			format(data,sizeof(data),"Снаружи_игрек=%f\n",HouseInfo[houseid][hOutPos_y] );		fwriteRUS(house,data);
			format(data,sizeof(data),"Снаружи_зет=%f\n",HouseInfo[houseid][hOutPos_z] );		fwriteRUS(house,data);
			format(data,sizeof(data),"Снаружи_угол=%f\n",HouseInfo[houseid][hOutAngle] );		fwriteRUS(house,data);
			format(data,sizeof(data),"Интерьер=%d\n",HouseInfo[houseid][hHouseInterior] );		fwriteRUS(house,data);
			format(data,sizeof(data),"Замок=%d\n",HouseInfo[houseid][hLocked] );				fwriteRUS(house,data);
			
			fclose(house);//Закроем файл, когда мы записали инфу
		}
	}
	else
	{
	    format(data,sizeof(data),"houses/ID%d.ini",houseid);
	    house = fopen(data,io_write);
		format(data,sizeof(data),"Владелец=%d\n",HouseInfo[houseid][hOwner] );				fwriteRUS(house,data);
		format(data,sizeof(data),"Цена=%d\n",HouseInfo[houseid][hPrice] );					fwriteRUS(house,data);
		format(data,sizeof(data),"Снаружи_икс=%f\n",HouseInfo[houseid][hOutPos_x] );		fwriteRUS(house,data);
		format(data,sizeof(data),"Снаружи_игрек=%f\n",HouseInfo[houseid][hOutPos_y] );		fwriteRUS(house,data);
		format(data,sizeof(data),"Снаружи_зет=%f\n",HouseInfo[houseid][hOutPos_z] );		fwriteRUS(house,data);
		format(data,sizeof(data),"Снаружи_угол=%f\n",HouseInfo[houseid][hOutAngle] );		fwriteRUS(house,data);
		format(data,sizeof(data),"Интерьер=%d\n",HouseInfo[houseid][hHouseInterior] );		fwriteRUS(house,data);
		format(data,sizeof(data),"Замок=%d\n",HouseInfo[houseid][hLocked] );				fwriteRUS(house,data);
			
		fclose(house);//Закроем файл, когда мы записали инфу
	}
	return 1;
}
stock IsPlayerNearHouse(playerid)
{
	for(new i; i < Config[MaxHouseAmount_cfg]; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,5.0,HouseInfo[i][hOutPos_x],HouseInfo[i][hOutPos_y],HouseInfo[i][hOutPos_z]))
		return i;
	}
	return -1;
}
