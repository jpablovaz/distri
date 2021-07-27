#!/bin/bash
#######################################################
# DOCKER Installation
#######################################################
yes | sudo apt update
yes | sudo apt upgrade
yes | sudo apt install git
yes | sudo apt install docker.io

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
sudo systemctl daemon-reload
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

#sudo docker stop $(docker ps -a -q)
sudo usermod -aG docker $USER
newgrp docker
#yes | docker system prune -a
