#!/bin/bash

# Script Bash pour activer ou désactiver le pare-feu 
echo "======================"
echo "Gestion des pare-feux"
echo "======================"
echo "" 

while true; do
    echo ""
    echo "--- Menu Principal ---"
    echo "1. Activer le pare-feu"
    echo "2. Désactiver le pare-feu"
    echo "3. Quitter"
    echo -n "Sélectionnez une option : "
    read choice

    case $choice in
        1)
            echo "Activation du pare-feu..."
            sudo ufw enable
            echo "Pare-feu activé."
            ;;
        2)
            echo "Désactivation du pare-feu..."
            sudo ufw disable
            echo "Pare-feu désactivé."
            ;;
        3)
            echo "Quitter."
            break
            ;;
        *)
            echo "Option invalide. Veuillez sélectionner 1, 2 ou 3."
            ;;
    esac
done

#Vérification du statut du parfeu
#sudo ufw status