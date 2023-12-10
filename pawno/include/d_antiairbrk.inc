stock i_SetPlayerPos( playerid, Float:x, Float:y, Float:z )
	return CallRemoteFunction( "t_SetPlayerPos", "ifff", playerid, x, y, z );
#define SetPlayerPos i_SetPlayerPos