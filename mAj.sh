#!/bin/bash

function retour () {
    echo "Retour au menu précédant choix 1"
    echo "Retour au menu principal choix 2"
    read "Faite votre selection (1/2) :" selectRet
        if [ $selectRet -eq 1 ]
        then
            #########fonction menu selection action sur ordi#########
        else
            #########fonction menu principal########
        fi     
}





function mAj (){
    read -p "Souhaitez-vous mettre le système à jour ? (o/n):" validation
    case $validation in
    o)
    #commande de mise à jour du système
    sudo apt update && sudo apt upgrade -y && echo "mise à jour du systéme effectuée!"
    #retour en arrière
    retour
    ;;
    n)
    #message d'annulation de la mise à jour
    echo "Opération de mise à jour abandonnée"
    retour
    ;;         
    *)
    #message commande inconnue
    echo "commande invalide!"
    mAj
    ;;
    esac

}