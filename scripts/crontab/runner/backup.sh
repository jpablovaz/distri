#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`
backup_java_path=/opt/distri/docker/java/backup/
backup_dropbox_path=/home/$username/Dropbox/Backs/
while true
do
	sleep 100
  if [ -f $backup_java_path/delete.txt ]; then
    rm $backup_java_path/delete.txt
    rm $backup_dropbox_path/* -f
  fi
  cp -R -u -p $backup_java_path/* $backup_dropbox_path
done
