#!/bin/bash

value=""
server=`cat /etc/resolv.conf  |grep nameserver | awk -F " " '{print $2}'`
for s in $server;do
     value="$value",\""$s"\"
done
prefix=","
v=`echo ${value#*$prefix}`

printf "{\n"
printf '\t"dns":['
printf "$v"
printf "]\n"
printf "}\n"
