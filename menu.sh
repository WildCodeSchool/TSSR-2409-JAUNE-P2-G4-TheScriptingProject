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
        menu2
    ;;
    2)
        menu3
    ;;
    0)
        echo -e "\e[1;32mSortie du script\e[0;m"
        exit 0
    ;;
    *)
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
        menu1
    ;;
    esac
}

# Fonction Menu2 (Actions)
function menu2()
{
    echo -e "Vous souhaitez réaliser une \e[1;33maction\e[0;m sur..."
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
}

# Fonction Menu3 (Informations)
function menu3()
{
    echo -e "Vous souhaitez rechercher une \e[1;33minformation\e[0;m sur..."
    echo "1. Un utilisateur"
    echo "2. Un ordinateur client"
    echo "3. Un événement du fichier log_evt.log"
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
    3)
        echo "Lancement de evt.sh"
    ;;
    0)
        menu1
    ;;
    esac
}

# Fonction Menu des A(ctions) U(tilisateur)
function menuAU()
{
    echo -e "Quelle \e[1;33maction utilisateur\e[0;m souhaitez-vous réaliser ?"
    echo "1. Une action sur les Comptes"
    echo "2. Une action sur les Groupes"
    echo "0. Revenir en arrière"
    echo "Taper 1, 2 ou 0"
    read -p "" choix
    case $choix in
    1)
        echo -e "Action Utilisateur Comptes"
    ;;
    2)
        echo -e "Action Utilisateur Groupes"
    ;;
    0)
        echo -e "\e[1;32mRetour en arrière\e[0;m"
        menu2
    ;;
    *)
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
        menuAU
    ;;
    esac
}

# Fonction Menu des A(ctions) C(lient)
function menuAC()
{
    echo -e "Quelle \e[1;33maction client\e[0;m souhaitez-vous réaliser ?"
    echo "1. Une action sur l'alimentation"
    echo "2. Une mise à jour"
    echo "3. Une action sur les répertoires"
    echo "4. Une prise en main à distance (GUI)"
    echo "5. Une action sur les pare-feux"
    echo "6. Une action sur les logiciels"
    echo "0. Revenir en arrière"
    echo "Taper 1, 2 ou 0"
    read -p "" choix
    case $choix in
    1)
        echo -e "Action Client Alimentation"
    ;;
    2)
        echo -e "Action Client MàJ"
    ;;
    3)
        echo -e "Action Client Répertoires"
    ;;
    4)
        echo -e "Action Client GUI"
    ;;
    5)
        echo -e "Action Client Pare-feux"
    ;;
    6)
        echo -e "Action Client Logiciels"
    ;;
    0)
        echo -e "\e[1;32mRetour en arrière\e[0;m"
        menu2
    ;;
    *)
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
        menuAU
    ;;
    esac
}

# Fonction Menu des I(nformations) U(tilisateur)
function menuIU()
{
    echo -e "Lancement de InfoUser.sh"
}

# Fonction Menu des I(nformations) C(lient)
#function menuIC()
#{

#}

while true
do
    menu1
done