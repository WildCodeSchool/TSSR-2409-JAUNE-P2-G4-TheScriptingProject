function verionOS() {
    #Nettoyage de l'écran 
    Clear-Host
    #Recherche de la version de l'OS
    $OSVersion = $(Get-WmiObject -Class win32_operatingsystem | select-object -Property caption)
    #Affichage de l'information
    Write-Host "Le systeme d'exploitation acuel sur cette ordinateur est: "$OSVersion.caption""
    }
    
    #####Ajouter fonction enregistrement dans journal de log###
    
    function menuDeRetour() {
    write-host "Choix 1: Retour au menu precedant"
    Write-Host "Choix 2: Retour au menu principal"
    $choixRetour = Read-host "Faite votre choix"
        switch ($choixRetour) {
            1 { menu information ordinateur }
            2 { menu information principal }
            default {Write-Host "La commande selectionnee est inconnue" 
            menuDeRetour
            }
        }
    }

    verionOS
    menuDeRetour