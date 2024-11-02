# Fonction pour créer un utilisateur s'il n'existe pas
function Creer-Utilisateur {
    param (
        [string]$NomUtilisateur
    )

    # Vérifie si l'utilisateur existe
    $userExists = (Get-LocalUser | Where-Object { $_.Name -eq $NomUtilisateur })
    if ($userExists) {
        Write-Output "L'utilisateur $NomUtilisateur existe déjà."
        return $true
    } else {
        Write-Output "L'utilisateur $NomUtilisateur n'existe pas. Création en cours..."
        try {
            New-LocalUser -Name $NomUtilisateur -NoPassword -AccountNeverExpires
            Write-Output "Utilisateur $NomUtilisateur créé avec succès."
            return $true
        } catch {
            Write-Output "Erreur lors de la création de l'utilisateur $NomUtilisateur."
            return $false
        }
    }
}

# Fonction pour vérifier et créer un groupe s'il n'existe pas
function Creer-Groupe-Si-Non-Existant {
    param (
        [string]$NomGroupe
    )

    # Vérifie si le groupe existe
    $groupExists = (Get-LocalGroup | Where-Object { $_.Name -eq $NomGroupe })
    if ($groupExists) {
        Write-Output "Le groupe $NomGroupe existe déjà."
        return $true
    } else {
        Write-Output "Le groupe $NomGroupe n'existe pas. Création en cours..."
        try {
            New-LocalGroup -Name $NomGroupe
            Write-Output "Groupe $NomGroupe créé avec succès."
            return $true
        } catch {
            Write-Output "Erreur lors de la création du groupe $NomGroupe."
            return $false
        }
    }
}

# Fonction pour ajouter un utilisateur au groupe Administrateurs avec confirmation
function Creer-Utilisateur-Groupe-Admin {
    param (
        [string]$NomUtilisateur,
        [string]$NomGroupe = "Administrateurs" 
    )

    # S'assurer que l'utilisateur est créé
    if (-not (Creer-Utilisateur -NomUtilisateur $NomUtilisateur)) { return }

    # S'assurer que le groupe Administrateurs existe
    if (-not (Creer-Groupe-Si-Non-Existant -NomGroupe $NomGroupe)) { return }

    # Confirmation avant d'ajouter au groupe Administrateurs
    $confirmation = Read-Host "Voulez-vous vraiment ajouter $NomUtilisateur au groupe $NomGroupe ? (oui/non)"
    if ($confirmation -eq "oui") {
        $membreDuGroupe = Get-LocalGroupMember -Group $NomGroupe | Where-Object { $_.Name -eq $NomUtilisateur }
        if ($membreDuGroupe) {
            Write-Output "L'utilisateur $NomUtilisateur est déjà membre du groupe $NomGroupe."
        } else {
            try {
                Add-LocalGroupMember -Group $NomGroupe -Member $NomUtilisateur
                Write-Output "L'utilisateur $NomUtilisateur a été ajouté au groupe $NomGroupe avec succès."
            } catch {
                Write-Output "Erreur lors de l'ajout de l'utilisateur $NomUtilisateur au groupe $NomGroupe."
            }
        }
    } else {
        Write-Output "Ajout annulé."
    }
}

# Fonction pour ajouter un utilisateur à un groupe local avec confirmation
function Creer-Utilisateur-Groupe-Local {
    param (
        [string]$NomUtilisateur,
        [string]$NomGroupe
    )

    # S'assurer que l'utilisateur est créé
    if (-not (Creer-Utilisateur -NomUtilisateur $NomUtilisateur)) { return }

    # S'assurer que le groupe local existe
    if (-not (Creer-Groupe-Si-Non-Existant -NomGroupe $NomGroupe)) { return }

    # Confirmation avant d'ajouter au groupe local
    $confirmation = Read-Host "Voulez-vous vraiment ajouter $NomUtilisateur au groupe $NomGroupe ? (oui/non)"
    if ($confirmation -eq "oui") {
        $membreDuGroupe = Get-LocalGroupMember -Group $NomGroupe | Where-Object { $_.Name -eq $NomUtilisateur }
        if ($membreDuGroupe) {
            Write-Output "L'utilisateur $NomUtilisateur est déjà membre du groupe $NomGroupe."
        } else {
            try {
                Add-LocalGroupMember -Group $NomGroupe -Member $NomUtilisateur
                Write-Output "L'utilisateur $NomUtilisateur a été ajouté au groupe $NomGroupe avec succès."
            } catch {
                Write-Output "Erreur lors de l'ajout de l'utilisateur $NomUtilisateur au groupe $NomGroupe."
            }
        }
    } else {
        Write-Output "Ajout annulé."
    }
}

# Fonction pour retirer un utilisateur d'un groupe local avec confirmation
function Retirer-Utilisateur-Du-Groupe-Local {
    param (
        [string]$NomUtilisateur,
        [string]$NomGroupe
    )

    # Vérifie si l'utilisateur et le groupe existent
    $userExists = (Get-LocalUser | Where-Object { $_.Name -eq $NomUtilisateur })
    $groupExists = (Get-LocalGroup | Where-Object { $_.Name -eq $NomGroupe })

    if (-not $userExists) {
        Write-Output "Erreur : L'utilisateur $NomUtilisateur n'existe pas."
        return
    }
    if (-not $groupExists) {
        Write-Output "Erreur : Le groupe $NomGroupe n'existe pas."
        return
    }

    # Vérification de la présence de l'utilisateur dans le groupe local
    $membreDuGroupe = Get-LocalGroupMember -Group $NomGroupe | Where-Object { $_.Name -like "*$NomUtilisateur" }
    if ($membreDuGroupe) {
        # Confirmation avant de retirer du groupe local
        $confirmation = Read-Host "Voulez-vous vraiment retirer $NomUtilisateur du groupe $NomGroupe ? (oui/non)"
        if ($confirmation -eq "oui") {
            try {
                # Utiliser le nom exact tel qu'il est affiché par Get-LocalGroupMember
                Remove-LocalGroupMember -Group $NomGroupe -Member $membreDuGroupe.Name
                Write-Output "L'utilisateur $NomUtilisateur a été retiré du groupe $NomGroupe avec succès."
            } catch {
                Write-Output "Erreur lors du retrait de l'utilisateur $NomUtilisateur du groupe $NomGroupe."
            }
        } else {
            Write-Output "Retrait annulé."
        }
    } else {
        Write-Output "L'utilisateur $NomUtilisateur n'est pas membre du groupe $NomGroupe."
    }
}

# Menu principal
$continuer = $true
while ($continuer) {
    Write-Output "Choisissez une action :"
    Write-Output "1. Ajouter un utilisateur au groupe Administrateurs"
    Write-Output "2. Ajouter un utilisateur à un groupe local"
    Write-Output "3. Retirer un utilisateur d'un groupe local"
    Write-Output "4. Quitter"
    $choix = Read-Host "Entrez votre choix"

    switch ($choix) {
        1 {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            Creer-Utilisateur-Groupe-Admin -NomUtilisateur $utilisateur
        }
        2 {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $groupe = Read-Host "Entrez le nom du groupe local"
            Creer-Utilisateur-Groupe-Local -NomUtilisateur $utilisateur -NomGroupe $groupe
        }
        3 {
            $utilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $groupe = Read-Host "Entrez le nom du groupe local"
            Retirer-Utilisateur-Du-Groupe-Local -NomUtilisateur $utilisateur -NomGroupe $groupe
        }
        4 {
            Write-Output "Quitter le script."
            $continuer = $false
        }
        default {
            Write-Output "Option invalide. Veuillez choisir une option valide."
        }
    }
    Write-Output ""
}