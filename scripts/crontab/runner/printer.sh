#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`
java_path=/opt/distri/docker/java/pdf/
desktop_path=/home/$username/Escritorio/Distribuidora/
rm -f $java_path -R
mkdir $java_path
rm -f $desktop_path -R
mkdir $desktop_path
chmod 777 $java_path -R
chmod 777 $desktop_path -R
while true
do
	sleep 5
	for f in $(find $java_path -type f -name \*) ; do
		f="$(basename -- $f)"
		at=`echo $f | cut -b 1-1`
		pdf=`echo $f | cut -b 2-2`
		p1=`echo $f | cut -b 3-3`
		p2=`echo $f | cut -b 4-4`
		name=`echo $f | cut -b 5-100`
		if [ $at = '@' ]; then
			if [ $pdf = '1' ]; then
				cp $java_path$f $desktop_path$name
			fi
			if [ $p1 = '1' ]; then
				lp $java_path$f
			fi
			if [ $p2 = '1' ]; then
				lp $java_path$f
			fi
			rm -f $java_path$f
			chmod 777 $desktop_path$name
		fi
	done
done
