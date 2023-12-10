#define MAX_SALUTS 7
#define fireworksV 35
#define fireworksP 16
#define TimeSystem 7 
#define TimeSystemU 500
#define TimeDPickup 5 


forward FireworksSystem();
forward UpdateFireworksSystem();
forward DestroyPickups();

new TimerFire[3];
new PickUpFire[8][MAX_SALUTS];
new ObjFire[2];
new ValidObj=0;
new ValidPick=0;
new Float:fireworksX, Float:fireworksY, Float:fireworksZ;

public FireworksSystem()
{
    ObjFire[1] = CreateObject(2780,fireworksX,fireworksY,fireworksZ,0,0,0,300.0);
	MoveObject(ObjFire[0],fireworksX,fireworksY,fireworksZ+fireworksV,30.0);
	MoveObject(ObjFire[1],fireworksX,fireworksY,fireworksZ+fireworksV,30.0);
	KillTimer(TimerFire[0]);
	return 1;
}

public UpdateFireworksSystem()
{
	new Float:xf, Float:yf, Float:zf;
	GetObjectPos(ObjFire[0],xf,yf,zf);
	if(zf == fireworksZ+fireworksV)
	{
	    CreateExplosion(fireworksX,fireworksY,fireworksZ+fireworksV, 12, 50.0);
     	DestroyObject(ObjFire[0]);
     	DestroyObject(ObjFire[1]);
        for(new i = 1; i < MAX_SALUTS; i++)
		{
		    new RandomPosX = random(fireworksP);
		    new RandomPosY = random(fireworksP);
		    new RandomPosZ = random(fireworksP);
		    
    		PickUpFire[0][i] = CreatePickup(354,13,fireworksX+RandomPosX,fireworksY+RandomPosY,(fireworksZ+fireworksV)+RandomPosZ,-1); 
    		PickUpFire[1][i] = CreatePickup(354,13,fireworksX-RandomPosX,fireworksY-RandomPosY,(fireworksZ+fireworksV)-RandomPosZ,-1); 
    		PickUpFire[2][i] = CreatePickup(354,13,fireworksX+RandomPosX,fireworksY-RandomPosY,(fireworksZ+fireworksV)+RandomPosZ,-1); 
			PickUpFire[3][i] = CreatePickup(354,13,fireworksX-RandomPosX,fireworksY+RandomPosY,(fireworksZ+fireworksV)-RandomPosZ,-1); 
 			PickUpFire[4][i] = CreatePickup(354,13,fireworksX+RandomPosX,fireworksY+RandomPosY,(fireworksZ+fireworksV)-RandomPosZ,-1); 
    		PickUpFire[5][i] = CreatePickup(354,13,fireworksX-RandomPosX,fireworksY-RandomPosY,(fireworksZ+fireworksV)+RandomPosZ,-1); 
       		PickUpFire[6][i] = CreatePickup(354,13,fireworksX-RandomPosX,fireworksY+RandomPosY,(fireworksZ+fireworksV)+RandomPosZ,-1); 
			PickUpFire[7][i] = CreatePickup(354,13,fireworksX+RandomPosX,fireworksY-RandomPosY,(fireworksZ+fireworksV)-RandomPosZ,-1); 
		    ValidPick=1;
		}
		TimerFire[2] = SetTimer("DestroyPickups",TimeDPickup*1000,false);
 	}
	return 1;
}

public DestroyPickups()
{
	if(ValidPick == 1)
	{
        for(new i = 1; i < MAX_SALUTS; i++)
		{
		    DestroyPickup(PickUpFire[0][i]);
		    DestroyPickup(PickUpFire[1][i]);
		    DestroyPickup(PickUpFire[2][i]);
			DestroyPickup(PickUpFire[3][i]);
   			DestroyPickup(PickUpFire[4][i]);
		    DestroyPickup(PickUpFire[5][i]);
		    DestroyPickup(PickUpFire[6][i]);
			DestroyPickup(PickUpFire[7][i]);
		    ValidPick=0;
		    ValidObj=0;
		}
	}
	KillTimer(TimerFire[2]);
	return 1;
}