# Remote SysLogs Papertrail edition
:local remotesvr "7.214.212.59"
:local portsvr "39152"
:local prefix "PMS"

/system logging action
add bsd-syslog=yes name=papertrail remote=$remotesvr remote-port=$portsvr \
    src-address=0.0.0.0 syslog-facility=daemon syslog-severity=auto target=\
    remote
	
/system logging
add action=papertrail disabled=no prefix=$prefix topics=!async
