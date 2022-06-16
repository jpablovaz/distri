#!/bin/bash
https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/installer.shgit 	
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
sudo rm ~/.distri/desktop.sh
sudo rm ~/.distri/pig.png

#######################################################
# MKDIR
#######################################################
sudo mkdir /opt/distri
sudo mkdir /opt/distri/scripts
sudo mkdir /opt/distri/scripts/temp
sudo mkdir /opt/distri/app
sudo mkdir /opt/distri/docker
sudo mkdir /opt/distri/docker/java
sudo mkdir /opt/distri/docker/java/pdf
sudo mkdir /opt/distri/images
sudo mkdir /opt/distri/backups
sudo mkdir /opt/distri/version
sudo mkdir /opt/distri/cache
sudo chmod 777 /opt/distri -R

#######################################################
# Setting $User
#######################################################
echo $USER > /opt/distri/scripts/user.txt

#######################################################
# Setting .desktop
#######################################################
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/distri.service -P /opt/distri/scripts/  
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/print.service -P /opt/distri/scripts/  
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/init.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/print.sh -P /opt/distri/scripts/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/scripts/desktop.sh -P ~/.distri/ 
wget https://raw.githubusercontent.com/jpablovaz/distri/main/images/pig.png -P ~/.distri/

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

sudo desktop-file-install ~/.local/share/applications/distri.desktop

#######################################################
# Setting Up Boot Script
#######################################################
sudo chmod +x /opt/distri/scripts/init.sh
sudo chmod +x /opt/distri/scripts/print.sh
sudo chmod +x ~/.distri/desktop.sh
sudo mv /opt/distri/scripts/distri.service /etc/systemd/system
sudo mv /opt/distri/scripts/print.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable distri.service
sudo systemctl enable print.service

#######################################################
# Initial Versions
#######################################################
echo "0" > /opt/distri/version/api_version.txt
echo "0" > /opt/distri/version/app_version.txt

########################################################
# Reboot
#######################################################
sudo usermod -aG docker $USER
newgrp docker
sudo docker stop $(docker ps -a -q)
yes | docker system prune -a

########################################################
# Reboot
#######################################################
sudo reboot
