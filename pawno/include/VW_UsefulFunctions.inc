/*
 *            VW_UsefulFunctions 1.0
 *       (c) Copyright 2009-2010 by Hidden -=DANGER=-
 *
 * @author    : DANGER1979 (http://dracoblue.com)
 * @date      : 18.10.2009
 * @update    : 11.09.2010
 *
 * This file is provided as is (no warranties).
 *
 */
/*#if defined _samp_included
	#endinput
#endif
#define _samp_included
#pragma library samp*/

#include <a_samp>
/*#if !defined _samp_included
	#tryinclude <a_samp>
	#if !defined _samp_included
		#error could not locate a_samp.inc file, please check your server includes
	#endif
#endif*/

//#define _VW_UsefulFunctions_included
//#pragma library VW_UsefulFunctions

#define MAX_STRING 256
#define COLOR_RED 0xFF0000FF//������� ��� ����������� ��������� 255 0 0
#define COLOR_MAROON 0x800000FF//�������� ��� ��������� ���������� 128 0 0

forward Float: CalculateArea(Float:x1,Float:y1,Float:x2,Float:y2,Float:x3,Float:y3);
//forward Float: Distance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
forward Float: GetDistanceBetweenPlayers(playerid, targetid);
//#define DisableBadword(%1) for(new i=0; i<strlen(text); i++) if(strfind(text[i], %1, true) == 0) for(new a=0; a<256; a++) if(a >= i && a < i+strlen(%1)) text[a]='*'
//##############################################################################//
//                                                                              //
//                             ������������� �������                            //
//                                                                              //
//##############################################################################//
stock PlaySoundForPlayer(playerid, soundid)
{   //����������� ���� soundid �� ����������� ������  playerid
	if(IsValidSound(soundid))
	{
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid, pX, pY, pZ);
		PlayerPlaySound(playerid, soundid, pX, pY, pZ);
	}
}
stock PlaySoundForObject(objectid, soundid)
{   //����������� ���� soundid �� ����������� ������� objectid
	if(IsValidSound(soundid))
	{
		new Float:pX, Float:pY, Float:pZ;
		GetObjectPos(objectid, pX, pY, pZ);
		for(new i=0; i<GetMaxPlayers(); i++)
		{
			if(IsPlayerConnected(i) && !IsPlayerNPC(i))
			{
				if(IsPlayerInRangeOfPoint(i, 100.0, pX, pY, pZ)) PlayerPlaySound(i, soundid, pX, pY, pZ);
			}
		}
	}
}

//##############################################################################//
//                                                                              //
//                                ������� ��������                              //
//                                                                              //
//##############################################################################//
stock IsValidSound(soundid)
{
	new Sounds[] = 	{ 	1002, 1009, 1027, 1035, 1036, 1039, 1052, 1053,
   					1054, 1055, 1056, 1057, 1058, 1062, 1063, 1068,
   					1069, 1076, 1077, 1083, 1084, 1085, 1097, 1098,
   					1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137,
					1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145,
   					1146, 1147, 1148, 1149, 1150, 1153, 1154, 1163,
   					1165, 1166, 1169, 1183, 1184, 1185, 1186, 1187,
   					1188
				};
    for(new i = 0; i < sizeof(Sounds); i++)
    {
        if(Sounds[i] == soundid) return 1;
    }
    return 0;
}

stock CheckValidSkin(SkinID)
{
	if( (SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||
		(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||
		(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||
		(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||
		(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||
		(SkinID >= 290 && SkinID <= 299)
	  )
	{
		return 1;
	}
	return 0;
}
stock SetPlayerSkinEx(playerid, skinid)
{
	if(CheckValidSkin(skinid)) SetPlayerSkin(playerid, skinid);
	else
	{
	    new string[MAX_STRING];
		format(string, sizeof(string), "Error: playerid %s[%d], reason: Use Invalid Skin %d", PlayerName(playerid), playerid, skinid);
		//ABroadCast(COLOR_MAROON, string, 1);
		SendClientMessageToAll(COLOR_MAROON, string);
	}
}
stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
/*//Has also a fix to use "-" and "+" in the beginning of the number.
isNumeric(const string[])
{
	new length = strlen(string);
	if(length == 0) return false;
	for(new i = 0; i < length; i++)
    {
		if((string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') // Not a number,'+' or '-'
             || (string[i]=='-' && i!=0)                                             // A '-' but not at first.
             || (string[i]=='+' && i!=0)                                             // A '+' but not at first.
		   ) return false;
    }
	if(length==1 && (string[0]=='-' || string[0]=='+')) return false;
	return true;
}*/

stock GetSeatVehiclePlayer(vehicleid, seatid)
{   //�������� ID ������ ������� ����� �� ������ �����
//�� �������� � ����� ����� � PutPlayerInVehicle, ������ � ��������� ��������
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid))//IsPlayerInAnyVehicle(i)
		{	//��������� ���� ��� ��������� � ������ �����
       		if(GetPlayerVehicleSeat(i) == seatid && GetPlayerVehicleSeat(i) != -1)
       		{   //Will also return 0 if the player is not in a vehicle!
   	        	//��������������
				//new string[256];
				//format(string, sizeof(string), "GetPlayerVehicleSeat(playerid: %d) = %d", i, GetPlayerVehicleSeat(i));
				//SendClientMessageToAll(COLOR_YELLOW, string);
   	        	return i;
			}
	    }
	}
	return INVALID_PLAYER_ID;
}
//##############################################################################//
//                                                                              //
//                               ����� ����������                               //
//                                                                              //
//##############################################################################//
stock PlayerName(playerid)
{  //��� ��������� ��� ������
	new pName[MAX_PLAYER_NAME+1];//20+1
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}
stock WeaponName(weaponid)
//weaponid,const weapon[],len)
{  //��� ��������� ��� ������
	new gunname[256];
	GetWeaponName(weaponid, gunname, sizeof(gunname));
	return gunname;
}
stock TimeConverter(seconds)//��������� ������� � ������ � �������
{
	new string[6];//��������� ���������� ����������
 	new minutes = floatround(seconds/60);//���. ����� �����
	seconds -= minutes*60; 	//�������
	format(string, sizeof(string), "%02d:%02d", minutes, seconds);//���������������
	return string;//���������� ������ ��������
}
stock timeconvert(Time, &Minutes, &Seconds, &rMSeconds)//��� ����� ��������� �� � ���:���.����
{   //Time - ���-�� ����������� ����� � ������� ������, � ��
	new Float:fTime = floatdiv(Time, 60000);//����� ������������ ����� �� ��������, ��������� ������������ ������, ���������.
    Minutes = floatround(fTime, floatround_tozero);//��������� ������������ ����� ��������� �������.
    //Round downwards for positive values and upwards for negative values (�truncate�).
    //��������� ���� ��� ������������� ������� � ����� ��� ������������� �������
    Seconds = floatround(floatmul(fTime - Minutes, 60), floatround_tozero);
						//����������� ��� ������������ ����� � ���������� ������������.
    rMSeconds = floatround(floatmul(floatmul(fTime - Minutes, 60) - Seconds, 1000), floatround_tozero);
}
stock ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while(text[pos] < 0x21) // Strip out leading spaces //������� ��������� �����
	{
		if(text[pos] == 0) return INVALID_PLAYER_ID; // No passed text //��� ������ �� �����
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if(IsNumeric(text[pos])) // Check whole passed string - ��������� ����� ��������� ������
	{   //���� ������ ������������ � ���� �����
		// If they have a numeric name you have a problem (although names are checked on id failure)
		// ���� � ��� ���� �������� ��� � ��� ���� �������� (���� ����� ��������� � �������)
		userid = strval(text[pos]);
		if(userid >= 0 && userid < MAX_PLAYERS)// && !IsPlayerNPC(userid)
		{
			if(!IsPlayerConnected(userid))	userid = INVALID_PLAYER_ID;
			else return userid; // A player was found
		}
	}
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME+1];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			GetPlayerName(i, name, sizeof(name));
			if(strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{   //��������� ��������� �� ��������� ��� � ����� �� ������ �������
				if(len == strlen(name)) // Exact match //����� ������ ��������
				{   //���� ����� ����� ���������
					return i; // Return the exact player on an exact match
					//���������� ������� ���������� ������ ID � ������� �� �-��
				}
				else // Partial match //��������� ��������
				//� ��������� ������ ���� ���� ��� ������:
				//Me � MeYou ������ ���, ����� �� ����� Me ��� ������ ����� ���
				//� ������� �� ���� ��������� ���������� ������ Me id
				{   //���� ������� �� ������ ����� �����, �� ���������� ���������
					count++;
					userid = i;//���������� userid =
				}
			}
		}
	}
	if(count != 1)
	{
		if(playerid != INVALID_PLAYER_ID)// && !IsPlayerNPC(playerid)
		{
			if(count) ABroadCast(COLOR_RED, "Error: Multiple users found, please narrow earch", 1);
			else ABroadCast(COLOR_RED, "Error: No matching user found", 1);
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid; // INVALID_USER_ID for bad return
}

//------------------------------------------------------------------------------
stock GetDistanceToPoint(playerid, Float:x2, Float:y2, Float:z2)//���������� ��������� �� ������ �� ������
{
	new Float:x1, Float:y1, Float:z1, Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
	return floatround(tmpdis);
}
public Float:GetDistanceBetweenPlayers(playerid, targetid)
{   //�-�� ��������� ��������� ����� ��������
	new Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return -1.00;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(targetid,x2,y2,z2);
	//new Float: fDistance =
	return floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
			//floatsqroot - ��������� ���������� ������ ������� ������������� �����.
						//floatpower - �������� ������������ ����� � �������.
								//floatabs - ���������� ���������� �������� ������������� �����.
										//floatsub - ��������� ������ ����� oper1 �� �����, ��������� � oper2.
	//return fDistance;
}
/*GetDistanceBetweenPlayers(playerid, playerid2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
	return floatround(tmpdis);//���������� �����
}*/

public Float: CalculateArea(Float:x1,Float:y1,
					Float:x2,Float:y2,
					Float:x3,Float:y3)
{   //���������� ������� ������������
    new Float: ab = x1*y2 - y1*x2;
    new Float: bc = x2*y3 - y2*x3;
	new Float: ca = x3*y1 - y3*x1;
	new Float: S = floatabs((ab + bc + ca)/2);
	//printf("ab:%.1f, bc:%.1f, ca:%.1f, S=%.1f",ab, bc, ca, S);
	return S;
}//��������: //S = 1/2 * a * h = 1921
//S = 1/2 * a * b * sin(gamma) = 1820;

stock IsPlayerInRangeOfPlayer(Float:radi, playerid, targetid)
{   //���������� ����� � ������ ���� ��������� �� playerid �� targetid ������ ����������
	if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid) &&
		!IsPlayerNPC(playerid) && !IsPlayerNPC(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		GetPlayerPos(targetid, posx, posy, posz);
		//new Float:oldposx, Float:oldposy, Float:oldposz;
		//new Float:tempposx, Float:tempposy, Float:tempposz;
		//GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//tempposx = (oldposx -posx);
		//tempposy = (oldposy -posy);
		//tempposz = (oldposz -posz);
		//if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
   		if(IsPlayerInRangeOfPoint(playerid, radi, posx, posy, posz))
		{
			return 1;
		}
	}
	return 0;
}

//��� ��������� ����������� ����� � ��� ��������� ������ �� �����
stock IsPlayerInArea(playerid, Float:area[6])//���������� ����� ������ �������
{   //���� ����� ��������� � ������������� ���� ������������ ������������ �� ������� area
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if (x > area[0] && x < area[3] && y > area[1] && y < area[4] && z > area[2] && z < area[5]) return 1;
		//���� ������� ���������� ��������� ����� ������������ �� ������� checkCoords
	}
	return 0;
}
stock GetDistanceToCar(playerid, vehicleid)
//stock GetDistanceFromPlayerToVehicle(playerid, vehicleid)
{	//���������� ��������� �� ������ �� ������
	new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(vehicleid,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
						//�������� ������������ ����� � �������.
											//��������� ������ ����� oper1 �� �����, ��������� � oper2.
	return floatround(tmpdis);
}

stock GetXYInfrontOfPlayer(playerid, Float:distance, &Float:x, &Float:y)
{   //�������� ���������� ����� �������
    new Float:z, Float:angle;
 	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
    x += (distance * floatsin(-angle, degrees));
    y += (distance * floatcos(-angle, degrees));
}

stock GetXYInrear(Float:distance, Float:angle, &Float:x, &Float:y)
{   //�������� ���������� �� ��������� ������
    //new Float:z, Float:angle;
 	//GetPlayerPos(playerid, x, y, z);
	//GetVehicleZAngle(LastCar[playerid], A);
    x -= (distance * floatsin(-angle, degrees));
    y -= (distance * floatcos(-angle, degrees));
}

stock IsVehicleAttachedToTrailer(vehicleid)
{   //�������� ID ����� ������������ � ���� ����
	for(new car = 1; car<(MAX_VEHICLES-1); car++)
	{
		if(IsTrailerAttachedToVehicle(car))
		{   //�������� ��������� ����� ����� ����� � ������ ����� �������
	     	if( vehicleid == GetVehicleTrailer(car) )
       		{
				//��������������
				//new string[MAX_STRING];
				//format(string, sizeof(string), "IsVehicleAttachedToTrailer(%d) - %d", vehicleid, car);
				//ABroadCast(COLOR_MAROON, string, 9);
   	        	return car;//���� ������ ����� � ���� �� ���������� �� ������� �����
			}
	    }
	}
	return 0;
}
stock RespawnAllCars()
{
	new unoccupied[MAX_VEHICLES-1];
	for(new i=0; i<GetMaxPlayers(); i++)
	{
       	if(IsPlayerInAnyVehicle(i))	unoccupied[GetPlayerVehicleID(i)] = 1;
    }
	for(new car = 1; car<(MAX_VEHICLES-1); car++)
	{
		//VehicleName[GetVehicleModel(car)-400][Category] != Trailers)
		//��������: ������� �� �������� ������������ ����� ����� �� ����� �� ���� ������
		if(unoccupied[car] == 1 || (unoccupied[IsVehicleAttachedToTrailer(car)] == 1)) { }
		else
		{
			SetVehicleToRespawn(car);//��������: ����� ����� ��������� ��������� � ���������� �������� �� 1000
		}
	}
}

stock IsEvenNumber(number)
{   //������, ������ ����� ��� ���.
	if(number % 2 == 0) return 1;
	return 0;
}

stock CheckFireArm(weaponid)
{
	if(weaponid >= 22 && weaponid <= 39) return 1;
	return 0;
}

stock GetWeaponSlot(weaponid)
{
	if(weaponid == 0 || weaponid == 1) return 0;
	else if(2 <= weaponid <= 9) return 1;
	else if(22 <= weaponid <= 24) return 2;
	else if(25 <= weaponid <= 27) return 3;
	else if(weaponid == 28 || weaponid == 29 || weaponid == 32) return 4;
	else if(weaponid == 30 || weaponid == 31) return 5;
	else if(weaponid == 33 || weaponid == 34) return 6;
	else if(35 <= weaponid <= 38) return 7;
	else if(16 <= weaponid <= 18 || weaponid == 39) return 8;
	else if(41 <= weaponid <= 43) return 9;
	else if(10 <= weaponid <= 15) return 10;
	else if(44 <= weaponid <= 46) return 11;
	else if(weaponid == 40) return 12;
	else return 0;
}
//##############################################################################//
//                                                                              //
//                         ������� ��� ������ � �������                         //
//                                                                              //
//##############################################################################//
stock ini_GetKey( line[] )//���������� �� �-�� PlayerLogin
{   //���������� �������� �� ����������� "=" �� ������� ������ line
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind(line, "=", true) == -1 ) return keyRes;
    strmid( keyRes, line, 0, strfind(line, "=", true), sizeof( keyRes) );
    return keyRes;
}
stock ini_GetValue( line[] )//���������� �� �-�� PlayerLogin
{	//���������� �������� ����� ����������� "=" �� ������� ������ line
	new valRes[256];
	valRes[0] = 0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes, line, strfind(line, "=", true)+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

stock strtok(const string[], &index)//��������� ������ �� ������� ������� '������'
//� ���������� �������� ����� �������� ������ � ���������� (&index).
//����������� � �������� ��� ������, ����� ����� �������� ��������� ����� �������.
//string[] - ������, ������� ����� ���������.
//&index - ����� ��������� ������� �� ������ �������.
//����������  �������� ����� �������� ������ � � ���������� &index
//stock - ������ ���������, ���� ������ ������
//stock - ����������� ������ � �������� �������
//stock - ��� ������� �����������, �.�. ��� ���������� ��� ������� stock, � ������ � ����� ��� �� �� ��������� ����������� ��� ������� � ��� ��������.
//public - ���������� �������, �.�. ��� �������������� ��� ��������� ������, � � ����� ��� �� � ��������� ������������ ����� ��� ���������� public � ������,
//forward - ��� ��� ������� �������� ����� ������� ��� ������ ��������� ������ ��������� ������ �� ��� public
{
   new length = strlen(string);//�������� ����� ���������� ������� ������
   while ((index < length) && (string[index] <= ' '))   index++;//���������� ������� �������� �� �������
   //���� ������� ������� < ����� ������ � ������� ������� ��������� �� �������, �� ������� �� ���������
   new offset = index;//�������� ������� �������
   new result[20];//20 ��������� ����� ���������� ���������� � ������������ 20
   while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
   {	//������ ������� ������� ������ ����� ������ � ������� ��������� �� ��������
		// � ������� ����� ������� ������� � �������� ������� < ������ ������ ������� ������ result, �.�. ������ 20 � ������ ������
		result[index - offset] = string[index];//�������� ������ � ������ �� ��������� �� �������� ������� �������, ��� ����� ����������� ������ ����� �������
		index++;//������� �� ��������� ������
   }
   result[index - offset] = EOS;//�������� ������ � ������ result ������� � ������� ���������� ����������� �������
   return result;//���������� ������ �� �������� ������� �� �������� ������� �� �������
}
stock strtoko(const string[], &index, seperator=' ')
{
	new length = strlen(string);//�������� ����� ���������� ������� ������
	new offset = index;//�������� ������� �������
	new result[128];//��������� ����� ���������� ���������� � ������������ 256
	while(  (index < length) && (string[index] != seperator) &&
			( (index - offset) < (sizeof(result) - 1)      )
	     )
	{   //������ ������� ������� ������ ����� ������ � ������ �� ����� �����������
		// � ������� ����� ������� ������� � �������� ������� < ������ ������� ������ result, �.�. ������ 256 � ������ ������
		result[index - offset] = string[index];//�������� ������ � ������ �� ��������� �� �������� ������� �������, ��� ����� ����������� ������ ����� �����������
		index++;//������� �� ��������� ������
	}
	result[index - offset] = EOS;////�������� ������ � ������ result ������� � ������� ���������� ����������� �������
	if ((index < length) && (string[index] == seperator))
	{   //���� ������� ������� < ����� ������ � ������ ����� �����������
		index++;//���������� ������� �������� �� �������
	}
	return result;//���������� ������ �� �������� ������� �� �������� ������� �� �������
}
//���������� ������� ������ ����������� ' ', ���������� ������ - 0.
/*strtoko(const string[], &index, separator)
{   //��� �������� ��������
	new length = strlen(string);
	while ((index < length) && (string[index] <= separator)) index++;
	new offset = index;
	new result[256];//64//20
	while ((index < length) && (string[index] > separator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];	index++;
	}
	result[index - offset] = EOS;
	return result;
}*/

stock split(const strsrc[], strdest[][], delimiter)
{   //��������� ������ �������� �� ����� � ������� �� �� ������ �������� ������
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))//strcmp("male", tmp, true, strlen(tmp)
	{   //���� i <= ����� ������ strsrc
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{   //���� �������� strsrc[i] == '/' ���  i == ����� ������ strsrc
	        len = strmid(strdest[aNum], strsrc, li, i, 128);//��������� �������� �������� �� ������.
			//li - ������� ������� �������, i - ������� ���������� �������, 128 - ������������ ����� ������-���������� ��� �����������.
	        //�������� � strdest[aNum] �������� strsrc
	        strdest[aNum][len] = 0;
	        li = i+1;//
	        aNum++;//������� �������
		}
		i++;
	}
	return 1;
}
//------------------------------------------------------------------------------
stock strrest(const string[], &index)
{   //string[] - ������, ����� ������� �� ������ ����� � ���� ������ �����.
	new length = strlen(string);//��� ������� ����� ���� ������������ ��� �������� ����� ��������� ������.
	while ((index < length) && (string[index] <= ' '))
	{
		index++;//����� ������� �������
	}
	new offset = index;//���������� ������� ������� � ���������� ������
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];//� ���������� result �������� ������� � ������� ����� �������
		index++;
	}
	result[index - offset] = EOS;//�������� ������ � ������ result ������� � ������� ���������� ����������� �������
	return result;
}

stock RusToGame(string[])
{
	new result[256];
	for(new i=0; i < 256; i++)
	{
		switch(string[i])
		{
			case '�':result[i] = 'a';
			case '�':result[i] = 'A';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'e';
			case '�':result[i] = 'E';
			case '�':result[i] = 'e';
			case '�':result[i] = 'E';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'k';
			case '�':result[i] = 'K';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'M';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'o';
			case '�':result[i] = 'O';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'p';
			case '�':result[i] = 'P';
			case '�':result[i] = 'c';
			case '�':result[i] = 'C';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'y';
			case '�':result[i] = 'Y';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = 'x';
			case '�':result[i] = 'X';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			case '�':result[i] = '�';
			default:result[i] = string[i];
		}
	}
	return result;
}
