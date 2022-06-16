#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`
temp=/opt/distri/scripts/temp
running=/opt/distri/scripts/running

if ! [ -f $running ]; then
    touch $running
fi

#######################################################
# Versions
#######################################################
app_version=`cat /opt/distri/version/app_version.txt`
api_version=`cat /opt/distri/version/api_version.txt`
temp_app_version=$temp/app_version.txt
temp_api_version=$temp/api_version.txt
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt -P $temp
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt -P $temp
if [ -f $temp_app_version ]; then
    app_cloud_version=`cat $temp_app_version`
    rm $temp_app_version
    echo $app_cloud_version > /opt/distri/version/app_version.txt
else
    app_cloud_version=$app_version
fi

if [ -f $temp_api_version ]; then
    api_cloud_version=`cat $temp_api_version`
    rm $temp_api_version
    echo $api_cloud_version > /opt/distri/version/api_version.txt
else
    api_cloud_version=$api_version
fi

#######################################################
# Download Files
#######################################################
compose=/opt/distri/docker/docker-compose.yml
docker=/opt/distri/docker/java/Dockerfile
print=/opt/distri/scripts/print.sh
temp_compose=$temp/docker-compose.yml
temp_docker=$temp/Dockerfile
temp_print=$temp/print.sh
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P $temp
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P $temp
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/print.sh -P $temp
if [ -f $temp_compose ]; then
    mv $temp_compose $compose
fi
if [ -f $temp_docker ]; then
    mv $temp_docker $docker
fi
if [ -f $temp_print ]; then
    mv $temp_print $print
fi
#######################################################
# Reading local version
#######################################################
if [ $app_version != $app_cloud_version ]; then
    rm /opt/distri/app/*
    wget https://github.com/jpablovaz/distri/raw/main/app/app.aa -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ab -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ac -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ad -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ae -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.af -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ag -P /opt/distri/app/
    cat /opt/distri/app/app.* > /home/$username/.distri/dm.AppImage
    chmod +x /home/$username/.distri/dm.AppImage
fi
if [ $api_version != $api_cloud_version ]; then
    rm /opt/distri/docker/java/distri.jar
    wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/
fi
cd /opt/distri/docker

rm $running

sh /opt/distri/scripts/print.sh
docker-compose up


