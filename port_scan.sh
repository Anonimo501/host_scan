#!/bin/bash

echo ""
echo "  Ingrese una ip Ejemplo: 192.168.0.100 "
echo ""
read ip
echo ""

function ctrl_c(){
		echo -e "\n\n[!] Saliendo...\n"
		tput cnorm; exit 1
}

#Ctrl+c
trap ctrl_c INT

tput civis

for port in $(seq 1 65535); do
        timeout 1 bash -c "echo '' > /dev/tcp/$ip/$port" 2>/dev/null && echo "[+] Port $port - OPEN" &
done; wait

tput cnorm
