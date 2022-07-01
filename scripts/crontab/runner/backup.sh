#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`
backup_path=/home/$username/Escritorio/backup
rm -f $backup_path -R
mkdir $backup_path
chmod 777 $backup_path -R
echo "backup" >> $backup_path/hola.txt
