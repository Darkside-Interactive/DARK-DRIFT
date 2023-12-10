#include <a_samp>

#define DUEL_MIR		2000
#define DUEL_ID         11777

new PlayerInDuel[MAX_PLAYERS];
new GetDuelCreate[MAX_PLAYERS];
new StartingDuel[MAX_PLAYERS];
new CountDuelTimer[MAX_PLAYERS];
new WeaponDuel = 24;
new MoneyDuel = 1000;
new bool:DuelPlaceVisit = false;

new Float:duelspawn[12][3] = {
{-1129.8909,1057.5424,1346.4141},
{-1103.7913,1086.7838,1341.9036},
{-1082.0232,1043.7269,1343.7159},
{-1053.5138,1023.3488,1343.1503},
{-1048.3635,1058.6753,1343.9337},
{-1060.6057,1092.9423,1342.9473},
{-1036.6921,1088.7567,1343.1466},
{-1015.7525,1069.8811,1344.1016},
{-1020.4619,1034.2771,1342.4492},
{-992.12230,1036.9589,1341.8861},
{-973.94290,1061.5148,1345.6714},
{-992.10420,1090.4716,1342.8617}
};

forward DuelStarting(playerid);

//==============================================================================

public OnPlayerConnect(playerid)
{
	PlayerInDuel[playerid] = 0;
	GetDuelCreate[playerid] = INVALID_PLAYER_ID;
	return 1;
}

//==============================================================================

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(CountDuelTimer[playerid]);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInDuel[i] == 1)
		    	{
				PlayerInDuel[i] = 0;
				DuelPlaceVisit = false;
				SendClientMessage(i, -1, "���� ��������� ������� �����");
				OnPlayerSpawn(i);
			}
  		}
	}
	return 1;
}

//==============================================================================

public OnPlayerSpawn(playerid)
{
	return 1;
}

//==============================================================================

public OnPlayerCommandText(playerid, cmdtext[])
{
    new string[1024], cmd[256], tmp[256], giveplayerid, idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/duel", true) == 0)
	{
		if(PlayerInDuel[playerid] == 1) return SendClientMessage(playerid, -1, "�� ��� ���������� � �����.");
		if(DuelPlaceVisit) return SendClientMessage(playerid, -1, "��������� ���� ����� ��� ����� �����������.");
		tmp = strtok(cmdtext, idx);
	  	if(!strlen(tmp)) return SendClientMessage(playerid, 0xB22222FF, "�������������:{FFFFFF} /duel [ID ������] [ID ������] [������] | ������ ID'�� ������ /glist");
	  	giveplayerid = strval(tmp);
	  	tmp = strtok(cmdtext, idx);
	  	if(!strlen(tmp)) return SendClientMessage(playerid, 0xB22222FF, "�������������:{FFFFFF} /duel [ID ������] [ID ������] [������] | ������ ID'�� ������ /glist");
	  	WeaponDuel = strval(tmp);
	  	if(WeaponDuel < 0 || WeaponDuel > 42) return SendClientMessage(playerid, -1, "�� ��� �� ������ ID ������ | ������ ID'�� ������ /glist");
	  	tmp = strtok(cmdtext, idx);
	  	if(!strlen(tmp)) return SendClientMessage(playerid, 0xB22222FF, "�������������:{FFFFFF} /duel [ID ������] [ID ������] [������] | ������ ID'�� ������ /glist");
	  	MoneyDuel = strval(tmp);
	  	if(MoneyDuel < 1 || MoneyDuel > 10000000) return SendClientMessage(playerid, -1, "�� ��� �� ������ ����� ������ | ��������� ����� �� 1$ �� 10.000.000$");
	  	if(MoneyDuel > GetPlayerMoney(playerid)) return SendClientMessage(playerid, -1, "���� �� ������� �� ������ | ����� ������ �����");
		if(MoneyDuel > GetPlayerMoney(giveplayerid)) return SendClientMessage(playerid, -1, "������ ���������� �� ������� �� ������ | ����� ������ �����");
		if(IsPlayerConnected(giveplayerid))
	  	{
			new Float:POS[3];
  			GetPlayerPos(giveplayerid, POS[0], POS[1], POS[2]);
	  	    if(playerid == giveplayerid) return SendClientMessage(playerid, -1, "�� �� ������ ��������� ��� �������� � ������ ����");
	        if(!IsPlayerInRangeOfPoint(playerid, 5, POS[0], POS[1], POS[2])) return SendClientMessage(playerid, -1, "�� ���������� ������� ������ �� ����� ������");
		  	if(PlayerInDuel[giveplayerid] == 1) return SendClientMessage(playerid, -1, "���� ����� ��� ��������� � �����");
	  	   	GetDuelCreate[giveplayerid] = playerid;
	        format(string, sizeof(string), "�� ��������� ����������� {FF9900}%s{FFFFFF} �� �����! ������� ������.", pNick(giveplayerid));
	        SendClientMessage(playerid, -1, string);
	        format(string, sizeof(string), "����� %s ���������� ���� �� �����\n\n������: %d\n������: %d$", pNick(playerid), WeaponDuel, MoneyDuel);
	        ShowPlayerDialog(giveplayerid, DUEL_ID, DIALOG_STYLE_MSGBOX, "����������� �� �����", string, "��", "���");
      		}
	  	else
  		{
		  	SendClientMessage(playerid, -1, "����� � ��������� ID �� ������");
	  	}
	  	return 1;
	}
	return 0;
}

//==============================================================================

public DuelStarting(playerid)
{
    	new string[256];
    	StartingDuel[playerid] -= 1;
    	format(string, sizeof(string), "~y~STARTING: ~w~%d", StartingDuel[playerid]);
    	GameTextForPlayer(playerid, string, 999, 3);
    	SetPlayerHealth(playerid, 100);
    	if(StartingDuel[playerid] == 0)
    	{
			GameTextForPlayer(playerid, "~g~DUEL START", 3000, 3);
			TogglePlayerControllable(playerid, true);
			KillTimer(CountDuelTimer[playerid]);
    	}
		return 1;
}

//==============================================================================

public OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerInDuel[killerid] == 1 && PlayerInDuel[playerid] == 1)
	{
		new string[256];
		DuelPlaceVisit = false;
		PlayerInDuel[killerid] = 0;
		PlayerInDuel[playerid] = 0;
		GetDuelCreate[killerid] = INVALID_PLAYER_ID;
		GetDuelCreate[playerid] = INVALID_PLAYER_ID;
		GivePlayerMoney(killerid, MoneyDuel);
		GivePlayerMoney(playerid, -MoneyDuel);
		format(string, sizeof(string), "~g~+%d$", MoneyDuel);
		GameTextForPlayer(killerid, string, 1000, 1);
		format(string, sizeof(string), "~r~-%d$", MoneyDuel);
		GameTextForPlayer(playerid, string, 1000, 1);
		format(string, sizeof(string), ">> � ����� ����� �������� {FFFFFF}%s{00FF00} � {FFFFFF}%s{00FF00} ������� ����� {FFFFFF}%s", pNick(killerid), pNick(playerid), pNick(killerid));
	  	SendClientMessageToAll(0x00FF00FF, string);
	  	SetTimerEx("OnPlayerSpawn", 1000, false, "i", killerid);
		return 1;
  	}
	return 1;
}

//==============================================================================

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new string[1024];
	new dueledid = GetDuelCreate[playerid];
	if(dialogid == DUEL_ID)
	{
		if(response)
		{
			if(PlayerInDuel[playerid] == 1)
			{
		 		SendClientMessage(playerid, -1, "�� ��� ���������� � �����");
				SendClientMessage(dueledid, -1, "��� ���������� �� ������� � ����� ��������� ������");
				GetDuelCreate[playerid] = INVALID_PLAYER_ID;
				return 1;
			}
			if(PlayerInDuel[dueledid] == 1)
			{
		 		SendClientMessage(playerid, -1, "�����, ���������� ���� �����������, ��� ��������� � �����");
				SendClientMessage(dueledid, -1, "��� ���������� �� ������� � ����� ��������� ������");
				GetDuelCreate[playerid] = INVALID_PLAYER_ID;
				return 1;
	  		}
			if(DuelPlaceVisit)
			{
		 		SendClientMessage(playerid, -1, "������� ���� ����� ��� ����� �����������");
				SendClientMessage(dueledid, -1, "������� ���� ����� ��� ����� �����������");
				GetDuelCreate[playerid] = INVALID_PLAYER_ID;
				return 1;
			}
			if(IsPlayerConnected(dueledid))
	  		{
    			PlayerInDuel[playerid] = 1;
				PlayerInDuel[dueledid] = 1;
				DuelPlaceVisit = true;
 				new rand1 = random(sizeof(duelspawn));
			    SetPlayerPos(playerid, duelspawn[rand1][0], duelspawn[rand1][1], duelspawn[rand1][2]);
    			new rand2 = random(sizeof(duelspawn));
    			SetPlayerPos(dueledid, duelspawn[rand2][0], duelspawn[rand2][1], duelspawn[rand2][2]);
    			SetCameraBehindPlayer(playerid);
				SetCameraBehindPlayer(dueledid);
   				SetPlayerInterior(playerid, 10);
				SetPlayerInterior(dueledid, 10);
				SetPlayerHealth(dueledid, 100);
				SetPlayerHealth(playerid, 100);
   				SetPlayerVirtualWorld(playerid, DUEL_MIR);
				SetPlayerVirtualWorld(dueledid, DUEL_MIR);
   				TogglePlayerControllable(playerid, false);
				TogglePlayerControllable(dueledid, false);
   				StartingDuel[playerid] = 6;
				StartingDuel[dueledid] = 6;
   				CountDuelTimer[playerid] = SetTimerEx("DuelStarting", 1000, true, "i", playerid);
   				CountDuelTimer[dueledid] = SetTimerEx("DuelStarting", 1000, true, "i", dueledid);
   				ResetPlayerWeapons(playerid);
				ResetPlayerWeapons(dueledid);
				GivePlayerWeapon(playerid, WeaponDuel, 99999);
				GivePlayerWeapon(dueledid, WeaponDuel, 99999);
				GetDuelCreate[playerid] = INVALID_PLAYER_ID;
      			}
      			else
			{
				SendClientMessage(playerid, -1, "�����, ���������� ���� �����������, ������������");
				GetDuelCreate[playerid] = INVALID_PLAYER_ID;
			}
  		}
  		else
  		{
			format(string, sizeof(string), "�� ��������� �� ������� � ����� � ������� {FF9900}%s", pNick(dueledid));
			SendClientMessage(playerid, -1, string);
			format(string, sizeof(string), "����� {FF9900}%s{FFFFFF} ��������� �� ������� � ����� � �����", pNick(playerid));
  			SendClientMessage(GetDuelCreate[playerid], -1, string);
			GetDuelCreate[playerid] = INVALID_PLAYER_ID;
  		}
  		return 1;
  	}
	return 1;
}

//==============================================================================

stock pNick(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
	return nick;
}

//==============================================================================

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
