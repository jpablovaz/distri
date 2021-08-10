#!/bin/bash

if [[ -f "/opt/distri/app/running" ]]; then
    wmctrl -a Distribuidora
else
    touch /opt/distri/app/running
    /opt/distri/app/dm.AppImage
    yes | rm /opt/distri/app/running
fi

#user_dir=`cat /opt/distri/scripts/user.txt`
#/home/$user_dir/Desktop/Distribuidora_Mendoza.AppImage

