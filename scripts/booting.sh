#!/bin/bash

#yes | rm /opt/distri/docker/docker-compose.yml
#yes | rm /opt/distri/docker/java/Dockerfile
#yes | rm /opt/distri/scripts/booting.sh
f_booting = /opt/distri/scripts/booting.sh
f_booting_2 = /opt/distri/scripts/booting2.sh

f_compose = /opt/distri/docker/docker-compose.yml
f_compose_2 = /opt/distri/docker/docker-compose2.yml

f_docker = /opt/distri/docker/java/Dockerfile
f_docker_2 = /opt/distri/docker/java/Dockerfile2

f_v_app = /opt/distri/version/app_version.txt
f_v_app_2 = /opt/distri/version/app_version2.txt

f_v_api = /opt/distri/version/api_version.txt
f_v_api_2 = /opt/distri/version/api_version2.txt

wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P $f_booting_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P $f_compose_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P $f_docker_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt -P $f_v_app_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt -P $f_v_api_2

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

chmod +x /opt/distri/app/dm.AppImage

if [[ -f "$f_booting_2" ]]; then
    yes | rm $f_booting
    mv $f_booting_2 $f_booting
fi

if [[ -f "$f_compose_2" ]]; then
    yes | rm $f_compose
    mv $f_compose_2 $f_compose
fi

if [[ -f "$f_docker_2" ]]; then
    yes | rm $f_docker
    mv $f_docker_2 $f_docker
fi

if [[ -f "$f_v_app_2" ]]; then
    yes | rm $f_v_app
    mv $f_v_app_2 $f_v_app
fi

if [[ -f "$f_v_api_2" ]]; then
    yes | rm $f_v_api
    mv $f_v_api_2 $f_v_api
fi

#mv /opt/distri/scripts/booting2.sh /opt/distri/scripts/booting.sh
#mv /opt/distri/docker/docker-compose2.yml /opt/distri/docker/docker-compose.yml
#mv /opt/distri/docker/java/Dockerfile2 /opt/distri/docker/java/Dockerfile
#mv /opt/distri/version/app_version2.txt /opt/distri/version/app_version.txt
#mv /opt/distri/version/api_version2.txt /opt/distri/version/api_version.txt

cd /opt/distri/docker
docker-compose up

