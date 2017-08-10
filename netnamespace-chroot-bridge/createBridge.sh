#!/bin/bash
source config.sh
if [[ ! `brctl show | tail -n +2 | awk '{print $1}' | grep ^$bridgeName$` ]]
then
brctl addbr $bridgeName
ip addr add "$bridgeIp/$netmask" dev $bridgeName
ip link set $bridgeName up
echo "Bridge Ip address : $bridgeIp"
fi

