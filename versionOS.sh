#!/bin/bash

function versionOS() {
    version=$(cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d'"' -f2)
    echo "Votre système d'exploitation est: $version"
    echo "Choix 1: Retour menu précédant"
    echo "Choix 2: Retour menu principal"
    read -p "Quel est votre choix (1/2)" choix
    case $choix in 
    1)
        return
    ;;
    2) 
        menu1
    ;;
    *)
        echo "Commande inconnue! Retour menu principal!"
        menu1
    ;;
    esac 
}