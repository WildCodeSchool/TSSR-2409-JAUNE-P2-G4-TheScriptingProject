$clientName = Read-Host "Quelle est la cible à atteindre ? (Nom de machine complet ou Adresse IP)"
Write-Host "Avec quel compte souhaitez-vous vous connecter ?"
$userName = Read-Host "(seul un compte avec les droits administrateurs pourra exécuter toutes les tâches)"
$scriptPath = "C:\Users\Administrateur\Documents\Script.ps1"



function Execute-RemoteScript {
    param (
        [string]$ComputerName,
        [string]$UserName,
        [string]$ScriptPath)

    $securePassword = Read-Host "Mot de passe pour $UserName" -AsSecureString
    $credential = New-Object System.Management.Automation.PSCredential ($UserName, $securePassword)

    try {
        Invoke-Command -ComputerName $ComputerName -Credential $credential -ScriptBlock {
            param($Path)
            & $Path
        } -ArgumentList $ScriptPath
    }
    catch {
        Write-Error "Erreur"
    }
}

Execute-RemoteScript -ComputerName $clientName -UserName $userName -ScriptPath $scriptPath
