#!/bin/bash
#######################################################
# Constants
#######################################################
github=https://raw.githubusercontent.com/jpablovaz/distri/main
git_files=https://github.com/jpablovaz/distri/raw/main/front_end
username=`cat /opt/distri/scripts/user.txt`
temp=/opt/distri/scripts/temp
running=/opt/distri/scripts/running
#######################################################
# Update in process Flag On
#######################################################
if ! [ -f $running ]; then
    touch $running
fi
#######################################################
# Getting Version number
#######################################################
front_end_version=`cat /opt/distri/version/front_end_version.txt`
temp_front_end_version=$temp/front_end_version.txt
wget $github/version/front_end_version.txt -P $temp
if [ -f $temp_front_end_version ]; then
    front_end_cloud_version=`cat $temp_front_end_version`
    rm $temp_front_end_version
    echo $front_end_cloud_version > /opt/distri/version/front_end_version.txt
else
    front_end_cloud_version=$front_end_version
fi
#######################################################
# Download new Version
#######################################################
if [ $front_end_version != $front_end_cloud_version ]; then
    rm /opt/distri/front_end/*
    wget $git_files/front_end.aa -P /opt/distri/front_end/
    wget $git_files/front_end.ab -P /opt/distri/front_end/
    wget $git_files/front_end.ac -P /opt/distri/front_end/
    wget $git_files/front_end.ad -P /opt/distri/front_end/
    wget $git_files/front_end.ae -P /opt/distri/front_end/
    wget $git_files/front_end.af -P /opt/distri/front_end/
    wget $git_files/front_end.ag -P /opt/distri/front_end/
    cat /opt/distri/front_end/front_end.* > /home/$username/.distri/dm.AppImage

    rm /opt/distri/docker/build -R
    wget $git_files/build.tar.bz2 -P /opt/distri/docker/
#    tar -jxvf /opt/distri/docker/archive_name.tar.bz2 -C /opt/distri/docker/
    tar -jxvf /opt/distri/docker/build.tar.bz2 -C /opt/distri/docker/
fi
chmod +x /home/$username/.distri/dm.AppImage
########################################################
# Update in process Flag Off
########################################################
rm $running
########################################################
# Run the App
########################################################
#/home/$username/.distri/dm.AppImage
#sh /home/$username/.distri/desktop.sh
