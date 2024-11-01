###############################################################################
#                                                                             #
#                                   PREREQUIS                                 #
#                                                                             #
# Avoir créé le fichier C:\Windows\System32\LogFiles\log_evt.log au préalable #
#                                                                             #
#              Avoir donné les droits d'écriture sur le fichier               #
#                                                                             #
###############################################################################

function journalisation()
{
    # Définition des variables Date/Heure/Utilisateur
    $date=$(Get-Date -Format "yyyymmdd-hhmmss")
    $user=$($env:USERNAME)

    # Récupération de l'action à enregistrer placée en argument
    $action=$ARGS[0]

    # Compilation du tout dans le fichier log
    Write-Output "$date-$user-$action" >> C:\Windows\System32\LogFiles\log_evt.log
}

Clear-Host
journalisation $ARGS[0]