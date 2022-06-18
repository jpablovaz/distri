#!/bin/bash
# HOLA a todos...!!
github=https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/crontab
base=/opt/distri/scripts/crontab
temp=/opt/distri/scripts/temp
################################################
# dcron
dcron=$base/dcron
temp_dcron=$temp/dcron
$github/dcron >> out1.txt
wget $github/dcron -P $temp
if [ -f $temp_dcron ]; then
    mv $temp_dcron $dcron
	chmod 777 $dcron
fi
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
