#!/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
lightBlueColour="\e[94m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;90m\033[1m"



echo ""
echo -e "\e[31m	Ingrese 3 octetos de la ip de (Red) \e[0m - \e[33m Ejemplo: 192.168.0 \e[0m"
echo ""
read ip
echo ""

echo ""
echo -e "\e[31m Ingrese la velocidad del escaneo \e[0m - \e[33m Ejemplo: 1 -> (4.23m) - 0.5 -> (2.11m)- 0.1 -> (32sg)\e[0m"
echo ""
read vel
echo ""

echo -e "${redColour}[*] OS based on TTL${endColour}"
echo ""

for i in $(seq 1 254); do
	timeout $vel bash -c "ping -c 1 $ip.$i" &> /dev/null && echo -e "\e[33m[+] Host $ip.$i - ACTIVE\e[0m" &

#if [ -z $1 ]
if [ -z $ip.$i ]
then
    echo -e "${redColour}[*] Syntax: IP address${endColour}"
    exit 1
fi

SECONDS=0

#echo -e "${redColour}[*] OS based on TTL${endColour}"

ttl=$(timeout $vel ping -c 1 $ip.$i | head -2 | tail -1 | cut -d " " -f6 | tr -d "ttl=")

if [ -z $ttl ]
then
    echo -e "\e[34m Couldn't reach the host \e[0m" :$i #&> /dev/null
elif [[ $ttl -ge 33 && $ttl -le 64 ]]
then
        echo -e "\e[33m[OS] Linux : $i\e[0m"
elif [[ $ttl -ge 65 && $ttl -le 128 ]]
then
    echo -e "\e[33m[OS] Windows : $i\e[0m"
elif [[ $ttl -ge 129 && $ttl -le 255 ]]
then
    echo -e "\e[33m[OS] Cisco : $i\e[0m"
else
    echo "Unknown OS" :$i
fi

ttl_time=$SECONDS

if [ -z $ttl_time ]
then
    $ttl_time=0
fi


done; wait
