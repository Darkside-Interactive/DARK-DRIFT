#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 500 //�������� ������� �� ������� + 1 (���� 50 �������, �� ����� 51 !!!)

forward Reklama1();
forward Reklama3();
forward Reklama4();
forward Reklama5();
forward Reklama6();
forward Reklama2();

new reklamatimer1;
new reklamatimer2;
new reklamatimer3;
new reklamatimer4;
new reklamatimer5;
new reklamatimer6;

public OnFilterScriptInit()
{
    reklamatimer1 = SetTimer("Reklama3",500000,1);
    reklamatimer2 = SetTimer("Reklama4",1200000,1);
    reklamatimer3 = SetTimer("Reklama1",700000,1);
    reklamatimer4 = SetTimer("Reklama6",400000,1);
    reklamatimer5 = SetTimer("Reklama2",690000,1);
}

public OnFilterScriptExit()
{
	KillTimer(reklamatimer1);
	KillTimer(reklamatimer2);
	KillTimer(reklamatimer3);
	KillTimer(reklamatimer5);
	KillTimer(reklamatimer4);
	KillTimer(reklamatimer6);
    return 1;
}
public Reklama2()
{
	SendClientMessageToAll(0xFFFFFFFF,"{FF0000}[���] {FFFFFF}���� ��� ����� ������ ���� � AFK, ������� /afk");
	printf("[���] ���� ��� ����� ������ ���� � AFK, ������� /afk");
}

public Reklama3()
{
	SendClientMessageToAll(0xFFFFFFFF,"{FF0000}[�������������] {FFFFFF}����� ���������� ������������� On-Line,�������: /admins");
	printf("[�������������] ����� ���������� ��������������� � On-Line, �������: /admins");
	return 1;
}

public Reklama4()
{
	SendClientMessageToAll(0xFFFFFFFF,"{FF0000}[������] {FFFFFF}�� ������ ����� ��� ����������? ���� � /report [id] [�������]");
	printf("[������] �� ������� ����� ��� ����������? ���� � /report [id] [�������]");
	return 1;
}

public Reklama1()
{
	SendClientMessageToAll(0xFFFFFFFF,"{FF0000}[���������� ��� �������] {FFFFFF}����� ������ ���� �� ���������������� �����, ����� /adminka");
	printf("[���������� ��� �������] ����� ������ ���� �� ���������������� �����, ����� /adminka");
	return 1;
}

public Reklama6()
{
	SendClientMessageToAll(0xFFFFFFFF,"{FF0000}[�������] {FFFFFF}����� ������ ��� ������� �������, ����� /cmd");
	printf("[�������] ����� ������ ��� ������� �������, ����� /cmd");
	return 1;
}
