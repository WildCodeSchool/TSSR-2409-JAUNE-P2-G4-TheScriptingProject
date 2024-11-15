#####################################################
#                                                   #
#          Fichier contenant les fonctions          #
# Requêtes d'Informations concernant un Utilisateur #
#                                                   #
#####################################################

# Date de dernière connexion d’un utilisateur
# Déjà dans le menu

# Date de dernière modification du mot de passe
# Déjà dans le menu


# Liste des sessions ouvertes par l'utilisateur
# Déjà dans le menu


# Groupe d’appartenance d’un utilisateur
function getGroups
{
    $user= Read-Host "Quel est le nom de l'utilisateur dont vous souhaitez connaître les groupes ?"
    Get-LocalGroup | ForEach-Object {
    if (Get-LocalGroupMember -Group $_ | Where-Object name -like "*\$user") { $_.name } 
    }
}

# Historique des commandes exécutées par l'utilisateur
function userhistory
{
    $user= Read-Host "Quel est le nom de l'utilisateur dont vous souhaitez connaître l'historique ?"
    Get-Content "C:\\Users\$user\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
}

# Droits/permissions de l’utilisateur sur un dossier
function droitDossier
{
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

# Droits/permissions de l’utilisateur sur un fichier
function droitFichier
{
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