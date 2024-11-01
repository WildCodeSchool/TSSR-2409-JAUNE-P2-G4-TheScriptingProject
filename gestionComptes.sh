#!/bin/bash

# Fonction pour créer un utilisateur s'il n'existe pas
creer_utilisateur() {
    local nom_utilisateur=$1

    # Création de l'utilisateur si nécessaire
    if ! id "$nom_utilisateur" &>/dev/null; then
        echo "L'utilisateur $nom_utilisateur n'existe pas. Création en cours..."
        adduser --quiet "$nom_utilisateur"
        if [ $? -eq 0 ]; then
            echo "Utilisateur $nom_utilisateur créé avec succès."
        else
            echo "Erreur lors de la création de l'utilisateur $nom_utilisateur."
            return 1
        fi
    else
        echo "L'utilisateur $nom_utilisateur existe déjà."
    fi
}

# Fonction pour vérifier et créer un groupe s'il n'existe pas
creer_groupe_si_non_existant() {
    local groupe=$1
    if ! getent group "$groupe" &>/dev/null; then
        echo "Le groupe $groupe n'existe pas. Création en cours..."
        groupadd "$groupe"
        if [ $? -eq 0 ]; then
            echo "Groupe $groupe créé avec succès."
        else
            echo "Erreur lors de la création du groupe $groupe."
            return 1
        fi
    else
        echo "Le groupe $groupe existe déjà."
    fi
}

# Fonction pour ajouter un utilisateur au groupe d'administration (sudo)
creer_utilisateur_groupe_admin() {
    local nom_utilisateur=$1
    local groupe_admin="sudo"

    # Assurer que l'utilisateur est créé
    creer_utilisateur "$nom_utilisateur" || return

    # Assurer que le groupe sudo existe
    creer_groupe_si_non_existant "$groupe_admin" || return

    # Ajout de l'utilisateur au groupe sudo
    if id -nG "$nom_utilisateur" | grep -qw "$groupe_admin"; then
        echo "L'utilisateur est déjà membre du groupe d'administration."
    else
        echo "Ajout de $nom_utilisateur au groupe d'administration ($groupe_admin)..."
        usermod -aG "$groupe_admin" "$nom_utilisateur"
        if [ $? -eq 0 ]; then
            echo "Utilisateur ajouté au groupe d'administration avec succès."
        else
            echo "Erreur lors de l'ajout de l'utilisateur au groupe d'administration."
        fi
    fi
}

# Fonction pour ajouter un utilisateur à un groupe local
creer_utilisateur_groupe_local() {
    local nom_utilisateur=$1
    read -p "Entrez le nom du groupe local : " groupe_local

    # Assurer que l'utilisateur est créé
    creer_utilisateur "$nom_utilisateur" || return

    # Assurer que le groupe local existe
    creer_groupe_si_non_existant "$groupe_local" || return

    # Ajout de l'utilisateur au groupe local
    if id -nG "$nom_utilisateur" | grep -qw "$groupe_local"; then
        echo "L'utilisateur est déjà membre du groupe local."
    else
        usermod -aG "$groupe_local" "$nom_utilisateur"
        if [ $? -eq 0 ]; then
            echo "Utilisateur ajouté au groupe local avec succès."
        else
            echo "Erreur lors de l'ajout de l'utilisateur au groupe local."
        fi
    fi
}

# Fonction pour retirer un utilisateur d'un groupe local
retirer_utilisateur_du_groupe_local() {
    local nom_utilisateur=$1
    read -p "Entrez le nom du groupe local : " groupe_local

    # Vérification si l'utilisateur existe
    if ! id "$nom_utilisateur" &>/dev/null; then
        echo "Erreur : L'utilisateur $nom_utilisateur n'existe pas."
        return
    fi

    # Vérification si le groupe existe
    if ! getent group "$groupe_local" &>/dev/null; then
        echo "Erreur : Le groupe $groupe_local n'existe pas."
        return
    fi

    # Vérification de la présence de l'utilisateur dans le groupe local
    if id -nG "$nom_utilisateur" | grep -qw "$groupe_local"; then
        read -p "Voulez-vous retirer l'utilisateur du groupe local ? (oui/non) " reponse
        if [ "$reponse" == "oui" ]; then
            deluser "$nom_utilisateur" "$groupe_local"
            if [ $? -eq 0 ]; then
                echo "Utilisateur retiré du groupe local avec succès."
            else
                echo "Erreur lors du retrait de l'utilisateur du groupe local."
            fi
        else
            echo "Retrait annulé."
        fi
    else
        echo "L'utilisateur n'est pas membre du groupe local."
    fi
}

# Menu principal
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