#!/bin/bash

yes | rm /opt/distri/app/running

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

#######################################################
# Files
#######################################################
f_booting=/opt/distri/scripts/booting.sh
f_booting_2=/opt/distri/scripts/booting2

f_compose=/opt/distri/docker/docker-compose.yml
f_compose_2=/opt/distri/docker/compose2

f_docker=/opt/distri/docker/java/Dockerfile
f_docker_2=/opt/distri/docker/java/Docker2

f_v_app=/opt/distri/version/app_version.txt
f_v_app_2=/opt/distri/version/app2

f_v_api=/opt/distri/version/api_version.txt
f_v_api_2=/opt/distri/version/api2

wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P $f_booting_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P $f_compose_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P $f_docker_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt -P $f_v_app_2
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt -P $f_v_api_2

if [ -f $f_compose_2/docker-compose.yml ]; then
    yes | rm $f_compose
    mv $f_compose_2/docker-compose.yml $f_compose
    yes | rm -rf $f_compose_2
fi

if [ -f $f_docker_2/Dockerfile ]; then
    yes | rm $f_docker
    mv $f_docker_2/Dockerfile $f_docker
    yes | rm -rf $f_docker_2
fi

if [ -f $f_v_app_2/app_version.txt ]; then
    yes | rm $f_v_app
    mv $f_v_app_2/app_version.txt $f_v_app
    yes | rm -rf $f_v_app_2
fi

if [ -f $f_v_api_2/api_version.txt ]; then
    yes | rm $f_v_api
    mv $f_v_api_2/api_version.txt $f_v_api
    yes | rm -rf $f_v_api_2
fi

#######################################################
# Reading local version
#######################################################
if [ $app_version != $app_cloud_version ]; then
    yes | rm /opt/distri/app/*
    wget https://github.com/jpablovaz/distri/raw/main/app/app.aa -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ab -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ac -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ad -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.ae -P /opt/distri/app/
    wget https://github.com/jpablovaz/distri/raw/main/app/app.af -P /opt/distri/app/
    cat /opt/distri/app/app.* > /opt/distri/app/dm.AppImage
    chmod +x /opt/distri/app/dm.AppImage
    if [ -f "/home/$user_dir/Desktop/app_Diff" ]; then
        echo "Already exist Juancito"
    else
        mkdir /home/$user_dir/Desktop/app_Diff
    fi
else
    if [ -f "/home/$user_dir/Desktop/app_Equal" ]; then
        echo "Already exist Juancito"
    else
        mkdir /home/$user_dir/Desktop/app_Equal
    fi
fi

if [ $api_version != $api_cloud_version ]; then
    yes | rm /opt/distri/docker/java/distri.jar
    wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/
    mkdir /home/$user_dir/Desktop/api_Diff
else
    mkdir /home/$user_dir/Desktop/api_Equal
fi

chmod +x /opt/distri/app/dm.AppImage

cd /opt/distri/docker
docker-compose up

if [ -f $f_booting_2/booting.sh ]; then
    yes | rm $f_booting
    mv $f_booting_2/booting.sh $f_booting
    yes | rm -rf $f_booting_2
fi
