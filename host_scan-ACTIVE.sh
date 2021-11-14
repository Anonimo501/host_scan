#!/bin/bash

echo ""
echo "	Ingrese 3 octetos de la ip - Ejemplo: 192.168.0 "
echo ""
read ip
echo ""

for i in $(seq 1 254); do
	timeout 1 bash -c "ping -c 1 $ip.$i" &> /dev/null && echo "[+] Host $ip.$i - ACTIVE" &
done; wait
