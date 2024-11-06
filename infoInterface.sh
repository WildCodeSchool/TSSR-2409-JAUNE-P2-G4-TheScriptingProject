
#!/bin/bash

echo "=============================="
echo "Informations sur l'ordinateur client"
echo "=============================="

# Nombre d'interfaces réseau actives
echo "Nombre d'interfaces réseau actives :"
num_interfaces=$(netsh interface show interface | grep -c "Connecté")
echo "$num_interfaces interfaces actives détectées"

# Adresse IP de chaque interface
echo "Adresse IP de chaque interface :"
ipconfig | grep "Adaptateur" | while read -r line; do
    interface=$(echo "$line" | sed 's/Adaptateur //; s/://')
    ip_address=$(ipconfig | grep -A10 "$line" | grep "Adresse IPv4" | awk '{print $NF}')
    if [[ -n $ip_address ]]; then
        echo "- Interface $interface : IP $ip_address"
    else
        echo "- Interface $interface : Pas d'adresse IP assignée"
    fi
done

# Adresse MAC de chaque interface
echo "Adresse MAC de chaque interface :"
ipconfig /all | grep "Carte Ethernet" | while read -r line; do
    interface=$(echo "$line" | sed 's/Carte Ethernet //; s/://')
    mac_address=$(ipconfig /all | grep -A7 "$line" | grep "Adresse physique" | awk '{print $NF}')
    if [[ -n $mac_address ]]; then
        echo "- Interface $interface : MAC $mac_address"
    else
        echo "- Interface $interface : Pas d'adresse MAC disponible"
    fi
done

echo "=============================="