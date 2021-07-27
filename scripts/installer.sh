#!/bin/bash
#######################################################
# DOCKER Installation
#######################################################
sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt install docker.io
docker stop $(docker ps -a -q)
sudo usermod -aG docker $USER
newgrp docker
yes | docker system prune -a

#######################################################
# Cleaning up old installations
#######################################################
sudo rm /opt/distri -R
sudo mkdir /opt/distri
sudo chmod 777 /opt/distri -R

#######################################################
# Downloads
#######################################################
git clone https://github.com/jpablovaz/distri.git /opt/distri

#######################################################
# Setting Up Boot Script
#######################################################
sudo chmod +x /opt/distri/scripts/booting.sh
sudo mv /opt/distri/scripts/distri.service /etc/systemd/system
sudo systemctl enable distri.service

#######################################################
# Extras
#######################################################
mkdir /opt/distri/backups
mkdir /opt/distri/cache

#######################################################
# Re-Join APP
#######################################################
cat /opt/distri/app/app.* > ~/Desktop/Distribuidora Mendoza.AppImage

