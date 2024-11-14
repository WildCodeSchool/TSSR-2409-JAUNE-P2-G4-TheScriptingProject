# I. Prérequis techniques
- Serveur Windows sous Windows Server 2022
    - Désactiver les pare-feux
    - Configurer la fonctionnalité SSH
    - Configurer la fonctionnalité WinRM
    - Configurer C:\Windows\System32\drivers\etc\hosts
    - Installer PowerShell 7
- Serveur Linux sous Debian 12
    - Configurer la fonctionnalité SSH
    - Configurer /etc/hosts
- Client Windows sous Windows 10
    - Désactiver les pare-feux
    - Configurer la fonctionnalité SSH
    - Configurer C:\Windows\System32\drivers\etc\hosts
    - Installer Fonctionnalité NuGet
    - Activer le Bureau distant
    - Installer Module PSWindowsUpdate
- Client Linux sous Ubuntu 24.04
    - Configurer la fonctionnalité SSH
    - Configurer /etc/hosts

# II. Installation et Configuration
## Désactivation Pare-feux

## Configuration SSH et WinRM
- Windows
    - Configurer le service SSH sur le serveur
        - Installer OpenSSH Server grâce à cette commande PowerShell à exécuter en tant qu'administrateur : `Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0`
        - Ensuite, démarrer le service : `Start-Service sshd`
        - Puis configurer le service pour qu'il démarre automatiquement : `Set-Service -Name sshd -StartupType "Automatic"`
    - Configurer le service SSH sur le client : `Add-WindowsCapability -Online -Name OpenSSH.Client`
    - Configurer WinRM sur le serveur
        - Démarrer le service WinRM : `Start-Service -Name WinRM`
        - Puis configurer le service pour qu'il démarre automatiquement : `Set-Service -Name WinRM -StartupType "Automatic"`
        - Configurer les hôtes de confiance pour les connexion : `Set-Item WSMan:\localhost\Client\TrustedHosts "172.16.40.20, cliwin01"`
    - Configurer WinRM sur le client
        - Démarrer le service WinRM : `Start-Service -Name WinRM`
        - Puis configurer le service pour qu'il démarre automatiquement : `Set-Service -Name WinRM -StartupType "Automatic"`
    - Créer ou configurer un compte Administrateur sur le client 
    - Créer une session PSSession sur le serveur : `New-PSSession -ComputerName Cliwin01 -Credential Cliwin01\Administrateur`
    
- Linux
    - Sur le serveur Debian
        ```
        sudo apt update
        sudo apt install openssh-server
        sudo service ssh start
        sudo systemctl enable ssh
        ```
    - Sur le client Ubuntu
        `sudo apt install openssh-client`

## Configuration fichiers Hosts
- Windows
- Linux
    Dans /etc/hosts, ajouter les lignes suivantes :
    ```
    172.16.40.10    SRVLX01
    172.16.40.30    CLILIN01
    ```
## Installation Powershell 7

## Installer NuGet

## Activer le bureau distant sur le client

## Installer le module PSWindowsUpdate sur le client

# III. F.A.Q.
