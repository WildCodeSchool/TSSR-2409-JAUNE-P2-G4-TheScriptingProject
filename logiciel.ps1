Write-Output "================="
Write-Output "Gestion logiciel"
Write-Output "================="
Write-Output ""

# Fonction pour installer un logiciel
function Installer_Logiciel {
    param (
        [string]$Logiciel
    )
    Write-Output "Installation du logiciel $Logiciel..."
    try {
        Start-Process -FilePath "powershell" -ArgumentList "Install-Package -Name $Logiciel" -Verb RunAs -Wait
    } catch {
        Write-Output "Erreur : Échec de l'installation du logiciel $Logiciel. Assurez-vous que le nom est correct."
    }
}

# Fonction pour désinstaller un logiciel
function Desinstaller_Logiciel {
    param (
        [string]$Logiciel
    )
    Write-Output "Désinstallation du logiciel $Logiciel..."
    try {
        Start-Process -FilePath "powershell" -ArgumentList "Uninstall-Package -Name $Logiciel " -Verb RunAs -Wait
    } catch {
        Write-Output "Erreur : Impossible de désinstaller le logiciel $Logiciel. Assurez-vous qu'il est bien installé."
    }
}

# Fonction pour exécuter un script PowerShell sur une machine distante
function Executer_ScriptDistant {
    param (
        [string]$MachineDistante,
        [string]$CheminScript
    )

    try {
        if (!(Test-Path $CheminScript)) {
            Write-Output "Erreur : Le chemin du script $CheminScript est introuvable. Vérifiez le chemin et réessayez."
            return
        }

        Write-Output "Copie du script vers la machine distante..."
        Copy-Item -Path $CheminScript -Destination "\\$MachineDistante\c$\script_temp.ps1" -Force -ErrorAction Stop
        Write-Output "Exécution du script sur la machine distante..."
        Invoke-Command -ComputerName $MachineDistante -FilePath "C:\script_temp.ps1" -ErrorAction Stop
    } catch {
        Write-Output "Erreur : Impossible d'exécuter le script sur la machine distante. Vérifiez l'adresse de la machine et les autorisations."
    }
}