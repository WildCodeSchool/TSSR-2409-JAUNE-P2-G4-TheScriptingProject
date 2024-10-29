#!/bin/bash
# Fonction Détail des partitions
function disk2()
{
    #       2)Demander sur quel disque l'utilisateur souhaite avoir le détails du partitionnement
    read -p "Vous souhaitez des informations concernant les partitions de quel disque ? (0 pour sortir) " disk
    #         Vérifier si le disque existe

    if [ $disk = "0" ]
    then
        return
    fi

    if lsblk | grep $disk >> /dev/null
    #             Si oui
    #             Alors 
    then
    #                   Commande pour avoir les infos sur les partitions
    #sudo blkid -o list | grep $disk
    #sudo parted -l

    #                   Retourner la liste des infos sur le disque sélectionné
    #                   nombre de partitions (
            nbpart=$(df -Th | grep "$disk" | wc -l)
            echo -e "Il y a $nbpart partitions sur le disque $disk."
    #                   nom des partition
    #                   File System            
    #                   taille de la partition (lsblk | grep part) ou (df -h | grep $disk)
            df -Th | grep $disk | sort | awk '{print $1 " " $3 " " $2}' > /tmp/part.txt

            while read a b c
            do 
                echo "La partition $a, d'une taille de $b et au format $c"
            done < /tmp/part.txt
    #                   Retour au menu des info disques et lecteurs            
    #             Sinon
    else
    #                   message d'erreur le disque sélectionné est inconnue
        echo "Erreur - Le disque sélectionné est inconnu"
    #                   afficher liste des disques
        err=$(lsblk | grep disk | awk '{print $1}')
        echo "Les disques disponibles sont $err"
    #             fin
    fi

    # demander si l'utilisateur souhaite sélectionner un autre disque
    read -p "Voulez-vous sélectionner un autre disque ? [O/n] " again
    #                   Si oui      
    if [ $again = "O" ]
    #                   Alors 
    then
    #   relancer fonction partition

##### A débugger : Si $again n'est pas O, va poser la question 3x avant de sortir de la fonction

        disk2
    #                   Sinon fin
    fi
}

# Fonction disk3
function disk3()
{
    #       3)Demander si l'information concerne un disque entier ou une partition
        echo "Vous souhaitez connaître l'espace disponible..."
        echo "1. ...d'un disque ?"
        echo "2. ...d'une partition ?"
        echo "3. Revenir au menu précédent"
        echo "0. Retour au menu principal"
        read -p "" choix
    #             afficher menu 1 - disque
    #                           2 - partition    
    #                           3 - retour menu précédent
    #                           4 - retour menu principal
        case $choix in
        1)
    #             Si 1
    #                   Demander le nom du disque
            read -p "Quel disque souhaitez-vous observer ? " disk
    #                   Vérifier existence du disque demandé
            if lsblk | grep "$disk"
    #                       si disque existe
            then
    #                       alors
    #                           récupérer espace libre sur le disque
                echo "Espace libre : "
    #                           retourner nom du disque et taille d'espace libre
    #                       Sinon
            else
    #                           message d'erreur le disque sélectionné n'existe pas
                echo -e "\e[0;31mErreur - Le disque sélectionné n'existe pas\e[0;m"
    #                           afficher liste des disques
                disks=$(lsblk | grep disk | awk -v RS= '{print $1}')
                echo -e "\e[0;33mLa liste des disques disponibles est\e[1;35m $disks\e[0;m"
    #                           retour début de la fonction 
            fi
        ;;

        2)
    #            Si 2
    #                   Demander le nom de la partition
            read -p "Quelle partition souhaitez-vous observer ? " part
    #                   Vérifier existence de la partition
            if lsblk | grep "$part" >> /dev/null
    #                       si existe
    #                       alors
            then
    #                           récupérer espace libre sur la partition
    #lsblk | grep "$part" | awk -v RS= '{print $2}' 
    echo "$part" && df -h | grep "$part" | awk -v RS= '{print $4}'
    #                           retourner nom de la partition et taille d'espace libre
    #                       Sinon
            else
    #           message d'erreur la partition sélectionné n'existe pas
                echo "Erreur - La partition sélectionnée n'existe pas"
    #                           afficher liste des partitions
                lsblk | grep part
    #                           retour début de la fonction break 
                disk3
    #                       fin
            fi
        ;;

        3)

        ;;
        0)
            exit 0
        ;;
        *)
        ;;
        esac
}

#Information sur les disques et lecteurs
function infodisk()
{
    #Afficher le menu des informations disponibles
    echo "Quelle information souhaitez-vous récupérer ?"
    echo "1-Nombre de disque présent sur l'ordinateur"
    echo "2-Détail des partitions présente sur un disque"
    echo "3-Espace disponible"
    echo "4-Rechercher l'emplacement d'un dossier"
    echo "5-Liste des lecteurs montés monter sur l'ordinateur"
    echo "6-Retour au menu précédant"
    echo "0-Retour au menu principal"
    #Demander quelle information souhaite obtenir l'utilisateur -> $choixInfoCl
    read -p "" choix

    #   SI [ $choixInfoCl COMPRIS ENTRE 1-7 ]
    case $choix in
    #   Alors 
    #       case $choixInfoCl in
    1)
    #       1)Rechercher le nombre de disques présent sur la machine 
    #         Retourner la liste des disques ou le nombre
        lsblk | grep disk | wc -l
        lsblk | grep disk
    ;;

    2)      
        disk2
    ;;

    3)
        disk3
    ;;

    4)
    #       4)Quel est le nom du fichier dont vous souhaitez connaître l'emplacement
    #           rechercher fichier dans les espace de stockages
    #               Si résultat positif
    #               Alors 
    #                   retourner nom du dossier et emplacement
    #               Sinon 
    #                   retourner message: dossier inconnue
    #                   retour menu info disque et lecteur
    #               fin
    ;;      

    5)
    #       5)Rechercher liste des lecteur monté sur l'ordinateur et retourner liste
    #         Retourner liste
    #         Retour menu info disque et lecteur
    ;;  

    6)
    #       6)Retour au menu précédant : information sur un ordinateur client
    ;;

    0)
    #       7)Retour au menu principal
        echo "Retour au menu principal"
        exit 0
    ;;

    *)
    #   Sinon
    #       Message d'erreur commande inconnue
    #       Retour menu info disque et lecteur
    ;;
    esac
}

while true
do
    infodisk
done