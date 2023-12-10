/**********************************
 *                                *
 *   @Author:      aptyp          *
 *   @Version:     0.1a           *
 *   @Released:    0.3/10/2012    *
 *                                *
 **********************************/

new bool:smotrit[MAX_PLAYERS],//true- смотрит на тачку, false-не смотрит
	Float:K[2][MAX_PLAYERS],
	Float:V[2][MAX_PLAYERS],
	Float:H[2][MAX_PLAYERS],
	timer;


stock LookOnVeh(playerid, vehicle)
{
	new Float:xp,Float:yp,Float:zp;
	GetPlayerPos(playerid,xp,yp,zp);
	switch(smotrit[playerid])
	{
 		case false:
		{
	        GetPlayerPos(playerid,K[0][playerid],V[0][playerid],H[0][playerid]);
	    }
	}
	smotrit[playerid] = true;
	GetVehiclePos(vehicle,K[1][playerid],V[1][playerid],H[1][playerid]);

	InterpolateCameraPos(playerid, xp,yp,zp+3, K[1][playerid]+200,V[1][playerid]+200,H[1][playerid]+500, 3250, 1);
	InterpolateCameraLookAt(playerid, xp,yp,zp+3, K[1][playerid],V[1][playerid],H[1][playerid], 4500, 1);

	timer = SetTimerEx("LookVeh", 4000, false, "ii", playerid,vehicle);
}

stock StopLookOnVeh(playerid)
{
	switch(smotrit[playerid])
	{
 		case true:
		{
	        TogglePlayerControllable(playerid, 1);
    		SetPlayerPos(playerid, K[0][playerid],V[0][playerid],H[0][playerid]);
			SetCameraBehindPlayer(playerid);
    		smotrit[playerid] = false;
	    }
	}
}

forward LookVeh(playerid,v);
public LookVeh(playerid,v)
{
	switch(smotrit[playerid])
	{
 		case true:
		{
			TogglePlayerControllable(playerid, 0);
			SetPlayerPos(playerid, K[1][playerid],V[1][playerid],H[1][playerid]-3);
    		InterpolateCameraPos(playerid, K[1][playerid]+200,V[1][playerid]+200,H[1][playerid]+500, K[1][playerid]+3.5,V[1][playerid]+3.5,H[1][playerid]+1, 2500, 1);
			InterpolateCameraLookAt(playerid, K[1][playerid],V[1][playerid],H[1][playerid], K[1][playerid],V[1][playerid],H[1][playerid]-0.5, 10000, 1);
			KillTimer(timer);
		}
	}
}
