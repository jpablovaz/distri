#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`

java_path=/opt/distri/docker/java/pdf/
if [ -e /home/$username/Desktop ]; then
  pdf_doc_path=/home/$username/Desktop/Comprobantes/
  list_path=/home/$username/Desktop/Listas/
else
  pdf_doc_path=/home/$username/Escritorio/Comprobantes/
  list_path=/home/$username/Escritorio/Listas/
fi

# JAVA
rm -f $java_path -R
mkdir $java_path
chmod 777 $java_path -R

# DOCUMENTS
rm -f $pdf_doc_path -R
mkdir $pdf_doc_path
chmod 777 $pdf_doc_path -R

# LIST ROOT
rm -f $list_path -R
mkdir $list_path
chmod 777 $list_path -R

# LIST FOLDER 1..12
n=0
while [ $n -lt 12 ]; do
    n=$(( n + 1 ))
	[ $n -lt 10 ] && folder=0$n || folder=$n
	rm -f $list_path$folder -R
	mkdir $list_path$folder
	chmod 777 $list_path$folder -R
done

while true
do
	sleep 3
	for f in $(find $java_path -type f -name \*) ; do
		f="$(basename -- $f)"
		at=`echo $f | cut -b 1-1`
		p1=`echo $f | cut -b 2-2`
		p2=`echo $f | cut -b 3-3`
		num=`echo $f | cut -b 2-3`
		name=`echo $f | cut -b 4-100`
		if [ $at = '@' ]; then
			cp $java_path$f $pdf_doc_path$name
			if [ $p1 = '1' ]; then
				lp $java_path$f
			fi
			if [ $p2 = '1' ]; then
				lp $java_path$f
			fi
			rm -f $java_path$f
			chmod 777 $pdf_doc_path$name
		elif [ $at = '&' ]; then
			cp $java_path$f $list_path$num/$name
			rm -f $java_path$f
			chmod 777 $list_path$num/$name
		fi
	done
done
