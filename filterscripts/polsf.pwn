#include <a_samp>

#include <streamer>

new PickupIDin;//�� ������ ����� � ������� SF
new PickupIDout;//�� ������ ������ �� ������� SF

public OnFilterScriptInit()
{
	PickupIDin = CreateDynamicPickup(19198, 1, 2466.4602,-631.7151,8.2979, 0, 0, -1, 100.0);//������ ����� ����� � ������� SF
	PickupIDout = CreateDynamicPickup(19198, 1, 1243.7217,-1677.1677,11.8013, 0, 10, -1, 100.0);//������ ����� ������ �� ������� SF
	return 1;
}

public OnFilterScriptExit()
{
	DestroyDynamicPickup(PickupIDin);//������� ����� ����� � ������� SF
	DestroyDynamicPickup(PickupIDout);//������� ����� ������ �� ������� SF
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(pickupid == PickupIDin)
		{
 			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 2466.4602,-631.7151,8.2979);
			SetPlayerFacingAngle(playerid, 0.00);
			SetCameraBehindPlayer(playerid);
		}
		if(pickupid == PickupIDout)
		{
 			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 1243.7217,-1677.1677,11.8013);
			SetPlayerFacingAngle(playerid, 0.00);
			SetCameraBehindPlayer(playerid);
		}
	}
	return 1;
}

