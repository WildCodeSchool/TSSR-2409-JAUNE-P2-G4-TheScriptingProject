#!/bin/bash

echo "======================================"
echo "Vérification des droits et permissions"
echo "======================================"

# Vérifier que le nom d'utilisateur est fourni
if [ $# -lt 1 ]; then
    echo "Usage: $0 <nom_utilisateur>"
    exit 1
fi

# Définir la variable utilisateur
utilisateur=$1

# Fonction pour afficher le menu
function Menu {
    echo "Menu principal - Choisissez une action :"
    echo "1) Vérifier les droits sur un dossier"
    echo "2) Vérifier les droits sur un fichier"
    echo "3) Quitter"
}

# Boucle principale pour afficher le menu
while true; do
    # Appeler la fonction Menu
    Menu
    read -e -p "Entrez votre choix (1-3): " choix

    case $choix in
        1)
            # Demander le chemin du dossier
            read -e -p "Entrez le chemin complet du dossier: " cheminDossier

            # Vérifier si le dossier existe
            if [ ! -d "$cheminDossier" ]; then
                echo "Erreur : Le dossier spécifié n'existe pas."
                continue
            fi

            # Afficher les permissions du dossier
            echo -n "Permissions sur le dossier : "
            ls -ld "$cheminDossier" | awk '{print $1}'
            ;;
        2)
            # Demander le chemin du fichier
            read -e -p "Entrez le chemin complet du fichier: " cheminFichier

            # Vérifier si le fichier existe
            if [ ! -f "$cheminFichier" ]; then
                echo "Erreur : Le fichier spécifié n'existe pas."
                continue
            fi

            # Afficher les permissions du fichier
            echo -n "Permissions sur le fichier : "
            ls -l "$cheminFichier" | awk '{print $1}'
            ;;
        3)
            # Quitter le script
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "Choix invalide, veuillez entrer 1, 2 ou 3."
            ;;
    esac
    echo ""
done
