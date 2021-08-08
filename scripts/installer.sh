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
sudo mkdir /opt/distri/backups
sudo mkdir /opt/distri/cache

sudo chmod 777 /opt/distri -R

#######################################################
# Downloads
#######################################################
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/distri.service -P /opt/distri/scripts/  
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/booting.sh -P /opt/distri/scripts/ 

wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/docker-compose.yml -P /opt/distri/docker/
wget https://raw.githubusercontent.com/jpablovaz/distri/main/docker/java/Dockerfile -P /opt/distri/docker/java/
wget https://github.com/jpablovaz/distri/raw/main/docker/java/distri.jar -P /opt/distri/docker/java/

wget https://github.com/jpablovaz/distri/raw/main/app/app.aa -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ab -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ac -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ad -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.ae -P /opt/distri/app/
wget https://github.com/jpablovaz/distri/raw/main/app/app.af -P /opt/distri/app/

#######################################################
# Setting Up Boot Script
#######################################################
sudo chmod +x /opt/distri/scripts/booting.sh
sudo mv /opt/distri/scripts/distri.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable distri.service

#######################################################
# Re-Join APP
#######################################################
cat /opt/distri/app/app.* > ~/Desktop/Distribuidora_Mendoza.AppImage
chmod +x ~/Desktop/Distribuidora_Mendoza.AppImage
sudo usermod -aG docker $USER
newgrp docker
sudo docker stop $(docker ps -a -q)
yes | docker system prune -a

########################################################
# Reboot
#######################################################
sudo reboot
