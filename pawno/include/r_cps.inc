/*-----------------------------------------*
 
=== Romanius's =============================
 Стрмер чекпоинтов который не грузит сервер
========================== v2.2 ============


=== Контакты ===============================
	icq: 4814665
	email: romanius@list.ru
============================================

*------------------------------------------*/

/* natives
native CreateCheckpoint(playerid, Float:cpX, Float:cpY, Float:cpZ, Float:cpS, Float:viewdiss);
native DestroyCheckpoint(checkpointid);
native TogglePlayerCheckpoint(playerid, checkpointid, bool:toggle);
native --_FOR_INSTALL_--();
native CheckpointCheck(playerid);
native PlayerCheckPointUpdate(playerid);
*/

#include <a_samp>

#define INVALID_CP_ID 	 -1
#define INVALID_CP_VALUE_F 	 -99999999999999999.0
#define MAX_STREAMED_RCPS 	 200

Float:DistanceBetweenPoints(Float:x11, Float:y11, Float:z11, Float:x22, Float:y22, Float:z22)
	return floatsqroot(floatpower(floatabs(floatsub(x22,x11)),2)+floatpower(floatabs(floatsub(y22,y11)),2)+floatpower(floatabs(floatsub(z22,z11)),2));

new checkpointid = -1;
enum CP_ENUM
{
	cpid,
	Float:Xx,
	Float:Yy,
	Float:Zz,
	Float:Size,
	bool:active,
	Float:viewdis,
	bool:global
};
new rCheckPoints[MAX_STREAMED_RCPS][CP_ENUM];

new bool:rpscpactive[MAX_PLAYERS][MAX_STREAMED_RCPS];
new bool:rpshown[MAX_PLAYERS][MAX_STREAMED_RCPS];
new rscpid[MAX_PLAYERS];

stock CheckpointCheck(playerid)
{
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	if(rscpid[playerid] != INVALID_CP_ID && DistanceBetweenPoints(pPos[0], pPos[1], pPos[2], rCheckPoints[rscpid[playerid]][Xx], rCheckPoints[rscpid[playerid]][Yy], rCheckPoints[rscpid[playerid]][Zz]) <= rCheckPoints[rscpid[playerid]][viewdis]) 
	{ 
		CallLocalFunction("OnPlayerEnterStreamedCheckpoint","dd",playerid, rscpid[playerid]);
	}
	return 1;
}

stock CreateStreamedCheckpoint(Float:cpX, Float:cpY, Float:cpZ, Float:cpS, Float:viewdiss, playerid = -1)
{
    checkpointid ++;
	rCheckPoints[checkpointid][cpid] = checkpointid;
	rCheckPoints[checkpointid][Xx] = cpX;
	rCheckPoints[checkpointid][Yy] = cpY;
	rCheckPoints[checkpointid][Zz] = cpZ;
	rCheckPoints[checkpointid][Size] = cpS;
	rCheckPoints[checkpointid][active] = true;
	rCheckPoints[checkpointid][viewdis] = viewdiss;
	if(playerid == -1)
	{
		rCheckPoints[checkpointid][global]  = true;
		for(new i; i < MAX_PLAYERS; i ++)
		{
		    rpshown[i][checkpointid] = true;
		}
	}
	else if(playerid != -1)
	{
		rpshown[playerid][checkpointid] = true;
		rCheckPoints[checkpointid][global]  = false;
		for(new i; i < MAX_PLAYERS; i ++)
		{
		    if(i != playerid)
		    {
		    	rpshown[i][checkpointid] = false;
			}
		}
	}
	return checkpointid;
}

stock IsPlayerInStreamedCP(playerid,chpointid=-1)
{
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	if(chpointid == -1)
	{
		if(DistanceBetweenPoints(pPos[0], pPos[1], pPos[2], rCheckPoints[rscpid[playerid]][Xx], rCheckPoints[rscpid[playerid]][Yy], rCheckPoints[rscpid[playerid]][Zz]) <= rCheckPoints[rscpid[playerid]][viewdis]) return true;
		return false;
	}
	else
	{
		if(IsPlayerInCheckpoint(playerid) && DistanceBetweenPoints(pPos[0], pPos[1], pPos[2], rCheckPoints[chpointid][Xx], rCheckPoints[chpointid][Yy], rCheckPoints[chpointid][Zz]) <= rCheckPoints[chpointid][viewdis]) return true;
		return false;
	}
	//return false;
}

stock TogglePlayerCheckpoint(playerid, chepid, bool:toggle)
{
	return rpshown[playerid][chepid] = toggle;
}

stock DestroyStreamedCheckpoint(dcheckpointid)
{
	rCheckPoints[dcheckpointid][cpid] = INVALID_CP_ID;
	rCheckPoints[dcheckpointid][Xx] = INVALID_CP_VALUE_F;
	rCheckPoints[dcheckpointid][Yy] = INVALID_CP_VALUE_F;
	rCheckPoints[dcheckpointid][Zz] = INVALID_CP_VALUE_F;
	rCheckPoints[dcheckpointid][Size] = INVALID_CP_VALUE_F;
	rCheckPoints[dcheckpointid][active] = false;
	rCheckPoints[dcheckpointid][viewdis] = INVALID_CP_VALUE_F;
	return 1;
}

stock PlayerCheckPointUpdate(playerid)
{
	new Float:pPos[3];
	if(IsPlayerConnected(playerid))
	{
		GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
		for(new j; j < checkpointid; j ++)
		{
			if(rCheckPoints[j][active])
			{
			    if(rpshown[playerid][j] && DistanceBetweenPoints(pPos[0], pPos[1], pPos[2], rCheckPoints[j][Xx], rCheckPoints[j][Yy], rCheckPoints[j][Zz]) <= rCheckPoints[j][viewdis])
			    {
			    	if(!rpscpactive[playerid][j])
			    	{
						SetPlayerCheckpoint(playerid, rCheckPoints[j][Xx], rCheckPoints[j][Yy], rCheckPoints[j][Zz], rCheckPoints[j][Size]);
			    	    rpscpactive[playerid][j] = true;
			    	    rscpid[playerid] = j;
					}
				}
				else
				{
					if(rpscpactive[playerid][j])
					{
						    DisablePlayerCheckpoint(playerid);
						    rpscpactive[playerid][j] = false;
							rscpid[playerid] = INVALID_CP_ID;
					}
     			}
			}
		}
	}
}

stock rcps_OnPlayerConnect(playerid)
{
	for(new i; i < MAX_STREAMED_RCPS; i ++) rpscpactive[ playerid ][ i ] = false;
	for(new i; i < MAX_STREAMED_RCPS; i ++)
	{
		if(rCheckPoints[ i ][ global ])
		{
			for(new k; k < MAX_PLAYERS; k ++)
			{
				rpshown[ k ][ i ] = true;
			}
		}
	}
}

forward OnPlayerEnterStreamedCheckpoint(playerid, scpid);