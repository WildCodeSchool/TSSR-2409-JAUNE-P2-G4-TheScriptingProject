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
            echo -e "Il y a \e[0;32m$nbpart partitions\e[0;m sur le disque $disk."
    #                   nom des partition
    #                   File System            
    #                   taille de la partition (lsblk | grep part) ou (df -h | grep $disk)
            df -Th | grep $disk | sort | awk '{print $1 " " $3 " " $2}' > /tmp/part.txt

            while read a b c
            do 
                echo -e "La partition \e[0;32m$a\e[0;m, d'une \e[0;32mtaille de $b\e[0;m et \e[0;32mau format $c\e[0;m"
            done < /tmp/part.txt
    #                   Retour au menu des info disques et lecteurs            
    #             Sinon
    else
    #                   message d'erreur le disque sélectionné est inconnue
        echo -e "\e[0;31mErreur - Le disque sélectionné est inconnu\e[0;m"
    #                   afficher liste des disques
        err=$(lsblk | grep disk | awk '{print $1}')

##### A débugger : fonctionne s'il n'y a qu'un disque, pas s'il y en a plusieurs

        echo -e "\e[0;33mLa liste des disques disponibles est\e[1;35m $err\e[0;m"
    #             fin
    fi

    # demander si l'utilisateur souhaite sélectionner un autre disque
    read -p "Voulez-vous sélectionner un autre disque ? [O/n] " again
    #                   Si oui      
    if [ $again = "O" ]
    #                   Alors 
    then
    #   relancer fonction partition
        disk2
    #                   Sinon fin
    fi
}

#Fonction spacedisk
function spacedisk()
{
#   récupérer espace libre sur le disque
    df | grep $disk | awk '{print $4}' | sed ':a;N;$!ba;s/\n/ /g' > /tmp/space.txt

    while read a b
    do                   
        result=$(($a + $b))
        result=$(numfmt --to=iec $result)
        echo -e "\n"
        echo -e "Il reste \e[0;32m$result\e[0;m disponibles sur \e[0;32m$disk\e[0;m"
        echo -e "\n"
    done < /tmp/space.txt
   
}
# Fonction disk3
function disk3()
{
    #       3)Demander si l'information concerne un disque entier ou une partition
        echo "Vous souhaitez connaître l'espace disponible..."
        echo -e "1. ...d'un \e[0;36mdisque\e[0;m ?"
        echo -e "2. ...d'une \e[0;36mpartition\e[0;m ?"
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
            if lsblk | grep "$disk" >> /dev/null
    #                       si disque existe
            then
    #                       alors
                spacedisk $disk
    #                           retourner nom du disque et taille d'espace libre
    #                       Sinon
            else
    #                           message d'erreur le disque sélectionné n'existe pas
                echo -e "\e[0;31mErreur - Le disque sélectionné est inconnu\e[0;m"
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
                echo -e "\n\n"
                df -h | grep $part | sort | awk '{print "Il reste " $4 " disponibles sur " $1}'
                echo -e "\n\n"
    #                           retourner nom de la partition et taille d'espace libre
    #                       Sinon
            else
    #           message d'erreur la partition sélectionné n'existe pas
                echo -e "\e[0;31mErreur - La partition sélectionnée n'existe pas\e[0;m"
                list=$(lsblk | grep part | awk '{print $1}')
                echo -e "\e[0;33mLes partitions disponibles sont :\e[0;m \e[0;35m\n$list\e[0;m"
    #                           afficher liste des partitions
    #                           retour début de la fonction break 
                disk3
    #                       fin
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
function disk4()
{
#       4)Quel est le nom du répertoire dont vous souhaitez connaître la taille
    read -p "Quel est le nom du répertoire dont vous souhaitez connaître la taille ? " directory
#           rechercher fichier dans les espace de stockages
    if du | grep $directory
#               Si résultat positif
#               Alors 
    then
        echo "OK"
#                   retourner nom du dossier et taille
#               Sinon 
    else
        echo "NOK"
        return
    fi
#                   retourner message: dossier inconnu
#                   retour menu info disque et lecteur
#               fin
}

#Information sur les disques et lecteurs
function infodisk()
{
    #Afficher le menu des informations disponibles
    echo -e "Quelle information souhaitez-vous récupérer ?"
    echo -e "1-\e[0;36mNombre de disques\e[0;m présent sur l'ordinateur"
    echo -e "2-\e[0;36mDétails des partitions\e[0;m présente sur un disque"
    echo -e "3-\e[0;36mEspace disponible\e[0;m"
    echo -e "4-\e[0;36mEmplacement d'un dossier\e[0;m"
    echo -e "5-\e[0;36mLecteurs montés\e[0;m sur l'ordinateur"
    echo "6-Retour au menu précédent"
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
        disk=$(lsblk | grep disk | wc -l)
        echo -e "\n"
        echo -e "Il y a \e[0;32m$disk disque(s)\e[0;m sur la machine."
        echo -e "\n"
    ;;

    2)  
        echo -e "\n"    
        disk2
    ;;

    3)
        echo -e "\n"
        disk3
    ;;

    4)
        echo -e "\n\n"
        disk4
    ;;      

    5)
    #       5)Rechercher liste des lecteur monté sur l'ordinateur et retourner liste
    #         Retourner liste
    #         Retour menu info disque et lecteur
    ;;  

    6)
    #       6)Retour au menu précédent : information sur un ordinateur client
        echo -e "\e[0;35mRetour au menu précédent\e[0;m"
    ;;

    0)
    #       7)Retour au menu principal
        echo -e "\e[0;35mRetour au menu principal\e[0;m"
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
