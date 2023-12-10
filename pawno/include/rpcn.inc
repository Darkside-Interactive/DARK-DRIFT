/*
* ROLE PLAY NICK CHECK FUNCTION By AirKite
*/
native CheckRP_Nickname(string[]);
forward CheckRP_Nickname(string[]);
public CheckRP_Nickname(string[])
{
	new next; new nname;
	for (new i; i < strlen(string); i++)
	{
        if(i == next)
		{
	        if(string[i]=='Q' || string[i]=='W' || string[i]=='E' ||
	        string[i]=='R' || string[i]=='T' || string[i]=='Y' || string[i]=='U' ||
	        string[i]=='I' || string[i]=='O' || string[i]=='P' || string[i]=='A' ||
	        string[i]=='S' || string[i]=='D' || string[i]=='F' || string[i]=='G' ||
	        string[i]=='H' || string[i]=='J' || string[i]=='K' || string[i]=='L' ||
	        string[i]=='Z' || string[i]=='X' || string[i]=='C' || string[i]=='V' ||
	        string[i]=='B' || string[i]=='N' || string[i]=='M') { } else return 0;
		}
		else if(i != next)
		{
		    if(string[i]=='q' || string[i]=='w' || string[i]=='e' ||
	        string[i]=='r' || string[i]=='t' || string[i]=='y' || string[i]=='u' ||
	        string[i]=='i' || string[i]=='o' || string[i]=='p' || string[i]=='a' ||
	        string[i]=='s' || string[i]=='d' || string[i]=='f' || string[i]=='g' ||
	        string[i]=='h' || string[i]=='j' || string[i]=='k' || string[i]=='l' ||
	        string[i]=='z' || string[i]=='x' || string[i]=='c' || string[i]=='v' ||
	        string[i]=='b' || string[i]=='n' || string[i]=='m') { }
			else if(string[i]=='_' && !nname) { next = i+1; nname = 1;} else return 0;
		}
	}
	if(!nname) { return 0; }
	return 1;
}
