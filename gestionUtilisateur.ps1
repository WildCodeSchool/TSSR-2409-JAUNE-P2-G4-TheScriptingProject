# Fonction pour afficher le menu
function Menu {
    Write-Output "Menu principal - Choisissez une action :"
    Write-Output "1) Date de dernière connexion de l'utilisateur"
    Write-Output "2) Date de dernière modification du mot de passe"
    Write-Output "3) Liste des sessions ouvertes par l'utilisateur"
    Write-Output "4) Quitter"
}

# Vérifier que le nom d'utilisateur est fourni
if (-not $args[0]) {
    Write-Output "Usage: .\script.ps1 <nom_utilisateur>"
    exit
}

$Utilisateur = $args[0]

# Vérifier si l'utilisateur existe
if (-not (Get-LocalUser -Name $Utilisateur)) {
    Write-Output "Erreur : L'utilisateur $Utilisateur n'existe pas."
    exit
}

# Boucle principale du menu
while ($true) {
    Menu
    $choix = Read-Host "Entrez votre choix (1-4)"

    switch ($choix) {
        1 {
            # Date de dernière connexion
            Write-Output "Date de dernière connexion de l'utilisateur $Utilisateur :"
            $lastLogin = (Get-EventLog -LogName Security -InstanceId 4624 | Where-Object { $_.ReplacementStrings[5] -eq $Utilisateur } | Select-Object -First 1).TimeGenerated
            if ($lastLogin) {
                Write-Output $lastLogin
            } else {
                Write-Output "Aucune information de connexion disponible."
            }
        }
        2 {
            # Date de dernière modification du mot de passe
            Write-Output "Date de dernière modification du mot de passe de l'utilisateur $Utilisateur :"
            $userInfo = Get-LocalUser -Name $Utilisateur
            if ($userInfo.LastPasswordChangeTime) {
                Write-Output $userInfo.LastPasswordChangeTime
            } else {
                Write-Output "Aucune date de changement enregistrée."
            }
        }
        3 {
            # Liste des sessions ouvertes
            Write-Output "Sessions ouvertes par l'utilisateur $Utilisateur :"
            $sessions = Get-Process -IncludeUserName | Where-Object { $_.UserName -match $Utilisateur }
            if ($sessions) {
                $sessions | ForEach-Object { Write-Output "Session ouverte par $($_.UserName) sur le processus $($_.ProcessName)" }
            } else {
                Write-Output "Aucune session ouverte trouvée pour cet utilisateur."
            }
        }
        4 {
            # Quitter le script
            Write-Output "Quitter le script."
            exit
        }
        default {
            Write-Output "Choix invalide, veuillez entrer 1, 2, 3 ou 4."
        }
    }
    Write-Output ""
}
