#!/bin/bash
github=https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/crontab
github_java=https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java
base=/opt/distri/scripts/crontab
base_java=/opt/distri/docker/java
temp=/opt/distri/scripts/temp
username=`cat /opt/distri/scripts/user.txt`
################################################
# dcron
dcron=$base/dcron
> $dcron
echo \@reboot sleep 20 \; sh /opt/distri/scripts/crontab/_init.sh >> $dcron
echo \@reboot sleep 20 \; sh /opt/distri/scripts/crontab/updater.sh >> $dcron 
echo \@reboot sleep 20 \; sh /opt/distri/scripts/crontab/runner/front_end.sh >> $dcron
echo \@reboot sleep 30 \; sh /opt/distri/scripts/crontab/runner/back_end.sh >> $dcron
echo \@reboot sleep 30 \; sh /opt/distri/scripts/crontab/runner/printer.sh >> $dcron
crontab $dcron
################################################
# back_end
back_end=$base/runner/back_end.sh
temp_back_end=$temp/back_end.sh
wget $github/runner/back_end.sh -P $temp
if [ -f $temp_back_end ]; then
    mv $temp_back_end $back_end
	chmod +x $back_end
fi
################################################
# front_end
front_end=$base/runner/front_end.sh
temp_front_end=$temp/front_end.sh
wget $github/runner/front_end.sh -P $temp
if [ -f $temp_front_end ]; then
    mv $temp_front_end $front_end
	chmod +x $front_end
fi
################################################
# printer
printer=$base/runner/printer.sh
temp_printer=$temp/printer.sh
wget $github/runner/printer.sh -P $temp
if [ -f $temp_printer ]; then
    mv $temp_printer $printer
	chmod +x $printer
fi
