#!/bin/bash
base=/opt/distri/scripts
temp=$base/temp
boot=$base/booting.sh
temp_boot=$temp/booting.sh
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P $temp
if [ -f $temp_boot ]; then
    mv $temp_boot $boot
fi
sh $boot
