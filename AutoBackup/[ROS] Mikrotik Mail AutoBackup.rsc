# Created Date  : mar/30/2022 11:51:18
# Author        : Zick Keen
# Tested on     : RouterOS 6.40 or newer
#CATATAN        : gunakan password khusus app: https://myaccount.google.com/apppasswords

#Jalankan command di bawah melalui terminal
/tool e-mail set address=smtp.google.com from="smtpuser@gmail.com" password="smtppass" \
	port=587 start-tls=yes user="smtpuser@gmail.com"

/system script
add name=autobackup owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    :local smtpserver \"smtp.google.com\"\r\
    \n:local smtpuser \"smtpuser@gmail.com\"\r\
    \n:local smtppass \"smtppass\"\r\
	\n:local emailto \"mailto@gmail.com\"\r\
    \n:local routername [sys identity get name]\r\
    \n\r\
    \n\r\
    \n/system backup save name=\"\$routername\"\r\
    \n:log info [file get \"\$routername.backup\" type]\r\
    \n:delay 10s;\r\
    \n/tool e-mail send server=[:resolve smtp.gmail.com] port=587 user=\"\$smt\
    puser\" password=\"\$smtppass\" to=\"\$emailto\" subject=\"Backup Mikrotik \
    \$routername\" body=\"Backup mikrotik \$routername\" start-tls=yes  file=\
    \"\$routername.backup\" from=\"\$smtpuser\";\r\
    \n:delay 20s;\r\
    \n/file remove \"\$routername.backup\";"


#Untuk export konfigurasi dapat menggunakan script berikut
/system script
add name=autobackup owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    :local smtpserver \"smtp.google.com\"\r\
    \n:local smtpuser \"smtpuser@gmail.com\"\r\
    \n:local smtppass \"smtppass\"\r\
	\n:local emailto \"mailto@gmail.com\"\r\
    \n:local routername [sys identity get name]\r\
    \n\r\
    \n\r\
    \nexport compact file=\"\$routername.rsc\"\r\
    \n:log info [file get \"\$routername.rsc\" type]\r\
    \n:delay 10s;\r\
    \n/tool e-mail send server=[:resolve smtp.gmail.com] port=587 user=\"\$smt\
    puser\" password=\"\$smtppass\" to=\"\$emailto\" subject=\"Backup Mikrotik \
    \$routername\" body=\"Backup mikrotik \$routername\" start-tls=yes  file=\
    \"\$routername.rsc\" from=\"\$smtpuser\";\r\
    \n:delay 20s;\r\
    \n/file remove \"\$routername.rsc\";"


# Jika ingin copas script diWinbox langsung (tanpa melalui terminal)
# dapat menggunakan script dibawah ini:
:local smtpserver "smtp.google.com"
:local smtpuser "smtpuser@gmail.com"
:local smtppass "smtppass"
:local emailto "mailto@gmail.com"
:local routername [sys identity get name]

/system backup save name="$routername"
:log info [file get "$routername.backup" type]
:delay 10s;
/tool e-mail send server=[:resolve smtp.gmail.com] port=587 user="$smtpuser" password="$smtppass" to="$emailto" subject="Backup Mikrotik $routername" body="Backup mikrotik $routername" start-tls=yes  file="$routername.backup" from="$smtpuser";
:delay 20s;
/file remove "$routername.backup";


# Script winbox untuk auto export konfigurasi

:local smtpserver "smtp.google.com"
:local smtpuser "jackkinny@gmail.com"
:local smtppass "jjytakzevtqwsefo"
:local emailto "zickkeen@gmail.com"
:local routername [sys identity get name]

:local tanggal [/system clock get date]
:local months ("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec")

:local tgl [ :pick $tanggal 4 6 ]
:local month ([:find $months [:pick $tanggal 0 3 ]] + 1)
:local tahun [ :pick $tanggal 7 11 ]
:local format "$tahun_$month_$tgl"
:local fileName "$routername_$format"

export compact file="$fileName"
delay 10s
:log info [file get "$fileName" type]
/tool e-mail send server=[:resolve smtp.gmail.com] port=587 user="$smtpuser" password="$smtppass" to="$emailto" subject="Backup Mikrotik $routername" body="Backup mikrotik $fileName" start-tls=yes  file="$fileName" from="$smtpuser";
:delay 20s;
/file remove "$fileName";