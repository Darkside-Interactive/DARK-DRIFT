#include <a_samp>
#include <mxINI>
#include <sscanf2>
//=====================================
#define MAX_KLANS 50 // ������������ ���-�� ������.
#define KLAN_MENU 1 // ������� �� ��������� �� �������.
#define KLAN_CREATE 2 // ������� �� ��������� �� �������.
#define KLAN_COLOR 3 // ������� �� ��������� �� �������.
#define KLAN_INVITE 4 // ������� �� ��������� �� �������.
#define KLAN_UNINVITE 5 // ������� �� ��������� �� �������.
#define KLAN_ZAM 6 // ������� �� ��������� �� �������.
#define KLAN_COLOR2 7 // ������� �� ��������� �� �������.
#define KLAN_DELETE 8 // ������� �� ��������� �� �������.
#define KLAN_SELECT 10 // ������� �� ��������� �� �������.
#define KLAN_UNZAM 11 // ������� �� ��������� �� �������.
new ID_KLANS;
static BIGSTR[1000];
static STR[256];
enum klans
{
	kOwner[32],
	kName[35],
	kParty,
	kRang[32],
	kColor
};
new KlanInfo[MAX_KLANS][klans];
static const KLN0[4][] =
{
	{"{006400}����� ���������� � ���� �������� ������ �����!\n\n"},
	{"{FF8C00}� ��������� ����� ��� ��� ���� ������� ����� �����������, � ������:\n"},
	{"{FF0000}---> {FFFFFF}���������� � �������� ������� �� �����!\n{FF0000}---> {FFFFFF}��������� ����������� �����!\n{FF0000}---> {FFFFFF}�������� ���� �����!\n{FF0000}---> {FFFFFF}��� ������ ����� ����� ��������� ���!\n\n"},
	{"{FFFF00}������� �������� ������ �����:"}
};
static KLN1[7][1] =
{
 	{0xFF0000FF}, // �������
 	{0xFFFF00FF}, // ������
 	{0x006400FF}, // �������
 	{0x0000FFFF}, // �����
 	{0xFF8C00FF}, // ���������
 	{0xFFFFFFFF}, // �����
 	{0x800080FF} // ����������
};

//====
enum pInfo
{
	pKlan
};
new PlayerInfo[MAX_PLAYERS][pInfo];
//====
main(){}
public OnGameModeInit()
{
	print ("Clans Loading");
    LoadKlans();
	SetTimer("AntiTeleportNew", 1000,true);
	AddPlayerClass(307, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}
public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
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
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[128]; // ���� � ��� ���� ��� ����������, �� ������� ��.
    new string[256]; // ���� � ��� ���� ��� ����������, �� ������� ��.
	new idx; // ���� � ��� ���� ��� ����������, �� ������� ��.
    cmd = strtok(cmdtext, idx); // ���� � ��� ���� ��� ����������, �� ������� ��.
	if(strcmp(cmd,"/mklan", true) == 0)
	{
		if(PlayerInfo[playerid][pKlan] == 0) return SendClientMessage(playerid, -1, "� ��� ��� �����!");
		if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]],pName(playerid),true))
		{
			format(string,sizeof(string), "���� ����� - {1DE3CB}%s",KlanInfo[PlayerInfo[playerid][pKlan]][kName]);
 			ShowPlayerDialog(playerid, KLAN_MENU, DIALOG_STYLE_LIST,string,"���������� � ����\n������� �� �����\n��������� �����������\n����� �����������\n�������� ���� �����\n������� ����\n���������� �����","�������","������");
		}
		return 1;
	}
	else if(strcmp(cmd,"/cklan", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 1) return SendClientMessage(playerid, -1, "� ��� ��� ���� ����!");
	    format(BIGSTR,sizeof(BIGSTR), "%s%s%s%s", KLN0[0],KLN0[1],KLN0[2],KLN0[3]);
	    ShowPlayerDialog(playerid, KLAN_CREATE, DIALOG_STYLE_INPUT,"�������� �����",BIGSTR,"�����","������");
	    return 1;
	}
	else if(strcmp(cmd,"/klancolor", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 0) return 1;
	    new id = PlayerInfo[playerid][pKlan];
	    SetPlayerColor(playerid, KLN1[KlanInfo[id][kColor]][0]),SendClientMessage(playerid,KLN1[KlanInfo[id][kColor]][0], "�� �������� ���� ������ �����");
	    return 1;
	}
	else if(strcmp(cmd,"/klanoff", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 0) return SendClientMessage(playerid, -1, "�� �� �������� � �����!");
	    if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kOwner],pName(playerid),true)) return SendClientMessage(playerid, -1, "�� �� ������ ���� �� ������ �����!");
		if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],pName(playerid),true))
		{
		    strmid(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],"None",0,24,24);
		    KlanInfo[PlayerInfo[playerid][pKlan]][kParty]--;
			SaveClan(PlayerInfo[playerid][pKlan]);
			format(string, sizeof(string), "%s ������� ����!", pName(playerid));
	  		KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
	  		SaveClan(PlayerInfo[playerid][pKlan]);
			PlayerInfo[playerid][pKlan] = 0;
			SendClientMessage(playerid, -1, "�� �������� ����!");
			//SavePlayer(playerid) // ������ �� ���� ������� ���������� ������.
		}
		else
		{
		    KlanInfo[PlayerInfo[playerid][pKlan]][kParty]--;
			SaveClan(PlayerInfo[playerid][pKlan]);
			format(string, sizeof(string), "%s ������� ����!", pName(playerid));
	  		KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
			PlayerInfo[playerid][pKlan] = 0;
			SendClientMessage(playerid, -1, "�� �������� ����!");
		    //SavePlayer(playerid) // ������ �� ���� ������� ���������� ������.
		}
		return 1;
	}
	else if(strcmp(cmd,"/klanchat", true) == 0 || strcmp(cmd,"/kc", true) == 0)
	{
	    if(PlayerInfo[playerid][pKlan] == 0) return SendClientMessage(playerid, -1, "�� �� �������� � �����!");
	    if(strcmp(KlanInfo[PlayerInfo[playerid][pKlan]],"None",false))
		{
		    new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kOwner],pName(playerid),true))
			{
				format(string, sizeof(string), "��������� ����� - %s[%d]: {FFFFFF}%s", pName(playerid), playerid, result);
				KlanMsg(KLN1[KlanInfo[PlayerInfo[playerid][pKlan]][kColor]][0], string, PlayerInfo[playerid][pKlan]);
				return 1;
			}
			else if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],pName(playerid),true))
			{
			    format(string, sizeof(string), "����������� - %s[%d]: {FFFFFF}%s", pName(playerid), playerid, result);
				KlanMsg(KLN1[KlanInfo[PlayerInfo[playerid][pKlan]][kColor]][0], string, PlayerInfo[playerid][pKlan]);
				return 1;
			}
			else
			{
			    format(string, sizeof(string), "������� - %s[%d]: {FFFFFF}%s", pName(playerid), playerid, result);
				KlanMsg(KLN1[KlanInfo[PlayerInfo[playerid][pKlan]][kColor]][0], string, PlayerInfo[playerid][pKlan]);
				return 1;
			}
		}
		return 1;
	}
	else if(strcmp(cmd,"/give", true) == 0)
	{
		PlayerInfo[playerid][pKlan] = 1;
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
 	SetPlayerPos(playerid, fX,fY,fZ);
  	SetPlayerInterior(playerid, 0);
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
	new string[258];
	switch(dialogid)
	{
	    case KLAN_MENU:
	    {
	        if(!response) return 1;
	        switch(listitem)
	        {
	            case 0: ShowPlayerDialog(playerid, KLAN_INVITE,DIALOG_STYLE_INPUT,"���������� ������ � ����","������� ID ������, �������� ������ ����������:","����������","������");
	            case 1: ShowPlayerDialog(playerid, KLAN_UNINVITE,DIALOG_STYLE_INPUT,"������� �� �����","������� ID ������, �������� ������ �������:","�������","������");
	            case 2: ShowPlayerDialog(playerid, KLAN_ZAM,DIALOG_STYLE_INPUT,"�����������","������� ID ������, �������� ������ ��������� ������������:","������","������");
	            case 3: ShowPlayerDialog(playerid, KLAN_UNZAM,DIALOG_STYLE_INPUT,"�����������","������� ID ������, �������� ������ ����� � �����������:","������","������");
	            case 4: ShowPlayerDialog(playerid, KLAN_COLOR2,DIALOG_STYLE_LIST,"���� �����","{FF0000}�������\n{FFFF00}������\n{006400}�������\n{0000FF}�����\n{FF8C00}���������\n{FFFFFF}�����\n{800080}����������","������","������");
	            case 5: ShowPlayerDialog(playerid, KLAN_DELETE,DIALOG_STYLE_MSGBOX,"�������� �����","�� ������������� ������ ������� ����?","��","���");
	            case 6:
				{
				    new color[100];
        			if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 0) {color = "{FF0000}�������";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 1) {color = "{FFFF00}������";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 2) {color = "{006400}�������";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 3) {color = "{0000FF}�����";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 4) {color = "{FF8C00}���������";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 5) {color = "{FFFFFF}�����";}
			        else if(KlanInfo[PlayerInfo[playerid][pKlan]][kColor] == 6) {color = "{800080}����������";}
					format(string,sizeof(string), "{FFFFFF}���� �����: %s\n{FFFFFF}�����������: {FF8C00}%s\n{FFFFFF}����������: {FF8C00}%d", color,KlanInfo[PlayerInfo[playerid][pKlan]][kRang],KlanInfo[PlayerInfo[playerid][pKlan]][kParty]);
					ShowPlayerDialog(playerid, 0,DIALOG_STYLE_MSGBOX,"���������� �����.",string,"������","");
				}
	        }
	    }
	    case KLAN_CREATE:
	    {
	        if(!response) return SendClientMessage(playerid, -1, "�� ���������� �� �������� �����!");
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid,KLAN_CREATE,DIALOG_STYLE_INPUT, "{FF0000}������!", "{FFFFFF}������ �������� �� ������ ���� ������ 6-� � ������ 35-� ��������!\n������� �������� ��� ���:", "�����", "�������");
	        if(strlen(inputtext) > 35) return ShowPlayerDialog(playerid,KLAN_CREATE,DIALOG_STYLE_INPUT, "{FF0000}������!", "{FFFFFF}������ �������� �� ������ ���� ������ 6-� � ������ 35-� ��������!\n������� �������� ��� ���:", "�����", "�������");
	        if(strlen(inputtext) < 6) return ShowPlayerDialog(playerid,KLAN_CREATE,DIALOG_STYLE_INPUT, "{FF0000}������!", "{FFFFFF}������ �������� �� ������ ���� ������ 6-� � ������ 35-� ��������!\n������� �������� ��� ���:", "�����", "�������");
	        for(new k; k <= ID_KLANS; k++)
	        {
	            if(!strcmp(KlanInfo[k][kName],"None",true))
		    	{
		    	    SetPVarString(playerid, "KLAN_NAME",inputtext);
		    	    ShowPlayerDialog(playerid, KLAN_COLOR,DIALOG_STYLE_LIST, "�������� ���� �����:",
					"{FF0000}�������\n{FFFF00}������\n{006400}�������\n{0000FF}�����\n{FF8C00}���������\n{FFFFFF}�����\n{800080}����������","�������","������");
				}
				else SendClientMessage(playerid, -1, "���� � ����� ��������� ��� ����������!");
			}
	    }
	    case KLAN_COLOR:
	    {
	        if(!response) return SendClientMessage(playerid, -1, "�� ���������� �� �������� �����!"),DeletePVar(playerid,"KLAN_NAME");
	        switch(listitem)
	        {
	            case 0: SetPVarInt(playerid, "KLAN_COLOR", 0);
	            case 1: SetPVarInt(playerid, "KLAN_COLOR", 1);
	            case 2: SetPVarInt(playerid, "KLAN_COLOR", 2);
	            case 3: SetPVarInt(playerid, "KLAN_COLOR", 3);
	            case 4: SetPVarInt(playerid, "KLAN_COLOR", 4);
	            case 5: SetPVarInt(playerid, "KLAN_COLOR", 5);
	            case 6: SetPVarInt(playerid, "KLAN_COLOR", 6);
	        }
	        SendClientMessage(playerid, -1, "���� ������� ������! ���������� ������ - {FFFF00}(/mklan)");
	        new NAME[35];
		 	ID_KLANS++,Save_ID_KLANS();
	        GetPVarString(playerid, "KLAN_NAME", NAME,sizeof(NAME));
	        strmid(KlanInfo[ID_KLANS][kOwner],pName(playerid),0,24,24);
		 	strmid(KlanInfo[ID_KLANS][kName],NAME,0,35,35);
			strmid(KlanInfo[ID_KLANS][kRang],"None",0,24,24);
			KlanInfo[ID_KLANS][kParty] = 0;
			KlanInfo[ID_KLANS][kColor] = GetPVarInt(playerid, "KLAN_COLOR");
			SaveClan(ID_KLANS),PlayerInfo[playerid][pKlan] = ID_KLANS;
			//SavePlayer(playerid) // ������ �� ���� ������� ���������� ������.
	    }
		case KLAN_INVITE:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_INVITE,DIALOG_STYLE_INPUT,"���������� ������ � ����","������� ID ������, �������� ������ ����������:","����������","������");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "������ ��� � ����!");
			if(PlayerInfo[strval(inputtext)][pKlan] == PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"���� ����� ������� � ����� �����!");
		    SetPVarInt(strval(inputtext), "KLANS_IDS", PlayerInfo[playerid][pKlan]);
		    SetPVarInt(strval(inputtext), "INV_PLAYERID", playerid);
			format(string,sizeof(string), "����� %s ���������� �������� � ���� %s", pName(playerid), KlanInfo[PlayerInfo[playerid][pKlan]][kName]);
		    ShowPlayerDialog(strval(inputtext), KLAN_SELECT, DIALOG_STYLE_MSGBOX, "����������� � ����!", string, "�������", "������");
			SendClientMessage(playerid, -1, "����������� ������ ������� �����������! �������� ������ ������.");
		}
		case KLAN_SELECT:
		{
			if(!response) return SendClientMessage(GetPVarInt(playerid, "INV_PLAYERID"), -1, "����� ��������� �������� � ��� ����!");
			SendClientMessage(GetPVarInt(playerid, "INV_PLAYERID"), -1, "����� ���������� �������� � ��� ����!");
			format(string, sizeof(string), "����� ������� ����� - %s!", pName(playerid));
			PlayerInfo[playerid][pKlan] = GetPVarInt(playerid, "KLANS_IDS");
			KlanMsg(0x006400FF,string,GetPVarInt(playerid, "KLANS_IDS"));
			KlanInfo[GetPVarInt(playerid, "KLANS_IDS")][kParty]++;
			SaveClan(GetPVarInt(playerid, "KLANS_IDS"));
			//SavePlayer(playerid) // ���� ������� ����������.
		}
		case KLAN_UNINVITE:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_UNINVITE,DIALOG_STYLE_INPUT,"������� �� �����","������� ID ������, �������� ������ �������:","�������","������");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "������ ��� � ����!");
		    if(PlayerInfo[strval(inputtext)][pKlan] != PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"���� ����� �� ������� � ����� �����!");
		    format(string, sizeof(string), "%s ������ �� ������� � ����� �����!", pName(playerid));
		    KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
			SendClientMessage(strval(inputtext),-1, "��� ������� �� �����!");
			PlayerInfo[strval(inputtext)][pKlan] = 0;
			//SavePlayer(playerid) // ���� ������� ����������.
			KlanInfo[PlayerInfo[playerid][pKlan]][kParty]--;
			SaveClan(PlayerInfo[playerid][pKlan]);
		}
		case KLAN_ZAM:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_ZAM,DIALOG_STYLE_INPUT,"�����������","������� ID ������, �������� ������ ��������� ������������:","������","������");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "������ ��� � ����!");
		    if(PlayerInfo[strval(inputtext)][pKlan] != PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"���� ����� �� ������� � ����� �����!");
		    if(!strcmp(KlanInfo[PlayerInfo[playerid][pKlan]],"None",true))
		    {
			    format(string, sizeof(string), "%s �������� ������������!", pName(playerid));
			    KlanMsg(0x006400FF,string,PlayerInfo[playerid][pKlan]);
				SendClientMessage(strval(inputtext),-1, "��� ��������� ������������!");
	            strmid(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],pName(strval(inputtext)),0,24,24);
				SaveClan(PlayerInfo[playerid][pKlan]);
			}
		}
		case KLAN_UNZAM:
		{
		    if(!response) return 1;
		    if(!strlen(inputtext)) return ShowPlayerDialog(playerid, KLAN_ZAM,DIALOG_STYLE_INPUT,"�����������","������� ID ������, �������� ������ ��������� ������������:","������","������");
		    if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, -1, "������ ��� � ����!");
		    if(PlayerInfo[strval(inputtext)][pKlan] != PlayerInfo[playerid][pKlan]) return SendClientMessage(playerid, -1,"���� ����� �� ������� � ����� �����!");
		    format(string, sizeof(string), "%s ���� � ��������� �����������!", pName(playerid));
		    KlanMsg(0xFF0000FF,string,PlayerInfo[playerid][pKlan]);
  			strmid(KlanInfo[PlayerInfo[playerid][pKlan]][kRang],"None",0,24,24);
			SaveClan(PlayerInfo[playerid][pKlan]);
		}
		case KLAN_COLOR2:
		{
		    if(!response) return 1;
		    switch(listitem)
		    {
		        case 0: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 0;
		        case 1: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 1;
		        case 2: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 2;
		        case 3: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 3;
		        case 4: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 4;
		        case 5: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 5;
		        case 6: KlanInfo[PlayerInfo[playerid][pKlan]][kColor] = 6;
		    }
		}
		case KLAN_DELETE:
		{
		    if(!response) return 1;
		    new ID_KLANS2 = PlayerInfo[playerid][pKlan];
		    SendClientMessage(playerid, -1, "���� ������� ������!");
	        strmid(KlanInfo[ID_KLANS2][kOwner],"None",0,24,24);
		 	strmid(KlanInfo[ID_KLANS2][kName],"None",0,35,35);
			strmid(KlanInfo[ID_KLANS2][kRang],"None",0,24,24);
			KlanInfo[ID_KLANS2][kParty] = 0;
			KlanInfo[ID_KLANS2][kColor] = 0;
			SaveClan(ID_KLANS2),PlayerInfo[playerid][pKlan] = 0;
			//SavePlayer(playerid) // ���� ������� ����������.
		}
	}
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
stock LoadKlans()
{
    if(!fexist("Klans/ID_KLANS.ini")) return print("File ID_KLANS.ini not found!");
    new file=ini_openFile("Klans/ID_KLANS.ini");
    ini_getInteger(file,"ID",ID_KLANS);
    ini_closeFile(file);
    if(!fexist("Klans/Klans.ini"))return print("File Klans.ini not found!");
    file = ini_openFile("Klans/Klans.ini");
    new str[50];
    for(new k = 1; k <= ID_KLANS; k++)
    {
        format(str,sizeof(str),"Number %d",k);
        ini_getString(file,str,STR);
       	sscanf(STR,"p<|>s[32]s[35]s[32]ii",KlanInfo[k][kOwner],KlanInfo[k][kName],KlanInfo[k][kRang],KlanInfo[k][kParty],KlanInfo[k][kColor]);
    }
    ini_closeFile(file);
    return printf("Loaded %d Klans\n",ID_KLANS);
}
stock SaveClan(k)
{
    new file=ini_openFile("Klans/Klans.ini");
	new str[50];
	format(str,sizeof(str),"Number %d",k);
	format(STR,sizeof(STR),"%s|%s|%s|%d|%d",KlanInfo[k][kOwner],KlanInfo[k][kName],KlanInfo[k][kRang],KlanInfo[k][kParty],KlanInfo[k][kColor]);
  	ini_setString(file,str,STR);
  	ini_closeFile(file);
}
stock KlanMsg(color,const string[],id_klans)
{
	for(new i = MAX_PLAYERS; i >= 0; i--)
	{
		if(!IsPlayerConnected(i)) continue;
		if(PlayerInfo[i][pKlan] == id_klans) SendClientMessage(i, color, string);
	}
	return true;
}
stock Save_ID_KLANS()
{
    new file = ini_openFile("Klans/ID_KLANS.ini");
    ini_setInteger(file,"ID",ID_KLANS);
    return ini_closeFile(file);
}
stock pName(playerid)
{
	new Nm[MAX_PLAYER_NAME];
	GetPlayerName(playerid,Nm,24);
	return Nm;
}
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
