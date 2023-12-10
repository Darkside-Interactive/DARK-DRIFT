//
// Created:     27.11.06
// Aurthor:     Peter Steenbergen
//
#if defined _business_included
#endinput
#endif

#define _business_included
#pragma library business
#include "base"
#include "utils\gtoutils"
#include "utils\dutils"
#include "utils\dini"
#include "account"
#include "player"
#include "world"

forward Business_OnGameModeInit();
forward IsPlayerAtBusiness(playerid);
forward OnPlayerEnterBusinessCheckpoint(playerid);
forward GetBusinessID(playerid);
forward TurnAround();
forward BusinessCommandHandler(playerid,text[]);

forward BisMenuInit();
forward FBisInfo(playerid);
forward FBisBuy(playerid);
forward FBisSell(playerid);
forward FBisCollect(playerid);
forward FBisBises(playerid);
forward FBisMyBises(playerid);

#define MAX_BUSINESBUYSELL 1000000

#define TurnAroundDelay 200000 // Delay between businesses turnaround

enum BusinessInfo {
	Business_Name[MAX_STRING],  // business name
	Business_Cost,     // cost
	Business_Value,        // value
	Business_Level,            // minumum level
	Business_Owner[MAX_NAME],   // owner
	Business_Buyout,            // Buyout price
	Business_Vault              // Vault
}

//last 31 businesses
#define MAX_BUSINESSES 53

new Businesses[MAX_BUSINESSES][BusinessInfo] = {
	//NAME,COST,VALUE,LEVEL,OWNER,BUYOUT
	{"Botique",35000,800,5,"Unknown",0,0},
	{"Shithole Bar",25000,1300,8,"Unknown",0,0},
	{"Tattoo Parlor",40000,600,3,"Unknown",0,0},
	{"Binco Clothing",15000,800,5,"Unknown",0,0},
	{"Train Hard Clothing",15000,800,9,"Unknown",0,0},
	{"Urban Clothing",15000,800,5,"Unknown",0,0},
	{"Victim Clothing",15000,800,5,"Unknown",0,0},
	{"Zip Clothing",15000,800,5,"Unknown",0,0},
	{"DidierSachs Clothing",20000,950,7,"Unknown",0,0},
	{"Gym",20000,1000,7,"Unknown",0,0},
	{"Zero RC",10000,900,3,"Unknown",0,0},
	{"Zombotech",35000,1600,12,"Unknown",0,0},
	{"Verdant Meadows Air Strip",20000,1200,7,"Unknown",0,0},
	{"Blueberry Liquor Store",15000,850,5,"Unknown",0,0},
	{"Club-Disco",50000,1600,10,"Unknown",0,0},
	{"Lil Probe-Inn",47000,1100,6,"Unknown",0,0},
	{"Sex Shop",40000,950,7,"Unknown",0,0},
	{"Strip Club",60000,1400,10,"Unknown",0,0},
	{"The Big Spread Ranch",48000,1450,9,"Unknown",0,0},
	{"Jizzys",58000,1675,13,"Unknown",0,0},
	{"The Sherman Dam",58000,1800,16,"Unknown",0,0},
	{"Cobra Marital Arts",15000,800,5,"Unknown",0,0},
	{"City Planning Department",35000,1600,12,"Unknown",0,0},
	{"Inside Track",20000,1200,7,"Unknown",0,0},
	{"Coutt and Schutz Auto",25000,1250,8,"Unknown",0,0},
	{"Ottos Auto",25000,1250,8,"Unknown",0,0},
	{"Wang Cars",25000,1250,8,"Unknown",0,0},
	{"Emerald Isle",160000,4100,17,"Unknown",0,0},
	{"The Visage",145000,3800,17,"Unknown",0,0},
	{"Caligulas",3750000,19900,20,"Unknown",0,0},
	{"Four Dragons",2050000,16000,20,"Unknown",0,0},
//NEWS
   	{"Skate Park",200000,1000,14,"Unknown",0,0},
	{"Federal Bank Of Los Santos",90000000,150000,34,"Unknown",0,0},
	{"SannyWood Studio",1000000,30000,25,"Unknown",0,0},
	{"Theatre 'Red Dragon'",300000,2000,26,"Unknown",0,0},
	{"Tennis Club",600000,7000,21,"Unknown",0,0},
	{"Old Beacon",1500000,3000,25,"Unknown",0,0},
	{"Restaurant 'Startfish'",90000,900,19,"Unknown",0,0},
	{"Oil Station 69",210000,800,11,"Unknown",0,0},
	{"'Gold Kolosse' Fabric",2000000,10000,27,"Unknown",0,0},
	{"Chemical Fabric",7000000,15000,29,"Unknown",0,0},
	{"Home Group 'San Fierro'",900000,7000,20,"Unknown",0,0},
	{"Stadium 'San Fierro'",400000,2000,24,"Unknown",0,0},
	{"Drugs Fabric",10000000,40000,29,"Unknown",0,0},
	{"Sacred Nicolay Church",2500000,1300,24,"Unknown",0,0},
	{"Business Center",4000000,4000,27,"Unknown",0,0},
	{"Hotel 'Plaza'",1500000,9000,27,"Unknown",0,0},
	{"The Medical Center 'San Fierro'",3000000,11000,28,"Unknown",0,0},
	{"'Chiodan' Shop",15000,800,5,"Unknown",0,0},
	{"Car trading",150000,1000,10,"Unknown",0,0},
	{"Casino 'Royale'",15000000,20000,30,"Unknown",0,0},
	{"Super Market 'Las Venturas'",24000000,22000,29,"Unknown",0,0},
	{"Disk's Sounds",20000,1000,7,"Unknown",0,0}

//      {"Rancho's Attraction",1200500,25000,29,"Unknown",0,0}
};

new BusinessCP[MAX_BUSINESSES][CoordInfo] = {
	{418.5547,-80.1667,1001.8047},
	{501.4927,-75.4323,998.7578},
	{-203.4864,-41.2045,1002.2734},
	{207.5640,-97.8188,1005.2578},
	{210.1111,-129.1273,1003.5152},
	{203.8557,-40.4717,1001.8047},
	{210.3724,-8.1825,1005.2109},
	{161.1875,-79.9915,1001.8047},
	{204.2810,-157.2614,1000.5234},
	{773.6138,-72.1616,1000.6484},
	{-2231.2478,131.9623,1035.4141},
	{-1951.5938,704.3567,46.5625},
	{418.1210,2536.8762,10.0000},
	{252.4851,-57.3515,1.5703},
	{500.7049,-13.3777,1000.6797},
	{-225.7790,1403.9459,27.7734},
	{-103.5525,-22.4661,1000.7188},
	{1212.3918,-10.9459,1000.9219},
	{1208.5027,-32.6044,1000.9531},
	{-2650.0667,1409.2106,906.2734},
	{-955.5327,1948.5414,9.0000},
	{768.2014,-36.9461,1000.6865},
	{357.0584,173.5787,1008.3820},
	{823.1819,3.2361,1004.1797},
	{2131.6455,-1148.2836,24.3898},
	{-1657.8334,1207.3041,7.2500},
	{-1957.5327,300.2131,35.4688},
	{2127.5940,2370.4255,10.8203},
	{2022.5179,1916.6848,12.3397},
	{2235.5408,1679.0402,1008.3594},
	{1993.9758,1017.8945,994.8906},
//NEWS
	{1907.3983,-1410.0752,13.5703},
	{1481.0059,-1767.0461,18.7958},
	{915.5178,-1235.0593,17.2109},
	{1022.6241,-1122.3911,23.8714},
	{727.8724,-1275.8170,13.6484},
	{154.1374,-1945.6095,4.7621},
	{386.2871,-2028.5677,7.8359},
	{-83.6396,-1178.1255,2.0002},
	{-49.7400,-271.0310,6.6332},
	{-1013.4882,-692.5747,32.0078},
	{-2061.3794,-860.7638,32.1719},
	{-2112.0164,-443.8892,38.7344},
	{-2163.2351,-223.8717,36.5156},
	{-1988.0575,1118.0524,54.4741},
	{-1952.9694,1341.1848,7.1875},
	{-1755.1521,959.4395,24.8828},
	{-2658.4219,636.4652,14.4531},
	{-2131.0112,715.5322,69.5625},
	{2200.5972,1391.1923,10.8203},
	{2088.4282,1449.8523,10.8203},
	{1953.8895,1342.9160,15.3746},
	{2519.5034,2334.8428,10.8203}

//	{1045.6881, -301.7158, 73.6473}
};


new Menu:BisMenu;

public BisMenuInit()     //Create by FP
{
//	new rst[256]="edited...";

	BisMenu = CreateMenu("Bizz..", 1, 30.0, 150.0, 100.0, 140.0);
//	SetMenuColumnHeader(BisMenu, 0, "");
		AddMenuItem(BisMenu, 0, "...cancel...");
		AddMenuItem(BisMenu, 0, "Information");
		AddMenuItem(BisMenu, 0, "Buy");
		AddMenuItem(BisMenu, 0, "Sell");
//		AddMenuItem(BisMenu, 0, "Set Sell Cost");
		AddMenuItem(BisMenu, 0, "Collect");
		AddMenuItem(BisMenu, 0, "My Busin-s");
		AddMenuItem(BisMenu, 0, "All Busin-s");


return 1;
}

new BusinessDB[MAX_STRING] = "GTO/Business/";

BusinessLoadAll()
{
	if (ForceOverwrite) return;
	new temp[MAX_STRING];
	if (!dini_Exists(ConfigDB)) dini_Create(ConfigDB);
	set(temp,dini_Get(ConfigDB,"Business_DB"));
	if (strlen(temp) > 0) set(BusinessDB,temp);

	if (!dini_Exists(BusinessDB))
	{

		BusinessSaveAll();

		return;
	}
	for (new i=0;i<MAX_BUSINESSES;i++)
	{
		new businessdbname[MAX_STRING];
		format(businessdbname,sizeof(businessdbname),"%sGTO.Business.%s.txt",BusinessDB,Businesses[i][Business_Name]);
		if (!dini_Exists(businessdbname))
		{
			continue;
		}
		set(temp,dini_Get(businessdbname,"Name"));
		if (strlen(temp) > 0) set(Businesses[i][Business_Name],temp);
		set(temp,nullstr);
		set(temp,dini_Get(businessdbname,"Cost"));
		if (strlen(temp) > 0) Businesses[i][Business_Cost] = strval(temp);
		set(temp,nullstr);
		set(temp,dini_Get(businessdbname,"Value"));
		if (strlen(temp) > 0) Businesses[i][Business_Value] = strval(temp);
		set(temp,nullstr);
		set(temp,dini_Get(businessdbname,"Level"));
		if (strlen(temp) > 0) Businesses[i][Business_Level] = strval(temp);
		set(temp,nullstr);
		set(temp,dini_Get(businessdbname,"Owner"));
		if (strlen(temp) > 0) set(Businesses[i][Business_Owner],temp);
		set(temp,nullstr);
		set(temp,dini_Get(businessdbname,"Buyout"));
		if (strlen(temp) > 0) Businesses[i][Business_Buyout] = strval(temp);
		set(temp,nullstr);
		set(temp,dini_Get(businessdbname,"Vault"));
		if (strlen(temp) > 0) Businesses[i][Business_Vault] = strval(temp);
		set(temp,nullstr);
	}
	return;

}

BusinessSaveAll()
{
	new temp[MAX_STRING];
	if (dini_Exists(ConfigDB))
	{
		dini_Set(ConfigDB,"Business_DB",BusinessDB);
	}

	for (new i=0;i<MAX_BUSINESSES;i++)
	{
		new businessdbname[MAX_STRING];
		format(businessdbname,sizeof(businessdbname),"%sGTO.Business.%s.txt",BusinessDB,Businesses[i][Business_Name]);
		if (!dini_Exists(businessdbname)) dini_Create(businessdbname);
		dini_Set(businessdbname,"Name",Businesses[i][Business_Name]);
		valstr(temp,Businesses[i][Business_Cost]);
		dini_Set(businessdbname,"Cost",temp);
		set(temp,nullstr);
		valstr(temp,Businesses[i][Business_Value]);
		dini_Set(businessdbname,"Value",temp);
		set(temp,nullstr);
		valstr(temp,Businesses[i][Business_Level]);
		dini_Set(businessdbname,"Level",temp);
		set(temp,nullstr);
		dini_Set(businessdbname,"Owner",Businesses[i][Business_Owner]);
		valstr(temp,Businesses[i][Business_Buyout]);
		dini_Set(businessdbname,"Buyout",temp);
		set(temp,nullstr);
		valstr(temp,Businesses[i][Business_Vault]);
		dini_Set(businessdbname,"Vault",temp);
		set(temp,nullstr);
	}
	return;

}

public Business_OnGameModeInit()
{
	BusinessLoadAll();
	BisMenuInit();
	for (new id=0;id<MAX_BUSINESSES;id++)
	{
		AddActiveCheckpoint(BusinessCP[id][Coord_X],BusinessCP[id][Coord_Y],BusinessCP[id][Coord_Z],20,2);
//		CreateStreamPickup(1274,49,BusinessCP[id][Coord_X],BusinessCP[id][Coord_Y],BusinessCP[id][Coord_Z]);
	}
	SetTimer("TurnAround", TurnAroundDelay, 1);
	WriteLog("Business initialised");
	return 0;
}

public IsPlayerAtBusiness(playerid)
{
	for (new id=0;id<MAX_BUSINESSES;id++)
	{
		if (oIsPlayerInCheckpoint(playerid,BusinessCP[id][Coord_X],BusinessCP[id][Coord_Y],BusinessCP[id][Coord_Z],10))
		{
			return 1;
		}
	}
	return 0;
}

public OnPlayerEnterBusinessCheckpoint(playerid)
{
	if (playerid == INVALID_PLAYER_ID) return;
	if (!IsPlayerConnected(playerid)) return;
	if (!IsPlayerAtBusiness(playerid)) return;

	for (new id=0;id<MAX_BUSINESSES;id++)
	{
		if (oIsPlayerInCheckpoint(playerid,BusinessCP[id][Coord_X],BusinessCP[id][Coord_Y],BusinessCP[id][Coord_Z],10))
		{
//			new temp[MAX_STRING];
//			format(temp,sizeof(temp), lang_texts[47] ,Businesses[id][Business_Name]);
//			SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
//  	        ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "Меню управления бизнесом"," Информация \n Купить \n Продать \n Собрать прибыль " ,"Выбор", "Отмена");
		SendClientMessage(playerid, COLOUR_YELLOW, "Нажмите на левую кнопку мыши(огонь) чтобы показать меню управлением бизнесом");

		}
	}
}

public GetBusinessID(playerid)
{
	new lookupid=-1;
	for (new id=0;id<MAX_BUSINESSES;id++)
	{
		if (oIsPlayerInCheckpoint(playerid,BusinessCP[id][Coord_X],BusinessCP[id][Coord_Y],BusinessCP[id][Coord_Z],10))
		{
			lookupid = id;
		}
	}
	return lookupid;
}

public TurnAround()
{
	new temp[MAX_STRING];
	new vaultamount;
	new vaultmax;
	for (new id=0;id<MAX_BUSINESSES;id++)
	{
		if(strcomp(Businesses[id][Business_Owner], "Unknown", true) == 0)
		{
			vaultmax = Businesses[id][Business_Value] * 5;
			vaultamount = Businesses[id][Business_Vault] + Businesses[id][Business_Value];
			if(vaultamount < vaultmax)
			{
				Businesses[id][Business_Vault] = vaultamount;
				new dinifilename[MAX_STRING];
				format(dinifilename,sizeof(dinifilename),"%sGTO.Business.%s.txt",BusinessDB,Businesses[id][Business_Name]);
				if (dini_Exists(dinifilename))
				{
					valstr(temp,Businesses[id][Business_Vault]);
					dini_Set(dinifilename,"Vault",temp);
					set(temp,nullstr);
				}
			}
		}
	}
}

public BusinessCommandHandler(playerid,text[]) // process player commands
{
	if (!IsPlayerConnected(playerid)) return 0;

	new cmd[20];
	new idx;

	set(cmd,strcharsplit(text, idx,strchar(" ")));
	if (strlen(cmd) == 0) return 0;

/*	if (!strcmp("/bmenu", cmd, true, 5))
	{
		if (!IsPlayerAtBusiness(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[48]  , 0,COLOUR_RED);
			return 1;
		}
		else
		{
//		new s[128];
		TogglePlayerControllable(playerid, 0);
		return 1;
		}
	}
*/
	//-- businessinfo --
	if((strcomp(cmd, "/businessinfo", true) == 1) || (strcomp(cmd, "/binfo", true) == 1))
	{
		if (!IsPlayerAtBusiness(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[48]  , 0,COLOUR_RED);
			return 1;
		}
		else
		{
		FBisInfo(playerid);
		}

	}
	//---------------------

	//-- buybusiness --
	if((strcomp(cmd, "/businessbuy", true) == 1) || (strcomp(cmd, "/bbuy", true) == 1))
	{
		if (!IsPlayerAtBusiness(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[65]  , 0,COLOUR_RED);
			return 1;
		}
		else
		{
		FBisBuy(playerid);
		}

	}
	//---------------------

	//-- sellbusiness --
	if((strcomp(cmd, "/businesssell", true) == 1) || (strcomp(cmd, "/bsell", true) == 1))
	{
		if (!IsPlayerAtBusiness(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[74]  , 0,COLOUR_RED);
			return 1;
		}
		else
		{
		FBisSell(playerid);
		}

	}
	//--------------------

//	//-- set buyout --
//	if(strcomp(cmd, "/setbbuyout_closed", true) == 1)
//	{
//		new buyoutamount;
//		buyoutamount = strval(strcharsplit(text, idx,strchar(" ")));
//
//		if ((buyoutamount < -9999) || (buyoutamount == 0) || (buyoutamount > 9999) || (buyoutamount > Player[playerid][Money]))
//		{
//			SendPlayerFormattedText(playerid, lang_texts[83] , 0,COLOUR_RED);
//			return 1;
//		}
//
//		if (!IsPlayerAtBusiness(playerid))
//		{
//			SendPlayerFormattedText(playerid,  lang_texts[84]  , 0,COLOUR_RED);
//			return 1;
//		} else {
//			new id=GetBusinessID(playerid);
//			new temp[MAX_STRING];
//			if (id > -1)
//			{
//				if (IsPlayerRegistered(playerid))
//				{
//					if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true) == 0)
//					{
//						SendPlayerFormattedText(playerid,  lang_texts[85] , 0,COLOUR_RED);
//					} else {
//						new newbuyout;
//						newbuyout = Businesses[id][Business_Buyout] + buyoutamount;
//						if(newbuyout < 0 || newbuyout > MAX_BUSINESBUYSELL)
//						{
//							SendPlayerFormattedText(playerid, lang_texts[86] , 0,COLOUR_RED);
//							return 1;
//						}
//						oGivePlayerMoney(playerid,0-buyoutamount,1);
//						Businesses[id][Business_Buyout] = newbuyout;
//						new dinifilename[MAX_STRING];
//						//format(dinifilename,sizeof(dinifilename),"%sGTO.Business.%s.txt",BusinessDB,Businesses[id][Business_Name]);
//						if (dini_Exists(dinifilename))
//						{
//							valstr(temp,Businesses[id][Business_Buyout]);
//							dini_Set(dinifilename,"Buyout",temp);
//							set(temp,nullstr);
//						}
//						if(buyoutamount > 0)
//						{
//							format(temp,sizeof(temp), lang_texts[87] ,Businesses[id][Business_Buyout]);
//							SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
//							set(temp,nullstr);
//							new logstring[256];
//							format(logstring, sizeof (logstring), "player: %d:  %s: increased the buy out of '%s' (business) to $%d",playerid,oGetPlayerName(playerid),Businesses[id][Business_Name],Businesses[id][Business_Buyout]);
//							WriteLog(logstring);
//						} else {
//							format(temp,sizeof(temp), lang_texts[88] ,Businesses[id][Business_Buyout]);
//							SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
//							set(temp,nullstr);
//							new logstring[256];
//							format(logstring, sizeof (logstring), "player: %d:  %s: decreased the buy out of '%s' (business) to $%d",playerid,oGetPlayerName(playerid),Businesses[id][Business_Name],Businesses[id][Business_Buyout]);
//							WriteLog(logstring);
//						}
//					}
//				} else {
//					SendPlayerFormattedText(playerid,  lang_texts[89] , 0,COLOUR_RED);
//					SendPlayerFormattedText(playerid,  lang_texts[90] , 0,COLOUR_RED);
//				}
//			} else {
//				SendPlayerFormattedText(playerid,  lang_texts[91] , 0,COLOUR_RED);
//			}
//		}
//		return 1;
//	}
//	//----------------------

	//-- collect vault --
	if(strcomp(cmd, "/collect", true) == 1)
	{
		if (!IsPlayerAtBusiness(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[92]  , 0,COLOUR_RED);
			return 1;
		}
		else
		{
		FBisCollect(playerid);
		}
		return 1;
	}
	//---------------------

	//-- businesses list --
	if(strcomp(cmd, "/businesses", true) == 1)
	{
	FBisBises(playerid);
	}


	//-------------------------

	//--  my businesses list --
	if(strcomp(cmd, "/mybusinesses", true) == 1)
	{
	FBisMyBises(playerid);
	}


	//-------------------------
	return 0;
}


//----------------RECOMPILED BUSINESSES----------------------------------------

public FBisInfo(playerid) {
			new id=GetBusinessID(playerid);
			if (id > -1)
			{
				new temp[MAX_STRING];
				format(temp,sizeof(temp), lang_texts[49] ,Businesses[id][Business_Name]);
				SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
				set(temp,nullstr);
				if(strcomp(Businesses[id][Business_Owner], "Unknown", true) == 0)
				{
					format(temp,sizeof(temp), lang_texts[50] ,Businesses[id][Business_Owner]);
					SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
					set(temp,nullstr);
					new price;
					price = Businesses[id][Business_Cost] + Businesses[id][Business_Buyout];
					if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true) == 0)
					{
						format(temp,sizeof(temp), lang_texts[51] ,price);
						SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
						set(temp,nullstr);
						format(temp,sizeof(temp), lang_texts[52] ,Businesses[id][Business_Level]);
						SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
						set(temp,nullstr);
						format(temp,sizeof(temp), lang_texts[53] ,Businesses[id][Business_Value]);
						SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
						set(temp,nullstr);
						SendPlayerFormattedText(playerid,  lang_texts[54] , 0,COLOUR_LIGHTGREEN);
					} else {
						price = (price * 85) / 100;
						if (Businesses[id][Business_Vault] > 0)
						{
							format(temp,sizeof(temp), lang_texts[55] ,Businesses[id][Business_Vault]);
							SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
							set(temp,nullstr);
							SendPlayerFormattedText(playerid,  lang_texts[56] , 0,COLOUR_LIGHTGREEN);
						}
						format(temp,sizeof(temp), lang_texts[57] ,price);
						SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
						set(temp,nullstr);
						SendPlayerFormattedText(playerid,  lang_texts[58] , 0,COLOUR_LIGHTGREEN);
					}
				} else {
					SendPlayerFormattedText(playerid,  lang_texts[59] , 0,COLOUR_LIGHTGREEN);
					format(temp,sizeof(temp), lang_texts[60] ,Businesses[id][Business_Cost]);
					SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
					set(temp,nullstr);
					format(temp,sizeof(temp), lang_texts[61] ,Businesses[id][Business_Level]);
					SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
					set(temp,nullstr);
					format(temp,sizeof(temp), lang_texts[62] ,Businesses[id][Business_Value]);
					SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
					set(temp,nullstr);
					SendPlayerFormattedText(playerid,  lang_texts[63] , 0,COLOUR_LIGHTGREEN);
				}
			} else {
				SendPlayerFormattedText(playerid,  lang_texts[64] , 0,COLOUR_RED);
			}
			return 1;
}

public FBisBuy(playerid) {
			new id=GetBusinessID(playerid);
			new temp[MAX_STRING];
			if (id > -1)
			{
				if (IsPlayerRegistered(playerid))
				{
					if (Player[playerid][Level] >= Businesses[id][Business_Level])
					{
						new price;
						price = Businesses[id][Business_Cost] + Businesses[id][Business_Buyout];
						if(Player[playerid][Money] >= price)
						{
							if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true) == 1)
							{
								SendPlayerFormattedText(playerid,  lang_texts[66] , 0,COLOUR_RED);
							} else {
								new owner=-1;
								for (new ownerid = 0; ownerid < MAX_PLAYERS; ownerid++)
								{
									if (IsPlayerConnected(ownerid))
									{
										if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(ownerid), true) == 1)
										{
											format(temp,sizeof(temp), lang_texts[67] ,Businesses[id][Business_Name],oGetPlayerName(playerid));
											SendPlayerFormattedText(ownerid, temp, 0,COLOUR_RED);
											set(temp,nullstr);
											owner=ownerid;
										}
									}
								}
								oGivePlayerMoney(playerid,0-price,1);
								if (owner > -1)
								{
									oGivePlayerMoney(owner,0+price,1);
								} else {
									new dinifilename[MAX_STRING];
									format(dinifilename,sizeof(dinifilename),"%sGTO.Player.%s.txt",PlayerDB,EncodeName(Businesses[id][Business_Owner]));
									if (dini_Exists(dinifilename))
									{
										new tempmoney;
										tempmoney = strval(dini_Get(dinifilename,"Money"));
										tempmoney = tempmoney + price;
										valstr(temp,tempmoney);
										dini_Set(dinifilename,"Money",temp);
										set(temp,nullstr);
									}
								}
								set(Businesses[id][Business_Owner],oGetPlayerName(playerid));
								Businesses[id][Business_Buyout] = 0;
								new dinifilename[MAX_STRING];
								format(dinifilename,sizeof(dinifilename),"%sGTO.Business.%s.txt",BusinessDB,Businesses[id][Business_Name]);
								if (dini_Exists(dinifilename))
								{
									dini_Set(dinifilename,"Owner",Businesses[id][Business_Owner]);
									valstr(temp,Businesses[id][Business_Buyout]);
									dini_Set(dinifilename,"Buyout",temp);
									set(temp,nullstr);
								}
								format(temp,sizeof(temp), lang_texts[68] ,Businesses[id][Business_Name]);
								SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
								set(temp,nullstr);

								new logstring[256];
								format(logstring, sizeof (logstring), "player: %d:  %s: bought the '%s' (business)",playerid,oGetPlayerName(playerid),Businesses[id][Business_Name]);
								WriteLog(logstring);

								if (Businesses[id][Business_Vault] > 0)
								{
									format(temp,sizeof(temp), lang_texts[69] ,Businesses[id][Business_Vault]);
									SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
									set(temp,nullstr);
								}
							}
						} else {
							SendPlayerFormattedText(playerid,  lang_texts[70] , 0,COLOUR_RED);
						}
					} else {
						format(temp,sizeof(temp), lang_texts[71] ,Businesses[id][Business_Level]);
						SendPlayerFormattedText(playerid, temp, 0,COLOUR_RED);
						set(temp,nullstr);
					}
				} else {
					SendPlayerFormattedText(playerid,  lang_texts[72] , 0,COLOUR_RED);
				}
			} else {
				SendPlayerFormattedText(playerid,  lang_texts[73] , 0,COLOUR_RED);
			}
			return 1;
	}


public FBisSell(playerid) {
			new id=GetBusinessID(playerid);
			new temp[MAX_STRING];
			if (id > -1)
			{
				if (IsPlayerRegistered(playerid))
				{
					if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true) == 0)
					{
						SendPlayerFormattedText(playerid,  lang_texts[75] , 0,COLOUR_RED);
					} else {
						new price;
						price = Businesses[id][Business_Cost] + Businesses[id][Business_Buyout];
						price = (price * 85) / 100;
						oGivePlayerMoney(playerid,0+price,1);
						set(Businesses[id][Business_Owner],"Unknown");
						Businesses[id][Business_Buyout] = 0;
						new dinifilename[MAX_STRING];
						format(dinifilename,sizeof(dinifilename),"%sGTO.Business.%s.txt",BusinessDB,Businesses[id][Business_Name]);
						if (dini_Exists(dinifilename))
						{
							dini_Set(dinifilename,"Owner","Unknown");
							valstr(temp,Businesses[id][Business_Buyout]);
							dini_Set(dinifilename,"Buyout",temp);
							set(temp,nullstr);
						}
						format(temp,sizeof(temp), lang_texts[76] ,Businesses[id][Business_Name]);
						SendPlayerFormattedText(playerid, temp, 0,COLOUR_LIGHTGREEN);
						set(temp,nullstr);
//						SendPlayerFormattedText(playerid,  lang_texts[77] , 0,COLOUR_LIGHTGREEN);
						if (Businesses[id][Business_Vault] > 0)
						{
							format(temp,sizeof(temp), lang_texts[78] ,Businesses[id][Business_Vault]);
							SendPlayerFormattedText(playerid, temp, 0,COLOUR_RED);
							set(temp,nullstr);
							SendPlayerFormattedText(playerid,  lang_texts[79] , 0,COLOUR_RED);
						}
						new logstring[256];
						format(logstring, sizeof (logstring), "player: %d:  %s: sold the '%s' (business)",playerid,oGetPlayerName(playerid),Businesses[id][Business_Name]);
						WriteLog(logstring);
					}
				} else {
					SendPlayerFormattedText(playerid,  lang_texts[80] , 0,COLOUR_RED);
					SendPlayerFormattedText(playerid,  lang_texts[81] , 0,COLOUR_RED);
				}
			} else {
				SendPlayerFormattedText(playerid,  lang_texts[82] , 0,COLOUR_RED);
			}
			return 1;
	}



public FBisCollect(playerid) {
			new id=GetBusinessID(playerid);
			new temp[MAX_STRING];
			if (id > -1)
			{
				if (IsPlayerRegistered(playerid))
				{
					if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true) == 0)
					{
						SendPlayerFormattedText(playerid,  lang_texts[93] , 0,COLOUR_RED);
					} else {
						if(Businesses[id][Business_Vault] > 0)
						{
							oGivePlayerMoney(playerid,0+Businesses[id][Business_Vault],1);
							SendPlayerFormattedText(playerid,  lang_texts[94] , 0,COLOUR_LIGHTGREEN);
							Businesses[id][Business_Vault] = 0;
							new dinifilename[MAX_STRING];
							format(dinifilename,sizeof(dinifilename),"%sGTO.Business.%s.txt",BusinessDB,Businesses[id][Business_Name]);
							if (dini_Exists(dinifilename))
							{
								valstr(temp,Businesses[id][Business_Vault]);
								dini_Set(dinifilename,"Vault",temp);
								set(temp,nullstr);
							}
						} else {
							SendPlayerFormattedText(playerid,  lang_texts[95] , 0,COLOUR_RED);
						}
					}
				} else {
					SendPlayerFormattedText(playerid,  lang_texts[96] , 0,COLOUR_RED);
					SendPlayerFormattedText(playerid,  lang_texts[97] , 0,COLOUR_RED);
				}
			} else {
				SendPlayerFormattedText(playerid,  lang_texts[98] , 0,COLOUR_RED);
			}
	}




public FBisBises(playerid) {
		new temp[MAX_STRING];
		for (new id=0;id<MAX_BUSINESSES;id++)
		{
			if(strcomp(Businesses[id][Business_Owner], "Unknown", true) == 0)
			{
				format(temp,sizeof(temp), lang_texts[99] ,Businesses[id][Business_Name],Businesses[id][Business_Owner]);
				SendPlayerScrollingText(playerid,temp);
				set(temp,nullstr);
			} else {
				format(temp,sizeof(temp), lang_texts[100] ,Businesses[id][Business_Name]);
				SendPlayerScrollingText(playerid,temp);
				set(temp,nullstr);
			}
		}
		return 1;
	}


public FBisMyBises(playerid) {
		new temp[MAX_STRING];
		new count = 0;
		for (new id=0;id<MAX_BUSINESSES;id++)
		{
			if(strcomp(Businesses[id][Business_Owner], oGetPlayerName(playerid), true) == 1)
			{
				count++;
				format(temp,sizeof(temp), lang_texts[101] ,Businesses[id][Business_Name],Businesses[id][Business_Vault]);
				SendPlayerScrollingText(playerid,temp);
				set(temp,nullstr);
			}
		}
		if(count < 1)
		{
			SendPlayerFormattedText(playerid,  lang_texts[102] , 0,COLOUR_RED);
		}
		return 1;
	}

