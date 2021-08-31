#include <YSI_Coding\y_hooks>
#include <YSI\y_inline>


stock CheckVehicleModel(playerid, vehicleid, componentid)
{
    new model = GetVehicleModel(vehicleid);
    switch(model)
    {
        case 400:
        {
            if(!LandstalkerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 401:
        {
            if(!BravuraMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 402:
        {
            if(!BuffaloMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 403:
        {
            if(!LinerunnerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 404:
        {
            if(!PerrenialMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 405:
        {
            if(!SentinelMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 406:
        {
            if(!DumperMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 407:
        {

            if(!FiretruckMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 408:
        {
            if(!TrashmasterMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 409:
        {
            if(!TrashmasterMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 410:
        {
            if(!MananaMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;

        }
        case 411:
        {
            if(!InfernusMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;

        }
        case 412:
        {
            if(!VoodooMod(componentid))
                 return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
                
            return 1;
        }
        case 413:
        {
            if(!PonyMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 414:
        {
            if(!MuleMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 415:
        {
            if(!CheetahMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 416:
        {
            if(!AmbulanceMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
        }
        case 417:
        {
            if(!LeviathanMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 418:
        {
            if(!MoonbeamMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
        }
        case 419:
        {
            if(!EsperantoMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 420:
        {
            if(!TaxiMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 421:
        {
            if(!WashingtonMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 422:
        {
            if(!BobcatMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 425:
        {
            if(!HunterMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 426:
        {
            if(!PremierMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 427:
        {
            if(!EnforcerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 428:
        {
            if(!SecuricarMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            
            return 1;
        }
        case 429:
        {
            if(!BansheeMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 431:
        {
            if(!BusMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 432:
        {
            if(!RhinoMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 433:
        {
            if(!BarracksMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 434:
        {
            if(!HotknifeMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 436:
        {
            if(!PrevionMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 437:
        {
            if(!CoachMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 438:
        {
            if(!CabbieMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 439:
        {
            if(!StallionMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 440:
        {
            if(!RumpoMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 442:
        {
            if(!RomeroMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");


            return 1;
        }
        case 443:
        {
            if(!PackerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 444:
        {
            if(!MonsterMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 445:
        {
            if(!AdmiralMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 447:
        {
            if(!SeasparrowMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 451:
        {
            if(!TurismoMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 455:
        {
            if(!FlatbedMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 456:
        {
            if(!YankeeMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 457:
        {
            if(!CaddyMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 458:
        {
            if(!SolairMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

           return 1;
        }
        case 459:
        {
            if(!Berkleys_RC_VanMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 460:
        {
            if(!SkimmerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 466:
        {
            if(!GlendaleMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 467:
        {
            if(!OceanicMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 469:
        {
            if(!SparrowMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 470:
        {
            if(!PatriotMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 474:
        {
            if(!HermesMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 475:
        {
            if(!SabreMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 476:
        {
            if(!RustlerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 477:
        {
            if(!ZR_350Mod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 478:
        {
            if(!WaltonMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 479:
        {
            if(!ReginaMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 480:
        {
            if(!CometMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 482:
        {
            if(!BurritoMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");
            
            return 1;
        }
        case 483:
        {
            if(!CamperMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 486:
        {
            if(!DozerMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 488:
        {
            if(!News_ChopperMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 489:
        {
            if(!RancherMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 492:
        {
            if(!GreenwoodMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 494:
        {
            if(!HotringMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 495:
        {
            if(!SandkingMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 496:
        {
            if(!Blista_CompactMod(componentid))
                return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

            return 1;
        }
        case 498:
        {


                if(!BoxvilleMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 499:
        {


                if(!BensonMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 500:
        {


                if(!MesaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 505:
        {


                if(!Rancher_1Mod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 506:
        {


                if(!Super_GTMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 507:
        {


                if(!ElegantMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 508:
        {


                if(!JourneyMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 514:
        {


                if(!TankerMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 515:
        {


                if(!RoadtrainMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 516:
        {


                if(!NebulaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 517:
        {


                if(!MajesticMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 518:
        {


                if(!BuccaneerMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 525:
        {


                if(!Tow_TruckMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 526:
        {


                if(!FortuneMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 527:
        {


                if(!CadronaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 529:
        {


                if(!WillardMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 530:
        {


                if(!ForkliftMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 531:
        {


                if(!TractorMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 532:
        {


                if(!CombineMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 533:
        {


                if(!FeltzerMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 534:
        {


                if(!RemingtonMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 535:
        {


                if(!SlamvanMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 536:
        {


                if(!BladeMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 539:
        {


                if(!VortexMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 540:
        {


                if(!VincentMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 541:
        {


                if(!BulletMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 542:
        {


                if(!CloverMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 543:
        {


                if(!SadlerMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 545:
        {


                if(!HustlerMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 546:
        {


                if(!IntruderMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 547:
        {


                if(!PrimoMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 549:
        {


                if(!TampaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 550:
        {


                if(!SunriseMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 551:
        {


                if(!MeritMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 553:
        {


                if(!NevadaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 554:
        {


                if(!YosemiteMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 555:
        {


                if(!WindsorMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 558:
        {


                if(!UranusMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 559:
        {


                if(!JesterMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 560:
        {


                if(!SultanMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 561:
        {


                if(!StratumMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 562:
        {


                if(!ElegyMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 565:
        {


                if(!FlashMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 566:
        {


                if(!TahomaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 567:
        {


                if(!SavannaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 568:
        {


                if(!BanditoMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 575:
        {


                if(!BroadwayMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 576:
        {


                if(!TornadoMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 579:
        {


                if(!HuntleyMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 580:
        {


                if(!StaffordMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 585:
        {


                if(!EmperorMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 587:
        {


                if(!EurosMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 588:
        {


                if(!HotdogMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 589:
        {


                if(!ClubMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 600:
        {


                if(!PicadorMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 602:
        {


                if(!AlphaMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
        case 603:
        {


                if(PhoenixMod(componentid))
                    return SendErrorMessage(playerid, "คุณใส่ ID ไม่ถูกต้อง");

                return 1;
        }
    }
    return 1;
}


stock LandstalkerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1013, 1018, 1019, 1020, 1021, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 
        1097, 1098: return 1;
    }
    return 0;
}

stock BravuraMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079,
        1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock BuffaloMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock LinerunnerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PerrenialMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1002, 1007, 1008, 1009, 1010, 1013, 1016, 1017, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SentinelMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1001, 1008, 1009, 1010, 1014, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock DumperMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock FiretruckMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock TrashmasterMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock StretchMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MananaMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1021, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077,
        1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock InfernusMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock VoodooMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PonyMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MuleMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CheetahMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082,
        1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock AmbulanceMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock LeviathanMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MoonbeamMod(componentid)
{
    switch(componentid)
    {
        case 1002, 1006, 1008, 1009, 1010, 1016, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079,
        1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock EsperantoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock TaxiMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1004, 1005, 1008, 1009, 1010, 1019, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock WashingtonMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1008, 1009, 1010, 1014, 1016, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079,
        1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BobcatMod(componentid)
{
    switch(componentid)
    {
        case 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock HunterMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PremierMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1004, 1005, 1006, 1008, 1009, 1010, 1019, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083,
        1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock EnforcerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SecuricarMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BansheeMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BusMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock RhinoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BarracksMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock HotknifeMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PrevionMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1021, 1022, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CoachMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CabbieMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock StallionMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1007, 1008, 1009, 1010, 1013, 1017, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084,
        1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock RumpoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock RomeroMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PackerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MonsterMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock AdmiralMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SeasparrowMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock TurismoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock FlatbedMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock YankeeMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CaddyMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SolairMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock Berkleys_RC_VanMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SkimmerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock GlendaleMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock OceanicMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SparrowMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PatriotMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock HermesMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SabreMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock RustlerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock ZR_350Mod(componentid)
{
    switch(componentid)
    {
        case 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083,
        1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock WaltonMod(componentid)
{
    switch(componentid)
    {
        case 1004, 1005, 1008, 1009, 1010, 1012, 1013, 1020, 1021, 1022, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082,
        1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock ReginaMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CometMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BurritoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CamperMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock DozerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MaverickMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock News_ChopperMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock RancherMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1002, 1004, 1005, 1006, 1008, 1009, 1010, 1013, 1016, 1018, 1019, 1020, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079,
        1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock VirgoMod(componentid)
{
    switch(componentid)
    {
        case 1003, 1007, 1008, 1009, 1010, 1014, 1017, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock GreenwoodMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1004, 1005, 1006, 1008, 1009, 1010, 1016, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085,
        1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock HotringMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SandkingMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock Blista_CompactMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1002, 1003, 1006, 1007, 1008, 1009, 1010, 1011, 1017, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143: return 1;
    }
    return 0;
}

stock BoxvilleMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BensonMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MesaMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1013, 1019, 1020, 1021, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085,
        1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock Rancher_1Mod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock Super_GTMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock ElegantMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock JourneyMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock TankerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock RoadtrainMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock NebulaMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1002, 1004, 1007, 1008, 1009, 1010, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079,
        1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock MajesticMod(componentid)
{
    switch(componentid)
    {
        case 1002, 1003, 1007, 1008, 1009, 1010, 1016, 1017, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock BuccaneerMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1018, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock Tow_TruckMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock FortuneMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CadronaMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1007, 1008, 1009, 1010, 1014, 1015, 1017, 1018, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082,
        1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock WillardMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1017, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock ForkliftMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock TractorMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CombineMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock FeltzerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock RemingtonMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098,
        1100, 1101, 1106, 1122, 1123, 1124, 1125, 1126, 1127, 1178, 1179, 1180, 1185: return 1;
    }
    return 0;
}

stock SlamvanMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1109,
        1110, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121: return 1;
    }
    return 0;
}

stock BladeMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1103, 1104,
        1105, 1107, 1108, 1128, 1181, 1182, 1183, 1184: return 1;
    }
    return 0;
}

stock VortexMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock VincentMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1004, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1020, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock BulletMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock CloverMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1014, 1015, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084,
        1085, 1086, 1087, 1096, 1097, 1098, 1144, 1145: return 1;
    }
    return 0;
}

stock SadlerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock HustlerMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock IntruderMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1002, 1004, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock PrimoMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1003, 1008, 1009, 1010, 1016, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083,
        1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143: return 1;
    }
    return 0;
}

stock TampaMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1007, 1008, 1009, 1010, 1011, 1012, 1017, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock SunriseMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1003, 1004, 1005, 1006, 1008, 1009, 1010, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock MeritMod(componentid)
{
    switch(componentid)
    {
        case 1002, 1003, 1005, 1006, 1008, 1009, 1010, 1016, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock NevadaMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock YosemiteMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock WindsorMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock UranusMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090,
        1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1163, 1164, 1165, 1166, 1167, 1168: return 1;
    }
    return 0;
}

stock JesterMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009: return 1;
    }
    return 0;
}

stock SultanMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082,
        1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1138, 1139, 1140, 1141, 1169, 1170: return 1;
    }
    return 0;
}

stock StratumMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1026, 1027, 1030, 1031, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1073, 1074, 1075, 1076,
        1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1154, 1155, 1156, 1157: return 1;
    }
    return 0;
}

stock ElegyMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082,
        1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1146, 1147, 1148, 1149, 1171, 1172: return 1;
    }
    return 0;
}

stock RaindanceMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock FlashMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080,
        1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1150, 1151, 1152, 1153: return 1;
    }
    return 0;
}

stock TahomaMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock SavannaMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097,
        1098, 1102, 1129, 1130, 1131, 1132, 1133, 1186, 1187, 1188, 1189: return 1;
    }
    return 0;
}

stock BanditoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock BroadwayMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1042, 1043, 1044, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087,
        1096, 1097, 1098, 1099, 1174, 1175, 1176, 1177: return 1;
    }
    return 0;
}

stock TornadoMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098,
        1134, 1135, 1136, 1137, 1190, 1191, 1192, 1193: return 1;
    }
    return 0;
}

stock HuntleyMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock StaffordMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082,
        1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock EmperorMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1001, 1002, 1003, 1006, 1007, 1008, 1009, 1010, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025,
        1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

stock EurosMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock HotdogMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock ClubMod(componentid)
{
    switch(componentid)
    {
        case 1000, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1016, 1017, 1018, 1020, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079,
        1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1144, 1145: return 1;
    }
    return 0;
}

stock PicadorMod(componentid)
{
    switch(componentid)
    {
        case 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1018, 1020, 1022, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081,
        1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock AlphaMod(componentid)
{
    switch(componentid)
    {
        case 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098: return 1;
    }
    return 0;
}

stock PhoenixMod(componentid)
{
    switch(componentid)
    {
        case 1001, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1020, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083,
        1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145: return 1;
    }
    return 0;
}

