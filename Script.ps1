
# Je veux proposer un menu à trois entrées : Action, Requête d'information ou Sortie du script ;
# Je veux que l'on revienne à ce menu si l'on en fait la demande => fonction


# Fonction Menu2 (Actions)
function menu2
{
    Write-Host "Vous souhaitez réaliser une action sur..."
    Write-Host "1. Un utilisateur"
    Write-Host "2. Un ordinateur client"
    Write-Host "0. Revenir en arrière"
    $choix=Read-Host "(Taper 1, 2 ou 0)"
    Switch ( $choix )
    {
        1
            {
                # Lancement Menu A(ctions) U(tilisateurs)
                menuAU
            }
        2
            {
                # Lancement Menu A(ctions) C(lient)
                menuAC
            }
        0
            {
                # Retour au Menu principal
                Write-Host "Retour en arrière"
                menu1
            }
        default
            {
                # Lancement à nouveau de ce menu
                Write-Host "Mauvaise entrée. Tapez 1, 2 ou 0 "
            }
    }
}

# Fonction Menu3 (Informations)
function menu3
{
    Write-Host "Vous souhaitez rechercher une information sur..."
    Write-Host "1. Un utilisateur"
    Write-Host "2. Un ordinateur client"
    Write-Host "3. Un événement du fichier log_evt.log"
    Write-Host "0. Revenir en arrière"
    $choix=Read-Host "(Taper 1, 2 ou 0)"
    Switch ( $choix )
    {
        1
            {
                # Lancement du Menu des I(nformations) U(tilisateurs)
                menuIU
            }
        2
            {
                # Lancement du Menu des I(nformations) C(lient)
                menuIC
            }
        3
            {
                Write-Host "Lancement de evt.sh"
            }
        0
            {
                # Retour au Menu Principal
                Write-Host "Retour en arrière"
                return
            }
        default 
            {
                # Lancement à nouveau de ce menu
                Write-Host "Mauvaise entrée. Tapez 1, 2, 3 ou 0 "
            }
    }
}

# Fonction Menu des A(ctions) U(tilisateur)
function menuAU
{
    Write-Host "Quelle action utilisateur souhaitez-vous réaliser ?"
    Write-Host "1. Une action sur les Comptes"
    Write-Host "2. Une action sur les Groupes"
    Write-Host "0. Revenir en arrière"
    $choix=Read-Host "(Taper 1, 2 ou 0)"
    Switch ( $choix )
    {
        1
        {
            # Lancement du script d'action sur les comptes ?
            # Ou proposition directe des différentes actions puis redirection vers les différents scripts ?
            Write-Host "Action Utilisateur Comptes"
        }
        2
        {
            # Lancement du script d'action sur les groupes ?
            # Ou proposition directe des différentes actions puis redirection vers les différents scripts ?
            Write-Host "Action Utilisateur Groupes"
        }
        0
        {
            # Retour au Menu des Actions
            Write-Host "Retour en arrière"
            return
        }
        default 
        {
            # Relance de ce menu
            Write-Host "Mauvaise entrée. Tapez 1, 2 ou 0 "
        }
    }
}

# Fonction Menu des A(ctions) C(lient)
function menuAC()
{
    Write-Host "Quelle action client souhaitez-vous réaliser ?"
    Write-Host "1. Une action sur l'alimentation"
    Write-Host "2. Une mise à jour"
    Write-Host "3. Une action sur les répertoires"
    Write-Host "4. Une prise en main à distance (GUI)"
    Write-Host "5. Une action sur les pare-feux"
    Write-Host "6. Une action sur les logiciels"
    Write-Host "0. Revenir en arrière"
    Write-Host "Taper 1, 2 ou 0"
    Read-Host "" choix
    Switch ( $choix ) 
    {
        1 
        {
            Write-Host "Action Client Alimentation"
            }
        2 
        {
            Write-Host "Action Client MàJ"
            }
        3 
        {
            Write-Host "Action Client Répertoires"
            }
        4 
        {
            Write-Host "Action Client GUI"
            }
        5 
        {
            Write-Host "Action Client Pare-feux"
            }
        6 
        {
            Write-Host "Action Client Logiciels"
            }
        0 
        {
            Write-Host "Retour en arrière"
            return
            }
        default 
        {
            Write-Host "Mauvaise entrée. Tapez 1, 2 ou 0 "
            }
    }
}

# Fonction Menu des I(nformations) U(tilisateur)
function menuIU()
{
    Write-Host "Lancement de InfoUser.sh"
}

# Fonction Menu des I(nformations) C(lient)
#function menuIC()
#{

#}



# Choix de cible entre 
	#	- Ordinateur : par Nom complet ou Adresse IP
	#	- Utilisateur : par nom partiel ou complet

# Quelle est la machine cible ?
Write-host "Quelle est la machine cible ?"
$Cible=Read-Host "Adresse IPv4 ou Nom de machine complet"


Enter-PSSession -ComputerName $Cible -Credential $Cible\Administrateur

# Menu Principal
while ( $true )
{
    Write-Host "Que voulez-vous faire ?"
    Write-Host "1. Réaliser une action"
    Write-Host "2. Rechercher une information"
    Write-Host "0. Sortir de ce script"
    $choix= Read-Host "(Taper 1, 2 ou 0)"

    Switch ( $choix )
    {
        1
            {
            # Lancement du menu des Actions
            While ( $True )
                {menu2}
            }
        2
            {
            # Lancement du menu des Informations
            While ( $True )
            {menu3}
            }
        0
            {
            # Sortie
            Write-Host "Sortie du script"
            exit 0
            }
        default 
            {
            # Lancement à nouveau de ce menu (optionnel car le script est une boucle while et le ferait quoiqu'il arrive)
            Write-Host "Mauvaise entrée. Tapez 1, 2 ou 0 "
            menu1
            }
    }
}