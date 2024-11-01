#!/bin/bash

# Fonction pour créer un utilisateur s'il n'existe pas et l'ajouter au groupe d'administration (sudo)
creer_utilisateur_groupe_admin() {
    local nom_utilisateur=$1
    local groupe_admin="sudo"  # Nom du groupe d'administration

    # Vérification si l'utilisateur existe, sinon le créer
    if ! id "$nom_utilisateur" &>/dev/null; then
        echo "L'utilisateur $nom_utilisateur n'existe pas. Création en cours..."
        adduser "$nom_utilisateur"
        echo "Utilisateur $nom_utilisateur créé avec succès."
    else
        echo "L'utilisateur $nom_utilisateur existe déjà."
    fi

    # Vérification de la présence de l'utilisateur dans le groupe d'administration
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

    # Vérification si l'utilisateur existe
    if ! id "$nom_utilisateur" &>/dev/null; then
        echo "Erreur : L'utilisateur $nom_utilisateur n'existe pas."
        return
    fi

    # Création du groupe local s'il n'existe pas
    if ! getent group "$groupe_local" &>/dev/null; then
        echo "Le groupe $groupe_local n'existe pas. Création en cours..."
        groupadd "$groupe_local"
        echo "Groupe $groupe_local créé avec succès."
    fi

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

    # Vérification de la présence de l'utilisateur dans le groupe local
    if id -nG "$nom_utilisateur" | grep -qw "$groupe_local"; then
        read -p "Voulez-vous retirer l'utilisateur du groupe local ? (oui/non) " reponse
        if [ "$reponse" == "oui" ]; then
            gpasswd -d "$nom_utilisateur" "$groupe_local"
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