#!/bin/bash
# HOLA a todos...!!
github=https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/crontab
github_java=https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java
base=/opt/distri/scripts/crontab
base_java=/opt/distri/docker/java
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

echo \@reboot sleep 20 \; sh /opt/distri/scripts/crontab/_init.sh >> $dcron
echo \@reboot sleep 33 \; sh /opt/distri/scripts/crontab/updater.sh >> $dcron 
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/back_end.sh >> $dcron
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/front_end.sh >> $dcron
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/printer.sh >> $dcron
echo \@reboot sleep 40 \; sh /opt/distri/scripts/crontab/runner/ip_reader.sh >> $dcron
echo \@reboot sleep 45 \; sh /home/$username/.distri/desktop.sh >> $dcron
#echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/once.sh >> $dcron
#echo \@reboot sleep 18 \; sh /opt/distri/scripts/crontab/runner/backup.sh >> $dcron
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
# ip_reader
ip_reader=$base/runner/ip_reader.sh
temp_ip_reader=$temp/ip_reader.sh
wget $github/runner/ip_reader.sh -P $temp
if [ -f $temp_ip_reader ]; then
    mv $temp_ip_reader $ip_reader
	chmod +x $ip_reader
fi
################################################
# ip_network
ip_network=$base_java/ip_network.data
temp_ip_network=$temp/ip_network.data
wget $github_java/ip_network.data -P $temp
if [ -f $temp_ip_network ]; then
    mv $temp_ip_network $ip_network
	chmod +x $ip_network
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
