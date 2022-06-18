#!/bin/bash
user_dir=`cat /opt/distri/scripts/user.txt`
if [ -f /opt/distri/scripts/running ]; then
    wmctrl -a Distribuidora
else
    touch /opt/distri/scripts/running
    /home/$user_dir/.distri/dm.AppImage
    yes | rm /opt/distri/scripts/running
fi
