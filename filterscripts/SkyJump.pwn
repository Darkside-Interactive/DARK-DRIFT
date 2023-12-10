#include <a_samp>
main () {}
new S_O;
new V[4];

public OnFilterScriptInit()
{
    S_O = CreateObject(16330, 36.46785, 1832.47375, 12.5350,   0.00000, 0.00000, 0.00000);
    CreateObject(16328, 36.46790, 1832.47375,  16.4034,   0.00000, 0.00000, 0.00000);
    new s = CreateObject(16329, 36.46790, 1832.47375, 47.32959,   -50.00000, 0.00000, 0.00000);
    CreateObject(16329, 36.46790, 1832.47375, 47.32960,   -50.00000, 0.00000, 90.00000);
    CreateObject(16329, 36.46790, 1832.47375, 47.32960,   -50.00000, 0.00000, -90.00000);
    CreateObject(16329, 36.46790, 1832.47375, 47.32960,   -50.00000, 0.00000, 180.00000);
    AttachObjectToObject(s, S_O, 0.0, 0.0, 31.17196, -50.00000, 0.00000, 0.00000);
    AttachObjectToObject(s+1, S_O, 0.0, 0.0, 31.17196, -50.00000, 0.00000, 90.00000);
    AttachObjectToObject(s+2, S_O, 0.0, 0.0, 31.17196, -50.00000, 0.00000, -90.00000);
    AttachObjectToObject(s+3, S_O, 0.0, 0.0, 31.17196, -50.00000, 0.00000, 180.00000);

    V[0] = CreateVehicle(411, 81.619377, 1832.514038, 47.631561, 90.0, -1, -1, 999999999999999);
    V[1] = CreateVehicle(411, 36.514041, 1877.751342, 47.631561, 180.0, -1, -1, 999999999999999);
    V[2] = CreateVehicle(411, -8.711162, 1832.470336, 47.631431, 270.0, -1, -1, 999999999999999);
    V[3] = CreateVehicle(411, 36.408866, 1787.320434, 44.878196, 0.0, -1, -1, 999999999999999);
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/mj", cmdtext, true, 10) == 0)
    {
        SetObjectRot(S_O, 0.0, 0.0, 0.0);
        MoveObject(S_O, 36.46785, 1832.47375, 12.5350+0.001, 0.0001, 0.0, 0.0, 180.0);
        return 1;
    }
    if (strcmp("/mj1", cmdtext, true, 10) == 0) return MoveObject(S_O, 36.46785, 1832.47375, 12.5360-0.001, 0.0001, 0.0, 0.0, 360.0);
    if (strcmp("/v0", cmdtext, true, 10) == 0) return PutPlayerInVehicle(playerid, V[0], 0);
    if (strcmp("/v1", cmdtext, true, 10) == 0) return PutPlayerInVehicle(playerid, V[1], 0);
    if (strcmp("/v2", cmdtext, true, 10) == 0) return PutPlayerInVehicle(playerid, V[2], 0);
    if (strcmp("/v3", cmdtext, true, 10) == 0) return PutPlayerInVehicle(playerid, V[3], 0);
    if (strcmp("/v", cmdtext, true, 10) == 0)
    {
        new vehiculo;
        new Float:pos[3];
        GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
        new Float:anglea;
        GetPlayerFacingAngle(playerid, anglea);
        vehiculo = CreateVehicle(411,pos[0],pos[1]+1,pos[2]+0.5,anglea, -1, -1, 500);
        if(!IsPlayerInAnyVehicle(playerid))
        {
            PutPlayerInVehicle(playerid, vehiculo, 0);
        }
        else
        {
            DestroyVehicle(GetPlayerVehicleID(playerid));
            PutPlayerInVehicle(playerid, vehiculo, 0);
        }
        return 1;
    }
    return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(!IsPlayerInAnyVehicle(playerid)) return 1;
    if (newkeys & KEY_FIRE) return BoostVeh(GetPlayerVehicleID(playerid));
    return 1;
}

BoostVeh(vid, Float:dis = 0.24)
{
    new Float:T[4];
    GetVehicleVelocity(vid, T[0], T[1], T[2]);
    GetVehicleZAngle(vid, T[3]);
    SetVehicleVelocity(vid,floatadd(T[0],floatmul(dis,floatsin(-T[3],degrees))), floatadd(T[1],floatmul(dis,floatcos(-T[3],degrees))), T[2]);
    return 1;
}
