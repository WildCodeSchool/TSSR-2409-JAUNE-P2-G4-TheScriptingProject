# Fonction pour lister les ports ouverts et le statut du pare-feu


function PortsOuverts {
    Clear-Host
    Write-Host "Les ports réseaux ouverts sur le système sont:"
    Get-NetTCPConnection -State Listen | Select-Object -Property LocalPort | `
    Sort-Object -Property localport -Unique    
    }  

PortsOuverts

Function StatutPareFeu {
    Clear-Host
    Write-Host "Statut des pare-feux:"
    Get-NetFirewallProfile | Select-Object -Property Name,Enabled
    }
    
StatutPareFeu
