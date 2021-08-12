#!/bin/bash
rm /opt/distri/app/running
#######################################################
# Reading cloud version
#######################################################
app_cloud_version="`wget -qO- https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt`"
api_cloud_version="`wget -qO- https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt`"

#######################################################
# Reading local version
#######################################################
app_version=`cat /opt/distri/version/app_version.txt`
api_version=`cat /opt/distri/version/api_version.txt`
username=`cat /opt/distri/scripts/user.txt`

#######################################################
# Files
#######################################################
temp=/opt/distri/scripts/temp

booting=/opt/distri/scripts/booting.sh
compose=/opt/distri/docker/docker-compose.yml
docker=/opt/distri/docker/java/Dockerfile

temp_compose=$temp/docker-compose.yml
temp_docker=$temp/Dockerfile

wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P $temp
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P $temp

if [ -f $temp_compose ]; then
    mv $temp_compose $compose
fi

if [ -f $temp_docker ]; then
    mv $temp_docker $docker
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
    cat /opt/distri/app/app.* > /opt/distri/app/dm.AppImage
    chmod +x /opt/distri/app/dm.AppImage
    if [ -f "/home/$username/Desktop/app_Diff" ]; then
        echo "Already exist Juancito"
    else
        mkdir /home/$username/Desktop/app_Diff
    fi
else
    if [ -f "/home/$username/Desktop/app_Equal" ]; then
        echo "Already exist Juancito"
    else
        mkdir /home/$username/Desktop/app_Equal
    fi
fi

if [ $api_version != $api_cloud_version ]; then
    rm /opt/distri/docker/java/distri.jar
    wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/
    mkdir /home/$username/Desktop/api_Diff
else
    mkdir /home/$username/Desktop/api_Equal
fi

chmod +x /opt/distri/app/dm.AppImage

cd /opt/distri/docker
docker-compose up
