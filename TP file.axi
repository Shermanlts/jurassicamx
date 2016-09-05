PROGRAM_NAME='TP file'
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

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

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
Button_event[dvtp,4]
Button_event[dvtp,5]
Button_event[dvtp,6]//TCP connections
Button_event[dvtp,12]
Button_event[dvtp,13]
Button_event[dvtp,14]
Button_event[dvtp,15]
Button_event[dvtp,16]
Button_event[dvtp,17]
Button_event[dvtp,18]
Button_event[dvtp,19]
Button_event[dvtp,20]
Button_event[dvtp,21]
Button_event[dvtp,22]
Button_event[dvtp,23]
Button_event[dvtp,24]
Button_event[dvtp,25]
Button_event[dvtp,26]
Button_event[dvtp,27]
Button_event[dvtp,28]
Button_event[dvtp,29]
Button_event[dvtp,30]
Button_event[dvtp,31]
Button_event[dvtp,32]
Button_event[dvtp,33]
Button_event[dvtp,34]
Button_event[dvtp,35]
Button_event[dvtp,36]
{
    push:
    {
	p = button.input.channel
	IP_CLIENT_CLOSE(p)
	Wait(5)
	{
	    IP_CLIENT_OPEN(p,"equip[p].address",equip[p].port,1)
	}
    }
}
Button_event[dvtp,7]
Button_event[dvtp,8]
Button_event[dvtp,9]
Button_event[dvtp,10]
Button_event[dvtp,11]//UDP connections
{
    push:
    {
	p= button.input.channel
	IP_CLIENT_CLOSE(p)
	Wait(5)
	{
	    IP_CLIENT_OPEN(p,"equip[p].address",equip[p].port,2)
	}
    }
}
BUTTON_EVENT[dvtp,114]
BUTTON_EVENT[dvtp,115]
BUTTON_EVENT[dvtp,116]
BUTTON_EVENT[dvtp,117]
BUTTON_EVENT[dvtp,118]
BUTTON_EVENT[dvtp,119]
BUTTON_EVENT[dvtp,120]
BUTTON_EVENT[dvtp,121]
BUTTON_EVENT[dvtp,122]
BUTTON_EVENT[dvtp,123]
BUTTON_EVENT[dvtp,124]
BUTTON_EVENT[dvtp,125]
BUTTON_EVENT[dvtp,126]
BUTTON_EVENT[dvtp,127]
BUTTON_EVENT[dvtp,128]
BUTTON_EVENT[dvtp,129]
BUTTON_EVENT[dvtp,130]
BUTTON_EVENT[dvtp,131]
BUTTON_EVENT[dvtp,132]
BUTTON_EVENT[dvtp,133]//monitor on buttons
BUTTON_EVENT[dvtp,134]
BUTTON_EVENT[dvtp,135]
{
    Push:
    {
	If(equip[button.input.channel-100].port == LGport)//LG monitors
	{
	    Send_string equip[button.input.channel-100].device, "lgpon"
	}
	If(equip[button.input.channel-100].port == Samsungport)//Samsung monitor
	{
	    Send_string equip[button.input.channel-100].device, "samsungoff"
	}
    }
}
BUTTON_EVENT[dvtp,214]
BUTTON_EVENT[dvtp,215]
BUTTON_EVENT[dvtp,216]
BUTTON_EVENT[dvtp,217]
BUTTON_EVENT[dvtp,218]
BUTTON_EVENT[dvtp,219]
BUTTON_EVENT[dvtp,220]
BUTTON_EVENT[dvtp,221]
BUTTON_EVENT[dvtp,222]
BUTTON_EVENT[dvtp,223]
BUTTON_EVENT[dvtp,224]
BUTTON_EVENT[dvtp,225]
BUTTON_EVENT[dvtp,226]
BUTTON_EVENT[dvtp,227]
BUTTON_EVENT[dvtp,228]
BUTTON_EVENT[dvtp,229]
BUTTON_EVENT[dvtp,230]
BUTTON_EVENT[dvtp,231]
BUTTON_EVENT[dvtp,232]
BUTTON_EVENT[dvtp,233]//Monitor off buttons
BUTTON_EVENT[dvtp,234]
BUTTON_EVENT[dvtp,235]
{
    Push:
    {
	If(equip[button.input.channel-200].port == LGport)//LG monitors
	{
	    Send_string equip[button.input.channel-200].device, "lgpoff"
	}
	If(equip[button.input.channel-200].port == Samsungport)//Samsung monitor
	{
	    Send_string equip[button.input.channel-200].device, "samsungoff"
	}
    }
}
Button_event[dvtp,601]//Main page revert
{
    push:
    {
	[vdvJWE,17] = 0
	SEND_COMMAND dvtp, "'PAGE-Main Back'"
	//timeline_kill(TL_install)
    }
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

