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

- 1 - Téléchargez PowerShell 7 :

    - Ouvrez votre navigateur sur le serveur.
    - Rendez-vous sur la page de téléchargement officielle : https://github.com/PowerShell/PowerShell/releases.
    - Recherchez la dernière version stable de PowerShell 7.
    - Téléchargez le fichier .msi.

 - 2 - Installez PowerShell 7 :

    - Ouvrez le fichier .msi téléchargé pour lancer l’installation.
    - Suivez les étapes de l’assistant d’installation :
        - Acceptez les conditions de licence.
        - Laissez l’emplacement d’installation par défaut.
        - Cochez "Add to PATH Environment Variable" pour que PowerShell 7 soit accessible depuis n'importe où dans l'invite de commande.
        - Cliquez sur Installer et laissez l’installation se terminer.

 - 3 - Vérifiez l’installation :

    - Ouvrez une invite de commande ou PowerShell.
    - Tapez pwsh pour démarrer PowerShell 7.
    - Pour confirmer la version, exécutez la commande suivante dans PowerShell 7 :
```
Powershell

$PSVersionTable.PSVersion
```

## Installer NuGet

 1- Ouvrez PowerShell 7 en tant qu’administrateur.

 - Installer le fournisseur NuGet pour PowerShell :

    - Si vous n’avez jamais utilisé NuGet dans PowerShell, vous devez d’abord installer le fournisseur NuGet. PowerShell le proposera automatiquement lors de la première utilisation de la commande Install-Module.
   Exemple, exécutez la commande suivante pour installer un module depuis la galerie PowerShell. Cela déclenchera l’installation du fournisseur NuGet :
```
Powershell
Install-Module -Name PackageManagement -Force
```

Exécutez la commande suivante pour voir la liste des sources de packages disponibles NuGet devrait être présent dans la liste des sources de packages.:
```
Powershell
Get-PackageSource
```
## Activer le bureau distant sur le client

 - Activer le Bureau à distance via les Paramètres de Windows

    - 1 - Ouvrir les Paramètres :
        Cliquez sur le bouton Démarrer, puis sélectionnez Paramètres.

    - 2 - Naviguer vers Système :
        Dans la fenêtre Paramètres, sélectionnez Système.

    - 3 - Accéder aux paramètres de Bureau à distance :
        Dans le menu de gauche, faites défiler vers le bas et cliquez sur Bureau à distance.

    - 4 - Activer le Bureau à distance :
        Dans la section Bureau à distance, faites glisser le bouton Activer le Bureau à distance sur Activé.
        Une fenêtre de confirmation apparaît. Cliquez sur Confirmer pour activer le Bureau à distance.


## Installer le module PSWindowsUpdate sur le client

 - Voici la manière la plus simple d'installer le module PSWindowsUpdate :

    - 1 - Ouvrez PowerShell en tant qu'administrateur.

    - 2 - Exécutez la commande suivante pour installer le module directement depuis la PowerShell Gallery :
```
Powershell
Install-Module -Name PSWindowsUpdate -Force
```
 PSWindowsUpdate est maintenant installé et prêt à être utilisé 

# III. F.A.Q.
