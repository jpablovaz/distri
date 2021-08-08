#!/bin/bash

wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P /opt/distri/docker/
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P /opt/distri/docker/java/

#######################################################
# Reading cloud version
#######################################################
echo "CLOUD:"
app_cloud_version="`wget -qO- https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt`"
api_cloud_version="`wget -qO- https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt`"
echo $app_cloud_version
echo $api_cloud_version

#######################################################
# Reading local version
#######################################################
echo "LOCAL:"
app_version=`cat /opt/distri/version/app_version.txt`
api_version=`cat /opt/distri/version/api_version.txt`
echo $app_version
echo $api_version

wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt -P /opt/distri/version/
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt -P /opt/distri/version/

#######################################################
# Reading local version
#######################################################
if [ "$api_version" != "$api_cloud_version" ]; then
    wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/
fi

if [ "$app_version" != "$app_cloud_version" ]; then
    wget https://github.com/jpablovaz/distri/raw/main/app/app.aa -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ab -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ac -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ad -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ae -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.af -P /opt/distri/app/
    reboot
else
    cd /opt/distri/docker
    docker-compose up
fi
