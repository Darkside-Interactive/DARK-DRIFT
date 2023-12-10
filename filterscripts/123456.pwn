#include                                         <      a_samp      >
new
	Text:speedom[122],
	Text:mysp[16],
	Float:ST[4],
	spedom[MAX_PLAYERS];
public OnFilterScriptInit(){
    speedom[32] = TextDrawCreate(37.401531, 432.959899,".");
	TextDrawColor(speedom[32],0xffffffff);
	mysp[0] = TextDrawCreate(30,410,"0");
    TextDrawColor(mysp[0],0xffffffff);
    mysp[1] = TextDrawCreate(14,394,"20");
    TextDrawColor(mysp[1],0xCBFFBFff);
    mysp[2] = TextDrawCreate(8,375,"40");
    TextDrawColor(mysp[2],0x94FF7Dff);
    mysp[3] = TextDrawCreate(14,355,"60");
    TextDrawColor(mysp[3],0xB5FE63ff);
    mysp[4] = TextDrawCreate(26,336,"80");
    TextDrawColor(mysp[4],0xEBFE63ff);
    mysp[5] = TextDrawCreate(57,321,"100");
    TextDrawColor(mysp[5],0xFFE862ff);
    mysp[6] = TextDrawCreate(96,321,"120");
    TextDrawColor(mysp[6],0xFFD362ff);
    mysp[7] = TextDrawCreate(131,336,"140");
    TextDrawColor(mysp[7],0xFEB063ff);
    mysp[8] = TextDrawCreate(145,355,"160");
    TextDrawColor(mysp[8],0xFEA043ff);
    mysp[9] = TextDrawCreate(151,375,"180");
    TextDrawColor(mysp[9],0xFE7B43ff);
    mysp[10] = TextDrawCreate(145,394,"200");
    TextDrawColor(mysp[10],0xFE5A43ff);
    mysp[11] = TextDrawCreate(132,410,"220");
    TextDrawColor(mysp[11],0xFF2D2Dff);
    for(new i=0; i<12; i++)
    TextDrawAlignment(mysp[i],0),
    TextDrawBackgroundColor(mysp[i],0x00000022),
    TextDrawSetOutline(mysp[i],1),
    TextDrawSetProportional(mysp[i],1),
    TextDrawSetShadow(mysp[i],1),
	TextDrawFont(mysp[i],2),
	TextDrawLetterSize(mysp[i],0.3,1.1);
	mysp[12] = TextDrawCreate(88.5,380,"-");
	TextDrawAlignment(mysp[12],0),
	TextDrawLetterSize(mysp[12],3.5, 0.6),
    TextDrawBackgroundColor(mysp[12],0x00ff0022),
    TextDrawColor(mysp[12],0x00000099),
    TextDrawSetOutline(mysp[12],1),
    TextDrawSetProportional(mysp[2],1),
    TextDrawSetShadow(mysp[12],1),
	TextDrawFont(mysp[12],1);
	mysp[13] = TextDrawCreate(48,380,"-");
	TextDrawAlignment(mysp[13],0),
	TextDrawLetterSize(mysp[13],3.5, 0.6),
    TextDrawBackgroundColor(mysp[13],0x00ff0022),
    TextDrawColor(mysp[13],0x00000099),
    TextDrawSetOutline(mysp[13],1),
    TextDrawSetProportional(mysp[13],1),
    TextDrawSetShadow(mysp[13],1),
	TextDrawFont(mysp[13],1);
	mysp[14] = TextDrawCreate(86.7,254,"-");
	TextDrawAlignment(mysp[14],0),
	TextDrawLetterSize(mysp[14],0.10, 20),
    TextDrawBackgroundColor(mysp[14],0x00ff0022),
    TextDrawColor(mysp[14],0x00000088),
    TextDrawSetOutline(mysp[14],1),
    TextDrawSetProportional(mysp[14],1),
    TextDrawSetShadow(mysp[14],1),
	TextDrawFont(mysp[14],1);
	mysp[15] = TextDrawCreate(86.7,285,"-");
	TextDrawAlignment(mysp[15],0),
	TextDrawLetterSize(mysp[15],0.10, 20),
    TextDrawBackgroundColor(mysp[15],0x00ff0022),
    TextDrawColor(mysp[15],0x00000088),
    TextDrawSetOutline(mysp[15],1),
    TextDrawSetProportional(mysp[15],1),
    TextDrawSetShadow(mysp[15],1),
	TextDrawFont(mysp[15],1);
    speedom[0] = TextDrawCreate(35.324634, 430.428039,".");
	TextDrawColor(speedom[0],0xffffffff);
	speedom[1] = TextDrawCreate(33.430648, 427.784698,".");
	TextDrawColor(speedom[1],0xffffffff);
    speedom[2] = TextDrawCreate(31.862686, 425.281860,".");
	TextDrawColor(speedom[2],0xffffffff);
	speedom[3] = TextDrawCreate(30.776248, 423.329376,".");
	TextDrawColor(speedom[3],0xffffffff);
	speedom[4] = TextDrawCreate(29.404899, 420.520385,".");
	TextDrawColor(speedom[4],0xCBFFBFff);
	speedom[5] = TextDrawCreate(28.617698, 418.673034,".");
	TextDrawColor(speedom[5],0xCBFFBFff);
	speedom[6] = TextDrawCreate(27.498638, 415.608367,".");
	TextDrawColor(speedom[6],0xCBFFBFff);
	speedom[7] = TextDrawCreate(26.861858, 413.517364,".");
	TextDrawColor(speedom[7],0xCBFFBFff);
	speedom[8] = TextDrawCreate(26.108127, 410.468261,".");
	TextDrawColor(speedom[8],0xCBFFBFff);
	speedom[9] = TextDrawCreate(25.531257, 407.269378,".");
	TextDrawColor(speedom[9],0x94FF7Dff);
	speedom[10] = TextDrawCreate(25.234642, 404.838317,".");
	TextDrawColor(speedom[10],0xB0FA5Fff);
	speedom[11] = TextDrawCreate(25.036220, 401.902801,".");
	TextDrawColor(speedom[11],0xB0FA5Fff);
	speedom[12] = TextDrawCreate(25.000000, 399.998657,".");
	TextDrawColor(speedom[12],0xB0FA5Fff);
	speedom[13] = TextDrawCreate(25.095291, 396.914550,".");
	TextDrawColor(speedom[13],0xB0FA5Fff);
	speedom[14] = TextDrawCreate(25.267501, 394.834869,".");
	TextDrawColor(speedom[14],0xB0FA5Fff);
	speedom[15] = TextDrawCreate(25.720287, 391.543640,".");
	TextDrawColor(speedom[15],0xB0FA5Fff);
	speedom[16] = TextDrawCreate(26.200008, 389.111450,".");
	TextDrawColor(speedom[16],0xB0FA5Fff);
	speedom[17] = TextDrawCreate(26.535270, 387.704895,".");
	TextDrawColor(speedom[17],0xB0FA5Fff);
	speedom[18] = TextDrawCreate(27.115295, 385.610595,".");
	TextDrawColor(speedom[18],0xB0FA5Fff);
	speedom[19] = TextDrawCreate(27.573451, 384.165771,".");
	TextDrawColor(speedom[19],0xB0FA5Fff);
	speedom[20] = TextDrawCreate(28.353984, 381.995849,".");
	TextDrawColor(speedom[20],0xD3FB5Eff);
	speedom[21] = TextDrawCreate(29.110584, 380.146484,".");
	TextDrawColor(speedom[21],0xD3FB5Eff);
	speedom[22] = TextDrawCreate(30.003578, 378.198120,".");
	TextDrawColor(speedom[22],0xD3FB5Eff);
	speedom[23] = TextDrawCreate(30.943103, 376.357025,".");
	TextDrawColor(speedom[23],0xD3FB5Eff);
	speedom[24] = TextDrawCreate(31.610439, 375.153564,".");
	TextDrawColor(speedom[24],0xD3FB5Eff);
	speedom[25] = TextDrawCreate(32.650913, 373.418884,".");
	TextDrawColor(speedom[25],0xD3FB5Eff);
	speedom[26] = TextDrawCreate(33.421348, 372.229217,".");
	TextDrawColor(speedom[26],0xD3FB5Eff);
	speedom[27] = TextDrawCreate(34.611717, 370.524810,".");
	TextDrawColor(speedom[27],0xD3FB5Eff);
	speedom[28] = TextDrawCreate(35.456802, 369.400390,".");
	TextDrawColor(speedom[28],0xD3FB5Eff);
	speedom[29] = TextDrawCreate(36.784107, 367.758026,".");
	TextDrawColor(speedom[29],0xD3FB5Eff);
	speedom[30] = TextDrawCreate(38.190975, 366.160736,".");
	TextDrawColor(speedom[30],0xE4FC5Cff);
	speedom[31] = TextDrawCreate(39.222682, 365.071746,".");
	TextDrawColor(speedom[31],0xE4FC5Cff);
	speedom[33] = TextDrawCreate(40.596107, 363.718170,".");
	TextDrawColor(speedom[33],0xE4FC5Cff);
	speedom[34] = TextDrawCreate(41.608734, 362.784088,".");
	TextDrawColor(speedom[34],0xE4FC5Cff);
	speedom[35] = TextDrawCreate(43.259990, 361.366180,".");
	TextDrawColor(speedom[35],0xE4FC5Cff);
	speedom[36] = TextDrawCreate(44.814285, 360.139953,".");
	TextDrawColor(speedom[36],0xE4FC5Cff);
	speedom[37] = TextDrawCreate(46.029258, 359.248352,".");
	TextDrawColor(speedom[37],0xE4FC5Cff);
	speedom[38] = TextDrawCreate(47.527160, 358.223907,".");
	TextDrawColor(speedom[38],0xE4FC5Cff);
	speedom[39] = TextDrawCreate(48.674690, 357.491424,".");
	TextDrawColor(speedom[39],0xE4FC5Cff);
	speedom[40] = TextDrawCreate(50.482131, 356.423919,".");
	TextDrawColor(speedom[40],0xF4FD5Bff);
	speedom[41] = TextDrawCreate(51.687698, 355.767242,".");
	TextDrawColor(speedom[41],0xF4FD5Bff);
	speedom[42] = TextDrawCreate(53.342453, 354.933929,".");
	TextDrawColor(speedom[42],0xF4FD5Bff);
	speedom[43] = TextDrawCreate(54.511066, 354.390747,".");
	TextDrawColor(speedom[43],0xF4FD5Bff);
	speedom[44] = TextDrawCreate(56.331035, 353.616058,".");
	TextDrawColor(speedom[44],0xF4FD5Bff);
	speedom[45] = TextDrawCreate(57.556175, 353.141571,".");
	TextDrawColor(speedom[45],0xF4FD5Bff);
	speedom[46] = TextDrawCreate(59.383964, 352.501159,".");
	TextDrawColor(speedom[46],0xF4FD5Bff);
	speedom[47] = TextDrawCreate(60.627845, 352.110107,".");
	TextDrawColor(speedom[47],0xF4FD5Bff);
	speedom[48] = TextDrawCreate(62.537475, 351.578063,".");
	TextDrawColor(speedom[48],0xF4FD5Bff);
	speedom[49] = TextDrawCreate(64.620719, 351.089172,".");
	TextDrawColor(speedom[49],0xF4FD5Bff);
	speedom[49] = TextDrawCreate(65.886276, 350.837615,".");
	TextDrawColor(speedom[49],0xF4FD5Bff);
	speedom[50] = TextDrawCreate(66.909934, 350.658843,".");
	TextDrawColor(speedom[50],0xFDF15Bff);
	speedom[51] = TextDrawCreate(67.868965, 350.511138,".");
	TextDrawColor(speedom[51],0xFDF15Bff);
    speedom[52] = TextDrawCreate(68.636573, 350.406585,".");
	TextDrawColor(speedom[52],0xFDF15Bff);
	speedom[53] = TextDrawCreate(69.574790, 350.295196,".");
	TextDrawColor(speedom[53],0xFDF15Bff);
	speedom[54] = TextDrawCreate(70.186012, 350.232299,".");
	TextDrawColor(speedom[54],0xFDF15Bff);
	speedom[55] = TextDrawCreate(71.071029, 350.154602,".");
	TextDrawColor(speedom[55],0xFDF15Bff);
	speedom[56] = TextDrawCreate(72.028015, 350.088409,".");
	TextDrawColor(speedom[56],0xFDF15Bff);
	speedom[57] = TextDrawCreate(72.950660, 350.042022,".");
	TextDrawColor(speedom[57],0xFDF15Bff);
	speedom[58] = TextDrawCreate(73.908653, 350.011901,".");
	TextDrawColor(speedom[58],0xFDF15Bff);
    speedom[59] = TextDrawCreate(74.877418, 350.000152,".");
	TextDrawColor(speedom[59],0xFDF15Bff);
	speedom[60] = TextDrawCreate(75.529548, 350.002807,".");
	TextDrawColor(speedom[60],0xFDF15Bff);
	speedom[61] = TextDrawCreate(76.50307, 350.022583,".");
	TextDrawColor(speedom[61],0xFDF15Bff);
	speedom[62] = TextDrawCreate(77.154121, 350.046417,".");//350.046417
	TextDrawColor(speedom[62],0xFDDD5Bff);
	speedom[63] = TextDrawCreate(77.636695, 350.515754,".");
	TextDrawColor(speedom[63],0xFDDD5Bff);
	speedom[64] = TextDrawCreate(80.818321, 350.518463,".");
	TextDrawColor(speedom[64],0xFDDD5Bff);
	speedom[65] = TextDrawCreate(83.280525, 350.223236,".");
	TextDrawColor(speedom[65],0xFDDD5Bff);
	speedom[66] = TextDrawCreate(88.507255, 350.002563,".");
	TextDrawColor(speedom[66],0xFDDD5Bff);
	speedom[67] = TextDrawCreate(91.731109, 350.139404,".");
	TextDrawColor(speedom[67],0xFDDD5Bff);
	speedom[68] = TextDrawCreate(93.899375, 350.349243,".");
	TextDrawColor(speedom[68],0xFDDD5Bff);
	speedom[69] = TextDrawCreate(97.121894, 350.839141,".");
	TextDrawColor(speedom[69],0xFDDD5Bff);
	speedom[70] = TextDrawCreate(99.525985, 351.346618,".");
	TextDrawColor(speedom[70],0xFDDD5Bff);
	speedom[71] = TextDrawCreate(102.386077, 352.114288,".");
	TextDrawColor(speedom[71],0xFDDD5Bff);
	speedom[72] = TextDrawCreate(105.100166, 353.015075,".");
	TextDrawColor(speedom[72],0xFDC55Bff);
	speedom[73] = TextDrawCreate(107.222015, 353.842498,".");
	TextDrawColor(speedom[73],0xFDC55Bff);
	speedom[74] = TextDrawCreate(110.218063, 355.207611,".");
	TextDrawColor(speedom[74],0xFDC55Bff);
	speedom[75] = TextDrawCreate(111.976905, 356.123962,".");
	TextDrawColor(speedom[75],0xFDC55Bff);
	speedom[76] = TextDrawCreate(114.802116, 357.790435,".");
	TextDrawColor(speedom[76],0xFDC55Bff);
	speedom[77] = TextDrawCreate(117.422355, 359.573211,".");
	TextDrawColor(speedom[77],0xFDC55Bff);
	speedom[78] = TextDrawCreate(119.910507, 361.506896,".");
	TextDrawColor(speedom[78],0xFDC55Bff);
	speedom[79] = TextDrawCreate(122.429077, 363.742065,".");
	TextDrawColor(speedom[79],0xFDC55Bff);
	speedom[79] = TextDrawCreate(123.822807, 365.118408,".");
	TextDrawColor(speedom[79],0xFDC55Bff);
	speedom[80] = TextDrawCreate(125.720169, 367.179443,".");
	TextDrawColor(speedom[80],0xFDC55Bff);
	speedom[81] = TextDrawCreate(126.392639, 367.968688,".");
	TextDrawColor(speedom[81],0xFDB55Bff);
	speedom[82] = TextDrawCreate(127.487609, 369.328704,".");
	TextDrawColor(speedom[82],0xFDB55Bff);
	speedom[83] = TextDrawCreate(128.528839, 370.718383,".");
	TextDrawColor(speedom[83],0xFDB55Bff);
	speedom[84] = TextDrawCreate(129.195327, 371.663726,".");
	TextDrawColor(speedom[84],0xFDB55Bff);
	speedom[85] = TextDrawCreate(130.168090, 373.132690,".");
	TextDrawColor(speedom[85],0xFDB55Bff);
	speedom[85] = TextDrawCreate(130.760299, 374.085571,".");
	TextDrawColor(speedom[85],0xFDB55Bff);
	speedom[86] = TextDrawCreate(131.582199, 375.493011,".");
	TextDrawColor(speedom[86],0xFDB55Bff);
	speedom[87] = TextDrawCreate(132.427856, 377.061706,".");
	TextDrawColor(speedom[87],0xFDB55Bff);
	speedom[88] = TextDrawCreate(133.163421, 378.546203,".");
	TextDrawColor(speedom[88],0xFDB55Bff);
	speedom[89] = TextDrawCreate(133.883193, 380.132141,".");
	TextDrawColor(speedom[89],0xFD985Bff);
	speedom[90] = TextDrawCreate(134.401977, 381.375885,".");
	TextDrawColor(speedom[90],0xFD985Bff);
	speedom[91] = TextDrawCreate(135.010574, 382.970458,".");
	TextDrawColor(speedom[91],0xFD985Bff);
	speedom[92] = TextDrawCreate(135.570129, 384.602508,".");
	TextDrawColor(speedom[92],0xFD985Bff);
	speedom[93] = TextDrawCreate(136.047302, 386.163177,".");
	TextDrawColor(speedom[93],0xFD985Bff);
	speedom[93] = TextDrawCreate(136.494491, 387.822784,".");
	TextDrawColor(speedom[93],0xFD985Bff);
	speedom[94] = TextDrawCreate(136.873580, 389.446655,".");
	TextDrawColor(speedom[94],0xFD985Bff);
	speedom[95] = TextDrawCreate(137.115264, 390.635650,".");
	TextDrawColor(speedom[95],0xFD985Bff);
	speedom[96] = TextDrawCreate(137.389709, 392.211761,".");
	TextDrawColor(speedom[96],0xFD985Bff);
	speedom[97] = TextDrawCreate(137.621185, 393.856933,".");
	TextDrawColor(speedom[97],0xFD985Bff);
	speedom[98] = TextDrawCreate(137.800460, 395.537536,".");
	TextDrawColor(speedom[98],0xFD985Bff);
	speedom[99] = TextDrawCreate(137.923156, 397.228851,".");
	TextDrawColor(speedom[99],0xFD7B5Bff);
	speedom[100] = TextDrawCreate(137.976669, 398.472717,".");
	TextDrawColor(speedom[100],0xFD7B5Bff);
	speedom[101] = TextDrawCreate(137.999984, 400.037475,".");
	TextDrawColor(speedom[101],0xFD7B5Bff);
	speedom[102] = TextDrawCreate(137.986587, 401.157867,".");
	TextDrawColor(speedom[102],0xFD7B5Bff);
	speedom[103] = TextDrawCreate(137.919891, 402.829284,".");
	TextDrawColor(speedom[103],0xFD7B5Bff);
	speedom[104] = TextDrawCreate(137.842941, 403.959960,".");
	TextDrawColor(speedom[104],0xFD7B5Bff);
	speedom[105] = TextDrawCreate(137.687438, 405.581939,".");
	TextDrawColor(speedom[105],0xFD7B5Bff);
	speedom[106] = TextDrawCreate(137.546539, 406.718597,".");
	TextDrawColor(speedom[106],0xFD7B5Bff);
	speedom[107] = TextDrawCreate(137.307159, 408.294769,".");
	TextDrawColor(speedom[107],0xFD7B5Bff);
	speedom[108] = TextDrawCreate(137.116668, 409.357025,".");
	TextDrawColor(speedom[108],0xFD7B5Bff);
	speedom[109] = TextDrawCreate(136.795135, 410.910339,".");
	TextDrawColor(speedom[109],0xFD7B5Bff);
	speedom[110] = TextDrawCreate(136.549652, 411.955352,".");
	TextDrawColor(speedom[110],0xFB2D2Dff);
	speedom[111] = TextDrawCreate(136.123794, 413.568359,".");
	TextDrawColor(speedom[111],0xFB2D2Dff);
	speedom[112] = TextDrawCreate(135.673797, 415.073486,".");
	TextDrawColor(speedom[112],0xFB2D2Dff);
	speedom[113] = TextDrawCreate(135.333312, 416.110778,".");
	TextDrawColor(speedom[113],0xFB2D2Dff);
	speedom[114] = TextDrawCreate(134.806640, 417.582305,".");
	TextDrawColor(speedom[114],0xFB2D2Dff);
	speedom[115] = TextDrawCreate(134.434539, 418.542755,".");
	TextDrawColor(speedom[115],0xFB2D2Dff);
	speedom[116] = TextDrawCreate(133.800064, 420.058776,".");
	TextDrawColor(speedom[116],0xFB2D2Dff);
	speedom[117] = TextDrawCreate(133.344879, 421.067535,".");
	TextDrawColor(speedom[117],0xFB2D2Dff);
	speedom[118] = TextDrawCreate(132.881042, 422.038391,".");
	TextDrawColor(speedom[118],0xFB2D2Dff);
	speedom[119] = TextDrawCreate(132.206527, 423.361999,".");
	TextDrawColor(speedom[119],0xFB2D2Dff);
	speedom[120] = TextDrawCreate(131.400131, 424.827972,".");
	TextDrawColor(speedom[120],0xFB2D2Dff);
	speedom[121] = TextDrawCreate(131.301269, 425.000000,".");
	TextDrawColor(speedom[121],0xFB2D2Dff);
	for(new i=0; i<122; i++)
	TextDrawLetterSize(speedom[i], 0.73, -2.60),
	TextDrawSetOutline(speedom[i], 0),
	TextDrawSetShadow(speedom[i], 1),
	TextDrawSetOutline(speedom[i],1),
    TextDrawBackgroundColor(speedom[i],0x00000022);
	print("|---|---|---|---|---|---|---|---|---|---|---|--|---|");
	print("|---|                                          |---|");
    print("|---|   Speedometer by: ]_DA[R]K_[             |---|");
    print("|---|                                          |---|");
    print("|---|---|---|---|---|---|---|---|---|---|---|--|---|");
	return 1;
}
public OnFilterScriptExit(){
    for(new i=0; i<122; i++)
    TextDrawDestroy(speedom[i]);
    for(new l=0; l<16; l++)
    TextDrawDestroy(mysp[l]);
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER && BikeVeh(playerid, GiveModel(playerid)) == 1){
    	for(new l=0; l<16; l++)
    	TextDrawShowForPlayer(playerid, mysp[l]);
    }
    else if(newstate == PLAYER_STATE_ONFOOT){
    	for(new i=0; i<122; i++)
    	TextDrawHideForPlayer(playerid, speedom[i]);
    	for(new l=0; l<16; l++)
    	TextDrawHideForPlayer(playerid, mysp[l]);
    }
	return 1;
}
stock BikeVeh(i, id){
    switch(id){
    	case 509,481,510,441,564,465,464: spedom[i] = 0;
    	default: spedom[i] = 1;
	}
    return spedom[i];
}
stock GiveModel(playerid){
    new car = GetPlayerVehicleID(playerid);
    return GetVehicleModel(car);
}
public OnPlayerUpdate(playerid){
    if(IsPlayerInAnyVehicle(playerid) == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && spedom[playerid] == 1){
    	GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    	ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    	UpdateSpeed(playerid, floatround(ST[3]));
	}
	return 1;
}
stock UpdateSpeed(playerid, speed){
    for(new i=0; i<122; i++)
    TextDrawHideForPlayer(playerid, speedom[i]);
	switch(speed){
		case 0..3:     TextDrawShowForPlayer(playerid, speedom[0]);
		case 4..6:     TextDrawShowForPlayer(playerid, speedom[1]);
		case 7..9:     TextDrawShowForPlayer(playerid, speedom[2]);
		case 10..12:   TextDrawShowForPlayer(playerid, speedom[3]);
		case 13..15:   TextDrawShowForPlayer(playerid, speedom[4]);
		case 16..18:   TextDrawShowForPlayer(playerid, speedom[5]);
		case 19..21:   TextDrawShowForPlayer(playerid, speedom[6]);
	    case 22..24:   TextDrawShowForPlayer(playerid, speedom[7]);
	    case 25..27:   TextDrawShowForPlayer(playerid, speedom[8]);
	    case 28..30:   TextDrawShowForPlayer(playerid, speedom[9]);
	    case 31..33:   TextDrawShowForPlayer(playerid, speedom[10]);
	    case 34..36:   TextDrawShowForPlayer(playerid, speedom[11]);
	    case 37..39:   TextDrawShowForPlayer(playerid, speedom[12]);
	    case 40..42:   TextDrawShowForPlayer(playerid, speedom[13]);
	    case 43..45:   TextDrawShowForPlayer(playerid, speedom[14]);
	    case 46..48:   TextDrawShowForPlayer(playerid, speedom[15]);
	    case 49..51:   TextDrawShowForPlayer(playerid, speedom[16]);
	    case 52..54:   TextDrawShowForPlayer(playerid, speedom[17]);
	    case 55..57:   TextDrawShowForPlayer(playerid, speedom[18]);
	    case 58..59:   TextDrawShowForPlayer(playerid, speedom[19]);
	    case 60:       TextDrawShowForPlayer(playerid, speedom[20]);
	    case 61:       TextDrawShowForPlayer(playerid, speedom[21]);
	    case 62:       TextDrawShowForPlayer(playerid, speedom[22]);
	    case 63:       TextDrawShowForPlayer(playerid, speedom[23]);
	    case 64:       TextDrawShowForPlayer(playerid, speedom[24]);
	    case 65:       TextDrawShowForPlayer(playerid, speedom[25]);
	    case 66:       TextDrawShowForPlayer(playerid, speedom[26]);
	    case 67:       TextDrawShowForPlayer(playerid, speedom[27]);
	    case 68:       TextDrawShowForPlayer(playerid, speedom[28]);
	    case 69:       TextDrawShowForPlayer(playerid, speedom[29]);
	    case 70:       TextDrawShowForPlayer(playerid, speedom[30]);
	    case 71:       TextDrawShowForPlayer(playerid, speedom[31]);
	    case 72:       TextDrawShowForPlayer(playerid, speedom[33]);
	    case 73:       TextDrawShowForPlayer(playerid, speedom[34]);
	    case 74:       TextDrawShowForPlayer(playerid, speedom[35]);
	    case 75:       TextDrawShowForPlayer(playerid, speedom[36]);
	    case 76:       TextDrawShowForPlayer(playerid, speedom[37]);
	    case 77:       TextDrawShowForPlayer(playerid, speedom[38]);
	    case 78:       TextDrawShowForPlayer(playerid, speedom[39]);
	    case 79:       TextDrawShowForPlayer(playerid, speedom[40]);
	    case 80:       TextDrawShowForPlayer(playerid, speedom[41]);
	    case 81:       TextDrawShowForPlayer(playerid, speedom[42]);
	    case 82:       TextDrawShowForPlayer(playerid, speedom[43]);
	    case 83:       TextDrawShowForPlayer(playerid, speedom[44]);
	    case 84:       TextDrawShowForPlayer(playerid, speedom[45]);
	    case 85:       TextDrawShowForPlayer(playerid, speedom[46]);
	    case 86:       TextDrawShowForPlayer(playerid, speedom[47]);
	    case 87:       TextDrawShowForPlayer(playerid, speedom[48]);
	    case 88:       TextDrawShowForPlayer(playerid, speedom[49]);
	    case 89:       TextDrawShowForPlayer(playerid, speedom[50]);
	    case 90:       TextDrawShowForPlayer(playerid, speedom[51]);
	    case 91:       TextDrawShowForPlayer(playerid, speedom[52]);
	    case 92:       TextDrawShowForPlayer(playerid, speedom[53]);
	    case 93:       TextDrawShowForPlayer(playerid, speedom[54]);
	    case 94:       TextDrawShowForPlayer(playerid, speedom[55]);
	    case 95:       TextDrawShowForPlayer(playerid, speedom[56]);
	    case 96:       TextDrawShowForPlayer(playerid, speedom[57]);
	    case 97:       TextDrawShowForPlayer(playerid, speedom[58]);
	    case 98:       TextDrawShowForPlayer(playerid, speedom[59]);
	    case 99:       TextDrawShowForPlayer(playerid, speedom[60]);
	    case 100:      TextDrawShowForPlayer(playerid, speedom[61]);
	    case 101..103: TextDrawShowForPlayer(playerid, speedom[61]);
	    case 104..106: TextDrawShowForPlayer(playerid, speedom[62]);
	    case 107..109: TextDrawShowForPlayer(playerid, speedom[63]);
	    case 110..112: TextDrawShowForPlayer(playerid, speedom[64]);
	    case 113..115: TextDrawShowForPlayer(playerid, speedom[65]);
	    case 116,117: TextDrawShowForPlayer(playerid, speedom[67]);
	    case 118,119: TextDrawShowForPlayer(playerid, speedom[68]);
	    case 120,121: TextDrawShowForPlayer(playerid, speedom[69]);
	    case 122,123: TextDrawShowForPlayer(playerid, speedom[70]);
	    case 124,125: TextDrawShowForPlayer(playerid, speedom[71]);
	    case 126,127: TextDrawShowForPlayer(playerid, speedom[72]);
	    case 128,129: TextDrawShowForPlayer(playerid, speedom[73]);
	    case 130,131: TextDrawShowForPlayer(playerid, speedom[74]);
	    case 132,133: TextDrawShowForPlayer(playerid, speedom[75]);
	    case 134,135: TextDrawShowForPlayer(playerid, speedom[76]);
	    case 136,137: TextDrawShowForPlayer(playerid, speedom[77]);
	    case 138,139: TextDrawShowForPlayer(playerid, speedom[78]);
	    case 140,141: TextDrawShowForPlayer(playerid, speedom[79]);
	    case 142,143: TextDrawShowForPlayer(playerid, speedom[80]);
	    case 144,145: TextDrawShowForPlayer(playerid, speedom[81]);
	    case 146,147: TextDrawShowForPlayer(playerid, speedom[82]);
	    case 148,149: TextDrawShowForPlayer(playerid, speedom[83]);
	    case 150,151: TextDrawShowForPlayer(playerid, speedom[84]);
	    case 152,153: TextDrawShowForPlayer(playerid, speedom[85]);
	    case 154,155: TextDrawShowForPlayer(playerid, speedom[86]);
	    case 156,157: TextDrawShowForPlayer(playerid, speedom[87]);
	    case 158,159: TextDrawShowForPlayer(playerid, speedom[88]);
	    case 160,161: TextDrawShowForPlayer(playerid, speedom[89]);
	    case 162,163: TextDrawShowForPlayer(playerid, speedom[90]);
	    case 164,165: TextDrawShowForPlayer(playerid, speedom[91]);
	    case 166,167: TextDrawShowForPlayer(playerid, speedom[92]);
	    case 168,169: TextDrawShowForPlayer(playerid, speedom[93]);
	    case 170,171: TextDrawShowForPlayer(playerid, speedom[94]);
	    case 172,173: TextDrawShowForPlayer(playerid, speedom[95]);
	    case 174,175: TextDrawShowForPlayer(playerid, speedom[96]);
	    case 176,177: TextDrawShowForPlayer(playerid, speedom[97]);
	    case 178,179: TextDrawShowForPlayer(playerid, speedom[98]);
	    case 180,181: TextDrawShowForPlayer(playerid, speedom[99]);
	    case 182,183: TextDrawShowForPlayer(playerid, speedom[100]);
	    case 184,185: TextDrawShowForPlayer(playerid, speedom[101]);
	    case 186,187: TextDrawShowForPlayer(playerid, speedom[102]);
	    case 188,189: TextDrawShowForPlayer(playerid, speedom[103]);
	    case 190,191: TextDrawShowForPlayer(playerid, speedom[104]);
	    case 192,193: TextDrawShowForPlayer(playerid, speedom[105]);
	    case 194,195: TextDrawShowForPlayer(playerid, speedom[106]);
	    case 196,197: TextDrawShowForPlayer(playerid, speedom[107]);
	    case 198,199: TextDrawShowForPlayer(playerid, speedom[108]);
	    case 200,201: TextDrawShowForPlayer(playerid, speedom[109]);
	    case 202,203: TextDrawShowForPlayer(playerid, speedom[110]);
	    case 204:      TextDrawShowForPlayer(playerid, speedom[111]);
		case 205:      TextDrawShowForPlayer(playerid, speedom[112]);
	    case 206:      TextDrawShowForPlayer(playerid, speedom[113]);
		case 207:      TextDrawShowForPlayer(playerid, speedom[114]);
	    case 208,209: TextDrawShowForPlayer(playerid, speedom[115]);
	    case 210,211: TextDrawShowForPlayer(playerid, speedom[116]);
	    case 212,213: TextDrawShowForPlayer(playerid, speedom[117]);
	    case 214,215: TextDrawShowForPlayer(playerid, speedom[118]);
	    case 216,217: TextDrawShowForPlayer(playerid, speedom[119]);
	    case 218:      TextDrawShowForPlayer(playerid, speedom[120]);
	    default:       TextDrawShowForPlayer(playerid, speedom[121]);
	}
    return 1;
}
