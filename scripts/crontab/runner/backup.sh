#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`
if [ -e /home/$username/Desktop ]; then
  backup_path=/home/$username/Desktop/backup
else
  backup_path=/home/$username/Escritorio/backup
fi
rm -f $backup_path -R
mkdir $backup_path
chmod 777 $backup_path -R
echo "backup" >> $backup_path/hola.txt
