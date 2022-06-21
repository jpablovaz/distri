username=`cat /opt/distri/scripts/user.txt`
desktop_path=/home/$username/Escritorio/once
rm -f $desktop_path -R
mkdir $desktop_path
chmod 777 $desktop_path -R
echo "hola la" >> $desktop_path/hola.txt
