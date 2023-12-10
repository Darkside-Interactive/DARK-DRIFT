/*����������� by Burger
���������� ��� Dark Drift Team
������: 1.5.2
*/

/*
forward GetPlayerAdminLevel(playerid);
public GetPlayerAdminLevel(playerid) return pInfo[playerid][pAdmin]; // �������� � ���, pInfo[playerid][pAdmin]; �������� �� ���. ������ ������� ������� �������. �����������! ����� ������ �� ����� ������ �������!
*/

#include <a_samp>
//
#define FILTERSCRIPT
#define GetPlayerAdminLevel(%0) CallRemoteFunction("GetPlayerAdminLevel", "i", %0)
//
new cfix[MAX_PLAYERS];

public OnFilterScriptInit()
{
        printf("����������� by Dark Drift Team ����������!");
        printf("����������� �������: Burger");
        printf("������: v1.5.2");
        return 1;
}

public OnFilterScriptExit()
{
        printf("����������� by Dark Drift Team ����������!");
        return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])//������ ������������� ����� � ���, ��� ��������� ������ ������������, �.�. ��������� ������� ���������� �����.
{
	cfix[playerid] = 0;
	if(!AntiReklama(playerid, cmdtext)) return 1;//��� ������ ����� ������������ ������ � ��� �������, ������� ����� ��������� �� �������. � ��������� ������ ��� ����� ���� � �������� ����� �����������.
	return 0;
}
public OnPlayerText(playerid, text[])
{
	cfix[playerid] = 1;
	if(AntiReklama(playerid, text))return 1;
	return 0;
}

stock AntiReklama(playerid, str[])
{
	new stringer[250], r, test, name[MAX_PLAYER_NAME];
 	new dsp[250];
 	GetPlayerName(playerid, name, sizeof(name));
 	for(r = strlen(str); r != 0; r--)
	switch(str[r])
	{
	        case '0'..'9': test++;
	}
	if(cfix[playerid] == 1 && test+1 >= 3)//-> ��� ����������� 3 � ����� ���� � ����, � ����� ���������, ����� ������������� � �������.
	{
	        format(stringer, sizeof(stringer), "{aa3333}�������������, ������ ����� ������������� � �������! %s[%d] ", name, playerid);
	        FS4AMes(-1, stringer);
	        format(stringer, sizeof(stringer), "{aa3333}��� ��� �� �������: %s", str);
	        FS4AMes(-1, stringer);
			//� ������ ������ ��������� ����� ����������, �������� ��� ������� ������ �� ���������������, ������� ������� ��������� � ����������
			cfix[playerid] = 0;
	        return 1;
	}
	if(cfix[playerid] == 0 && test >= 3)// ��� ����������� 3 � ����� ���� ����� '/' ����� ������ �������������
	{
	        format(stringer, sizeof(stringer), "{aa3333}�������������, ������ ����� ������������� � �������! %s[%d]", name, playerid);
	        FS4AMes(-1, stringer);
	        format(stringer, sizeof(stringer), "{aa3333}��� ��� �� �������: %s", str);
	        FS4AMes(-1, stringer);
			//� ������ ������ ��������� ����� ����������, �������� ��� ������� ������ �� ���������������, ������� ������� ��������� � ����������
	        return 1;
	}
 	strmid(dsp, str, 0, strlen(str), sizeof(dsp));
 	DeleteSpaces(dsp);
 	TextToRussia(dsp);
 	//��� ����� ��� �������� ������ ������,  ���������� �������� �������, �� ��������� ������� (�������, ����� � �.�.)
 	if(strfind(dsp, "���", true) != -1 || strfind(dsp, "������������", true) != -1 ||
    strfind(dsp, "����������", true) != -1 || strfind(dsp, "���������", true) != -1 ||
    strfind(dsp, "��������", true) != -1 || strfind(dsp, "���������", true) != -1 ||
    strfind(dsp, "����", true) != -1 || strfind(dsp, "�����", true) != -1 || strfind(dsp, "7777", true) != -1
    || strfind(dsp, "���", true) != -1
	|| strfind(dsp, "������", true) != -1 || strfind(dsp, "���", true) != -1 || strfind(dsp, "���", true) != -1 || strfind(dsp, "������", true) != -1 || strfind(dsp, "����", true) != -1
 	|| strfind(dsp, "����������", true) != -1 || strfind(dsp, "����", true) != -1 || strfind(dsp, "������", true) != -1 || strfind(dsp, "������", true) != -1 || strfind(dsp, "������", true) != -1
  	|| strfind(dsp, "������", true) != -1 || strfind(dsp, "��������", true) != -1 || strfind(dsp, "��������", true) != -1 || strfind(dsp, "�����", true) != -1 || strfind(dsp, "���������", true) != -1
   	|| strfind(dsp, "����������", true) != -1 || strfind(dsp, "���������", true) != -1 || strfind(dsp, "�����������", true) != -1 || strfind(dsp, "���������", true) != -1 || strfind(dsp, "���", true) != -1
    || strfind(dsp, "������", true) != -1 || strfind(dsp, "������", true) != -1 || strfind(dsp, "���������", true) != -1 || strfind(dsp, "�������", true) != -1 || strfind(dsp, "��������", true) != -1
 	|| strfind(dsp, "�������", true) != -1 || strfind(dsp, "���������", true) != -1 || strfind(dsp, "���������", true) != -1)
    {
	    format(stringer, sizeof(stringer), "{aa3333}�������������, ������ ����� ������������� � �������! %s[%d] ", name, playerid);
	    FS4AMes(-1, stringer);
	    format(stringer, sizeof(stringer), "{aa3333}��� ��� �� �������: %s", str);
	    FS4AMes(-1, stringer);
  		format(stringer, sizeof(stringer), "- %s (%s)[%d]", str, name, playerid);//����� �� ������, ��� ��������� �� ����������. ���������� ������� ��� ���� ���.
        SendClientMessage(playerid, -1, stringer);
    	if(!IsPlayerInAnyVehicle(playerid))
		{
			ApplyAnimation(playerid, "PED", "IDLE_CHAT", 8.1, 0, 1, 1, 1, 1);
		}
        return 0;
    }
    cfix[playerid] = 0;
	return 1;
}

stock FS4AMes(color, str[])
{
	for(new i = GetMaxPlayers()-1; i != -1; --i)
	{
		if(GetPlayerAdminLevel(i) >= 1) SendClientMessage(i, color, str);
	}
	return 1;
}

stock DeleteSpaces(String[])
{
    new i;
    static ii;
    for(ii = 0; String[ii] != '\0'; ii++)
    {
        switch(String[ii])
        {
            case '�'..'�', '�'..'�', 'A'..'Z', 'a'..'z', '@', '/', '\\': String[i++] = String[ii];
        }
    }
    String[i] = '\0';
}

stock TextToRussia(string[])
{
    new i;
	static ii;
    for (ii = 0; string[ii] != '\0'; ii++)
    {
        switch (string[ii])
        {
        case 'a': string[ii] = '�';
        case 'A': string[ii] = '�';
        case 'b': string[ii] = '�';
        case 'B': string[ii] = '�';
        case 'c': string[ii] = '�';
        case 'C': string[ii] = '�';
        case 'd': string[ii] = '�';
        case 'D': string[ii] = '�';
        case 'e': string[ii] = '�';
        case 'E': string[ii] = '�';
        case 'f': string[ii] = '�';
        case 'F': string[ii] = '�';
        case 'g': string[ii] = '�';
        case 'G': string[ii] = '�';
        case 'h': string[ii] = '�';
        case 'H': string[ii] = '�';
        case 'i': string[ii] = '�';
        case 'I': string[ii] = '�';
        case 'j': string[ii] = '�';
        case 'J': string[ii] = '�';
        case 'k': string[ii] = '�';
        case 'K': string[ii] = '�';
        case 'l': string[ii] = '�';
        case 'L': string[ii] = '�';
        case 'm': string[ii] = '�';
        case 'M': string[ii] = '�';
        case 'n': string[ii] = '�';
        case 'N': string[ii] = '�';
        case 'o': string[ii] = '�';
        case 'O': string[ii] = '�';
        case 'p': string[ii] = '�';
        case 'P': string[ii] = '�';
        case 'r': string[ii] = '�';
        case 'R': string[ii] = '�';
        case 's': string[ii] = '�';
        case 'S': string[ii] = '�';
        case 't': string[ii] = '�';
        case 'T': string[ii] = '�';
        case 'u': string[ii] = '�';
        case 'U': string[ii] = '�';
        case 'v': string[ii] = '�';
        case 'V': string[ii] = '�';
        case 'q': string[ii] = '�';
        case 'Q': string[ii] = '�';
        case 'x': string[ii] = '�';
        case 'X': string[ii] = '�';
        case 'y': string[ii] = '�';
        case 'Y': string[ii] = '�';
        case 'z': string[ii] = '�';
        case 'Z': string[ii] = '�';
        case '@': string[ii] = '�';
        //
        case '�': string[ii] = '�';
		case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        case '�': string[ii] = '�';
        
		/*case '/':// ��� � �� ����������, ������ ���������� /\ ��� '�' - ���� ���� ������� - ���������������� � ���������
		{
			if(!strcmp(string[ii+1], "\\", false, 1))
			{
			    string[ii] = '�';
			    strdel(string[ii], string[ii+1], string[ii+1]);
			}
		}*/
        }
    }
    return string[i];
}
