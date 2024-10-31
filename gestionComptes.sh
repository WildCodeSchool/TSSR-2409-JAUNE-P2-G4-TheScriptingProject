#!/bin/bash

# Répertoires de base pour les groupes
REPERTOIRE_ADMIN="/mnt/c/Users/maril/Documents/admin"
REPERTOIRE_LOCAL="/mnt/c/Users/maril/Documents/local"

# Fonction pour créer un utilisateur dans le répertoire admin et l'ajouter au groupe d'administration
creer_utilisateur_groupe_admin() {
    local utilisateur=$1
    local groupe="admin"
    local repertoire_utilisateur="$REPERTOIRE_ADMIN/$utilisateur"

    # Vérification si l'utilisateur existe
    if id "$utilisateur" &>/dev/null; then
        echo "L'utilisateur $utilisateur existe déjà."
    else
        echo "L'utilisateur $utilisateur n'existe pas. Création en cours..."
        useradd -m -d "$repertoire_utilisateur" -g "$groupe" "$utilisateur"
        echo "L'utilisateur $utilisateur a été créé dans le répertoire $repertoire_utilisateur."
    fi

    # Ajouter l'utilisateur au groupe admin
    usermod -aG "$groupe" "$utilisateur"
    echo "L'utilisateur $utilisateur a été ajouté au groupe d'administration $groupe."

    # Créer un fichier texte avec des informations sur l'utilisateur
    mkdir -p "$repertoire_utilisateur"
    echo "Nom d'utilisateur : $utilisateur" > "$repertoire_utilisateur/info.txt"
    echo "Groupe : $groupe" >> "$repertoire_utilisateur/info.txt"
    echo "Date de création : $(date)" >> "$repertoire_utilisateur/info.txt"
    echo "Fichier d'information créé dans $repertoire_utilisateur/info.txt."
}

# Fonction pour créer un utilisateur dans le répertoire local et l'ajouter à un groupe local spécifique
creer_utilisateur_groupe_local() {
    local utilisateur=$1
    local groupe=$2
    local repertoire_utilisateur="$REPERTOIRE_LOCAL/$utilisateur"

    # Vérification si l'utilisateur existe
    if id "$utilisateur" &>/dev/null; then
        echo "L'utilisateur $utilisateur existe déjà."
    else
        echo "L'utilisateur $utilisateur n'existe pas. Création en cours..."
        useradd -m -d "$repertoire_utilisateur" -g "$groupe" "$utilisateur"
        echo "L'utilisateur $utilisateur a été créé dans le répertoire $repertoire_utilisateur."
    fi

    # Ajouter l'utilisateur au groupe local
    usermod -aG "$groupe" "$utilisateur"
    echo "L'utilisateur $utilisateur a été ajouté au groupe local $groupe."

    # Créer un fichier texte avec des informations sur l'utilisateur
    mkdir -p "$repertoire_utilisateur"
    echo "Nom d'utilisateur : $utilisateur" > "$repertoire_utilisateur/info.txt"
    echo "Groupe : $groupe" >> "$repertoire_utilisateur/info.txt"
    echo "Date de création : $(date)" >> "$repertoire_utilisateur/info.txt"
    echo "Fichier d'information créé dans $repertoire_utilisateur/info.txt."
}

# Fonction pour retirer un utilisateur du groupe spécifié et supprimer son sous-répertoire
retirer_utilisateur_du_groupe() {
    local utilisateur=$1

    # Demander si l’utilisateur est dans le groupe admin ou local
    read -p "Souhaitez-vous supprimer l'utilisateur de 'admin' ou 'local' ? (entrez 'admin' ou 'local') : " choix_groupe

    # Définir le groupe et le répertoire en fonction de la réponse
    if [ "$choix_groupe" == "admin" ]; then
        local groupe="admin"
        local repertoire_utilisateur="$REPERTOIRE_ADMIN/$utilisateur"
    elif [ "$choix_groupe" == "local" ]; then
        read -p "Entrez le nom du groupe local : " groupe
        local repertoire_utilisateur="$REPERTOIRE_LOCAL/$utilisateur"
    else
        echo "Choix invalide. Aucune action n'a été effectuée."
        return
    fi

    # Vérification si l'utilisateur existe
    if id "$utilisateur" &>/dev/null; then
        # Retirer l'utilisateur du groupe
        gpasswd -d "$utilisateur" "$groupe"
        echo "L'utilisateur $utilisateur a été retiré du groupe $groupe."

        # Suppression du sous-répertoire utilisateur si dans le groupe local uniquement
        if [ "$choix_groupe" == "local" ]; then
            if [ -d "$repertoire_utilisateur" ]; then
                rm -rf "$repertoire_utilisateur"
                echo "Le sous-répertoire de l'utilisateur $utilisateur a été supprimé du répertoire $REPERTOIRE_LOCAL."
            else
                echo "Le sous-répertoire de l'utilisateur $utilisateur n'existe pas dans le répertoire $REPERTOIRE_LOCAL."
            fi
        fi

        # Suppression de l'utilisateur du système
        userdel "$utilisateur"
        echo "L'utilisateur $utilisateur a été supprimé du système."
    else
        echo "L'utilisateur $utilisateur n'existe pas."
    fi
}

# Menu principal pour choisir l'action
while true; do
    echo "Choisissez une action :"
    echo "1. Ajouter un utilisateur à un groupe d'administration"
    echo "2. Ajouter un utilisateur à un groupe local"
    echo "3. Retirer un utilisateur d'un groupe et supprimer son sous-répertoire (si groupe local)"
    echo "4. Quitter"
    read -p "Entrez votre choix : " choix

    case $choix in
        1)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            creer_utilisateur_groupe_admin "$utilisateur"
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            read -p "Entrez le nom du groupe local : " groupe
            creer_utilisateur_groupe_local "$utilisateur" "$groupe"
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur : " utilisateur
            retirer_utilisateur_du_groupe "$utilisateur"
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