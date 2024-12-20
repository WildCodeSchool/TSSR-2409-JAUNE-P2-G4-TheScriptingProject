# I. Prérequis techniques
- Serveur Windows sous Windows Server 2022
    - Désactiver les pare-feux
    - Configurer la fonctionnalité SSH
    - Configurer la fonctionnalité WinRM
    - Installer PowerShell 7
- Serveur Linux sous Debian 12
    - Configurer la fonctionnalité SSH
    - Configurer /etc/hosts
- Client Windows sous Windows 10
    - Désactiver les pare-feux
    - Configurer la fonctionnalité SSH
    - Installer Fonctionnalité NuGet
    - Activer le Bureau distant
    - Installer Module PSWindowsUpdate
- Client Linux sous Ubuntu 24.04
    - Configurer la fonctionnalité SSH
    - Configurer /etc/hosts
    - Modification du mot de passe root

___
___

# II. Installation et Configuration
## Serveur Windows sous Windows Server 2022
### Désactiver les pare-feux
### Configurer la fonctionnalité SSH
- Installer OpenSSH Server grâce à cette commande PowerShell à exécuter en tant qu'administrateur :
```
        Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
- Ensuite, démarrer le service :
```
        Start-Service sshd
```
- Puis configurer le service pour qu'il démarre automatiquement :
```
        Set-Service -Name sshd -StartupType "Automatic"
```
### Configurer la fonctionnalité WinRM
- Démarrer le service WinRM :
```
        Start-Service -Name WinRM
```
- Puis configurer le service pour qu'il démarre automatiquement :
```
        Set-Service -Name WinRM -StartupType "Automatic"
```
- Configurer les hôtes de confiance pour les connexion :
```
        Set-Item WSMan:\localhost\Client\TrustedHosts "172.16.40.20, cliwin01"
```
- Créer une session PSSession sur le serveur :
```
        New-PSSession -ComputerName Cliwin01 -Credential Cliwin01\Administrateur
```
### Installer PowerShell 7
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
        $PSVersionTable.PSVersion
```
___
## Serveur Linux sous Debian 12
### Configurer la fonctionnalité SSH
- Installer la fonctionnalité SSH
 ```
        sudo apt update
        sudo apt install openssh-server
        sudo service ssh start
        sudo systemctl enable ssh
```

- Générer une clé SSH avec la commande suivante :
```
        ssh-keygen -t rsa -b 4096
```
et la partagé au client avec la commande :

```
        ssh-copy-id utilisateur@ip_machine_client
```
- Vérification de la connexion shh avec la commande :
```
        ssh root@adresseIp 172.16.40.30
```

### Configurer /etc/hosts
Dans /etc/hosts, ajouter les lignes suivantes :
```
        172.16.40.10    SRVLX01
        172.16.40.30    CLILIN01
```
___
## Client Windows sous Windows 10
### Désactiver les pare-feux
### Configurer la fonctionnalité SSH
```
        Add-WindowsCapability -Online -Name OpenSSH.Client
```
### Configurer la fonctionnalité WinRM
- Démarrer le service WinRM :
```
        Start-Service -Name WinRM
```
- Puis configurer le service pour qu'il démarre automatiquement :
```
        Set-Service -Name WinRM -StartupType "Automatic"
```
### Installer Fonctionnalité NuGet

 1- Ouvrez PowerShell 7 en tant qu’administrateur.

 - Installer le fournisseur NuGet pour PowerShell :

    - Si vous n’avez jamais utilisé NuGet dans PowerShell, vous devez d’abord installer le fournisseur NuGet. PowerShell le proposera automatiquement lors de la première utilisation de la commande Install-Module.
   Exemple, exécutez la commande suivante pour installer un module depuis la galerie PowerShell. Cela déclenchera l’installation du fournisseur NuGet :
```
        Install-Module -Name PackageManagement -Force
```

Exécutez la commande suivante pour voir la liste des sources de packages disponibles NuGet devrait être présent dans la liste des sources de packages.:
```
        Get-PackageSource
```
### Activer le Bureau distant

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

### Installer Module PSWindowsUpdate

- 1 - Ouvrez PowerShell en tant qu'administrateur.

- 2 - Exécutez la commande suivante pour installer le module directement depuis la PowerShell Gallery :
```
        Powershell
        Install-Module -Name PSWindowsUpdate -Force
        Import-Module -Name PSWindowsUpdate
        Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
```
- PSWindowsUpdate est maintenant installé et prêt à être utilisé 
### Créer ou configurer un compte Administrateur sur le client 
___
## Client Linux sous Ubuntu 24.04
### Configurer la fonctionnalité SSH
```
sudo apt install openssh-client
```
### Configurer /etc/hosts
Dans /etc/hosts, ajouter les lignes suivantes :
```
        172.16.40.10    SRVLX01
        172.16.40.30    CLILIN01
```
### Modification du mot de passe root
```
        sudo passwd root 
```
