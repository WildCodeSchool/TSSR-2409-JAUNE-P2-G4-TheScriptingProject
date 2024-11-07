#!/bin/bash

echo "===================================="
echo "Informations sur l'ordinateur client"
echo "===================================="
echo "" 

# Nombre d'interfaces réseau actives
echo "Nombre d'interfaces réseau actives :"
num_interfaces=$(ip link show | grep -c "state UP")
echo "- $num_interfaces interfaces actives détectées"
echo "" 
# Adresse IP de chaque interface
echo "Adresse IP de chaque interface :"
ip -o -4 addr show | while read -r line; do
    interface=$(echo "$line" | awk '{print $2}')
    ip_address=$(echo "$line" | awk '{print $4}')
    echo "- Interface $interface : IP $ip_address"
done
echo "" 
# Adresse MAC de chaque interface
echo "Adresse MAC de chaque interface :"
for interface in $(ip -o link show | awk -F': ' '{print $2}'); do
    mac_address=$(ip link show "$interface" | awk '/link\/ether/ {print $2}')
    if [[ -n $mac_address ]]; then
        echo "- Interface $interface : MAC $mac_address"
    fi
done
echo "===================================="