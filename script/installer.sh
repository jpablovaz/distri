#!/bin/bash

#######################################################
# DOCKER
#######################################################
sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt  install docker.io
docker stop $(docker ps -a -q)
sudo usermod -aG docker $USER
newgrp docker
yes | docker system prune -a

#######################################################
# FILE TREE
#######################################################
sudo rm /opt/distri -R
sudo mkdir /opt/distri
sudo chmod 777 /opt/distri -R
mkdir /opt/distri/java
mkdir /opt/distri/node
mkdir /opt/distri/postgres
mkdir /opt/distri/backups
mkdir /opt/distri/cache
mkdir /opt/distri/scripts

#######################################################
# BOOT SERVICE SH
#######################################################
cat <<EOT >> /opt/distri/scripts/service.sh
mkdir $HOME/Desktop/HEY
EOT

sudo chmod +x /opt/distri/scripts/service.sh

sudo cat <<EOT >> /etc/systemd/system/distri.service
[Unit]
Description=Distri Boot

[Service]
ExecStart=/opt/distri/scripts/service.sh start

WantedBy=multi-user.target
[Install]
EOT

sudo systemctl enable distri.service

#######################################################
# Download source code
#######################################################
git clone https://github.com/jpablovaz/distri-api.git /opt/distri

#######################################################
# Dockerfile Java Builder
#######################################################
cat <<EOT >> /opt/distri/java/Dockerfile
FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
COPY . .
CMD ["java", "-jar", "/api.jar"]
EOT

#######################################################
# docker-compose.yml
#######################################################
cat <<EOT >> ~/.distri/docker-compose.yml
version: '3'
services:
  java:
    build:
      /java 
    depends_on:
      - postgres
  postgres:
    image: postgres:13.0-alpine
      environment:
        POSTGRES_USER: distri
        POSTGRES_DB: distri
        POSTGRES_PASSWORD: distri
      ports:
        - 5433:5432
      volumes:
        - ./postgres:/var/lib/postgresql/data
      restart: unless-stopped
EOT
cd ~/.distri-mza/
docker-compose build up
yes | docker system prune
#alias dm-disk='docker run --rm -it -v /:/docker alpine:edge $@' 
#dm-disk ls -l /docker/var/lib/docker/volumes/maven-m2-root/_data
