#!/bin/bash

#######################################################
# DOCKER Installation
#######################################################
yes | sudo apt update
yes | sudo apt upgrade
yes | sudo apt install docker.io
yes | sudo apt install docker-compose

#######################################################
# Cleaning up old installations
#######################################################
sudo rm /opt/distri -R

sudo mkdir /opt/distri
sudo mkdir /opt/distri/scripts
sudo mkdir /opt/distri/app
sudo mkdir /opt/distri/docker
sudo mkdir /opt/distri/docker/java
sudo mkdir /opt/distri/images
sudo mkdir /opt/distri/backups
sudo mkdir /opt/distri/version
sudo mkdir /opt/distri/cache

sudo chmod 777 /opt/distri -R

#######################################################
# Downloads
#######################################################
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/distri.service -P /opt/distri/scripts/  
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/app.service -P /opt/distri/scripts/  
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/app.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/desktop.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/distri.desktop -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/images/pig.png -P /opt/distri/images/ 

wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P /opt/distri/docker/
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P /opt/distri/docker/java/
wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/

wget https://github.com/jpablovaz/distri/raw/main/app/app.aa -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ab -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ac -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ad -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ae -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.af -P /opt/distri/app/

wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/app_version.txt -P /opt/distri/version/
wget https://raw.githubusercontent.com/jpablovaz/distri/main/version/api_version.txt -P /opt/distri/version/

#######################################################
# Setting Up Boot Script
#######################################################
sudo chmod +x /opt/distri/scripts/booting.sh
sudo chmod +x /opt/distri/scripts/app.sh
sudo mv /opt/distri/scripts/distri.service /etc/systemd/system
sudo mv /opt/distri/scripts/app.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable distri.service
sudo systemctl enable app.service
#sudo systemctl enable systemd-networkd.service distri.service

#######################################################
# Re-Join APP
#######################################################
#cat /opt/distri/app/app.* > ~/Desktop/Distribuidora_Mendoza.AppImage
cat /opt/distri/app/app.* > /opt/distri/app/dm.AppImage
#sudo chmod 777 /opt/distri -R

chmod +x /opt/distri/app/dm.AppImage
echo $USER > /opt/distri/scripts/user.txt
sudo usermod -aG docker $USER
newgrp docker
sudo docker stop $(docker ps -a -q)
yes | docker system prune -a

########################################################
# Reboot
#######################################################
sudo reboot
