#include <a_samp>
/*Настройки*/
#define MAX_PROCESS 9000//процесс раскраски, меньше процесс - быстрее раскрашивается
#define Radius 4//радиус в котором машины будут раскрашиваться
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
public OnFilterScriptInit()
{
    return 1;
}
new TimerP;
new Process[MAX_PLAYERS][MAX_VEHICLES];
new ColorBallon[MAX_PLAYERS] = 3;
main(){}
public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/балончик", cmdtext, true, 10) == 0)return ShowPlayerDialog(playerid,9975,2,"Выберите цвет балончика. \nБалончик стоит 500$","Красный\nСиний\nЗеленый\nЖёлтый\nЧёрный\nРозовый","Выбрать","Отменить");
    return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 9975)
    {
        if(!response)return 1;
        if(GetPlayerMoney(playerid) < 500)return SendClientMessage(playerid,-1,"Нехватает денег!");
        switch(listitem)
        {
            case 0:ColorBallon[playerid] = 3;
            case 1:ColorBallon[playerid] = 106;
            case 2:ColorBallon[playerid] = 86;
            case 3:ColorBallon[playerid] = 6;
            case 4:ColorBallon[playerid] = 0;
            case 5:ColorBallon[playerid] = 126;
        }
        for(new v; v < MAX_VEHICLES; v++)Process[playerid][v] = 0;
        GivePlayerMoney(playerid,-500);
        GivePlayerWeapon(playerid,41,1000);
        SendClientMessage(playerid,-1,"Вы успешно купили балончик за 500$");
    }
    return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

    if(IsPlayerConnected(playerid))
    {
           if(PRESSED(KEY_FIRE) && GetPlayerWeapon(playerid) == 41) { TimerP = SetTimerEx("Raskraska",30,1,"d",playerid); }
           if(RELEASED(KEY_FIRE)) { KillTimer(TimerP); }
    }
    return 1;
}
forward Raskraska(playerid);
public Raskraska(playerid)
{
    new Float: P[3];
    GetPlayerPos(playerid,P[0],P[1],P[2]);
    for(new v; v < MAX_VEHICLES; v++)
    {
          if((GetVehicleDistanceFromPoint(v,P[0],P[1],P[2])<= Radius) && Process[playerid][v] < MAX_PROCESS)
          {
                  if(IsPlayerAimingVehicle(playerid, v))
                  {
                       Process[playerid][v] += 100;
                       if(Process[playerid][v] >= MAX_PROCESS)ChangeVehicleColor(v,ColorBallon[playerid],ColorBallon[playerid]);
                  }
          }
    }
    return 1;
}
#define YAHOOO 0.42
stock IsPlayerAimingVehicle(playerid, vehicleid)
{
    new Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2;
    GetPlayerPos(playerid, X1, Y1, Z1);
    GetVehiclePos(vehicleid, X2, Y2, Z2);
    new Float:Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
    if(Distance < 350)
    {
        new Float:A;
        GetPlayerFacingAngle(playerid, A);
        X1 += (Distance * floatsin(-A, degrees));
        Y1 += (Distance * floatcos(-A, degrees));
        Distance = floatsqroot(floatpower(floatabs(X1-X2), 2) + floatpower(floatabs(Y1-Y2), 2));
        if(Distance < YAHOOO )return true;
    }
    return false;
}
