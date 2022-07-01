echo ifconfig | grep 172.17.0.1\ | awk '{print $2 }' > ip.data
