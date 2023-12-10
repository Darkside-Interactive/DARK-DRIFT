//MOTD Message module
//Created by MadCat
//Idea from FreeRoam 2.4c by ProRail

#include "base"

forward MOTD_OnGameModeInit();
forward MOTD_OnPlayerConnect(playerid);
forward LoadMOTD();

new MOTD_Line1[MAX_STRING] = "Добро пожаловать в Grand Theft Online 0.6.3b5 by SCALOlaz.";
new MOTD_Line2[MAX_STRING] = "Этот сервер имеет некоторые изменения, поэтому возможно все.";
new MOTD_Line3[MAX_STRING] = "Все самые последние изменения в моде GTO будут тестироваться здесь";
new MOTD_Line4[MAX_STRING] = "Ошибки, крэши, торможения - это обычное дело для тестового режима";
new MOTD_Color[MAX_STRING] = "FFFFFFAA";

public MOTD_OnGameModeInit(){
	LoadMOTD();
	WriteLog("MOTD loaded");
	return 0;
}

public LoadMOTD()
{
	Debug("motd.inc > LoadMOTD - Start");
	if (ForceOverwrite) {Debug("motd.inc > LoadMOTD - Stop"); return;}
	if (!dini_Exists(MOTDDB)) {Debug("motd.inc > LoadMOTD - Stop"); return;}
	new temp[MAX_STRING];
	set(temp,dini_Get(MOTDDB,"MOTD_Line1"));
	if (strlen(temp) > 0) set(MOTD_Line1,temp); 
	else { set(temp,MOTD_Line1); dini_Set(MOTDDB,"MOTD_Line1",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(MOTDDB,"MOTD_Line2"));
	if (strlen(temp) > 0) set(MOTD_Line2,temp); 
	else { set(temp,MOTD_Line2); dini_Set(MOTDDB,"MOTD_Line2",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(MOTDDB,"MOTD_Line3"));
	if (strlen(temp) > 0) set(MOTD_Line3,temp); 
	else { set(temp,MOTD_Line3); dini_Set(MOTDDB,"MOTD_Line3",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(MOTDDB,"MOTD_Line4"));
	if (strlen(temp) > 0) set(MOTD_Line4,temp); 
	else { set(temp,MOTD_Line4); dini_Set(MOTDDB,"MOTD_Line4",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(MOTDDB,"MOTD_Color"));
	if (strlen(temp) > 0) MOTD_Color = temp; 
	else { set(temp,MOTD_Color); dini_Set(MOTDDB,"MOTD_Color",temp);  }
	set(temp,nullstr);
	Debug("motd.inc > LoadMOTD - Stop");
	return;
}

public MOTD_OnPlayerConnect(playerid)
{
	Debug("motd.inc > MOTD_OnPlayerConnect - Start");
	new color = HexToInt(MOTD_Color);
	if (strlen(MOTD_Line1)) SendClientMessage(playerid,color,MOTD_Line1);
    	if (strlen(MOTD_Line2)) SendClientMessage(playerid,color,MOTD_Line2);
    	if (strlen(MOTD_Line3)) SendClientMessage(playerid,color,MOTD_Line3);
    	if (strlen(MOTD_Line4)) SendClientMessage(playerid,color,MOTD_Line4);
	Debug("motd.inc > MOTD_OnPlayerConnect - Stop");
}
