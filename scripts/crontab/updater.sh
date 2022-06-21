#!/bin/bash
# HOLA a todos...!!
github=https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/crontab
base=/opt/distri/scripts/crontab
temp=/opt/distri/scripts/temp
username=`cat /opt/distri/scripts/user.txt`
################################################
# dcron
dcron=$base/dcron
#temp_dcron=$temp/dcron
#wget $github/dcron -P $temp
#if [ -f $temp_dcron ]; then
#	rm -f $dcron
#    mv $temp_dcron $dcron
#chmod 777 $dcron
#fi
> $dcron
echo \@reboot sleep 10 \; sh  /opt/distri/scripts/crontab/_init.sh >> $dcron
echo \@reboot sleep 13 \; sh  /opt/distri/scripts/crontab/updater.sh >> $dcron
echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/back_end.sh >> $dcron
echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/front_end.sh >> $dcron
echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/printer.sh >> $dcron
echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/once.sh >> $dcron
echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/backup.sh >> $dcron
echo \@reboot sleep 25 \; sh /home/$username/.distri/desktop.sh >> $dcron
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
################################################
# once
once=$base/runner/once.sh
temp_once=$temp/once.sh
wget $github/runner/once.sh -P $temp
if [ -f $temp_once ]; then
    mv $temp_once $once
	chmod +x $once
fi
################################################
# backup
backup=$base/runner/backup.sh
temp_backup=$temp/backup.sh
wget $github/runner/backup.sh -P $temp
if [ -f $temp_backup ]; then
    mv $temp_backup $backup
	chmod +x $backup
fi
