PROGRAM_NAME='Qsys'
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT
Long TL_Qsys = 12
long qtimes[] = {2000, 2000, 2000}
char status[] = 'sg'
QSYS_POLLING_PERIOD	=	500
LONG iQSYS_Timeline_Array[] = {QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD, QSYS_POLLING_PERIOD}
(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE
STRUCTURE QSYS_CORE_STRUCTURE
{
    CHAR	sDesignName[32]
    CHAR	sDesignID[32]
    CHAR	sUsername[32]
    CHAR	sPin[4]
    INTEGER	iPrimary
    INTEGER 	iActive
    INTEGER 	iLoggedIn
    CHAR	sBuffer[2048][20]
    integer	pointer
}
STRUCTURE QSYS_VARIABLE_STRUCTURE
{
    CHAR 	sLabel[48]
    CHAR	sString[48]
    INTEGER	iValue
    INTEGER 	iPosition	// PERCENTAGE (*100 TO MAKE INTEGER INSTEAD OF FLOAT)
}
(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
integer qsysactive = 1//Tracks which master is open
char qhold1[30]
char qhold2[30]
QSYS_CORE_STRUCTURE	stQSYSCore		// STRUCTURE THAT HOLDS DSP GENERAL PARAMETERS
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

Define_function qsysstart()
{
    Send_string dvqsys1,"'csp amppower 1',$0A"
    Send_string dvqsys1,"'ct SODplay',$0A"
    Send_string dvqsys2,"'csp amppower 1',$0A"
    Send_string dvqsys2,"'ct SODplay',$0A"
}
Define_function qsysstop()
{
    Send_string dvqsys1,"'csp amppower 0',$0A"
    Send_string dvqsys1,"'ct EODstop',$0A"
    Send_string dvqsys2,"'csp amppower 0',$0A"
    Send_string dvqsys2,"'ct EODstop',$0A"
}
Define_function qsystest()
{
    Send_string dvqsys1,"'csp loop 1',$0A"
    Send_string dvqsys2,"'csp loop 1',$0A"
    Send_string dvqsys1,"'ct BrachPL ',$0A"
    Send_string dvqsys2,"'ct BrachPL ',$0A"
    Send_string dvqsys1,"'ct BrachSPL ',$0A"
    Send_string dvqsys2,"'ct BrachSPL ',$0A"
    Wait(10)
    {
	Send_string dvqsys1,"'ct ParaPL ',$0A"
	Send_string dvqsys2,"'ct ParaPL ',$0A"
	Send_string dvqsys1,"'ct Pachy1PL ',$0A"
	Send_string dvqsys2,"'ct Pachy1PL ',$0A"
	Send_string dvqsys1,"'ct Pachy2PL ',$0A"
	Send_string dvqsys2,"'ct Pachy2PL ',$0A"
	Wait(10)
	{
	    Send_string dvqsys1,"'ct TrexPL ',$0A"
	    Send_string dvqsys2,"'ct TrexPL ',$0A"
	    Send_string dvqsys1,"'ct StegPL ',$0A"
	    Send_string dvqsys2,"'ct StegPL ',$0A"
	    Send_string dvqsys1,"'ct GyroPL ',$0A"
	    Send_string dvqsys2,"'ct GyroPL ',$0A"
	    Wait(10)
	    {
		Send_string dvqsys1,"'ct IrexPL ',$0A"
		Send_string dvqsys2,"'ct IrexPL ',$0A"
	    }
	}
    }
}
DEFINE_FUNCTION Qtestoff()
{
    Send_string dvqsys1,"'csp loop 0',$0A"
    Send_string dvqsys2,"'csp loop 0',$0A"
}
DEFINE_FUNCTION DSP_INITIALIZE(DEV dvDSP_Client)
{
    // CREATE CHANGE GROUPS AND ADD VARIABLES TO THEM
    // XCOUNTER/YCOUNTER IS JUST A GENERIC COUNTER VARIABLE
    LOCAL_VAR INTEGER xCounter
    LOCAL_VAR INTEGER yCounter


    // ADD UP TO 4 CHANGE GROUPS
    SEND_STRING dvDSP_Client,"'cgc 1',$0A"
    SEND_STRING dvDSP_Client,"'cgc 2',$0A"

    SEND_STRING dvDSP_Client,"'cga 1 PwrEntry',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrTHE1',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrTHE2',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrTHE3',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrWel1',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrWel2',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrWel3',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrPet1',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrPet2',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrLab',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrTRT',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrRex1',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrRex2',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrRex3',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrGyr1',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrGyr2',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrGyr3',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrInn',$0A"
    SEND_STRING dvDSP_Client,"'cga 1 PwrRet',$0A"
    
    SEND_STRING dvDSP_Client,"'cga 2 StatENT',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatTHE1',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatTHE2',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatTHE3',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatWel1',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatWel2',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatWel3',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatPet1',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatPet2',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 Statlab',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 Stattrt',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatRex1',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 Statrex2',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 Statrex3',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatGyr1',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatGyr2',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatGyr3',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 Statinn',$0A"
    SEND_STRING dvDSP_Client,"'cga 2 StatRet',$0A"
}
Define_function dsp_Response(DEV dvDSP_Client, char spass[2048])
{
    char temphold[2048]
    char Tempstrip[2048]
    integer length
    if(Find_string(spass,'sr',1))
    {
	temphold = Remove_string(spass,"$0D",1)
    }
}
// FUNCTION THAT UPDATES TOUCHPANEL FOR QSYS IP PHONE
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
data_event[dvtp]
{
    online:
    {
	TIMELINE_CREATE(TL_Qsys,iQSYS_Timeline_Array,LENGTH_ARRAY(iQSYS_Timeline_Array),TIMELINE_RELATIVE,TIMELINE_REPEAT)
    }
}
Data_event[dvqsys1]
{
    online:
    {
	equip[5].connected = 1
	dsp_initialize(dvqsys1)
    }
    offline:
    {
	equip[5].connected = 0
	emailqsysfail()
    }
    String:
    {
	//Send_string 0,"data.text"
	stQSYSCore.sBuffer[stQSYSCore.pointer] = DATA.TEXT
	stQSYSCore.pointer++
	IF(stQSYSCore.pointer>20)
	{
	    stQSYSCore.pointer = 1
	}
	DSP_RESPONSE(dvqsys1, data.text)
    }
    ONERROR:
    {
	Send_string 0, "'port ',itoa(data.device.port),' error is ',itoa(data.number)"
    }
}
Data_event[dvqsys2]
{
    online:
    {
	equip[6].connected =1
	dsp_initialize(dvqsys2)
    }
    Offline:
    {
	equip[6].connected = 0
	emailqsysfail()
    }
    String:
    {
	stQSYSCore.sBuffer[stQSYSCore.pointer] = DATA.TEXT
	stQSYSCore.pointer++
	IF(stQSYSCore.pointer>20)
	{
	    stQSYSCore.pointer = 1
	}
	DSP_RESPONSE(dvqsys2,data.text)
    }
    ONERROR:
    {
	Send_string 0, "'port ',itoa(data.device.port),' error is ',itoa(data.number)"
    }
}
Timeline_event[TL_Qsys]
{
    IF (TIMELINE.SEQUENCE == 10)
    {
	SEND_STRING dvqsys1,"'sg',$0A"
	SEND_STRING dvqsys2,"'sg',$0A"
    } 
    ELSE IF (TIMELINE.SEQUENCE == 9)
    {
	SEND_STRING dvqsys1,"'cgi 1',$0A"
	SEND_STRING dvQSYS1,"'cgi 2',$0A"
	SEND_STRING dvqsys2,"'cgi 1',$0A"
	SEND_STRING dvQSYS2,"'cgi 2',$0A"
    }
    SEND_STRING dvQSYS1,"'cgp 1',$0A"
    SEND_STRING dvQSYS1,"'cgp 2',$0A"
    SEND_STRING dvQSYS2,"'cgp 1',$0A"
    SEND_STRING dvQSYS2,"'cgp 2',$0A"
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

