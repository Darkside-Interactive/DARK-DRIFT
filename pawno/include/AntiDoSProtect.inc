/*
							English:
	Include Version 1.0 For Script 'AntiDoS_Protect'!
	You Need This Include For Function: 'AntiVehicleChit'!
	Add '#include <AntiDoSProtect>' On The TOP(after #include <a_samp>) Of Your GameMode Or Another Scripts!
	Made By [KrYpToDeN]
	Skype: net6616
	All Rights Reserved �
*/
/*
							Russian:
	������ ������ 1.0 ��� ������� 'AntiDoS_Protect'!
	��� ��������� ������ ������ ��� �������: 'AntiVehicleChit'!
	�������� '#include <AntiDoSProtect>' � ��������(����� '#include <a_samp>') ������ �������� ��� ������ ��������!
	�����: [KrYpToDeN]
	�����: net6616
	��� ����� �������� �
*/


#if !defined _samp_included 
	#error Include 'AntiDoSProtect.inc' should be loaded after 'a_samp.inc'!
#endif

#if defined _KrYpToDeN_included
	#endinput
#endif

#define _KrYpToDeN_included
#pragma library KrYpToDeN

stock AntiVehicleChit(playerid,vehicleid,seatid)
{
    SetPVarInt(playerid,"ChitCar",vehicleid);
    PutPlayerInVehicle(playerid,vehicleid,seatid);
}
#define PutPlayerInVehicle AntiVehicleChit