#!/bin/bash
base=/opt/distri/scripts
temp=$base/temp
boot=$base/booting.sh
tboot=$temp/booting.sh
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P $temp
if [ -f $tboot ]; then
    mv $tboot $boot
    chmod +x /opt/distri/scripts/booting.sh
fi
sh $boot
