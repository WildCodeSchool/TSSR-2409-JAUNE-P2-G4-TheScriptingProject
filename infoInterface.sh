#!/bin/bash

echo "===================================="
echo "Informations sur l'ordinateur client"
echo "===================================="

# Nombre d'interfaces réseau actives
echo "Nombre d'interfaces réseau actives :"
num_interfaces=$(ip link show | grep -c "state UP")
echo "$num_interfaces interfaces actives détectées"

# Adresse IP de chaque interface
echo "Adresse IP de chaque interface :"
ip -o -4 addr show | while read -r line; do
    interface=$(echo "$line" | awk '{print $2}')
    ip_address=$(echo "$line" | awk '{print $4}')
    echo "- Interface $interface : IP $ip_address"
done

# Adresse MAC de chaque interface
echo "Adresse MAC de chaque interface :"
ip link show | grep "link/ether" | while read -r line; do
    interface=$(echo "$line" | awk '{print $2}')
    mac_address=$(echo "$line" | awk '{print $2}')
    echo "- Interface $interface : MAC $mac_address"
done

echo "=============================="