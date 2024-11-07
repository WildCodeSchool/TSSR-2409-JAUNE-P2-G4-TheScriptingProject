#!/bin/bash

echo "=============================="
echo "Gestion des groupes"
echo "=============================="

# Fonction pour créer un utilisateur s'il n'existe pas
function creation_utilisateur {
    local nom_utilisateur="$1"
    
    # Vérifie si l'utilisateur existe
    if id "$nom_utilisateur" &>/dev/null; then
        echo "L'utilisateur $nom_utilisateur existe déjà."
        return 0
    else
        echo "L'utilisateur $nom_utilisateur n'existe pas. Création en cours..."
        sudo useradd "$nom_utilisateur"
        if [[ $? -eq 0 ]]; then
            echo "Utilisateur $nom_utilisateur créé avec succès."
            return 0
        else
            echo "Erreur lors de la création de l'utilisateur $nom_utilisateur."
            return 1
        fi
    fi
}

# Fonction pour ajouter un utilisateur au groupe Administrateurs avec confirmation
function ajout_utilisateur_admin {
    local nom_utilisateur="$1"
    local nom_groupe="sudo" # Groupe des administrateurs sur Ubuntu/Debian

    # S'assurer que l'utilisateur est créé
    creation_utilisateur "$nom_utilisateur"
    
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

    # S'assurer que l'utilisateur est créé
    creation_utilisateur "$nom_utilisateur"
    
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

    # Vérifie si l'utilisateur et le groupe existent
    if ! id "$nom_utilisateur" &>/dev/null; then
        echo "Erreur : L'utilisateur $nom_utilisateur n'existe pas."
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