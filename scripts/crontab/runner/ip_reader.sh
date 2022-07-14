#!/bin/bash
path=/opt/distri/docker/java
echo > $path/ip_me.data
while read p; do
	p=$(echo $p | awk '{print $2 }')
	var=$(/sbin/ifconfig | grep $p | awk '{print $2 }')
	echo $var >> $path/ip_me.data
	#[ -z $var ] || echo $var > $path/ip_me.data
done <$path/ip_network.data
