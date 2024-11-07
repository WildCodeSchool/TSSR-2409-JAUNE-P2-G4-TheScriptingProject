# Création de compte utilisateur local
function createuser ()
{
    # Demander le nom du nouveau compte à créer
    Write-Host "Quel est le nom de l'utilisateur que vous souhaitez créer ?" -ForegroundColor DarkCyan
    $user = Read-Host "Nom d'utilisateur"

    # Retour Menu Précédent
        #    If ( $user = "9" )
        #    {
        #        return
        #    }

    # Vérification que le nom de compte n'est pas déjà attribué
    If ( ($((Get-LocalUser $user ).Enabled) -eq "True" ) 2> $null )
    {
        Write-Host "`n"
        Write-Host "L'utilisateur $user existe déjà " -ForegroundColor DarkYellow
    }
    Else
    {
        # Demande de confirmation
        Write-Host "`n"
        Write-Host "Êtes-vous sûr de vouloir créer l'utilisateur $user ? [O/n]"
        $confirm = Read-Host "Confirmation"
        if ( $confirm -eq "O" )
        {
            # Création Utilisateur
            New-LocalUser -NoPassword $user -ErrorAction SilentlyContinue
            # Vérification Création utilisateur 
            if ( $(Get-LocalUser $user).Enabled -eq "True" 2> $null)
            # Si la création s'est bien effectuée, un message affiche "L'utilisateur <nom_utilisateur> a été crée".
            {
                Write-Host "`n"
                Write-Host "L'utilisateur $user a été crée " -ForegroundColor Green
                journalisation "Création_Utilisateur-$user"
            }
            #Sinon, un message affiche "Erreur à la création de l'utilisateur <nom_utilisateur>".
            else 
            {
                Write-Host "`n"
                Write-Host "Erreur à la création de l'utilisateur $user " -ForegroundColor Red
                journalisation "Création_Utilisateur-Erreur-$user"
            }
        }
        # Si refus confirmation - Abandon
        Else
        {
        Write-Host "`n" 
        Write-Host "Abandon de la création de l'utilisateur $user " -ForegroundColor Red
                journalisation "Création_Utilisateur-Abandon-$user"
        }
    }
}

# Changement de mot de passe
function changepassword()
{
    # Demander le nom du compte dont le mot de passe doit être modifié 
    Write-Host "Quel est le nom de l'utilisateur dont le mot de passe doit être modifié ? " -ForegroundColor DarkCyan
    $user = Read-Host "Nom d'utilisateur"

    # Retour Menu Précédent
        #    if [ $user = "9" ]
        #    {
        #        return
        #    }

    # Vérification existence du nom du compte 
    While ( !($((Get-LocalUser -Name $user).Enabled )) 2> $null )
    {
        Write-Host "`n"
        Write-Host "L'utilisateur $user est introuvable "
        Get-LocalUser -Name $user*
        Write-Host "`n"
        Write-Host "Quel est le nom de l'utilisateur dont le mot de passe doit être modifié ?" -ForegroundColor DarkYellow
        $user = Read-Host "Nom d'utilisateur"
    }

    # Demande de confirmation de l'opération de changement du mot de passe
    Write-Host "`n"
    Write-Host "Êtes-vous sûr de vouloir modifier le mot de passe de l'utilisateur $user ? [O/n]" -ForegroundColor DarkYellow
    $confirm = Read-Host "Confirmation"

    # Si confirmation  
    If ( $confirm -eq "O" )
    # Alors modification du mot de passe et confirmation de la modification
    {
        $NewPwd = Read-Host -AsSecureString "Nouveau Mot de passe"
        Get-LocalUser -Name "$user" | Set-LocalUser -Password $NewPwd
        Write-Host "`n"
        Write-Host "Mot de passe modifié" -ForegroundColor Green
        journalisation "Modification_Mot_passe-$user"
    }
    # Sinon Message d'abandon
    else
    {
        Write-Host "`n"
        Write-Host "Abandon de la modification de mot de passe de l'utilisateur $user " -ForegroundColor Red
        journalisation "Modification_Mot_passe-Abandon-$user"
    }
}

# Suppression de compte utilisateur local
function deleteuser()
{
    # Demander le nom du compte à supprimer 
    Write-Host "Quel est le nom de l'utilisateur que vous souhaitez supprimer ? "
    $user=Read-Host "Nom d'utilisateur"

    # Retour Menu Précédent
        #    if [ $user = "9" ]
        #    {
        #        return
        #    }

    # Vérification existence du nom du compte 
    While ( !($((Get-LocalUser -Name $user).Enabled )) 2> $null )
    {
        Write-Host "`n"
        Write-Host "L'utilisateur $user est introuvable "
        Get-LocalUser -Name $user*
        Write-Host "`n"
        Write-Host "Quel est le nom de l'utilisateur dont le compte doit être modifié ?" -ForegroundColor DarkYellow
        $user = Read-Host "Nom d'utilisateur"
    }
    
    Write-Host "`n"
    Write-Host "Êtes-vous sûr de vouloir supprimer l'utilisateur $user ? [O/n]"
    $confirm=Read-Host "Confirmation"
    if ( $confirm = "O" )
    {
        # Suppression Utilisateur
        Remove-LocalUser -Name $user
        # Vérification Suppression utilisateur 
        if ($((Get-LocalUser -Name $user).Enabled ))
        # Si la suppression ne s'est pas effectuée -  Message d'erreur".
        {
            Write-Host "`n"
            Write-Host "Erreur lors de la suppression de l'utilisateur $user " -ForegroundColor Red
            journalisation "Suppression_Utilisateur-Erreur-$user"
        }
        # Si la suppression s'est bien effectuée - Message OK
        else
        {
            Write-Host "`n"
            Write-Host "L'utilisateur $user a bien été supprimé " -ForegroundColor Green
            journalisation "Suppression_Utilisateur-$user"
        }
    }
    # Si refus confirmation - Abandon
    else
    {
        Write-Host "`n"
        Write-Host "Abandon de la suppression de l'utilisateur $user " -ForegroundColor Red
            journalisation "Suppression_Utilisateur-Abandon-$user"
    }
}

# Désactivation de compte utilisateur local
function deactivateuser()
{
    # Demande du nom du compte à modifier
    Write-Host "Quel est le nom de l'utilisateur dont le compte doit être modifié ? "
    $user=Read-Host "Nom d'utilisateur"

    # Retour Menu Précédent
        #    if [ $user = "9" ]
        #    {
        #        return
        #    }

    # Vérification existence du nom du compte 
    While ( !($((Get-LocalUser -Name $user).Enabled )) 2> $null )
    {
        Write-Host "`n"
        Write-Host "L'utilisateur $user est introuvable "
        Get-LocalUser -Name $user*
        Write-Host "`n"
        Write-Host "Quel est le nom de l'utilisateur dont le compte doit être modifié ?" -ForegroundColor DarkYellow
        $user = Read-Host "Nom d'utilisateur"
    }
    
    # Activer ou Désactiver ?
    Write-Host "`n"
    Write-Host "Souhaitez-vous Activer [A] ou Désactiver [D] le compte de l'utilisateur $user ?"-ForegroundColor DarkCyan
    $activ=Read-Host "A / D"

    # Activation
    if ( $activ = "A" )
    {
        Write-Host "`n"
        Write-Host "Êtes vous sûr de vouloir activer le compte $user ? [O/n]"-ForegroundColor DarkYellow
        $confirm=Read-Host "Confirmation" confirm
        if ( $confirm = "O" )
        {
            Enable-LocalUser -Name $user
        }

        if ( $? -eq 0 )
        {
            Write-Host "`n"
            Write-Host "Le compte $user est activé"-ForegroundColor Green
            journalisation "Activation_Compte_Utilisateur-$user"
        }
        else
        {
            Write-Host "`n"
            Write-Host "Erreur lors des modifications sur le compte $user"-ForegroundColor Red
            journalisation "Activation_Compte_Utilisateur-Erreur-$user"
        }
    }
    # Désactivation
    ElseIf ( $activ = "D" )
    {
        Write-Host "`n"
        Write-Host "Êtes vous sûr de vouloir désactiver le compte $user ? [O/n]" -ForegroundColor DarkYellow
        $confirm=Read-Host "Confirmation" confirm
        if ( $confirm = "O" )
        {
            Disable-LocalUser -Name $user
        }

        if ( $? -eq 0 )
        {
            Write-Host "`n"
            Write-Host "Le compte $user est désactivé" -ForegroundColor Green
            journalisation "Désactivation_Compte_Utilisateur-$user"
        }
        else
        {
            Write-Host "`n"
            Write-Host "Erreur lors des modifications sur le compte $user" -ForegroundColor Red
            journalisation "Désactivation_Compte_Utilisateur-Erreur-$user"
        }
    }
    # Commande incorrecte
    else
    {
        Write-Host "`n"
        Write-Host "Veuillez entrer une valeur correcte [A/D]"
    }
}

# Ajout à un groupe d'administration


# Ajout à un groupe local


# Sortie d’un groupe local
