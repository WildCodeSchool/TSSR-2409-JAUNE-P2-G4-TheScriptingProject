# Fonction pour arrêter l'ordinateur
function Arret {
    Write-Output "Voulez-vous vraiment arrêter ?"
    Write-Output "1 - Arrêt immédiat"
    Write-Output "2 - Arrêt dans une minute"
    Write-Output "3 - Annuler"
    $confirmationArret = Read-Host "Choix"

    switch ($confirmationArret) {
        1 {
            Write-Output "Arrêt immédiat en cours..."
            Stop-Computer -Force
        }
        2 {
            Write-Output "Arrêt dans une minute en cours..."
            shutdown.exe /s /t 60
        }
        3 {
            Write-Output "Arrêt annulé."
            return
        }
        default {
            Write-Output "Choix invalide."
        }
    }
}

# Fonction pour redémarrer l'ordinateur
function Redemarrage {
    Write-Output "Voulez-vous vraiment redémarrer ?"
    Write-Output "1 - Redémarrage immédiat"
    Write-Output "2 - Redémarrage dans une minute"
    Write-Output "3 - Annuler"
    $confirmationRedemarrage = Read-Host "Choix"

    switch ($confirmationRedemarrage) {
        1 {
            Write-Output "Redémarrage immédiat en cours..."
            Restart-Computer -Force
        }
        2 {
            Write-Output "Redémarrage dans une minute en cours..."
            shutdown.exe /r /t 60
        }
        3 {
            Write-Output "Redémarrage annulé."
            return
        }
        default {
            Write-Output "Choix invalide."
        }
    }
}

# Fonction pour verrouiller la session
function Verrouillage {
    Write-Output "Verrouillage de la session..."
    rundll32.exe user32.dll,LockWorkStation
}

# Menu principal 
while ($true) {
    Write-Output "Que voulez-vous faire ?"
    Write-Output "1 - Arrêter l'ordinateur"
    Write-Output "2 - Redémarrer l'ordinateur"
    Write-Output "3 - Verrouiller la session"
    Write-Output "4 - Quitter"
    $choixUtilisateur = Read-Host "Choix"

    switch ($choixUtilisateur) {
        1 { Arret }
        2 { Redemarrage }
        3 { Verrouillage }
        4 {
            Write-Output "Sortie du programme."
            break
        }
        default {
            Write-Output "Choix invalide, veuillez réessayer."
        }
    }
}