version=`cat /Users/juanvazquez/Dev/Distribuidora/distri/version/api_version.txt`
a=$(echo $version| cut -d'.' -f 1)
b=$(echo $version| cut -d'.' -f 2)
c=$(echo $version| cut -d'.' -f 3)
version=$a.$b.$(($c+1))
echo $version > /Users/juanvazquez/Dev/Distribuidora/distri/version/api_version.txt
