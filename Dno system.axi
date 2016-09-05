PROGRAM_NAME='Dno system'
DEFINE_CONSTANT

DEFINE_TYPE
Structure dinobuffer
{
    char buffer[20][20]
    integer counter
    integer pointer
}
DEFINE_VARIABLE
dinobuffer bufferdino 
integer db

DEFINE_LATCHING

DEFINE_MUTUALLY_EXCLUSIVE

DEFINE_START
bufferdino.counter =0
bufferdino.pointer =1

DEFINE_EVENT
data_event[dvdino]
{
    online:
    {
	equip[dvdino.port].connected = 1
    }
    offline:
    {
	equip[dvdino.port].connected = 0
	IP_SERVER_CLOSE(dvdino.port)
	IP_SERVER_OPEN(dvDINO.port,Dinoport,1)
    }
    String:
    {
	Send_string 0,"data.text"
	bufferdino.buffer[bufferdino.pointer] = remove_string(data.text,"$0D",1)
	db = bufferdino.pointer
	if(find_string(bufferdino.buffer[db],'LEAVING',1))
	{
	    [VDVJWE,10] = 0
	}
	IF(FIND_STRING(bufferdino.buffer[db],'ENTERING',1))
	{
	    [vdvJWE,10] = 1
	}
	IF(find_string(bufferdino.buffer[db],'DINO',1))
	{
	    if(find_string(bufferdino.buffer[db],'NOT',1))
	    {
		[vdvJWE,11] = 0
	    }
	    Else
	    {
		[vdvJWE,11] = 1
	    }
	}
	IF(find_string(bufferdino.buffer[db],'BRACH',1))
	{
	    Send_string dvdino, "'BRACH ACK ',atoi(bufferdino.buffer[db]),$0D"
	    if(atoi(bufferdino.buffer[db]) < 7 && atoi(Bufferdino.buffer[db]) > 1)
	    {
		if(welcomearmed == 1)
		{
		    Send_string vdvjwe,"'GO'"
		    welcomearmed = 0
		}
	    }
	    switch(atoi(bufferdino.buffer[db]))
	    {
		CASE 2:
		{
		    If([vdvjwe,1] == 2)
		    {
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
			Send_string dvqsys1,"'ct BrachSPL ',$0A"
			Send_string dvqsys2,"'ct BrachSPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,1] = 2
			Send_string dvqsys1,"'css Brachfile "BrachSA.wav" ',$0A"
			Send_string dvqsys2,"'css Brachfile "BrachSA.wav" ',$0A"
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
			Send_string dvqsys1,"'ct BrachSPL ',$0A"
			Send_string dvqsys2,"'ct BrachSPL ',$0A"
		    }
		}
		CASE 4:
		{
		    If([vdvjwe,1] == 4)
		    {
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,1] = 4
			Send_string dvqsys1,"'css Brachfile "BrachVA.wav" ',$0A"
			Send_string dvqsys2,"'css Brachfile "BrachVA.wav" ',$0A"
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		}
		CASE 5:
		{
		    If([vdvjwe,1] == 5)
		    {
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,1] = 5
			Send_string dvqsys1,"'css Brachfile "BrachVB.wav" ',$0A"
			Send_string dvqsys2,"'css Brachfile "BrachVB.wav" ',$0A"
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		}
		CASE 6:
		{
		    If([vdvjwe,1] == 6)
		    {
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,1] = 6
			Send_string dvqsys1,"'css Brachfile "BrachVC.wav" ',$0A"
			Send_string dvqsys2,"'css Brachfile "BrachVC.wav" ',$0A"
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,1] == 7)
		    {
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,1] = 7
			Send_string dvqsys1,"'css Brachfile "BrachCON.wav" ',$0A"
			Send_string dvqsys2,"'css Brachfile "BrachCON.wav" ',$0A"
			Send_string dvqsys1,"'ct BrachPL ',$0A"
			Send_string dvqsys2,"'ct BrachPL ',$0A"
		    }
		}
	    }
	}
	IF(find_string(bufferdino.buffer[db],'PARA',1))
	{
	    Send_string dvdino, "'PARA ACK ',atoi(bufferdino.buffer[db]),$0D"
	    if(atoi(bufferdino.buffer[db]) < 7 && atoi(Bufferdino.buffer[db]) > 1)
	    {
		if(welcomearmed == 1)
		{
		    Send_string vdvjwe,"'GO'"
		    welcomearmed = 0
		}
	    }
	    switch(atoi(bufferdino.buffer[db]))
	    {
		CASE 2:
		{
		    If([vdvjwe,2] == 2)
		    {
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,2] = 2
			Send_string dvqsys1,"'css Parafile "ParaSA.wav" ',$0A"
			Send_string dvqsys2,"'css Parafile "ParaSA.wav" ',$0A"
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		}
		CASE 4:
		{
		    If([vdvjwe,2] == 4)
		    {
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,2] = 4
			Send_string dvqsys1,"'css Parafile "ParaVA.wav" ',$0A"
			Send_string dvqsys2,"'css Parafile "ParaVA.wav" ',$0A"
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		}
		CASE 5:
		{
		    If([vdvjwe,2] == 5)
		    {
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,2] = 5
			Send_string dvqsys1,"'css Parafile "ParaVB.wav" ',$0A"
			Send_string dvqsys2,"'css Parafile "ParaVB.wav" ',$0A"
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		}
		CASE 6:
		{
		    If([vdvjwe,2] == 6)
		    {
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,2] = 6
			Send_string dvqsys1,"'css Parafile "ParaVC.wav" ',$0A"
			Send_string dvqsys2,"'css Parafile "ParaVC.wav" ',$0A"
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,2] == 7)
		    {
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,2] = 7
			Send_string dvqsys1,"'css Parafile "ParaCON.wav" ',$0A"
			Send_string dvqsys2,"'css Parafile "ParaCON.wav" ',$0A"
			Send_string dvqsys1,"'ct ParaPL ',$0A"
			Send_string dvqsys2,"'ct ParaPL ',$0A"
		    }
		}
	    }
	}
	IF(find_string(bufferdino.buffer[db],'PACHY01',1))
	{
	    remove_string(bufferdino.buffer[db],'PACHY01',1)
	    Send_string dvdino, "'PACHY01 ACK ',atoi(bufferdino.buffer[db]),$0D"
	    switch(atoi(bufferdino.buffer[db]))
	    {
		CASE 2:
		{
		    If([vdvjwe,3] == 2)
		    {
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,3] = 2
			Send_string dvqsys1,"'css Pachy1file "ParaSA.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy1file "ParaSA.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		}
		CASE 3:
		{
		    If([vdvjwe,3] == 3)
		    {
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,3] = 3
			Send_string dvqsys1,"'css Pachy1file "Pachy1SB.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy1file "Pachy1SB.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		}
		CASE 4:
		{
		    If([vdvjwe,3] == 4)
		    {
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,3] = 4
			Send_string dvqsys1,"'css Pachy1file "Pachy1VA.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy1file "Pachy1VA.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		}
		CASE 5:
		{
		    If([vdvjwe,3] == 5)
		    {
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,3] = 5
			Send_string dvqsys1,"'css Pachy1file "Pachy1VB.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy1file "Pachy1VB.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,3] == 7)
		    {
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,3] = 7
			Send_string dvqsys1,"'css Pachy1file "Pachy1CON.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy1file "Pachy1CON.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy1PL ',$0A"
			Send_string dvqsys2,"'ct Pachy1PL ',$0A"
		    }
		}
	    }
	}
	IF(find_string(bufferdino.buffer[db],'PACHY02',1))
	{
	    Remove_string(bufferdino.buffer[db],'PACHY02',1)
	    Send_string dvdino, "'PACHY02 ACK ',atoi(bufferdino.buffer[db]),$0D"
	    switch(atoi(bufferdino.buffer[db]))
	    {
		CASE 2:
		{
		    If([vdvjwe,4] == 2)
		    {
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,4] = 2
			Send_string dvqsys1,"'css Pachy2file "Pachy2SA.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy2file "Pachy2SA.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		}
		CASE 3:
		{
		    If([vdvjwe,4] == 3)
		    {
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,4] = 3
			Send_string dvqsys1,"'css Pachy2file "Pachy2SB.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy2file "Pachy2SB.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		}
		CASE 4:
		{
		    If([vdvjwe,4] == 4)
		    {
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,4] = 4
			Send_string dvqsys1,"'css Pachy2file "Pachy2VA.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy2file "Pachy2VA.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		}
		CASE 5:
		{
		    If([vdvjwe,4] == 5)
		    {
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,4] = 5
			Send_string dvqsys1,"'css Pachy2file "Pachy2VB.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy2file "Pachy2VB.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,4] == 7)
		    {
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,4] = 7
			Send_string dvqsys1,"'css Pachy2file "Pachy2CON.wav" ',$0A"
			Send_string dvqsys2,"'css Pachy2file "Pachy2CON.wav" ',$0A"
			Send_string dvqsys1,"'ct Pachy2PL ',$0A"
			Send_string dvqsys2,"'ct Pachy2PL ',$0A"
		    }
		}
	    }
	}
	IF(find_string(bufferdino.buffer[db],'TREX',1))
	{
	    Send_string dvdino, "'TREX ACK ',atoi(bufferdino.buffer[db]),$0D"
	    switch(atoi(bufferdino.buffer[db]))
	    {
		Case 2:
		{
		    [vdvjwe,5] =2
		    if(rexarmed ==1)
		    {
			Rexgo()
		    }
		}
		CASE 3:
		{
		    If([vdvjwe,5] == 3)
		    {
			Send_string dvqsys1,"'ct REX2PL ',$0A"
			Send_string dvqsys2,"'ct REX2PL ',$0A"
			Send_string dvlighting, "'GTQ 6,2',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,5] = 3
			Send_string dvqsys1,"'css Trexfile "TrexSB.wav" ',$0A"
			Send_string dvqsys2,"'css Trexfile "TrexSB.wav" ',$0A"
			Send_string dvqsys1,"'ct REX2PL ',$0A"
			Send_string dvqsys2,"'ct REX2PL ',$0A"
			Send_string dvlighting, "'GTQ 6,2',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,5] == 7)
		    {
			Send_string dvqsys1,"'ct TrexPL ',$0A"
			Send_string dvqsys2,"'ct TrexPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,5] = 7
			Send_string dvqsys1,"'css Trexfile "Trexcon.wav" ',$0A"
			Send_string dvqsys2,"'css Trexfile "Trexcon.wav" ',$0A"
			Send_string dvqsys1,"'ct TrexPL ',$0A"
			Send_string dvqsys2,"'ct TrexPL ',$0A"
		    }
		}
	    }
	}
	IF(find_string(bufferdino.buffer[db],'STEG',1))
	{
	    Send_string dvdino, "'STEG ACK ',atoi(bufferdino.buffer[db]),$0D"
	    switch(atoi(bufferdino.buffer[db]))
	    {
		CASE 2:
		{
		    If([vdvjwe,6] == 2)
		    {
			If(Timeline_active(TL_Gyro)==0)
			{
			    Timeline_create(TL_gyro,ltime,Length_array(ltime),TIMELINE_RELATIVE,Timeline_repeat)
			}
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,6] = 2
			Send_string dvqsys1,"'css Stegfile "StegSA.wav" ',$0A"
			Send_string dvqsys2,"'css Stegfile "StegSA.wav" ',$0A"
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
			If(Timeline_active(TL_Gyro)==0)
			{
			    Timeline_create(TL_gyro,ltime,Length_array(ltime),TIMELINE_RELATIVE,Timeline_repeat)
			}
		    }
		}
		CASE 3:
		{
		    If([vdvjwe,6] == 3)
		    {
			
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,6] = 3
			Send_string dvqsys1, "'css GYRfile "Gyrbgm.wav" ',$0A"
			Send_string dvqsys2, "'css GYRfile "Gyrbgm.wav" ',$0A"
			Send_string dvqsys1,"'ct GYRPL ',$0A"
			Send_string dvqsys2,"'ct GYRPL ',$0A"
			Send_string dvqsys1,"'css Stegfile "StegSB.wav" ',$0A"
			Send_string dvqsys2,"'css Stegfile "StegSB.wav" ',$0A"
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		}
		CASE 4:
		{
		    If([vdvjwe,6] == 4)
		    {
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,6] = 4
			Send_string dvqsys1,"'css Stegfile "StegVA.wav" ',$0A"
			Send_string dvqsys2,"'css Stegfile "StegVA.wav" ',$0A"
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		}
		CASE 5:
		{
		    If([vdvjwe,6] == 5)
		    {
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,6] = 5
			Send_string dvqsys1,"'css Stegfile "StegVB.wav" ',$0A"
			Send_string dvqsys2,"'css Stegfile "StegVB.wav" ',$0A"
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,6] == 7)
		    {
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,6] = 7
			Send_string dvqsys1,"'css Stegfile "StegVA.wav" ',$0A"
			Send_string dvqsys2,"'css Stegfile "StegVA.wav" ',$0A"
			Send_string dvqsys1,"'ct StegPL ',$0A"
			Send_string dvqsys2,"'ct StegPL ',$0A"
		    }
		}
	    }
	}
	IF(find_string(bufferdino.buffer[db],'IREX',1))
	{
	    Send_string dvdino, "'IREX ACK ',atoi(bufferdino.buffer[db]),$0D"
	    switch(atoi(bufferdino.buffer[db]))
	    {
		Case 2:
		{
		    
		}
		CASE 3:
		{
		    If([vdvjwe,7] == 3)
		    {
			Send_string dvqsys1,"'ct IrexPL ',$0A"
			Send_string dvqsys2,"'ct IrexPL ',$0A"
			Send_string dvqsys1,"'ct GyroPL ',$0A"
			Send_string dvqsys2,"'ct GyroPL ',$0A"
			Send_string dvlighting,"'GTQ 7,2',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,7] = 3
			Send_string dvqsys1,"'css Irexfile "IrexSB.wav" ',$0A"
			Send_string dvqsys2,"'css Irexfile "IrexSB.wav" ',$0A"
			Send_string dvqsys1,"'ct IrexPL ',$0A"
			Send_string dvqsys2,"'ct IrexPL ',$0A"
			Send_string dvqsys1,"'ct GyroPL ',$0A"
			Send_string dvqsys2,"'ct GyroPL ',$0A"
			Send_string dvlighting,"'GTQ 7,2',$0A"
		    }
		}
		CASE 7:
		{
		    If([vdvjwe,7] == 7)
		    {
			Send_string dvqsys1,"'ct IrexPL ',$0A"
			Send_string dvqsys2,"'ct IrexPL ',$0A"
		    }
		    ELSE
		    {
			[vdvjwe,7] = 7
			Send_string dvqsys1,"'css Irexfile "Irexcon.wav" ',$0A"
			Send_string dvqsys2,"'css Irexfile "Irexcon.wav" ',$0A"
			Send_string dvqsys1,"'ct IrexPL ',$0A"
			Send_string dvqsys2,"'ct IrexPL ',$0A"
		    }
		}
	    }
	}
	bufferdino.pointer++
	If(bufferdino.pointer>20)
	{
	    bufferdino.pointer = 1
	}
    }
    ONERROR:
    {
	Send_string 0,"'Dino error is ',itoa(data.number)"
    }
}
DEFINE_PROGRAM