/*
*	Created:			01.10.10
*	Author:				009
*	Description:        "Criminal Syndicate 1.0" core
*/

#if defined _cs_core_included
  #endinput
#endif
#define _cs_core_included
#pragma library cs_core

// --------------------------------------------------
// includes
// --------------------------------------------------
#include "debug.p"
#include "utils.p"
#include "actions.p"
#include "dialogs.p"
#include "pickups.p"
#include "icons.p"
#include "3dtexts.p"
#include "objects.p"
#include "interiors.p"
#include "camera.p"
#include "parsers.p"
#include "holding.p"
#include "vehicles.p"

// --------------------------------------------------
// natives list (for pawno functions list)
// --------------------------------------------------
/*
native Debug system

native Debug(type,const format[],{Float,_}:...);

native

native Utils

native StripNL(str[]);
native GetMaxPlayerId();
native GetDistanceBetweenCoords(Float:X1,Float:Y1,Float:Z1,Float:X2,Float:Y2,Float:Z2);
native TogglePlayerControllableEx(playerid,bool:toggle);
native IsPlayerControllable(playerid);
native MoveCoordsOnAngleByDistance(Float:X,Float:Y,Float:angle,Float:distance);
native ShowHelpBoxForPlayer(playerid,helpboxid,info[]);
native GetPlayerClosestPlayer(playerid);
native fixchars(string[]);
native nullstr(string[]);
native IsPlayerInRangeOfPlayer(playerid,Float:range,pid);
native PreLoadAnimation(playerid,animlib[]);
native GetPlayerCity(playerid);

native

native Actions system

native SetPlayerAction(playerid,actionid);
native GetPlayerAction(playerid);
native AddActionSelectRow(const actionname[],actionid);
native ShowActionSelecting(playerid);

native

native Dialogs system

native ShowPlayerModeDialog(playerid,dialogid,style,caption[],info[],button1[],button2[]);
native HidePlayerModeDialog(playerid);
native SetPlayerModeDialogListData(playerid,listitem,data);
native GetPlayerModeDialogListData(playerid,listitem);
native GetPlayerModeDialogStyle(playerid);

native

native Pickups system

native CreateModePickup(Model,Type,Float:X,Float:Y,Float:Z,ModeInterior,VirtualWorld,TypeEx,TypeExParam);
native DestroyModePickup(pickupid);
native GetModePickupPos(pickupid,&Float:X,&Float:Y,&Float:Z);
native SetModePickupPos(pickupid,Float:X,Float:Y,Float:Z);
native GetModePickupModeInterior(pickupid);
native SetModePickupModeInterior(pickupid,modeinterior);
native GetModePickupVirtualWorld(pickupid);
native SetModePickupVirtualWorld(pickupid,virtualworld);
native GetModePickupModel(pickupid);
native GetModePickupType(pickupid);
native SetModePickupType(pickupid,type);
native GetModePickupTypeEx(pickupid);
native SetModePickupTypeEx(pickupid,type);
native GetModePickupTypeExParam(pickupid);
native SetModePickupTypeExParam(pickupid,typeparam);
native GetPlayerPickupOn(playerid);
native IsModePickupNeedToShow(playerid,pickupid);

native

native Icons

native CreateModeIcon(Icon,Color,Float:X,Float:Y,Float:Z,ModeInterior,VirtualWorld);
native DestroyModeIcon(iconid);
native GetModeIconPos(iconid,&Float:X,&Float:Y,&Float:Z);
native SetModeIconPos(iconid,Float:X,Float:Y,Float:Z);
native GetModeIconModeInterior(iconid);
native SetModeIconModeInterior(iconid,modeinterior);
native GetModeIconVirtualWorld(iconid);
native SetModeIconVirtualWorld(iconid,virtualworld);
native GetModeIconIcon(iconid);
native SetModeIconIcon(iconid,icon);
native GetModeIconColor(iconid);
native SetModeIconColor(iconid,color);
native IsModeIconNeedToShow(playerid,iconid);

native

native 3DTexts

native CreateMode3DText(Text[],Color,Float:X,Float:Y,Float:Z,Float:DrawDistance,ModeInterior,VirtualWorld,LOS);
native DestroyMode3DText(text3did);
native GetMode3DTextPos(text3did,&Float:X,&Float:Y,&Float:Z);
native SetMode3DTextPos(text3did,Float:X,Float:Y,Float:Z);
native GetMode3DTextModeInterior(text3did);
native SetMode3DTextModeInterior(text3did,modeinterior);
native GetMode3DTextVirtualWorld(text3did);
native SetMode3DTextVirtualWorld(text3did,virtualworld);
native AttachMode3DTextToPlayer(text3did,playerid,Float:oX,Float:oY,Float:oZ);
native AttachMode3DTextToVehicle(text3did,vehicleid,Float:oX,Float:oY,Float:oZ);
native DeAttachMode3DText(text3did);
native IsMode3DTextAttached(text3did);
native GetMode3DTextText(text3did);
native SetMode3DTextText(text3did,Text[]);
native GetMode3DTextColor(text3did);
native SetMode3DTextColor(text3did,Color);
native Float:GetMode3DTextDrawDistance(text3did);
native SetMode3DTextDrawDistance(text3did,Float:DrawDistance);
native IsMode3DTextNeedToShow(playerid,text3did);

native

native Objects system

native CreateModeObject(Model,Float:X,Float:Y,Float:Z,Float:rX,Float:rY,Float:rZ,ModeInterior,VirtualWorld,Float:Health,Type,TypeParam);
native DestroyModeObject(objectid);
native GetModeObjectPos(objectid,&Float:X,&Float:Y,&Float:Z);
native SetModeObjectPos(objectid,Float:X,Float:Y,Float:Z);
native GetModeObjectRot(objectid,&Float:rX,&Float:rY,&Float:rZ);
native SetModeObjectRot(objectid,Float:rX,Float:rY,Float:rZ);
native GetModeObjectModeInterior(objectid);
native SetModeObjectModeInterior(objectid,modeinterior);
native GetModeObjectVirtualWorld(objectid);
native SetModeObjectVirtualWorld(objectid,virtualworld);
native AttachModeObjectToPlayer(objectid,playerid,Float:oX,Float:oY,Float:oZ,Float:orX,Float:orY,Float:orZ);
native DeAttachModeObject(objectid);
native IsModeObjectAttached(objectid);
native GetPlayerAttachedModeObject(playerid);
native GetModeObjectModel(objectid);
native GetModeObjectType(objectid);
native SetModeObjectType(objectid,type);
native GetModeObjectTypeParam(objectid);
native SetModeObjectTypeParam(objectid,typeparam);
native Float:GetModeObjectHealth(objectid);
native SetModeObjectHealth(objectid,Float:health);
native GetPlayerClosestModeObject(playerid);
native Float:GetPlayerDistanceToModeObject(playerid,objectid);
native IsModeObjectNeedToShow(playerid,objectid);
native IsPlayerRangeOfModeObject(playerid,Float:range,objectid);
native HideModeObject(objectid);
native ShowModeObject(objectid);
native IsModeObjectStreamedIn(objectid,playerid);
native GetMaxModeObjectId();
native IsValidModeObject(objectid);

native

native Interiors system

native SetPlayerModeInterior(playerid,modeinteriorid);
native GetPlayerModeInterior(playerid);
native GetModeInteriorExitPos(modeinteriorid,&Float:X,&Float:Y,&Float:Z);

native

native Camera system

native MovePlayerCamera(playerid,cameraid,Float:sX,Float:sY,Float:sZ,Float:eX,Float:eY,Float:eZ,Float:vX,Float:vY,Float:vZ,Float:speed);
native MovePlayerCameraEx(playerid,cameraid,Float:sX,Float:sY,Float:sZ,Float:eX,Float:eY,Float:eZ,Float:lX,Float:lY,Float:lZ,Float:speed);
native MovePlayerCameraAroundPlayer(playerid,cameraid,aroundid,Float:radius,Float:speed,direction);
native MovePlayerCameraAroundXYZ(playerid,cameraid,Float:X,Float:Y,Float:Z,Float:radius,Float:speed,direction);
native MovePlayerCameraAroundXYZEx(playerid,cameraid,Float:X,Float:Y,Float:Z,Float:radius,Float:speed,Float:minAngle,Float:maxAngle,direction);
native Float:GetPlayerCameraAroundRadius(playerid);
native SetPlayerCameraAroundRadius(playerid,Float:radius);
native GetPlayerCameraAroundCenter(playerid,&Float:X,&Float:Y,&Float:Z);
native SetPlayerCameraAroundCenter(playerid,Float:X,Float:Y,Float:Z);
native GetPlayerCameraAroundDirection(playerid);
native SetPlayerCameraAroundDirection(playerid,direction);
native StopPlayerCamera(playerid,bool:returncamera);
native IsPlayerCameraMoving(playerid);

native

native Parsers

native RegisterCmd(cmdtext[],command[],cmdlen,prefics,cmdid);
native RegisterText(text[],char,prefics,textid);
native RegisterDialog(playerid,response,listitem,inputtext,prefics,dialogid);

native

native Holding

native AddHolding(dir[],field[],name[]);
native OpenHolding(dir[],field[],name[],mode);
native CloseHolding();
native IsHoldingExist(dir[],field[],name[]);
native DeleteHolding(dir[],field[],name[]);
native GetHoldingDataInt(field[]);
native Float:GetHoldingDataFloat(field[]);
native GetHoldingDataString(field[]);
native GetHoldingDataStringEx(field[],dest[],destlen=sizeof dest);
native SetHoldingDataInt(field[],data);
native SetHoldingDataFloat(field[],Float:data);
native SetHoldingDataString(field[],data[]);
native GetHoldingDataByOrder(dir[],field[],order);
native OpenHoldingTable(dir[]);
native NextHoldingTableRow();
native CloseHoldingTable();

native

native Vehicles

native CreateModeVehicle(model,Float:posx,Float:posy,Float:posz,Float:angle,color1,color2,key,stype,ssubtype,sid);
native DestroyModeVehicle(vehicleid);
native GetModeVehiclePos(vehicleid,&Float:X,&Float:Y,&Float:Z);
native SetModeVehiclePos(vehicleid,Float:X,Float:Y,Float:Z);
native GetModeVehicleAngle(vehicleid,&Float:A);
native SetModeVehicleAngle(vehicleid,Float:A);
native GetModeVehicleHealth(vehicleid,&Float:health);
native SetModeVehicleHealth(vehicleid,Float:health);
native GetModeVehicleTuning(vehicleid,component);
native SetModeVehicleTuning(vehicleid,componentid);
native GetModeVehiclePaintjob(vehicleid);
native SetModeVehiclePaintjob(vehicleid,painjobid);
native GetModeVehicleColor(vehicleid,&color1,&color2);
native SetModeVehicleColor(vehicleid,color1,color2);
native GetModeVehicleKeysize(vehicleid);
native SetModeVehicleKeysize(vehicleid,key);
native GetModeVehicleSpeedoInfo(vehicleid,&stype,&ssubtype,&sid);
native SetModeVehicleSpeedoInfo(vehicleid,stype,ssubtype,sid);
native GetModeVehicleDoorStatus(vehicleid);
native SetModeVehicleDoorStatus(vehicleid,status);
native GetModeVehicleRadioStation(vehicleid);
native SetModeVehicleRadioStation(vehicleid,requency);
native Float:GetModeVehicleFuel(vehicleid);
native SetModeVehicleFuel(vehicleid,Float:fuel);
native GetModeVehicleEngineState(vehicleid);
native SetModeVehicleEngineState(vehicleid,state);
native Float:GetModeVehicleMaxLuggage(vehicleid);
native GetModeVehicleLuggageType(vehicleid);
native GetPlayerClosestModeVehicle(playerid);
native IsPlayerAroundLuggageModeVehicl(playerid,vehicleid);
native IsPlayerAroundDoorModeVehicle(playerid,vehicleid);
native GetModeVehicleType(model);
native GetModeVehicleSubType(model);
native GetMaxModeVehicleId();
native IsModeVehicleActive(vehicleid);
native Float:GetModeVehicleMaxFuel(model);
*/
