#! /bin/bash

# Enregistrer dans le fichier log_evt.log :
#       - les activités de navigation dans les menus du script, 
#       - les demandes d’informations,
#       - les actions

# Pour windows : dans le répertoire C:\Windows\System32\LogFiles
# Pour linux : dans /var/log

# Chaque enregistrement est sous la forme 
#   <Date>  -   <Heure> -   <Utilisateur>   -   <Evenement>
#   yyyymmdd-   hhmmss  -       user        -   action

# Quand je demande une information ou réalise une action, cela crée une instance dans le fichier log_evt.log
# Appel de fonction :
#   Actions fixes :
#       - Récupération date
#       - Récupération heure
#       - Récupération nom d'utilisateur
#   Actions modulaires :
#       - Définition de l'action

function journalisation()
{
    # Assurer que l'écriture est autorisée sur le fichier log
    sudo chmod 766 /var/log/log_evt.log

    # Définition des variables Date/Heure/Utilisateur
    date=$(date +%F | tr -d '-')
    heure=$(date +%T | tr -d ':')
    user=$(w -h | cut -d ' ' -f1)

    # Récupération de l'action à enregistrer placée en argument
    action=$1

    # Compilation du tout dans le fichier log
    echo "$date-$heure-$user-$action" >> /var/log/log_evt.log
}

journalisation $1