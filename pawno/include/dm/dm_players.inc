/*			Игроки			*/
forward TimerForPlayers();	//На эту функцию запущен глобальный таймер, 1 секунда
forward Anticheat();		//На эту функцию запущен глобальный таймер, 1 секунда
forward CargadorNitro(playerid,carid);// для нитро текстдрава
forward ReducidorNitro(playerid,carid);// для нитро текстдрава
forward Drift();//для дрифта
forward AngleUpdate();//для дрифта
forward DriftCancellation(playerid);//для дрифта

public TimerForPlayers()
{
	for(new playerid; playerid < GetMaxPlayers(); playerid++)
	{
		if(IsPlayerConnected(playerid))
		{
			SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
			if(PlayerCameraTimer[playerid] > 0)
			{
				PlayerCameraTimer[playerid] --;
				if(PlayerCameraTimer[playerid] == 0)
				{
					new r = random(sizeof(CamBefSpawn));
					SetPlayerPos(playerid,CamBefSpawn[r][0][0],CamBefSpawn[r][0][1],CamBefSpawn[r][0][2]);
					SetPlayerCameraPos(playerid,CamBefSpawn[r][1][0],CamBefSpawn[r][1][1],CamBefSpawn[r][1][2]);
					SetPlayerCameraLookAt(playerid,CamBefSpawn[r][0][0],CamBefSpawn[r][0][1],CamBefSpawn[r][0][2]);
					SetPlayerLookAtFrom(playerid,CamBefSpawn[r][1][0],CamBefSpawn[r][1][1],CamBefSpawn[r][0][0],CamBefSpawn[r][0][1]);
					PlayerCameraTimer[playerid] = CAMERA_CHANGE_TIME;
				}
			}
			new zoneid = GetPlayerZoneID(playerid);
			if(zoneid == -1)
			TextDrawSetString(PlayerZoneTextdraw[playerid],"_");
			else
			TextDrawSetString(PlayerZoneTextdraw[playerid],ZoneInfo[zoneid][zName]);
		}
	}
	return 1;
}
public Anticheat()
{
	for(new playerid; playerid < GetMaxPlayers(); playerid ++)
	{
		if(!IsPlayerConnected(playerid)) continue;
		if(PlayerCashToGive[playerid] != 0)
		{
			new money = PlayerCashToGive[playerid];
			PlayerInfo[playerid][pMoney] +=money;
			GivePlayerMoney(playerid,money);
			PlayerCashToGive[playerid] -= money;
		}
	}
	return 1;
}
stock bool:ResetPlayerStats(playerid)		//Обнулит статистику, оставшуюся от предыдущего игрока с таким же ID
{
	strmid(PlayerInfo[playerid][pPassword],"none",0,4,16);
	strmid(PlayerInfo[playerid][pLastVictim],"none",0,4,MAX_PLAYER_NAME);
	PlayerLoggedIn[playerid] 			= false;
	PlayerCashToGive[playerid]			= 0;
	PlayerTutorialWindow[playerid] 		= 0;
	PlayerCameraTimer[playerid]			= 0;
	PlayerColor[playerid]				= 0;
	PlayerGangLabel[playerid]			= Text3D:-1;
	PlayerGangInvited[playerid]			= -1;
	
	PlayerInfo[playerid][pInterior]		= -1;	//Сбросим только интерьер, по нему и будем сверяться
	PlayerInfo[playerid][pAdmin]		= 0;
	PlayerInfo[playerid][pKills]		= 0;
	PlayerInfo[playerid][pLevel]		= 0;
	PlayerInfo[playerid][pMoney]		= 0;
	PlayerInfo[playerid][pTutorial] 	= 0;
	PlayerInfo[playerid][pGangMember]	= -1;
	PlayerInfo[playerid][pGangLeader]	= 0;
	PlayerInfo[playerid][pEnemyKills]	= 0;
	
	return true;
}
stock bool:TutorialWindow(playerid,window)	//Показать окно обучения
{
	switch(window)
	{//ID диалога везде 5, это не опечатка, так надо :)
		case 1:	//Первое окно с текстом обучения
		ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"Обучение","{DB881A}Здравствуйте вы зашли на {15D4ED}[Cream Life DM/RPG] \n {DB881A}На сервере уникальный мод с большими возможностями. \n На все ваши вопросы вы можете получить ответы , набрав {15D4ED}'/faq' ","Далее","");
		case 2:	//Второе окно с текстом обучения
		ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"Обучение","{DB881A}Не забывайте посещать сайт сервера {15D4ED}'http://gta.relaxport.ru'","Далее","");
		case 3:	//Третье окно с текстом обучения
		ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"Обучение","{DB881A}Администрация сервера желает вам приятной и увлекательной игры.","Далее","");
/*
			***	Пример, как добавить больше диалоговых окон в обучение
				В dm_defines увеличиваешь MAX_TUTORIAL_WINDOW на 1 и снимаешь коммент с 'case 4:'
				Если надо - по аналогии добавишь 5, 6 и т. д.
*/
/*
		case 4:	//Четвертое окно с текстом обучения
		ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"Обучение","Текст Обучения четвертого GUI окна","Далее","");
*/
	}
	PlayerTutorialWindow[playerid] = window;
	return true;
}
stock bool:IsPlayerAtTheGunShop(playerid) //где можно купить оружие на улице, координаты !!!
{
	if(IsPlayerInRangeOfPoint(playerid,5.0,2446.0610,-1759.8402,13.5898)) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0,2377.9553,-2016.9886,14.8329)) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0,1752.2079,-2054.4177,14.0703)) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0,1783.7157,-1705.4528,13.5243)) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0,1576.8441,-1475.1724,13.7836)) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0,1367.5239,-1279.6818,13.1181)) return true;
	if(IsPlayerInRangeOfPoint(playerid,5.0,1080.6575,-1697.5751,13.1172)) return true;
	return false;
}
/*					начало нитро текстдрав						*/
public CargadorNitro(playerid,carid)
{
	if(Cantidad[carid] >= 100)
 	{
  		Cantidad[carid] = 100;
  		TextDrawBackgroundColor(T_Nitro[playerid], 0xFF0000FF);
  		TextDrawColor(T_Nitro[playerid], 0xFF0000FF);
  		TextDrawBoxColor(T_Nitro[playerid], 397783295);
 	}
 	if(Cantidad[carid] >= 1)
 	{
  		TextDrawBackgroundColor(T_Nitro[playerid], 0xFF0000FF);
  		TextDrawColor(T_Nitro[playerid], 0xFF0000FF);
  		TextDrawBoxColor(T_Nitro[playerid], 397783295);
 	}
 	Cantidad[carid]++;
 	TextDrawColor(T_Nitro[playerid], 0x00B9FFFF);
 	TextDrawTextSize(T_Nitro[playerid],489.7 + Cantidad[carid] , 12.0 ); //12
 	TextDrawShowForPlayer(playerid,T_Nitro[playerid]);
	return 1;
}
public ReducidorNitro(playerid,carid)
{
	Cantidad[carid]--;
 	if(Cantidad[carid] <= 0)
 	{
  		Cantidad[carid] = 0;
  		TextDrawBackgroundColor(T_Nitro[playerid], 0xFF0000FF);
  		TextDrawColor(T_Nitro[playerid], 0xFF0000FF);
  		TextDrawBoxColor(T_Nitro[playerid], 0xFF0000FF);
  		RemoveVehicleComponent(GetPlayerVehicleID(playerid), 1010);
 	}
 	TextDrawTextSize(T_Nitro[playerid],489.7 + Cantidad[carid] , 12.0 ); //12
 	TextDrawShowForPlayer(playerid,T_Nitro[playerid]);
 	return 1;
}
/*					конец нитро текстдрав						*/
/*================ начало дрифт скрипта =======================================*/
Float:GetPlayerTheoreticAngle(i)
{
	new Float:sin;
	new Float:dis;
	new Float:angle2;
	new Float:XXX,Float:YYY,Float:ZZZ;
	new Float:tmp3;
	new Float:tmp4;
	new Float:MindAngle;
	if(IsPlayerConnected(i)){
		GetPlayerPos(i,XXX,YYY,ZZZ);
		dis = floatsqroot(floatpower(floatabs(floatsub(XXX,ppos[i][0])),2)+floatpower(floatabs(floatsub(YYY,ppos[i][1])),2));
		if(IsPlayerInAnyVehicle(i))GetVehicleZAngle(GetPlayerVehicleID(i), angle2); else GetPlayerFacingAngle(i, angle2);
		if(XXX>ppos[i][0]){tmp3=XXX-ppos[i][0];}else{tmp3=ppos[i][0]-XXX;}
		if(YYY>ppos[i][1]){tmp4=YYY-ppos[i][1];}else{tmp4=ppos[i][1]-YYY;}
		if(ppos[i][1]>YYY && ppos[i][0]>XXX){
			sin = asin(tmp3/dis);
			MindAngle = floatsub(floatsub(floatadd(sin, 90), floatmul(sin, 2)), -90.0);
		}
		if(ppos[i][1]<YYY && ppos[i][0]>XXX){
			sin = asin(tmp3/dis);
			MindAngle = floatsub(floatadd(sin, 180), 180.0);
		}
		if(ppos[i][1]<YYY && ppos[i][0]<XXX){
			sin = acos(tmp4/dis);
			MindAngle = floatsub(floatadd(sin, 360), floatmul(sin, 2));
		}
		if(ppos[i][1]>YYY && ppos[i][0]<XXX){
			sin = asin(tmp3/dis);
			MindAngle = floatadd(sin, 180);
		}
	}
	if(MindAngle == 0.0){
		return angle2;
	} else
		return MindAngle;
}
/*----------------------------------------------------------------------------*/
public DriftCancellation(playerid){
	PlayerDriftCancellation[playerid] = 0;
	GameTextForPlayer(playerid, Split("~g~Drift ~y~Bonus:~w~ + ", tostr(DriftPointsNow[playerid]/4), "$"), 1000, 3);
    //GivePlayerMoney(playerid, DriftPointsNow[playerid]/4);
    PlayerCashToGive[playerid] = DriftPointsNow[playerid]/4;
	DriftPointsNow[playerid] = 0;
}
/*----------------------------------------------------------------------------*/
Float:ReturnPlayerAngle(playerid){
	new Float:Ang;
	if(IsPlayerInAnyVehicle(playerid))GetVehicleZAngle(GetPlayerVehicleID(playerid), Ang); else GetPlayerFacingAngle(playerid, Ang);
	return Ang;
}
/*----------------------------------------------------------------------------*/
public Drift(){
	new Float:Angle1, Float:Angle2, Float:BySpeed, s[256];
	new Float:ZZZ;
	new Float:XXX;
	new Float:YYY;
	new Float:SpeedX;
	for(new g=0;g<200;g++){
		GetPlayerPos(g, XXX, YYY, ZZZ);
		SpeedX = floatsqroot(floatadd(floatadd(floatpower(floatabs(floatsub(XXX,SavedPos[ g ][ sXXX ])),2),floatpower(floatabs(floatsub(YYY,SavedPos[ g ][ sYYY ])),2)),floatpower(floatabs(floatsub(ZZZ,SavedPos[ g ][ sZZZ ])),2)));
		Angle1 = ReturnPlayerAngle(g);
		Angle2 = GetPlayerTheoreticAngle(g);
		BySpeed = floatmul(SpeedX, 12);
		if(IsPlayerInAnyVehicle(g) && IsCar(GetPlayerVehicleID(g)) && floatabs(floatsub(Angle1, Angle2)) > DRIFT_MINKAT && floatabs(floatsub(Angle1, Angle2)) < DRIFT_MAXKAT && BySpeed > DRIFT_SPEED){
			if(PlayerDriftCancellation[g] > 0)KillTimer(PlayerDriftCancellation[g]);
			PlayerDriftCancellation[g] = 0;
			DriftPointsNow[g] += floatval( floatabs(floatsub(Angle1, Angle2)) * 3 * (BySpeed*0.1) )/10;
			PlayerDriftCancellation[g] = SetTimerEx("DriftCancellation", 3000, 0, "d", g);
		}
		if(DriftPointsNow[g] > 0){
			format(s, sizeof(s), "~n~~n~~n~~n~~n~~n~~n~____________________~n~______________________~g~Drift ~y~Bonus:~w~ %d$!", DriftPointsNow[g]/4);
			GameTextForPlayer(g, s, 3000, 3);
		}
		SavedPos[ g ][ sXXX ] = XXX;
		SavedPos[ g ][ sYYY ] = YYY;
		SavedPos[ g ][ sZZZ ] = ZZZ;
	}
}
/*----------------------------------------------------------------------------*/
Split(s1[], s2[], s3[]=""){
	new rxx[256];
	format(rxx, 256, "%s%s%s", s1, s2, s3);
	return rxx;
}
/*----------------------------------------------------------------------------*/
tostr(int){
	new st[256];
	format(st, 256, "%d", int);
	return st;
}
/*----------------------------------------------------------------------------*/
public AngleUpdate(){
	for(new g=0;g<200;g++){
		new Float:XXX, Float:YYY, Float:ZZZ;
		if(IsPlayerInAnyVehicle(g))GetVehiclePos(GetPlayerVehicleID(g), XXX, YYY, ZZZ); else GetPlayerPos(g, XXX, YYY, ZZZ);
		ppos[g][0] = XXX;
		ppos[g][1] = YYY;
		ppos[g][2] = ZZZ;
	}
}
/*----------------------------------------------------------------------------*/
floatval(Float:val){
	new str[256];
	format(str, 256, "%.0f", val);
	return todec(str);
}
/*----------------------------------------------------------------------------*/
IsCar(model)
{
	switch(model)
	{
		case 443:return 0;
		case 448:return 0;
		case 461:return 0;
		case 462:return 0;
		case 463:return 0;
		case 468:return 0;
		case 521:return 0;
		case 522:return 0;
		case 523:return 0;
		case 581:return 0;
		case 586:return 0;
		case 481:return 0;
		case 509:return 0;
		case 510:return 0;
		case 430:return 0;
		case 446:return 0;
		case 452:return 0;
		case 453:return 0;
		case 454:return 0;
		case 472:return 0;
		case 473:return 0;
		case 484:return 0;
		case 493:return 0;
		case 595:return 0;
		case 417:return 0;
		case 425:return 0;
		case 447:return 0;
		case 465:return 0;
		case 469:return 0;
		case 487:return 0;
		case 488:return 0;
		case 497:return 0;
		case 501:return 0;
		case 548:return 0;
		case 563:return 0;
		case 406:return 0;
		case 444:return 0;
		case 556:return 0;
		case 557:return 0;
		case 573:return 0;
		case 460:return 0;
		case 464:return 0;
		case 476:return 0;
		case 511:return 0;
		case 512:return 0;
		case 513:return 0;
		case 519:return 0;
		case 520:return 0;
		case 539:return 0;
		case 553:return 0;
		case 577:return 0;
		case 592:return 0;
		case 593:return 0;
		case 471:return 0;
	}
	return 1;
}
/*----------------------------------------------------------------------------*/
todec(str[])
{
	return strval(str);
}
#define ANNOUNCE 480000
forward Announce();
public Announce()
{
PlayerPlaySound(ANNOUNCE,1083,392.2066,-2929.0659,5.6610);
return 1;
}
/*================ конец дрифт скрипта =======================================*/
