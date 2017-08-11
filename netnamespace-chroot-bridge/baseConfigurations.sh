#!/bin/bash
source config.sh
ip=`echo $ipAddressBlock | grep -oP '.*?(?=/)'`
mask=`echo $ipAddressBlock | grep -oP '(?<=/).*'`
relBytes=$(( $mask / 8 ))
regExBytes=$(( $relBytes - 1 ))
nwPartBytes=$(( 4 - $relBytes ))
nwPartBytesRegex=$(( $nwPartBytes - 1 ))
nwPart=`echo $ipAddressBlock | grep -oP "^(\d{1,3}\.){$regExBytes}\d{1,3}"`
echo "networkPart=$nwPart" >> config.sh
bridgeIp=`echo $ipAddressBlock | grep -oP '.*?(?=/)'`
echo "bridgeIp=$bridgeIp" >> config.sh
echo "netmask=$mask" >> config.sh
bytes=0
startingHostPart=
endVal=$(( $relBytes + 1 ))
for bytes in $(eval echo "{4..$endVal}")
do
byte=`echo $ip | awk -F. -v bytepos=$bytes '{print $bytepos}'`
if [[ $bytes -eq 4 ]]
then
byte=$(( $byte + 1 ))
fi
startingHostPart=$byte" "$startingHostPart
done
echo $startingHostPart
echo $startingHostPart > file

