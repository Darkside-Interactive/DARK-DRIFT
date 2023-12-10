new Float:CarDeal[3] = {561.9745,-1292.2395,17.2482};		//координаты места, где лидер банды может купить автомобиль
new ModelPrices[212][2]	= //Цена транспорта: все 'id' vehicle идут по порядку, с 400 до 612 , получаем 212 авто.
{//Первая цифра - деньги, вторая - репутация
	{67000, 35},	//ID 400 Landstalcker
	{60000, 20},	//ID 401 Bravura
	{150000, 120},	//ID 402 Buffalo (Sport)
	{60000, 25},	//ID 403 Linerunner
	{60000, 20},	//ID 404 Perenniel
	{60000, 22},	//ID 405 Santiel
	{61000, 30},	//ID 406 Dumper
	{63000, 30},	//ID 407 Firetruck
	{60000, 27},	//ID 408 Trashmaster
	{75000, 45},	//ID 409 Stretch
	{60000, 20},	//ID 410 Manana
	{450000, 180},	//ID 411 Infernus (sport)
	{63000, 38},	//ID 412 Voodoo
	{60000, 20},	//ID 413 Pony
	{63000, 25},	//ID 414 Mule
	{380000, 160},	//ID 415 Cheetah (Sport)
	{75000, 35},	//ID 416 Ambulance
	{320000, 200},	//ID 417 Levithan
	{60000, 20},	//ID 418 Moonbeam
	{67000, 34},	//ID 419 Esperanto
	{76000, 32},	//ID 420 Taxi
	{60000, 20},	//ID 421 Washington
	{78000, 40},	//ID 422 Bobcat
	{62400, 36},	//ID 423 Mr Whoopee
	{80100, 45},	//ID 424 BF Injecttion
	{350000, 185},	//ID 425 Hunter
	{64300, 23},	//ID 426 Premier
	{100000, 80},	//ID 427 Enforcer
	{90000, 70},	//ID 428 Securicar
	{350000, 160},	//ID 429 Banshee (Sport)
	{120000, 100},	//ID 430 Predator
	{85000, 87},	//ID 431 Bus
	{500000, 2000000},	//ID 432 Rhino (ВНИМАНИЕ ТАНК!!!!!!!!!!!)
	{70000, 65},	//ID 433 Barracks
	{80000, 60},	//ID 434 Hotknife
	{60000, 200000},	//ID 435 Article Trailer (ПРИЦЕП!!!!!!!!)
	{60000, 20},	//ID 436 Previon
	{75000, 76},	//ID 437 Coach
	{60000, 30},	//ID 438 Taxi
 	{70000, 40},	//ID 439 Stallion
	{60000, 20},	//ID 440 Rumpo
	{100000, 89},	//ID 441 RC Bandit
	{67000, 39},	//ID 442 Romero
	{65000, 30},	//ID 443 Packer
	{100000, 90},	//ID 444 Monster
	{60000, 23},	//ID 445 Admiral
	{75000, 78},	//ID 446 Squallo
	{120000, 180},	//ID 447 Seasparrow
	{60000, 21},	//ID 448 Pizzaboy
	{100000, 2000000},	//ID 449 Tram Каму нах*й трамвай нужен?
	{60000, 25},	//ID 450 Article Trailer 2 (GHBWTG!!!!!!)
	{400000, 178},	//ID 451 Turismo (sport)
	{76000, 35},	//ID 452 Speeder
	{76000, 35},	//ID 453 Reefer
	{76000, 35},	//ID 454 Tropic
	{69000, 43},	//ID 455 Flatbed
	{67000, 22},	//ID 456 Yankee
	{60000, 32},	//ID 457 Caddy
	{61900, 37},	//ID 458 Solair
	{60200, 65},	//ID 459 Berkley's RC Van
	{78000, 89},	//ID 460 Skimmer
	{75000, 99},	//ID 461 PCJ-600
	{65000, 39},	//ID 462 Faggio
	{80000, 50},	//ID 463 Freeway
	{100000, 89},	//ID 464 RC Baron
	{100000, 89},	//ID 465 RC Raider
	{630000, 30},	//ID 466 Glendale
	{67000, 30},	//ID 467 Ocenic
	{90000, 67},	//ID 468 Sanchez
	{120000, 180},	//ID 469 Sparrow
	{120000, 89},	//ID 470 Patriot
	{100000, 80},	//ID 471 Quad
	{90000, 69},	//ID 472 Coastguard
	{90000, 69},	//ID 473 Dinghy
	{60000, 20},	//ID 474 Hermes
	{70000, 32},	//ID 475 Sabre
	{120000, 78},	//ID 476 Rustler
	{100000, 90},	//ID 477 ZR-350
	{60000, 30},	//ID 478 Walton
	{80000, 45},	//ID 479 Regina
	{70000, 45},	//ID 480 Comet
	{60000, 20},	//ID 481 BMX
	{60000, 20},	//ID 482 Burrito
	{60000, 20},	//ID 483 Camper
	{70000, 50},	//ID 484 Marquis
	{60000, 22},	//ID 485 Baggage
	{800000, 150},	//ID 486 Dozer
	{1100000, 150},	//ID 487 Maverick
	{1100000, 150},	//ID 488 SAN News Maverick
	{90000, 96},	//ID 489 Rancher
	{50000, 100},	//ID 490 FBI Rancher
	{60000, 20},	//ID 491 Virgo
	{60000, 20},	//ID 492 Greenwood
	{78000, 35},	//ID 493 Jetmax
	{100000, 40},	//ID 494 Hotring Racer
	{100000, 40},	//ID 495 Sandking
	{60000, 20},	//ID 496 Blista
	{60000, 30},	//ID 497 Police Maverick
	{60000, 30},	//ID 498 Boxville
	{60000, 30},	//ID 499 Benson
	{70000, 35},	//ID 500 Mesa
	{80000, 40},	//ID 501 RC Goblin
	{110000, 100},	//ID 502 Hotring Racer
	{110000, 100},	//ID 503 Hotring Racer
	{100000, 90},	//ID 504 Bloodring
	{80000, 60},	//ID 505 Rancher
	{350000, 150},	//ID 506 Super GT
	{80000, 34},	//ID 507 Elegant
	{60000, 20},	//ID 508 Journey
	{60000, 20},	//ID 509 Bike
	{65000, 20},	//ID 510 Mountain Bike
	{120000, 150},	//ID 511 Beagle
	{100000, 120},	//ID 512 Cropduster
	{100000, 100},	//ID 513 Stuntplane
	{60000, 20},	//ID 514 Tanker
	{60000, 20},	//ID 515 Roadtrain
	{60000, 30},	//ID 516 Nebula
	{62000, 34},	//ID 517 Majestic
	{60000, 20},	//ID 518 Buccaneer
	{500000, 300},	//ID 519 Shamal
	{500000, 1000},	//ID 520 Hydra
	{76000, 80},	//ID 521 FCR-900
	{85000, 90},	//ID 522 NRG-500
	{70000, 60},	//ID 523 HPV1000
	{60000, 20},	//ID 524 Cement Truck
	{70000, 30},	//ID 525 Towtruck
	{60000, 20},	//ID 526 Fortune
	{60000, 20},	//ID 527 Cadrona
	{120000, 80},	//ID 528 FBI Truck
	{60000, 20},	//ID 529 Willard
	{70000, 40},	//ID 530 Forklift
	{60000, 20},	//ID 531 Tractor
	{60000, 30},	//ID 532 Combaine Harvest
	{70000, 25},	//ID 533 Feltzer
	{80000, 50},	//ID 534 Remington
	{80000, 50},	//ID 535 Slamvan
	{80000, 50},	//ID 536 Blade
	{60000, 20},	//ID 537 Brownstreak ( ПОЕЗД!!!!!!!!!!)
	{60000, 20},	//ID 538 Freight (ПОЕЗД!!!!!!!)
	{80000, 50},	//ID 539 Vortex
	{60000, 30},	//ID 540 Vincent
	{280000, 160},	//ID 541 Bullet (sport)
	{70000, 30},	//ID 542 Clover
	{60000, 20},	//ID 543 Sadler
	{100000, 80},	//ID 544 Firetruck LA
	{60000, 20},	//ID 545 Hustler
	{65000, 23},	//ID 546 Intruder
	{67000, 24},	//ID 547 Primo
	{120000, 110},	//ID 548 Cargobob
	{66000, 26},	//ID 549 Tampa
	{75000, 45},	//ID 550 Sunrise
	{62000, 34},	//ID 551 Merit
	{50000, 34},	//ID 552 Utility Van
	{65000, 45},	//ID 553 Nevada
	{80000, 50},	//ID 554 Yosemite
	{62000, 20},	//ID 555 Winsdor
	{200000, 120},	//ID 556 Monter A
	{200000, 120},	//ID 557 Monster B
	{100000, 80},	//ID 558 Uranus
	{250000, 120},	//ID 559 Jester
	{380000, 150},	//ID 560 Sultan
	{80000, 70},	//ID 561 Stratum
	{80000, 78},	//ID 562 Elegy
	{100000, 100},	//ID 563 Raindance
	{110000, 100},	//ID 564 RC Tiger
	{89000, 70},	//ID 565 Flash
	{78000, 50},	//ID 566 Tahoma
 	{70000, 60},	//ID 567 Savanna
	{100000, 90},	//ID 568 Bandito
	{60000, 2000000},	//ID 569 Freight Flat Trailer (Train) (ПРИЦЕП К ПОЕЗДУ!)
	{60000, 2000000},	//ID 570 Streak Trailer (Train) (ПРИЦЕП)
	{78000, 78},	//ID 571 Kart
	{70000, 50},	//ID 572 Mower
	{100000, 90},	//ID 573 Dune
	{60000, 20},	//ID 574 Sweeper
	{60000, 20},	//ID 575 Broadway
	{60000, 20},	//ID 576 Tornado
	{450000, 180},	//ID 577 AT400
	{80000, 50},	//ID 578 DFT-30
	{80000, 70},	//ID 579 Huntley
	{68000, 30},	//ID 580 Stafford
	{90000, 50},	//ID 581 BF-400
	{75000, 60},	//ID 582 Newsvan
	{60000, 20},	//ID 583 Tug
	{60000, 2000000},	//ID 584 Petrol Trailer (ПРИЦЕП)
	{68000, 30},	//ID 585 Emperor
	{100000, 70},	//ID 586 Wayfarer
	{7000, 90}, 	//ID 587 Euros
	{80000, 80},	//ID 588 Hotdog
	{99000, 90},	//ID 589 Club
	{60000, 2000000},	//ID 590 Freight Box Trailer (ПРИЦЕП)
	{60000, 2000000},	//ID 591 Article Trailer (ПРИЦЕП)
	{500000, 200},	//ID 592 Andromada
	{300000, 100},	//ID 593 Dodo
	{60000, 80},	//ID 594 RC Cam
	{89000, 100},	//ID 595 Launch
	{150000, 120},	//ID 596 Police Car (LS)
	{150000, 120},	//ID 597 Police Car (SF)
	{150000, 120},	//ID 598 Police Car (LV)
	{200000, 130},	//ID 599 Police Ranger
	{60000, 30},	//ID 600 Picador
	{140000, 120},	//ID 601 S.W.A.T
	{87000, 78},	//ID 602 Alpha
	{90000, 90},	//ID 603 Phoenix
	{60000, 20},	//ID 604 Glendale Shit
	{60000, 20},	//ID 605 Sadler Shit
	{60000, 2000000},	//ID 606 Baggage Trailer "A" (ПРИЦЕП)
	{60000, 2000000},	//ID 607 Baggage Trailer "B" (ПРИЦЕП)
	{60000, 2000000},	//ID 608 Tug Stairs Trailer (ПРИЦЕП)
	{75000, 30},	//ID 609 Boxville
	{60000, 2000000},	//ID 610 Farm Trailer (ПРИЦЕП)
	{60000, 2000000}		//ID 611 Utility Trailer  (ПРИЦЕП)
};
enum carinfo
{
	cId,
	Float:cPos_x,
	Float:cPos_y,
	Float:cPos_z,
	Float:cPos_a,
	cCol1,
	cCol2,
	cOwner[40],
	//Части тюнинга
	cSpoiler,
	cHood,
	cSideskirt,
	cNitro,
	cLamps,
	cExhaust,
	cWheels,
	cRoof,
	cStereo,
	cHydraulics,
	cBullbar,
	cRearBullbars,
	cFrontSign,
	cFrontBullbars,
	cFrontBumper,
	cRearBumper,
	cVents,
	cPaintJob,
	//Не сохраняется
	Text3D:cLabel,
	cForSave
}
new CarInfo[MAX_VEHICLES][carinfo];
stock LoadCars()
{
	new File:aFile = fopen("config/cars.txt",io_read),
		data[256], arr[26][40],
		id, t;
	if(!aFile) return 0;
	while(fread(aFile,data,sizeof(data)))
	{
		split(data,arr,'|');
		t 	= strval(arr[0]);
		if(t == 0) continue;
		id++;
		CarInfo[id][cId]	= t;
		CarInfo[id][cPos_x] = floatstr(arr[1]);
		CarInfo[id][cPos_y] = floatstr(arr[2]);
		CarInfo[id][cPos_z] = floatstr(arr[3]);
		CarInfo[id][cPos_a]	= floatstr(arr[4]);
		CarInfo[id][cCol1]	= strval(arr[5]);
		CarInfo[id][cCol2]	= strval(arr[6]);
		//Тюнинг
		CarInfo[id][cSpoiler] = strval(arr[7]);
	   	CarInfo[id][cHood] = strval(arr[8]);
	   	CarInfo[id][cSideskirt] = strval(arr[9]);
	   	CarInfo[id][cNitro] = strval(arr[10]);
       	CarInfo[id][cLamps] = strval(arr[11]);
	   	CarInfo[id][cExhaust] = strval(arr[12]);
	   	CarInfo[id][cWheels] = strval(arr[13]);
	   	CarInfo[id][cRoof] = strval(arr[14]);
       	CarInfo[id][cStereo] = strval(arr[15]);
	   	CarInfo[id][cHydraulics] = strval(arr[16]);
	   	CarInfo[id][cBullbar] = strval(arr[17]);
	   	CarInfo[id][cRearBullbars] = strval(arr[18]);
	   	CarInfo[id][cFrontSign] = strval(arr[19]);
	   	CarInfo[id][cFrontBullbars] = strval(arr[20]);
	   	CarInfo[id][cFrontBumper] = strval(arr[21]);
	   	CarInfo[id][cRearBumper] = strval(arr[22]);
	   	CarInfo[id][cVents] = strval(arr[23]);
	   	CarInfo[id][cPaintJob] = strval(arr[24]);
		//Владелец
		strmid(CarInfo[id][cOwner],arr[25],0,strlen(arr[25])-1,MAX_GANG_NAME);
		//Для сохранения?
		CarInfo[id][cForSave] = 1;
	}
	fclose(aFile);
	return id;
}
stock SaveCars()
{
	new File:aFile = fopen("config/cars.txt",io_write),
		data[256];
	if(!aFile) return 0;
	for(new id = 1; id <= MAX_VEHICLES; id++)
	{
		if(GetVehicleModel(id) == 0 || CarInfo[id][cForSave] != 1) continue;
		format(data,sizeof(data),"%d|%f|%f|%f|%f|%d|%d|\
		%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%s\n",CarInfo[id][cId],CarInfo[id][cPos_x],CarInfo[id][cPos_y],CarInfo[id][cPos_z],CarInfo[id][cPos_a],CarInfo[id][cCol1],CarInfo[id][cCol2],
		CarInfo[id][cSpoiler],CarInfo[id][cHood],CarInfo[id][cSideskirt],CarInfo[id][cNitro],CarInfo[id][cLamps],CarInfo[id][cExhaust],
		CarInfo[id][cWheels],CarInfo[id][cRoof],CarInfo[id][cStereo],CarInfo[id][cHydraulics],CarInfo[id][cBullbar],CarInfo[id][cRearBullbars],
		CarInfo[id][cFrontSign],CarInfo[id][cFrontBullbars],CarInfo[id][cFrontBumper],CarInfo[id][cRearBumper],CarInfo[id][cVents],CarInfo[id][cPaintJob],CarInfo[id][cOwner]);
		fwrite(aFile,data);
	}
	fclose(aFile);
	return 1;
}
forward ModCar(carid);		//Установить тюнинг на тачку
public ModCar(carid)
{
	if(CarInfo[carid][cSpoiler] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cSpoiler]);
	if(CarInfo[carid][cHood] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cHood]);
	if(CarInfo[carid][cSideskirt] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cSideskirt]);
	if(CarInfo[carid][cNitro] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cNitro]);
	if(CarInfo[carid][cLamps] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cLamps]);
	if(CarInfo[carid][cExhaust] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cExhaust]);
	if(CarInfo[carid][cWheels] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cWheels]);
	if(CarInfo[carid][cRoof] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cRoof]);
	if(CarInfo[carid][cStereo] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cStereo]);
	if(CarInfo[carid][cHydraulics] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cHydraulics]);
	if(CarInfo[carid][cBullbar] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cBullbar]);
	if(CarInfo[carid][cRearBullbars] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cRearBullbars]);
	if(CarInfo[carid][cFrontSign] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cFrontSign]);
	if(CarInfo[carid][cFrontBullbars] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cFrontBullbars]);
	if(CarInfo[carid][cFrontBumper] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cFrontBumper]);
	if(CarInfo[carid][cRearBumper] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cRearBumper]);
	if(CarInfo[carid][cVents] != 0)
    AddVehicleComponent(carid,CarInfo[carid][cVents]);
	if(CarInfo[carid][cPaintJob] != -1)
    ChangeVehiclePaintjob(carid,CarInfo[carid][cPaintJob]);
	return 1;
}
