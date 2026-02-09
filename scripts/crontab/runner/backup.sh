#!/bin/bash
#---------------------------------------------------
DAY_OF_THE_WEEK=$(date +%A)
DAY_OF_THE_MONTH=$(date +%F)
#---------------------------------------------------
username=`cat /opt/distri/scripts/user.txt`
backup_java_path=/opt/distri/docker/java/backup/
backup_dropbox_path=/home/$username/Dropbox/Backups/$DAY_OF_THE_WEEK
backup_desktop_path=/home/$username/Escritorio/Backups/up-$DAY_OF_THE_MONTH
mkdir -p $backup_java_path
mkdir -p $backup_dropbox_path
mkdir -p $backup_desktop_path
#---------------------------------------------------
while true
do
  sleep 100
  if [ -f $backup_java_path/delete.txt ]; then
    rm $backup_java_path/delete.txt
    rm $backup_dropbox_path/* -f
    rm $backup_desktop_path/* -f
  fi
  #cp -R -u -p $backup_java_path/* $backup_dropbox_path
  cp -R -u $backup_java_path/* $backup_dropbox_path
  cp -R -u $backup_java_path/* $backup_desktop_path
done
