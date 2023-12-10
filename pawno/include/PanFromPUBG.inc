#if defined _NAME_included
    #endinput
#endif
#define _NAME_included

#define PAN_SIZE_X 0.747//размеры объекта
#define PAN_SIZE_Y 0.634
#define PAN_SIZE_Z 0.484

#define PAN_SLOT 0//слот для SetPlayerAttachedObject

static 
    bool:have_pan[MAX_PLAYERS char],
	bool:use_pan[MAX_PLAYERS char],
	attach_pan[MAX_PLAYERS char];

stock PFPUBG___GivePlayerWeapon(playerid, weaponid, ammo)
{
	if(!GivePlayerWeapon(playerid, weaponid, ammo)) return 0;

	switch(weaponid)
	{
		case 11: have_pan{playerid} = true;
		case 10, 12..15:
		{
			if(have_pan{playerid})
			{
				have_pan{playerid} = use_pan{playerid} = false;
				attach_pan{playerid} = 0;
				RemovePlayerAttachedObject(playerid, PAN_SLOT);
			}
		}
	}
    return GivePlayerWeapon(playerid, weaponid, ammo);
}

#if defined _ALS_GivePlayerWeapon
    #undef GivePlayerWeapon
#else
    #define _ALS_GivePlayerWeapon
#endif
#define GivePlayerWeapon PFPUBG___GivePlayerWeapon

stock PFPUBG___ResetPlayerWeapons(playerid)
{
	if(!ResetPlayerWeapons(playerid)) return 0;

	have_pan{playerid} = use_pan{playerid} = false;
	attach_pan{playerid} = 0;
	RemovePlayerAttachedObject(playerid, PAN_SLOT);

    return ResetPlayerWeapons(playerid);
}

#if defined _ALS_ResetPlayerWeapons
    #undef ResetPlayerWeapons
#else
    #define _ALS_ResetPlayerWeapons
#endif
#define ResetPlayerWeapons PFPUBG___ResetPlayerWeapons

stock PFPUBG___GetWeaponName(weaponid, weapon[], len)
{
	if(!GetWeaponName(weaponid, weapon[], len)) return 0;
	
	switch(weaponid)
	{
		case 11: return weapon[0] = 0, strcat(weapon, "Pan", 4), 1;
		default: return GetWeaponName(weaponid, weapon, len);
	}

	return 0;
}

#if defined _ALS_GetWeaponName
    #undef GetWeaponName
#else
    #define _ALS_GetWeaponName
#endif
#define GetWeaponName PFPUBG___GetWeaponName


public OnPlayerUpdate(playerid)
{
	static 
	    weaponid,
	    actionid;

    weaponid = GetPlayerWeapon(playerid);
    actionid = GetPlayerSpecialAction(playerid);

	if(weaponid == 11 && !use_pan{playerid})
	{
		use_pan{playerid} = true;
		attach_pan{playerid} = 0;

		RemovePlayerAttachedObject(playerid, PAN_SLOT);

		switch(GetPlayerSkin(playerid))
		{
			case 0: SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 6,  0.055000, 0.026999, -0.030000, -82.500022, 17.399967, 4.399998, PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
			//case : SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 6,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
			default: SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 6,  0.055000, 0.026999, -0.030000, -82.500022, 17.399967, 4.399998, PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
		}
	}
	if(weaponid != 11 && use_pan{playerid})
	{
		use_pan{playerid} = false;
	}
	switch(actionid)
	{
		case SPECIAL_ACTION_NONE:
	    {
		     if(have_pan{playerid} && !use_pan{playerid} && attach_pan{playerid} != 1)
		     {
			     attach_pan{playerid} = 1;	
				 
			     RemovePlayerAttachedObject(playerid, PAN_SLOT);
			
			     switch(GetPlayerSkin(playerid))
			     {
				     case 0: SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 1, -0.100999, -0.079000, -0.217999, -89.700012, -12.800043, -23.199996,  PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
				     //case : SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 1,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
				     default: SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 1, -0.100999, -0.079000, -0.217999, -89.700012, -12.800043, -23.199996,  PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
			     }
		     }
		}
		case SPECIAL_ACTION_DUCK:
		{
			if(have_pan{playerid} && !use_pan{playerid} && attach_pan{playerid} != 2)
			{
				attach_pan{playerid} = 2;

				RemovePlayerAttachedObject(playerid, PAN_SLOT);

				switch(GetPlayerSkin(playerid))
				{
					case 0: SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 1, -0.098999, -0.026000, -0.218999, -89.700012, 37.799976, -23.199996,  PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
					//case : SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 1,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
					default: SetPlayerAttachedObject(playerid, PAN_SLOT, 19581, 1, -0.098999, -0.026000, -0.218999, -89.700012, 37.799976, -23.199996,  PAN_SIZE_X, PAN_SIZE_Y, PAN_SIZE_Z);
				}
			}
		}
	}
	
    #if defined PFPUBG___OnPlayerUpdate
        return PFPUBG___OnPlayerUpdate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate PFPUBG___OnPlayerUpdate
#if defined PFPUBG___OnPlayerUpdate
forward PFPUBG___OnPlayerUpdate(playerid);
#endif

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float: fX, Float: fY, Float: fZ)
{
	if(hittype == BULLET_HIT_TYPE_PLAYER_OBJECT && hitid == 19851) return 0;

	#if defined PFPUBG___OnPlayerWeaponShot
        return PFPUBG___OnPlayerWeaponShot(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerWeaponShot
    #undef OnPlayerWeaponShot
#else
    #define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot PFPUBG___OnPlayerWeaponShot
#if defined PFPUBG___OnPlayerWeaponShot
forward PFPUBG___OnPlayerWeaponShot(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
	have_pan{playerid} = use_pan{playerid} = false;
	attach_pan{playerid} = 0;
	RemovePlayerAttachedObject(playerid, PAN_SLOT);

	#if defined PFPUBG___OnPlayerDisconnect
        return PFPUBG___OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect PFPUBG___OnPlayerDisconnect
#if defined PFPUBG___OnPlayerDisconnect
forward PFPUBG___OnPlayerDisconnect(playerid, reason);
#endif