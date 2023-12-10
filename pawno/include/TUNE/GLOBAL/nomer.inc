if(response)
		{
		new ubki;
        ubki = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_SIDESKIRT);
        new ROOF;
        ROOF = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_ROOF);
        new EXHAUST;
        EXHAUST = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_EXHAUST);
		new spoiler;
        spoiler = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_SPOILER);
        new FRONT_BUMPER;
        FRONT_BUMPER = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_FRONT_BUMPER);
        new REAR_BUMPER;
        REAR_BUMPER = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_REAR_BUMPER);
        new LAMPS;
        LAMPS = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_LAMPS);
        new HOOD;
        HOOD = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_HOOD);
        
        new NITRO;
        NITRO = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_NITRO);
        new STEREO;
        STEREO = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_STEREO);
        new HYDRAULICS;
        HYDRAULICS = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_HYDRAULICS);
        new WHEELS;
        WHEELS = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), CARMODTYPE_WHEELS);
        
        

        
        
        
        
    new Float:health;
    new veh = GetPlayerVehicleID(playerid);
    GetVehicleHealth(veh, health);
        
        
        
        
		    if(!strlen(inputtext))
	    	{
				ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"Смена номера","Введите номера авто в окошко","Готово","Выход");
				return 1;
	    	}



	    	new color1,color2;
for(new i; i != MAX_VEHICLES; ++i)
{
    if(GetVehicleColor(i, color1, color2))
    {
        printf("ИД т/c %d  ~  Моделька %d  ~  Первый цвет %d  ~  Второй цвет %d", i, GetVehicleModel(i), color1, color2);

	}
}
            new car = GetPlayerVehicleID(playerid);
            
            new carid = GetPlayerVehicleID(playerid);
	new engine,lights,alarm,doors,bonnet,boot,objective;

            new Float:x,Float:y,Float:z,Float:ang;
            SetVehicleNumberPlate(GetPlayerVehicleID(playerid), inputtext);
			GetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
			GetVehicleZAngle(GetPlayerVehicleID(playerid),ang);
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
			PutPlayerInVehicle(playerid,GetPlayerVehicleID(playerid),0);
			SetVehicleZAngle(GetPlayerVehicleID(playerid),ang);
			ChangeVehicleColor(car, color1, color2);
			GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
            SetVehicleParamsEx(carid,true,lights,alarm,doors,bonnet,boot,objective);
            SetVehicleHealth(veh, health);
            StopAudioStreamForPlayer(playerid); // отключим
            KillTimer(lourider);
            KillTimer(stretrace);



		/////////////////////////
		if (HOOD == 1111)
        {

            AddVehicleComponent(car,1111);
        }
		
	if (HOOD == 1112)
        {

            AddVehicleComponent(car,1112);
        }
        if (HOOD == 1142)
        {

            AddVehicleComponent(car,1142);
        }
        if (HOOD == 1143)
        {

            AddVehicleComponent(car,1143);
        }
        if (HOOD == 1144)
        {

            AddVehicleComponent(car,1144);
        }
        if (HOOD == 1145)
        {

            AddVehicleComponent(car,1145);
        }
        
        
     ////////////////////////
         if (spoiler == 1147)
        {
            
            AddVehicleComponent(car,1147);
        }

        if (spoiler == 1146)
        {
            
            AddVehicleComponent(car,1146);
        }
        if (spoiler == 1049)
        {

            AddVehicleComponent(car,1049);
        }

        if (spoiler == 1050)
        {

            AddVehicleComponent(car,1050);
        }

if (spoiler == 1158)
        {

            AddVehicleComponent(car,1158);
        }
        if (spoiler == 1162)
        {

            AddVehicleComponent(car,1162);
        }
        
        
        if (spoiler == 1058)
        {

            AddVehicleComponent(car,1058);
        }
        if (spoiler == 1060)
        {

            AddVehicleComponent(car,1060);
        }
        ///
        if (spoiler == 1138)
        {

            AddVehicleComponent(car,1138);
        }
        if (spoiler == 1139)
        {

            AddVehicleComponent(car,1139);
        }
        
        if (spoiler == 1164)
        {

            AddVehicleComponent(car,1164);
        }
        if (spoiler == 1165)
        {

            AddVehicleComponent(car,1165);
        }
        
   

if (spoiler == 1000)
        {

            AddVehicleComponent(car,1000);
        }
        if (spoiler == 1002)
        {

            AddVehicleComponent(car,1002);
        }
        if (spoiler == 1003)
        {

            AddVehicleComponent(car,1003);
        }
        if (spoiler == 1014)
        {

            AddVehicleComponent(car,1014);
        }
        if (spoiler == 1015)
        {

            AddVehicleComponent(car,1015);
        }
        if (spoiler == 1016)
        {

            AddVehicleComponent(car,1016);
        }
        if (spoiler == 1023)
        {

            AddVehicleComponent(car,1023);
        }






    
        
        
        //////////////////////////////////
        if (REAR_BUMPER == 1149)
        {

            AddVehicleComponent(car,1149);
        }
        if (REAR_BUMPER == 1148)
        {

            AddVehicleComponent(car,1148);
        }
        if (REAR_BUMPER == 1150)
        {

            AddVehicleComponent(car,1150);
        }
        if (REAR_BUMPER == 1151)
        {

            AddVehicleComponent(car,1151);
        }
        
        if (REAR_BUMPER == 1159)
        {

            AddVehicleComponent(car,1159);
        }
        if (REAR_BUMPER == 1161)
        {

            AddVehicleComponent(car,1161);
        }
        
        if (REAR_BUMPER == 1154)
        {

            AddVehicleComponent(car,1154);
        }
        if (REAR_BUMPER == 1156)
        {

            AddVehicleComponent(car,1156);
        }
        ///
        if (REAR_BUMPER == 1141)
        {

            AddVehicleComponent(car,1141);
        }
        if (REAR_BUMPER == 1140)
        {

            AddVehicleComponent(car,1140);
        }

if (REAR_BUMPER == 1166)
        {

            AddVehicleComponent(car,1166);
        }
        if (REAR_BUMPER == 1168)
        {

            AddVehicleComponent(car,1168);
        }
        
        if (REAR_BUMPER == 1190)
        {

            AddVehicleComponent(car,1190);
        }
        if (REAR_BUMPER == 1191)
        {

            AddVehicleComponent(car,1191);
        }
if (REAR_BUMPER == 1176)
        {

            AddVehicleComponent(car,1176);
        }
        if (REAR_BUMPER == 1177)
        {

            AddVehicleComponent(car,1177);
        }
        if (REAR_BUMPER == 1178)
        {

            AddVehicleComponent(car,1178);
        }
        if (REAR_BUMPER == 1180)
        {

            AddVehicleComponent(car,1180);
        }
        if (REAR_BUMPER == 1187)
        {

            AddVehicleComponent(car,1187);
        }
        if (REAR_BUMPER == 1186)
        {

            AddVehicleComponent(car,1186);
        }
if (REAR_BUMPER == 1184)
        {

            AddVehicleComponent(car,1184);
        }
if (REAR_BUMPER == 1183)
        {

            AddVehicleComponent(car,1183);
        }

if (REAR_BUMPER == 1109)
        {

            AddVehicleComponent(car,1109);
        }
        if (REAR_BUMPER == 1110)
        {

            AddVehicleComponent(car,1110);
        }
	    
   //////////////////////////////////////
        if (FRONT_BUMPER == 1171)
        {

            AddVehicleComponent(car,1171);
        }
        if (FRONT_BUMPER == 1172)
        {

            AddVehicleComponent(car,1172);
        }
        
        if (FRONT_BUMPER == 1152)
        {

            AddVehicleComponent(car,1152);
        }
        if (FRONT_BUMPER == 1153)
        {

            AddVehicleComponent(car,1153);
        }
	    
	    
	    if (FRONT_BUMPER == 1160)
        {

            AddVehicleComponent(car,1160);
        }
        if (FRONT_BUMPER == 1173)
        {

            AddVehicleComponent(car,1173);
        }
        
        if (FRONT_BUMPER == 1155)
        {

            AddVehicleComponent(car,1155);
        }
        if (FRONT_BUMPER == 1157)
        {

            AddVehicleComponent(car,1157);
        }
        
        if (FRONT_BUMPER == 1169)
        {

            AddVehicleComponent(car,1169);
        }
        if (FRONT_BUMPER == 1170)
        {

            AddVehicleComponent(car,1170);
        }
if (FRONT_BUMPER == 1165)
        {

            AddVehicleComponent(car,1165);
        }
        if (FRONT_BUMPER == 1167)
        {

            AddVehicleComponent(car,1167);
        }


if (FRONT_BUMPER == 1192)
        {

            AddVehicleComponent(car,1192);
        }
        if (FRONT_BUMPER == 1193)
        {

            AddVehicleComponent(car,1193);
        }
	    if (FRONT_BUMPER == 1174)
        {

            AddVehicleComponent(car,1174);
        }
        
        if (FRONT_BUMPER == 1175)
        {

            AddVehicleComponent(car,1175);
        }
        if (FRONT_BUMPER == 1179)
        {

            AddVehicleComponent(car,1179);
        }
        if (FRONT_BUMPER == 1185)
        {

            AddVehicleComponent(car,1185);
        }
        if (FRONT_BUMPER == 1189)
        {

            AddVehicleComponent(car,1189);
        }
        if (FRONT_BUMPER == 1188)
        {

            AddVehicleComponent(car,1188);
        }
        if (FRONT_BUMPER == 1182)
        {

            AddVehicleComponent(car,1182);
        }
        if (FRONT_BUMPER == 1181)
        {

            AddVehicleComponent(car,1181);
        }
        
        
        if (FRONT_BUMPER == 1115)
        {

            AddVehicleComponent(car,1115);
        }
        if (FRONT_BUMPER == 1116)
        {

            AddVehicleComponent(car,1116);
        }
        
        if (FRONT_BUMPER == 1117)
        {

            AddVehicleComponent(car,1117);
        }

///////////////////////////////

        if (ROOF == 1035)
        {

           AddVehicleComponent(car,1035);

        }
        if (ROOF == 1038)
        {

           AddVehicleComponent(car,1038);

        }
        if (ROOF == 1054)
        {

           AddVehicleComponent(car,1054);

        }
        if (ROOF == 1053)
        {

           AddVehicleComponent(car,1053);

        }
        if (ROOF == 1067)
        {

           AddVehicleComponent(car,1067);

        }
        if (ROOF == 1068)
        {

           AddVehicleComponent(car,1068);

        }
        


       if (ROOF == 1055)
        {

           AddVehicleComponent(car,1055);

        }
        if (ROOF == 1061)
        {

           AddVehicleComponent(car,1061);

        }
        
		///
		if (ROOF == 1032)
        {

           AddVehicleComponent(car,1032);

        }
        if (ROOF == 1033)
        {

           AddVehicleComponent(car,1033);

        }
        if (ROOF == 1088)
        {

           AddVehicleComponent(car,1088);

        }
        if (ROOF == 1091)
        {

           AddVehicleComponent(car,1091);

        }
        if (ROOF == 1130)
        {

           AddVehicleComponent(car,1130);

        }
        if (ROOF == 1131)
        {

           AddVehicleComponent(car,1131);

        }
if (ROOF == 1103)
        {

           AddVehicleComponent(car,1103);

        }
        
if (ROOF == 1128)
        {

           AddVehicleComponent(car,1128);

        }
        
        
        if (ROOF == 1004)
        {

           AddVehicleComponent(car,1004);

        }
        if (ROOF == 1005)
        {

           AddVehicleComponent(car,1005);

        }
        if (ROOF == 1006)
        {

           AddVehicleComponent(car,1006);

        }
        if (ROOF == 1011)
        {

           AddVehicleComponent(car,1011);

        }
        
        if (ROOF == 1012)
        {

           AddVehicleComponent(car,1012);

        }
        
        /////////////////////////////////////////////////
        if (EXHAUST == 1136)
        {

           AddVehicleComponent(car,1136);

        }
        if (EXHAUST == 1135)
        {

           AddVehicleComponent(car,1135);

        }
        
        if (EXHAUST == 1045)
        {

           AddVehicleComponent(car,1045);

        }
        if (EXHAUST == 1046)
        {

           AddVehicleComponent(car,1046);

        }
        if (EXHAUST == 1065)
        {

           AddVehicleComponent(car,1065);

        }
        if (EXHAUST == 1066)
        {

           AddVehicleComponent(car,1066);

        }
        
        
        
        if (EXHAUST == 1059)
        {

           AddVehicleComponent(car,1059);

        }
        if (EXHAUST == 1064)
        {

           AddVehicleComponent(car,1064);

        }
        ////
        if (EXHAUST == 1028)
        {

           AddVehicleComponent(car,1028);

        }
        if (EXHAUST == 1029)
        {

           AddVehicleComponent(car,1029);

        }
        if (EXHAUST == 1089)
        {

           AddVehicleComponent(car,1089);

        }
        if (EXHAUST == 1092)
        {

           AddVehicleComponent(car,1092);

        }
if (EXHAUST == 1044)
        {

           AddVehicleComponent(car,1044);

        }
        if (EXHAUST == 1043)
        {

           AddVehicleComponent(car,1043);

        }
        if (EXHAUST == 1126)
        {

           AddVehicleComponent(car,1126);

        }
        if (EXHAUST == 1127)
        {

           AddVehicleComponent(car,1127);

        }
        if (EXHAUST == 1129)
        {

           AddVehicleComponent(car,1129);

        }
        if (EXHAUST == 1132)
        {

           AddVehicleComponent(car,1132);

        }
       if (EXHAUST == 1104)
        {

           AddVehicleComponent(car,1104);

        }
        
      if (EXHAUST == 1105)
        {

           AddVehicleComponent(car,1105);

        }
        if (EXHAUST == 1113)
        {

           AddVehicleComponent(car,1113);

        }
        
         if (EXHAUST == 1114)
        {

           AddVehicleComponent(car,1114);

        }
        
        
        
        if (EXHAUST == 1018)
        {

           AddVehicleComponent(car,1018);

        }
        if (EXHAUST == 1019)
        {

           AddVehicleComponent(car,1019);

        }
        if (EXHAUST == 1020)
        {

           AddVehicleComponent(car,1020);

        }
        if (EXHAUST == 1021)
        {

           AddVehicleComponent(car,1021);

        }
        if (EXHAUST == 1022)
        {

           AddVehicleComponent(car,1022);

        }
        
        
        
        /////////////////////////////////////////////////
                if (ubki == 1140)
        {

            AddVehicleComponent(car,1040);

        }
        if (ubki == 1036)
        {

            AddVehicleComponent(car,1036);

        }
        if (ubki == 1039)
        {

            AddVehicleComponent(car,1039);

        }
        if (ubki == 1041)
        {

            AddVehicleComponent(car,1041);

        }
        
        if (ubki == 1007)
        {

            AddVehicleComponent(car,1007);

        }
        if (ubki == 1017)
        {

            AddVehicleComponent(car,1017);

        }
        
        
        if (ubki == 1047)
        {

            AddVehicleComponent(car,1047);

        }
        if (ubki == 1048)
        {

            AddVehicleComponent(car,1048);

        }
        if (ubki == 1051)
        {

            AddVehicleComponent(car,1051);

        }
        if (ubki == 1052)
        {

            AddVehicleComponent(car,1052);

        }
        
		/////
       if (ubki == 1069)
        {

            AddVehicleComponent(car,1069);

        }
        if (ubki == 1159)
        {

            AddVehicleComponent(car,1159);

        }
        if (ubki == 1070)
        {

            AddVehicleComponent(car,1070);

        }
        if (ubki == 1072)
        {

            AddVehicleComponent(car,1072);

        }
        ////
        
        
        if (ubki == 1056)
        {

            AddVehicleComponent(car,1056);

        }
        if (ubki == 1057)
        {

            AddVehicleComponent(car,1057);

        }
        if (ubki == 1062)
        {

            AddVehicleComponent(car,1062);

        }
        if (ubki == 1063)
        {

            AddVehicleComponent(car,1063);

        }
        
        ////


        if (ubki == 1026)
        {

            AddVehicleComponent(car,1026);

        }
        if (ubki == 1027)
        {

            AddVehicleComponent(car,1027);

        }
        if (ubki == 1030)
        {

            AddVehicleComponent(car,1030);

        }
        if (ubki == 1031)
        {

            AddVehicleComponent(car,1031);

        }
        ////
        if (ubki == 1090)
        {

            AddVehicleComponent(car,1090);

        }
        if (ubki == 1093)
        {

            AddVehicleComponent(car,1093);

        }
        if (ubki == 1094)
        {

            AddVehicleComponent(car,1094);

        }
        if (ubki == 1095)
        {

            AddVehicleComponent(car,1095);

        }
        
        
        if (ubki == 1134)
        {

            AddVehicleComponent(car,1134);

        }
        if (ubki == 1137)
        {

            AddVehicleComponent(car,1137);

        }
 if (ubki == 1042)
        {

            AddVehicleComponent(car,1042);

        }
        if (ubki == 1099)
        {

            AddVehicleComponent(car,1099);

        }
        
        
        
        
        if (ubki == 1101)
        {

            AddVehicleComponent(car,1101);

        }
        if (ubki == 1106)
        {

            AddVehicleComponent(car,1106);

        }
        if (ubki == 1122)
        {

            AddVehicleComponent(car,1122);

        }
        if (ubki == 1124)
        {

            AddVehicleComponent(car,1124);

        }
        if (ubki == 1102)
        {

            AddVehicleComponent(car,1102);

        }
        if (ubki == 1133)
        {

            AddVehicleComponent(car,1133);

        }
        
        if (ubki == 1107)
        {

            AddVehicleComponent(car,1107);

        }
        if (ubki == 1108)
        {

            AddVehicleComponent(car,1108);

        }
        
        
        if (ubki == 1118)
        {

            AddVehicleComponent(car,1118);

        }
        if (ubki == 1119)
        {

            AddVehicleComponent(car,1119);

        }
        if (ubki == 1120)
        {

            AddVehicleComponent(car,1120);

        }
        if (ubki == 1121)
        {

            AddVehicleComponent(car,1121);

        }
        
        
        
        
       /////////////////////////////////////////////
       
       
       
       
       
       
       
       
       
       
       
       if (LAMPS == 1100)
        {

            AddVehicleComponent(car,1100);

        }
         if (LAMPS == 1123)
        {

            AddVehicleComponent(car,1123);

        }
         if (LAMPS == 1125)
        {

            AddVehicleComponent(car,1125);

        }
        
        
        
        
        
        ///////////////////////////////////////////////////////
        if (NITRO == 1008)
        {

            AddVehicleComponent(car,1008);

        }
        if (NITRO == 1009)
        {

            AddVehicleComponent(car,1009);

        }
        if (NITRO == 1010)
        {

            AddVehicleComponent(car,1010);

        }
        if (STEREO == 1086)
        {

            AddVehicleComponent(car,1086);

        }
        if (HYDRAULICS == 1087)
        {

            AddVehicleComponent(car,1087);

        }
        
        
        if (WHEELS == 1073)
        {

            AddVehicleComponent(car,1073);

        }
        if (WHEELS == 1074)
        {

            AddVehicleComponent(car,1074);

        }
        if (WHEELS == 1075)
        {

            AddVehicleComponent(car,1075);

        }
        if (WHEELS == 1076)
        {

            AddVehicleComponent(car,1076);

        }
        if (WHEELS == 1077)
        {

            AddVehicleComponent(car,1077);

        }
        if (WHEELS == 1078)
        {

            AddVehicleComponent(car,1078);

        }
        if (WHEELS == 1079)
        {

            AddVehicleComponent(car,1079);

        }
        if (WHEELS == 1080)
        {

            AddVehicleComponent(car,1080);

        }
        if (WHEELS == 1081)
        {

            AddVehicleComponent(car,1081);

        }
        if (WHEELS == 1082)
        {

            AddVehicleComponent(car,1082);

        }
        if (WHEELS == 1083)
        {

            AddVehicleComponent(car,1083);

        }
        if (WHEELS == 1084)
        {

            AddVehicleComponent(car,1084);

        }
        if (WHEELS == 1085)
        {

            AddVehicleComponent(car,1085);

        }
  
}
        else // а если игрок нажал 2 кнопку (в нашем случае это кнопка Отмена)
        {
        //// выводим ему сообщение
        StopAudioStreamForPlayer(playerid); // отключим
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(lourider);
         KillTimer(lourider);
         return 1;
        }

