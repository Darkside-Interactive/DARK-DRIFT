#include <a_samp>

#if defined _SCUtil_included
  #endinput
#endif
#define _SCUtil_included
#pragma library SCUtil

new Text:blindall;

/*
native TeleAllToPos(Float:x,Float:y,Float:z,Float:angle);
native KillAll();
native SetAllHealth(float:health);
native DeleteAllVehicles();
native ExplodeAll();
native SetAllMoney(money);
native GiveAllWeapon(weaponid, ammo);
native HealAll();
native ArmourAll();
native ForceAllToClassSelection();
native SetAllMapIcon(iconid, Float:x,Float:y,Float:z,markertype,colour);
native RemoveAllMapIcon(iconid);
native PlayAllSound(soundid);
native FreezeAll();
native UnfreezeAll();
native SpawnAll();
native RespawnAllCars();
native SetAllToSpawnHere(playerid,team,skin,Float:x,Float:y,Float:z,Float:angle,wep1,wep1ammo,wep2,wep2ammo,wep3,wep3ammo);
native RemoveAllFromVehicle();
native ApplyAnimForAll(animlib,animname, Float:fS,opt1,opt2,opt3,opt4,time);
native ClearAnimsForAll();
------------1.5
native SlapAll(Float:height);
native KickAll();
native BanAll(reason[]);
native TeleAllToMe(playerid,Float:x,Float:y,Float:z,Float:angle);
------------2.0
native SetAllInterior(interiorid);
native SetAllSkin(skinid);
native SetAllColour(colourid);
native SetAllScore(score);
native SetAllTeam(teamid);
native SetAllAmmo(weaponslot,ammo);
native SetAllFacingAngle(angle);
native SetAllSpecialAction(actionid);
native SetAllCheckpoint(Float:x,Float:y,Float:z,Float:size);
native SetAllBounds(Float:xmax,Float:xmin,Float:ymax,Float:ymin);
native SetAllCamPos(Float:x,Float:y,Float:z);
native SetAllCamLookAt(Float:x,Float:y,Float:z);
native SetAllCamBehind();
native SetAllTime(hour,minute);
native ToggleAllClock(toggle);
native SetAllVirtualWorld(world);
------------2.0
native BlindAll():
native UnblindAll();
native GetNumberOfAllPlayers();
native GetNumberOfAllVehicles();
native FuckAll();
native CustomFuckAll(Float:health,Float:armour,skinid,name);
native SetAllArmour(Float:armour);
---------------SA-MP 0.2.5 Functions Will Be Added Soon!---------------

For a glipse what will be added in the version when 0.2.5 comes out:

SetAllActorTeam(teamid);
SetAllActorSkin(skinid);
SetAllActorInterior(interiorid);
SetAllActorVirtualWorld(world);
RemoveAllActorsFromVehicles();
AllActorsDriveTo(Float:x,Float:y,Float:z,Float:speed,drivetype,Float:MinAlti);
SetAllActorName(name);
*/
//Set everybodys armour. [Sorry about it being late]
stock SetAllArmour(Float:armour)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerArmour(i,armour);
    }
}
//Customly Fuck all xD - choose there health,armour,skin and name
stock CutomFuckAll(Float:health,Float:armour,skinid,name[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerHealth(i,health);
    SetPlayerArmour(i,armour);
    SetPlayerSkin(i,skinid);
	RemovePlayerFromVehicle(i);
 	ResetPlayerWeapons(i);
 	SetPlayerName(i,"name[]");
	TogglePlayerControllable(i,0);
	}
}
//Fuck all xD - [ R@F inspired, brought up by [ Leopard ] - if you want to unfreeze them after, use UnfreezeAll();
stock FuckAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerHealth(i,1);
    SetPlayerArmour(i,1);
    SetPlayerSkin(i,10);
	RemovePlayerFromVehicle(i);
 	ResetPlayerWeapons(i);
 	SetPlayerName(i,"I_R_FUCKED_UP");
	TogglePlayerControllable(i,0);
	}
}
//Get how many vehicles are on the server [THX TO: Aerobalance]
stock GetNumberOfAllVehicles()
{
    new count, // New variable, which will hold the number of vehicles
        MaxVehicles = GetMaxVehicles(); // New variable (integer) which holds the number of vehicles in your server.
    for(new i = 0; i <= MaxVehicles; i++) // A for loop.
            count++; // Add to the variable.
    return count; // Return the value of 'count'.
}

//Get how many players are playing on the server [THX TO: Aerobalance]
stock GetNumberOfAllPlayers()
{
    new count, // New variable, which will hold the number of players.
        MaxPlayers = GetMaxPlayers(); // New variable (integer) which holds the number of player slots in your server.
    for(new i = 0; i <= MaxPlayers; i++) // A for loop.
        if(IsPlayerConnected(i)) // If the player is connected. (REMEMBER: 'i' is just a number, and we are using a loop to change i's value.)
            count++; // Add to the variable.
    return count; // Return the value of 'count'.
}

//Unblind everybody
stock UnblindAll()
{
	TextDrawDestroy(Text:blindall)
}

//Blind everybody (set everybodys screen to white)
stock BlindAll()
{
    blindall = TextDrawCreate(1.000000,1.000000," ");
	TextDrawUseBox(Textdraw0,1);
	TextDrawBoxColor(Textdraw0,0xffffffff);
	TextDrawTextSize(Textdraw0,651.000000,-113.000000);
	TextDrawAlignment(Textdraw0,0);
	TextDrawBackgroundColor(Textdraw0,0x000000ff);
	TextDrawFont(Textdraw0,3);
	TextDrawLetterSize(Textdraw0,1.000000,49.500000);
	TextDrawColor(Textdraw0,0xffffffff);
	TextDrawSetOutline(Textdraw0,1);
	TextDrawSetProportional(Textdraw0,1);
	TextDrawSetShadow(Textdraw0,1);
	TextDrawShowForAll(Text:blindall);
}
	
//Set everybodys virtual world
stock SetAllVirtualWorld(world)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerVirtualWorld(i,world);
    }
}
//Set everybodys clock
stock ToggleAllClock(toggle)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    TogglePlayerClock(i,toggle);
    }
}
//Set everybodys time
stock SetAllTime(hour,minute)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerTime(i,hour,minute);
    }
}
stock SetAllCamBehind()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetCameraBehindPlayer(i);
    }
}
//Set everyones camera to look at
stock SetAllCamLookAt(Float:x,Float:y,Float:z)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerCameraLookAt(i,x,y,z);
    }
}
//Set everyones camera pos
stock SetAllCamPos(Float:x,Float:y,Float:z)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerCameraPos(i,x,y,z);
    }
}
//Set everybodys world bounds (Like all players join a minigame)
stock SetAllBounds(Float:xmax,Float:xmin,Float:ymax,Float:ymin)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerWorldBounds(xmax,xmin,ymax,ymin);
	}
}
//Set everybodys checkpoint
stock SetAllCheckpoint(Float:x,Float:y,Float:z,Float:size)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerCheckpoint(i,x,y,z,size);
    }
}
//Set everybodys action (e.g dancing)
stock SetAllSpecialAction(actionid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerSpecialAction(i,actionid);
    }
}
//Set everybodys angle
stock SetAllFacingAngle(Float:angle)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerFacingAngle(i,angle);
    }
}
//Set everybodys ammo (e.g if you want a minigun fight ONLY in a command it could set the players mini slot to ammo 0.)
stock SetAllAmmo(weaponslot,ammo)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerAmmo(i,weaponslot,ammo);
    }
}
//Set everyboys team. (if you want to have a minigun bonanza in your server like every 30 minutes)
stock SetAllTeam(teamid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerTeam(i,teamid);
    }
}
//Set everybodys score.
stock SetAllScore(score)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerScore(i,score);
    }
}
//Set everybodys colour.
stock SetAllColour(colour)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerColor(i,colour);
    }
}
//Set everybodys skin
stock SetAllSkin(skinid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
	SetPlayerSkin(i,skinid);
	}
}
//Set everybodys interior
stock SetAllInterior(interiorid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
	SetPlayerInterior(i,interiorid);
	}
}
//Ban all (Nobody knows what you could use this for.. But its your server ;) Maybe the server gets flooded with bots
stock BanAll(reason[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    BanEx(i,reason);
    }
}
//Kick everybody.
stock KickAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    Kick(i);
	}
}
//Bitch slap!
stock SlapAll(Float:height)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    new x;
    new y;
    new z;
    GetPlayerPos(i,x,y,z);
    SetPlayerPos(i,x,y,z+height);
 	}
}
//Clear everyones animation.
stock ClearAnimsForAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    ClearAnimations(i);
    }
}
//Apply an animation for everybody.
stock ApplyAnimForAll(animlib,animname,Float:fS,opt1,opt2,opt3,opt4,time)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    ApplyAnimation(i,animlib,animname,fS,opt1,opt2,opt3,opt4,time);
    }
}
//Remove everyone from there vehicle.
stock RemoveAllFromVehicle()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    RemovePlayerFromVehicle(i);
    }
}
//ALERT: playerid is the player who did the commands ID
stock SetAllToSpawnHere(playerid,team,skin,Float:x,Float:y,Float:z,Float:angle,wep1,wep1ammo,wep2,wep2ammo,wep3,wep3ammo)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        GetPlayerPos(playerid,x,y,z);
        SetSpawnInfo(i,team,skin,x,y,z,angle,wep1,wep1ammo,wep2,wep2ammo,wep3,wep3ammo);
    }
}
//Respawn every car.
stock RespawnAllCars()
{
    for(new i = 0; i<MAX_VEHICLES; i++)
    {
    SetVehicleToRespawn(i);
    }
}
//Respawn every player.
stock SpawnAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SpawnPlayer(i);
    }
}
//Unfreeze all.
stock UnfreezeAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    TogglePlayerControllable(i,1);
    }
}
//Just the opposite of Unfreezeall. Freeze everybody.
stock FreezeAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
	TogglePlayerControllable(i,0);
	}
}
//Play everyone a sound.
stock PlayAllSound(soundid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	PlayerPlaySound(i,soundid,0.0,0.0,0.0);
	}
}
//Remove everyones map icon.
stock RemoveAllMapIcon(iconid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    RemovePlayerMapIcon(i,iconid);
    }
}
//Add a map icon for everyone.
stock SetAllMapIconIcon(iconid, Float:x, Float:y, Float:z,markertype,colour)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    SetPlayerMapIcon(i,iconid,x,y,z,markertype,colour);
    }
}
//Force everyone to class selection.
stock ForceAllToClassSelection()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    ForceClassSelection(i);
    }
}
//Teleport everyone to your location. ALERT: playerid is the player who did the commands ID
stock TeleAllToMe(playerid, Float:x,Float:y,Float:z,Float:angle)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        GetPlayerPos(playerid,x,y,z);
        SetPlayerPos(i,x,y,z);
        SetPlayerFacingAngle(i,angle);
    }
}
//Teleport everyone to the location inputed. ALERT: playerid is the player who did the commands ID
stock TeleAllToPos(Float:x,Float:y,Float:z,Float:angle)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        SetPlayerPos(i,x,y,z);
        SetPlayerFacingAngle(i,angle);
    }
}
//Kill everybody.
stock KillAll()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPlayerHealth(i,0);
	}
}
//Set everyones health to the health you put in.
stock SetAllHealth(Float:health)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPlayerHealth(i,health);
	}
}
//A vehicle clear. WARNING: Put RemoveAllFromVehicle in a timer for 2 seconds then operate this otherwise people could crash.
stock DeleteAllVehicles()
{
    for(new i = 0; i<MAX_VEHICLES; i++)
	{
	    DestroyVehicle(i);
	}
}

//Make everyone go boom :D
stock ExplodeAll(Float:type, Float:radius)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    new x;
	    new y;
	    new z;
	    GetPlayerPos(i,x,y,z);
	    CreateExplosion(x,y,z,type,radius);
	}
}
//Set everyones money.
stock SetAllMoney(Float:money)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    GivePlayerMoney(i, money);
    }
}
//Give everyone a weapon.
stock GiveAllWeapon(weaponid, ammo)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
    GivePlayerWeapon(i,weaponid,ammo);
    }
}
//Heal everybody.
stock HealAll()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    SetPlayerHealth(i,100);
	}
}
//Armour everybody.
stock ArmourAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        SetPlayerArmour(i,100);
	}
}
/*
------------------------------------------------------------------------------
END OF SCUtilities Include.END OF SCUtilities Include.END OF SCUtilities Include.
END OF SCUtilities Include.END OF SCUtilities Include.END OF SCUtilities Include.
END OF SCUtilities Include.END OF SCUtilities Include.END OF SCUtilities Include.
END OF SCUtilities Include.END OF SCUtilities Include.END OF SCUtilities Include.
*/
