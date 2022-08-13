#!/bin/bash

#variables 
network=$1
mask=$(sipcalc $network |grep '(bits)' | awk '{print $2}' FS="-")
oct1=$(echo $network | awk '{print $1}' FS=".")
oct2=$(echo $network | awk '{print $2}' FS=".")
oct3=$(echo $network | awk '{print $3}' FS=".")


# /24 networks
if [ $mask == 24 ]; then

    for i in $(seq 1 254); do
        timeout 1 bash -c "ping -c 1 $oct1.$oct2.$oct3.$i > /dev/null 2>&1" && echo "Host $oct1.$oct2.$oct3.$i - ACTIVE" &
    done


# /16 networks
elif [ $mask == 16 ]; then

    for x in $(seq 1 254); do
        for i in $(seq 1 254); do
            #echo $oct1.$oct2.$x.$i
            timeout 1 bash -c "ping -c 1 $oct1.$oct2.$x.$i > /dev/null 2>&1" && echo "Host $oct1.$oct2.$x.$i - ACTIVE" &
        done
    done


# /8 networks
elif [ $mask == 8 ]; then

    for y in $(seq 1 254); do
        for x in $(seq 1 254); do
            for i in $(seq 1 254); do
                #echo $oct1.$oct2.$x.$i
                timeout 1 bash -c "ping -c 1 $oct1.$y.$x.$i > /dev/null 2>&1" && echo "Host $oct1.$y.$x.$i - ACTIVE" &
            done
        done
    done
    
else 
    echo "use class network format ej. 192.168.0.0/24, 172.16.0.0/16, 10.0.0.0/8"
fi
