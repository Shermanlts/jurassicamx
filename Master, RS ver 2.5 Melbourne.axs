PROGRAM_NAME='Master, RS ver 2.5 Melbourne'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 07/25/2016                      *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
dvtp		=	10001:1:1 //Touchpanel
dvtpvirtual	=	10002:1:1 //virtual touchpanel
dvdino		=	0:3:1 //dino system open port
dvlighting 	=	0:4:1 //lighting controller
dvqsys1  	=	0:5:1 //qsys main
dvqsys2		=	0:6:1 //qsys backup
dvbrtwel	=	0:7:1 //Welcome brightsign
dvbrtpet	=	0:8:1 //Petting Brightsign
dvbrttimer	=	0:9:1 //timer for rex room
dvbrtrex	=	0:10:1 //Rex theater
dvbrtgyro	=	0:11:1 //Gyro player
dvbrtwu		=	0:12:1 //Wu's brightsign
dvbrtinn	=	0:13:1 //Innovation brightsign
dvMonDino1	=	0:14:1 //Dino wall 1 monitor
dvMonDino2	=	0:15:1 //Dino wall 2 monitor
dvMonDino3	=	0:16:1 //Dino wall 3 monitor
dvMonBuild1	=	0:17:1 //Build a dino monitor 1
dvMonBuild2	=	0:18:1 //Build a dino monitor 2
dvMonBuild3	=	0:19:1 //Build a dino monitor 3
dvMonBuild4	=	0:20:1 //Build a dino monitor 4
dvMonTable1	=	0:21:1 //Table monitor 1
dvMonTable2	=	0:22:1 //Table monitor 2
dvMonTable3	=	0:23:1 //Table monitor 3
dvMonDNA1	=	0:24:1 //DNA monitor 1
dvMonDNA2	=	0:25:1 //DNA monitor 2
dvMonDNA3	=	0:26:1 //DNA monitor 3
dvMonDNA4	=	0:27:1 //DNA monitor 4
dvMoncard1	=	0:28:1 //Postcard 1
dvMoncard2	=	0:29:1 //Postcard 2
dvMoncard3	=	0:30:1 //Postcard 3
//dvMoncard4	=	0:31:1 //Postcard 4
dvrextimer	=	0:32:1 //Rex timer monitor
dvrexproj	=	0:33:1 //Rex projector
dvconproj	=	0:34:1 //Console proj
dvmoncon	=	0:35:1 //Console monitor
dvrexdoor	=	0:36:1 //Rex door switch
dvmail		=	0:37:1 //Mail server device
dvrexbutton	=	6002:1:1 //T-rex buttons
vdvJWE		=	32768:1:1 //Data transfer virtual device
vdvqsc		=	33001:1:1 //QSC virtual device
vdvrexproj	=	41001:1:1 //Rex projector
vdvrexprojb	=	41001:2:1 //Lamp B check
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
integer totaldevices = 36 //Total number of devices on IP
long Dinoport = 10	//Port dino system uses to connect
long lightport = 2323	//Port for connecting to lighting controller
long qsysport = 1702	//Q-sys port number
long brightport = 5000	//Brightsign port number
long samsungport = 1515   //Samsung port number
long lgport = 4999	//LG monitor port number
long globalport = 4998 //port number or Globalcache units
long globalserial = 4999 //Port number for global cache serial units
long TL_theater = 1	//Timer for theater room
Long TL_Welcome = 2     //Timer for Welcome room
Long TL_petting = 3     //timer for petting zoo room
Long TL_TREX = 4	//timer for TREX room(including rex theater)
Long TL_Gyro = 5	//timer for Gyro room
Long TL_Innovation =6   //imer for innovation room
Long TL_Status = 8	//Timeline used for status checks
Long TL_power = 9	//Timeline used for power checks
Long TL_timers = 10	//System ontime timer
Long TL_install = 11	//Install only connection check
Long ltime[3] = {1000, 1000, 1000}  //1 second jumps for timelines
Long ltime2[3] = {10000, 10000, 10000} //10 second jumps for timelines
char samsungoff[] = {$AA,$11,$01,$01,$00,$13} //Code for Samsung monitor off
char samsungon[] = {$AA,$11,$01,$01,$01,$14} //Code for Samsung monitor on
char LGPon[] = {$6B,$61,$20,$31,$20,$31,$0D}//LG monitor on
char LGPoff[] = {$6B,$61,$20,$31,$20,$30,$0D}//LG monitor off
char Christieon[] = {$28,$50,$57,$52,$20,$31,$29,$0D} //Christie projector on
char Christieoff[] = {$28,$50,$57,$52,$20,$30,$29,$0D} //Christie projector off
(************Constants for Rex theater buttons*************)
integer start =1
integer disarm = 2
integer reset =3
integer bstatus = 4
integer dopen = 5
integer dclose = 6
(**********************Show timing*************************)
integer Fronthalftime = 270  //seconds for each room in front half
integer fronthalfwtrans = 300 //seconds for front half rooms with transition time
integer backhalf = 210 //seconds for back half rooms
integer backhalfwtrans = 240 //seconds for back half rooms with transition time
integer Fronthalftransition = 30 //seconds in transitions
integer intromovielength = 192  //seconds in intro movie
(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE
Structure IPhold //used to hold connection info for virtual devices
{
    Dev	Device //Device number
    char address[15] //IP address in XXX.XXX.XXX.XXX format
    long port	//Port number of device
    integer connected //Connected status 0=no 1=yes
    long conerror //last error number generated
    char buffer[30][30] //buffer of received data
    char point //pointer to current buffer line
}
Structure Sysstat  //System status structure
{
    integer power 		//System on or off
    integer connected		//all devices connected
    integer error		//Any errors
    integer Runtime		//time in seconds that system has been on
    integer Runhis[40]		//last 40 runtimes
    char onhistory[40][22]	//last 40 system on
    char offhistory[40][22]	//last 40 system off
    integer hispoint		//History pointer
    integer hisaverage		//Average runtime
}
Structure systimer  //Timer holds for show
{
    long Systemtime  //runtime since system on
    integer theatertime //counter for theater room
    integer Theaterdelay //how long since last theater run
    integer THEADelaystore[200] //storage of last 200 waits
    integer THEdelaypoint //pointer to which wait is current
    integer averageTHEdelay //Average theater delay
    integer Welcometime //timer for welcome room
    integer Welcomedelay  //time between end of theater and start of dino's
    integer weldelaystore[300] //storage of last 300 welcome delays 
    integer weldelaypoint //points to current storage point
    integer Weldelayaverage //average of last 300 waits
    integer Pettingtime  //timer for petting zoo
    integer Rextime  //timer for rex room
    integer gyrotime //gyro room timer
    integer Innotime //innovation room timer
    long dailytime[20]  //last 20 daily runtimes
    integer dailypoint  //points to current runtime
    long averagetime //Average of last 20 runtimes
}
(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
iphold Equip[totaldevices]//creates Iphold variable
integer p  //Throw away variable for loops
Sysstat JWEsys	//Main system status 
persistent systimer timers //All timers for system(including theater)
persistent integer morningtest //Test for the morning
integer temphold2//holds theater delay time
(****************armed status of rooms**********************)
integer welcomearmed = 0 
integer rexarmed = 0
integer gyroarmed = 0
(***********************************************************)
integer connectstat
integer rexroom = 0//Checks if the rex room was actually run
integer systemmute = 0 //system mute status
integer emergency = 0 //system emergency status
Dev Panels[] = {dvtp, dvtpvirtual}
(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START
Combine_devices(vdvqsc, dvQsys1, dvQsys2)//Combines the virtual and qsys devices
(************************Data load for all virtual devices***************)
equip[3].device = dvdino
equip[3].address = '192.168.11.0'//zero because it is a open port not a connection
equip[3].port = Dinoport

equip[4].device = dvlighting
equip[4].address = '192.168.11.46'
equip[4].port = lightport

equip[5].device = dvqsys1
equip[5].address = '192.168.11.26'
equip[5].port = qsysport

equip[6].device = dvqsys2
equip[6].address = '192.168.11.27'
equip[6].port = qsysport

equip[7].device = dvbrtwel
equip[7].address = '192.168.11.66'
equip[7].port = brightport

equip[8].device = dvbrtpet
equip[8].address = '192.168.11.67'
equip[8].port = brightport

equip[9].device = dvbrttimer
equip[9].address = '192.168.11.72'
equip[9].port = brightport

equip[10].device = dvbrtrex
equip[10].address = '192.168.11.73'
equip[10].port = brightport

equip[11].device = dvbrtgyro
equip[11].address = '192.168.11.74'
equip[11].port = brightport

equip[12].device = dvbrtwu
equip[12].address = '192.168.11.69'
equip[12].port = brightport

equip[13].device = dvbrtinn
equip[13].address = '192.168.11.68'
equip[13].port = brightport

equip[14].device = dvMonDino1
equip[14].address = '192.168.11.118'
equip[14].port = samsungport

equip[15].device = dvMonDino2
equip[15].address = '192.168.11.119'
equip[15].port = samsungport

equip[16].device = dvMonDino3
equip[16].address = '192.168.11.120'
equip[16].port = samsungport

equip[17].device = dvMonBuild1
equip[17].address = '192.168.11.115'
equip[17].port = lgport

equip[18].device = dvMonBuild2
equip[18].address = '192.168.11.116'
equip[18].port = lgport

equip[19].device = dvMonBuild3
equip[19].address = '192.168.11.117'
equip[19].port = lgport

equip[20].device = dvMonBuild4
equip[20].address = '192.168.11.128'
equip[20].port = lgport

equip[21].device = dvMonTable1
equip[21].address = '192.168.11.121'
equip[21].port = samsungport

equip[22].device = dvMonTable2
equip[22].address = '192.168.11.122'
equip[22].port = samsungport

equip[23].device = dvMonTable3
equip[23].address = '192.168.11.123'
equip[23].port = samsungport

equip[24].device = dvMonDNA1
equip[24].address = '192.168.11.129'
equip[24].port = samsungport

equip[25].device = dvMonDNA2
equip[25].address = '192.168.11.130'
equip[25].port = samsungport

equip[26].device = dvMonDNA3
equip[26].address = '192.168.11.131'
equip[26].port = samsungport

equip[27].device = dvMonDNA4
equip[27].address = '192.168.11.132'
equip[27].port = samsungport

equip[28].device = dvMoncard1
equip[28].address = '192.168.11.133'
equip[28].port = samsungport

equip[29].device = dvMoncard2
equip[29].address = '192.168.11.134'
equip[29].port = samsungport

equip[30].device = dvMoncard3
equip[30].address = '192.168.11.135'
equip[30].port = samsungport

//equip[31].device = dvMoncard4
equip[31].address = '192.168.11.136'
equip[31].port = samsungport

equip[32].device = dvrextimer
equip[32].address = '192.168.11.126'
equip[32].port = samsungport

equip[34].device = dvconproj
equip[34].address = '192.168.11.125'
equip[34].port = globalserial

equip[35].device = dvMoncon
equip[35].address = '192.168.11.124'
equip[35].port = samsungport

equip[36].device = dvrexdoor
equip[36].address = '192.168.11.49'
equip[36].port = globalport
(*******************************Functions*******************************)
DEFINE_FUNCTION Theaterfind()//timer management for the theater
{
    integer u//throw away for counting
    temphold2 = 0 //temporary holder
    timers.THEdelaypoint++ //moves the pointer forward 1
    if(timers.THEdelaypoint == 0 || timers.THEdelaypoint>200)//if out of range resets to 1
    {
	timers.THEdelaypoint = 1
    }
    timers.THEADelaystore[timers.weldelaypoint] = timers.Theaterdelay//Stores recent data
    timers.theaterdelay = 0//resets temp hold
    timers.weldelaypoint++//advances welcome delay pointer
    if(timers.weldelaypoint>201)//flips the point if out of range
    {
	timers.weldelaypoint =1
    }
    for(u=1;u<201;u++)//Averages all the holds
    {
	temphold2 = (temphold2 + timers.theadelaystore[u])
    }
    timers.averageTHEdelay = (temphold2/200)
}
Define_function SOD()//Start of day function
{
    If(DAY=='FRI')//sends an email test every friday
    {
	Emailtest()
    }
    Send_string dvlighting,"'GTQ 11,1',$0A"//lamp strike cue for lighting
    [vdvrexproj,255] = 1//turn on rex projector
    Send_string dvMonDino1,"samsungon"
    Wait(10)
    {
	Send_string dvMonDino2,"samsungon"
	Send_string dvMonDino3,"samsungon"
	Send_string dvMonTable1,"samsungon"
	Wait(10)
	{
	    Send_string dvMonTable2,"samsungon"
	    Send_string dvMonTable3,"samsungon"
	    Send_string dvbrtwel,"'play'"
	    
	    Wait(10)
	    {
		Send_string dvMonDNA1,"samsungon"
		Send_string dvMonDNA2,"samsungon"
		Send_string dvMonDNA3,"samsungon"
		Wait(10)
		{
		    Send_string dvMonDNA4,"samsungon"
		    Send_string dvrextimer,"samsungon"
		    Send_string dvmoncon,"samsungon"
		    Wait(10)
		    {
			Send_string dvMoncard1,"samsungon"
			Send_string dvMoncard2,"samsungon"
			Send_string dvMoncard3,"samsungon"
			Wait(10)
			{
			    //Send_string dvMoncard4,"samsungon"
			    Send_string dvlighting,"'GTQ 9,1',$0A"
			    Send_string dvbrtpet,"'play'"
			    Send_string dvbrtwu,"'play'"
			    Send_string dvbrtinn,"'play'"
			    Wait(10)
			    {
				Send_string dvMonBuild1,"lgpon"
				Send_string dvmonbuild1,"lgpon"
				Send_string dvlighting,"'GTQ 1,1',$0A"
				wait(10)
				{
				    Send_string dvlighting,"'GTQ 2,1',$0A"
				    Send_string dvlighting,"'GTQ 3,1',$0A"
				    Send_string dvMonBuild2,"lgpon"
				    Wait(10)
				    {
					Send_string dvlighting,"'GTQ 4,1',$0A"
					Send_string dvlighting,"'GTQ 5,1',$0A"
					Send_string dvlighting,"'GTQ 6,1',$0A"
					Wait(10)
					{
					    Send_string dvMonBuild3,"lgpon"
					    Send_string dvMonBuild4,"lgpon"
					    wait(10)
					    {
						Send_string dvlighting,"'GTQ 7,1',$0A"
						Send_string dvlighting,"'GTQ 10,1',$0A"
						Wait(10)
						{
						    Send_string dvlighting,"'GTQ 19,1',$0A"
						    Send_string dvconproj,"Christieon"
						    Send_string dvmonbuild1,"lgpon"
						}
					    }
					}
					
				    }
				}
			    }
			}
		    }
		}
	    }
	}
    }
}
define_function dailycheck()//End of day system time housekeeping
{
    integer jcount//loop variable
    integer nonnull//number of non-zero numbers
    long adding//temp variable
    jcount = 0
    nonnull = 0
    adding = 0
    if(timers.dailypoint == 0)//checks pointer isn't out of range
    {
	timers.dailypoint = 1
    }
    if(timers.systemtime>7200)//only saves if system has been on longer than 2 hours
    {
	timers.dailytime[timers.dailypoint] = timers.Systemtime//stores the last runtime
	timers.dailypoint++ //moves pointer forward
	if(timers.dailypoint>20)//flips pointer if out of range
	{
	    timers.dailypoint=1
	}
    }
    for(jcount =1;jcount<21;jcount++)//finds average of non null numbers
    {
	if(timers.dailytime[jcount]>0)//checks for non-zero
	{
	    adding = (adding+timers.dailytime[jcount])
	    nonnull++
	}
    }
    timers.averagetime=(adding/nonnull)//averages total
    timers.systemtime = 1//resets systemtime for the next day
}
Define_function EOD()//End of day function
{
    [vdvrexproj,255] = 0//Rex projector off
    Send_string dvconproj,"Christieoff"
    Send_string dvlighting,"'RAQL',$0A"//Releases all lighting cues
    Send_string dvMonDino1,"samsungoff"
    Send_string dvMonDino2,"samsungoff"
    wait(10)
    {
	Send_string dvrexdoor,"'setstate,1:1,1',$0D"//locks rexdoor open
	Send_string dvMonDino3,"samsungoff"
	Send_string dvMonTable1,"samsungoff"
	wait(10)
	{
	    Send_string dvMonTable2,"samsungoff"
	    Send_string dvMonTable3,"samsungoff"
	    Send_string dvMonBuild1,"lgpoff"
	    Wait(10)
	    {
		Send_string dvrexdoor,"'setstate,1:1,0',$0D"//rexdoor pulse off
		Send_string dvMonDNA1,"samsungoff"
		Send_string dvMonDNA2,"samsungoff"
		Send_string dvMonDNA3,"samsungoff"
		wait(10)
		{
		    Send_string dvMonDNA4,"samsungoff"
		    Send_string dvrextimer,"samsungoff"
		    Send_string dvmoncon,"samsungoff"
		    Send_string dvMonBuild2,"lgpoff"
		    Send_string dvMonBuild3,"lgpoff"
		    Wait(10)
		    {
			Send_string dvlighting, "'GTQ 12,1',$0A"//lamp off cue
			Send_string dvMoncard1,"samsungoff"
			Send_string dvMoncard2,"samsungoff"
			Send_string dvMoncard3,"samsungoff"
			Wait(10)
			{
			    //Send_string dvMoncard4,"samsungoff"
			    Send_string dvbrtwel,"'off'"//turns off ranger Brights
			    Send_string dvbrtpet,"'off'"
			    Send_string dvbrtwu,"'off'"
			    Send_string dvbrtinn,"'off'"
			    Send_string dvMonBuild4,"lgpoff"
			}
		    }
		}
	    }
	}
    }
}
DEFINE_FUNCTION Welcomefind()//Timer management for Welcome room
{
    integer temphold//temporary holder
    integer w //loop variable
    Temphold = 0
    timers.weldelaypoint++//advances welcome pointer
    if(timers.weldelaypoint == 0 || timers.weldelaypoint>300) //Checks point is in range
    {
	timers.weldelaypoint = 1
    }
    timers.weldelaystore[timers.weldelaypoint] = timers.Welcomedelay//Stores recent data
    timers.Welcomedelay = 0//resets temp hold
    for(w=1;w<301;w++)//finds average
    {
	temphold = (temphold + timers.weldelaystore[w])
    }
    timers.Weldelayaverage = (temphold/300)
}
Define_function connectcheck()//connection check for virtual devices
{
    integer i//counter variable
    integer lab//counter variable
    integer labcount//Number of lab connections
    labcount = 0
    connectstat =1
    equip[31].connected = 1//sets connection for missing device
    equip[33].connected = [vdvrexproj,251] //sets projector connection stat
    for(i=3;i<=totaldevices;i++)//checks connection and updates touchpanels
    {
	[panels,(i+300)] = equip[i].connected//sets panel lights
	if((equip[i].connected == 0) AND (i!=33))//tries to reconnect
	{
	    IP_CLIENT_OPEN(equip[i].Device.port,equip[i].address,equip[i].port,IP_TCP)
	    connectstat = 0
	}
    }
    [panels,703] = equip[7].connected//Welcome room connect
    [panels,704] = equip[8].connected//petting room connect
    for(lab = 12;lab<=27;lab++)//lab room connect
    {
	if(lab==12)
	{
	    lab=13
	}
	else
	{
	    labcount = labcount + equip[lab].connected
	}
    }
    [panels,705] = (labcount==15)//lab
    [panels,706] = ((equip[34].connected+equip[35].connected)==2)//control connect
    [panels,707] = ((equip[9].connected+equip[10].connected+equip[32].connected+
			equip[33].connected+equip[34].connected) == 5)//rex theater connect
    [panels,708] = 1//rex connect has no objects. defaults to 1
    [panels,709] = equip[11].connected//Gyro connect
    [panels,710] = ((equip[13].connected+equip[28].connected+equip[29].connected+
			equip[30].connected)==4)//Innovation connect
    [panels,711] = 1//Retail no objects. defaults to 1
    if(connectstat==0)//if something isn't connected run the reconnect
    {
	reconnect()
    }
}
define_function reconnect()//attempts to reconnect any missing items
{
    integer recon//counter variable
    for(recon=4;recon<=totaldevices;recon++)//
    {
	if(equip[recon].connected == 0)
	{
	    if(equip[recon].port==brightport)//Brightsigns are UDP
	    {
		IP_CLIENT_OPEN(recon,"equip[recon].address",equip[recon].port,2)//UDP
	    }
	    Else
	    {
		IP_CLIENT_OPEN(recon,"equip[recon].address",equip[recon].port,1)//TCP
	    }
	}
    }
}
Define_function Rexgo()//Trigger for T-rex room
{
    rexroom = 1//Rex room is active
    //rexarmed = 0
    timers.Rextime =1 //reset timers for both rex and gyro
    timers.gyrotime = 1
    [dvrexbutton,bstatus] = 0//turns off 
    Send_string dvbrtrex,"'play'"//triggers the rex theater player
    Send_string dvbrttimer,"'play'"//triggers rex timer player
    Send_string dvlighting,"'GTQ 5,2',$0A"//start Theater lighting sequence
    Send_string dvqsys1, "'css GYRfile "SABGM.wav" ',$0A"//load gyro audio
    Send_string dvqsys2, "'css GYRfile "SABGM.wav" ',$0A"
    Send_string dvqsys1,"'ct TrexPL ',$0A"//play trex
    Send_string dvqsys2,"'ct TrexPL ',$0A"
    Send_string dvqsys1,"'ct GYRPL ',$0A"//play gyro
    Send_string dvqsys2,"'ct GYRPL ',$0A"
    //[dvrexbutton,start] = 0
    Timeline_create(TL_TREX,ltime,LENGTH_ARRAY(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//start rex timeline
    If(Timeline_active(TL_Gyro)==0)//checks that gyro timeline isn't currently running
    {
	Timeline_create(TL_gyro,ltime,Length_array(ltime),TIMELINE_RELATIVE,Timeline_repeat)//start gyro timeline
    }
}
(*NOTE:  Rexonly is used anytime the T-rex is triggered without running the
	 Rex theater.  This happens after the theater has been disarmed but
	 Gyro still has a final pulse to run.  T-rex and gyro always run
	 together.*)
Define_function Rexonly()//Runs Trex without rex theater
{
    //rexarmed = 0
    timers.Rextime =1//reset timers for both rex and gyro
    timers.gyrotime = 1
    //[dvrexbutton,bstatus] = 0
    Send_string dvqsys1,"'ct TrexPL ',$0A"//play trex audio
    Send_string dvqsys2,"'ct TrexPL ',$0A"
    Send_string dvqsys1, "'css GYRfile "SABGM.wav" ',$0A"//load gyro audio
    Send_string dvqsys2, "'css GYRfile "SABGM.wav" ',$0A"
    Send_string dvqsys1,"'ct GYRPL ',$0A"//play gyro audio
    Send_string dvqsys2,"'ct GYRPL ',$0A"
    //[dvrexbutton,start] = 0
    Timeline_create(TL_TREX,ltime,LENGTH_ARRAY(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//start rex timeline
    If(Timeline_active(TL_Gyro)==0)//check if gyro timeline is running
    {
	Timeline_create(TL_gyro,ltime,Length_array(ltime),TIMELINE_RELATIVE,Timeline_repeat)//Start gyro timeline
    }
}
(************************Included sub code files******************)
#include 'Email.axi'
#include 'qsys.axi'
#include 'Dno system.axi'
#include 'TP file.axi'
(************************Modules**********************************)
DEFINE_MODULE 'JBMIA_PJLink_Comm_dr1_0_0' comm2(vdvrexproj, dvrexproj)
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
Data_event[vdvrexproj]//T-rex projector events
{
    online://loads rex control
    {
	SEND_COMMAND vdvrexproj,'PROPERTY-IP_Address,192.168.11.127'
	SEND_COMMAND vdvrexproj,'PROPERTY-Port,4352'
	SEND_COMMAND vdvrexproj,'PROPERTY-Password,dino4ever'
	SEND_COMMAND vdvrexproj,'PROPERTY-Poll_Time,10000'
	SEND_COMMAND vdvrexproj,'reinit'
    }
}
Data_event[dvtp]
{
    online:
    {
	IP_SERVER_OPEN(dvdino.port,Dinoport,1)//create initial virtual connections
	IP_CLIENT_OPEN(dvlighting.port,equip[4].address,lightport,1)
	IP_CLIENT_OPEN(dvqsys1.port,equip[5].address,qsysport,1)
	IP_CLIENT_OPEN(dvqsys2.port,equip[6].address,qsysport,1)
	IP_CLIENT_OPEN(dvbrtwel.port,equip[7].address,brightport,2)
	IP_CLIENT_OPEN(dvbrtpet.port,equip[8].address,brightport,2)
	IP_CLIENT_OPEN(dvbrttimer.port,equip[9].address,brightport,2)
	IP_CLIENT_OPEN(dvbrtrex.port,equip[10].address,brightport,2)
	IP_CLIENT_OPEN(dvbrtgyro.port,equip[11].address,brightport,2)
	IP_client_open(dvbrtwu.port,equip[12].address,brightport,2)
	IP_client_open(dvbrtinn.port,equip[13].address,brightport,2)
	IP_client_open(dvmondino1.port,equip[14].address,samsungport,1)
	IP_client_open(dvmondino2.port,equip[15].address,samsungport,1)
	IP_client_open(dvmondino3.port,equip[16].address,samsungport,1)
	IP_client_open(dvMonBuild1.port,equip[17].address,lgport,1)
	IP_client_open(dvMonBuild2.port,equip[18].address,lgport,1)
	IP_client_open(dvMonBuild3.port,equip[19].address,lgport,1)
	IP_client_open(dvMonBuild4.port,equip[20].address,lgport,1)
	IP_client_open(dvMonTable1.port,equip[21].address,samsungport,1)
	IP_client_open(dvMonTable2.port,equip[22].address,samsungport,1)
	IP_client_open(dvMonTable3.port,equip[23].address,samsungport,1)
	IP_client_open(dvMonDNA1.port,equip[24].address,samsungport,1)
	IP_client_open(dvMonDNA2.port,equip[25].address,samsungport,1)
	IP_client_open(dvMonDNA3.port,equip[26].address,samsungport,1)
	IP_client_open(dvMonDNA4.port,equip[27].address,samsungport,1)
	IP_client_open(dvMoncard1.port,equip[28].address,samsungport,1)
	IP_client_open(dvMoncard2.port,equip[29].address,samsungport,1)
	IP_client_open(dvMoncard3.port,equip[30].address,samsungport,1)
	//IP_client_open(dvMoncard4.port,equip[31].address,samsungport,1)
	equip[31].connected = 1//bypass because 31 doesn't exist
	IP_client_open(dvrextimer.port,equip[32].address,samsungport,1)
	IP_CLIENT_OPEN(dvconproj.port,equip[34].address,globalserial,1)
	IP_client_open(dvMoncon.port,equip[35].address,samsungport,1)
	IP_client_open(dvrexdoor.port,equip[36].address,globalport,1)
	emailsetting()
    }
    string://touchpanel feedback
    {
	if(emergency ==1)//bypass of emergency event lockout
	{
	    if(data.text == 'KEYP-3030')//checks password
	    {
		Send_command dvtp,"'@PPX'"//clears touchscreen popups
		Send_string dvqsys1,"'csp Mutesys 0',$0A"//turn off audio mute
		Send_string dvqsys2,"'csp Mutesys 0',$0A"
		qsysstart()//restart audio system
		SOD()//run start of day
		Timeline_create(TL_theater,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//restart theater timeline
		Timeline_create(TL_timers,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//restart timers timeline
		Send_string vdvJWE,"'SOD'"//alert other masters to restart
		[vdvJWE,15] = 1//System variable to on
		[vdvjwe,17] = 0 //emergency variable used by dino system
		[dvtp,1] = 0
		[dvtp,2] = 1//reset on/off panel buttons
		emergency = 0//emergency variable
	    }
	}
	if(systemmute = 0)//system mute turn on event
	{
	    if(data.text == 'KEYP-3003')//checks password
	    {
		Send_string dvqsys1,"'csp Mutesys 1',$0A"//sets system mute
		Send_string dvqsys2,"'csp Mutesys 1',$0A"
		systemmute = 1
		[panels,801] = 1//mute button on
	    }
	}
    }
}
data_event[dvtpvirtual]//virtual touchscreen
{
    string://touchpanel feedback
    {
	if(emergency ==1)//bypass of emergency event lockout
	{
	    if(data.text == 'KEYP-3030')//checks password
	    {
		Send_command dvtp,"'@PPX'"//clears touchscreen popup
		Send_string dvqsys1,"'csp Mutesys 0',$0A"//Turn off mute
		Send_string dvqsys2,"'csp Mutesys 0',$0A"
		qsysstart()//restart audio system
		SOD()//alert other masters to restart
		Timeline_create(TL_theater,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//Restart theater timeline
		Timeline_create(TL_timers,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)
		Send_string vdvJWE,"'SOD'"//alerts other masters to restart
		[vdvJWE,15] = 1//system on variable
		[vdvjwe,17] = 0 //emergency variable used by dino system
		[Panels,1] = 0//reset on button for panels
		[panels,2] = 1
		emergency = 0//emergency variable off
	    }
	}
	if(systemmute = 0)//system mute turn on event
	{
	    if(data.text == 'KEYP-3003')//checks password
	    {
		Send_string dvqsys1,"'csp Mutesys 1',$0A"//sets system mute
		Send_string dvqsys2,"'csp Mutesys 1',$0A"
		systemmute = 1
		[panels,801] = 1//Mute button on
	    }
	}
    }
}
Data_event[vdvjwe]//Virtual device is used to trigger and pass data between masters
{
    string:
    {
	
	if(data.text == 'DOORS')//Door command from theater master(end of video)
	{
	    Send_string dvdino,"'WELCOME TH FINISH',$0D"//Arm Welcome dinos
	    Send_string dvqsys1,"'ct APFerryPL ',$0A"//play ferry audio
	    Send_string dvqsys2,"'ct APFerryPL ',$0A"
	    Send_string dvlighting,"'GTQ 1,3',$0A"//Lights up in theater
	    welcomearmed = 1//Welcome is armed awaiting dino trigger
	    timers.Welcomedelay = 1//reset timers
	    timers.welcometime = 1
	    Timeline_create(TL_Welcome,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//Start welcome timeline
	}
	if(data.text == 'RESET')//Theater reset
	{
	    Send_string dvlighting,"'GTQ 1,1',$0A"//theater lights reset
	    Send_string dvqsys1,"'csp WATERX 0',$0A"//Water audio in theater
	    Send_string dvqsys2,"'csp WATERX 0',$0A"
	}
	if(data.text == 'START')//Theater start
	{
	    Send_string dvlighting,"'GTQ 1,2',$0A"//theater lights down
	    Send_string dvqsys1,"'csp WATERX 1',$0A"//water audio out
	    Send_string dvqsys2,"'csp WATERX 1',$0A"
	}
	if(find_string(data.text,'QSYS-',1))//Passthrough for audio triggers from theater master
	{
	    Remove_string(data.text,'QSYS-',1)
	    Send_string dvqsys1,"data.text,$0A"
	    Send_string dvqsys1,"data.text,$0A"
	}
    }
}
DATA_event[dvbrtwel]//Data events for virtual devices
DATA_event[dvbrtpet]
DATA_event[dvbrttimer]
DATA_event[dvbrtwu]
DATA_event[dvbrtINN]
DATA_event[dvbrtrex]
DATA_event[dvbrtgyro]
DATA_event[dvMonDino1]
DATA_event[dvMonDino2]
DATA_event[dvMonDino3]
DATA_event[dvMonBuild1]
DATA_event[dvMonBuild2]
DATA_event[dvMonBuild3]
DATA_event[dvMonBuild4]
DATA_event[dvMonTable1]
DATA_event[dvMonTable2]
DATA_event[dvMonTable3]
DATA_event[dvMonDNA1]
DATA_event[dvMonDNA2]
DATA_event[dvMonDNA3]
DATA_event[dvMonDNA4]
DATA_event[dvMoncard1]
DATA_event[dvMoncard2]
DATA_event[dvMoncard3]
//DATA_event[dvMoncard4]
DATA_event[dvconproj]
DATA_event[dvrextimer]
DATA_event[dvMoncon]
DATA_EVENT[dvrexdoor]
{
    online:
    {
	equip[data.device.port].connected = 1
	connectcheck()//Checks overall connected status
    }
    offline:
    {
	equip[data.device.port].connected = 0
	IP_CLIENT_CLOSE(data.device.port)//After disconnect IP clients are closed for cleaner reconnect
	connectcheck()
    }
    String:
    {
	Send_string 0,"data.text"//Copy sent to internal system for troubleshooting
	if(equip[data.device.port].point == 0)//Checks pointer is in range
	{
	    equip[data.device.port].point = 1
	}
	equip[data.device.port].buffer[Equip[data.device.port].point] = data.text//stores data
	equip[data.device.port].point++//advances pointer
	if(equip[data.device.port].point > 20)//flips pointer if needed
	{
	    equip[data.device.port].point =1
	}
    }
    ONERROR:
    {
	equip[data.device.port].conerror = data.number//stores error code
	SEND_STRING 0,"itoa(data.device.port),' error is ',itoa(data.number)"//Send error to system
    }
}
DATA_event[dvlighting]//Lighting controller events
{
    online:
    {
	equip[data.device.port].connected = 1
	connectcheck()
    }
    offline:
    {
	equip[data.device.port].connected = 0
	emaillightingfail()//emails admin that lighting has failed
	IP_CLIENT_CLOSE(data.device.port)//closes port for reconnect
	connectcheck()
    }
    String:
    {
	Send_string 0,"data.text"//send string to internal system for troubleshooting
	if(equip[data.device.port].point == 0)//checks pointer is in range
	{
	    equip[data.device.port].point = 1
	}
	equip[data.device.port].buffer[Equip[data.device.port].point] = data.text//store data
	equip[data.device.port].point++//advance pointer
	if(equip[data.device.port].point > 20)//flip pointer if needed
	{
	    equip[data.device.port].point =1
	}
    }
    ONERROR:
    {
	equip[data.device.port].conerror = data.number//store error
	SEND_STRING 0,"itoa(data.device.port),' error is ',itoa(data.number)"//Send error to system
    }
}
Button_event[panels,1]//system off button
{
    hold[30]://requires a 3 second hold
    {
	qsysstop()//Stop all audio(Qsys file)
	EOD()//End of day function
	Send_string vdvJWE,"'EOD'"//Relay to external masters
	[vdvJWE,15] = 0//system off variable
	[panels,1] = 1//switch button to off on touchscreen
	[panels,2] = 0
	Timeline_kill(TL_theater)//kill 2 active timelines
	Timeline_kill(TL_timers)
	dailycheck()//Run end of day time function
    }
}
Button_event[panels,2]//system on button
{
    push:
    {
	qsysstart()//Start audio(qsys file)
	SOD()//Start of day function
	Timeline_create(TL_theater,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//Start theater timeline
	Timeline_create(TL_timers,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//Start timers timeline
	Send_string vdvJWE,"'SOD'"//Relay to external masters
	[vdvJWE,15] = 1//system on variable
	[panels,1] = 0//switch button on touchscreen to on
	[panels,2] = 1
    }
}
button_event[panels,666]//emergency mode
{
    hold[30]://held for 3 seconds
    {
	[vdvjwe,17] = 1//emergency variable used by dino system
	[panels,666] = 1//light up emergency button
	Send_command dvtp,"'@PPN-Emergency'"//Popup emergency screen on touchscreens
	Send_string vdvjwe,"'EMERGENCY'"//Alert other masters
	Send_string dvqsys1,"'csp Mutesys 1',$0A"//Mute audio
	Send_string dvqsys2,"'csp Mutesys 1',$0A"
	Timeline_kill(TL_theater)//Kills theater and timers timelines
	Timeline_kill(TL_timers)
	systemmute = 1//system mute variable
	emergency = 1//Emergency local variable
	EmailEmergency()//Send admin email alert
    }
}
button_event[panels,801]//audio mute button
{
    push:
    {
	if(systemmute ==1)//checks current status
	{
	    Send_string dvqsys1,"'csp Mutesys 0',$0A"//Turn mute off
	    Send_string dvqsys2,"'csp Mutesys 0',$0A"
	    systemmute = 0
	    [panels,801] = 0//feedback off
	}
    }
    hold[30]://hold for 3 seconds
    {
	SEND_COMMAND dvtp, "'@PPN-_keypad'"//Opens keypad to enter mute password
    }
}
Button_event[dvrexbutton,start]//Start theater
{
    push:
    {
	[dvrexbutton,disarm] = 0//change button feedbacks
	[dvrexbutton,start] =1
	Send_string dvdino,"'TRT ARMED',$0D"//alert dino system rex is armed
	rexarmed = 1//internal variable
    }
}
button_event[dvrexbutton,disarm]//disarm theater
{
    push:
    {
	[dvrexbutton,start] = 0//change button feedback
	Send_string dvdino,"'TRT DISARMED',$0D"//alert dino system res is disarmed
	rexarmed = 0
	[dvrexbutton,disarm] = 1
    }
}
Button_event[dvrexbutton,reset]//reset rex theater
{
    push:
    {
	[dvrexbutton,reset]=0
	Send_string dvrexdoor,"'setstate,1:2,1',$0D"//close trigger for rex paddock door(Long pulse)
	Wait(10)
	{
	    Send_string dvrexdoor,"'setstate,1:2,0',$0D"
	}
	Send_string dvlighting,"'GTQ 5,1',$0A"//reset rex theater lighting
	Send_string dvbrtrex,"'reset'"//reset rex theater playback
    }
}
button_event[dvrexbutton,5]//Door open in rex theater
{
    push:
    {
	pulse[dvrexbutton,5]//pulse feedback
	Send_string dvrexdoor,"'setstate,1:1,1',$0D"//open rex paddock door(long pulse)
	Wait(10)
	{
	    Send_string dvrexdoor,"'setstate,1:1,0',$0D"
	}
    }
}
button_event[dvrexbutton,6]//Door close in rex theater
{
    push:
    {
	pulse[dvrexbutton,6]//pulse feedback
	Send_string dvrexdoor,"'setstate,1:2,1',$0D"//close rex paddock door(long pulse)
	Wait(10)
	{
	    Send_string dvrexdoor,"'setstate,1:2,0',$0D"
	}
    }
}
(*************************Timelines**********************)
Timeline_event [TL_Theater]//Used for main theater timing
{
    if([vdvjwe,21] == 1)//set to 1 by theater master when theater is running
    {
	if(timers.Theaterdelay> 0)//checks if there was a delay before the theater ran
	{
	    Theaterfind()//function stores and averages delays
	}
	switch(timers.theatertime)//triggers based upon theater time
	{
	    CASE Fronthalftime:
	    {
		//open for future use
	    }
	    CASE fronthalfwtrans:
	    {
		timers.theatertime = 0
	    }
	    Case intromovielength:
	    {
		//open for future use
	    }
	}
	timers.theatertime++//count up
	if(timers.theatertime > (Fronthalftime+Fronthalftransition))//resets if beyond maximum theater time
	{
	    timers.theatertime = 0
	}
    }
    Else
    {
	timers.Theaterdelay++//counts up if theater is idle
    }
}
Timeline_event [TL_Welcome]//Welcome room timer
{
    if([vdvjwe,17] ==1)//kills timeline if emergency is present
    {
	Timeline_kill(TL_Welcome)
    }
    if(welcomearmed == 1)//Checks if room is armed
    {
	timers.Welcomedelay++//counter increase
	if(timers.Welcomedelay>31)//automatically triggers if maximum delay has been reached
	{
	    Send_string vdvjwe,"'GO'"//alert other masters room has started
	    welcomearmed = 0
	}
    }
    IF((timers.welcomedelay > 0) && (welcomearmed== 0))//deals with delay counter
    {
	Welcomefind()//averages and stores welcome room delay
    }
    if(welcomearmed == 0)//room is live and not armed
    {
	switch(timers.Welcometime)//triggers for room
	{
	    case 2:
	    {
		//Send_string dvbrtwel,"'play'" //currently on a loop instead
	    }
	    CASE Fronthalftime:
	    {
		if(Timeline_active(TL_petting)==1)//checks if petting zoo is already running
		{
		    Timeline_Kill(TL_petting)//Kill petting zoo timers
		    timers.pettingtime = 0
		}
		Timeline_create(TL_Petting,ltime,length_array(ltime),TIMELINE_RELATIVE,TIMELINE_REPEAT)//start petting zoo timers
	    }
	    CASE fronthalfwtrans://room complete
	    {
		timers.welcometime =1//resets timer
		Timeline_kill(TL_Welcome)//Kills timeline
	    }
	}
	timers.Welcometime++//increase timer
    }
}
Timeline_event[TL_petting]//Petting zoo room timer
{
    if([vdvjwe,17] ==1)//if emergency exists cancel timer
    {
	Timeline_kill(TL_petting)
    }
    switch(timers.Pettingtime)//room triggers
    {
	Case 02:
	{
	    //Send_string dvbrtpet,"'play'"//currently looped
	}
	case fronthalfwtrans://room complete
	{
	    timers.pettingtime = 0//reset timer
	    Timeline_kill(TL_petting)//kill timeline
	}
    }
    timers.pettingtime++//timer up
}
//NOTE:  Lab does not have any timer
Timeline_event[tl_trex]//T-rex timer
{
    if([vdvjwe,17] ==1)//if emergency kill the timeline
    {
	Timeline_kill(TL_TREX)
    }
    //NOTE: Rextimer is shared between T-rex theater and main rex room
    Switch(timers.Rextime)//room triggers
    {
	Case 56://End of rex theater video
	{
	    if(rexroom = 1)//if rex theater is active
	    {
		Send_string dvrexdoor,"'setstate,1:1,1',$0D"//open rex door(long pulse
		[dvrexbutton,reset] = 1//turns on reset button on control panel
		Wait(10)
		{
		    Send_string dvrexdoor,"'setstate,1:1,0',$0D"
		}
		Send_string dvlighting,"'GTQ 5,3',$0A"//Lighting trigger of main rex room
		rexroom= 0//rex theater is done
	    }
	}
	Case 150://30 second warning from reset
	{
	    [dvrexbutton,bstatus] = 1
	}
	Case 205://Room complete
	{
	    Timeline_kill(TL_TREX)
	}
    }
    timers.rextime++
}
Timeline_event[TL_Gyro]//Gyro valley timer
{
    if([vdvjwe,17] ==1)//if emergency kill timeline
    {
	Timeline_kill(TL_gyro)
    }
    Switch(timers.gyrotime)//room triggers
    {
	case 10:
	{
	    Send_string dvbrtgyro,"'play'"//ranger start
	}
    }
    if(timers.gyrotime==205)//room complete
    {
	Timeline_kill(TL_GYRO)
    }
    timers.gyrotime++
}
Timeline_event[TL_timers]//used to count system time
{
    timers.Systemtime++
}
(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


