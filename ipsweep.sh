#!/bin/bash

ifconfig | grep inet | cut -d " " -f 10 | tr -d "  " > iprm.txt && head -1 iprm.txt > ip.txt && rm iprm.txt | cat ip.txt | cut -f1-3 -d"." > ipa.txt
rm -f localip.txt
address=`cat ipa.txt`
myip=`cat ip.txt`
echo "Your IP is `cat ip.txt`"
for ip in $(seq 254) ; do

	ping -c 1 $address.${ip} | grep "64 bytes" | cut -d " " -f 4 | tr -d ":"  >> local.txt &

done
sort local.txt ip.txt | uniq -u > localip.txt
cat localip.txt
rm ipa.txt
rm local.txt
rm ip.txt
echo "Saved IP's to localip.txt"
