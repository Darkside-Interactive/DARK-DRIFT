//Military Base Bombing Script

forward MineRun();
forward MineRun2();
forward MineRun3();
forward Minerun_OnGameModeInit();

new Minerun_Enabled = 1;
new Minerun_Time1 = 2000;
new Minerun_Time2 = 1000;
new Minerun_Time3 = 1500;
new MineTMR1;
new MineTMR2;
new MineTMR3;

#define MINES_SIZE 43
new Float:Mines[MINES_SIZE][CoordInfo] = {
{335.324249,1809.999389,17.422206},
{344.868621,1828.381713,17.328859},
{322.501586,1829.441650,17.345781},
{303.481018,1807.960571,17.316085},
{302.469787,1830.298217,17.345655},
{324.797119,1849.115844,17.345779},
{354.202819,1886.942749,17.366865},
{335.719299,1894.427978,17.345689},
{301.941711,1894.482910,17.316097},
{287.983917,1917.636108,17.316099},
{246.322311,1954.003784,17.345670},
{246.666397,1996.318481,17.316095},
{225.883193,1993.879272,17.345695},
{210.809402,1965.451293,17.316068},
{208.357727,2026.516601,17.329950},
{244.303390,2044.139404,17.345621},
{286.278320,2071.832763,17.345649},
{307.484863,2059.517578,17.345775},
{305.697540,2033.230224,17.345804},
{322.028076,2012.171752,17.347257},
{349.346954,1984.184570,17.345682},
{374.475799,2003.074829,17.345617},
{302.161865,1968.298095,17.299900},
{328.696685,1776.689575,17.299928},
{363.502655,1799.411376,17.523963},
{373.129302,1784.182739,18.006160},
{314.125671,1774.341430,17.336164},
{362.201232,1834.957519,17.441162},
{377.020782,1839.337402,17.822917},
{93.095787,1915.031005,17.666421},
{90.443252,1923.796508,17.610311},
{108.889511,1914.653198,18.230510},
{104.868110,1924.265869,18.107732},
{118.123130,1922.773437,18.620126},
{236.216873,1900.750366,17.316093},
{223.897171,1880.991088,17.345727},
{210.208053,1871.945068,17.336204},
{206.043807,1883.746948,17.319927},
{207.702896,1905.673950,17.345651},
{216.565307,1918.674072,17.345680},
{214.878311,1895.432983,16.049276},
{195.540527,1918.915161,17.345714},
{179.653747,1897.071533,17.747814}
};

#define MINES_SIZE2 23
new Float:Mines2[MINES_SIZE2][CoordInfo] = {
{332.537658,2055.203369,17.633132},
{294.821441,2034.488769,17.631196},
{309.049468,1992.734863,17.631055},
{298.001617,1931.784912,17.633497},
{319.991058,1898.285522,17.631629},
{312.094818,1863.815185,17.632743},
{337.789428,1836.011840,17.632614},
{343.687255,1817.568847,17.836313},
{328.834503,1807.106445,17.697191},
{293.478424,1820.763061,17.631052},
{290.609313,1850.623657,17.633089},
{290.020843,1902.108642,17.634084},
{358.592010,1932.562622,17.631336},
{382.755187,1911.444458,17.630943},
{374.897003,1887.435180,17.649385},
{384.651062,2017.419799,18.769384},
{377.071868,2053.662109,17.730722},
{378.143096,2077.915039,17.631502},
{336.962341,2075.062011,17.630296},
{295.504455,2077.431152,17.631319},
{286.754425,2066.173828,17.632818},
{266.249481,2040.550292,17.631814},
{325.746826,1931.188720,17.638072}
};

#define MINES_SIZE3 8
new Float:Mines3[MINES_SIZE3][CoordInfo] = {
{193.457672,1946.340576,17.640625},
{189.992248,1964.910644,17.640625},
{203.423736,1984.145996,17.640625},
{196.092498,2003.451660,17.648057},
{189.750152,2021.994506,17.640625},
{199.164672,2042.866210,17.640625},
{206.489074,2067.822998,21.771425},
{196.039260,2065.442626,22.644439}
};


public Minerun_OnGameModeInit(){
	Minerun_Config();
	if (Minerun_Enabled == 1) {
	Minerun_On();
	WriteLog("Military Base Bombing script init.");
	}
}

forward Minerun_On();
forward Minerun_Off();

public Minerun_On() {
	MineTMR1 = SetTimer("MineRun",Minerun_Time1,1);
	MineTMR2 = SetTimer("MineRun2",Minerun_Time2,1);
	MineTMR3 = SetTimer("MineRun3",Minerun_Time3,1);
}

public Minerun_Off() {
	KillTimer(MineTMR1);
	KillTimer(MineTMR2);
	KillTimer(MineTMR3);
}

forward Minerun_Config();
public Minerun_Config()
{
	if (!dini_Exists(ConfigDB)) return;

	new temp[MAX_STRING];

	set(temp,dini_Get(ConfigDB,"Minerun_Enabled"));
	if (strlen(temp) > 0) Minerun_Enabled = strval(temp); 
	else { valstr(temp,Minerun_Enabled); dini_Set(ConfigDB,"Minerun_Enabled",temp); }

	set(temp,nullstr);	
	set(temp,dini_Get(ConfigDB,"Minerun_Time1"));
	if (strlen(temp) > 0) Minerun_Time1 = strval(temp); 
	else { valstr(temp,Minerun_Time1); dini_Set(ConfigDB,"Minerun_Time1",temp); }
	
	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"Minerun_Time2"));
	if (strlen(temp) > 0) Minerun_Time2 = strval(temp); 
	else { valstr(temp,Minerun_Time2); dini_Set(ConfigDB,"Minerun_Time2",temp);  }

	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"Minerun_Time3"));
	if (strlen(temp) > 0) Minerun_Time3 = strval(temp); 
	else { valstr(temp,Minerun_Time3); dini_Set(ConfigDB,"Minerun_Time3",temp);  }
}


public MineRun()
{
//if (sysmbbomb == 0) {return;}
new rand = random(sizeof(Mines));
CreateExplosion(Mines[rand][Coord_X], Mines[rand][Coord_Y], Mines[rand][Coord_Z], 7, random(20)+10);
}

public MineRun2()
{
//if (sysmbbomb == 0) {return;}
new rand = random(sizeof(Mines2));
CreateExplosion(Mines2[rand][Coord_X], Mines2[rand][Coord_Y], Mines2[rand][Coord_Z], random(12), random(20)+5);
}

public MineRun3()
{
//if (sysmbbomb == 0) {return;}
new rand = random(sizeof(Mines3));
CreateExplosion(Mines3[rand][Coord_X], Mines3[rand][Coord_Y], Mines3[rand][Coord_Z], 10, random(30)+10);
}