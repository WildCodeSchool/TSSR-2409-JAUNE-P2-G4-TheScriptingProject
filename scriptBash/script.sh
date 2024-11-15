#! /bin/bash

#########################################################################################################
# FONCTIONS ACTIONS UTILISATEURS
#########################################################################################################

##Création d'un nouveau compte utilisateur local
function createuser () {
    echo "==============================="
    echo "Gestion des utilisateurs locaux"
    echo "==============================="
    echo ""
    # Demander le nom du nouveau compte à créer 
    echo -e "Quel est le \e[0;36mnom de l'utilisateur\e[0;m que vous souhaitez créer ? (9 pour revenir au menu précédent)"
    read -p "" user

    # Retour Menu Précédent
    if [ $user = "9" ]
    then
        return
    fi

    # Vérification que le nom de compte n'est pas déjà attribué
    if cat /etc/passwd | grep $user >> /dev/null
    then
        echo -e "\n"
        echo -e "\e[0;33mL'utilisateur $user existe déjà \e[0;m"
    fi

    # Demande de confirmation
    echo -e "\n"
    echo -e "Êtes-vous sûr de vouloir créer l'utilisateur $user ? [O/n]"
    read -p "" confirm
    if [ $confirm = "O" ]
    then
        # Création Utilisateur
        sudo useradd $user
        # Vérification Création utilisateur 
        if cat /etc/passwd | grep $user >> /dev/null
        # Si la création s'est bien effectuée, un message affiche "L'utilisateur <nom_utilisateur> a été crée".
        then
            echo -e "\n"
            echo -e "\e[0;32mL'utilisateur $user a été crée \e[0;m"
        #Sinon, un message affiche "Erreur à la création de l'utilisateur <nom_utilisateur>".
        else
            echo -e "\n"
            echo -e "\e[0;31mErreur à la création de l'utilisateur $user \e[0;m"
        fi
    # Si refus confirmation - Abandon
    else
        echo -e "\n"
        echo -e "\e[0;31mAbandon de la création de l'utilisateur $user \e[0;m"
    fi
}


##Changement du mot de passe d'un utilisateur local
function changepassword() {
    echo "==============================="
    echo "Gestion des utilisateurs locaux"
    echo "==============================="
    echo ""
    # Demander le nom du compte dont le mot de passe doit être modifié 
    echo -e "Quel est le \e[0;36mnom de l'utilisateur\e[0;m dont le mot de passe doit être modifié ? (9 pour revenir au menu précédent)"
    read -p "" user

    # Retour Menu Précédent
    if [ $user = "9" ]
    then
        return
    fi

    # Vérification existence du nom du compte 
    until [ $(cat /etc/passwd | grep $user | wc -l) -eq 1 ]
    do
        echo -e "\n"
        echo -e "\e[0;31mL'utilisateur $user est introuvable \e[0;m"
        cat /etc/passwd | grep $user | cut -d ':' -f1 | grep $user
        echo -e "\n"
        echo -e "Quel est le \e[0;36mnom de l'utilisateur\e[0;m dont le mot de passe doit être modifié ?"
        read -p "" user
    done

    # Demande de confirmation de l'opération de changement du mot de passe
    echo -e "\n"
    echo -e "\e[0;33mÊtes-vous sûr de vouloir modifier le mot de passe de l'utilisateur $user ? [O/n]\e[0;m"
    read -p "" confirm

    # Si confirmation  
    if [ $confirm = "O" ]
    # Alors modification du mot de passe et confirmation de la modification
    then
        sudo passwd $user
    # Sinon Message d'abandon
    else
        echo -e "\n"
        echo -e "\e[0;31mAbandon de la modification de mot de passe de l'utilisateur $user \e[0;m"
    fi
}


##Suppression d'un compte utilisateur local
function deleteuser() {
    echo "==============================="
    echo "Gestion des utilisateurs locaux"
    echo "==============================="
    echo ""
    # Demander le nom du compte à supprimer 
    echo -e "Quel est le \e[0;36mnom de l'utilisateur\e[0;m que vous souhaitez supprimer ? (9 pour revenir au menu précédent)"
    read -p "" user

    # Retour Menu Précédent
    if [ $user = "9" ]
    then
        return
    fi

    # Vérification existence du nom du compte 
    until [ $(cat /etc/passwd | grep $user | wc -l) -eq 1 ]
    do
        echo -e "\n"
        echo -e "\e[0;31mL'utilisateur $user est introuvable \e[0;m"
        cat /etc/passwd | grep $user | cut -d ':' -f1 | grep $user
        echo -e "\n"
        echo -e "Quel est le \e[0;36mnom de l'utilisateur\e[0;m que vous souhaitez supprimer ?"
        read -p "" user
    done
    
    echo -e "\n"
    echo -e "\e[0;33mÊtes-vous sûr de vouloir supprimer l'utilisateur $user ? [O/n]\e[0;m"
    read -p "" confirm
    if [ $confirm = "O" ]
    then
        # Suppression Utilisateur
        sudo userdel $user
        # Vérification Suppression utilisateur 
        if cat /etc/passwd | grep $user >> /dev/null
        # Si la suppression ne s'est pas effectuée -  Message d'erreur".
        then
            echo -e "\n"
            echo -e "\e[0;31mErreur lors de la suppression de l'utilisateur $user \e[0;m"
        # Si la suppression s'est bien effectuée - Message OK
        else
            echo -e "\n"
            echo -e "\e[0;32mL'utilisateur $user a bien été \e[0;31msupprimé \e[0;m"
        fi
    # Si refus confirmation - Abandon
    else
        echo -e "\n"
        echo -e "\e[0;31mAbandon de la suppression de l'utilisateur $user \e[0;m"
    fi
}


function deactivateuser() {
    echo "==============================="
    echo "Gestion des utilisateurs locaux"
    echo "==============================="
    echo ""
    # Demande du nom du compte à modifier
    echo -e "Quel est le \e[0;36mnom de l'utilisateur\e[0;m dont le compte doit être modifié ? (9 pour revenir au menu précédent)"
    read -p "" user

    # Retour Menu Précédent
    if [ $user = "9" ]
    then
        return
    fi

    # Vérification existence du nom du compte 
    until [ $(cat /etc/passwd | grep $user | wc -l) -eq 1 ]
    do
        echo -e "\n"
        echo -e "\e[0;31mL'utilisateur $user est introuvable \e[0;m"
        cat /etc/passwd | grep $user | cut -d ':' -f1 | grep $user
        echo -e "\n"
        echo -e "Quel est le nom de l'utilisateur dont le compte doit être modifié ?"
        read -p "" user
    done

    # Activer ou Désactiver ?
    echo -e "\n"
    echo -e "Souhaitez-vous \e[0;36mActiver [A]\e[0;m ou \e[0;36mDésactiver [D]\e[0;m le compte de l'utilisateur $user ?"
    read -p "" activ

    # Activation
    if [ $activ = "A" ]
    then
        echo -e "\n"
        echo -e "Êtes vous sûr de vouloir \e[0;32mactiver\e[0;m le compte $user ? [O/n]"
        read -p "" confirm
        if [ $confirm = "O" ]
        then
            sudo usermod -U $user
        fi

        if [ $? -eq 0 ]
        then
            echo -e "\n"
            echo -e "\e[0;32mLe compte $user est activé\e[0;m"
        else
            echo -e "\n"
            echo -e "\e[0;31mAbandon des modifications sur le compte $user\e[0;m"
        fi
    # Désactivation
    elif [ $activ = "D" ]
    then
        echo -e "\n"
        echo -e "Êtes vous sûr de vouloir \e[0;31mdésactiver\e[0;m le compte $user ? [O/n]"
        read -p "" confirm
        if [ $confirm = "O" ]
        then
            sudo usermod -L $user
        fi

        if [ $? -eq 0 ]
        then
            echo -e "\n"
            echo -e "\e[0;32mLe compte $user est \e[0;31mdésactivé\e[0;m"
        else
            echo -e "\n"
            echo -e "\e[0;31mAbandon des modifications sur le compte $user\e[0;m"
        fi
    # Commande incorrecte
    else
        echo -e "\n"
        echo -e "\e[0;31mVeuillez entrer une valeur correcte\e[0;m \e[0;36m[A/D]\e[0;m"
    fi
}


# Ajouter un utilisateur au groupe Administrateurs
ajout_admin() {
    echo "=========================="
    echo "Gestion des groupes locaux"
    echo "=========================="
    echo ""
    read -p "Entrez le nom de l'utilisateur: " utilisateur
    local utilisateur="$utilisateur"
    local groupe="sudo"  

    usermod -aG "$groupe" "$utilisateur" && echo "L'utilisateur $utilisateur a été ajouté au groupe $groupe avec succès."
}

# Ajouter un utilisateur à un groupe local
ajout_groupe() {
    echo "=========================="
    echo "Gestion des groupes locaux"
    echo "=========================="
    echo ""
    read -p "Entrez le nom de l'utilisateur: " utilisateur
    read -p "Entrez le nom du groupe local: " groupe
    local utilisateur="$utilisateur"
    local groupe="$groupe"

    usermod -aG "$groupe" "$utilisateur" && echo "L'utilisateur $utilisateur a été ajouté au groupe $groupe avec succès."
}

# Retirer un utilisateur d'un groupe local
retirer_groupe() {
    echo "=========================="
    echo "Gestion des groupes locaux"
    echo "=========================="
    echo ""
    read -p "Entrez le nom de l'utilisateur: " utilisateur
    read -p "Entrez le nom du groupe local: " groupe
    local utilisateur="$utilisateur"
    local groupe="$groupe"

    gpasswd -d "$utilisateur" "$groupe" && echo "L'utilisateur $utilisateur a été retiré du groupe $groupe avec succès."
}




##########################################################################################################################################################
# FONCTION ACTIONS ORDINATEUR CLIENT
##########################################################################################################################################################

# Fonction pour arrêter l'ordinateur
function arret() {
    echo "========================="
    echo "Gestion de l'alimentation"
    echo "========================="
    echo ""
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
function redemarrage() {
    echo "========================="
    echo "Gestion de l'alimentation"
    echo "========================="
    echo ""
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
function verrouillage() {
    echo "========================="
    echo "Gestion de l'alimentation"
    echo "========================="
    echo ""
    echo "Verrouillage de la session..."
    gnome-screensaver-command -l || echo "Verrouillage non disponible."
}

#Fonction de mise à jour de l'OS
function mAj () {
    echo "==================="
    echo "Mise à jour système"
    echo "==================="
    echo ""
    read -p "Souhaitez-vous mettre le système à jour ? (o/n):" validation
    case $validation in
    o)
    #commande de mise à jour du système
    sudo apt update && sudo apt upgrade -y && echo "mise à jour du systéme effectuée!"
    ;;
    n)
    #message d'annulation de la mise à jour
    echo "Opération de mise à jour abandonnée"
    ;;         
    *)
    #message commande inconnue
    echo "commande invalide!"
    mAj
    ;;
    esac
}

# Création d'un répertoire
function créaRep() {
    echo "======================="
    echo "Gestion des répertoires"
    echo "======================="
    echo ""
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
#FIN SI
}

#Modification d'un répertoire
function modifRep() {
    echo "======================="
    echo "Gestion des répertoires"
    echo "======================="
    echo ""
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
        -read -p "Quel sera le nouveau nom du répertoire:" newNameRep
        #Vérification que le nouveau nom n'est pas déjà utilisé
        if [ -d $pathRep/$newNameRep ]
        then 
            echo "Le nom de répertoire est déjà utilisé"
            modifRep
        else
            #Demande de confirmation de renommage du répertoire
            read -p "Vous souhaitez renommer le répertoire $nameRep en $newNameRep (o/n)" valRename
            if [ "$valRename"="o" ]
            then
                mv "$pathRep/$nameRep" "$pathRep/$newNameRep" && echo "Le nom du répertoire a été modifié avec succès"
            else
                echo "Commande inconnue"
                modifRep
            fi
        fi       
    else
        echo "Le répertoire indiqué n'a pas été trouvé"
        modifRep
    fi
    ;;

    2)
    read -p "Quel est le nom du répertoire: " nameRepMove
    read -p "Quel est le chemin actuel du répertoire (chemin absolu): " pathRepMove
    #SI le répertoire existe ALORS
    if [ -d "pathRepMove/$nameRepMove" ]
    then
        #Indiquez le nouveau nom du répertoire
        read -p "Où souhaitez-vous déplacer le répertoire?" newPathRep
        #Vérification que le nouveau nom n'est pas déjà utilisé
        if [ -d "$newPathRep/$nameRepMove" ]
        then 
            echo "Le nom et l'emplacement du répertoire existe déjà."
            modifRep
        else
            #Demande de confirmation de renommage du répertoire
            read -p "Vous souhaitez déplacer le répertoire $nameRepMove dans $newPathRep (o/n)" valMove
            if [ "$valMove"="o" ]
            then
                mv "$pathRepMove/$nameRepMove" "$newPathRep/$nameRepMove" && echo "Le répertoire a bien été déplacé dans $newPathRep."
            else
                echo "Commande inconnue"
                modifRep
            fi
        fi       
    else
        echo "Le répertoire indiqué n'a pas été trouvé"
        modifRep
    fi
    ;;

    3)
    menu2
    ;;

    4)
    menu1
    ;;
    esac
}

# Suppression d'un répertoire avec validation
function suppRep() {
    echo "======================="
    echo "Gestion des répertoires"
    echo "======================="
    echo ""
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
            else
                echo "Suppression annulée"
            fi
        else
        echo "Le répertoire sélectionné n'a pas été trouvé"
        fi
    else
        echo "Opération de suppression annulée."
    fi
}  


# Fonction d'installation de logiciel
function instalLogiciel() {
    echo "================="
    echo "Gestion logiciels"
    echo "================="
    echo ""
    read -p "Quel logiciel souhaitez-vous installer:" nomLogiciel
    echo "Installation du logiciel $nomLogiciel..."
    sudo apt-get install  "$nomLogiciel" -y
    echo "Installation de $nomLogiciel terminée."
}

# Fonction de désinstallation de logiciel
function delLogiciel() {
    echo "================="
    echo "Gestion logiciels"
    echo "================="
    echo ""
    read  -p "Quel logiciel souhaitez-vous désinstaller" logicielDel
    echo "Désinstallation du logiciel $logicielDel..."
    sudo apt-get remove -y "$logicielDel"
    echo "Suppression complète de $logicielDel..."
    sudo apt-get purge -y "$logicielDel"
    echo "Suppression des paquets inutilisés..."
    sudo apt-get autoremove -y
    echo "Désinstallation de $logicielDel terminée."
}

# Fonction pour exécuter un script bash sur une machine distante
executer_script_distant() {
    echo "=================="
    echo "Exécuter un script"
    echo "=================="
    echo ""
    local machine_distante=$1
    local chemin_script=$2

    echo "Copie du script vers la machine distante..."
    scp "$chemin_script" "$machine_distante:~/script_temp.sh"
    echo "Exécution du script sur la machine distante..."
    ssh "$machine_distante" 'bash ~/script_temp.sh'
    echo "Script exécuté sur la machine distante."
}




##########################################################################################################################################################
# FONCTIONS INFORMATION UTILISATEURS
##########################################################################################################################################################

# Script Bash pour connaître des informations utilisateur

function dateLastCon () {
    # Utilisation de last pour obtenir la dernière connexion de l'utilisateur
    echo "==========================="
    echo "Informations utilisateurs"
    echo "==========================="
    echo "" 
    read -p "Quel est le nom de l'utilisateur dont vous souhaiter connaitre la dernière date de connexion:" UTILISATEUR
    if ! id "$UTILISATEUR" &>/dev/null
    then
        echo "Erreur : L'utilisateur $UTILISATEUR n'existe pas."
    else
        echo "Date de dernière connexion de l'utilisateur $UTILISATEUR :"
            DERNIERE_CONNEXION=$(last -n 1 "$UTILISATEUR" | head -n 1)
            if [ -z "$DERNIERE_CONNEXION" ]; then
                echo "Aucune information de connexion disponible pour cet utilisateur."
            else
                DATE_CONNEXION=$(echo "$DERNIERE_CONNEXION" | awk '{print $4, $5, $6, $7}')
                DATE_FRANCAISE=$(LANG=fr_FR.UTF-8 date -d "$DATE_CONNEXION" "+%A %d %B %Y")
                echo "$DATE_FRANCAISE"
            fi
    fi
}

function dateModifPW () {
    # Date de dernière modification du mot de passe de l'utilisateur
    echo "==========================="
    echo "Informations utilisateurs"
    echo "==========================="
    echo "" 
    read -p "Quel est le nom de l'utilisateur dont vous souhaitez connaitre la date de modification du mot de passe:" UTILISATEUR
    if ! id "$UTILISATEUR" &>/dev/null
    then
        echo "Erreur : L'utilisateur $UTILISATEUR n'existe pas."
    else
        echo "Date de dernière modification du mot de passe de l'utilisateur $UTILISATEUR :"
        sudo chage -l "$UTILISATEUR" | grep "modification"
    fi
}

function sessionOuverte() {          
    # Liste des sessions ouvertes par l'utilisateur
    echo "==========================="
    echo "Informations utilisateurs"
    echo "==========================="
    echo "" 
    read -p "Quel est le nom de l'utilisateur dont vous souhaitez connaitre la liste des sessions ouvertes:" UTILISATEUR
    if ! id "$UTILISATEUR" &>/dev/null
    then
    echo "Erreur : L'utilisateur $UTILISATEUR n'existe pas."
    else
    echo "Sessions ouvertes par l'utilisateur $UTILISATEUR :"
        if ! who | grep "$UTILISATEUR"; then
            echo "Aucune session ouverte trouvée pour cet utilisateur."
        fi
    fi    
}  


function historique() {
    # Fonction pour consulter l'historique des commandes d'un utilisateur 
    echo "========================"
    echo "Historique des commandes"
    echo "========================"
    echo ""
    echo -e "\n"
    echo -e "Quel est l'utilisateur dont vous souhaitez connaître l'historique ?"
    read -p "" user
    echo -e "\n"
    echo -e "Vous souhaitez un historique des \e[0;36mn dernières commandes\e[0;m."
    echo -e "\e[0;32mDéfinissez n\e[0;m : (intégralité si aucune valeur entrée)"
    read -p "" number
    test='^[0-9]+$'
    if ! [[ $number =~ $test ]]
    then
        echo -e "\n"
        echo -e "\e[0;31mVous n'avez pas entré de nombre\e[0;m"
        echo -e "\e[0;33mAffichage de l'intégralité de l'historique\e[0;m"
        echo -e "\n"
        sleep 5
        cat /home/$user/.bash_history
        echo -e "\n"
    else
        echo -e "\n"
        tail -n $number /home/$user/.bash_history
        echo -e "\n"
    fi
}

function droitsDossier() {
    echo "======================================"
    echo "Vérification des droits et permissions"
    echo "======================================"
    echo ""
    # Demander le chemin du dossier
    read -e -p "Entrez le chemin complet du dossier: " cheminDossier
    # Vérifier si le dossier existe
    if [ ! -d "$cheminDossier" ]
    then
        echo "Erreur : Le dossier spécifié n'existe pas."
    else
        # Afficher les permissions du dossier
        echo -n "Permissions sur le dossier : "
        ls -ld "$cheminDossier" | awk '{print $1" "$3" "$4}'
    fi
}


function droitsFichier() {
    echo "======================================"
    echo "Vérification des droits et permissions"
    echo "======================================"
    echo ""
    # Demander le chemin du fichier
    read -e -p "Entrez le chemin complet du fichier: " cheminFichier
    # Vérifier si le fichier existe
    if [ ! -f "$cheminFichier" ]
    then
        echo "Erreur : Le fichier spécifié n'existe pas."
    else
    # Afficher les permissions du fichier
        echo -n "Permissions sur le fichier : "
        ls -l "$cheminFichier" | awk '{print $1" "$3" "$4}'
    fi
}



##########################################################################################################################################################
# FONCTIONS INFORMATION ORDINATEUR CLIENT
##########################################################################################################################################################

# Fonction version de l'OS
function versionOS() {
    echo "=========================================="
    echo "Information version système d'exploitation"
    echo "=========================================="
    echo ""
    version=$(cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d '"' -f2)
    echo "Votre système d'exploitation est: $version"
    read -p "Appuyer sur entrer pour revenir au menu principal"
}


# Fonction Détail des partitions
function disk2() {
    echo "======================="
    echo "Information des disques"
    echo "======================="
    echo ""
    # 2)Détails de partitionnement
    # Demander Disque concerné
    echo -e "Vous souhaitez des informations concernant les partitions de quel disque ? (0 pour sortir)"
    read -p "" disk

    # Retour menu précédent si l'utilisateur le souhaite
    if [ $disk = "0" ]
    then
        return
    fi

    # Vérifier si le disque existe
    if lsblk | grep $disk >> /dev/null
    # +) Déterminer le nombre de partitions & Leur Nom, FS et Taille
    then
            nbpart=$(df -Th | grep "$disk" | wc -l)
            echo -e "\n"
            echo -e "Il y a \e[0;32m$nbpart partitions\e[0;m sur le disque $disk."
    
            df -Th | grep $disk | sort | awk '{print $1 " " $3 " " $2}' > /tmp/part.txt

            echo -e "\n"
            while read a b c
            do 
                echo -e "La partition \e[0;32m$a\e[0;m, d'une \e[0;32mtaille de $b\e[0;m et \e[0;32mau format $c\e[0;m"
            done < /tmp/part.txt
            echo -e "\n"
    
    # -) Message erreur & Liste des disques observables
    else
        echo -e "\n"
        echo -e "\e[0;31mErreur - Le disque sélectionné est inconnu\e[0;m"
        err=$(lsblk | grep disk | awk '{print $1}')

##### A débugger : fonctionne s'il n'y a qu'un disque, pas s'il y en a plusieurs

        echo -e "\e[0;33mLa liste des disques disponibles est\e[1;36m $err\e[0;m"
        echo -e "\n"
    fi

    # Possible relance de la fonction
    read -p "Voulez-vous sélectionner un autre disque ? [O/n] " again
    if [ $again = "O" ]
    then
        disk2
    fi
}


#Fonction spacedisk
function spacedisk() {
    echo "======================="
    echo "Information des disques"
    echo "======================="
    echo ""
    # Récupérer espace libre sur le disque
    total=$(df | grep $disk | awk '{print $4}')
    for ligne in $total
    do
            sum=$(($sum + $ligne))
    done
    sum=$(numfmt --to=iec $sum)
    echo "Résultat: $sum"
}


# Fonction disk3
function disk3() {
    echo "======================="
    echo "Information des disques"
    echo "======================="
    echo ""
    # 3)Demander si l'information concerne un disque entier ou une partition
        echo "Vous souhaitez connaître l'espace disponible..."
        echo -e "1. ...d'un \e[0;36mdisque\e[0;m ?"
        echo -e "2. ...d'une \e[0;36mpartition\e[0;m ?"
        echo "3. Revenir au menu précédent"
        echo "0. Retour au menu principal"
        read -p "" choix

        case $choix in
    # 1. Disque entier - Espace restant
        1)
            read -p "Quel disque souhaitez-vous observer ? " disk
        # Vérifier existence du disque demandé
            if lsblk | grep "$disk" >> /dev/null
        # +) Appel fonction d'information sur l'espace disque
            then
                spacedisk $disk
        # -) Message erreur & Liste des disques disponibles
            else
                echo -e "\e[0;31mErreur - Le disque sélectionné est inconnu\e[0;m"
                disks=$(lsblk | grep disk | awk -v RS= '{print $1}')
                echo -e "\e[0;33mLa liste des disques disponibles est\e[1;35m $disks\e[0;m"
            fi
        ;;

    # 2. Partition - Espace restant
        2)
        # Demander le nom de la partition
            read -p "Quelle partition souhaitez-vous observer ? " part
        # Vérifier existence de la partition
            if lsblk | grep "$part" >> /dev/null

        # +) Récupérer espace libre sur la partition
            then
                echo -e "\n\n"
                df -h | grep $part | sort | awk '{print "Il reste " $4 " disponibles sur " $1}'
                echo -e "\n\n"

        # -) Message erreur & Affichage liste des partitions pour sélection & Retour Sélection Disque/Partition
            else
                echo -e "\e[0;31mErreur - La partition sélectionnée n'existe pas\e[0;m"
                list=$(lsblk | grep part | awk '{print $1}')
                echo -e "\e[0;33mLes partitions disponibles sont :\e[0;m \e[0;35m\n$list\e[0;m"
                disk3
            fi
        ;;
        3)
            return
        ;;
        0)
            exit 0
        ;;
        *)
        ;;
        esac
}


# Fonction disk4
function disk4() {
    echo "======================="
    echo "Information des disques"
    echo "======================="
    echo ""
    # 4) Recherche d'espace occupé par un répertoire
    # Demande chemin réseau du répertoire
    echo "Quel est le nom du répertoire dont vous souhaitez connaître la taille ?"
    read -p "" path

    # Vérification existence du répertoire
    if du $path > /dev/null

    # +) Affichage de l'espace occupé par le répertoire
    then
        du -sh $path | awk '{print $2 " " $1}' > /tmp/space.txt
        while read a b
        do                   
            echo -e "\n"
            echo -e "\e[0;32m$a\e[0;m occupe \e[0;32m$b\e[0;m d'espace."
            echo -e "\n"
        done < /tmp/space.txt

    # -) Message erreur
    else
        echo -e "\n"
        echo -e "\e[0;31mErreur - Le chemin spécifié est introuvable.\e[0;m"
        echo -e "\e[0;33mMerci d'entrer le chemin réseau complet\e[0;m"
        echo -e "\n"
        return
    fi
}


# Fonction disk5
function disk5() {
    echo "======================="
    echo "Information des disques"
    echo "======================="
    echo ""
    #       5)Rechercher liste des lecteur monté sur l'ordinateur et retourner liste
    #         Retourner liste
    #         Retour menu info disque et lecteur
    df | grep -v tmpfs | grep -v blocs | sort | awk '{print $1" "$6}' > /tmp/awk.txt

    echo -e "\n"
    while read a b
    do
        echo -e "Le volume \e[0;32m$a\e[0;m est monté sur \e[0;32m$b\e[0;m"
    done < /tmp/awk.txt
    echo -e "\n"

}


# Nombre d'interfaces réseau actives
function nbrInterfaces() {
    echo "=============================="
    echo "Information interfaces réseaux"
    echo "=============================="
    echo ""
    echo "Nombre d'interfaces réseau actives :"
    num_interfaces=$(ip link show | grep -c "state UP")
    echo "- $num_interfaces interfaces actives détectées"
    echo "" 
}


# Adresse IP de chaque interface
function addressIP() {
    echo "=============================="
    echo "Information interfaces réseaux"
    echo "=============================="
    echo ""
    echo "Adresse IP de chaque interface :"
    ip -o -4 addr show | while read -r line; do
    interface=$(echo "$line" | awk '{print $2}')
    ip_address=$(echo "$line" | awk '{print $4}')
    echo "- Interface $interface : IP $ip_address"
done
echo ""
}


# Adresse MAC de chaque interface
function addressMac() {
    echo "=============================="
    echo "Information interfaces réseaux"
    echo "=============================="
    echo ""
    echo "Adresse MAC de chaque interface :"
    for interface in $(ip -o link show | awk -F': ' '{print $2}'); do
        mac_address=$(ip link show "$interface" | awk '/link\/ether/ {print $2}')
        if [[ -n $mac_address ]]; then
            echo "- Interface $interface : MAC $mac_address"
        fi
    done
echo "===================================="
}

function portsOuverts() {
    echo "========================="
    echo "Information ports ouverts"
    echo "========================="
    echo ""
    echo "Les ports ouverts sur le système sont:"
    ss -tulnp | grep LISTEN | awk '{print $5}' | cut -d ':' -f2 | sort -u
    echo "================================="
    read -p "Appuyer sur entrer pour revenir au menu" 
}

function statutPareFeux() {
    echo "=============================="
    echo "Information statut du pare-feu"
    echo ""
    echo "Statut du pare-feux."
    ufw status verbose
    read -p "Appuyer sur entrer pour revenir au menu" 
}


##########################################################################################################################################################
# FONCTIONS MENUS
##########################################################################################################################################################

# Je veux proposer un menu à trois entrées : Action, Requête d'information ou Sortie du script ;
# Je veux que l'on revienne à ce menu si l'on en fait la demande => fonction


# Fonction Menu2 (Actions)
function menu2()
{
    echo -e "\n"
    echo -e "Quelle action souhaitez-vous réaliser ?"
    echo -e "=========================================================="
    echo -e "01. Création de Compte Utilisateur local"
    echo -e "02. Changement de Mot de passe"
    echo -e "03. Suppression de Compte Utilisateur local"
    echo -e "04. Activation / Désactivation de Compte Utilisateur local"
    echo -e "05. Ajouter un utilisateur au groupe Administrateurs"
    echo -e "06. Ajouter un utilisateur à un groupe local"
    echo -e "07. Retirer un utilisateur d'un groupe local"
    echo -e "08. Arrêter l'ordinateur"
    echo -e "09. Redémarrer l'ordinateur"
    echo -e "10. Verrouiller la session"
    echo -e "11. Mise-à-jour du système"
    echo -e "12. Créer un répertoire"
    echo -e "13. Modifier un répertoire"
    echo -e "14. Supprimer un répertoire"
    echo -e "15. Activer le pare-feu"
    echo -e "16. Désactiver le pare-feu"
    echo -e "17. Installation de logiciel"
    echo -e "18. Désinstallation de logiciel"
    echo -e "19. Exécution de script sur la machine distante"
    echo -e "0. Revenir en arrière"
    echo -e "=========================================================="
    echo -e "\n"
    read -p "(Taper 1, 2, ... , 19 ou 0) : " choix
    case $choix in
    1)
        # Lancement Création de Compte Utilisateur local
        createuser
    ;;
    2)
        # Lancement Changement de Mot de passe
        changepassword
    ;;
    3)
        # Lancement Suppression de compte utilisateur local
        deleteuser
    ;;
    4)
        # Lancement Désactivation de compte utilisateur local
        deactivateuser
    ;;
    5)
        # Lancement Ajout à un groupe d'administration
        ajout_admin
    ;;
    6)
        # Lancement Ajout à un groupe local
        ajout_groupe
    ;;
    7)
        # Lancement Sortie d’un groupe local
        retirer_groupe
    ;;
    8)
        # Lancement Arrêt
        arret
    ;;
    9)
        # Lancement Redémarrage
        redemarrage
    ;;
    10)
        # Lancement Verrouillage session
        verrouillage
    ;;
    11)
        # Lancement Mise-à-jour du système
        mAj
    ;;
    12)
        # Lancement Création de répertoire
        créaRep
    ;;
    13)
        # Lancement Modification de répertoire
        ModifRep
    ;;
    14)
        # Lancement Suppression de répertoire
        SuppRep
    ;;
    15)
        # Lancement Activation du pare-feu
        echo "Activation du pare-feu..."
        sudo ufw enable
        echo "Pare-feu activé."
    ;;
    16)
        # Lancement Désactivation du pare-feu
        echo "Désactivation du pare-feu..."
        sudo ufw disable
        echo "Pare-feu désactivé."
    ;;
    17)
        # Lancement Installation de logiciel
        instalLogiciel
    ;;
    18)
        # Lancement Désinstallation de logiciel
        delLogiciel
    ;;
    19)
        # Lancement Exécution de script sur la machine distante
        executer_script_distant
    ;;
    0)
        # Retour au Menu principal
        echo -e "\e[1;32mRetour en arrière\e[0;m"
        return
    ;;
    *)
        # Lancement à nouveau de ce menu
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
        menu2
    ;;
    esac
}

# Fonction Menu3 (Informations)
function menu3()
{
    echo -e "\n"
    echo -e "Quelle information recherchez-vous ?"
    echo -e "=========================================================="
    echo -e "01. Date de dernière connexion d’un utilisateur"
    echo -e "02. Date de dernière modification du mot de passe"
    echo -e "03. Liste des sessions ouvertes par l'utilisateur"
    echo -e "04. Groupe d’appartenance d’un utilisateur"
    echo -e "05. Historique des commandes exécutées par l'utilisateur"
    echo -e "06. Droits/permissions de l’utilisateur sur un dossier"
    echo -e "07. Droits/permissions de l’utilisateur sur un fichier"
    echo -e "08. Version de l'OS"
    echo -e "09. Nombre de disque"
    echo -e "10. Partition (nombre, nom, FS, taille) par disque"
    echo -e "11. Espace disque restant par partition/volume"
    echo -e "12. Nom et espace disque d'un dossier (nom de dossier demandé)"
    echo -e "13. Liste des lecteurs monté (disque, CD, etc.)"
    echo -e "14. Nombre d'interface"
    echo -e "15. Adresse IP de chaque interface"
    echo -e "16. Adresse Mac"
    echo -e "17. Liste des ports ouverts"
    echo -e "18. Statut du pare-feu"
    echo -e "19. Recherche des evenements dans le fichier log_evt.log pour un utilisateur"
    echo -e "20. Recherche des evenements dans le fichier log_evt.log pour un ordinateur"
    echo -e "0. Revenir en arrière"
    echo -e "=========================================================="
    echo -e "\n"
    read -p "(Taper 1, 2, ... , 20 ou 0) : " choix




    case $choix in
    1)
        # Lancement Date de dernière connexion d’un utilisateur
        # Utilisation de last pour obtenir la dernière connexion de l'utilisateur
        dateLastCon
    ;;
    2)
        # Lancement Date de dernière modification du mot de passe
        dateModifPW
    ;;
    3)
        # Lancement Liste des sessions ouvertes par l'utilisateur
        sessionOuverte
    ;;
    4)
        # Lancement Groupe d’appartenance d’un utilisateur
        read -p "Quel est l'utilisateur dont vous souhaitez connaître les groupes ?" user
        groups $user
    ;;
    5)
        # Lancement Historique des commandes exécutées par l'utilisateur
        historique   
    ;;
    6)
        # Lancement Droits/permissions de l’utilisateur sur un dossier
        droitsDossier  
    ;;
    7)
        # Lancement Droits/permissions de l’utilisateur sur un fichier
        droitsFichier
    ;;
    8)
        # Lancement Version de l'OS
        versionOS
    ;;
    9)
        # Lancement Nombre de disque
        echo "======================="
        echo "Information des disques"
        echo "======================="
        echo ""
        disk=$(lsblk | grep disk | wc -l)
        echo -e "\n"
        echo -e "Il y a \e[0;32m$disk disque(s)\e[0;m sur la machine."
        echo -e "\n"  
    ;;
    10)
        # Lancement Partition (nombre, nom, FS, taille) par disque
        disk2
    ;;
    11)
        # Lancement Espace disque restant par partition/volume
        disk3
    ;;
    12)
        # Lancement Nom et espace disque d'un dossier (nom de dossier demandé)
        disk4
    ;;
    13)
        # Lancement Liste des lecteurs monté (disque, CD, etc.)
        disk5
    ;;
    14)
        # Lancement Nombre d'interface
        nbrInterfaces    
    ;;
    15)
        # Lancement Adresse IP de chaque interface
        addressIP
    ;;
    16)
        # Lancement Adresse Mac
        addressMac   
    ;;
    17)
        # Lancement Liste des ports ouverts
        portsOuverts   
    ;;
    18)
        # Lancement Statut du pare-feu
        statutPareFeux
    ;;
    19)
        # Lancement Recherche des evenements dans le fichier log_evt.log pour un utilisateur
        echo "Cette fonctionnalité n'a pas encore été mise en œuvre."
    ;;
    20)
        # Lancement Recherche des evenements dans le fichier log_evt.log pour un ordinateur
        echo "Cette fonctionnalité n'a pas encore été mise en œuvre."
    ;;
    0)
        # Retour au Menu Principal
        echo -e "\e[1;32mRetour en arrière\e[0;m"
        return
    ;;
    *)
        # Lancement à nouveau de ce menu
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2, 3 ou 0 \e[0;m"
        menu3
    ;;
    esac
}

##########################################################################################################################################################
# SCRIPT
##########################################################################################################################################################

while true
do
    echo -e "\n"
    echo "Que voulez-vous faire ?"
    echo "1. Réaliser une action"
    echo "2. Rechercher une information"
    echo "0. Sortir de ce script"
    echo -e "\n"
    read -p "(Taper 1, 2 ou 0) : " choix

    case $choix in
    1)
        # Lancement du menu des Actions
        menu2
    ;;
    2)
        # Lancement du menu des Informations
        menu3
    ;;
    0)
        # Sortie
        echo -e "\e[1;35mSortie du script\e[0;m"
        echo -e "\n"
        exit 0
    ;;
    *)
        # Lancement à nouveau de ce menu (optionnel car le script est une boucle while et le ferait quoiqu'il arrive)
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
    ;;
    esac
done



