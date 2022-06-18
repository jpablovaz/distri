#######################################################
# Constants
#######################################################
github=https://raw.githubusercontent.com/jpablovaz/distri/main
username=`cat /opt/distri/scripts/user.txt`
temp=/opt/distri/scripts/temp
#######################################################
# Getting Version number
#######################################################
back_end_version=`cat /opt/distri/version/back_end_version.txt`
temp_back_end_version=$temp/back_end_version.txt
wget $github/version/back_end_version.txt -P $temp
if [ -f $temp_back_end_version ]; then
    back_end_cloud_version=`cat $temp_back_end_version`
    rm $temp_back_end_version
    echo $back_end_cloud_version > /opt/distri/version/back_end_version.txt
else
    back_end_cloud_version=$back_end_version
fi
#######################################################
# Download new Version
#######################################################
# DockerCompose
compose=/opt/distri/docker/docker-compose.yml
temp_compose=$temp/docker-compose.yml
wget $github/docker/docker-compose.yml -P $temp
if [ -f $temp_compose ]; then
    mv -f $temp_compose $compose
fi
# Java Dockerfile
docker=/opt/distri/docker/java/Dockerfile
temp_docker=$temp/Dockerfile
wget $github/docker/java/Dockerfile -P $temp
if [ -f $temp_docker ]; then
    mv -f $temp_docker $docker
fi
# JAR
if [ $back_end_version != $back_end_cloud_version ]; then
    rm /opt/distri/docker/java/distri.jar
    wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/
fi
#######################################################
# Run DockerCompose
#######################################################
cd /opt/distri/docker
docker-compose up
