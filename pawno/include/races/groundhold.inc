//
// Created:     13.09.06
// Aurthor:    Iain Gilbert
//

#if defined _groundhold_included
#endinput
#endif

#define _groundhold_included
#pragma library groundhold
#include "base"
#include "player"
#include "world"

forward GroundholdInit();
forward CheckGround(ghid);
forward CountPlayers(players[]);
forward CheckAllGround();

#define GROUNDHOLD_DELAY 5000 // how often in seconds players are paid

enum gh_info {
	gh_name[MAX_NAME], // name of ground
	gh_money, // base amount of money recieved for holding this ground
	gh_xp, // base amount of xp recieved for holding this ground
	gh_multi, // max multiplyer of base
	gh_dist, // distance from checkpoint player can be to still receive pay
	Float:gh_x,
	Float:gh_y,
	Float:gh_z
}

#define GROUNDHOLD_SIZE 6
new PlayerGroundHoldTime[GROUNDHOLD_SIZE][MAX_PLAYERS];
new PlayerHoldingGround[GROUNDHOLD_SIZE][MAX_PLAYERS];
new groundholdActiveCPID[GROUNDHOLD_SIZE];
new groundholdCP[GROUNDHOLD_SIZE][gh_info] = {
	//      Name,       		pay ,   xp 	multi   dist,       x,          y,          z
	{"��������� �������",		1,	10,	10,	15,	2000.8861,	1539.0835,	13.5859},
//	{"������ 'Shithole'",		10,	2,	7,	15,	2081.8914, 	2173.5374, 	10.5474},
	
	{"����� �����",			2,	10,	 4,	15,	2491.5679,	-1668.6174,	13.3438},
//	{"���� ����", 			2,	2,	 6,	15,	1968.7186,	-1200.1226,	17.4500},
	{"���� �������'",		1,	2,	10,	15,	-2333.813232,	-1630.865356,	483.428253},
//	{"�������������� '������'",	3,	2,	10,	15,	-2068.970947,	228.978775,	39.051757},
	{"��� ������",			50,	1,	20,	15,	1762.791015,616.698364,10.525601},
	{"The Roof Point",		10,	10,	10,	10,	2253.197021,952.436218,16.631505},
	{"Boat Point",			0,	10,	10,	10,	-1534.5357,	112.4920,	17.0078}

};

public GroundholdInit()
{
	for (new i=0;i<GROUNDHOLD_SIZE;i++)
	{
		groundholdActiveCPID[i] = AddActiveCheckpoint(groundholdCP[i][gh_x],groundholdCP[i][gh_y],groundholdCP[i][gh_z],groundholdCP[i][gh_dist],2);
		CreateStreamMapIcon(25,groundholdCP[i][gh_x],groundholdCP[i][gh_y],groundholdCP[i][gh_z]);
	}
	WriteLog("Groundhold checkpoints initialised");
}

public CheckGround(ghid)
{
	new playergroundcount;
	playergroundcount = CountPlayers(PlayerGroundHoldTime[ghid]);

	for (new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		if (IsPlayerConnected(playerid))
		{
			
			if ((oIsPlayerInCheckpoint(playerid,groundholdCP[ghid][gh_x],groundholdCP[ghid][gh_y],groundholdCP[ghid][gh_z],groundholdCP[ghid][gh_dist]))
					|| (GetDistancePlayertoXYZ(playerid,groundholdCP[ghid][gh_x],groundholdCP[ghid][gh_y],groundholdCP[ghid][gh_z]) < groundholdCP[ghid][gh_dist]))
			{

				new groundenemycount;
				for (new i = 0;i<MAX_PLAYERS;i++)
				{
					if (i == playerid) continue;
					if (i == INVALID_PLAYER_ID) continue;
					if (PlayerGroundHoldTime[ghid][i] > 0)
					{
						if ((PlayerGangid[i] == 0) || (PlayerGangid[i] != PlayerGangid[playerid]))
						{
							groundenemycount++;
						}
					}
				}

				if (PlayerGroundHoldTime[ghid][playerid] < groundholdCP[ghid][gh_multi])
				{
					if ((PlayerGroundHoldTime[ghid][playerid] == 0) && (PlayerHoldingGround[ghid][playerid] == 0))
					{
						new string[MAX_STRING];
						format(string, sizeof(string),  lang_texts[284] , groundholdCP[ghid][gh_name]);
						SendClientMessage(playerid, COLOUR_ORANGE, string);
						new maxmoney=(groundholdCP[ghid][gh_money]*groundholdCP[ghid][gh_multi]);
						new maxxp=(groundholdCP[ghid][gh_xp]*groundholdCP[ghid][gh_multi]);
						format(string, sizeof(string),  lang_texts[285] ,maxmoney,maxxp);
						SendClientMessage(playerid, COLOUR_ORANGE, string);
					}
					if (PlayerGroundHoldTime[ghid][playerid] == 0)
					{
						PlayerGroundHoldTime[ghid][playerid]++;
					}
					else if (groundenemycount == 0)
					{
						PlayerGroundHoldTime[ghid][playerid]++;
					}
				}
				PlayerHoldingGround[ghid][playerid] = 1;
				
				if (PlayerGroundHoldTime[ghid][playerid] > 0)
				{
					if (groundenemycount > 0) // if more that 0 enimies on ground
					{

						if (PlayerGroundHoldTime[ghid][playerid] > 2) // if we have been holding this ground
						{
							new string[MAX_STRING];
							format(string, sizeof(string),  lang_texts[286] , groundholdCP[ghid][gh_name]);
							SendClientMessage(playerid, COLOUR_RED, string);
						}
						if (PlayerGroundHoldTime[ghid][playerid] > 1)
						{
							PlayerGroundHoldTime[ghid][playerid]--;
						}
					}

					new moneyreward;
					new xpreward;
					xpreward = (groundholdCP[ghid][gh_xp] * PlayerGroundHoldTime[ghid][playerid]);
					if (playergroundcount <= 5)
					{
						moneyreward = (groundholdCP[ghid][gh_money] * PlayerGroundHoldTime[ghid][playerid]) / (1+(playergroundcount / 5));
					}
					else
					{
						moneyreward = (groundholdCP[ghid][gh_money] * PlayerGroundHoldTime[ghid][playerid]) / (1+(5 / 5));
					}

					if (moneyreward > 0) oGivePlayerMoney(playerid,moneyreward,0);
					if (xpreward > 0 && (GetPlayerXP(playerid) < MAX_LVLXP) ) 
					{
					GivePlayerXP(playerid,xpreward,0);
					} else {
					new string[MAX_STRING];
					format(string, sizeof(string),  lang_texts[356] );
					SendClientMessage(playerid, COLOUR_RED, string);
					}
				}
				
			}
			else 
			{
				if (PlayerGroundHoldTime[ghid][playerid] > 0)
				{
					if (PlayerHoldingGround[ghid][playerid] == 1)
					{
						new string[MAX_STRING];
						format(string, sizeof(string),  lang_texts[287] );
						SendClientMessage(playerid, COLOUR_RED, string);
					}
					
					if (PlayerGroundHoldTime[ghid][playerid] == 1)
					{
						new string[MAX_STRING];
						format(string, sizeof(string),  lang_texts[288] , groundholdCP[ghid][gh_name]);
						SendClientMessage(playerid, COLOUR_RED, string);
					}
					PlayerGroundHoldTime[ghid][playerid]--;
					if (PlayerGroundHoldTime[ghid][playerid] > 1)
					{
						PlayerGroundHoldTime[ghid][playerid]--;
					}
					if (PlayerGroundHoldTime[ghid][playerid] > 1)
					{
						PlayerGroundHoldTime[ghid][playerid]--;
					}
				}
				PlayerHoldingGround[ghid][playerid] = 0;
			}

		}
		else
		{
			PlayerGroundHoldTime[ghid][playerid] = 0;
			PlayerHoldingGround[ghid][playerid] = 0;
		}
	}
	return;
}

public CountPlayers(players[])
{

	new count;
	for (new i = 0;i<MAX_PLAYERS;i++)
	{
		if (players[i] > 0) count++;
	}
	return count;

}

public CheckAllGround()
{
	for (new ghid = 0;ghid<GROUNDHOLD_SIZE;ghid++)
	{
		CheckGround(ghid);
	}
}

