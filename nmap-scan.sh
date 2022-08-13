#!/bin/bash

ip_address=$1

#fast scan
nmap -sS --min-rate 5000 -p- --open -n -Pn  $ip_address -oG /tmp/allPorts

#getting the ports
allPorts=$(cat /tmp/allPorts | grep -oP '\d{1,5}/open' | awk '{print $1}' FS="/" | xargs | tr ' ' ',' | tr -d '\n')

#detailed scan
[ -z "$allPorts" ] && echo "No ports detected" || nmap -sC -sV -p $allPorts -vvv -Pn $ip_address -oN nmap.txt

#cleaning
rm /tmp/allPorts
