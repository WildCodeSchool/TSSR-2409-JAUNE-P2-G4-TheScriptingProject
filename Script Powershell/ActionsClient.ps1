#####################################################
#                                                   #
#          Fichier contenant les fonctions          #
#              Actions sur un Client                #
#                                                   #
#####################################################

# Arrêt
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

# Redémarrage
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

# Verrouillage
function Verrouillage {
    Write-Output "Verrouillage de la session..."
    rundll32.exe user32.dll,LockWorkStation
}

# Mise-à-jour du système
function MiseAJour() {
    # PRÉREQUIS 
    # Avoir installé le module PSWindowsUpdate
    
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
        }
    }
    else
    {
    Write-Host "Aucune mise à jours nécessaire" -ForegroundColor green
    }
}

# Création de répertoire
function CréaRep {
    Clear-Host
    $Chemin = Read-Host "Où souhaitez-vous créer un répertoire (nom avec chemin absolu)" 
    if ( Test-Path -Path $Chemin -PathType Container )
    {
        Write-Host "Le répertoire $chemin éxiste déjà!"
    }
    else
    {
        New-Item -Path $Chemin -ItemType Directory -ErrorAction Stop | Out-Null
        Write-Host "Répertoire $Chemin créé!"    
    }
}

# Modification de répertoire
function ModifRep {
    Clear-Host
    Write-Host "choix 1: Modifier le nom d'un répertoire."
    Write-Host "choix 2: Déplacer un répertoire."
    Write-Host "choix 0: Retour au menu principal."
    $SelectModiRep = Read-Host "Quelle opération souhaitez-vous réaliser?" 

    switch ( $SelectModiRep )
    {
        1{  $NameRep = Read-Host "Quel est le nom actuel du répertoire" 
            $PathRep = Read-Host "Quel est le chemin du répertoire (chemin absolu)"
            #SI le répertoire existe
            if ( Test-Path "$PathRep\$NameRep" ) 
            {
                $NewNameRep = Read-Host "Quel sera le nouveau nom du répertoire"
                #Vérification que le nouveau nom n'est pas déjà utilisé
                if ( Test-Path "$PathRep\$NewNameRep" ) 
                {
                    Write-Host "Le nom de répertoire est déjà utilisé"
                    ModifRep
                }
                else
                {
                    #Demande de confirmation de renommage du répertoire
                    $ValRename = Read-Host "Vous souhaitez renommer le répertoire $NameRep en $NewNameRep (o/n)"
                    if ( "$ValRename" -eq "o" ) 
                    {
                        Rename-Item -Path "$PathRep\$NameRep" -NewName "$NewNameRep"
                        Write-Host "Le répertoire $NameRep a bien été renommer $NewNameRep"
                    }
                    else
                    {
                        Write-Host "L'opération de renommage du répertoire $NameRep a été abandonnée!"
                    }
                }
            }    
            else
            {
                write-host "Le répertoire indiqué n'a pas été trouvé"
            }
        }

        2{  $NameRepMove = Read-Host "Quel est le nom actuel du répertoire: " 
            $PathRepMove = Read-Host "Quel est le chemin du répertoire (chemin absolu)"
            #SI le répertoire existe
            if ( Test-Path "$PathRepMove\$NameRepMove") 
            {
                $NewPathRep = Read-Host "Où souhaitez-vous déplacer le répertoire?"
                #Vérification que le nouveau nom n'est pas déjà utilisé
                if ( Test-Path "$PathRepMove\$NewPathRep" ) 
                {
                    Write-Host "Le nom et l'emplacement du répertoire existe déjà."
                    ModifRep
                }
                else
                {
                    #Demande de confirmation de renommage du répertoire
                    $ValMove = Read-Host "Vous souhaitez déplacer le répertoire $NameRepMove dans $NewPathRep (o/n)"
                    if ( "$ValMove" -eq "o" ) 
                    {
                        Move-Item -Path "$PathRepMove\$NameRepMove" -Destination "$NewPathRep\$NameRepMove"
                        Write-Host "Le répertoire $NameRepMove a bien été déplacé dans $WewPathRep"
                    }
                    else
                    {
                        Write-Host "Le déplacement du répertoire $NameRepMove a été annulé!"
                    }
                }
            }    
            else
            {
                write-host "Le répertoire indiqué n'a pas été trouvé"
            }
        }
        0{ write-host "Retour Menu Principal" } 
    }
}

# Suppression de répertoire
function SuppRep {
    Clear-Host
    $ChoixSup = Read-Host "Souhaitez vous effectuer la suppression d'un répertoire(o/n)" 
    if ( "$ChoixSup" -eq "o" ) 
    {
            $PathRepSup = Read-Host "Quel est le repertoire à supprimer (avec son chemin absolu)" 
        if ( test-Path "$PathRepSup" ) 
        {
            $ConfSup = Read-Host "Souhaitez-vous supprimer le répertoire $PathRepSup, cette action sera irrévocable(o/n)" 
            if ( "$confSup" -eq "o" )
            {
                Remove-Item "$PathRepSup"
                Write-Host "Répertoire $PathRepSup supprimé avec succès"
            }
            else
            {
                Write-Host "Suppression annulée"
            }
        }
        else
        {
        echo "Le répertoire sélectionné n'a pas été trouvé"
        SuppRep
        }
    }
}

# Prise de main à distance (GUI)
function connexionGui
{
    Write-Output "============================="
    Write-Output "Prise en main à distance Gui"
    Write-Output "============================="
    Write-Output ""

    # Récupérer l'adresse IP du client
    $remoteComputer = Read-Host "adresse_IP_du_client"  # Remplacez par l'adresse IP du client

    # Lancer la connexion RDP avec MSTSC
    Start-Process "mstsc" -ArgumentList "/v:$remoteComputer"
}

# Activation du pare-feu
# Déjà dans le menu

# Désactivation du pare-feu
# Déjà dans le menu


# Installation de logiciel
function Installer_Logiciel {
#    $Logiciel = Read-Host "Quel est le nom du logiciel que vous souhaitez installer ?"
#    Write-Host "`n"
#    Write-Output "Installation du logiciel $Logiciel..."
#    try {
#        Start-Process -FilePath "powershell" -ArgumentList "Install-Package -Name $Logiciel" -Verb RunAs -Wait
#    } catch {
#        Write-Output "Erreur : Échec de l'installation du logiciel $Logiciel. Assurez-vous que le nom est correct."
#    }
	Write-Host "Tâche non fonctionnelle"
}

# Désinstallation de logiciel
function Desinstaller_Logiciel {
#    $Logiciel = Read-Host "Quel est le nom du logiciel que vous souhaitez désinstaller ?"
#    Write-Host "`n"
#    Write-Output "Désinstallation du logiciel $Logiciel..."
#    try {
#        Start-Process -FilePath "powershell" -ArgumentList "Uninstall-Package -Name $Logiciel " -Verb RunAs -Wait
#    } catch {
#        Write-Output "Erreur : Impossible de désinstaller le logiciel $Logiciel. Assurez-vous qu'il est bien installé."
#    }
	Write-Host "Tâche non fonctionnelle"
}

# Exécution de script sur la machine distante
function Executer_ScriptDistant {
#    param (
#        [string]$MachineDistante,
#        [string]$CheminScript
#    )

#    try {
#        if (!(Test-Path $CheminScript)) {
#            Write-Output "Erreur : Le chemin du script $CheminScript est introuvable. Vérifiez le chemin et réessayez."
#            return
#        }

#        Write-Output "Copie du script vers la machine distante..."
#        Copy-Item -Path $CheminScript -Destination "\\$MachineDistante\c$\script_temp.ps1" -Force -ErrorAction Stop
#        Write-Output "Exécution du script sur la machine distante..."
#        Invoke-Command -ComputerName $MachineDistante -FilePath "C:\script_temp.ps1" -ErrorAction Stop
#    } catch {
#        Write-Output "Erreur : Impossible d'exécuter le script sur la machine distante. Vérifiez l'adresse de la machine et les autorisations."
#    }
	Write-Host "Tâche non fonctionnelle"
}