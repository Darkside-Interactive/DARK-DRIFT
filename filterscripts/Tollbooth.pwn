#define FILTERSCRIPT

#include <a_samp>

/*      FORWARDS (TIMERS)       */
forward TollGameOpen01();
forward TollGameOpen02();
forward TollGameOpen03();
forward TollGameOpen04();
forward TollGameOpen05();
forward TollGameOpen06();

/*      NEW(TOLBOOTH OBJECT MOVEMENTS) */

new TollGate1;
new TollGate2;
new TollGate3;
new TollGate4;
new TollGate5;
new TollGate6;

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print(" TollBooth Script Loaded");
        print("--------------------------------------\n");
        /*      YELLOW OBJECTS (DOCK BARRIERS)  */

        TollGate1 = CreateObject(3578, -1066.5502900, -2853.0302700, 67.3433100, 0.0000000, 0.0000000, 267.1820000);
        TollGate2 = CreateObject(3578, -1060.8540000, -2862.4062500, 67.4200400, 0.0000000, 0.0000000, 270.6060000);
        TollGate3 = CreateObject(3578, 1626.2581800, -3.2747300, 36.4867000, 0.0000000, 0.0000000, 25.6830000);
        TollGate4 = CreateObject(3578, 1633.3264200, 13.7717900, 36.3332300, 0.0000000, 0.0000000, 23.9710000);
        TollGate5 = CreateObject(3578, -1360.5251500, 874.1776700, 46.4573100, 0.0000000, 0.0000000, 313.2860000);
        TollGate6 = CreateObject(3578, -1349.2727100, 872.7283300, 46.5340500, 0.0000000, 0.0000000, 316.7100000);

        /*      TIMERS TO CHECK IF A PLAYERS NEAR A SPECIFIC TOLL(SO IT CAN OPEN)*/

        SetTimer("TollGameOpen01", 1000, 1);
        SetTimer("TollGameOpen02", 1000, 1);
        SetTimer("TollGameOpen03", 1000, 1);
        SetTimer("TollGameOpen04", 1000, 1);
        SetTimer("TollGameOpen05", 1000, 1);
        SetTimer("TollGameOpen06", 1000, 1);

        /*      OBJECTS AROUND THE TOLLS(barriers and such)     */
        CreateObject(7522,1629.8262900,5.2264300,40.1231100,0.0000000,0.0000000,24.8270000); //object(vgnhsegate1)(1)
        CreateObject(9623,-1354.8737800,873.2026400,48.4917800,0.0000000,0.0000000,316.1590000); //object(toll_sfw)(2)
        CreateObject(973,-1337.6466100,874.6323200,46.6080000,0.0000000,0.0000000,0.0000000); //object(sub_roadbarrier)(1)
        CreateObject(973,-1354.3665800,890.8648700,46.6080000,0.0000000,0.0000000,272.3220000); //object(sub_roadbarrier)(2)
        CreateObject(973,-1371.6890900,872.9743000,46.8382100,0.0000000,0.0000000,172.1060000); //object(sub_roadbarrier)(3)
        CreateObject(973,-1354.6119400,856.4165000,47.0684200,0.0000000,0.0000000,99.2190000); //object(sub_roadbarrier)(4)
        CreateObject(1237,-1359.1123000,868.9385400,46.3792400,0.0000000,0.0000000,0.0000000); //object(strtbarrier01)(1)
        CreateObject(1237,-1365.2504900,875.5571300,45.9188200,0.0000000,0.0000000,0.0000000); //object(strtbarrier01)(2)
        CreateObject(1237,-1351.9832800,862.9818700,45.9955600,0.0000000,0.0000000,0.0000000); //object(strtbarrier01)(3)
        CreateObject(3465,-2026.3858600,155.9366600,29.3545700,0.0000000,0.0000000,0.0000000); //object(vegspetrolpump)(5)
        CreateObject(3465,-2026.4226100,157.5771000,29.3545700,0.0000000,0.0000000,0.0000000); //object(vegspetrolpump)(6)
        CreateObject(3578,1667.9622800,1013.7434700,10.5983500,0.0000000,0.0000000,0.0000000); //object(dockbarr1_la)(3)
        CreateObject(7522,1629.8262900,5.2264300,40.1231100,0.0000000,0.0000000,24.8270000); //object(vgnhsegate1)(1)
        CreateObject(979,1627.2603800,11.2036400,36.6668800,0.0000000,0.0000000,115.5570000); //object(sub_roadleft)(1)
        CreateObject(979,1623.5072000,19.6976400,36.6668800,0.0000000,0.0000000,112.1300000); //object(sub_roadleft)(2)
        CreateObject(979,1619.9879200,28.2845600,36.6668800,0.0000000,0.0000000,112.1260000); //object(sub_roadleft)(3)
        CreateObject(979,1616.4619100,36.9564300,36.6668800,0.0000000,0.0000000,112.1260000); //object(sub_roadleft)(4)
        CreateObject(979,1631.9554400,0.1902100,36.6668800,0.0000000,0.0000000,113.8420000); //object(sub_roadleft)(5)
        CreateObject(979,1635.7330300,-8.3589800,36.6668800,0.0000000,0.0000000,113.8400000); //object(sub_roadleft)(6)
        CreateObject(979,1639.3315400,-16.5106400,36.6668800,0.0000000,0.0000000,113.8400000); //object(sub_roadleft)(7)
        CreateObject(979,1642.9608200,-24.9894700,36.6668800,0.0000000,0.0000000,112.1280000); //object(sub_roadleft)(8)
        CreateObject(1319,1614.9923100,5.1094100,37.3655900,0.0000000,0.0000000,0.0000000); //object(ws_ref_bollard)(1)
        CreateObject(1319,1620.0255100,-6.0256700,37.3655900,0.0000000,0.0000000,0.0000000); //object(ws_ref_bollard)(2)
        CreateObject(1319,1644.7067900,4.6644700,37.3655900,0.0000000,0.0000000,0.0000000); //object(ws_ref_bollard)(3)
        CreateObject(1319,1639.6470900,15.9715200,37.3655900,0.0000000,0.0000000,0.0000000); //object(ws_ref_bollard)(4)
        CreateObject(9623,-1064.4021000,-2857.9797400,69.2828300,0.0000000,0.0000000,269.7540000); //object(toll_sfw)(3)
        CreateObject(973,-1050.8028600,-2868.2448700,67.5589700,0.0000000,0.0000000,336.6430000); //object(sub_roadbarrier)(10)
        CreateObject(973,-1051.2607400,-2847.1132800,67.5589700,0.0000000,0.0000000,209.0950000); //object(sub_roadbarrier)(11)
        CreateObject(973,-1077.3183600,-2847.5312500,67.5589700,0.0000000,0.0000000,151.8620000); //object(sub_roadbarrier)(12)
        CreateObject(973,-1077.8773200,-2868.0251500,67.5589700,0.0000000,0.0000000,27.4330000); //object(sub_roadbarrier)(13)
        CreateObject(1214,-1058.6272000,-2857.6594200,66.7298000,0.0000000,0.0000000,0.0000000); //object(bollard)(1)
        CreateObject(1214,-1058.6090100,-2866.7978500,66.7298000,0.0000000,0.0000000,0.0000000); //object(bollard)(2)
        CreateObject(1214,-1058.6698000,-2848.7966300,66.7298000,0.0000000,0.0000000,0.0000000); //object(bollard)(3)
        CreateObject(1214,-1070.5253900,-2848.9357900,66.7298000,0.0000000,0.0000000,0.0000000); //object(bollard)(4)
        CreateObject(1214,-1070.4191900,-2857.7612300,66.7298000,0.0000000,0.0000000,0.0000000); //object(bollard)(5)
        CreateObject(1214,-1070.3093300,-2866.6591800,66.7298000,0.0000000,0.0000000,0.0000000); //object(bollard)(6)
        CreateObject(1214,-1065.1203600,-2869.0422400,66.1926400,0.0000000,0.0000000,0.0000000); //object(bollard)(7)
        CreateObject(1214,-1064.4406700,-2846.5268600,66.1926400,0.0000000,0.0000000,0.0000000); //object(bollard)(8)
        CreateObject(1214,-1064.9724100,-2870.7231400,67.2669500,0.0000000,0.0000000,0.0000000); //object(bollard)(9)
        CreateObject(1214,-1064.5083000,-2844.4165000,67.2669500,0.0000000,0.0000000,0.0000000); //object(bollard)(10)
        CreateObject(1232,-1074.8084700,-2857.6084000,68.9717100,0.0000000,0.0000000,0.0000000); //object(streetlamp1)(1)
        CreateObject(1232,-1074.8010300,-2847.3173800,68.9717100,0.0000000,0.0000000,0.0000000); //object(streetlamp1)(2)
        CreateObject(1232,-1074.0004900,-2869.1394000,68.9717100,0.0000000,0.0000000,0.0000000); //object(streetlamp1)(3)
        CreateObject(1232,-1056.0117200,-2869.1682100,68.9717100,0.0000000,0.0000000,0.0000000); //object(streetlamp1)(4)
        CreateObject(1232,-1053.6070600,-2857.7429200,68.9717100,0.0000000,0.0000000,0.0000000); //object(streetlamp1)(5)
        CreateObject(1232,-1053.7836900,-2847.2919900,68.9717100,0.0000000,0.0000000,0.0000000); //object(streetlamp1)(6)
        CreateObject(3877,-1355.2369400,873.0219100,50.4211100,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(1)
        CreateObject(3877,-1348.5152600,866.6992800,50.4211100,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(2)
        CreateObject(3877,-1361.9741200,879.3808600,50.4211100,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(3)
        CreateObject(3877,-1360.1121800,856.4358500,44.4356700,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(13)
        CreateObject(3877,-1363.0184300,853.3740200,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(14)
        CreateObject(3877,-1368.4617900,847.6406300,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(15)
        CreateObject(3877,-1373.9580100,841.8515600,44.5891400,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(16)
        CreateObject(3877,-1373.6286600,837.5163600,44.6658700,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(17)
        CreateObject(3877,-1371.6776100,867.5421800,44.4356700,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(18)
        CreateObject(3877,-1374.4406700,864.5576800,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(19)
        CreateObject(3877,-1380.0288100,858.7484100,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(20)
        CreateObject(3877,-1385.5346700,852.9120500,44.5891400,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(21)
        CreateObject(3877,-1389.5502900,853.6707800,44.6658700,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(22)
        CreateObject(3877,-1382.1353800,860.9658200,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(23)
        CreateObject(3877,-1373.7359600,869.4941400,44.4356700,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(24)
        CreateObject(3877,-1365.8696300,845.1077900,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(25)
        CreateObject(3877,-1357.6582000,854.2326000,44.5124000,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(26)
        CreateObject(3877,-1350.3472900,889.8347200,44.1287200,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(27)
        CreateObject(3877,-1352.7436500,891.9895000,44.1287200,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(28)
        CreateObject(3877,-1344.8938000,895.6119400,44.0519800,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(29)
        CreateObject(3877,-1347.4337200,897.8950800,44.0519800,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(30)
        CreateObject(3877,-1338.5035400,902.6614400,43.8985100,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(31)
        CreateObject(3877,-1340.9012500,904.8164700,43.8985100,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(32)
        CreateObject(3877,-1335.7341300,909.8730500,43.8217700,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(33)
        CreateObject(3877,-1321.8962400,896.4491000,43.9752500,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(34)
        CreateObject(3877,-1326.8120100,891.3233000,43.9752500,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(35)
        CreateObject(3877,-1324.5007300,889.2446300,43.9752500,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(36)
        CreateObject(3877,-1333.0888700,884.6307400,43.9752500,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(37)
        CreateObject(3877,-1330.9199200,882.6796900,44.0519800,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(38)
        CreateObject(3877,-1335.6928700,877.3721300,44.1287200,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(39)
        CreateObject(3877,-1338.1755400,879.6044900,44.1287200,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(40)
        CreateObject(3877,-1341.0507800,876.4084500,44.2054600,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(41)
        CreateObject(3877,-1352.7836900,887.5797100,44.2054600,0.0000000,0.0000000,0.0000000); //object(sf_rooflite)(42)
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}

#else

main()
{}

#endif


public TollGameOpen01()
{
        new open;
        for(new i=GetMaxPlayers(); i > -1; i--)
        {
                if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 8.0, -1066.5502900, -2853.0302700, 67.3433100))
                {
                        new vehicleid = GetPlayerVehicleID(i);
                        if(IsPlayerInVehicle(i, vehicleid))
                        {
                                open = 1;
                                MoveObject(TollGate1, -1067.9841300, -2853.0805700, 65.8853100, 2.0)&& GivePlayerMoney(i,-10) && GameTextForPlayer(i,"$10\nThank You",2000,4);
                                break;
                        }
                }
        }
        if(!open)
                MoveObject(TollGate1, -1066.5502900, -2853.0302700, 67.3433100, 2.0);
}
public TollGameOpen02()
{
        new open;
        for(new i=GetMaxPlayers(); i > -1; i--)
        {
                if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 8.0, -1060.8540000, -2862.4062500, 67.4200400))
                {
                        new vehicleid = GetPlayerVehicleID(i);
                        if(IsPlayerInVehicle(i, vehicleid))
                        {
                                open = 1;
                                MoveObject(TollGate2, -1060.8540000, -2862.4062500, 65.7318400, 2.0)&& GivePlayerMoney(i,-10) && GameTextForPlayer(i,"$10\nThank You",2000,4);
                                break;
                        }
                }
        }
        if(!open)
                MoveObject(TollGate2, -1060.8540000, -2862.4062500, 67.4200400, 2.0);
}
public TollGameOpen03()
{
        new open;
        for(new i=GetMaxPlayers(); i > -1; i--)
        {
                if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 8.0, 1626.2581800, -3.2747300, 36.4867000))
                {
                        new vehicleid = GetPlayerVehicleID(i);
                        if(IsPlayerInVehicle(i, vehicleid))
                        {
                                open = 1;
                                MoveObject(TollGate3, 1626.2581800, -3.2747300, 34.5682900, 2.0)&& GivePlayerMoney(i,-10) && GameTextForPlayer(i,"$10\nThank You",2000,4);
                                break;
                        }
                }
        }
        if(!open)
                MoveObject(TollGate3, 1626.2581800, -3.2747300, 36.4867000, 2.0);
}
public TollGameOpen04()
{
        new open;
        for(new i=GetMaxPlayers(); i > -1; i--)
        {
                if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 8.0, 1633.3264200, 13.7717900, 36.3332300))
                {
                        new vehicleid = GetPlayerVehicleID(i);
                        if(IsPlayerInVehicle(i, vehicleid))
                        {
                                open = 1;
                                MoveObject(TollGate4, 1633.3264200, 13.7717900, 34.5682900, 2.0)&& GivePlayerMoney(i,-10) && GameTextForPlayer(i,"$10\nThank You",2000,4);
                                break;
                        }
                }
        }
        if(!open)
                MoveObject(TollGate4, 1633.3264200, 13.7717900, 36.3332300, 2.0);
}
public TollGameOpen05()
{
        new open;
        for(new i=GetMaxPlayers(); i > -1; i--)
        {
                if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 8.0, -1360.5251500, 874.1776700, 46.4573100))
                {
                        new vehicleid = GetPlayerVehicleID(i);
                        if(IsPlayerInVehicle(i, vehicleid))
                        {
                                open = 1;
                                MoveObject(TollGate5, -1360.5251500, 874.1776700, 45.0760500, 2.0)&& GivePlayerMoney(i,-10) && GameTextForPlayer(i,"$10\nThank You",2000,4);
                                break;
                        }
                }
        }
        if(!open)
                MoveObject(TollGate5, -1360.5251500, 874.1776700, 46.4573100, 2.0);
}
public TollGameOpen06()
{
        new open;
        for(new i=GetMaxPlayers(); i > -1; i--)
        {
                if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, 8.0, -1349.2727100, 872.7283300, 46.5340500))
                {
                    new vehicleid = GetPlayerVehicleID(i);
                        if(IsPlayerInVehicle(i, vehicleid))
                        {
                                open = 1;
                                MoveObject(TollGate6, -1349.2727100, 872.7283300, 44.9993200, 2.0) && GivePlayerMoney(i,-10) && GameTextForPlayer(i,"$10\nThank You",2000,4);
                                break;
                        }
                }
        }
        if(!open)
                MoveObject(TollGate6, -1349.2727100, 872.7283300, 46.5340500, 2.0);
}
