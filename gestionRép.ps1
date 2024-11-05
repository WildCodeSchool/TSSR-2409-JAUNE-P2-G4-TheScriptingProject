function MenuGestionRep {
    Clear-Host
    Write-Host "Choix 1: Créer un répertoire"
    Write-Host "Choix 2: Modifier un répertoire"
    Write-Host "Choix 3: Supprimer un répertoire"
    Write-Host "Choix 4: Retour au menu précédent"
    Write-Host "Choix 5: Retour au menu principal"
    $Selection = Read-Host "Quelle action souhaitez-vous effectuer ? "

    switch ($Selection)
    {
        1{ CréaRep }
        2{ ModifRep }
        3{ SuppRep }
        4{ Write-Host "RetourMenu" }
        5{ Write-Host "Menu1" }
        *{  Write-host "Choix invalide. Veuillez réessayer."
            MenuGestionRep
        }
    }
}

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
        Write-Host"Répertoire $Chemin créé!"    
    }
}

function ModifRep {
    Clear-Host
    Write-Host "choix 1: Modifier le nom d'un répertoire."
    Write-Host "choix 2: Déplacer un répertoire."
    Write-Host "choix 3: Retour au menu précédant."
    Write-Host "choix 4: Retour au menu principal."
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
                        MenuGestionRep
                    }
                    else
                    {
                        Write-Host "L'opération de renommage du répertoire $NameRep a été abandonnée!"
                        MenuGestionRep
                    }
                }
            }    
            else
            {
                write-host "Le répertoire indiqué n'a pas été trouvé"
                MenuGestionRep
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
                        MenuGestionRep
                    }
                    else
                    {
                        Write-Host "Le déplacement du répertoire $NameRepMove a été annulé!"
                        MenuGestionRep
                    }
                }
            }    
            else
            {
                write-host "Le répertoire indiqué n'a pas été trouvé"
                MenuGestionRep
            }
        }
        3{ MenuGestionRep } 
        4{ Menu1 }
    }
}

# Suppression d'un répertoire avec validation
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
                MenuGestionRep
            }
            else
            {
                Write-Host "Suppression annulée"
                MenuGestionRep
            }
        }
        else
        {
        echo "Le répertoire sélectionné n'a pas été trouvé"
        SuppRep
        }
    }
    else
    {
        menuGestionRepertoires
    }
}

MenuGestionRep