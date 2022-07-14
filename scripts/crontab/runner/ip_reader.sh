path=/opt/distri/docker/java
#echo "holaY" > $path/ip_meY.data
#echo "holaX" > $path/ip_meX.data
echo > $path/ip_me.data
while read p; do
	p=$(echo $p | awk '{print $2 }')
	#var=$(ifconfig | grep "$p" | awk '{print $2 }')
	var=$(ifconfig)
	echo $var >> $path/ip_me.data
	#[ -z $var ] || echo $var > $path/ip_me.data
done <$path/ip_network.data
