/*

***'**'*'*'****
CREDITS: Lean
Date of Creation: 2015-02-11
***'**'*'*'****

Helicopter Thermal Mode By Lean



*/

//INCLUDES
#include <a_samp>
#include <zcmd>
#include <streamer>


// DEFINE FOR LEANCMD
#define LEANCMD:(%1) CMD:%1(playerid, params[])



#define SCM SendClientMessage

//COLORS
#define COL_ORANGE "{FF9900}"
#define COLOR_LIGHTRED 0xFF6347AA
#define COL_WHITE "{FFFFFF}"

//NEWS
new objectids[MAX_VEHICLES];
new Text:crosshair[MAX_PLAYERS];
new playerveh[MAX_PLAYERS];

//FORWARDS
forward THERMALON( playerid, veh );
forward THERMALOFF(playerid);

//CALLBACKS
public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print(" Leans Helicopter Thermal Mode");
        print("--------------------------------------\n");
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}



public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT) // checking if player was in a vehicle
    {
        if(GetPVarInt( playerid, "ThermalActive" ) == 1) // Checking if player have thermal active
                {
            THERMALOFF( playerid ); // If Player exits vehicle we set his thermal mode off
                }
    }
    return 1;
}


public THERMALON( playerid, veh )
{
                TextDrawDestroy( crosshair[playerid] ); //Destroying the crosshair
        crosshair[playerid] = TextDrawCreate( 306.0, 218.0, "+" ); // Creating the crosshair
        TextDrawLetterSize( crosshair[playerid], 1.4 ,1.4 ); //Setting the size of the crosshair
        TextDrawShowForPlayer( playerid, crosshair[playerid] ); //Showing the crosshair for the player
                objectids[veh] = CreateObject( 3785,0,0,0,0,0,0,80 ); // creating a light object as it will act like a camera
                AttachObjectToVehicle( objectids[veh], veh, 0.000000, 2.599999, -0.800000, 0.000000, 0.000000, 0.000000 ); // attaching the object to the helicoper
                AttachCameraToObject( playerid, objectids[veh] ); // now we attach our camera to the object
                SetPVarInt( playerid, "ThermalActive", 1 ); // setting thermalactive true
                SCM( playerid,COLOR_LIGHTRED,"NOTICE: "COL_WHITE"Вы вошли в режим тепловой камеры. Чтобы выйти введите /exit" );
                SCM( playerid,COLOR_LIGHTRED,"WARNING: "COL_WHITE"Вы все еще можете покинуть транспорт." );
                playerveh[playerid] = veh; // Storing the vehicleID in a variable
                return 1;
}



public THERMALOFF(playerid)
{
                TextDrawDestroy( crosshair[playerid] ); // Destroying the crosshair
                new vehid = playerveh[playerid];
                SCM( playerid,COLOR_LIGHTRED,"NOTICE: "COL_WHITE"Вы вышли из режима тепловой камеры." );
                DeletePVar( playerid,"ThermalActive" ); // Deleting thermalactive from player
                SetCameraBehindPlayer( playerid ); // Setting the camera back to the player
                DestroyObject(objectids[vehid]); // Destroying the light from the helicopter
                return 1;
}

//COMMANDS


LEANCMD:(helithermal)
{
        new vehi = GetPlayerVehicleID( playerid );
        if( IsPlayerInAnyVehicle(playerid) ) // Checking if player is in any vehicle at all
        {
                if( GetVehicleModel( vehi ) == 497 ) // If player was in vehicle ,we now check if he is in police helicopter
                {
                if( GetPlayerVehicleSeat(playerid) == 1 ) // Checking if he is in passenger seat
                {

                        if( GetPVarInt( playerid, "ThermalActive" ) == 0 ) // If player dosent have thermalactive
                        {
                        THERMALON( playerid, vehi ); // We now set the player in thermal mode.
                                }
                                else // IF he wasent in thermalmode
                                {
                        THERMALOFF( playerid ); // We now set the player back to normal
                                }
                        }
                        else return SCM(playerid,COLOR_LIGHTRED,"ERROR: "COL_WHITE"Тепловая камера может быть использована вторым пилотом..");
                }
                else return SCM(playerid, COLOR_LIGHTRED,"ERROR: "COL_WHITE"Данный транспорт не поддерживает режим тепловой камеры.");
        }
        else return SCM(playerid,COLOR_LIGHTRED,"ERROR: "COL_WHITE"Вы не находитесь в транспорте.");
}




//END OF LEANS HELICOPTER THERMAL MODE
