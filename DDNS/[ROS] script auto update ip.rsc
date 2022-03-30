# mar/23/2022 10:08:21 by https://github.com/zickkeen
# Tested on version 6.43.2
/system script
add dont-require-permissions=no name=updateip owner=mustofa policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_Dynamic DNS Update / Simple Edition\r\
    \n:local ddnsuser \"user-changeip.com\"\r\
    \n:local ddnspass \"pass-changeip.com\"\r\
    \n:local ddnshost \"host-changeip.com\"\r\
    \n\r\
    \n:global ddnsip\r\
    \n:local resolvedIP [:resolve \$ddnshost]\r\
    \n\r\
    \n/tool fetch url=\"https://myip.dnsomatic.com/\" mode=https dst-path=ipad\
    dress.txt\r\
    \n\r\
    \n:set ddnsip [/file get [/file find name=ipaddress.txt] contents]\r\
    \n\r\
    \n:log info \"set ddnsip: \$ddnsip\"\r\
    \n\r\
    \n:if ([ :typeof \$ddnsip ] = \"nothing\" ) do={\r\
    \n\t:log info (\"DDNS: tidak ada ip yang terset pada ddnsip \$ddnsip, sila\
    hkan cek kembali\")\r\
    \n} else={\r\
    \n  :if (\$ddnsip != \$resolvedIP) do={\r\
    \n    :log info \"DDNS: mengirimkan update ip \$ddnsip ke changeip.com!\"\
    \r\
    \n    :log info [ :put [/tool dns-update name=\$ddnshost address=\$ddnsip \
    key-name=\$ddnsuser key=\$ddnspass ] ]\r\
    \n  } else={ \r\
    \n    :log info \"DDNS: ip saat ini \$ddnsip sama dengan ip sebelumnya \$r\
    esolvedIP\"\r\
    \n  }\r\
    \n}"

/system scheduler
add interval=5m name=changeipDNS on-event="/system script run updateip\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
