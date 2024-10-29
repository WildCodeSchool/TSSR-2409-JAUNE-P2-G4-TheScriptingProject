#!/bin/bash

# Menu principal pour choisir l'action
while true; do
    echo "Choisissez une action :"
    echo "1. Ajouter un utilisateur à un groupe d'administration"
    echo "2. Ajouter un utilisateur à un groupe local"
    echo "3. Retirer un utilisateur d'un groupe local"
    echo "4. Quitter"
    read -p "Entrez votre choix : " choix

    case $choix in
        1)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            ajouter_a_groupe_admin "$utilisateur"
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            read -p "Entrez le nom du groupe local : " groupe
            ajouter_a_groupe_local "$utilisateur" "$groupe"
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            read -p "Entrez le nom du groupe local : " groupe
            sortir_de_groupe_local "$utilisateur" "$groupe"
            ;;
        4)
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir une option valide."
            ;;
    esac
    echo
done

# Fonction pour ajouter un utilisateur à un groupe d'administration
ajouter_a_groupe_admin() {
    local utilisateur=$1
    local groupe="admin"  # Spécifiez le groupe d'administration ici

    if id "$utilisateur" &>/dev/null; then
        if id -nG "$utilisateur" | grep -qw "$groupe"; then
            echo "L'utilisateur $utilisateur est déjà dans le groupe d'administration $groupe."
        else
            sudo usermod -aG "$groupe" "$utilisateur"
            echo "L'utilisateur $utilisateur a été ajouté au groupe d'administration $groupe."
        fi
    else
        echo "L'utilisateur $utilisateur n'existe pas."
    fi
}

# Fonction pour ajouter un utilisateur à un groupe local
ajouter_a_groupe_local() {
    local utilisateur=$1
    local groupe=$2

    if id "$utilisateur" &>/dev/null; then
        if id -nG "$utilisateur" | grep -qw "$groupe"; then
            echo "L'utilisateur $utilisateur est déjà dans le groupe local $groupe."
        else
            sudo usermod -aG "$groupe" "$utilisateur"
            echo "L'utilisateur $utilisateur a été ajouté au groupe local $groupe."
        fi
    else
        echo "L'utilisateur $utilisateur n'existe pas."
    fi
}

# Fonction pour retirer un utilisateur d'un groupe local
sortir_de_groupe_local() {
    local utilisateur=$1
    local groupe=$2

    if id "$utilisateur" &>/dev/null; then
        if id -nG "$utilisateur" | grep -qw "$groupe"; then
            sudo gpasswd -d "$utilisateur" "$groupe"
            echo "L'utilisateur $utilisateur a été retiré du groupe local $groupe."
        else
            echo "L'utilisateur $utilisateur n'est pas dans le groupe local $groupe."
        fi
    else
        echo "L'utilisateur $utilisateur n'existe pas."
    fi
}