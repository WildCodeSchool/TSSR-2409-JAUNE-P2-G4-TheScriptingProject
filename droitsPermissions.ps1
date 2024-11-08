Write-Output "======================================"
Write-Output "Vérification des droits et permissions"
Write-Output "======================================"

# Fonction pour afficher le menu
function Menu {
    Write-Output "Menu principal - Choisissez une action :"
    Write-Output "1) Vérifier les droits sur un dossier"
    Write-Output "2) Vérifier les droits sur un fichier"
    Write-Output "3) Quitter"
}

# Vérifier que le nom d'utilisateur est fourni
if ($args.Count -lt 1) {
    Write-Output "Usage: script.ps1 <nom_utilisateur>"
    exit
}

# Définir la variable utilisateur
$utilisateur = $args[0]

# Boucle principale pour afficher le menu
while ($true) {
    Menu
    $choix = Read-Host "Entrez votre choix (1-3)"

    switch ($choix) {
        1 {
            # Demander le chemin du dossier
            $cheminDossier = Read-Host "Entrez le chemin complet du dossier"

            # Vérifier si le dossier existe
            if (-not (Test-Path -Path $cheminDossier -PathType Container)) {
                Write-Output "Erreur : Le dossier spécifié n'existe pas."
                continue
            }

            # Obtenir les permissions sur le dossier
            Write-Output "Permissions de l'utilisateur $utilisateur sur le dossier $cheminDossier :"
            $permissions = (Get-Acl -Path $cheminDossier).Access | Where-Object { $_.IdentityReference -like "*$utilisateur*" }
            if ($permissions) {
                $permissions | Format-Table -Property IdentityReference, FileSystemRights, AccessControlType
            } else {
                Write-Output "Aucune permission trouvée pour cet utilisateur sur le dossier spécifié."
            }
        }
        2 {
            # Demander le chemin du fichier
            $cheminFichier = Read-Host "Entrez le chemin complet du fichier"

            # Vérifier si le fichier existe
            if (-not (Test-Path -Path $cheminFichier -PathType Leaf)) {
                Write-Output "Erreur : Le fichier spécifié n'existe pas."
                continue
            }

            # Obtenir les permissions sur le fichier
            Write-Output "Permissions de l'utilisateur $utilisateur sur le fichier $cheminFichier :"
            $permissions = (Get-Acl -Path $cheminFichier).Access | Where-Object { $_.IdentityReference -like "*$utilisateur*" }
            if ($permissions) {
                $permissions | Format-Table -Property IdentityReference, FileSystemRights, AccessControlType
            } else {
                Write-Output "Aucune permission trouvée pour cet utilisateur sur le fichier spécifié."
            }
        }
        3 {
            # Quitter le script
            Write-Output "Quitter le script."
            exit
        }
        Default {
            Write-Output "Choix invalide, veuillez entrer 1, 2 ou 3."
        }
    }
    Write-Output ""
}