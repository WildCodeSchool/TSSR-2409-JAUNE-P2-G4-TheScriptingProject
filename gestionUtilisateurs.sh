#! /bin/bash


##Création d'un nouveau compte utilisateur local
function createuser ()
{
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
function changepassword()
{
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
function deleteuser()
{
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


function deactivateuser()
{
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


function manageusers ()
{
    echo -e "\n"
    echo -e "Quelle action voulez-vous effectuer sur les Comptes Utilisateur ?"
    echo -e "1. Création de Compte Utilisateur local"
    echo -e "2. Changement de Mot de passe"
    echo -e "3. Suppression de Compte Utilisateur local"
    echo -e "4. Activation / Désactivation de Compte Utilisateur local"
    echo -e "9. Menu Précédent"
    echo -e "0. Menu Principal"
    read -p "" choix

    case $choix in

    1)
        echo -e "\n"
        createuser
    ;;
    2)
        echo -e "\n"
        changepassword
    ;;
    3)
        echo -e "\n"
        deleteuser
    ;;
    4)
        echo -e "\n"
        deactivateuser
    ;;
    9)
        echo -e "\n"
        echo -e "\e[0;35mRetour au menu précédent\e[0;m"
        return 0
    ;;
    0)
        echo -e "\n"
        echo -e "\e[0;35mRetour au menu principal\e[0;m"
        exit 0
    ;;
    *)
        echo -e "\n"
        echo -e "\e[0;31mErreur - Choix introuvable.\e[0;m"
        echo -e "\e[0;33mMerci d'entrer un des choix de la liste suivante\e[0;m"
        echo -e "\n"
    ;;
    esac
}

while true
do
    manageusers
done