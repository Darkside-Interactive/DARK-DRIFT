#include <a_sam
#define MAX_VEHICLE_PARAMS 		( 6 )
#define KEY_OPEN_MENU      		( KEY_LOOK_BEHIND )

new Text:TextDrawVehiclePanel[ 10 ], PlayerText:PlayerTextDrawPanel[MAX_PLAYERS];

new paramsName[ MAX_VEHICLE_PARAMS ][ 3 ][] =
{
	{ "Motor",				"On", 			"Off" },
	{ "Svjetla",			"On",			"Off" },
	{ "Alarm",				"On",			"Off" },
	{ "Vrata",			"Lock",			"Unlock" },
	{ "Hauba",				"Zatvori",		"Otvori" },
	{ "Gepek",				"Zatvori",		"Otvori" }
};
//----------------------------------------------------------------------------//
public OnFilterScriptInit()
{
	if (GetPVarInt(playerid, "p_Panel"))
	
}
CMD:noc( playerid )
		        break;
		    }
	    }
	}
	return 1;
}
stock FixUnsetParameters(vehicleid)
{
	new params[ 7 ];
	GetVehicleParamsEx(vehicleid, params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ], params[ 4 ], params[ 5 ], params[6 ]);
	SetVehicleParamsEx(vehicleid,
		params[ 0 ] < 0 ? 1 : params[ 0 ], // Motor
		params[ 1 ] < 0 ? 0 : params[ 1 ], // Svjetla
		params[ 2 ] < 0 ? 0 : params[ 2 ], // Alarm
		params[ 3 ] < 0 ? 0 : params[ 3 ], // Vrata
	 	params[ 4 ] < 0 ? 0 : params[ 4 ], // Hauba
	 	params[ 5 ] < 0 ? 0 : params[ 5 ], // Gepek
	 	params[ 6 ]); // Objective
}
CMD:vozilo( playerid )
{
	new Float: X, Float: Y, Float: Z, Float:ANG, elegy;
	GetPlayerPos( playerid, X, Y, Z );
	GetPlayerFacingAngle( playerid, ANG);
	elegy = CreateVehicle(562, X, Y, Z, ANG, -1, -1, -1 );
	PutPlayerInVehicle(playerid, elegy, 0);
	SendClientMessage(playerid, -1, "Вы создали автомобиль");
	return 1;
{
	SetPlayerTime(playerid, 21 , 00);
	return 1;
}
