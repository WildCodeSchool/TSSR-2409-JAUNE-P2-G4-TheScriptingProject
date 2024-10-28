#! /bin/bash

# Je veux proposer un menu à trois entrées : Action, Requête d'information ou Sortie du script ;
# Je veux que l'on revienne à ce menu si l'on en fait la demande => fonction
function menu1()
{
    echo "Que voulez-vous faire ? (Taper 1, 2 ou 0)"
    echo "1. Réaliser une action"
    echo "2. Rechercher une information"
    echo "0. Sortir de ce script"
    read -p "" choix

    case $choix in
    1)
        echo "Vous souhaitez réaliser une action sur..."
        echo "1. Un utilisateur"
        echo "2. Un ordinateur client"
        echo "0. Revenir en arrière"
        echo "Taper 1, 2 ou 0"
        read -p "" choix
        case $choix in
        1)
            menuAU
        ;;
        2)
            menuAC
        ;;
        0)
            menu1
        ;;
        esac
    ;;
    2)
        echo "Vous souhaitez rechercher une information sur..."
        echo "1. Un utilisateur"
        echo "2. Un ordinateur client"
        echo "0. Revenir en arrière"
        echo "Taper 1, 2 ou 0"
        read -p "" choix
        case $choix in
        1)
            menuIU
        ;;
        2)
            menuIC
        ;;
        0)
            menu1
        ;;
        esac
    ;;
    0)
        echo "Sortie du script"
        exit 0
    ;;
    *)
        echo "Mauvaise entrée. Tapez 1, 2 ou 0 "
    ;;
    esac
}

# Fonction Menu des A(ctions) U(tilisateur)
function menuAU()
{

}

# Fonction Menu des A(ctions) C(lient)
function menuAC()
{

}

# Fonction Menu de I(nformations) U(tilisateur)
function menuIU()
{

}

# Fonction Menu de I(nformations) C(lient)
function menuIC()
{

}


menu1
