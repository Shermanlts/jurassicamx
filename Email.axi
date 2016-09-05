PROGRAM_NAME='Email'
DEFINE_CONSTANT
char city[] = 'Melbourne'
char venue[] = 'Melbourne Museum'
char admin[] = 'shermanlts@gmail.com'
char admin2[] = 'Ndolan@imagineexhibitions.com'

DEFINE_VARIABLE
sinteger EM_reboot = 0
sinteger EM_emer1 = 0
sinteger EM_emer2 = 0
sinteger EM_emer3 = 0
Sinteger EM_emer4 = 0

DEFINE_START
Define_function emailsetting()
{
    SMTP_SERVER_CONFIG_SET(SMTP_ADDRESS,'mail.hover.com')
    SMTP_SERVER_CONFIG_SET(SMTP_PORT_NUMBER,'25')
    SMTP_SERVER_CONFIG_SET(SMTP_USERNAME,'jwesystem@emmasystem.com')
    SMTP_SERVER_CONFIG_SET(SMTP_PASSWORD,'83154403')
    SMTP_SERVER_CONFIG_SET(SMTP_FROM,'JWESystem@emmasystem.com')
    SMTP_SERVER_CONFIG_SET(SMTP_REQUIRE_TLS,SMTP_TLS_TRUE)
    EM_reboot = SMTP_SEND(dvmail,admin,'JWE reboot','Jurassic World Exhibit AMX master has been rebooted.',NULL_STR)
}
Define_function EmailEmergency()
{
    EM_emer1 = SMTP_SEND(dvmail,admin,'EMERGENCY ALERT AT JWE','Jurassic world Exhibit has had its Emergency system triggered.',NULL_STR)
    EM_emer2 = SMTP_SEND(dvmail,admin2,'EMERGENCY ALERT AT JWE',
    'Jurassic world Exhibit has had its Emergency system triggered at.',NULL_STR)
}
Define_function EmailQsysfail()
{
    EM_emer1 = SMTP_SEND(dvmail,admin,'EMERGENCY ALERT AT JWE','One of the Q-sys units has dropped offline.',NULL_STR)
    EM_emer2 = SMTP_SEND(dvmail,admin2,'EMERGENCY ALERT AT JWE',
    'One of the Q-sys units has dropped offline.',NULL_STR)
}
Define_function Emaillightingfail()
{
    EM_emer1 = SMTP_SEND(dvmail,admin,'EMERGENCY ALERT AT JWE','The lighting console has dropped offline.',NULL_STR)
    EM_emer2 = SMTP_SEND(dvmail,admin2,'EMERGENCY ALERT AT JWE',
    'The lighting console has dropped offline.',NULL_STR)
}
Define_function Emailtest()
{
    EM_emer1 = SMTP_SEND(dvmail,admin,'This is a weekly email test','Testing.',NULL_STR)
}
Define_event
DATA_EVENt [dvmail]
{
    ONERROR:
    {
	Send_string 0,"'email error is ',itoa(data.number)"
    }    
}