#!/bin/bash

#yes | rm /opt/distri/docker/docker-compose.yml
#yes | rm /opt/distri/docker/java/Dockerfile
#yes | rm /opt/distri/scripts/booting.sh
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P /opt/distri/scripts/booting2.sh
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P /opt/distri/docker/docker-compose2.yml
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P /opt/distri/docker/java/Dockerfile2

wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt -P /opt/distri/version/app_version2.txt
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt -P /opt/distri/version/api_version2.txt

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
user_dir=`cat /opt/distri/scripts/user.txt`
echo $app_version
echo $api_version

#yes | rm /opt/distri/version/app_version.txt
#yes | rm /opt/distri/version/api_version.txt
#######################################################
# Reading local version
#######################################################
if [ "$app_version" != "$app_cloud_version" ]; then
    yes | rm /opt/distri/app/*
#    yes | rm /home/$user_dir/Desktop/Distribuidora_Mendoza.AppImage
    wget https://github.com/jpablovaz/distri/raw/main/app/app.aa -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ab -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ac -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ad -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ae -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.af -P /opt/distri/app/
#    cat /opt/distri/app/app.* > /home/$user_dir/Desktop/Distribuidora_Mendoza.AppImage
    cat /opt/distri/app/app.* > /opt/distri/app/dm.AppImage
    chmod +x /opt/distri/app/dm.AppImage
    mkdir /home/$user_dir/Desktop/app_Diff
else
    mkdir /home/$user_dir/Desktop/app_Equal
fi

if [ "$api_version" != "$api_cloud_version" ]; then
    yes | rm /opt/distri/docker/java/distri.jar
    wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/
    mkdir /home/$user_dir/Desktop/api_Diff
else
    mkdir /home/$user_dir/Desktop/api_Equal
fi

mv /opt/distri/scripts/booting2.sh /opt/distri/scripts/booting.sh
chmod +x /opt/distri/app/dm.AppImage
mv /opt/distri/docker/docker-compose2.yml /opt/distri/docker/docker-compose.yml
mv /opt/distri/docker/java/Dockerfile2 /opt/distri/docker/java/Dockerfile
mv /opt/distri/version/app_version2.txt /opt/distri/version/app_version.txt
mv /opt/distri/version/api_version2.txt /opt/distri/version/api_version.txt



cd /opt/distri/docker
docker-compose up

