#Firware Upgrade script
:global Var1
:global Var2
:set Var1 "$[/system package get system version]"
:set Var2 "$[/system routerboard get current-firmware]"
:if ($Var1>$Var2) do={/system routerboard upgrade;
/system reboot;
}



#ROS Version Upgrade script
:log info message="Auto Upgrade Started."
/system package update
check-for-updates once
:delay 3s;
 
:if ( [get status] = "New version is available") do={ 
install
} else={:log info message="No Update."}
