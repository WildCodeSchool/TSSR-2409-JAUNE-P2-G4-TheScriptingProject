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
# Déjà dans le menu

# Partition (nombre, nom, FS, taille) par disque
# Déjà dans le menu

# Espace disque restant par partition/volume
# Déjà dans le menu

# Nom et espace disque d'un dossier (nom de dossier demandé)
function disk4
{
    $directory=Read-Host "Quel est le nom du répertoire dont vous souhaitez connaître la taille ?"
    $size=(Get-ChildItem -force $directory -Recurse -ErrorAction SilentlyContinue| measure Length -s).sum
    if ($size -le 0) {
        # Message erreur
        Write-Host "L'emplacement de dossier spécifié n'a pas été trouvé" -ForegroundColor Red
    } elseif ($size -lt 1024) {
        # format en B
        Write-Host "$directory occupe $Size b"
    } elseif ($size -lt 1048576) {
        # format en KB
        $size=((gci -force $directory -Recurse -ErrorAction SilentlyContinue| measure Length -s).sum / 1Kb)

        $Size = '{0:n2}' -f $size

        Write-Host "$directory occupe $Size Kb"
    } elseif ($size -lt 1073741824) {
        # format en MB
        $size=((gci -force $directory -Recurse -ErrorAction SilentlyContinue| measure Length -s).sum / 1Mb)

        $Size = '{0:n2}' -f $size

        Write-Host "$directory occupe $Size Mb"
    } elseif ($size -lt 1099511627776) {
        # format en GB
        $size=((gci -force $directory -Recurse -ErrorAction SilentlyContinue| measure Length -s).sum / 1Gb)

        $Size = '{0:n2}' -f $size

        Write-Host "$directory occupe $Size Gb"
    }
}

# Liste des lecteurs monté (disque, CD, etc.)
# Déjà dans le menu

# Nombre d'interface
# Déjà dans le menu

# Adresse IP de chaque interface
# Déjà dans le menu

# Adresse Mac
# Déjà dans le menu

# Liste des ports ouverts
function PortsOuverts {
    Clear-Host
    Write-Host "Les ports réseaux ouverts sur le système sont:"
    Get-NetTCPConnection -State Listen | Select-Object -Property LocalPort | `
    Sort-Object -Property localport -Unique    
    }  

# Statut du pare-feu
# Déjà dans le menu