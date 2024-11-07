# Script PowerShell pour connaître des informations utilisateur

Write-Output "=============================="
Write-Output "Informations utilisateur"
Write-Output "=============================="
Write-Output ""

# Fonction pour afficher le menu
function Menu {
    Write-Output "Menu principal - Choisissez une action :"
    Write-Output "1) Date de dernière connexion de l'utilisateur"
    Write-Output "2) Date de dernière modification du mot de passe"
    Write-Output "3) Liste des sessions ouvertes par l'utilisateur"
    Write-Output "4) Quitter"
}

# Vérifier que le nom d'utilisateur est fourni
if ($args.Count -eq 0) {
    Write-Output "Usage: script.ps1 <nom_utilisateur>"
    exit
}

# Définir la variable utilisateur
$utilisateur = $args[0]

# Fonction pour vérifier si l'utilisateur existe
function Verifier-Utilisateur {
    $userExists = Get-LocalUser -Name $utilisateur
    if (-not $userExists) {
        Write-Output "Erreur : L'utilisateur $utilisateur n'existe pas."
        exit
    }
}

# Appel de la fonction pour vérifier l'utilisateur
Verifier-Utilisateur

# Boucle principale pour afficher le menu
while ($true) {
    Menu
    $choix = Read-Host "Entrez votre choix (1-4)"

    switch ($choix) {
        1 {
            # Obtenir la dernière date de connexion de l'utilisateur
            Write-Output "Date de dernière connexion de l'utilisateur $utilisateur :"
            $derniereConnexion = (Get-WinEvent -LogName System -FilterXPath "*[System[(EventID=7001 or EventID=7002)]]" |
                Sort-Object TimeCreated -Descending |
                Select-Object -First 1).TimeCreated
            if ($derniereConnexion) {
                Write-Output $derniereConnexion
            } else {
                Write-Output "Aucune information de connexion disponible pour cet utilisateur."
            }
        }
        2 {
            # Date de dernière modification du mot de passe de l'utilisateur
            Write-Output "Date de dernière modification du mot de passe de l'utilisateur $utilisateur :"
            $modifMotDePasse = (Get-LocalUser -Name $utilisateur).PasswordLastSet
            if ($modifMotDePasse) {
                Write-Output $modifMotDePasse
            } else {
                Write-Output "Aucune date de modification de mot de passe disponible pour cet utilisateur."
            }
        }
        3 {
            # Liste des sessions ouvertes par l'utilisateur 
            Write-Output "Sessions ouvertes par l'utilisateur $utilisateur :"
            $sessions = Get-WmiObject -Class Win32_ComputerSystem | Where-Object { $_.UserName -like "*$utilisateur*" }
            if ($sessions) {
                $sessions | Format-Table -Property UserName, Name, Domain
            } else {
                Write-Output "Aucune session ouverte trouvée pour cet utilisateur."
            }
        }
        4 {
            # Quitter le script
            Write-Output "Quitter le script."
            exit
        }
        Default {
            Write-Output "Choix invalide, veuillez entrer 1, 2, 3 ou 4."
        }
    }
    Write-Output ""
}