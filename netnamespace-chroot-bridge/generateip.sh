#!/bin/bash
source config.sh
ip=`cat file | awk '{a=NF;
while(a > 0)
{
if($a == 255){$a=0}else{$a++;break;};a--;
};print $0;
}'`
echo $ip > file
hostPart=`echo $ip  | sed 's/  */\./g'`
echo $hostPart
allotedIp=$networkPart"."$hostPart
echo $allotedIp



