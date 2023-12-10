#include <core>
#include <float>

//#define RED 0xBE0000FF
#define COLOR_ORANGE 0xFF9900AA


new glob0[200];

new glob320[17][1] = {
	{ 1073 },
	{ 1074 },
	{ 1075 },
	{ 1076 },
	{ 1077 },
	{ 1078 },
	{ 1079 },
	{ 1080 },
	{ 1081 },
	{ 1082 },
	{ 1083 },
	{ 1084 },
	{ 1085 },
	{ 1096 },
	{ 1097 },
	{ 1098 },
	{ 1025 }
};

new glob3A8[3][1] = {
	{ 0 },
	{ 1 },
	{ 2 }
};

stock IsAirPlanes(vehicleid)
{
new model = GetVehicleModel(vehicleid);
if(model == 592 || model == 577 || model == 511 || model == 548 || model == 512 || model == 593 || model == 425 || model == 417 || model == 487 || model == 553 || model == 448 || model == 497 || model == 563 || model == 476 || model == 447 || model == 519 || model == 460 || model == 469 || model == 513 || model == 520)
return true;
return false;
}

/*forward InStateChange(playerid, vehicleid, newkeys);
public InStateChange(playerid, vehicleid, newkeys)
{
	new var0 = GetPlayerState(playerid);	
	if(newkeys == 4 && var0 == 2 && IsPlayerInAnyVehicle(playerid))
	{*/

forward MomTun(playerid, vehicleid);
public MomTun(playerid, vehicleid)
{
		new var1 = GetPlayerVehicleID(playerid);
		new var2 = GetVehicleModel(var1);
		if(var2 == 562)
		{
			AddVehicleComponent(var1, 1146);
			AddVehicleComponent(var1, 1034);
			AddVehicleComponent(var1, 1035);
			AddVehicleComponent(var1, 1036);
			AddVehicleComponent(var1, 1040);
			AddVehicleComponent(var1, 1149);
			AddVehicleComponent(var1, 1171);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 560)
		{
			AddVehicleComponent(var1, 1139);
			AddVehicleComponent(var1, 1026);
			AddVehicleComponent(var1, 1027);
			AddVehicleComponent(var1, 1029);
			AddVehicleComponent(var1, 1032);
			AddVehicleComponent(var1, 1149);
			AddVehicleComponent(var1, 1141);
			AddVehicleComponent(var1, 1169);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 559)
		{
			AddVehicleComponent(var1, 1158);
			AddVehicleComponent(var1, 1162);
			AddVehicleComponent(var1, 1159);
			AddVehicleComponent(var1, 1160);
			AddVehicleComponent(var1, 1069);
			AddVehicleComponent(var1, 1070);
			AddVehicleComponent(var1, 1067);
			AddVehicleComponent(var1, 1065);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 575)
		{
			AddVehicleComponent(var1, 1042);
			AddVehicleComponent(var1, 1044);
			AddVehicleComponent(var1, 1174);
			AddVehicleComponent(var1, 1176);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 558)
		{
			AddVehicleComponent(var1, 1164);
			AddVehicleComponent(var1, 1088);
			AddVehicleComponent(var1, 1092);
			AddVehicleComponent(var1, 1090);
			AddVehicleComponent(var1, 1094);
			AddVehicleComponent(var1, 1166);
			AddVehicleComponent(var1, 1168);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 561)
		{
			AddVehicleComponent(var1, 1058);
			AddVehicleComponent(var1, 1055);
			AddVehicleComponent(var1, 1056);
			AddVehicleComponent(var1, 1062);
			AddVehicleComponent(var1, 1064);
			AddVehicleComponent(var1, 1154);
			AddVehicleComponent(var1, 1155);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 565)
		{
			AddVehicleComponent(var1, 1049);
			AddVehicleComponent(var1, 1046);
			AddVehicleComponent(var1, 1047);
			AddVehicleComponent(var1, 1051);
			AddVehicleComponent(var1, 1054);
			AddVehicleComponent(var1, 1150);
			AddVehicleComponent(var1, 1153);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 576)
		{
			AddVehicleComponent(var1, 1134);
			AddVehicleComponent(var1, 1136);
			AddVehicleComponent(var1, 1137);
			AddVehicleComponent(var1, 1190);
			AddVehicleComponent(var1, 1192);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1076);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 534)
		{
			AddVehicleComponent(var1, 1124);
			AddVehicleComponent(var1, 1106);
			AddVehicleComponent(var1, 1126);
			AddVehicleComponent(var1, 1125);
			AddVehicleComponent(var1, 1179);
			AddVehicleComponent(var1, 1180);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 567)
		{
			AddVehicleComponent(var1, 1133);
			AddVehicleComponent(var1, 1130);
			AddVehicleComponent(var1, 1186);
			AddVehicleComponent(var1, 1188);
			AddVehicleComponent(var1, 1129);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 535)
		{
			AddVehicleComponent(var1, 1110);
			AddVehicleComponent(var1, 1111);
			AddVehicleComponent(var1, 1113);
			AddVehicleComponent(var1, 1115);
			AddVehicleComponent(var1, 1117);
			AddVehicleComponent(var1, 1118);
			AddVehicleComponent(var1, 1120);
			AddVehicleComponent(var1, 1010);
			AddVehicleComponent(var1, 1079);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 536)
		{
			AddVehicleComponent(var1, 1182);
			AddVehicleComponent(var1, 1184);
			AddVehicleComponent(var1, 1107);
			AddVehicleComponent(var1, 1108);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 415)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 402)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 541)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 602)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 480)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 405)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 411)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 429)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 439)
		{
			AddVehicleComponent(var1, 1013);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 400)
		{
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 445)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 409)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 506)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 470)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 489)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 475)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 477)
		{
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 479)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 404)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1013);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 410)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 478)
		{
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1013);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 414)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 589)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 413)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 401)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 406)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 407)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 408)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 412)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 416)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 418)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 419)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 420)
		{
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 421)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 422)
		{
			AddVehicleComponent(var1, 1013);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 423)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 424)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 427)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 426)
		{
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 428)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 431)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 432)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 433)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 434)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 436)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 437)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 438)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 440)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 442)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 443)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 444)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 451)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 455)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 456)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 457)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 458)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 459)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 466)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 467)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 474)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 482)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 483)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 485)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 486)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 490)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 491)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 492)
		{
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 494)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 495)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 496)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 498)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 499)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 500)
		{
			AddVehicleComponent(var1, 1013);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 502)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 503)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 504)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 505)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 507)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 508)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 514)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 515)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 516)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 517)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 518)
		{
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1013);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 525)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 526)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 527)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 528)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 529)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 530)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 531)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 532)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 533)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 539)
		{
			AddVehicleComponent(var1, 1010);
		}
		if(var2 == 540)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 542)
		{
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 543)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 544)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 545)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 546)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 547)
		{
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 549)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 550)
		{
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 551)
		{
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 552)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 554)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 555)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 556)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 557)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 566)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 568)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 571)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 572)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 573)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 574)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 579)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 580)
		{
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 582)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 583)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 587)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 585)
		{
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 588)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 596)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 597)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 598)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 599)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 600)
		{
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1012);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 601)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 603)
		{
			AddVehicleComponent(var1, 1145);
			AddVehicleComponent(var1, 1023);
			AddVehicleComponent(var1, 1024);
			AddVehicleComponent(var1, 1018);
			AddVehicleComponent(var1, 1007);
			AddVehicleComponent(var1, 1017);
			AddVehicleComponent(var1, 1006);
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
		if(var2 == 609)
		{
			AddVehicleComponent(var1, 1010);
			SetPlayerRandomWheels(playerid);
			AddVehicleComponent(var1, 1087);
		}
	/*}
	if(newkeys == 4 && var0 == 2 && IsPlayerInAnyVehicle(playerid))
	{
		new var1 = GetPlayerVehicleID(playerid);
		new var2 = GetVehicleModel(var1);*/
		if(var2 == 562)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 560)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 559)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 575)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 558)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 561)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 565)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 576)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 534)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 567)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 535)
		{
			SetPlayerRandomPaintjob(playerid);
		}
		if(var2 == 536)
		{
			SetPlayerRandomPaintjob(playerid);
		}
	    return 1;
	}

	
forward SetPlayerRandomWheels(playerid);
forward SetPlayerRandomPaintjob(playerid);

public SetPlayerRandomWheels(playerid)
{
	if(!glob0[playerid])
	{
		new var0 = GetPlayerVehicleID(playerid);
		new var1 = random(17);
		AddVehicleComponent(var0, glob320[var1][0]);
	}
	return 1;
}

public SetPlayerRandomPaintjob(playerid)
{
	if(!glob0[playerid])
	{
		new var0 = GetPlayerVehicleID(playerid);
		new var1 = random(3);
		ChangeVehiclePaintjob(var0, glob3A8[var1][0]);
	}
	return 1;
}
