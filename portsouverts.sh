#!/bin/bash

function portsOuverts() {
    echo "Les ports ouverts sur le système sont:"
    ss -tulnp | grep LISTEN | awk '{print $5}' | cut -d ':' -f2 | sort -u
    echo "================================="
    read -p "Appuyer sur entrer pour revenir au menu" 
}

portsOuverts

