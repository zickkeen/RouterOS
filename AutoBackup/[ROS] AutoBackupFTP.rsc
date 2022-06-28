:local ftpserver "123.123.123.123"
:local ftpuser "ftpusername"
:local ftppass "ftppassword"
:local path "path-ftp-ifexist"
:local routername [sys identity get name]
:local formatedname
:for i from=0 to=([:len $routername] - 1) do={ 
  :local char [:pick $routername $i]
  :if (($char = " ") || ($char = ">") || ($char = "<") || ($char = "=")) do={
    :set $char "_"
  }
  :set formatedname ($formatedname . $char)
}

:local tanggal [/system clock get date]
:local months ("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec")

:local tgl [ :pick $tanggal 4 6 ]
:local month ([:find $months [:pick $tanggal 0 3 ]] + 1)
:local tahun [ :pick $tanggal 7 11 ]
:local format "$tahun_$month_$tgl"
:local fileName "$formatedname_$format"

/system backup save name="$fileName"
/export file="$fileName.rsc"
:log info [file get "$fileName.backup" type]
:delay 10s;
/tool fetch mode=ftp address="$ftpserver" dst-path="$path/$fileName.backup" user="$ftpuser" pass="$ftppass" upload=yes src-path="$fileName.backup"
/tool fetch mode=ftp address="$ftpserver" dst-path="$path/$fileName.rsc" user="$ftpuser" pass="$ftppass" upload=yes src-path="$fileName.rsc"
/tool fetch mode=ftp address="$ftpserver" dst-path="$path/$fileName_dude.db" user="$ftpuser" pass="$ftppass" upload=yes src-path="disk1/dude/dude.
db"
:delay 10s;
/file remove "$fileName.backup";
/file remove "$fileName.rsc";