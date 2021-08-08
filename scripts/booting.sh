#!/bin/bash

echo "LOCAL:"
app_local_version="`wget -qO- http://localhost:8090/app-version`"
api_local_version="`wget -qO- http://localhost:8090/api-version`"
echo $app_local_version
echo $api_local_version

echo "CLOUD:"
app_cloud_version=`cat app_cloud_version.txt`
api_cloud_version=`cat api_cloud_version.txt`
echo $app_cloud_version
echo $api_cloud_version

if [ "$app_local_version" = "$app_cloud_version" ]; then
    echo 'Be careful not to fall off!'
else
    echo 'Be careful not to fall off!'
fi

if [ "$api_local_version" = "$api_cloud_version" ]; then
    echo 'Be careful not to fall off!'
else
    echo 'Be careful not to fall off!'
fi

wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P /opt/distri/scripts/ 
cd /opt/distri/docker
docker-compose up --build
