# Script PowerShell pour gérer les utilisateurs dans les groupes
Write-Output "===================="
Write-Output "Gestion des groupes"
Write-Output "===================="
Write-Output ""

# Ajouter un utilisateur au groupe Administrateurs 
function ajout_admin {
    param ([string]$NomUtilisateur)
    $NomGroupe = "Administrateurs"  # Groupe des administrateurs

    Add-LocalGroupMember -Group $NomGroupe -Member $NomUtilisateur
    Write-Output "L'utilisateur $NomUtilisateur a été ajouté au groupe $NomGroupe avec succès."
}

# Ajouter un utilisateur à un groupe local 
function ajout_groupe {
    param ([string]$NomUtilisateur, [string]$NomGroupe)

    Add-LocalGroupMember -Group $NomGroupe -Member $NomUtilisateur
    Write-Output "L'utilisateur $NomUtilisateur a été ajouté au groupe $NomGroupe avec succès."
}

# Retirer un utilisateur d'un groupe local 
function retirer_groupe {
    param ([string]$NomUtilisateur, [string]$NomGroupe)

    Remove-LocalGroupMember -Group $NomGroupe -Member $NomUtilisateur
    Write-Output "L'utilisateur $NomUtilisateur a été retiré du groupe $NomGroupe avec succès."
}

# Menu principal
while ($true) {
    Write-Output "Choisissez une action :"
    Write-Output "1. Ajouter un utilisateur au groupe Administrateurs"
    Write-Output "2. Ajouter un utilisateur à un groupe local"
    Write-Output "3. Retirer un utilisateur d'un groupe local"
    Write-Output "4. Quitter"
    $choix = Read-Host "Entrez votre choix"

    switch ($choix) {
        1 {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            ajout_admin -NomUtilisateur $utilisateur
        }
        2 {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $groupe = Read-Host "Entrez le nom du groupe local"
            ajout_groupe -NomUtilisateur $utilisateur -NomGroupe $groupe
        }
        3 {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $groupe = Read-Host "Entrez le nom du groupe local"
            retirer_groupe -NomUtilisateur $utilisateur -NomGroupe $groupe
        }
        4 {
            Write-Output "Quitter le script."
            break
        }
        default {
            Write-Output "Option invalide. Veuillez choisir une option valide."
        }
    }
    Write-Output ""
}