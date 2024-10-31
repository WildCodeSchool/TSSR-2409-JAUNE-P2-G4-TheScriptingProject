#!/bin/bash

# Fonction pour vérifier si un utilisateur existe
utilisateur_existe() {
    local utilisateur="$1"
    id "$utilisateur" &>/dev/null
}

# Fonction pour vérifier si un groupe existe
groupe_existe() {
    local groupe="$1"
    getent group "$groupe" > /dev/null 2>&1
}

# Fonction pour vérifier l'appartenance d'un utilisateur à un groupe
verifier_membre() {
    local utilisateur="$1"
    local groupe="$2"
    id -nG "$utilisateur" | grep -qw "$groupe"
}

# Fonction pour créer un utilisateur si nécessaire
creer_utilisateur_si_inexistant() {
    local utilisateur="$1"
    if ! utilisateur_existe "$utilisateur"; then
        echo "L'utilisateur $utilisateur n'existe pas. Création de l'utilisateur..."
        sudo adduser "$utilisateur"
    fi
}

# Fonction pour ajouter un utilisateur à n'importe quel groupe, en créant le groupe et l'utilisateur si nécessaire
ajouter_utilisateur_groupe() {
    local utilisateur="$1"
    local groupe="$2"

    # Créer l'utilisateur s'il n'existe pas
    creer_utilisateur_si_inexistant "$utilisateur"

    # Créer le groupe s'il n'existe pas
    if ! groupe_existe "$groupe"; then
        echo "Le groupe $groupe n'existe pas. Création du groupe..."
        sudo groupadd "$groupe"
        echo "Groupe $groupe créé avec succès."
    fi

    # Ajouter l'utilisateur au groupe s'il n'est pas déjà membre
    if verifier_membre "$utilisateur" "$groupe"; then
        echo "L'utilisateur est déjà membre du groupe $groupe."
    else
        read -p "Voulez-vous ajouter l'utilisateur au groupe $groupe ? (Oui/Non): " confirmation
        if [[ "$confirmation" == "Oui" ]]; then
            sudo usermod -aG "$groupe" "$utilisateur"
            echo "Utilisateur ajouté au groupe $groupe avec succès."
        else
            echo "Ajout annulé."
        fi
    fi
}

# Menu principal pour choisir l'action
while true; do
    echo "Choisissez une action :"
    echo "1. Ajouter un utilisateur à un groupe"
    echo "2. Quitter"
    read -p "Entrez votre choix : " choix

    case $choix in
        1)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            read -p "Entrez le nom du groupe : " groupe
            ajouter_utilisateur_groupe "$utilisateur" "$groupe"
            ;;
        2)
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir une option valide."
            ;;
    esac
    echo
done