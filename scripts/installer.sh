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
#######################################################
# MKDIR
#######################################################
sudo mkdir /opt/distri
sudo mkdir /opt/distri/scripts
sudo mkdir /opt/distri/scripts/crontab
sudo mkdir /opt/distri/scripts/crontab/runner
sudo mkdir /opt/distri/scripts/temp
sudo mkdir /opt/distri/front_end
sudo mkdir /opt/distri/docker
sudo mkdir /opt/distri/docker/postgres
sudo mkdir /opt/distri/docker/java
sudo mkdir /opt/distri/docker/java/pdf
sudo mkdir /opt/distri/docker/java/backup
sudo mkdir /opt/distri/docker/java/restore
sudo mkdir /opt/distri/version
sudo mkdir /opt/distri/cache
sudo chmod 777 /opt/distri -R
dcron=/opt/distri/scripts/crontab/dcron
touch $dcron
echo \@reboot sleep 30 \; sh /opt/distri/scripts/crontab/_init.sh >> $dcron
echo \@reboot sleep 33 \; sh /opt/distri/scripts/crontab/updater.sh >> $dcron
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/back_end.sh >> $dcron
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/front_end.sh >> $dcron
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/printer.sh >> $dcron
echo \@reboot sleep 38 \; sh /opt/distri/scripts/crontab/runner/backup.sh >> $dcron
crontab $dcron
#######################################################
# Setting $User
#######################################################
echo $USER > /opt/distri/scripts/user.txt
echo $USER > /opt/distri/docker/java/user.txt
#sudo mkdir /home/$USER/.distri
#sudo chmod 777 /home/$USER/.distri -R
#######################################################
# Setting
#######################################################
github=https://raw.githubusercontent.com/jpablovaz/distri/main
sudo wget $github/scripts/crontab/_init.sh -P /opt/distri/scripts/crontab
sudo wget $github/scripts/crontab/dcron -P /opt/distri/scripts/crontab
crontab /opt/distri/scripts/crontab/dcron
#######################################################
# Setting Up Boot Script
#######################################################
sudo chmod +x /opt/distri/scripts/crontab/_init.sh
#######################################################
# Initial Versions
#######################################################
echo "0" > /opt/distri/version/back_end_version.txt
echo "0" > /opt/distri/version/front_end_version.txt
########################################################
# Reboot
#######################################################
sudo usermod -aG docker $USER
newgrp docker
sudo docker stop $(docker ps -a -q)
yes | docker system prune -a
########################################################
########################################################
sudo reboot
