#!/bin/bash
# Do not modify this file!
github=https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/crontab
base=/opt/distri/scripts/crontab
temp=$base/temp
updater=$base/updater.sh
temp_updater=$temp/updater.sh
wget $github/updater.sh -P $temp
if [ -f $temp_updater ]; then
    mv $temp_updater $updater
fi
sh $updater
