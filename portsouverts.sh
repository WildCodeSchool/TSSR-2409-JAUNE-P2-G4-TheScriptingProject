#!/bin/bash

function portsOuverts() {
    echo "Les ports ouverts sur le système sont:"
    ss -tulnp | grep LISTEN | awk '{print $5}' | cut -d ':' -f2 | sort -u
}

function retour () {
    echo "Retour au menu précédant choix 1"
    echo "Retour au menu principal choix 2"
    read  -p "Faite votre selection (1/2) :" selectRet
        if [ "$selectRet" -eq 1 ]
        then
            echo return
        else
            echo menu1
        fi     
}


portsOuverts
echo "================================="
retour
