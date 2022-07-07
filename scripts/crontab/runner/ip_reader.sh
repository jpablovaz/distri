path=/opt/distri/docker/java
while read p; do
	p=$(echo $p | awk '{print $2 }')
	var=$(ifconfig | grep "$p" | awk '{print $2 }')
	[ -z $var ] || echo $var > $path/ip_me.data
done <$path/ip_network.data
