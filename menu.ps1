
# Je veux proposer un menu à trois entrées : Action, Requête d'information ou Sortie du script ;
# Je veux que l'on revienne à ce menu si l'on en fait la demande => fonction


# Fonction Menu2 (Actions)
function menu2
{
    Write-Host "`n"
    Write-Host "Quelle action souhaitez-vous réaliser ?"
    Write-Host "=========================================================="
    Write-Host "01. Création de Compte Utilisateur local"
    Write-Host "02. Changement de Mot de passe"
    Write-Host "03. Suppression de Compte Utilisateur local"
    Write-Host "04. Activation / Désactivation de Compte Utilisateur local"
    Write-Host "05. Ajouter un utilisateur au groupe Administrateurs"
    Write-Host "06. Ajouter un utilisateur à un groupe local"
    Write-Host "07. Retirer un utilisateur d'un groupe local"
    Write-Host "08. Arrêter l'ordinateur"
    Write-Host "09. Redémarrer l'ordinateur"
    Write-Host "10. Verrouiller la session"
    Write-Host "11. Mise-à-jour du système"
    Write-Host "12. Créer un répertoire"
    Write-Host "13. Modifier un répertoire"
    Write-Host "14. Supprimer un répertoire"
    Write-Host "15. Prise en main à distance (GUI)"
    Write-Host "16. Activer le pare-feu"
    Write-Host "17. Désactiver le pare-feu"
    Write-Host "18. Installation de logiciel"
    Write-Host "19. Désinstallation de logiciel"
    Write-Host "20. Exécution de script sur la machine distante"
    Write-Host "0. Revenir en arrière"
    Write-Host "=========================================================="
    Write-Host "`n"
    $choix=Read-Host "(Taper 1, 2, ... , 20 ou 0)"
    Switch ( $choix )
    {
        1
            {
                # Lancement Création de compte utilisateur local
                createuser
            }
        2
            {
                # Lancement Changement de mot de passe
                changepassword
            }
        3
            {
                # Lancement Suppression de compte utilisateur local
                deleteuser
            }
        4
            {
                # Lancement Désactivation de compte utilisateur local
                deactivateuser
            }
        5
            {
                # Lancement Ajout à un groupe d'administration
                $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
                Ajouter_Utilisateur_Admin -NomUtilisateur $utilisateur
            }
        6
            {
                # Lancement Ajout à un groupe local
                $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
                $groupe = Read-Host "Entrez le nom du groupe local"
                Ajouter_Utilisateur_Groupe_Local -NomUtilisateur $utilisateur -NomGroupe $groupe
            }
        7
            {
                # Lancement Sortie d’un groupe local
                $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
                $groupe = Read-Host "Entrez le nom du groupe local"
                Supprimer_Utilisateur_Groupe_Local -NomUtilisateur $utilisateur -NomGroupe $groupe
            }
        8
            {
                # Lancement Arrêt
                Fonction-Arret
            }
        9
            {
                # Lancement Redémarrage
                Fonction-Redemarrage
            }
        10
            {
                # Lancement Verrouillage session
                Fonction-Verrouillage
            }
        11
            {
                # Lancement Mise-à-jour du système
                MiseAJour
            }
        12
            {
                # Lancement Création de répertoire
                CréaRep
            }
        13
            {
                # Lancement Modification de répertoire
                ModifRep
            }
        14
            {
                # Lancement Suppression de répertoire
                SuppRep
            }
        15
            {
                # Lancement Fonction Prise en main à distance GUI
                
            }
        16
            {
                # Lancement Activation du pare-feu
                Write-Output "Activation du pare-feu..."
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
                Write-Output "Pare-feu activé pour tous les profils."
            }
        17
            {
                # Lancement Désactivation du pare-feu
                Write-Output "Désactivation du pare-feu..."
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
                Write-Output "Pare-feu désactivé pour tous les profils."
            }
        18
            {
                # Lancement Installation de logiciel
                # Fonction install-software
            }
        19
            {
                # Lancement Désinstallation de logiciel
                # Fonction uninstall-software
            }
        20
            {
                # Lancement Exécution de script sur la machine distante
                # Fonction scriptexec
            }
        0
            {
                # Retour au Menu principal
                Write-Host "Retour en arrière"
                Return
            }
        default
            {
                # Lancement à nouveau de ce menu
                Write-Host "Mauvaise entrée. Tapez 1, 2 ou 0 "
            }
    }
}

# Fonction Menu3 (Informations)
function menu3
{
    Write-Host "`n"
    Write-Host "Quelle information recherchez-vous ?"
    Write-Host "=========================================================="
    Write-Host "01. Date de dernière connexion d’un utilisateur"
    Write-Host "02. Date de dernière modification du mot de passe"
    Write-Host "03. Liste des sessions ouvertes par l'utilisateur"
    Write-Host "04. Groupe d’appartenance d’un utilisateur"
    Write-Host "05. Historique des commandes exécutées par l'utilisateur"
    Write-Host "06. Droits/permissions de l’utilisateur sur un dossier"
    Write-Host "07. Droits/permissions de l’utilisateur sur un fichier"
    Write-Host "08. Version de l'OS"
    Write-Host "09. Nombre de disque"
    Write-Host "10. Partition (nombre, nom, FS, taille) par disque"
    Write-Host "11. Espace disque restant par partition/volume"
    Write-Host "12. Nom et espace disque d'un dossier (nom de dossier demandé)"
    Write-Host "13. Liste des lecteurs monté (disque, CD, etc.)"
    Write-Host "14. Nombre d'interface"
    Write-Host "15. Adresse IP de chaque interface"
    Write-Host "16. Adresse Mac"
    Write-Host "17. Liste des ports ouverts"
    Write-Host "18. Statut du pare-feu"
    Write-Host "19. Recherche des evenements dans le fichier log_evt.log pour un utilisateur"
    Write-Host "20. Recherche des evenements dans le fichier log_evt.log pour un ordinateur"
    Write-Host "0. Revenir en arrière"
    Write-Host "=========================================================="
    Write-Host "`n"
    $choix=Read-Host "(Taper 1, 2, ... , 20 ou 0)"
    Switch ( $choix )
    {
        1
            {
                # Lancement Date de dernière connexion d’un utilisateur
                Write-Output "Date de dernière connexion de l'utilisateur $Utilisateur :"
                $lastLogin = (Get-EventLog -LogName Security -InstanceId 4624 | Where-Object { $_.ReplacementStrings[5] -eq $Utilisateur } | Select-Object -First 1).TimeGenerated
                if ($lastLogin) {
                    Write-Output $lastLogin
                } else {
                    Write-Output "Aucune information de connexion disponible."
                }
            }
        2
            {
                # Lancement Date de dernière modification du mot de passe
                Write-Output "Date de dernière modification du mot de passe de l'utilisateur $Utilisateur :"
                $userInfo = Get-LocalUser -Name $Utilisateur
                if ($userInfo.LastPasswordChangeTime) {
                    Write-Output $userInfo.LastPasswordChangeTime
                } else {
                    Write-Output "Aucune date de changement enregistrée."
                }
            }
        3
            {
                # Lancement Liste des sessions ouvertes par l'utilisateur
                Write-Output "Sessions ouvertes par l'utilisateur $Utilisateur :"
                $sessions = Get-Process -IncludeUserName | Where-Object { $_.UserName -match $Utilisateur }
                if ($sessions) {
                    $sessions | ForEach-Object { Write-Output "Session ouverte par $($_.UserName) sur le processus $($_.ProcessName)" }
                } else {
                    Write-Output "Aucune session ouverte trouvée pour cet utilisateur."
                }
            }
        4
            {
                # Lancement Groupe d’appartenance d’un utilisateur
                
            }
        5
            {
                # Lancement Historique des commandes exécutées par l'utilisateur
                
            }
        6
            {
                # Lancement Droits/permissions de l’utilisateur sur un dossier
                droitDossier
            }
        7
            {
                # Lancement Droits/permissions de l’utilisateur sur un fichier
                droitFichier
            }
        8
            {
                # Lancement Version de l'OS
                versionOS
            }
        9
            {
                # Lancement Nombre de disque
                Get-Disk
            }
        10
            {
                # Lancement Partition (nombre, nom, FS, taille) par disque
                Get-Partition
            }
        11
            {
                # Lancement Espace disque restant par partition/volume
                Get-WmiObject -Class Win32_LogicalDisk
            }
        12
            {
                # Lancement Nom et espace disque d'un dossier (nom de dossier demandé)
                disk4
            }
        13
            {
                # Lancement Liste des lecteurs monté (disque, CD, etc.)
                Write-Host "La liste des lecteurs montés sur l'ordinateur est : "
                Get-PSDrive | Where-Object -Property Root | Select-Object -Property Name,Root
            }
        14
            {
                # Lancement Nombre d'interface
                # Nombre d'interfaces réseau actives
                Write-Output "Nombre d'interfaces réseau actives :"
                $numInterfaces = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).Count
                Write-Output "- $numInterfaces interfaces actives détectées"
                Write-Output ""
            }
        15
            {
                # Lancement Adresse IP de chaque interface
                Write-Output "Adresse IP de chaque interface :"
                Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne "127.0.0.1" } | ForEach-Object {
                    Write-Output "- Interface $($_.InterfaceAlias) : IP $($_.IPAddress)"
                }
                Write-Output ""
            }
        16
            {
                # Lancement Adresse Mac
                # Adresse MAC de chaque interface
                Write-Output "Adresse MAC de chaque interface :"
                Get-NetAdapter | ForEach-Object {
                    if ($_.MacAddress) {
                        Write-Output "- Interface $($_.Name) : MAC $($_.MacAddress)"
                    }
                }
            }
        17
            {
                # Lancement Liste des ports ouverts
                
            }
        18
            {
                # Lancement Statut du pare-feu
                Get-NetFirewallProfile | Select-Object -Property Name,Enabled
            }
        19
            {
                # Lancement Recherche des evenements dans le fichier log_evt.log pour un utilisateur
                
            }
        20
            {
                # Lancement Recherche des evenements dans le fichier log_evt.log pour un ordinateur
                
            }
        0
            {
                # Retour au Menu Principal
                Write-Host "Retour en arrière"
                return
            }
        default 
            {
                # Lancement à nouveau de ce menu
                Write-Host "Mauvaise entrée. Tapez 1, 2, ... , 20 ou 0 "
            }
    }
    return
}


# Dot-sourcing des différentes fonctions
. $PSScriptRoot\ActionsUtilisateur.ps1
. $PSScriptRoot\ActionsClient.ps1
. $PSScriptRoot\InfosUtilisateur.ps1
. $PSScriptRoot\InfosClient.ps1
. $PSScriptRoot\journalisation.ps1

# Début journalisation
$date=$(Get-Date -Format "yyyymmdd-HHmmss")
$user=$($env:USERNAME)
Write-Output "$date-$user-********StartScript********" >> C:\Windows\System32\LogFiles\log_evt.log


while ( $true )
{
    Write-Host "`n"
    Write-Host "Que voulez-vous faire ?"
    Write-Host "1. Réaliser une action"
    Write-Host "2. Rechercher une information"
    Write-Host "0. Sortir de ce script"
    Write-Host "`n"
    $choix= Read-Host "(Taper 1, 2 ou 0)"

    Switch ( $choix )
    {
        1
            {
            # Lancement du menu des Actions
            menu2
            }
        2
            {
            # Lancement du menu des Informations
            menu3
            }
        0
            {
            # Sortie
            Write-Host "Sortie du script"
            # Fin journalisation
            $date=$(Get-Date -Format "yyyymmdd-HHmmss")
            $user=$($env:USERNAME)
            Write-Output "$date-$user-*********EndScript*********" >> C:\Windows\System32\LogFiles\log_evt.log
            exit 0
            }
        default 
            {
            # Lancement à nouveau de ce menu (optionnel car le script est une boucle while et le ferait quoiqu'il arrive)
            Write-Host "Mauvaise entrée. Tapez 1, 2 ou 0 "
            }
    }
}