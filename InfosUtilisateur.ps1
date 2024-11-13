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
    if (Get-LocalGroupMember -Group $_ | \
        Where-Object name -like "*\$user") \
            { $_.name } 
    }
}

# Historique des commandes exécutées par l'utilisateur
function userhistory
{
    $user= Read-Host "Quel est le nom de l'utilisateur dont vous souhaitez connaître l'historique ?"
    Get-Content "C:\\Users\$user\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
}

# Droits/permissions de l’utilisateur sur un dossier
# Déjà dans le menu

# Droits/permissions de l’utilisateur sur un fichier
# Déjà dans le menu