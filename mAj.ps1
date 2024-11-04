#La mise à jour du système d'exploitation nécessite l'installation du module 
#"psWindowsUpdate", ainsi que l'autorisation d'éxécutions des scriptes.

#commandes à fournirent dans le install.md pour que le script de mise à jour soit fonctionnel
#Installation du module pswindowsupdate
##Install-Module -Name pswindowsupdate -Force
#Modification des autorisation d'éxécution des scripts
##Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
#Imporatation du module psWindowsUpdate
##Import-Module PSWindowsUpdate


function menuDeRetour() {
    write-host "Choix 1: Retour au menu précédant"
    Write-Host "Choix 2: Retour au menu principal"
    $choixRetour = Read-host "Faite votre choix"
        switch ($choixRetour) {
            1 { menu information ordinateur }
            2 { menu information principal }
            default {Write-Host "La commande sélectionnée est inconnue" 
            menuDeRetour
            }
        }
    }

function MiseAJour() {
clear-host 
#Vérification des mises à jour
write-host "Veuilez patienter pendant la recherche des mises à jours disponibles."

Get-WindowsUpdate
    if ( $? -lt 0 )
    {
    $ValidationMAJ = Read-Host "Souhaitez-vous installer les mises à jours (o/n)"
        if ( $ValidationMAJ -eq "o")
        { 
        write-host "La mise à jour du système peut prendre plusieurs minutes et necessiter un redémarrage de l'ordinateur."
        Install-WindowsUpdate -AcceptAll
        Write-Host "La mise à jour du système d'exploitation est effèctuée" -ForegroundColor green
        }
        else 
        {
        Write-Host "Abandon de l'opération de mise à jour du système d'exploitation" -ForegroundColor Red
        menuDeRetour
        }
    }
    else
    {
    Write-Host "Aucune mise à jours nécessaire" -ForegroundColor green
    menuDeRetour
    }
}

MiseAJour
