#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`
backup_java_path=/opt/distri/docker/java/backup/
backup_dropbox_path=/home/$username/Dropbox/Backups/

while true
do
	sleep 180
  cp $backup_java_path/* $backup_dropbox_path
done
