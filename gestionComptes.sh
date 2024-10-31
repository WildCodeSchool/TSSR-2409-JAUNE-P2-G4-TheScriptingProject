#!/bin/bash

# Fonction pour vérifier l'appartenance d'un utilisateur à un groupe
verifier_membre() {
    local utilisateur="$1"
    local groupe="$2"
    if id -nG "$utilisateur" | grep -qw "$groupe"; then
        return 0  # Utilisateur est membre du groupe
    else
        return 1  # Utilisateur n'est pas membre du groupe
    fi
}

# Fonction pour ajouter un utilisateur au groupe sudo
creer_utilisateur_groupe_admin() {
    local utilisateur="$1"
    local groupe="sudo"

    if verifier_membre "$utilisateur" "$groupe"; then
        echo "L'utilisateur est déjà membre du groupe sudo (administrateurs)."
    else
        read -p "Voulez-vous ajouter l'utilisateur au groupe sudo ? (oui/non): " confirmation
        if [[ "$confirmation" == "oui" ]]; then
            sudo usermod -aG "$groupe" "$utilisateur"
            echo "Utilisateur ajouté au groupe sudo avec succès."
        else
            echo "Ajout annulé."
        fi
    fi
}

# Fonction pour vérifier si un groupe existe
groupe_existe() {
    local groupe="$1"
    if getent group "$groupe" > /dev/null 2>&1; then
        return 0  # Groupe existe
    else
        return 1  # Groupe n'existe pas
    fi
}

# Fonction pour ajouter un utilisateur à un groupe local avec confirmation
creer_utilisateur_groupe_local() {
    local utilisateur="$1"
    read -p "Entrez le nom du groupe local : " groupe

    # Vérifier si le groupe existe, sinon le créer
    if ! groupe_existe "$groupe"; then
        echo "Le groupe $groupe n'existe pas."
        read -p "Voulez-vous créer le groupe $groupe ? (oui/non): " confirmation_creation
        if [[ "$confirmation_creation" == "oui" ]]; then
            sudo groupadd "$groupe"
            echo "Groupe $groupe créé avec succès."
        else
            echo "Création du groupe annulée."
            return
        fi
    fi

    # Ajouter l'utilisateur au groupe après confirmation
    if verifier_membre "$utilisateur" "$groupe"; then
        echo "L'utilisateur est déjà membre du groupe $groupe."
    else
        read -p "Voulez-vous ajouter l'utilisateur au groupe $groupe ? (oui/non): " confirmation
        if [[ "$confirmation" == "oui" ]]; then
            sudo usermod -aG "$groupe" "$utilisateur"
            echo "Utilisateur ajouté au groupe $groupe avec succès."
        else
            echo "Ajout annulé."
        fi
    fi
}

# Fonction pour retirer un utilisateur d'un groupe local
retirer_utilisateur_du_groupe_local() {
    local utilisateur="$1"
    read -p "Entrez le nom du groupe local : " groupe

    if verifier_membre "$utilisateur" "$groupe"; then
        read -p "Voulez-vous retirer l'utilisateur du groupe $groupe ? (oui/non): " confirmation
        if [[ "$confirmation" == "oui" ]]; then
            sudo gpasswd -d "$utilisateur" "$groupe"
            echo "Utilisateur retiré du groupe $groupe avec succès."
        else
            echo "Retrait annulé."
        fi
    else
        echo "L'utilisateur n'est pas membre du groupe $groupe."
    fi
}

# Menu principal pour choisir l'action
while true; do
    echo "Choisissez une action :"
    echo "1. Ajouter un utilisateur au groupe sudo (administration)"
    echo "2. Ajouter un utilisateur au groupe local"
    echo "3. Retirer un utilisateur du groupe local"
    echo "4. Quitter"
    read -p "Entrez votre choix : " choix

    case $choix in
        1)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            creer_utilisateur_groupe_admin "$utilisateur"
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            creer_utilisateur_groupe_local "$utilisateur"
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            retirer_utilisateur_du_groupe_local "$utilisateur"
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