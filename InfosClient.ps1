# Version de l'OS
function versionOS() {
    #Nettoyage de l'écran 
    Clear-Host
    #Recherche de la version de l'OS
    $OSVersion = $(Get-WmiObject -Class win32_operatingsystem | select-object -Property caption)
    #Affichage de l'information
    Write-Host "Le systeme d'exploitation acuel sur cette ordinateur est: "$OSVersion.caption""
    }

# Nombre de disque


# Partition (nombre, nom, FS, taille) par disque


# Espace disque restant par partition/volume


# Nom et espace disque d'un dossier (nom de dossier demandé)


# Liste des lecteurs monté (disque, CD, etc.)


# Nombre d'interface


# Adresse IP de chaque interface


# Adresse Mac


# Liste des ports ouverts


# Statut du pare-feu
# Déjà dans le menu