#######################################################
# PRINTING OBSERVER
#######################################################
username=`cat /opt/distri/scripts/user.txt`
java_path=/opt/distri/docker/java/pdf/
desktop_path=/home/$username/Escritorio/Distribuidora/

sleep 1

rm $java_path -R
mkdir $java_path
rm $desktop_path -R
mkdir $desktop_path

while true
do
	sleep 4
	for f in $(find $java_path -type f -name \*) ; do
		f="$(basename -- $f)"
		c1=`echo $f | cut -b 1-1`
		c2=`echo $f | cut -b 2-2`
		c3=`echo $f | cut -b 3-100`
		if [ $c1 = '@' ]; then
			if [ $c2 = 'C' ] || [ $c2 = 'B' ]; then
				cp $java_path$f $desktop_path$c4
			fi
			if [ $c2 = 'P' ] || [ $c2 = 'B' ]; then
				lp $java_path$f
			fi
			rm $java_path$f
		fi
	done
done
