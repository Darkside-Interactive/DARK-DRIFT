// ������ � ������ ������� �����
// by Exclusive (Coding) && Apec (Mapping)
// www.for-gta.ru | www.e-xclusiv-e.ru

#include <a_samp>

new Float:pickups[20][3] = {
{1491.9460, -1636.0879, 16.2609},
{1491.8560, -1649.5720, 16.2609},
{1490.2189, -1658.5719, 16.2609},
{1487.8273, -1658.7548, 16.2609},
{1485.3701, -1658.8398, 16.2609},
{1482.9283, -1658.7842, 16.2609},
{1478.1766, -1658.5590, 16.2609},
{1475.7457, -1658.6801, 16.2609},
{1473.2986, -1658.6772, 16.2609},
{1470.7522, -1658.6875, 16.2609},
{1468.2712, -1650.0839, 16.2609},
{1468.5658, -1636.7687, 16.2609},
{1491.4229, -1629.6162, 15.9816},
{1491.5317, -1643.4556, 15.9816},
{1491.0835, -1655.3998, 15.9816},
{1469.3336, -1655.4059, 15.9816},
{1468.8918, -1643.7698, 15.9816},
{1468.8267, -1629.6058, 15.9816},
{1480.5619, -1658.1678, 15.9816},
{1480.4948, -1647.2509, 15.9816}
};

new Float:dtext[7][3] = {
{1483.861, -1646.46, 15.698},
{1482.8311, -1647.0520, 15.6980},
{1481.8196, -1647.6920, 15.6980},
{1480.4673, -1647.6760, 15.6980},
{1479.2545, -1647.7750, 15.6980},
{1478.4342, -1647.3800, 15.6980},
{1477.0970, -1646.5660, 15.6980}
};

new Text3D: Dlabel[sizeof(dtext)];

new flowersobj[8],fshop;

new pickupidx[sizeof(pickups)];

forward NullFlowers();

stock ShowBigDialog(playerid,id)
{
	switch(id)
	{
	    case 0:
	    {
			static const strs[11][128] = {
			"{FFFFFF}\t\t\t1939 ��� | ��������",
			"1 � ��������� �������� �� ������",
			"17 - ���������� ���� �� ������ ������� �����. ��������� ���� �� ������",
			"\t\t\t�������",
			"3 � ����� ����������� ����� �� ����� ������. ����� 20 000 ������.",
			"5 � ��������-���������� ���� � �������� ������",
			"\t\t\t������",
			"3 � ��� �������� ������ �� ����� ������.",
			"26 � ��������� ���� �������� ��������� � ��������� �������.",
			"\t\t\t�������",
			"14 � ���� ����� ��������� ���� ���������� � ��������� ������� � ��� ����������."
			};
			new str[470];
			for(new i; i<sizeof(strs); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1939 ���)",str,"�������","");
	    }
	    case 1:
	    {
			static const strs1[24][128] = {
			"{FFFFFF}\t\t\t1940 ��� | ����",
			"12 � ���������� ���� ����� ���������� � ��������� ������.",
			"\t\t\t������",
			"8 � �������������� �������� ���������� ��������������� ����.",
			"9 � �������� ������ �������� ����� � ������������ � ��������.",
			"13 � ������ �������� ������ ������������ � �����������.",
			"14 � ������ �������� ������ ������������ � �������.",
			"\t\t\t���",
			"10 � ������ �������� ��������.",
			"14 � ����������� ����������� �����.",
			"27 � ����������� ����������� �����.",
			"\t\t\t����",
			"5 � ������ ����� �� �������.",
			"14 � ������� ������ ��������� ��������.",
			"\t\t\t�������",
			"7 � ������ ���������� �������� ����� � �������.",
			"28 � ��������� ������ �� ������.",
			"\t\t\t������",
			"4 � ������� ���������� ����� �� �����.",
			"23 � ������� �������������� � ����� ���� ������.",
			"24 � �������� �������������� � ����� ���� ������.",
			"\t\t\t�������",
			"9 � ����������� �������� ������ ���������� � �������� ������.",
			"18 � �������� ��������� ���������� � 21� � ���������� � ����� ������ ���������� �����."
			};
			new str[1200];
			for(new i; i<sizeof(strs1); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs1[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs1[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1940 ���)",str,"�������","");
	    }
	    case 2:
	    {
			static const strs2[33][128] = {
			"{FFFFFF}\t\t\t1941 ��� | ������",
			"5 � ����������� ������������ ��������� ������ � �����.",
			"19 � ������ ����������� �������� �� �������.",
			"24 � ������ ����������� �������� �� ���������.",
			"\t\t\t����",
			"1 � ������������� �������� � ����� ���� ������.",
			"2 � �������� ������ �������� � ��������.",
			"\t\t\t������",
			"10 � ��������� ���� �������� � ������ ���������� ������ �� �������� �������.",
			"13 � �������� ������ ���������� ���������. ���������� ��������-��������� ����� � ����������� � ������.",
			"27 � �������� ������ �������� � �����",
			"\t\t\t����",
			"14 � �������� �������������� � ����� ���� ������.",
			"17 � ������ ����������� � ���������.",
			"{FF003F}22 � ������ ��������� ����������� �� ��������� ����",
			"{FFFFFF}\t\t\t����",
			"1 � ��������� ���� � ������������ �����.",
			"9 � ��������� ���� � ������� �����.",
			"\t\t\t������",
			"5 � ��������� ���� � ���������� �����.",
			"8 � ��������� ���� � �������� �����.",
			"13 � ��������� ������.",
			"\t\t\t��������",
			"26 � ���������� �������� �� ����.",
			"\t\t\t�������",
			"2 � ����� �������� ����������� �� ����� ���������� ������.",
			"\t\t\t������",
			"7 � ������ ��������� �������� �����. ��������� �����������.",
			"18 � ������ ��������� ����������� �� ������",
			"29 � �������� ������ ��������� ������.",
			"\t\t\t�������",
			"6 � ������ ��������� ����������� �� ������. ������ ���������� ���������������� �� ����������� ������� ���������� ������.",
			"8 � ������ ��������� ����� ��� � ��������������"
			};
			new str[1350];
			for(new i; i<sizeof(strs2); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs2[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs2[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1941 ���)",str,"�������","");
	    }
	    case 3:
	    {
			static const strs3[29][128] = {
			"{FFFFFF}\t\t\t1942 ��� | �������",
			"8 � ��������� �������� ����� ��� ���������.",
			"15 � ������ �������� ���������.",
			"\t\t\t������",
			"20 � ������ �������� ����� �� ���������� �����.",
			"28 � ������ �������� ������ ����� �� ���������.",
			"\t\t\t���",
			"1 � ������ �������� ������ ��������.",
			"8 � ������ ��������� ����������� � ����� ���������� ����������� ����������� � �����.",
			"12 � ������ ����������� ��������� ����� �� �������.",
			"17 � ������ ��������� ���������������� ����� ��������.",
			"25 � ����� �������� �� �������.",
			"26 � ������ �������-������������ ����������� �� ���-�������.",
			"\t\t\t����",
			"3 � ������ ��������� ����������� �� �����������.",
			"\t\t\t����",
			"1 � ������ ��������� �������� �����������.",
			"17 � ������ ��������� �������� �������������",
			"\t\t\t������",
			"25 - 6-� �������� ����� ������� � �����������.",
			"\t\t\t��������",
			"2 � 6-� �������� ����� ������� �� ����� �������� �����������.",
			"\t\t\t�������",
			"17 � ������ ���������� ��������� ������ �����������.",
			"\t\t\t������",
			"19 � ������ ���������� ����������� ��� ������������.",
			"22 � ��������� �������� ����� ��� ������������.",
			"\t\t\t�������",
			"22 � ������ ����������� ��������� ����� �� �������."
			};
			new str[1200];
			for(new i; i<sizeof(strs3); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs3[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs3[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1942 ���)",str,"�������","");
	    }
	    case 4:
	    {
			static const strs4[24][128] = {
			"{FFFFFF}\t\t\t1943 ��� | ������",
			"10 � ������ ����������� ������� ����� � ����� ���������� ��������������� �����.",
			"14 � ��������� ������ �� ���� �� ������ 2-� ���������� �����.",
			"23 � ������ ��������� �������� �������.",
			"2 � ����������� �������� ����� ��� ������������",
			"16 � ������������ ���������� �������� ��������.",
			"\t\t\t����",
			"11 � ����������� �����-�������� ����� �� ������� �����������.",
			"\t\t\t����",
			"1 � ������� ����������� �� ������� ���-�������.",
			"10 � ������� �����-������������� ������� � �������.",
			"25 � ��������� � ����� ���������.",
			"\t\t\t������",
			"� � ������ ����������� ������� ����� ������ �������� ������ ����� ���.",
			"23 � ������ ��������� �������� ��������.��������� ������ � ������� �����",
			"\t\t\t��������",
			"24 � ����� ��������� �������� ���������.",
			"\t\t\t�������",
			"13 � ������ ��������� ����� ��������.",
			"\t\t\t������",
			"6 � �������� ������ ��������� ����",
			"21 � ������ �������� �������� ������������.",
			"\t\t\t�������",
			"24 � ������ ���������� ����������� �������� �����."
			};
			new str[1200];
			for(new i; i<sizeof(strs4); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs4[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs4[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1943 ���)",str,"�������","");
	    }
	    case 5:
	    {
			static const strs5[23][128] = {
			"{FFFFFF}\t\t\t1944 ��� | ������",
			"19 � ������ ������� ������ ������ �������� ������� ����� ����������.",
			"\t\t\t����",
			"4 � ������ �������� ��������� ����� ������ �������� ������ ����� ���.",
			"\t\t\t������",
			"8 � ������ ����������� ������� ����� � ����� ������������ �����",
			"15 � ������ ���������� ����������� �� �����������.",
			"\t\t\t���",
			"9 � ��������� ������ ���������� ������������.",
			"\t\t\t����",
			"22 � ������ �������� ��������� ����� ������ �������� ������ ����� ������.",
			"\t\t\t����",
			"20 � ��������� �� �������.",
			"25 � ������ ����������� �� ������.",
			"27 � ������ �������� ���-��������� �������.",
			"29 � �������� ������ ��������� �����.",
			"\t\t\t��������",
			"3 � ���������� ������ �������� ��������.",
			"8 � �������� ��������� ����� ��������.",
			"\t\t\t�������",
			"15 � ������� ������ � ���������� ����� ���������.",
			"\t\t\t�������",
			"24 � ��������� ������ �������� ��������."
			};
			new str[1000];
			for(new i; i<sizeof(strs5); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs5[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs5[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1944 ���)",str,"�������","");
	    }
	    case 6:
	    {
			static const strs6[21][128] = {
			"{FFFFFF}\t\t\t1945 ��� | ������",
			"31 � ��������� ������� ������ ʸ���������.",
			"\t\t\t�������",
			"13 � ��������� ���� � ���������.",
			"26 � ������ ��������� ����� � ����������� ����",
			"\t\t\t����",
			"30 � ������ ���������� ����������� �� ����.",
			"\t\t\t������",
			"24 � ������������� ��������� �������.",
			"{FF003F}30 � ������ �������� � �����.",
			"{FFFFFF}\t\t\t���",
			"8-9 � ��������� ������� �������� � ������.",
			"\t\t\t����",
			"17 � ������ ����������� �����������.",
			"\t\t\t������",
			"2 � ��������� ����������� �����������",
			"8 � ���� ������� ����� ������, ����� ���� ����� � ���������.",
			"\t\t\t��������",
			"2 � ���������� ���� � ����������� ������.",
			"\t\t\t������",
			"20 � ������������ �������."
			};
			new str[640];
			for(new i; i<sizeof(strs6); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs6[i]);
				else
				format(str,sizeof(str),"%s\n\r%s",str,strs6[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� ����� (1945 ���)",str,"�������","");
	    }

	}
	return 1;
}

stock ShowSmallDialog(playerid,id)
{
	new str[200];
	switch(id)
	{
	    case 0:
	    {
            static const strs[3][60] = {
			"{FFFFFF}��������� ��������� ��������:",
			"���� ��������: 5 ������� 1924",
			"���� ������: 27 ������� 1943"
			};
			for(new i; i<sizeof(strs); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 1:
	    {
            static const strs1[3][60] = {
			"{FFFFFF}��� ����������� ���������������:",
			"���� ��������: 8 �������� 1923",
			"���� ������: 29 ������ 1941"
			};
			for(new i; i<sizeof(strs1); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs1[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs1[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 2:
	    {
            static const strs2[3][60] = {
			"{FFFFFF}������� ��������:",
			"���� ��������: 23 ������  1907",
			"���� ������: 26 ���� 1941"
			};
			for(new i; i<sizeof(strs2); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs2[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs2[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 3:
	    {
            static const strs3[3][60] = {
			"{FFFFFF}����� �����:",
			"���� ��������: 29 ������� 1929",
			"���� ������: 11 ��� 1944"
			};
			for(new i; i<sizeof(strs3); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs3[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs3[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 4:
	    {
            static const strs4[3][60] = {
			"{FFFFFF}���� �������:",
			"���� ��������: 17 ���� 1926",
			"���� ������: 24 ������ 1943"
			};
			for(new i; i<sizeof(strs4); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs4[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs4[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 5:
	    {
            static const strs5[3][60] = {
			"{FFFFFF}���� ��������:",
			"���� ��������: 20 ������� 1926",
			"���� ������: 10 ������ 1944"
			};
			for(new i; i<sizeof(strs5); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs5[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs5[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 6:
	    {
            static const strs6[3][60] = {
			"{FFFFFF}��������� ��������� ��������:",
			"���� ��������: 6 ����� 1913",
			"���� ������: 13 ������ 1985"
			};
			for(new i; i<sizeof(strs6); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs6[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs6[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 7:
	    {
            static const strs7[3][60] = {
			"{FFFFFF}������� ������� ������������:",
			"���� ��������: 25 ����� 1923",
			"���� ������: 20 ������ 1945"
			};
			for(new i; i<sizeof(strs7); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs7[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs7[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 8:
	    {
            static const strs8[3][60] = {
			"{FFFFFF}���������� ���� ����������:",
			"���� ��������: 25 ������� 1911",
			"���� ������: 30 ������ 1976"
			};
			for(new i; i<sizeof(strs8); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs8[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs8[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	    case 9:
	    {
            static const strs9[3][60] = {
			"{FFFFFF}������� ���� ���������:",
			"���� ��������: 8 ���� 1920",
			"���� ������: 8 ������� 1991"
			};
			for(new i; i<sizeof(strs9); i++)
			{
			    if(i==0)
				format(str,sizeof(str),"%s",strs9[i]);
				else
				format(str,sizeof(str),"%s\n%s",str,strs9[i]);
			}
			ShowPlayerDialog(playerid,9000,DIALOG_STYLE_MSGBOX,"�������� II ������� �����",str,"�������","");
	    }
	}
	return 1;
}

public OnFilterScriptInit()
{
	fshop = CreatePickup(1239,2,1490.2050,-1677.0770,14.0469);
    SetTimer("NullFlowers",5000*60,1);
    // ����
	CreateObject(1571,1491.93994141,-1676.90002441,14.22999954,0.00000000,0.00000000,270.00000000);
	CreateObject(1569,1490.82995605,-1676.42004395,13.05000019,90.00000000,180.00000000,180.00000000);
	CreateObject(1569,1492.14001465,-1676.41003418,13.05000019,90.00000000,179.99450684,179.99450684);
	CreateObject(1569,1490.81994629,-1675.22998047,13.05000019,90.00000000,179.99450684,179.99450684);
	CreateObject(1569,1492.13000488,-1675.23999023,13.05000019,90.00000000,179.99450684,179.99450684);
	CreateObject(948,1493.16003418,-1675.68005371,13.21000004,0.00000000,0.00000000,0.00000000);
	CreateObject(2194,1491.06994629,-1677.93005371,14.28999996,0.00000000,0.00000000,0.00000000);
	CreateObject(2195,1493.22998047,-1676.35998535,13.81999969,0.00000000,0.00000000,0.00000000);
	CreateObject(2251,1492.38000488,-1675.64001465,14.06000042,0.00000000,0.00000000,14.00000000);
	CreateObject(2251,1492.63000488,-1676.01000977,14.06000042,0.00000000,0.00000000,13.99658203);
	CreateObject(2253,1493.19995117,-1676.93005371,13.47000027,0.00000000,0.00000000,0.00000000);
	CreateObject(2253,1493.18994141,-1677.38000488,13.47000027,0.00000000,0.00000000,0.00000000);
	CreateObject(948,1493.04003906,-1678.20996094,13.21000004,0.00000000,0.00000000,40.75000000);
	CreateObject(2345,1492.18005371,-1678.96997070,15.36999989,0.00000000,0.00000000,0.00000000);
	CreateObject(2345,1493.68994141,-1677.26000977,15.36999989,0.00000000,0.00000000,90.00000000);
	CreateObject(2345,1492.39001465,-1675.20996094,15.36999989,0.00000000,0.00000000,179.75000000);
	CreateObject(2811,1491.21997070,-1675.80004883,13.17000008,0.00000000,0.00000000,0.00000000);
	CreateObject(2811,1491.86999512,-1675.59997559,13.17000008,0.00000000,0.00000000,0.00000000);
	CreateObject(15038,1491.38000488,-1678.39001465,13.85000038,0.00000000,0.00000000,0.00000000);
	CreateObject(2955,1491.35998535,-1678.83996582,14.19999981,0.00000000,0.00000000,90.00000000);
	CreateObject(2194,1492.30004883,-1676.07995605,13.47999954,0.00000000,0.00000000,0.00000000);
	CreateObject(2194,1493.18994141,-1677.77001953,13.47999954,0.00000000,0.00000000,0.00000000);
	CreateObject(1810,1491.70996094,-1677.60998535,13.18000031,0.00000000,0.00000000,238.00000000);
	CreateObject(2771,1491.19995117,-1677.53002930,14.22000027,0.00000000,0.00000000,270.00000000);
	CreateObject(2362,1491.40002441,-1676.77001953,14.02999973,0.00000000,0.00000000,270.00000000);
	CreateObject(1510,1490.67004395,-1677.16003418,14.02999973,0.00000000,0.00000000,0.00000000);
	CreateObject(2752,1490.97998047,-1676.92004395,14.02000046,0.00000000,0.00000000,0.00000000);
	CreateObject(2752,1490.94995117,-1677.06994629,14.06000042,0.00000000,0.00000000,314.00000000);
    // �������
	CreateObject(9946, 1480.13671875, -1643.447265625, 15.4944896698, 0, 0, 270);
	CreateObject(11472, 1493.6748046875, -1618.1376953125, 12.614199638367, 0, 0, 90);
	CreateObject(11472, 1481.607421875, -1618.140625, 12.614339828491, 0, 0, 90);
	CreateObject(14394, 1480.658203125, -1616.5849609375, 14.842631340027, 0, 0, 270);
	CreateObject(14394, 1480.6192626953, -1614.6623535156, 13.417634010315, 0, 0, 270);
	CreateObject(11472, 1485.3674316406, -1619.5424804688, 12.339326858521, 0, 0, 0);
	CreateObject(11472, 1475.8645019531, -1619.5045166016, 12.339326858521, 0, 0, 0);
	CreateObject(11472, 1469.0693359375, -1618.1376953125, 12.614322662354, 0, 0, 90);
	CreateObject(11472, 1465.8271484375, -1618.1376953125, 12.614000320435, 0, 0, 90);
	CreateObject(11472, 1460.5400390625, -1625.4306640625, 12.589323043823, 0, 0, 180);
	CreateObject(11472, 1460.5400390625, -1637.4897460938, 12.589323043823, 0, 0, 179.99450683594);
	CreateObject(11472, 1460.5400390625, -1649.767578125, 12.589323043823, 0, 0, 179.99450683594);
	CreateObject(11472, 1460.5400390625, -1662.1688232422, 12.589323043823, 0, 0, 179.99450683594);
	CreateObject(11472, 1460.5451660156, -1664.0452880859, 12.589323043823, 0, 0, 180);
	CreateObject(11472, 1460.5400390625, -1662.16796875, 12.589323043823, 0, 0, 179.99450683594);
	CreateObject(11472, 1467.6943359375, -1669.2900390625, 12.589323043823, 0, 0, 269.98901367188);
	CreateObject(11472, 1479.8775634766, -1669.2900390625, 12.589323043823, 0, 0, 269.98901367188);
	CreateObject(11472, 1491.8798828125, -1669.2900390625, 12.589323043823, 0, 0, 269.98901367188);
	CreateObject(11472, 1494.4951171875, -1669.3134765625, 12.589323043823, 0, 0, 269.98901367188);
	CreateObject(11472, 1467.6899414063, -1668.3618164063, 12.589500427246, 0, 0, 269.98901367188);
	CreateObject(11472, 1480.0799560547, -1668.3486328125, 12.589500427246, 0, 0, 269.98901367188);
	CreateObject(11472, 1492.3717041016, -1668.3513183594, 12.589500427246, 0, 0, 269.98901367188);
	CreateObject(11472, 1494.4765625, -1668.2280273438, 12.589500427246, 0, 0, 269.98901367188);
	CreateObject(11472, 1499.7998046875, -1663.484375, 12.58899974823, 0, 0, 0);
	CreateObject(11472, 1499.7998046875, -1651.3818359375, 12.58899974823, 0, 0, 0);
	CreateObject(11472, 1499.8000488281, -1639.3981933594, 12.58899974823, 0, 0, 0);
	CreateObject(11472, 1499.8000488281, -1627.1317138672, 12.58899974823, 0, 0, 0);
	CreateObject(11472, 1499.8000488281, -1623.4311523438, 12.58899974823, 0, 0, 0);
	CreateObject(3461, 1480.7922363281, -1638.8090820313, 14.376035690308, 0, 0, 0);
	CreateObject(2773, 1486.5166015625, -1612.4619140625, 13.556525230408, 0, 0, 345.99792480469);
	CreateObject(2773, 1474.7796630859, -1612.5634765625, 13.556525230408, 0, 0, 14.002044677734);
	CreateObject(11489, 1480.4765625, -1649.0947265625, 14.711698532104, 0, 0, 179.99450683594);
	CreateObject(1231, 1494.6198730469, -1638.1477050781, 15.617053985596, 0, 0, 270);
	CreateObject(3462, 1475.9307861328, -1614.0440673828, 15.028007507324, 0, 0, 270);
	CreateObject(3462, 1485.34765625, -1614.05859375, 15.028007507324, 0, 0, 270);
	CreateObject(1231, 1482.6440429688, -1652.7633056641, 15.617053985596, 0, 0, 180);
	CreateObject(3935, 1492.6789550781, -1628.1752929688, 16.688318252563, 0, 0, 89.994506835938);
	CreateObject(3935, 1482.0579833984, -1659.5338134766, 16.688318252563, 0, 0, 359.98352050781);
	CreateObject(3935, 1467.5118408203, -1631.0491943359, 16.688318252563, 0, 0, 270);
	CreateObject(11472, 1480.5037841797, -1619.5992431641, 12.614500045776, 0, 0, 90);
	CreateObject(11472, 1480.4985351563, -1621.1025390625, 12.614700317383, 0, 0, 90);
	CreateObject(11472, 1480.5031738281, -1622.5838623047, 12.614800453186, 0, 0, 90);
	CreateObject(9308, 1481.7697753906, -1637.9440917969, 15.624908447266, 0, 0, 249.25);
	CreateObject(9308, 1479.7242431641, -1638.1446533203, 15.624908447266, 0, 0, 105.00274658203);
	CreateObject(9308, 1480.6861572266, -1638.2358398438, 15.651000022888, 0, 0, 180);
	CreateObject(9308, 1482.5063476563, -1639.1260986328, 15.625, 0, 0, 179.99450683594);
	CreateObject(9308, 1479.3508300781, -1639.08984375, 15.625100135803, 0, 0, 179.99450683594);
	CreateObject(3935, 1493.0966796875, -1655.4215087891, 16.688318252563, 0, 0, 44.994506835938);
	CreateObject(3935, 1469.2465820313, -1657.5020751953, 16.688318252563, 0, 0, 315.00549316406);
	CreateObject(3935, 1467.5095214844, -1645.0855712891, 16.688318252563, 0, 0, 270);
	CreateObject(9308, 1480.4130859375, -1640.7298583984, 15.649908065796, 0, 0, 105.00183105469);
	CreateObject(3935, 1492.7277832031, -1642.1130371094, 16.688318252563, 0, 0, 89.994506835938);
	CreateObject(2773, 1484.6052246094, -1634.4310302734, 15.428890228271, 0, 0, 339.24792480469);
	CreateObject(2773, 1483.7124023438, -1636.787109375, 15.428890228271, 0, 0, 339.24682617188);
	CreateObject(2773, 1477.8905029297, -1636.8138427734, 15.428890228271, 0, 0, 14.746826171875);
	CreateObject(2773, 1477.2231445313, -1634.3903808594, 15.428890228271, 0, 0, 14.74365234375);
	CreateObject(2773, 1477.7524414063, -1634.0179443359, 15.428890228271, 0, 0, 228.24365234375);
	CreateObject(2773, 1479.6877441406, -1635.6793212891, 15.428890228271, 0, 0, 228.24096679688);
	CreateObject(2773, 1482.0369873047, -1635.6783447266, 15.428890228271, 0, 0, 126.74096679688);
	CreateObject(2773, 1484.1295166016, -1634.0673828125, 15.428890228271, 0, 0, 126.73828125);
	CreateObject(2773, 1484.4423828125, -1638.3587646484, 15.428890228271, 0, 0, 237.74682617188);
	CreateObject(2773, 1486.7901611328, -1639.8465576172, 15.428890228271, 0, 0, 237.744140625);
	CreateObject(2773, 1486.69140625, -1640.5454101563, 15.428890228271, 0, 0, 89.244140625);
	CreateObject(2773, 1483.6994628906, -1640.5822753906, 15.428890228271, 0, 0, 90.241943359375);
	CreateObject(2773, 1481.7835693359, -1641.9670410156, 15.428890228271, 0, 0, 340.24169921875);
	CreateObject(2773, 1480.8276367188, -1645.0650634766, 15.428890228271, 0, 0, 342.49108886719);
	CreateObject(2773, 1480.0788574219, -1645.0260009766, 15.428890228271, 0, 0, 14.98779296875);
	CreateObject(2773, 1479.2557373047, -1642.0026855469, 15.428890228271, 0, 0, 14.9853515625);
	CreateObject(2773, 1477.5375976563, -1640.5230712891, 15.428890228271, 0, 0, 269.4853515625);
	CreateObject(2773, 1475.0869140625, -1640.494140625, 15.428890228271, 0, 0, 269.98364257813);
	CreateObject(2773, 1475.0056152344, -1639.8270263672, 15.428890228271, 0, 0, 122.98352050781);
	CreateObject(2773, 1476.9803466797, -1638.5063476563, 15.428890228271, 0, 0, 122.98095703125);
	CreateObject(2004, 1480.3620605469, -1638.6881103516, 15.650150299072, 90, 0, 0);
	CreateObject(2004, 1480.4936523438, -1638.4168701172, 15.650150299072, 90, 180, 139.25003051758);
	CreateObject(3920, 1493.8931884766, -1617.5894775391, 14.616878509521, 0, 0, 0);
	CreateObject(3920, 1468.2130126953, -1617.5675048828, 14.616878509521, 0, 0, 0);
	CreateObject(3920, 1460.0010986328, -1634.5196533203, 14.616878509521, 0, 0, 90);
	CreateObject(3920, 1459.9812011719, -1647.3524169922, 14.616878509521, 0, 0, 90);
	CreateObject(3920, 1460.0211181641, -1663.1317138672, 14.616878509521, 0, 0, 90);
	CreateObject(3920, 1466.6260986328, -1669.8796386719, 14.616878509521, 0, 0, 180);
	CreateObject(3920, 1479.6839599609, -1669.8404541016, 14.616878509521, 0, 0, 179.99450683594);
	CreateObject(3920, 1492.7891845703, -1669.9027099609, 14.616878509521, 0, 0, 179.99450683594);
	CreateObject(3920, 1500.3751220703, -1663.1589355469, 14.616878509521, 0, 0, 270);
	CreateObject(3920, 1500.3334960938, -1649.9501953125, 14.616878509521, 0, 0, 270);
	CreateObject(3920, 1500.3693847656, -1636.6958007813, 14.616878509521, 0, 0, 270);
	CreateObject(2245, 1484.2872314453, -1647.4958496094, 16.751714706421, 0, 0, 0);
	CreateObject(2004, 1480.0833740234, -1648.2821044922, 17.744609832764, 0, 0, 0);
	CreateObject(3660, 1463.2828369141, -1651.4112548828, 17.789751052856, 0, 0, 270);
	CreateObject(3660, 1462.6923828125, -1631.8034667969, 17.789751052856, 0, 0, 90);
	CreateObject(3660, 1497.1538085938, -1631.8090820313, 17.789751052856, 0, 0, 90);
	CreateObject(3660, 1497.7067871094, -1651.404296875, 17.789751052856, 0, 0, 270);
	CreateObject(357, 1480.2600097656, -1648.2973632813, 17.720726013184, 0, 340, 8.25);
	CreateObject(357, 1480.7253417969, -1648.232421875, 17.720726013184, 0, 339.99938964844, 187.49816894531);
	CreateObject(9915, 1479.685546875, -1659.2734375, 17.174987792969, 0, 0, 90);
	CreateObject(2895, 1481.2099609375, -1648.4013671875, 17.119140625, 0, 270, 319.99877929688);
	CreateObject(2895, 1479.7534179688, -1648.3377685547, 17.119140625, 0, 270, 229.99877929688);
	CreateObject(2245, 1483.4384765625, -1648.0178222656, 16.751714706421, 0, 0, 0);
	CreateObject(2245, 1482.5029296875, -1648.5643310547, 16.751714706421, 0, 0, 0);
	CreateObject(2245, 1478.8901367188, -1648.8026123047, 16.751714706421, 0, 0, 0);
	CreateObject(2245, 1477.8240966797, -1648.1818847656, 16.751714706421, 0, 0, 0);
	CreateObject(2245, 1476.5637207031, -1647.4222412109, 16.751714706421, 0, 0, 0);
	CreateObject(3935, 1492.740234375, -1644.4541015625, 16.688318252563, 0, 0, 89.994506835938);
	CreateObject(3935, 1492.6323242188, -1631.0600585938, 16.688318252563, 0, 0, 89.994506835938);
	CreateObject(3935, 1491.0561523438, -1657.4670410156, 16.688318252563, 0, 0, 44.994506835938);
	CreateObject(3935, 1479.0765380859, -1659.5867919922, 16.688318252563, 0, 0, 359.98352050781);
	CreateObject(3935, 1467.189453125, -1655.4658203125, 16.688318252563, 0, 0, 315.00549316406);
	CreateObject(3935, 1467.4649658203, -1642.1828613281, 16.688318252563, 0, 0, 270);
	CreateObject(3935, 1467.5068359375, -1628.13671875, 16.688318252563, 0, 0, 270);
	CreateObject(5715, 1482.9427490234, -1624.2559814453, 16.240636825562, 0, 0, 0);
	CreateObject(5715, 1482.86328125, -1610.427734375, 16.240648269653, 0, 0, 0);
	CreateObject(5715, 1457.7392578125, -1610.39453125, 16.315647125244, 0, 0, 0);
	CreateObject(5715, 1457.7229003906, -1624.4326171875, 16.315647125244, 0, 0, 0);
	CreateObject(5715, 1470.7119140625, -1640.2109375, 18.940683364868, 0, 0, 0);
	CreateObject(5715, 1471.435546875, -1649.779296875, 16.240636825562, 0, 0, 44.994506835938);
	CreateObject(5715, 1447.7332763672, -1649.8120117188, 16.240636825562, 0, 0, 45);
	CreateObject(3462, 1492.6462402344, -1629.5900878906, 24.308137893677, 0, 0, 0);
	CreateObject(3462, 1492.7308349609, -1643.4173583984, 24.308137893677, 0, 0, 0);
	CreateObject(3462, 1467.7042236328, -1643.6519775391, 24.308137893677, 0, 0, 180);
	CreateObject(3462, 1467.7155761719, -1629.5717773438, 24.308137893677, 0, 0, 179.99450683594);
	CreateObject(3462, 1468.3571777344, -1656.3508300781, 24.308137893677, 0, 0, 225);
	CreateObject(3462, 1491.9569091797, -1656.3024902344, 24.308137893677, 0, 0, 325);
	CreateObject(3462, 1480.5718994141, -1659.4609375, 28.792554855347, 0, 0, 270);
	CreateObject(5777, 1492.7684326172, -1636.1339111328, 16.200881958008, 0, 0, 0);
	CreateObject(5777, 1492.8684082031, -1649.7022705078, 16.200881958008, 0, 0, 0);
	CreateObject(5777, 1467.5119628906, -1650.1585693359, 16.200881958008, 0, 0, 0);
	CreateObject(5777, 1467.5529785156, -1636.7447509766, 16.200881958008, 0, 0, 0);
	CreateObject(3878, 1480.5456542969, -1659.3297119141, 16.115877151489, 0, 0, 270);
	CreateObject(2895, 1480.5717773438, -1657.8394775391, 15.394166946411, 0, 278, 319.99877929688);
	CreateObject(11472, 1494.5821533203, -1662.1767578125, 12.589323043823, 0, 0, 179.98901367188);
	CreateObject(11472, 1493.1456298828, -1661.9392089844, 12.589323043823, 0, 0, 179.98352050781);
	CreateObject(16410, 1493.2145996094, -1652.873046875, 14.855098724365, 2.999267578125, 0, 0);
	CreateObject(16410, 1493.0808105469, -1639.2825927734, 14.855098724365, 2.999267578125, 0, 0);
	CreateObject(16410, 1468.2590332031, -1639.8966064453, 14.855098724365, 2.999267578125, 0, 0);
	CreateObject(16410, 1468.1997070313, -1653.3120117188, 14.855098724365, 2.999267578125, 0, 0);
	for(new i; i<sizeof(dtext); i++) { Dlabel[i] = Create3DTextLabel("[����� �� ���������]",0xFFFFFFAA,dtext[i][0],dtext[i][1],dtext[i][2],20.0,0,1); }
	for(new i; i<sizeof(pickups); i++) { pickupidx[i] = CreatePickup(0,2,pickups[i][0],pickups[i][1],pickups[i][2],-1); }
	return 1;
}

public OnPlayerPickUpPickup(playerid,pickupid)
{
	if(pickupid == fshop) { ShowPlayerDialog(playerid,9001,DIALOG_STYLE_MSGBOX,"{FFFFFF}����","{FFFFFF}����� ����� 25$\n��� ������� ������� '������'","������","������"); }
	new xpickupid;
	for(new i; i<sizeof(pickupidx); i++) { if(pickupidx[i]==pickupid) xpickupid=i+1; }
	switch(xpickupid)
	{
		case 1..10:
		{
			ShowSmallDialog(playerid,pickupid);
		}
		case 11..17:
		{
		    ShowBigDialog(playerid,pickupid-10);
		}
	}
	return 1;
}

public NullFlowers() { for(new i; i<8; i++) DestroyObject(flowersobj[i]); for(new i; i<8; i++) Update3DTextLabelText(Dlabel[i], 0xFFFFFFFF,"[����� �� ���������]"); return 1; }

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new name[24],string[24+30];
	GetPlayerName(playerid, name, sizeof(name));
    if(newkeys == KEY_CROUCH)
	{
	    if(GetPlayerWeapon(playerid) == 14)
	    {
			/* � 1 � */
			if(IsPlayerInRangeOfPoint(playerid, 1.0, 1483.861, -1646.46, 15.698))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
				format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[0], 0xFFFFFFFF, string);
				flowersobj[0] = CreateObject(325,1483.861, -1646.46, 15.698, 0.00, 86.0, 300.0); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
		 	}
			/* � 2 � */
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1482.8311, -1647.0520, 15.6980))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
	            format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[1], 0xFFFFFFFF, string);
				flowersobj[1] = CreateObject(325,1482.8311, -1647.0520, 15.6980, 0.0000, 86.0000, 300.0000); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
		 	}
		 	/* � 3 � */
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1481.8196, -1647.6920, 15.6980))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
				format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[2], 0xFFFFFFFF, string);
				flowersobj[2] = CreateObject(325,1481.8196, -1647.6920, 15.6980, 0.0000, 86.0000, 300.0000); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
		 	}
		 	/* � 4 � */
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1480.4673, -1647.6760, 15.6980))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
				format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[3], 0xFFFFFFFF, string);
				flowersobj[4] = CreateObject(325,1480.4673, -1647.6760, 15.6980, 0.0000, 86.0000, 230.0000); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
		 	}
		 	/* � 5 � */
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1479.2545, -1647.7750, 15.6980))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
				format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[4], 0xFFFFFFFF, string);
				flowersobj[5] = CreateObject(325,1479.2545, -1647.7750, 15.6980, 0.0000, 86.0000, 230.0000); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
			}
			/* � 6 � */
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1478.4342, -1647.3800, 15.6980))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
				format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[5], 0xFFFFFFFF, string);
				flowersobj[6] = CreateObject(325,1478.4342, -1647.3800, 15.6980, 0.0000, 86.0000, 230.0000); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
			}
			/* � 7 � */
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1477.0970, -1646.5660, 15.6980))
			{
				if(GetPVarInt(playerid,"Exclusive") > gettime() ) return SendClientMessage(playerid,-1, "��������� ����� ����� ������ 1 ��� � 5 �����!");
				format(string,sizeof(string),"����� ��������\n� %s �",name); Update3DTextLabelText(Dlabel[6], 0xFFFFFFFF, string);
				flowersobj[7] = CreateObject(325,1477.0970, -1646.5660, 15.6980, 0.0000, 86.0000, 230.0000); ApplyAnimation(playerid,"BOMBER","BOM_Plant_2Idle",4.1,0,1,1,1,1); SetPVarInt(playerid,"Exclusive",gettime() + 300);
			}
		}
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 9001)
    {
    	if(response)
       	{
       	    GivePlayerMoney(playerid,-25); GivePlayerWeapon(playerid,14,1);
       	}
    }
    return 1;
}
