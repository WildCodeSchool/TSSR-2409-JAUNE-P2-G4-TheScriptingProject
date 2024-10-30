#!/bin/bash
# Fonction Détail des partitions
function disk2()
{
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
function spacedisk()
{
    # Récupérer espace libre sur le disque
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
function disk4()
{
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
function disk5()
{
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
        echo -e "\n"
        disk4
    ;;      

    5)
        echo -e "\n"
        disk5
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
