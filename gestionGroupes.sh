#!/bin/bash

echo "===================="
echo "Gestion des groupes"
echo "===================="
echo ""

# Ajouter un utilisateur au groupe Administrateurs
ajout_admin() {
    local utilisateur="$1"
    local groupe="sudo"  

    usermod -aG "$groupe" "$utilisateur"
    echo "L'utilisateur $utilisateur a été ajouté au groupe $groupe avec succès."
}

# Ajouter un utilisateur à un groupe local
ajout_groupe() {
    local utilisateur="$1"
    local groupe="$2"

    usermod -aG "$groupe" "$utilisateur"
    echo "L'utilisateur $utilisateur a été ajouté au groupe $groupe avec succès."
}

# Retirer un utilisateur d'un groupe local
retirer_groupe() {
    local utilisateur="$1"
    local groupe="$2"

    gpasswd -d "$utilisateur" "$groupe"
    echo "L'utilisateur $utilisateur a été retiré du groupe $groupe avec succès."
}

# Menu principal
while true; do
    echo "Choisissez une action :"
    echo "1. Ajouter un utilisateur au groupe Administrateurs"
    echo "2. Ajouter un utilisateur à un groupe local"
    echo "3. Retirer un utilisateur d'un groupe local"
    echo "4. Quitter"
    read -p "Entrez votre choix: " choix

    case $choix in
        1)
            read -p "Entrez le nom de l'utilisateur: " utilisateur
            ajout_admin "$utilisateur"
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur: " utilisateur
            read -p "Entrez le nom du groupe local: " groupe
            ajout_groupe "$utilisateur" "$groupe"
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur: " utilisateur
            read -p "Entrez le nom du groupe local: " groupe
            retirer_groupe "$utilisateur" "$groupe"
            ;;
        4)
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir une option valide."
            ;;
    esac
    echo ""
done