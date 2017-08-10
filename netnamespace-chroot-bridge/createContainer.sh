#!/bin/bash
source config.sh
if [ "$1" == "" ]; then
    echo "enter param"
    exit
fi
if [[ ! `brctl show | tail -n +2 | awk '{print $1}' | grep ^$bridgeName$` ]]
then
echo "Create bridge before running"
exit
fi


allottedIp=`./generateip.sh`

vethGlobalName=global$1
vethNamespaceName=ns$1
namespaceName=namespace$1
ip link add dev $vethGlobalName type veth peer name $vethNamespaceName
#ip addr add 192.168.100.1/25 dev br0
#ip link set br0 up
ip netns add $namespaceName
ip link set $vethNamespaceName netns $namespaceName
ip netns exec $namespaceName ip link set dev lo up
ip netns exec $namespaceName ip addr add "$allottedIp/$netmask" dev $vethNamespaceName
ip netns exec $namespaceName ip link set  $vethNamespaceName up
brctl addif $bridgeName $vethGlobalName
ip link set  $vethGlobalName up
sudo nohup unshare -f -p -n  ip netns exec $namespaceName chroot /home/ubuntu/rootfs '/launchnginx.sh' &
disown
echo "Container private ip : $allottedIp"




