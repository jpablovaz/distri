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
	pre=a$n
	if [ $n -lt 10 ]; then  pre=b$n; fi

	rm -f $pdf_list_path$pre -R
	mkdir $pdf_list_path$pre
	chmod 777 $pdf_list_path$pre -R

	rm -f $csv_list_path$pre -R
	mkdir $csv_list_path$pre
	chmod 777 $csv_list_path$pre -R

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
		nu=`echo $f | cut -b 3-4`
		name=`echo $f | cut -b 5-100`
		if [ $at = '@' ]; then
			if [ $pdf = '1' ]; then
				cp $java_path$f $pdf_doc_path$name
			fi
			if [ $p1 = '1' ]; then
				lp $java_path$f
			fi
			if [ $p2 = '1' ]; then
				lp $java_path$f
			fi
			rm -f $java_path$f
			chmod 777 $pdf_doc_path$name
		elif [ $at = 'p' ]; then
			cp $java_path$f $pdf_list_path$nu/$name
			rm -f $java_path$f
			chmod 777 $pdf_list_path$nu/$name
		elif [ $at = 'c' ]; then
			cp $java_path$f $csv_list_path$nu/$name
			rm -f $java_path$f
			chmod 777 $csv_list_path$nu/$name
		fi
	done
done
