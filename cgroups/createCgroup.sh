#!/bin/bash
source config.sh
if [ "$1" == "" ]; then
    echo "enter param"
    exit
fi

cgroupSuffix=`cat suffix`
cgroupName=$cgroupName$cgroupSuffix
cgcreate -g cpu,memory:$cgroupName
cgset -r memory.limit_in_bytes=${maxRamAllowed}M testscript
shares=`perl -E "say int($cpuSharesOnContentionPercentage/100*$baseSharesValue)"`
cgset -r cpu.shares=$shares $cgroupName
cfsQuota=`perl -E "say int($cpuUtilPercentage/100*$defaultCFSPeriod)"`
cgset -r cpu.cfs_period_us=$defaultCFSPeriod $cgroupName
cgset -r cpu.cfs_quota_us=$cfsQuota $cgroupName
cgroupSuffix=$(( $cgroupSuffix + 1 ))
echo $cgroupSuffix > suffix
cgexec -g cpu,memory:$cgroupName $PWD/$1 &
disown
