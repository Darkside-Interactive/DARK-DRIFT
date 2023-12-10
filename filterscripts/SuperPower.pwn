#include <a_samp>
#include <zcmd>

new pname[MAX_PLAYERS][MAX_PLAYER_NAME];

new Power[MAX_PLAYERS] = -1;
new Fires[MAX_PLAYERS];
new Float: round[MAX_PLAYERS]/* = 100.0*/;
new Timer[MAX_PLAYERS];
new Float: PEX[3][MAX_PLAYERS];
new Float: P[4][MAX_PLAYERS];
forward sPower(playerid);

public OnFilterScriptInit()
{
        print("    Super Power FS by xGanyx Loaded");
        for(new i; i < GetMaxPlayers(); i++)Power[i] = -1;
        return 1;
}

public OnFilterScriptExit()
{
    for(new i; i < GetMaxPlayers(); i++)KillTimer(Timer[i]);
        return 1;
}

public OnPlayerConnect(playerid)
{
    Power[playerid] = -1;
    Fires[playerid] = 0;
        return 1;
}

CMD:poweron(playerid,params[])
{
            new string[128];
                if(Power[playerid] > -1)return SendClientMessage(playerid,-1,"You alredy have super power. Plase use /poweroff to turn off the power");
                Power[playerid] = 1;
                Fires[playerid] = 1;
                SetPlayerAttachedObject( playerid, 0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
                SetPlayerAttachedObject( playerid, 1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
                SetPlayerAttachedObject( playerid, 2, 18703, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
                SetPlayerAttachedObject( playerid, 3, 18703, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
                SendClientMessage(playerid,-1,"Power Has Been Turned On. Please punch to show the power");
                GetPlayerName(playerid,pname[playerid],MAX_PLAYER_NAME);
                format(string,sizeof(string),"Admin %s has turned on super power",pname[playerid]);
                SendClientMessageToAll(0xFFFF00AA,string);
                return 1;
}

CMD:poweroff(playerid,params[])
{
        new string[128];
                Power[playerid] = -1;
                Fires[playerid] = 0;
                for ( new i = 0; i < 4; i++ )
                if ( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
                RemovePlayerAttachedObject( playerid, i );
                GetPlayerName(playerid, pname[playerid], MAX_PLAYER_NAME);
                format(string,sizeof(string),"Admin %s has turned off super power",pname[playerid]);
                SendClientMessageToAll(0xFFFF00AA,string);
                return 1;
}

public sPower(playerid)
{

        if(round[playerid] >= 90.0)
        {
                KillTimer(Timer[playerid]);
                //round[playerid] = 100.0;
                if(Fires[playerid] == 0)
                {
               Power[playerid] = -1;
               return 1;
                }
                Power[playerid] = 1;
                return 1;
        }
    GetXYInFrontOfPoint(P[0][playerid],P[1][playerid], PEX[0][playerid], PEX[1][playerid], P[3][playerid], round[playerid]);
    CreateExplosion(PEX[0][playerid],PEX[1][playerid],P[2][playerid],1,5);
    for(new i; i < GetMaxPlayers(); i ++)
    {
                if(!IsPlayerConnected(i))continue;
                if(GetPlayerDistanceFromPoint(i,PEX[0][playerid],PEX[1][playerid],P[2][playerid]) < 1.5)
                {
             new Float:hp;
                         GetPlayerHealth(i,hp);
                         if(hp <= 0)continue;
                         SetPlayerHealth(i,-1);

       }
    }
        for(new v; v < MAX_VEHICLES; v ++)
        {
           if(GetVehicleDistanceFromPoint(v,PEX[0][playerid],PEX[1][playerid],P[2][playerid]) <= 4.0)SetVehicleHealth(v,0);

        }
    round[playerid] += 3.0;
        return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
        if(newkeys & KEY_FIRE)
        {
                            if(GetPlayerWeapon(playerid) != 0)return 1;
                                if(Power[playerid] == -1 ||Power[playerid] == 0)return 1;
                                    if(IsPlayerInAnyVehicle(playerid))return 1;
                        round[playerid] = 13.0;
                        GetPlayerPos(playerid,P[0][playerid],P[1][playerid],P[2][playerid]);
                        GetPlayerFacingAngle(playerid,P[3][playerid]);
                        Timer[playerid] = SetTimerEx("sPower",20,1,"d",playerid);
                        Power[playerid] = 0;
                        PlayerPlaySound(playerid,1039,0,0,0);

        }
        return 1;
}
stock GetXYInFrontOfPoint(Float:x, Float:y, &Float:x2, &Float:y2, Float:A, Float:distance)
{
    x2 = x + (distance * floatsin(-A, degrees));
    y2 = y + (distance * floatcos(-A, degrees));
}
