#!/bin/bash
username=`cat /opt/distri/scripts/user.txt`

java_path=/opt/distri/docker/java/pdf/
pdf_doc_path=/home/$username/Escritorio/Documentos_PDF/
list_path=/home/$username/Escritorio/Listas/
pdf_list_path=/home/$username/Escritorio/Listas/PDF/
csv_list_path=/home/$username/Escritorio/Listas/CSV/

rm -f $java_path -R
mkdir $java_path

rm -f $pdf_doc_path -R
mkdir $pdf_doc_path

rm -f $list_path -R
mkdir $list_path

rm -f $pdf_list_path -R
mkdir $pdf_list_path

rm -f $csv_list_path -R
mkdir $csv_list_path

chmod 777 $java_path -R
chmod 777 $pdf_doc_path -R
chmod 777 $list_path -R
chmod 777 $pdf_list_path -R
chmod 777 $csv_list_path -R

n=0
while [ "$n" -lt 12 ] && [ ! -e filename ]; do
    n=$(( n + 1 ))
	rm -f $pdf_list_path$n -R
	mkdir $pdf_list_path$n
	chmod 777 $pdf_list_path$n -R
	rm -f $csv_list_path$n -R
	mkdir $csv_list_path$n
	chmod 777 $csv_list_path$n -R
done


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
