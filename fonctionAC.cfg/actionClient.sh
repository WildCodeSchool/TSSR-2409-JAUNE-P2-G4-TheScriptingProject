#!/bin/bash


#####ALIMENTATION#######
# Fonction pour arrêter l'ordinateur
fonction_arret() {
    echo "Voulez-vous vraiment arrêter ?"
    echo "1 - Arrêt immédiat"
    echo "2 - Arrêt dans une minute"
    echo "3 - Annuler"
    read -p "Choix : " confirmationArret

    case $confirmationArret in
        1)
            echo "Arrêt immédiat en cours..."
            sudo shutdown now
            ;;
        2)
            echo "Arrêt dans une minute en cours..."
            sudo shutdown +1
            ;;
        3)
            echo "Arrêt annulé."
            return
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
}

# Fonction pour redémarrer l'ordinateur
fonction_redemarrage() {
    echo "Voulez-vous vraiment redémarrer ?"
    echo "1 - Redémarrage immédiat"
    echo "2 - Redémarrage dans une minute"
    echo "3 - Annuler"
    read -p "Choix : " confirmationRedemarrage

    case $confirmationRedemarrage in
        1)
            echo "Redémarrage immédiat en cours..."
            sudo reboot now
            ;;
        2)
            echo "Redémarrage dans une minute en cours..."
            sudo shutdown -r +1
            ;;
        3)
            echo "Redémarrage annulé."
            return
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
}

# Fonction pour verrouiller la session
fonction_verrouillage() {
    echo "Verrouillage de la session..."
    gnome-screensaver-command -l || echo "Verrouillage non disponible."
}

# Menu principal 
function menuAlimentation() {
echo "=============================="
echo "Gestion alimentation"
echo "=============================="
while true; do
    echo "Que voulez-vous faire ?"
    echo "1 - Arrêter l'ordinateur"
    echo "2 - Redémarrer l'ordinateur"
    echo "3 - Verrouiller la session"
    echo "4 - Quitter"
    read -p "Choix : " choixUtilisateur

    case $choixUtilisateur in
        1)
            fonction_arret
            ;;
        2)
            fonction_redemarrage
            ;;
        3)
            fonction_verrouillage
            ;;
        4)
            echo "Sortie du programme."
            break
            ;;
        *)
            echo "Choix invalide, veuillez réessayer."
            ;;
    esac
done
}




function retour () {
    echo "Retour au menu précédant choix 1"
    echo "Retour au menu principal choix 2"
    read -p "Faite votre selection (1/2) :" selectRet
        if [ $selectRet -eq 1 ]
        then
            return
        else
            menu1
        fi     
}



#####MISE A JOUR SYSTEME#########

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




#######GESTION DES REPERTOIRES##########

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
    read -p "Quel est le chemin du répertoire (chemin absolu): " pathRep
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




#########GESTION PARE-FEU##############



# Script Bash pour activer ou désactiver le pare-feu

function pareFeux() {
echo "=============================="
echo "Gestion des pare-feux"
echo "=============================="
while true; do
    echo ""
    echo "--- Menu Principal ---"
    echo "1. Activer le pare-feu"
    echo "2. Désactiver le pare-feu"
    echo "3. Quitter"
    echo -n "Sélectionnez une option : "
    read choice

    case $choice in
        1)
            echo "Activation du pare-feu..."
            sudo ufw enable
            echo "Pare-feu activé."
            ;;
        2)
            echo "Désactivation du pare-feu..."
            sudo ufw disable
            echo "Pare-feu désactivé."
            ;;
        3)
            echo "Quitter."
            break
            ;;
        *)
            echo "Option invalide. Veuillez sélectionner 1, 2 ou 3."
            ;;
    esac
done
}