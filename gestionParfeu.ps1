# Script PowerShell pour activer ou désactiver le pare-feu 

function Show-Menu {
    Write-Output ""
    Write-Output "--- Menu Principal ---"
    Write-Output "1. Activer le pare-feu"
    Write-Output "2. Désactiver le pare-feu"
    Write-Output "3. Quitter"
    Write-Output "Sélectionnez une option : "
}

do {
    Show-Menu
    $choice = Read-Host

    switch ($choice) {
        "1" {
            Write-Output "Activation du pare-feu..."
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
            Write-Output "Pare-feu activé pour tous les profils."
        }
        "2" {
            Write-Output "Désactivation du pare-feu..."
            Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
            Write-Output "Pare-feu désactivé pour tous les profils."
        }
        "3" {
            Write-Output "Quitter."
            break
        }
        default {
            Write-Output "Option invalide. Veuillez sélectionner 1, 2 ou 3."
        }
    }
} while ($choice -ne "3")

## Vérification de l'état du pare-feu
#Get-NetFirewallProfile | Select-Object Name, Enabled