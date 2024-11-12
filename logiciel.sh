#!/bin/bash

echo "================="
echo "Gestion logiciel"
echo "================="

# Fonction d'installation de logiciel
installer_logiciel() {
    echo "Installation du logiciel $1..."
    sudo apt-get install -y "$1"
    echo "Installation de $1 terminée."
}

# Fonction de désinstallation de logiciel
desinstaller_logiciel() {
    echo "Désinstallation du logiciel $1..."
    sudo apt-get remove -y "$1"
    echo "Suppression complète de $1..."
    sudo apt-get purge -y "$1"
    echo "Suppression des paquets inutilisés..."
    sudo apt-get autoremove -y
    echo "Désinstallation de $1 terminée."
}

# Fonction pour exécuter un script bash sur une machine distante
executer_script_distant() {
    local machine_distante=$1
    local chemin_script=$2

    echo "Copie du script vers la machine distante..."
    scp "$chemin_script" "$machine_distante:~/script_temp.sh"
    echo "Exécution du script sur la machine distante..."
    ssh "$machine_distante" 'bash ~/script_temp.sh'
    echo "Script exécuté sur la machine distante."
}

# Menu pour l'utilisateur
echo "Sélectionnez une option :"
echo "1. Installer un logiciel"
echo "2. Désinstaller un logiciel"
echo "3. Exécuter un script sur une machine distante"
read -p "Votre choix : " choix

case $choix in
    1)
        read -p "Entrez le nom du logiciel à installer : " logiciel
        installer_logiciel "$logiciel"
        ;;
    2)
        read -p "Entrez le nom du logiciel à désinstaller : " logiciel
        desinstaller_logiciel "$logiciel"
        ;;
    3)
        read -p "Entrez l'adresse de la machine distante (ex : user@host) : " machine_distante
        read -p "Entrez le chemin du script local à exécuter sur la machine distante : " chemin_script
        executer_script_distant "$machine_distante" "$chemin_script"
        ;;
    *)
        echo "Option invalide. Veuillez réessayer."
        ;;
esac