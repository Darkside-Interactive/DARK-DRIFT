
Dialog:Welcome ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) // �����
	{
		if ( GetPVarInt ( playerid, "Page" ) < 4 ) SetPVarInt ( playerid, "Page", GetPVarInt ( playerid, "Page" ) + 1 ) ;
	}
	else // �����
	{
		if ( GetPVarInt ( playerid, "Page" ) == 0 )
			SetPVarInt ( playerid, "Page", GetPVarInt ( playerid, "Page" ) + 1 ) ;
		else
			SetPVarInt ( playerid, "Page", GetPVarInt ( playerid, "Page" ) - 1 ) ;
	}
	
	new dialog [ 1250 ] ;
	
	switch ( GetPVarInt ( playerid, "Page" ) )
	{
		case 0: 
		{
			new DialogPage1 [ 10 ] [ ] = 
			{
				{"{FFFFFF}���������� ������� ����, �� ����� ������� ���������� {FF0000}RolePlay {FFFFFF}�����!\n"},
				{"{FFFFFF}������������ ������� ��������� ��� ����������, ��� ������� ���� ��� �����������!\n\n"},
				{"\t\t\t\t{64AA96}1. �����, �������\n\n"},
				{"{FFFFFF}��� ���_������� ������ ���������. ��� ����� ���� �����������, ��� ��\n ��������� � ����� ������, ��� ������� �� ����� ��������.\n\n"},
				{"\t\t\t���������� � ������������ �������:\n\n"},
				{"\t{009B00}Pavel_Volkov - ���������\t\t{FF0000}Pashok_Volkov - �����������\n"},
				{"\t{009B00}Jason_Statham - ���������\t\t{FF0000}Super_Man - �����������\n"},
				{"\t{009B00}Alexey_Morozov - ���������\t{FF0000}Leha_Moroz - �����������\n\n"},
				{"\t\t\t{64AA96}2. Role Play (��, ������� ����, �����)\n\n"},
				{"{FFFFFF}RP - ��� ����������� ���� ������ ��������� � ����. ��� ��������, ������,\n ���������. ���������, �� ������ �������������� ���� ������ ���������.\n ���� ����� ���� �����, ��� ������� �� ������ ������ � ��������."}
			};
		
			for ( new i = 0; i < sizeof ( DialogPage1 ) ; i++ )  strcat ( dialog, DialogPage1 [ i ] ) ;
			ShowDialog ( playerid, Show:Welcome, DIALOG_STYLE_MSGBOX, "{FFFFFF}������ RolePlay ����!", dialog, "�����", "" ) ;
		}
		case 1:
		{
			new DialogPage2 [ 14 ] [ ] = 
			{
				{"\t\t\t\t{64AA96}3. �������� ������� � Role Play\n\n"},
				{"{FF0000}/� (/me) {FFFFFF}- ��������� �������� ������ ���������. ���� ����������� ���������\n �������� � ����� �������, �� �������� ����������. � ����� ����� �����.\n\n"},
				{"\t\t\t���������� � ������������ �������:\n\n"},
				{"{FFFFFF}����� - {009B00}/� ����� ���� � ������, ������ �� ���� ��������� - ���������.\n"},
				{"{FFFFFF}�������� - {C8A0D7}* Alex Jones ����� ���� � ������, ������ �� ���� ���������.\n"},
				{"{FFFFFF}����� - {FF0000}/� ������ - �����������!\n\n"},
				{"{FF0000}/�� (/do) {FFFFFF}- ��������� �������� �� �������� ����. ������ ����� ���������, � ����� �����.\n\n"},
				{"\t\t\t\t���������� �������:\n"},
				{"{FFFFFF}����� - {009B00}/�� ������������ ���������, � �������� ����, � ������ ����.\n"},
				{"{FFFFFF}�������� - {C8A0D7}* (( Alex Jones[21] )) ������������ ���������, � �������� ����, � ������ ����.\n\n"},
				{"{FF0000}/��� (/try) {FFFFFF}- �� ��, ��� � {FF0000}/� (/me) {FFFFFF}, �� ������������, ����� ����� �������\n ������� ���������� 	(������� ���� ����). ������������ � �������������� ���������.\n"},
				{"{FFFFFF}����� - {009B00}/��� ������� ������� ������ � �����\n"},
				{"{FFFFFF}�������� - {C8A0D7}*** Alex Jones ��������� ������� ������� ������ � ����� � � ���� ����������.\n"},
				{"{FFFFFF}��� - {C8A0D7}*** Alex Jones �������� ������� ������� ������ � �����, �� ������ �� ����������.\n"}
			};
					
			for ( new i = 0; i < sizeof ( DialogPage2 ) ; i++ )  strcat ( dialog, DialogPage2 [ i ] ) ;
			ShowDialog ( playerid, Show:Welcome, DIALOG_STYLE_MSGBOX, "{FFFFFF}������ RolePlay ����!", dialog, "�����", "�����" ) ;
		}
		case 2: 
		{
			new DialogPage3 [ 7 ] [ ] = 
			{
				{"\t\t\t\t\t{64AA96}4. ����, � ��� ��� � ��� ���������.\n\n"},
				{"{FFFFFF}1. IC (In Character) - ��� ����������, ������� ������� ���� ��������. � IC ��� ����� ������\n ������ ��, ��� ��������� � ������� ����, �� ��� ����� ���� ��������. ���������� ������\n ������, ������, ��������� ������������ ��������������� � �������������� �����. ����������\n ������������ -��������-, -���������- ����, *��������� ������*. ������� �������.\n\n"},
				{"Alex Jones[16] �������: ��� �� -���- ����� ������� -��������� �������-\n"},
				{"Alex Jones[16] �������: *�����* ���� �����, ��� � ���� ����� ���������! -���������� � ����� ��������-\n\n"},
				{"2. OOC (Out Of Character) - ��� ���������� ������� �������� ��, � ������� �� ��������� � ���������.\n� ���� ���� ����� �������� �� ����� ����, �������� ������� ��������.\n �� �� ����� ��� ����� ������������. ������� ��� ��� ���� {FF0000}/� (/b)\n\n"},
				{"{FFFFFF}3. MG (MetaGaming, OOC in IC) - ��� ������������� ��� ���������� � IC �����. ���������,\n � ���������, �� ���������� ���� �� ���������� �������.\n\n"},
				{"\t\t\t{64AA96}����� ��������� ���������� �� ������ ������ �� ����� �����\n"}
			};
			
			for ( new i = 0; i < sizeof ( DialogPage3 ) ; i++ )  strcat ( dialog, DialogPage3 [ i ] ) ;
			ShowDialog ( playerid, Show:Welcome, DIALOG_STYLE_MSGBOX, "{FFFFFF}������ RolePlay ����!", dialog, "�����", "�����" ) ;
		}
		case 3: 
		{
			DeletePVar ( playerid, "Page" ) ;
			ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}����� E-Mail", "����� ���� ����������� E-Mail �����\n\n��������! �� ���� ������ �������������� ���.", "������", "" ) ;
		}
	}
	return 1;
}

Dialog:Mail ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}����� E-Mail", "����� ���� ����������� E-Mail �����\n\n��������! �� ���� ������ �������������� ���.", "������", "" ) ;
	
	if ( !IsValidEmail ( inputtext ) ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}����� E-Mail", "����� ���� ����������� E-Mail �����\n\n��������! �� ���� ������ �������������� ���.\n{FF0000}�������� ������ E-Mail ������!", "������", "" ) ;
	
	SetPVarString ( playerid, "EMail", inputtext ) ;
	
	new query [ 128 ] ;
	echo ( query, "SELECT `mail` FROM `players` WHERE `mail` = '%s' LIMIT 1", inputtext ) ;
	mysql_function_query ( dbHandle, query, true, "CheckEMail", "ii", playerid, 0 ) ;
	
	return 1;
}

Dialog:MailAccept ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}����� E-Mail", "����� ���� ����������� E-Mail �����\n\n��������! �� ���� ������ �������������� ���.", "������", "" ) ;
	
	new email [ 64 ] ;
	GetPVarString ( playerid, "EMail", email, 64 ) ;
	
	new query [ 128 ] ;
	echo ( query, "SELECT * FROM `mails` WHERE `mail` = '%s' AND `key` = '%s' LIMIT 1", email, inputtext ) ;
	mysql_function_query ( dbHandle, query, true, "CheckEMailKey", "i", playerid ) ;
	
	return 1;
}

Dialog:Sex ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}����� E-Mail", "����� ���� ����������� E-Mail �����\n\n��������! �� ���� ������ �������������� ���.", "������", "" ) ;
	
	SetPVarInt ( playerid, "Sex", listitem ) ;
	
	SetTimerEx ( "ShowModelSelectionMenuDelay", 500, 0, "i", playerid ) ;
	
	return 1;
}

forward ShowModelSelectionMenuDelay ( playerid ) ;
public ShowModelSelectionMenuDelay ( playerid ) {
	return ShowModelSelectionMenu ( playerid, GetPVarInt ( playerid, "Sex" ), "B��OP CK��A" ) ;
}

Dialog:Password ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowModelSelectionMenu ( playerid, RegSkins [ GetPVarInt ( playerid, "Sex" ) ], "B��OP CK��A" ) ;
	
	if ( strlen ( inputtext ) < 6 || strlen ( inputtext ) > 32 ) return ShowDialog ( playerid, Show:Password, DIALOG_STYLE_INPUT, "{FFFFFF}������ �������", "����� ������ ��� �������.\n{FF0000}�� 6 �� 32 ��������.\n��������� ����� �������.", "������", "�����" ) ;
	
	SetPVarString ( playerid, "InputText", inputtext ) ;
	
	new email [ 64 ] ;
	GetPVarString ( playerid, "EMail", email, 64 ) ;
	
	new string [ 444 ] ;
	
	echo ( string, 
	"\n-------------------------------------------------------------------------------------------\n\
	�����:                  \t\t  %s \n\
	E-Mail �����:     \t\t  %s \n\
	�������� ���:     \t\t  %s \n\
	�������� ����:    \t\t  #%d \n\
	�������� ������:  \t\t  %s \n\
	\n-------------------------------------------------------------------------------------------\n", 
	PlayerName [ playerid ],
	email,
	StatSex [ GetPVarInt ( playerid, "Sex" ) ], 
	GetPVarInt ( playerid, "Skin" ),
	inputtext ) ;
	
	ShowDialog ( playerid, Show:Register, DIALOG_STYLE_MSGBOX, "{FFFFFF}�������������", string, "�����", "�������" ) ;
	
	return 1;
}

Dialog:Register ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}����� E-Mail", "����� ���� ����������� E-Mail �����\n\n��������! �� ���� ������ �������������� ���.", "������", "" ) ;
	
	new query [ 60 + MAX_PLAYER_NAME ] ;
	echo ( query, "SELECT `id` FROM `players` WHERE `name` = '%s' LIMIT 1", PlayerName [ playerid ] ) ;
	mysql_function_query ( dbHandle, query, true, "CheckPlayerRegistered", "ii", playerid, 1 ) ;
	
	return 1;
}

Dialog:Login ( playerid, response, listitem, inputtext[] )
{
	new query [ 512 ], temp [ 128 ] ;
	
	if ( strlen ( inputtext ) < 6 )
	{
		echo   ( query, "{FFFFFF}---------------------------------------------------------------------\n\n" ) ;
		strcat ( query, "����� ���������� �� {33AAFF}"NAME_SERVER"\n\n" ) ;
		echo   ( temp,	"{FFFFFF}����� {33AAFF}%s {FFFFFF}���������������\n\n", PlayerName [ playerid ] ) ;
		strcat ( query, temp ) ;
		strcat ( query, "����� ������ {FF0000}(���. 6 ����.)\n\n" ) ;
		strcat ( query, "{FFFFFF}---------------------------------------------------------------------\n" ) ;

		ShowDialog ( playerid, Show:Login, DIALOG_STYLE_PASSWORD, "{FFFFFF}�����������", query, "������", "" ) ;
	}
	else
	{
		mysql_real_escape_string ( inputtext, temp ) ;
		echo ( query, "SELECT * FROM `players` WHERE `name` = '%s' AND `password` = MD5('%s') LIMIT 1", PlayerName [ playerid ] , temp ) ;
		mysql_function_query ( dbHandle, query, true, "PlayerLogin", "i", playerid ) ;
	}
	return 1;
}


/*Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}


Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}


Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}

Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}