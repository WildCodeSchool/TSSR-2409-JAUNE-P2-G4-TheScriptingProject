#!/bin/bash

function statutPareFeux() {
    echo "Statut du pare-feux."
    sudo ufw status verbose
    read -p "Appuyer sur entrer pour revenir au menu" 
}

statutPareFeux