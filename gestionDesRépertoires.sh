#!/bin/bash

# Menu de gestion de répertoire
function menuGestionRepertoires() {
    echo "Choix 1: Créer un répertoire"
    echo "Choix 2: Modifier un répertoire"
    echo "Choix 3: Supprimer un répertoire"
    echo "Choix 4: Retour au menu précédent"
    echo "Choix 5: Retour au menu principal"
    read -p "Quelle action souhaitez-vous effectuer ? " selection

    case $selection in 
        1) 
            créaRep
            ;;
        2)
            modifRep
            ;;
        3)
            suppRep
            ;;
        4)
            return
            ;;
        5)
            menu1
            ;;
        *)
            echo "Choix invalide. Veuillez réessayer."
            menuGestionRepertoires
            ;;
    esac
}


# Création d'un répertoire
function créaRep() {
#SI le répertoire n'existe pas ALORS
    read -p "Où souhaitez-vous créer un répertoire (nom avec chemin absolu):" chemin
    if [ -d "$chemin" ]
    then
        #AFFICHER "Le répertoire existe déjà"
        echo "Le répertoire $chemin existe déjà!"
    else
        #CRÉER le répertoire et message de confirmation
        mkdir "$chemin" && echo "Répertoire $chemin créé!"
    fi 
    menuGestionRepertoires
#FIN SI
}


function modifRep() {
    echo "choix 1: Modifier le nom d'un répertoire."
    echo "choix 2: Déplacer un répertoire."
    echo "choix 3: Retour au menu précédant."
    echo "choix 4: Retour au menu principal."
    read -p "Quelle opération souhaitez-vous réaliser? :" selectModif 

    case $selectModif in
    1)    
    read -p "Quel est le nom actuel du répertoire: " nameRep
    read -p "Quel eqt le chemin du répertoire (chemin absolu): " pathRep
    #SI le répertoire existe ALORS
    if [ -d "$pathRep/$nameRep" ]
    then
        #Indiquez le nouveau nom du répertoire
        -read "Quel sera le nouveau nom du répertoire:" newNameRep
        #Vérification que le nouveau nom n'est pas déjà utilisé
        if [ -d $pathRep/$newNameRep ]
        then 
            echo "Le nom de répertoire est déjà utilisé"
            modifRep
        else
            #Demande de confirmation de renommage du répertoire
            -read -p "Vous souhaitez renommer le répertoire $nameRep en $newNameRep (o/n)" valRename
            if [ "$valRename"="o" ]
            then
                mv "$pathRep/$nameRep" "$pathRep/$newNameRep" && echo "Le nom du répertoire a été modifié avec succès"
                menuGestionRepertoires
            else
                menuGestionRepertoires
            fi
        fi       
    else
        echo "Le répertoire indiqué n'a pas été trouvé"
        menuGestionRepertoires
    fi
    ;;

    2)
    read -p "Quel est le nom du répertoire: " nameRepMove
    read -p "Quel est le chemin actuel du répertoire (chemin absolu): " pathRepMove
    #SI le répertoire existe ALORS
    if [ -d "pathRepMove/$nameRepMove" ]
    then
        #Indiquez le nouveau nom du répertoire
        -read "Où souhaitez-vous déplacer le répertoire?" newPathRep
        #Vérification que le nouveau nom n'est pas déjà utilisé
        if [ -d "$newPathRep/$newNameRep" ]
        then 
            echo "Le nom et l'emplacement du répertoire existe déjà."
            modifRep
        else
            #Demande de confirmation de renommage du répertoire
            -read "Vous souhaitez déplacer le répertoire $nameRepMove dans $newPathRep (o/n)" valMove
            if [ "$valMove"="o" ]
            then
                mv "$pathRepMove/$nameRepMove" "$newPathRep/$nameRepMove" && echo "Le répertoire a bien été déplacé dans $newPathRep."
                menuGestionRepertoires
            else
                menuGestionRepertoires
            fi
        fi       
    else
        echo "Le répertoire indiqué n'a pas été trouvé"
        menuGestionRepertoires
    fi
    ;;

    3)
    menuGestionRepertoires
    ;;

    4)
    menu1
    ;;
    esac
}

# Suppression d'un répertoire avec validation
function suppRep() {
    read -p "Souhaitez vous effectuer la suppression d'un répertoire(o/n)" choixSup
    if [ "$choixSup" = "o" ] 
    then
        read -p "Quel est le repertoire à supprimer (avec son chemin absolu): " pathRepSup
        
        if [ -d "$pathRepSup" ]
        then
            read -p "Souhaitez-vous supprimer le répertoire $nameRepSup, cette action sera irrévocable(o/n)": confSup
            if [ "$confSup" = "o" ]
            then
                sudo rm -r "$pathRepSup" && echo "Répertoire $pathRepSup supprimé avec succès"
                menuGestionRepertoires
            else
                echo "Suppression annulée"
                menuGestionRepertoires
            fi
        else
        echo "Le répertoire sélectionné n'a pas été trouvé"
        suppRep
        fi
    else
        menuGestionRepertoires
    fi
}  



menuGestionRepertoires