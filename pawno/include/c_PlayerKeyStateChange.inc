//##############################################################################//
//                                                                              //
//         																		//
//	    								       //
// Include: c_PlayerKeyStateChange, содержит автовызов нажатий игровых кнопок.  //
//                                                                              //
//##############################################################################//


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!IsPlayerInAnyVehicle(playerid) && newkeys & KEY_SECONDARY_ATTACK)
	{
	    new Float:pos[3];
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    if(pos[1] < -1301.4 && pos[1] > -1303.2417 && pos[0] < 1786.2131 && pos[0] > 1784.1555)    // He is using the elevator button
	    ShowElevatorDialog(playerid);
		else    // Is he in a floor button?
		{
		    if(pos[1] > -1301.4 && pos[1] < -1299.1447 && pos[0] < 1785.6147 && pos[0] > 1781.9902)
		    {
		        // He is most likely using it, check floor:
				new i=20;
				while(pos[2] < GetDoorsZCoordForFloor(i) + 3.5 && i > 0)
				    i --;

				if(i == 0 && pos[2] < GetDoorsZCoordForFloor(0) + 2.0)
				    i = -1;

				if(i <= 19)
				{
					CallElevator(playerid, i + 1);
					GameTextForPlayer(playerid, "~r~Elevator called", 3500, 4);
				}
		    }
		}
	}
	if(newkeys & 8192 && StartClothing[playerid] == 1)
	{
        if(ClothID[playerid] == 1)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, MaleCasualSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, FemaleCasualSkins[currentcloth[playerid]]);
				}
            }
        }
        if(ClothID[playerid] == 2)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, MaleCostumSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, FemaleCostumSkins[currentcloth[playerid]]);
				}
            }
        }
        if(ClothID[playerid] == 3)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, MaleBeachSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, FemaleBeachSkins[currentcloth[playerid]]);
				}
            }
        }
        if(ClothID[playerid] == 4)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, MaleOtherSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 0)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]--;
   					SetPlayerSkin(playerid, FemaleOtherSkins[currentcloth[playerid]]);
				}
            }
        }
	}
	if(newkeys & 16384 && StartClothing[playerid] == 1)
	{
        if(ClothID[playerid] == 1)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 107)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали последний доступный костюм в этой категории\nNUM4 посмотреть предыдущий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
				    currentcloth[playerid]++;
   					SetPlayerSkin(playerid, MaleCasualSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 49)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали последний доступный костюм в этой категории\nNUM4 посмотреть предыдущий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
				    currentcloth[playerid]++;
   					SetPlayerSkin(playerid, FemaleCasualSkins[currentcloth[playerid]]);
				}
            }
        }
        if(ClothID[playerid] == 2)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 38)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]++;
   					SetPlayerSkin(playerid, MaleCostumSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 17)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]++;
   					SetPlayerSkin(playerid, FemaleCostumSkins[currentcloth[playerid]]);
				}
            }
        }
        if(ClothID[playerid] == 3)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 5)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]++;
   					SetPlayerSkin(playerid, MaleBeachSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 5)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]++;
   					SetPlayerSkin(playerid, FemaleBeachSkins[currentcloth[playerid]]);
				}
            }
        }
        if(ClothID[playerid] == 4)
        {
            if(PlayerInfo[playerid][pSex] == 1)
            {
                if(currentcloth[playerid] == 46)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]++;
   					SetPlayerSkin(playerid, MaleOtherSkins[currentcloth[playerid]]);
				}
            }
            else if(PlayerInfo[playerid][pSex] == 2)
            {
                if(currentcloth[playerid] == 7)
            	{
		        	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_MSGBOX, "Покупка одежды", "Вы выбрали первый доступный костюм в этой категории\nNUM6 посмотреть следующий костюм\n\nНажмите кнопку бега, если хотите купить выбранную одежду\nНажмите кнопку 'Выход', если хотите закончить", "Ок", "Выход");
		        	return true;
        		}
          		else
				{
        			currentcloth[playerid]++;
   					SetPlayerSkin(playerid, FemaleOtherSkins[currentcloth[playerid]]);
				}
            }
        }
	}
	if(newkeys & 32 && StartClothing[playerid] == 1)
	{
	    StartClothing[playerid] = 0;
     	ClothID[playerid] = 0;
     	currentcloth[playerid] = 0;
      	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
	}
	if(newkeys & 8 && StartClothing[playerid] == 1)
	{
	    if(ClothID[playerid] == 1)
	    {
	        if(GetPlayerMoneyEx(playerid) >= 100) ShowPlayerDialog(playerid, 201, DIALOG_STYLE_LIST, "Выберите слот", "Слот 1\nСлот 2\nСлот 3", "Выбрать", "Выход");
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "Вы не можете позволить себе эту одежду.");
              	ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Выберите категорию одежды", "Повседневная - $100\nКостюмы - $500\nПляжная - $150\nДругое - $75", "Выбрать", "Выход");
               	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
	        }
	    }
	    if(ClothID[playerid] == 2)
	    {
	        if(GetPlayerMoneyEx(playerid) >= 500) ShowPlayerDialog(playerid, 201, DIALOG_STYLE_LIST, "Выберите слот", "Слот 1\nСлот 2\nСлот 3", "Выбрать", "Выход");
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "Вы не можете позволить себе эту одежду.");
              	ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Выберите категорию одежды", "Повседневная - $100\nКостюмы - $500\nПляжная - $150\nДругое - $75", "Выбрать", "Выход");
               	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
	        }
	    }
	    if(ClothID[playerid] == 3)
	    {
	        if(GetPlayerMoneyEx(playerid) >= 150) ShowPlayerDialog(playerid, 201, DIALOG_STYLE_LIST, "Выберите слот", "Слот 1\nСлот 2\nСлот 3", "Выбрать", "Выход");
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "Вы не можете позволить себе эту одежду.");
              	ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Выберите категорию одежды", "Повседневная - $100\nКостюмы - $500\nПляжная - $150\nДругое - $75", "Выбрать", "Выход");
               	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
	        }
	    }
	    if(ClothID[playerid] == 4)
	    {
	        if(GetPlayerMoneyEx(playerid) >= 75) ShowPlayerDialog(playerid, 201, DIALOG_STYLE_LIST, "Выберите слот", "Слот 1\nСлот 2\nСлот 3", "Выбрать", "Выход");
	        else
	        {
	            SendClientMessage(playerid, COLOR_GREY, "Вы не можете позволить себе эту одежду.");
              	ShowPlayerDialog(playerid, 200, DIALOG_STYLE_LIST, "Выберите категорию одежды", "Повседневная - $100\nКостюмы - $500\nПляжная - $150\nДругое - $75", "Выбрать", "Выход");
               	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
	        }
	    }
	}		
	if ((newkeys & KEY_FIRE)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
 	{
 	    new attachcar = GetVehicleModel(GetPlayerVehicleID(playerid));
 		if (attachcar==525||attachcar==531)
   		{
			new Float:pX,Float:pY,Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
			{
				vid++;
				GetVehiclePos(vid,vX,vY,vZ);
				if  ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
	   			{
	    			Found=1;
		    		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
     				{
	        			DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	        			return 1;
     				}
					else AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
		  		}
			}
		}
 	}
    if(oldkeys & KEY_ACTION && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1965.2174,-2193.8638,13.3210) || IsPlayerInRangeOfPoint(playerid, 5.0, 1964.8197,-2186.1755,13.3191))
	    {
	        if(PlayerInfo[playerid][pFlyLic] == 1)
	        {
	            if(agate1o == 0)
	            {
	            	MoveDynamicObject(agate1, 1969.22167969,-2189.74609375,14.36768055, 1.0);
	            	agate1o = 1;
	            	return 1;
	            }
	            else if(agate1o == 1)
	            {
	            	MoveDynamicObject(agate1, 1964.22204590,-2189.74609375,14.36768055, 1.0);
	            	agate1o = 0;
	            	return 1;
	            }
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, 1959.2828,-2184.6069,13.3190) || IsPlayerInRangeOfPoint(playerid, 5.0, 1958.3987,-2193.0532,13.3206))
	    {
	        if(PlayerInfo[playerid][pFlyLic] == 1)
	        {
	            if(agate2o == 0)
	            {
	            	MoveDynamicObject(agate2, 1953.85546875,-2189.78515625,14.36768055, 1.0);
	            	agate2o = 1;
	            	return 1;
	            }
	            else if(agate2o == 1)
	            {
	            	MoveDynamicObject(agate2, 1958.85571289,-2189.78588867,14.36768055, 1.0);
	            	agate2o = 0;
	            	return 1;
	            }
	        }
	    }
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, 2001.05761719,-2078.76464844,14.26249027))
		{
		    if(PlayerInfo[playerid][pMember] == 9)
			{
			    if(mechgateo == 0)
			    {
			    	MoveDynamicObject(mechgate, 1994.05761719,-2078.76464844,14.26249027, 1.0);
			    	mechgateo = 1;
			    	return 1;
			    }
			    else if(mechgateo == 1)
				{
				    MoveDynamicObject(mechgate, 2001.05761719,-2078.76464844,14.26249027, 1.0);
			    	mechgateo = 0;
			    	return 1;
				}
			}
		}
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 1415.17187500,-1652.48730469,13.22819996))
		{
		    if(PlayerInfo[playerid][pMember] == 6 || Practice[playerid] == 1)
			{
			    if(dmvbaro == 0)
			    {
			    	SetDynamicObjectRot(dmvbar, 0.00000000,0.00000000,90.00000000);
			    	dmvbaro = 1;
			    	return 1;
			    }
			    else if(dmvbaro == 1)
				{
				    SetDynamicObjectRot(dmvbar, 0.00000000,90.00000000,90.00000000);
			    	dmvbaro = 0;
			    	return 1;
				}
			}
		}
	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 1544.71374512,-1630.92944336,13.09531307))
		{
		    if(PlayerInfo[playerid][pMember] == 1)
			{
			    if(lspdbaro == 0)
			    {
			    	SetDynamicObjectRot(lspdbar, 0.00000000,359.44094849,270.15002441);
			    	lspdbaro = 1;
			    	return 1;
			    }
			    else if(lspdbaro == 1)
				{
				    SetDynamicObjectRot(lspdbar, 0.00000000,269.44116211,270.15002441);
			    	lspdbaro = 0;
			    	return 1;
				}
			}
		}
        if(IsPlayerInRangeOfPoint(playerid, 7.0, 1588.53259277,-1638.22644043,14.57146454))
		{
		    if(PlayerInfo[playerid][pMember] == 1)
			{
			    if(lspdgaro == 0)
			    {
			    	MoveDynamicObject(lspdgar, 1588.53259277,-1638.22644043,9.39647770, 1.0);
			    	lspdgaro = 1;
			    	return 1;
			    }
			    else if(lspdgaro == 1)
				{
				    MoveDynamicObject(lspdgar, 1588.53259277,-1638.22644043,14.57146454, 1.0);
			    	lspdgaro = 0;
			    	return 1;
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 2231.17187500,-2212.36621094,14.22156525))
		{
		    if(PlayerInfo[playerid][pJob] == 10 || PlayerInfo[playerid][pJob] == 11 || PlayerInfo[playerid][pJob] == 16)
			{
			    if(dgo == 0)
			    {
			    	MoveDynamicObject(dg1, 2226.95043945,-2208.14526367,14.22156525, 1.0);
			    	MoveDynamicObject(dg2, 2241.60083008,-2222.82299805,14.22156525, 1.0);
			    	dgo = 1;
			    	return 1;
			    }
			    else if(dgo == 1)
				{
				    MoveDynamicObject(dg1, 2231.17187500,-2212.36621094,14.22156525, 1.0);
				    MoveDynamicObject(dg2, 2237.42382812,-2218.64550781,14.22156525, 1.0);
			    	dgo = 0;
			    	return 1;
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 1139.71093750,-1678.71850586,13.68459702))
		{
		    if(PlayerInfo[playerid][pMember] == 8)
		    {
		        if(lsrco == 0)
		        {
		            SetDynamicObjectRot(lsrc, 0.00000000,0.00000000,269.81860352);
		            lsrco = 1;
		            return 1;
		        }
		        else if(lsrco == 1)
		        {
		            SetDynamicObjectRot(lsrc, 0.00000000,270.00000000,269.81860352);
		            lsrco = 0;
		            return 1;
		        }
		    }
		}
   	}
	if(oldkeys & KEY_SPRINT && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
	        if(IsPlayerInRangeOfPoint(playerid, 1.0, -782.2523, -1546.070, 134.098))
			{
				SetPlayerPos(playerid, -781.691, -1544.673, 121.200);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 1.0, -781.691, -1544.673, 121.200))
			{
				SetPlayerPos(playerid, -782.2523, -1546.070, 134.098);
				return true;
			}
			CheckForWalkingTeleport(playerid);
			if(PlayerInfo[playerid][pLocal] == 999) OnPlayerCommandText(playerid, "/enter");
			else OnPlayerCommandText(playerid, "/exit");
  		}
  		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1582.63989258,-1637.88073730,13.71341801))
		{
		    if(PlayerInfo[playerid][pMember] == 1)
			{
			    if(lspddoor1o == 0)
			    {
			    	SetDynamicObjectRot(lspddoor1, 0.00000000,0.00000000,63.75000000);
			    	lspddoor1o = 1;
			    	return 1;
			    }
			    else if(lspddoor1o == 1)
				{
				    SetDynamicObjectRot(lspddoor1, 0.00000000,0.00000000,358.50000000);
			    	lspddoor1o = 0;
			    	return 1;
				}
			}
		}
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1895.64562988,427.30560303,1198.26782227))
		{
		    if(PlayerInfo[playerid][pMember] == 3)
			{
			    if(emsdooro == 0)
			    {
			    	SetDynamicObjectRot(emsdoor, 0.00000000,0.00000000,68.69000000);
			    	emsdooro = 1;
			    	return 1;
			    }
			    else if(emsdooro == 1)
				{
				    SetDynamicObjectRot(emsdoor, 0.00000000,0.00000000,0.00000000);
			    	emsdooro = 0;
			    	return 1;
				}
			}
		}
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1577.28442383,-1637.32763672,13.89428520))
		{
		    if(PlayerInfo[playerid][pMember] == 1)
			{
			    if(lspddoor2o == 0)
			    {
			    	SetDynamicObjectRot(lspddoor2, 0.00000000,0.00000000,167.12353516);
			    	lspddoor2o = 1;
			    	return 1;
			    }
			    else if(lspddoor2o == 1)
				{
				    SetDynamicObjectRot(lspddoor2, 0.00000000,0.00000000,90.83358765);
			    	lspddoor2o = 0;
			    	return 1;
				}
			}
		}
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 221.57070923,114.55015564,997.37286377))
		{
		    if(PlayerInfo[playerid][pMember] == 1)
			{
			    if(lspddoor3o == 0)
			    {
			    	MoveDynamicObject(lspddoor3, 221.57070923,113.26661682,997.37286377, 1.0);
			    	lspddoor3o = 1;
			    	return 1;
			    }
			    else if(lspddoor3o == 1)
				{
				    MoveDynamicObject(lspddoor3, 221.57070923,114.55015564,997.37286377, 1.0);
			    	lspddoor3o = 0;
			    	return 1;
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 253.6181,109.0064,1003.2257))//open LSPD Right doors
	    {
	        if (PlayerInfo[playerid][pMember] == 1)
	        {
		 		if(copgt2 == 0)
		 		{
	   				MoveDynamicObject(cd1,253.2, 111.45, 1002.2, 1.0);
	   				MoveDynamicObject(cd2,253.2, 106.723, 1002.2, 1.0);
	   				copgt2 = 1;
	    			return 1;
				}
				else if(copgt2 == 1)
				{
			    	MoveDynamicObject(cd1,253.2, 110.594, 1002.2, 1.0);
	   				MoveDynamicObject(cd2,253.2, 107.586, 1002.2, 1.0);
			    	copgt2 = 0;
			    	return 1;
   				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Вы не можете открыть эту дверь.");
				return 1;
   			}
   		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 239.0902,117.7117,1003.2188))//open LSPD Left doors
	    {
	        if (PlayerInfo[playerid][pMember] == 1)
	        {
		 		if(copgt3 == 0)
		 		{
	   				MoveDynamicObject(cd3,239.5, 119.95, 1002.2, 1.0);
	   				MoveDynamicObject(cd4,239.5, 115.2, 1002.2, 1.0);
	   				copgt3 = 1;
	    			return 1;
				}
				else if(copgt3 == 1)
				{
			    	MoveDynamicObject(cd3,239.5, 119.09, 1002.2, 1.0);
	   				MoveDynamicObject(cd4,239.5, 116.09, 1002.2, 1.0);
			    	copgt3 = 0;
			    	return 1;
   				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Вы не можете открыть эту дверь.");
				return 1;
   			}
   		}
   		if(IsPlayerInRangeOfPoint(playerid, 1.5, 219.9512,121.0882,999.0156))//open LSPD prison doors
	    {
	        if (PlayerInfo[playerid][pMember] == 1)
	        {
		 		if(copgt4 == 0)
		 		{
	   				MoveDynamicObject(cd5,220.0, 123.44, 998.023, 1.0);
	   				MoveDynamicObject(cd6,220.0, 118.73, 998.023, 1.0);
	   				copgt4 = 1;
	    			return 1;
				}
				else if(copgt4 == 1)
				{
			    	MoveDynamicObject(cd5,220.0, 122.64, 998.023, 1.0);
	   				MoveDynamicObject(cd6,220.0, 119.64, 998.023, 1.0);
			    	copgt4 = 0;
			    	return 1;
   				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "Вы не можете открыть эту дверь.");
				return 1;
   			}
   		}
	    if(DutySkins[playerid] == 1)
	    {
	        DutySkins[playerid] = 0;
	        SetPlayerSkin(playerid, PlayerInfo[playerid][pChar]);
	        SendClientMessage(playerid, COLOR_GREY, "Вы одели служебную форму.");
         	TogglePlayerControllable(playerid, 1);
	        SetCameraBehindPlayer(playerid);
   		}
	}
	if(oldkeys & 16 || newkeys & 16)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
			if(Engine[gLastCar[playerid]] == 0 && engine_start[playerid] == 0)
			{
  				TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
   			else if(CarBroken[playerid] == 1 && engine_start[playerid] == 0)
   			{
   			    TogglePlayerControllable(playerid, 1);
				RemovePlayerFromVehicle(playerid);
   			}
 		}
	}
	if(newkeys & 16384)
	{
	    if(DutySkins[playerid] == 1)
	    {
	    	if(PlayerInfo[playerid][pSex] == 1)
	    	{
	    	    if(GetPlayerSkin(playerid)== 280)
	    	    {
	    	        SetPlayerSkin(playerid, 281);
	    	        PlayerInfo[playerid][pChar] = 281;
			 	}
			 	else if(GetPlayerSkin(playerid) == 281)
			 	{
			 	    SetPlayerSkin(playerid, 282);
	    	        PlayerInfo[playerid][pChar] = 282;
			 	}
			 	else if(GetPlayerSkin(playerid) == 282)
			 	{
			 	    SetPlayerSkin(playerid, 283);
	    	        PlayerInfo[playerid][pChar] = 283;
			 	}
			 	else if(GetPlayerSkin(playerid) == 283)
			 	{
			 	    SetPlayerSkin(playerid, 288);
	    	        PlayerInfo[playerid][pChar] = 288;
			 	}
			 	else if(GetPlayerSkin(playerid) == 288)
			 	{
			 	    SetPlayerSkin(playerid, 284);
	    	        PlayerInfo[playerid][pChar] = 284;
			 	}
			 	else if(GetPlayerSkin(playerid) == 284)
			 	{
			 	    SetPlayerSkin(playerid, 265);
	    	        PlayerInfo[playerid][pChar] = 265;
			 	}
			 	else if(GetPlayerSkin(playerid) == 265)
			 	{
			 	    SetPlayerSkin(playerid, 266);
	    	        PlayerInfo[playerid][pChar] = 266;
			 	}
			 	else if(GetPlayerSkin(playerid) == 266)
			 	{
			 	    SetPlayerSkin(playerid, 267);
	    	        PlayerInfo[playerid][pChar] = 267;
			 	}
			 	else if(GetPlayerSkin(playerid) == 267)
			 	{
			 	    SetPlayerSkin(playerid, 280);
	    	        PlayerInfo[playerid][pChar] = 280;
			 	}
 			}
		}
 	}
 	if(newkeys & 8192)
 	{
 	    if(DutySkins[playerid] == 1)
 	    {
         	if(PlayerInfo[playerid][pSex] == 1)
	    	{
			 	if(GetPlayerSkin(playerid) == 267)
			 	{
			 	    SetPlayerSkin(playerid, 266);
	    	        PlayerInfo[playerid][pChar] = 266;
			 	}
			 	else if(GetPlayerSkin(playerid) == 266)
			 	{
			 	    SetPlayerSkin(playerid, 265);
	    	        PlayerInfo[playerid][pChar] = 265;
			 	}
			 	else if(GetPlayerSkin(playerid) == 265)
			 	{
			 	    SetPlayerSkin(playerid, 284);
	    	        PlayerInfo[playerid][pChar] = 284;
			 	}
			 	else if(GetPlayerSkin(playerid) == 284)
			 	{
			 	    SetPlayerSkin(playerid, 288);
	    	        PlayerInfo[playerid][pChar] = 288;
			 	}
			 	else if(GetPlayerSkin(playerid) == 288)
			 	{
			 	    SetPlayerSkin(playerid, 283);
	    	        PlayerInfo[playerid][pChar] = 283;
			 	}
			 	else if(GetPlayerSkin(playerid) == 283)
			 	{
			 	    SetPlayerSkin(playerid, 282);
	    	        PlayerInfo[playerid][pChar] = 282;
			 	}
     			else if(GetPlayerSkin(playerid) == 282)
			 	{
			 	    SetPlayerSkin(playerid, 281);
	    	        PlayerInfo[playerid][pChar] = 281;
			 	}
			 	else if(GetPlayerSkin(playerid) == 281)
			 	{
			 	    SetPlayerSkin(playerid, 280);
	    	        PlayerInfo[playerid][pChar] = 280;
			 	}
			 	else if(GetPlayerSkin(playerid) == 280)
			 	{
			 	    SetPlayerSkin(playerid, 267);
	    	        PlayerInfo[playerid][pChar] = 267;
			 	}
 			}
  		}
  	}
	return 0;
}
