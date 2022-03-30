#Jalankan command di bawah melalui terminal
/tool email set address=smtp.google.com from=smtpuser@gmail.com password=smtppass \
	port=587 start-tls=yes user=smtpuser@gmail.com


#Gunakan Script dibawah ini sebagai script mikrotik dan jalankan dengan scheduler
#CATATAN: gunakan password khusus app: https://myaccount.google.com/apppasswords
:local smtpserver "smtp.google.com"
:local smtpuser "smtpuser@gmail.com"
:local smtppass "smtppass"
:local routername "routername"

:local email "mailto@gmail.com"

/system backup save name="$routername";
:delay 3s;
:log info "kirim file $routername ke email $email";
/tool e-mail send server=[:resolve smtp.gmail.com] port=587 user="$smtpuser" password="$smtppass" to="$email" subject="Backup Mikrotik $routername" body="Backup mikrotik $routername" start-tls=yes  file="$routername.backup" from="$smtpuser";
:log info "Backup dikirim ke email $email";
:delay 20s;
/file remove "$routername.backup";
:log info "file $routername.backup dihapus"