#pragma tabsize 0

#define SCM SendClientMessage
#define FACTIONS 20 //изменяем на количество фракций.
#define MAX_GANGZONES 200 //максимальное кол-во гангзон (ставим свое число)
#define REOWN_TURF 4  //число убиств для автоматического захвата
#define TEAM_GROVE 0
#define timersek 5 // для таймера

//--------------ЦВЕТА-------------------
#define red 0xAA3333AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_RED 0xFF0000FF


AntiDeAMX()
{
    new sam[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused sam
}


main()
{
	print("\n-------GANGZONES FROM SAN Andreas----");
	print("----------BY VITALIK-SAM---------------");
	print("-------------LOADED-------------------\n");
}

forward vsembabla();
forward StopAttacking(gangzone, newowner);
forward split(const strsrc[], strdest[][], delimiter);

enum pInfo
{
pMember,
pCash,//для бабла
pLeader
};
new PlayerInfo[MAX_PLAYERS][pInfo];
enum gzInfo
{
	gzDescription[32],
	gzOwner,
	Float:gzX[2],
	Float:gzZ[2],
	Float:gzY[2],
	gzID,
	gzAttackers,
	gzKilled,
	gzTimer
};
new GZInfo[MAX_GANGZONES][gzInfo];//для ганг зон


/*=======================================FACTIONS INFO=============================*/

enum factionInfo
{
    factionName[32],
	factionColor,
	allowedToSee,
	allowedToAttack
};

new FactionInfo[FACTIONS+1][factionInfo];
stock LoadFactionList() 
{
// Скрипт зон разработал Vitalik_Sam
	new File:file = fopen("Logs/factions.txt");
	if(!file) return printf("Error loading faction list!");
	new string[256], tmp[4][56];
	for(new i=0;i<sizeof(FactionInfo);i++)
	{
		if(!fread(file, string)) break;
		split(string, tmp, ',');
		format(FactionInfo[i][factionName], 32, "%s", tmp[0]);
		FactionInfo[i][factionColor] = strval(tmp[1]);
		FactionInfo[i][allowedToSee] = strval(tmp[2]);
		FactionInfo[i][allowedToAttack] = strval(tmp[3]);
		printf("Faction %d: %s, %x, %d, %d", FactionInfo[i][factionName], FactionInfo[i][factionColor], FactionInfo[i][allowedToSee], FactionInfo[i][allowedToAttack]);

	}
	fclose(file);
	return 1;
}
/*=======================================GANGZONES INFO============================*/
stock LoadGangZones()
{
// Скрипт зон разработал Vitalik_Sam
	new File:file=fopen("gangzones/gangzones.txt");
	if(!file) return printf("Error loading gangzones!");
	new string[256], tmp[7][56], i = 0, Float:x;
	while(fread(file, string))
	{
	    if(i >= MAX_GANGZONES) break;
		split(string, tmp, ',');
		format(GZInfo[i][gzDescription], 32, "%s", tmp[0]); 
		GZInfo[i][gzOwner] = strval(tmp[1]);
		GZInfo[i][gzX][0] = strval(tmp[2]);
		GZInfo[i][gzY][0] = strval(tmp[3]);
		GZInfo[i][gzZ][0] = strval(tmp[4]);
		GZInfo[i][gzX][1] = strval(tmp[5]);
		GZInfo[i][gzY][1] = strval(tmp[6]);
		if(GZInfo[i][gzX][0] > GZInfo[i][gzX][1])
		{
		    x = GZInfo[i][gzX][1];
		    GZInfo[i][gzX][1] = GZInfo[i][gzX][0];
		    GZInfo[i][gzX][0] = x;
		}
		if(GZInfo[i][gzY][0] > GZInfo[i][gzY][1])
		{
		    x = GZInfo[i][gzY][1];
		    GZInfo[i][gzY][1] = GZInfo[i][gzY][0];
		    GZInfo[i][gzY][0] = x;
		}
		GZInfo[i][gzAttackers] = 0;
		GZInfo[i][gzID] = GangZoneCreate(GZInfo[i][gzX][0], GZInfo[i][gzY][0], GZInfo[i][gzX][1], GZInfo[i][gzY][1]);
		i++;
	}
	fclose(file);
	printf("========================================================");
	printf("     ***     GangZones have been loaded!    ****       ");
	printf("========================================================");
	return 1;
}
stock SaveGangZones()
{
// Скрипт зон разработал Vitalik_Sam
	new File:file=fopen("gangzones/gangzones.txt");
	if(!file) return printf("Error saving gangzones!");
	new string[256];
	for(new i=0;i<sizeof(GZInfo);i++)
	{
		if(GZInfo[i][gzX][0] != 0)
		{
		    format(string, sizeof(string), "%s, %d, %f, %f,%f, %f, %f\n",
		 	   GZInfo[i][gzDescription],GZInfo[i][gzOwner], GZInfo[i][gzX][0], GZInfo[i][gzY][0], GZInfo[i][gzZ][0], GZInfo[i][gzX][1], GZInfo[i][gzY][1]
		    );
			fwrite(file, string);
		}
	}
	fclose(file);
	printf("============================");
	printf("GangZones have been saved!");
	printf("============================");
	return 1;
}

stock GetFactionColor(factionid)
{
	// название банд подстраивайте под себя
	// цвета тоже подстраивайте под себя
   // Скрипт зон разработал Vitalik_Sam
	switch(factionid)
	{
		/*(0)Groove */                   case 11: return 0x009933AA;  //groove
		/*(1)The Ballas*/               case 12: return 0xCC66FFAA;  //ballas
		/*(2)Varios Los Aztecas*/       case 13: return 0x99FFFFAA;  //aztec
		/*(3)Los Santos Vagos    */     case 14: return 0xFFFF66AA;  //vagos
		/*(4)Da Nang Boys          */   case 15: return 0xFFFFFFAA;  //Da Nang Boys
		/*(5)San Fierro Rifa      */    case 16: return 0x00CCFFAA; //rifa
		/*(6)The Traids           */    case 17: return 0x00000088; //triads
		/*(7)The Traids           */    case 18: return 0x663300AA; //bikers
		/*(8)Bikers            */    case 19: return 0x330033AA; //RM
	}
	return 0xFFFFFFAA;
}

stock CanFactionSeeZones(factionid)
{
	switch(factionid)
	{
	// 5,6,11-19 фракции будут видить зоны , т.е LCN Yakuza и все банды но захватывать могут только Банды
	// фракции подстраивайте под себя
   // Скрипт зон разработал Vitalik_Sam
	    case 5,6,11..19: return true;//видят банды и семьи
	    default: return false;
	}
	return false;
}

bool: CanFactionAttackZones(factionid)//bool:
{
	switch(factionid)
	{
	    case 11..19:return true;
	    default: return false;
	}
	return false;
}

stock GetPlayerFaction(playerid)
{
	if(PlayerInfo[playerid][pMember] != 0) return PlayerInfo[playerid][pMember];
	else if(PlayerInfo[playerid][pLeader] != 0) return PlayerInfo[playerid][pLeader];
	else return 0;
}

stock GetPlayerTerritory(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	for(new i=0;i<sizeof(GZInfo);i++)
	{
	    if(GZInfo[i][gzX][0] <= x && x <= GZInfo[i][gzX][1] && GZInfo[i][gzY][0] <= y  && y <= GZInfo[i][gzY][1])
		    return i;
	}
	return -1;
}
stock OnBusJobsLabels(playerid)
{
     if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
     {Delete3DTextLabel(TextBuss[playerid]);return 1;}
}
stock ShowPlayerZones(playerid, bool:show = true)
{
	if(show == false)
	{
	    for(new i=0;i<sizeof(GZInfo);i++)
	    {
	        GangZoneHideForPlayer(playerid, GZInfo[i][gzID]);
	    }
	    return;
	}
	new faction= GetPlayerFaction(playerid);
    if(CanFactionSeeZones(faction) == 1)
	{
		for(new i=0;i<sizeof(GZInfo);i++)
	    {
				GangZoneShowForPlayer(playerid, GZInfo[i][gzID], GetFactionColor(GZInfo[i][gzOwner]));
    	}
	}
    return;
}

stock StartAttacking(gangzone, attackers, defenders, time = 80000)
{
	if(gangzone < 0 || gangzone >= MAX_GANGZONES || attackers == defenders || attackers == 0) return 1;
	printf("StartAttacking: 1");
 //#############################################################################
	new otext[20];
	// название банд подстраивайте под себя
	// defenders== (число) никогда не менять иначе не будут захватываться зоны
   // Скрипт зон разработал Vitalik_Sam
	if(defenders== 11) { otext = "Groove"; }
	else if(defenders == 12) { otext = "The Ballas"; }
	else if(defenders == 13) { otext = "Varios Los Aztecas"; }
	else if(defenders == 14) { otext = "Los Santos Vagos"; }
	else if(defenders == 15) { otext = "Da Nang Boys"; }
	else if(defenders == 16) { otext = "San Fierro Rifa"; }
	else if(defenders == 17) { otext = "The Traids "; }
	else if(defenders == 18) { otext = "Biker"; }
	else if(defenders == 19) { otext = "Mafia"; }
	//-----------
	new otextt[20];
	// название банд подстраивайте под себя
	// attackers == (число) никогда не менять иначе не будут захватываться зоны
   // Скрипт зон разработал Vitalik_Sam
	if(attackers == 11) { otextt = "Groove"; }
	else if(attackers == 12) { otextt = "The Ballas"; }
	else if(attackers == 13) { otextt = "Varios Los Aztecas"; }
	else if(attackers == 14) { otextt = "Los Santos Vagos"; }
	else if(attackers == 15) { otextt = "Da Nang Boys"; }
	else if(attackers == 16) { otextt = "San Fierro Rifa"; }
	else if(attackers == 17) { otextt = "The Traids "; }
	else if(attackers == 18) { otextt = "Biker"; }
	else if(attackers == 19) { otextt = "Mafia"; }
//##############################################################################
	new faction, string[256];
	format(string, sizeof(string), "[GANGWARNING]: Территория %s (принадлежащая банде %s) была атакована бандой %s", GZInfo[gangzone][gzDescription], otext, otextt);
    printf("StartAttacking: 2");
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		faction = GetPlayerFaction(playerid);
        if(CanFactionSeeZones(faction) == 1)
		{
			GangZoneFlashForPlayer(playerid, GZInfo[gangzone][gzID], FactionInfo[GZInfo[gangzone][gzOwner]][factionColor]);
			SCM(playerid, COLOR_RED, string);
		}
	}
	GZInfo[gangzone][gzAttackers] = attackers;
	printf("StartAttacking: 3");
	SetTimerEx("StopAttacking", time, 0, "%d%d", gangzone, attackers);
	printf("StartAttacking: 4");
	return 1;
}

forward StopAttacking(gangzone, newowner);
public StopAttacking(gangzone, newowner)
{
	new faction, string[256];
	new otext[20];
	// название банд подстраивайте под себя
	// newowner== (число) никогда не менять иначе не будут захватываться зоны
   // Скрипт зон разработал Vitalik_Sam
	if(newowner== 11) { otext = "Groove"; }
	else if(newowner == 12) { otext = "The Ballas"; }
	else if(newowner == 13) { otext = "Varios Los Aztecas"; }
	else if(newowner == 14) { otext = "Los Santos Vagos"; }
	else if(newowner == 15) { otext = "Da Nang Boys"; }
	else if(newowner == 16) { otext = "San Fierro Rifa"; }
	else if(newowner == 17) { otext = "The Triads "; }
	else if(newowner == 18) { otext = "Biker"; }
	else if(newowner == 19) { otext = "Mafia"; }
	if(newowner == GZInfo[gangzone][gzOwner])
	{
		format(string, sizeof(string), "[GANGWARNING]: Территория %s (принадлежит банде %s) была защищена.", GZInfo[gangzone][gzDescription], otext);
	}
	else
	{
		format(string, sizeof(string), "[GANGWARNING]: Территория %s (принадлежит банде %s) была захвачена бандой %s.", GZInfo[gangzone][gzDescription], GZInfo[gangzone][gzOwner], FactionInfo[newowner][factionName]);
	}
    PlayerInfo[newowner][pCash]+=100000;
	GZInfo[gangzone][gzOwner] = newowner;
	printf("Newowner:%d\n", GZInfo[gangzone][gzOwner]);
	GZInfo[gangzone][gzAttackers] = 0;
	new bool:found = false;
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		faction = GetPlayerFaction(playerid);
		if(faction == newowner) found = true;
	}
	if(found == false) format(string, sizeof(string), "[GANGWARNING]: Захватчики территории %s сбежали, территория остается нейтральной!", GZInfo[gangzone][gzDescription]);
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		faction = GetPlayerFaction(playerid);
        if(CanFactionSeeZones(faction) == 1)
		{
			GangZoneStopFlashForPlayer(playerid, GZInfo[gangzone][gzID]);
			ShowPlayerZones(playerid, false);
			ShowPlayerZones(playerid);
			SCM(playerid, COLOR_RED, string);
		}
	}
	KillTimer(GZInfo[gangzone][gzTimer]);
	GZInfo[gangzone][gzKilled] = 0;
	SaveGangZones(); 
	return 1;
}
forward vsembabla();
public vsembabla()
{
// Скрипт зон разработал Vitalik_Sam
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(GetPlayerFaction(i) == 3) GivePlayerMoney(i, 1000);// вместо 1000 поставьте свою цену 
	   //сколько нада чтобы выплатило банде за захват зоны
	}
}

public OnGameModeExit()
{
// Скрипт зон разработал Vitalik_Sam
	SaveGangZones();
	return 1;
}
public OnGameModeInit()
{
// Скрипт зон разработал Vitalik_Sam
	SetTimer("vsembabla", 300000, 1);
	LoadFactionList();
	LoadGangZones();
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
new cmd[256];
// Скрипт зон разработал Vitalik_Sam
// захват зоны если она никем еще не захвачена т.е она 0
if(!strcmp(cmd, "/takeit", true))
	{
		if(GetPlayerFaction(playerid) == 0) return SCM(playerid, red, "[СЕРВЕР]: Вы должны быть в банде!");
		printf("Debug: 1");
		if(CanFactionAttackZones(GetPlayerFaction(playerid)) == false) return SCM(playerid, red, "[СЕРВЕР]: Ваша банда не может захватывать территории!");
        printf("Debug: 2");
		if(GetPlayerTerritory(playerid) == -1) return SCM(playerid, red, "[СЕРВЕР]: Вы должны быть на незахваченной территории!");
        printf("Debug: 3");
		if(GZInfo[GetPlayerTerritory(playerid)][gzOwner] > 0) return SCM(playerid, red, "[СЕРВЕР]: Вы должны быть на нейтральной территории!");
	    printf("Debug: 4");
		SCM(playerid, COLOR_WHITE, "[GANGWARNING]: Вы начали захват Территории другой Банды! Ждите 120 секунд на этой территории!");
		printf("Debug: 5");
		StartAttacking(GetPlayerTerritory(playerid), GetPlayerFaction(playerid), 0, 80000);
		printf("Debug: 6");
	    return 1;
	}

	return 1;
	}
	
public split(const strsrc[], strdest[][], delimiter)
{
// Скрипт зон разработал Vitalik_Sam
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
	return 1;
}
public OnPlayerSpawn(playerid)
{
// Скрипт зон разработал Vitalik_Sam
    AntiDeAMX();
    return 1;
}