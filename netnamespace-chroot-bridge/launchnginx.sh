#!/bin/sh
mount -t proc proc /proc
mknod /dev/null c 1 3
mknod /dev/random c 1 3
mknod /dev/urandom c 1 3
nginx &
while true
do
sleep 10000
done
