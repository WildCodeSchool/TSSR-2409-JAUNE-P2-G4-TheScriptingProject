#!/bin/bash

# Script Bash pour gérer les utilisateurs dans le groupe admin ou local
echo "===================="
echo "Gestion des groupes"
echo "===================="
echo ""

# Fonction pour vérifier si un utilisateur existe et afficher la liste des utilisateurs humains en cas d'erreur
function verifier_utilisateur {
    local nom_utilisateur="$1"
    if ! id "$nom_utilisateur" &>/dev/null; then
        echo "Erreur : L'utilisateur $nom_utilisateur n'existe pas."
        echo "Liste des utilisateur existants :"
        # Filtre pour afficher uniquement les utilisateurs humains avec un shell interactif
        awk -F: '$7 ~ /(bash|sh|zsh)/ {print $1}' /etc/passwd
        return 1
    fi
    return 0
}

# Fonction pour vérifier si un groupe existe et afficher la liste des groupes en cas d'erreur
function verifier_groupe {
    local nom_groupe="$1"
    if ! getent group "$nom_groupe" &>/dev/null; then
        echo "Erreur : Le groupe $nom_groupe n'existe pas."
        echo "Liste des groupes existants :"
        cut -d: -f1 /etc/group  # Affiche la liste des groupes
        return 1
    fi
    return 0
}

# Fonction pour ajouter un utilisateur au groupe Administrateurs avec confirmation
function ajout_utilisateur_admin {
    local nom_utilisateur="$1"
    local nom_groupe="sudo"  # Groupe des administrateurs sur Ubuntu/Debian
    
    # Vérifie que l'utilisateur existe
    if ! verifier_utilisateur "$nom_utilisateur"; then
        return
    fi
    
    # Confirmation avant d'ajouter au groupe Administrateurs
    read -p "Voulez-vous vraiment ajouter $nom_utilisateur au groupe $nom_groupe ? (oui/non): " confirmation
    if [[ "$confirmation" == "oui" ]]; then
        if groups "$nom_utilisateur" | grep -q "\b$nom_groupe\b"; then
            echo "L'utilisateur $nom_utilisateur est déjà membre du groupe $nom_groupe."
        else
            sudo usermod -aG "$nom_groupe" "$nom_utilisateur"
            if [[ $? -eq 0 ]]; then
                echo "L'utilisateur $nom_utilisateur a été ajouté au groupe $nom_groupe avec succès."
            else
                echo "Erreur lors de l'ajout de l'utilisateur $nom_utilisateur au groupe $nom_groupe."
            fi
        fi
    else
        echo "Ajout annulé."
    fi
}

# Fonction pour ajouter un utilisateur à un groupe local avec confirmation
function ajout_utilisateur_groupe {
    local nom_utilisateur="$1"
    local nom_groupe="$2"
    
    # Vérifie que l'utilisateur et le groupe existent
    if ! verifier_utilisateur "$nom_utilisateur"; then
        return
    fi
    if ! verifier_groupe "$nom_groupe"; then
        return
    fi
    
    # Confirmation avant d'ajouter au groupe local
    read -p "Voulez-vous vraiment ajouter $nom_utilisateur au groupe $nom_groupe ? (oui/non): " confirmation
    if [[ "$confirmation" == "oui" ]]; then
        if groups "$nom_utilisateur" | grep -q "\b$nom_groupe\b"; then
            echo "L'utilisateur $nom_utilisateur est déjà membre du groupe $nom_groupe."
        else
            sudo usermod -aG "$nom_groupe" "$nom_utilisateur"
            if [[ $? -eq 0 ]]; then
                echo "L'utilisateur $nom_utilisateur a été ajouté au groupe $nom_groupe avec succès."
            else
                echo "Erreur lors de l'ajout de l'utilisateur $nom_utilisateur au groupe $nom_groupe."
            fi
        fi
    else
        echo "Ajout annulé."
    fi
}

# Fonction pour retirer un utilisateur d'un groupe local avec confirmation
function suppression_utilisateur {
    local nom_utilisateur="$1"
    local nom_groupe="$2"
    
    # Vérifie que l'utilisateur et le groupe existent
    if ! verifier_utilisateur "$nom_utilisateur"; then
        return
    fi
    if ! verifier_groupe "$nom_groupe"; then
        return
    fi
    
    # Confirmation avant de retirer du groupe local
    if groups "$nom_utilisateur" | grep -q "\b$nom_groupe\b"; then
        read -p "Voulez-vous vraiment retirer $nom_utilisateur du groupe $nom_groupe ? (oui/non): " confirmation
        if [[ "$confirmation" == "oui" ]]; then
            sudo gpasswd -d "$nom_utilisateur" "$nom_groupe"
            if [[ $? -eq 0 ]]; then
                echo "L'utilisateur $nom_utilisateur a été retiré du groupe $nom_groupe avec succès."
            else
                echo "Erreur lors du retrait de l'utilisateur $nom_utilisateur du groupe $nom_groupe."
            fi
        else
            echo "Retrait annulé."
        fi
    else
        echo "L'utilisateur $nom_utilisateur n'est pas membre du groupe $nom_groupe."
    fi
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
            ajout_utilisateur_admin "$utilisateur"
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur: " utilisateur
            read -p "Entrez le nom du groupe local: " groupe
            ajout_utilisateur_groupe "$utilisateur" "$groupe"
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur: " utilisateur
            read -p "Entrez le nom du groupe local: " groupe
            suppression_utilisateur "$utilisateur" "$groupe"
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