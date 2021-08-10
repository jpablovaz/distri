#!/bin/bash

if [[ -f "/opt/distri/scripts/running" ]]; then
    wmctrl -a Distribuidora
else
    touch /opt/distri/scripts/running
    /opt/distri/app/dm.AppImage
    yes | rm /opt/distri/scripts/running
fi

#user_dir=`cat /opt/distri/scripts/user.txt`
#/home/$user_dir/Desktop/Distribuidora_Mendoza.AppImage

