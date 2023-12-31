/*			����������			*/
#define GAMEMODE_NAME 		"Cream Life [DM] v0.6"	//�������� ����
#define GAMEMODE_DEVELOPERS	"Enriko"	//������������ ����

#define MIN_USER_PASS_LEN	4						//����������� ����� ������ ������
#define MAX_USER_PASS_LEN 	16						//������������ ����� ������ ������
#define	HEAD_ADMIN			5						//��������� ������� ������
#define	MAX_TUTORIAL_WINDOW	3						//���������� GUI ���� ��������
#define ACCOUNTS_SAVE_TIME	5						//�������� ����� ������������ ��������� (� �������)
#define	CONFIG_SAVE_TIME	10						//�������� ����� ������������ ������������ (� �������)
#define	CAMERA_CHANGE_TIME	5						//�������� ����� ������ ������� ������ ��� ������ ����� (� ��������)
#define KILLS_PER_LEVEL		2						//���������� ������� ��� �������� �� ��������� �������
#define MAX_GANG_AMOUNT		300						//������������ ���������� ����
#define MAX_GANG_NAME		15						//������������ ����� ����� �����
#define TAG_DRAW_DISTANCE	30						//��������� ���������� �������� ����� ��� ������� ������
#define	KILLS_PER_RESPECT	2						//������� ������ ������ ����� ����� �����, ����� ���������� +1 � ��������� ����� �����
#define	GNAME_CHANGE_PRICE	25000					//��������� ����� �������� �����
#define GCOLOR_CHANGE_PRICE	25000					//��������� ����� ����� �����
#define	GREPUTATION_PRICE	10000					//��������� 1 ��������� ��� �����
#define	AMMO_PACK			50						//������� �������� � ����� ���� ������
#define	AMMO_PACK_PRICE		25000					//���� ������ ���� ������
//�����
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_LIGHTRED 		0xFF6347AA
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_LIGHTGREEN	0x9ACD32AA
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_WHITE 		0xFFFFFFAA
#define COLOR_SPRINGGREEN 	0x00FF7FAA
//��������� �������� ������ ������
#define PISTOL_SKILL_REP	10		//��������� ��� �������� ���������
#define PISTOL_SKILL_MON	10000	//������ ��� �������� ���������
#define UZI_SKILL_REP		20		// ...
#define UZI_SKILL_MON		20000
#define SAWN_SKILL_REP		30
#define SAWN_SKILL_MON  	30000
//������� �����
#define MAX_GANG_ARMOUR		100		//������������ ���������� ��������� ����� �����
#define ARMOUR_GANG_REP		1		//��������� ��� �������� 1 �������� �����
#define ARMOUR_GANG_MON		5000	//������ ��� �������� 1 �������� �����
//���������� �������� ��� �������� ������
#define	WR3_DEF_AMMO		50	
#define	WR4_DEF_AMMO		50
#define	WR5_DEF_AMMO		150
#define	WR6_DEF_AMMO		150
#define	WR7_DEF_AMMO		150
#define	WR8_DEF_AMMO		15
/* ��� ����� ������� */
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
new Text:Nitro[MAX_PLAYERS], Text:T_Nitro[MAX_PLAYERS], Text:T_Nitro2[MAX_PLAYERS], Cantidad[MAX_VEHICLES], Timer_C;
/*����� ����� �������*/
/* ��� ����� ������� */
new DriftPointsNow[200];
new PlayerDriftCancellation[200];
new Float:ppos[200][3];
enum Float:Pos{ Float:sXXX,Float:sYYY,Float:sZZZ };
new Float:SavedPos[MAX_PLAYERS][Pos];
#define DRIFT_MINKAT 10.0
#define DRIFT_MAXKAT 90.0
#define DRIFT_SPEED 30.0
#define COLOR_BLUE 0x33AAFFAA
#define XX 534.3334
#define YY -2680.6028
#define ZZ -37.7500
/* ����� ������� ����� */
new WeaponPrices[8]  = {5,10,20,25,30,40,50,60};	//��������� ��� ������� ������
new WeaponAmmo[8]  = {1,1,50,50,150,150,150,15};	//�������� ������
new WeaponsRank_1[6] = {1, 2, 3, 5, 6, 7};			//������ ������ �������
new WeaponsRank_2[2] = {4, 8};						//������ ������ �������
new WeaponsRank_3[2] = {22, 23};
new WeaponsRank_4[1] = {24};
new WeaponsRank_5[2] = {28, 32};					//..
new WeaponsRank_6[3] = {25, 29, 33};
new WeaponsRank_7[3] = {30, 31, 34};
new WeaponsRank_8[4] = {16, 17, 18, 41};			//������ ������� �������

new CarAmount;										//���������� ����������
new BUYGUN_Info[5][3] = //5 = ���-�� ������, ���������� ��� �������
{
//1-� ����� = ID ������, 2-� ����� = ���� ������, 3-� ����� = ���� �� 1 ������
	{23,3000,5},	//������ ������ (������ ���, ���� ������ = $2500, ���� �� 1 ������ = $5)
	{24,5000,7},	//������ ������
	{29,7000,8},	//������ ������
	{30,15000,10},	//��������� ������
	{31,15000,10}		//����� ������
};
new FAQ_Title[7][128] = 	//20 = ���-�� ������� � /faq , 32 = ������������ ����� ���������
{//��������� ������� � /faq
	"������������� [Cream Life][DM]",//1
	"������� �������",//2
	"C��� �������",//3
	"������� �������",//4
	"������ ����������",//5
	"�������� �����",//6
	"������� �������� ����"//7
	//"...............",//8
	//"...............",//9
	//"...............",//10
	//"...............",//11
	//"..............."//12
	//�� �������� ��� ������� � ��������� ������!!!!
};
new FAQ_Message[sizeof(FAQ_Title)][512] = //128 = ������������ ����� ������ ���������
{
/*1*/	"{FFFF00}�����������/������� ������������� : {008B00}Enriko {FF0000}[5]\n {FFFF00}Web �����������/ ������� ������������� : {008B00}HaoS {FF0000}[4]\n {FFFF00}������� ������������� : {008B00}oddatte {FF0000}[4]\n {FFFF00}������� ������������� : {008B00}Ordi {FF0000}[4]\n {FFFF00}������� �������� �������������� : {008B00}SLiM[228] {FF0000}[3]",
/*2*/	"{FF0000}1.{BABABA}�� ������� ����������� ����� ������������� ��������� ��������, ���-�� (cleo) ��������\n {FF0000}2.{BABABA}����� ���/����������� ������ ����������!\n {FF0000}3.{BABABA}������� ��������� �������� ����������.",
/*3*/	"{DBED15}http://gta.relaxport.ru",
/*4*/	"{FFFF00}/gang - {37DB45}��������������/��������/���������� ����\n {FFFF00}/unfreezeme - {37DB45}����������� ������ ����\n {FFFF00}/deletemygang - {37DB45}������� ���� �����\n {FFFF00}/kill - {37DB45}����� ������ ����\n {FFFF00}/savepos - {37DB45}��������� �������\n {FFFF00}/mymoney - {37DB45}���������� ���� ������\n {FFFF00}/buygun - {37DB45}������ ������",
/*5*/	"����� ��������� ����������, ����� ����� ������ 5 ������� � ����� � ������� 3 ����� ����� � ����\n ������ ������ ������� ������ ����� �� ����� ������\n �� ����� ������� ������ ������� ������ 10 ���, ����������� �����.",
/*6*/	"����� ������� ����� ���������� ����� 5 ����, ������ ������ {FF0000}/gang",
/*7*/	"���� �� ������� ���������� ������ ���, ������� ��������� � {FF0000}ICQ: 2349520\n {FFFFFF}���-�� ���� ������� ��� ��������� ����� ������ {FF0000}������!{FFFFFF} �� ����� �������� � {FF0000}'Enriko' "
/*8*/	//"�������������",
/*9*/	//"�������������",
/*10*/	//"�������������",
/*11*/	//"�������������",
/*12*/	//"�������������"
};
enum col_enum
{
	col_Name[16],	//�������� �����
	col_Color[8],	//��� ����� 
	col_Veh			//ID ����� ��� ����������
}
/*
	����� ��� �����������
	����� �������� ���:
	- ����������� ����� � ������� �� 1
	- ��������� ������� � ������� { "�������� �����" , "���� � 16-������ ������� ��������� ��� ������ ���� �������� � ��������� ���� ��������") },
*/
new RegistrationColors[19][col_enum] =
{
	{ "�����",			"BABABA",	13 	},//1
	{ "�������",		"FF0000", 	3	},//2
	{ "���������",		"FF7F00", 	6	},//3
	{ "������",			"FFFF00",	6	},//4
	{ "����-�������",	"00FF00", 	86	},//5
	{ "Ҹ���-�������",	"008B00", 	4	},//6
	{ "�����",			"FFFFFF",	1	},//7
	{ "�������",		"00E5EE",	2	},//8
	{ "�����",			"1B1BE0",	53	},//9
    { "����������",		"A020F0",	160	},//10
	{ "�������",		"FF00FF", 	126	},//11
	{ "Ҹ���-�������",	"8B0000", 	126	},//12
	{ "Ҹ���-�����",	"363636", 	126	},//13
	{ "������-�������",	"FFAEB9", 	126	},//14
	//{ "����-��������",	"FF0000", 	126	},//15
    { "��������",		"FFFF00", 	126	},//16
    { "�������",		"DAA520", 	126	},//17
    { "����������",		"8B4500", 	126	},//18
    { "���������",		"00FF7F", 	126	},//19
    { "Ҹ���-�����",	"0000FF", 	126	} //20
};
new StandartSkins[279] = //�����, ������� ����� �������� ����� ����� ����������� / �����������
{	//������ ������ � �������� � ��� ���� � wiki

	/*				�����				*/
	105, 106, 107,		//���� �����
	102, 103, 104,		//������
	114, 115, 116,		//����� ��� �������
	108, 109, 110,		//�����
	121, 122, 123,		//����� "�� ����"
	173, 174, 175,		//��� ������ ����
	117, 118, 120,		//������
	247, 248, 254,		//�������
	111, 112, 113,		//������� �����
	124, 125, 126, 127,	//����������� �����
	
	/*		������������ �����������	*/
	165, 166,			//"���� � ������"		
	280, 281, 282,		//������� �������
	283, 288, 			//�����
	284, 285, 286, 287,	//���-�����������, S.W.A.T. , ���, �����		
	277, 278, 279,		//���������
	274, 275, 276,		//������
	163, 164,			//�������������
	
	/*			������� �����			*/
	190, 191, 192,
	193, 194, 195,
	
	/*			���������� �����		*/
	138, 139, 140, 145,
	146, 154, 251, 94,
	97,	 45,  18,
	
	/*		������ �������� ���������	*/
	128, 129, 130, 131,
	132, 133, 157, 158,
	159, 160, 196, 197,
	198, 199, 161, 162,
	200, 201, 202, 31,
	32,	 33,  34,
	
	/*		���������� ������� (�����)	*/
	152, 178, 237, 238,
	243, 244, 207, 245,
	246, 85,  256, 257,
	64,  63,  87,  90,
	
	/*			����������				*/
	258, 259, 26,  51,
	52,  80,  81,  23,
	96,  99,
	
	/*			���������				*/
	11,  141, 147, 148,
	150, 153, 167, 68,
	171, 176, 177, 172,
	179, 187, 189, 203,
	204, 155, 205, 209,
	217, 211, 219, 260,
	16,  27,  254, 70,
	
	/*			������� ��������		*/
	10,  101, 12,  13,
	136, 14,  142, 143,
	144, 15,  151, 156,
	168, 169, 17,  170,
	180, 182, 54,  183,
	184, 236, 75,  186,
	185, 188, 19,  216, 
	20,  206, 21,  22,
	210, 214, 215, 220,
	221, 225, 226, 222,
	223, 227, 231, 228,
	234, 76,  235, 236,
	89,  88,  24,  218,
	240, 25,  250, 261,
	28,  40,  41,  35,
	36,  37,  38,  43,
	44,  69,  49,  9,
	93,  39,  48,  47,
	262, 229, 58,  29,
	60,  232, 233, 67,
	7,   72,  55,  94,
	95,  98,  56,  
	
	/*		���������� ���������		*/
	
	265, 266, 267, 268,
	269, 270, 271, 272,
	290, 291, 292, 293,
	294, 295, 296, 297,
	298, 299,
	
	/*			���������				*/
	134, 135, 137, 181,
	213, 212, 224, 230,
	239, 249, 241, 242,
	252, 253, 255, 29,
	30,  49,  50,  57,
	61,  62,  66,  73,
	77,  78,  79,  82,
	83,  84
	
};
new Float:RandSpawn[10][4] =
{
	{2230.0186,-1160.1522,25.8107,92.8651},	//x, y, z, a
	{2323.3408,-1508.4216,25.7266,275.9403},
	{2494.8772,-1686.4658,13.5135,359.0941},
	{2101.1086,-1806.1754,13.5547,90.1722},
	{1873.0569,-2061.6760,13.5469,343.6317},
	{1743.4985,-1862.7352,13.5759,358.8018},
	{1479.9169,-1741.9606,13.5469,1.9455},
	{1299.0192,-800.9059,84.1406,255.7620},
	{825.8691,-1102.7754,25.5938,267.2013},
	{1941.9327,-1373.5129,18.4006,98.5456}
};
//����������� �������� � ������ ������� �� 1
new Float:CamBefSpawn[5][2][3] = 	//������ ����� ������� ������
{
	//������ �������
	{	
		{-215.8599,981.6966,22.9432},	//������� ������
		{-216.6876,984.3950,23.0856}	//������� ������
	},
	//������ �������
	{
		{134.4837,1356.9277,26.2804},	//������� ������
		{133.5497,1360.0106,27.7837}	//������� ������
	},
	//������ �������
	{	
		{1159.0663,1934.4314,22.8222},	
		{1157.4282,1938.1676,24.0261}	
	},
	//��������� �������
	{
		{1445.8694,365.5289,18.9520},	
		{1446.8807,367.9583,20.9848}	
	},
	//����� �������
	{	
		{1186.4657,-152.0419,40.6440},	
		{1185.1105,-146.7706,42.6703}	
	}//  ����	     <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	 //��������� ������� ����� ���������� ������ ^^^
	 //������� ����������� ����, ������ ���� ����������
	 //����� ������������� '}' ������� ���� �� ������
/*
	 //�������������� �������
	{
		{0.0,0.0,0.0},					//������� ������
		{0.0,0.0,0.0}					//������� ������
	}//��� ����� ������������� '}'
*/
};	 //��������� '}'

enum enum_config
{
	MaxGangCars_cfg,
	MaxHouseAmount_cfg
}
new Config[enum_config];
new Timer_SaveAccounts;	//ID �������, ������������ �������� �������
new Timer_SaveConfig;	//ID ������� ��� ������������
new Timer_Players;		//ID ������� ��� �������
new Timer_Anticheat;	//ID ������� ��� ��������
//��� �������
//�� �����������
new	bool:	PlayerLoggedIn[MAX_PLAYERS];		//����������� �� �����
new Text:	PlayerZoneTextdraw[MAX_PLAYERS];	//�������� ����, �� ������� ����� ��������� �����
new			PlayerTutorialWindow[MAX_PLAYERS];	//� ����� GUI ���� �������� ��������� ����� 	
new			PlayerCameraTimer[MAX_PLAYERS];		//������� ������ ��������, ������ ��� ������� ������� ������ ��� ������ �����		
new			PlayerCashToGive[MAX_PLAYERS];		//���-�� �����, ������� ����� ������ ������		
new Text3D:	PlayerGangLabel[MAX_PLAYERS];		//3D-����� ��� ������� � ����������� � �����
new			PlayerColor[MAX_PLAYERS];			//���� ������
new			PlayerGangInvited[MAX_PLAYERS];		//�� ������, ������� ��������� � �����
//�����������
enum pdata
{
	pPassword[MAX_USER_PASS_LEN+1],	//������ ������
	pTutorial,						//������ �� ����� ��������?
	Float:pPos_x,					//���������� ������, x
	Float:pPos_y,					//���������� ������, y
	Float:pPos_z,					//���������� ������, z
	Float:pFacingAngle,				//���� �������� ������
	pInterior,						//�������� ������
	pVirtualWorld,					//����������� ��� ������
	pKills,							//���������� ������� (���������� � ���������� ����)
	pLastVictim[MAX_PLAYER_NAME],	//��� ��������� "������" ������� ������
	pLevel,							//������� ������
	pMoney,							//���-�� ����� � ������
	pGangMember,					//�� �����, ������ ������� �������� �����
	pGangLeader,					//�������� �� ����� ������� �����, � ������� �� �������
	pEnemyKills,					//������� ������ ������ ����� ���� ����� (����������)
	pAdmin							//������� ������
};	
new PlayerInfo[MAX_PLAYERS][pdata];	//�������� ������ � ����������� ����� �������
