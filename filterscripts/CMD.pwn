// ������ ��� ����� ������������ ��� GNR ��������

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
    // �������� ������ �� ���������� � ������������ ��������.
    new vehid = GetPlayerVehicleID(playerid);
    if (0 == vehid)
        return SendClientMessage(playerid, -1, "�� �� � ����������!");

    // ���������� �������� ���������� �� ���� X � Y � ������ ��� ���� ��������.
    const Float:velocity = 1.5;
    new Float:angle;
    GetVehicleZAngle(vehid, angle);
    new Float:vx = velocity * -floatcos(angle - 90.0, degrees);
    new Float:vy = velocity * -floatsin(angle - 90.0, degrees);
    // �������� ������������� �������� �������� (��������� ����� �����).
    return SetVehicleVelocity(vehid, vx, vy, 0.0);
}

CMD:w(playerid, params[])
{
    new string[30];
    if(sscanf(params, "d", params[0]))
        return SendClientMessage(playerid, -1, "�������: /w [ID]");
    if(params[0] > 255 || params[0] < 0)
        return SendClientMessage(playerid, -1, "������� �������� �� 0 �� 255");
    SetPlayerWeather(playerid, params[0]);
    format(string, sizeof(string), "������ �����������. ID: %d", params[0]);
    SendClientMessage(playerid, -1, string);
    return 1;
}
CMD:t(playerid, params[])
{
    new string[47];
    if(sscanf(params, "p< >dd", params[0], params[1]))
        return SendClientMessage(playerid, -1, "�������: /t [����] [������]");
    if(params[0] > 23 || params[0] < 0)
        return SendClientMessage(playerid, -1, "������� �������� �� 0 �� 23");
    if(params[1] > 59 || params[1] < 0)
        return SendClientMessage(playerid, -1, "������� �������� �� 0 �� 59");

    SetPlayerTime(playerid, params[0], params[1]);
    format(string, sizeof(string), "����� ����������� �� %d ����� %d �����", params[0], params[1]);
    SendClientMessage(playerid, -1, string);
    return 1;
}
