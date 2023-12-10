// Данный мод будет предназначен для GNR серверов

#include <a_samp>
#include <foreach>
#include <sscanf2>
#include <zcmd>
#define FILTERSCRIPT
#pragma warning disable 213
#pragma warning disable 203
public OnFilterScriptInit()
{
   printf("CMD loaded");
}

CMD:boost(playerid, params[])
{
    // Проверим игрока на нахождение в транспортном средстве.
    new vehid = GetPlayerVehicleID(playerid);
    if (0 == vehid)
        return SendClientMessage(playerid, -1, "Вы не в транспорте!");

    // Рассчитаем скорости транспорта по осям X и Y с учётом его угла поворота.
    const Float:velocity = 1.5;
    new Float:angle;
    GetVehicleZAngle(vehid, angle);
    new Float:vx = velocity * -floatcos(angle - 90.0, degrees);
    new Float:vy = velocity * -floatsin(angle - 90.0, degrees);
    // Придадим транспортному средству скорость (получится рывок вперёд).
    return SetVehicleVelocity(vehid, vx, vy, 0.0);
}

CMD:w(playerid, params[])
{
    new string[30];
    if(sscanf(params, "d", params[0]))
        return SendClientMessage(playerid, -1, "Введите: /w [ID]");
    if(params[0] > 255 || params[0] < 0)
        return SendClientMessage(playerid, -1, "Введите значение от 0 до 255");
    SetPlayerWeather(playerid, params[0]);
    format(string, sizeof(string), "Погода установлена. ID: %d", params[0]);
    SendClientMessage(playerid, -1, string);
    return 1;
}
CMD:t(playerid, params[])
{
    new string[47];
    if(sscanf(params, "p< >dd", params[0], params[1]))
        return SendClientMessage(playerid, -1, "Введите: /t [часы] [минуты]");
    if(params[0] > 23 || params[0] < 0)
        return SendClientMessage(playerid, -1, "Введите значение от 0 до 23");
    if(params[1] > 59 || params[1] < 0)
        return SendClientMessage(playerid, -1, "Введите значение от 0 до 59");

    SetPlayerTime(playerid, params[0], params[1]);
    format(string, sizeof(string), "Время установлено на %d часов %d минут", params[0], params[1]);
    SendClientMessage(playerid, -1, string);
    return 1;
}
