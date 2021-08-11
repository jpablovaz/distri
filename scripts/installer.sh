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
sudo rm ~/.local/share/applications/distri.desktop

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
#wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/desktop.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/desktop.sh -P ~/.distri/ 
#wget https://raw.githubusercontent.com/jpablovaz/distri/main/images/pig.png -P /opt/distri/images/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/images/pig.png -P ~/.distri/

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
sudo chmod +x ~/.distri/desktop.sh
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
#cat /opt/distri/app/app.* > /opt/distri/app/dm.AppImage
cat /opt/distri/app/app.* > ~/.distri/dm.AppImage
#wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/distri.desktop -P ~/.local/share/applications

sudo chmod +x ~/.distri/dm.AppImage

cat > ~/.local/share/applications/distri.desktop <<EOF
[Desktop Entry]
Name=Distribuidora
Comment=Administration
Exec=/home/$USER/.distri/desktop.sh
Icon=/home/$USER/.distri/pig.png
Terminal=false
Type=Application
Categories=Utility
EOF
#sudo chmod 777 /opt/distri -R
rm /opt/distri/app/app.*
sudo desktop-file-install ~/.local/share/applications/distri.desktop
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
