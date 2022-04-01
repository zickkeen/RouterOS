# Created Date	: mar/30/2022 11:51:18
# Author 		: Zick Keen
# Created By	: RouterOS 6.48.6
#CATATAN		: gunakan password khusus app: https://myaccount.google.com/apppasswords

#Jalankan command di bawah melalui terminal
/tool e-mail set address=smtp.google.com from="smtpuser@gmail.com" password="smtppass" \
	port=587 start-tls=yes user="smtpuser@gmail.com"

/system script
add dont-require-permissions=no name=autobackup owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local smtpserver \"smtp.google.com\"\r\
    \n:local smtpuser \"smtpuser@gmail.com\"\r\
    \n:local smtppass \"smtppass\"\r\
	\n:local emailto \"mailto@gmail.com\"\r\
    \n:local routername [sys identity get name]\r\
    \n\r\
    \n\r\
    \n/system backup save name=\"\$routername\"\r\
    \n:log info [file get "\$routername.backup" type]\r\
    \n:delay 3s;\r\
    \n/tool e-mail send server=[:resolve smtp.gmail.com] port=587 user=\"\$smt\
    puser\" password=\"\$smtppass\" to=\"\$emailto\" subject=\"Backup Mikrotik \
    \$routername\" body=\"Backup mikrotik \$routername\" start-tls=yes  file=\
    \"\$routername.backup\" from=\"\$smtpuser\";\r\
    \n:delay 20s;\r\
    \n/file remove \"\$routername.backup\";"
