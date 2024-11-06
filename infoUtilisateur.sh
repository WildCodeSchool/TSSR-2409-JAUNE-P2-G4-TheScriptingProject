#!/bin/bash

echo "=============================="
echo "Informations utilisateurs"
echo "=============================="

# Fonction pour afficher le menu
afficher_menu() {
    echo "Menu principal - Choisissez une action :"
    echo "1) Date de dernière connexion de l'utilisateur"
    echo "2) Date de dernière modification du mot de passe"
    echo "3) Liste des sessions ouvertes par l'utilisateur"
    echo "4) Quitter"
}

# Vérifier que le nom d'utilisateur est fourni
if [ -z "$1" ]; then
    echo "Usage: $0 <nom_utilisateur>"
    exit 1
fi

UTILISATEUR="$1"

# Fonction pour vérifier si l'utilisateur existe
verifier_utilisateur() {
    if ! id "$UTILISATEUR" &>/dev/null; then
        echo "Erreur : L'utilisateur $UTILISATEUR n'existe pas."
        exit 1
    fi
}

# Appel de la fonction pour vérifier l'utilisateur
verifier_utilisateur

# Boucle principale du menu
while true; do
    afficher_menu
    read -p "Entrez votre choix (1-4) : " choix

    case $choix in
        1)
            # Utilisation de last pour obtenir la dernière connexion de l'utilisateur
            echo "Date de dernière connexion de l'utilisateur $UTILISATEUR :"
            last -n 1 "$UTILISATEUR" || echo "Aucune information de connexion disponible pour cet utilisateur."
            ;;
        2)
            # Date de dernière modification du mot de passe de l'utilisateur

            echo "Date de dernière modification du mot de passe de l'utilisateur $UTILISATEUR :"
            sudo chage -l "$UTILISATEUR" | grep "modification"
            ;;
        3)
            # Liste des sessions ouvertes par l'utilisateur
            echo "Sessions ouvertes par l'utilisateur $UTILISATEUR :"
            if ! who | grep "$UTILISATEUR"; then
                echo "Aucune session ouverte trouvée pour cet utilisateur."
            fi
            ;;
        4)
            # Quitter le script
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "Choix invalide, veuillez entrer 1, 2, 3 ou 4."
            ;;
    esac
    echo ""
done