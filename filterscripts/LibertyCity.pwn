#include <a_samp>

#define FILTERSCRIPT
#if defined FILTERSCRIPT

new Menu:LCMenu;

new LC_Car1;
new LC_Car2;
new LC_Bike;

public OnFilterScriptInit()
{
    // --------------------------------------------------------------------------> Intro

	print("\n--------------------------------------");
	print("Либерти Сити загружен !");
	print("--------------------------------------\n");
	
	// --------------------------------------------------------------------------> Objects
	
	CreateObject(8171,-720.7,598,1370.88,0,180,0);
	CreateObject(8000,-849,670,1351.4,0,168.8,0);
	CreateObject(8000,-880,670,1349,0,174.3,0);
	CreateObject(8172,-891,550,1345.85,0,180,0);
	CreateObject(8000,-900,595.9,1342.9,0,180,270);
	CreateObject(8000,-1020,662.74,1336.8,0,174.2,0);
	CreateObject(8171,-960.6,513.15,1340.87,0,180,0);
	CreateObject(8171,-907.699,375.803,1338.9,5.8,180,0);
	CreateObject(8171,-907.699,397.003,1340.86,0,180,0);
	CreateObject(8171,-887.699,347.003,1340.86,0,180,220);
	CreateObject(8171,-869.299,406.503,1333.2,0,202.8,0);
	CreateObject(8000,-788.7,359.4,1335,0,180,270);
	CreateObject(8000,-705.626,369.1,1327.1,203,0,0);
	CreateObject(8171,-960.7,375.184,1334,185.71,0,0);
	CreateObject(8000,-1014.47,290.528,1337.9,0,180,90);
	CreateObject(8171,-1000.52,443.15,1338.88,0,174.3,0);
	CreateObject(8171,-1020.52,443.15,1336.88,0,174.3,0);
	CreateObject(8000,-1020.32,497.011,1337.86,0,180,270);
	CreateObject(8000,-1088.22,547.011,1337.86,0,180,270);
	CreateObject(8171,-1130.5,596.75,1332.76,0,170.8,270);
	CreateObject(8000,-1138.22,697.011,1332.7,0,180,270);
	CreateObject(8000,-1218.22,547.011,1337.857,0,180,270);
	CreateObject(8000,-1218.22,327.011,1337.86,0,180,90);
	CreateObject(8171,-1271.5,596.75,1335.95,0,180,90);
	CreateObject(8171,-1311.5,546.75,1335.95,0,180,0);
	CreateObject(8171,-1311.5,408.5,1335.95,0,180,0);
	CreateObject(8171,-1311.5,278.5,1335.95,0,180,0);
	CreateObject(8171,-1218.2,277.4,1335.9,0,180,270);
	CreateObject(8172,-1201,259.5,1335.95,0,180,270);
	CreateObject(8172,-1119.5,359.9,1335.85,0,180,0);
	CreateObject(8172,-1113.72,339.8,1335.64,0,179.2,0);
	CreateObject(8171,-930.6,512.903,1343.95,0,174.3,0);
	CreateObject(8171,-950.6,512.903,1341.918,0,174.3,0);
	CreateObject(8171,-998.56,562.9,1332.17,0,154,0);
	CreateObject(8171,-1008.56,562.9,1335.94,0,180,0);
	CreateObject(8171,-1042.83,646,1335.9,0,180,0);
	
	// --------------------------------------------------------------------------> Cars
	
	LC_Car1 = CreateVehicle(405,-757.4554,504.6992,1372,274,25,1,10);
	LC_Car2 = CreateVehicle(405,-758.0460,508.1261,1372,94,25,1,10);
	LC_Bike = CreateVehicle(509,-789.5652,485.4703,1382,270,53,1,10);
	LinkVehicleToInterior(LC_Car1,1);
	LinkVehicleToInterior(LC_Car2,1);
	LinkVehicleToInterior(LC_Bike,1);
	AddVehicleComponent(LC_Car1,1023);
	AddVehicleComponent(LC_Car2,1023);
	
	// --------------------------------------------------------------------------> Menu
	
	LCMenu = CreateMenu("Liberty City",1,200,200,200,30);
	AddMenuItem(LCMenu,0,"Улица");
	AddMenuItem(LCMenu,0,"Внутри");
	AddMenuItem(LCMenu,0,"Крыша 1");
	AddMenuItem(LCMenu,0,"Крыша 2");
	return 1;
}

// ------------------------------------------------------------------------------> Command

public OnPlayerCommandText(playerid,cmdtext[])
{
    if (strcmp("/lc",cmdtext,true) == 0)
	{
		TogglePlayerControllable(playerid, 0);
		ShowMenuForPlayer(LCMenu,playerid);
		return 1;
	}
	return 0;
}

// ------------------------------------------------------------------------------> When menu selected

public OnPlayerSelectedMenuRow(playerid, row)
{
	TogglePlayerControllable(playerid,1);
	SetCameraBehindPlayer(playerid);
	new Menu:Current = GetPlayerMenu(playerid);

	if (Current == LCMenu)
	{
 		switch(row)
	 	{
			case 0:{SetPlayerPos(playerid,-753.5265,500.1738,1371.9109); SetPlayerFacingAngle(playerid,257); SetPlayerInterior(playerid,1);}
			case 1:{SetPlayerPos(playerid,-780.7311,506.6021,1371.7422); SetPlayerFacingAngle(playerid,90); SetPlayerInterior(playerid,1);}
			case 2:{SetPlayerPos(playerid,-849.8855,529.8953,1367.8601); SetPlayerFacingAngle(playerid,270); SetPlayerInterior(playerid,1);}
			case 3:{SetPlayerPos(playerid,-815.1640,518.0328,1390.7834); SetPlayerFacingAngle(playerid,180); SetPlayerInterior(playerid,1);}
		}
	}
	return 1;
}

// ------------------------------------------------------------------------------> When exit menu

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid,1);
    return 1;
}

// ------------------------------------------------------------------------------> End script

public OnFilterScriptExit()
{

	print("\n--------------------------------------");
	print("Basss' Liberty City Explore's has been Unloaded!");
	print("--------------------------------------\n");
	DestroyVehicle(LC_Car1);
	DestroyVehicle(LC_Car2);
	DestroyVehicle(LC_Bike);
	return 1;
}
#endif
