#! /bin/bash

# Je veux proposer un menu à trois entrées : Action, Requête d'information ou Sortie du script ;
# Je veux que l'on revienne à ce menu si l'on en fait la demande => fonction

# Fonction Menu2 (Actions)
function menu2()
{
    echo -e "\n"
    echo -e "Quelle action souhaitez-vous réaliser ?"
    echo -e "=========================================================="
    echo -e "01. Création de Compte Utilisateur local"
    echo -e "02. Changement de Mot de passe"
    echo -e "03. Suppression de Compte Utilisateur local"
    echo -e "04. Activation / Désactivation de Compte Utilisateur local"
    echo -e "05. Ajouter un utilisateur au groupe Administrateurs"
    echo -e "06. Ajouter un utilisateur à un groupe local"
    echo -e "07. Retirer un utilisateur d'un groupe local"
    echo -e "08. Arrêter l'ordinateur"
    echo -e "09. Redémarrer l'ordinateur"
    echo -e "10. Verrouiller la session"
    echo -e "11. Mise-à-jour du système"
    echo -e "12. Créer un répertoire"
    echo -e "13. Modifier un répertoire"
    echo -e "14. Supprimer un répertoire"
    echo -e "15. Activer le pare-feu"
    echo -e "16. Désactiver le pare-feu"
    echo -e "17. Installation de logiciel"
    echo -e "18. Désinstallation de logiciel"
    echo -e "19. Exécution de script sur la machine distante"
    echo -e "0. Revenir en arrière"
    echo -e "=========================================================="
    echo -e "\n"
    read -p "(Taper 1, 2, ... , 19 ou 0) : " choix
    case $choix in
    1)
        # Lancement Création de Compte Utilisateur local
        createuser
    ;;
    2)
        # Lancement Changement de Mot de passe
        changepassword
    ;;
    3)
        # Lancement Suppression de compte utilisateur local
        deleteuser
    ;;
    4)
        # Lancement Désactivation de compte utilisateur local
        deactivateuser
    ;;
    5)
        # Lancement Ajout à un groupe d'administration
        # fonction gpe admin
    ;;
    6)
        # Lancement Ajout à un groupe local
        # fonction gpe local
    ;;
    7)
        # Lancement Sortie d’un groupe local
        # fonction rm group
    ;;
    8)
        # Lancement Arrêt
        Fonction-Arret
    ;;
    9)
        # Lancement Redémarrage
        Fonction-Redemarrage
    ;;
    10)
        # Lancement Verrouillage session
        Fonction-Verrouillage
    ;;
    11)
        # Lancement Mise-à-jour du système
        MiseAJour
    ;;
    12)
        # Lancement Création de répertoire
        CréaRep
    ;;
    13)
        # Lancement Modification de répertoire
        ModifRep
    ;;
    14)
        # Lancement Suppression de répertoire
        SuppRep
    ;;
    15)
        # Lancement Activation du pare-feu
        echo "Activation du pare-feu..."
        sudo ufw enable
        echo "Pare-feu activé."
    ;;
    16)
        # Lancement Désactivation du pare-feu
        echo "Désactivation du pare-feu..."
        sudo ufw disable
        echo "Pare-feu désactivé."
    ;;
    17)
        # Lancement Installation de logiciel
        # Fonction install-software
    ;;
    18)
        # Lancement Désinstallation de logiciel
        # Fonction uninstall-software
    ;;
    19)
        # Lancement Exécution de script sur la machine distante
        # Fonction scriptexec
    ;;
    0)
        # Retour au Menu principal
        echo -e "\e[1;32mRetour en arrière\e[0;m"
        return
    ;;
    *)
        # Lancement à nouveau de ce menu
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
        menu2
    ;;
    esac
}

# Fonction Menu3 (Informations)
function menu3()
{
    echo -e "\n"
    echo -e "Quelle information recherchez-vous ?"
    echo -e "=========================================================="
    echo -e "01. Date de dernière connexion d’un utilisateur"
    echo -e "02. Date de dernière modification du mot de passe"
    echo -e "03. Liste des sessions ouvertes par l'utilisateur"
    echo -e "04. Groupe d’appartenance d’un utilisateur"
    echo -e "05. Historique des commandes exécutées par l'utilisateur"
    echo -e "06. Droits/permissions de l’utilisateur sur un dossier"
    echo -e "07. Droits/permissions de l’utilisateur sur un fichier"
    echo -e "08. Version de l'OS"
    echo -e "09. Nombre de disque"
    echo -e "10. Partition (nombre, nom, FS, taille) par disque"
    echo -e "11. Espace disque restant par partition/volume"
    echo -e "12. Nom et espace disque d'un dossier (nom de dossier demandé)"
    echo -e "13. Liste des lecteurs monté (disque, CD, etc.)"
    echo -e "14. Nombre d'interface"
    echo -e "15. Adresse IP de chaque interface"
    echo -e "16. Adresse Mac"
    echo -e "17. Liste des ports ouverts"
    echo -e "18. Statut du pare-feu"
    echo -e "19. Recherche des evenements dans le fichier log_evt.log pour un utilisateur"
    echo -e "20. Recherche des evenements dans le fichier log_evt.log pour un ordinateur"
    echo -e "0. Revenir en arrière"
    echo -e "=========================================================="
    echo -e "\n"
    read -p "(Taper 1, 2, ... , 20 ou 0) : " choix




    case $choix in
    1)
        # Lancement Date de dernière connexion d’un utilisateur
        # Utilisation de last pour obtenir la dernière connexion de l'utilisateur
        echo "Date de dernière connexion de l'utilisateur $UTILISATEUR :"
        last -n 1 "$UTILISATEUR" || echo "Aucune information de connexion disponible pour cet utilisateur."
    ;;
    2)
        # Lancement Date de dernière modification du mot de passe
        echo "Date de dernière modification du mot de passe de l'utilisateur $UTILISATEUR :"
        sudo chage -l "$UTILISATEUR" | grep "modification"
    ;;
    3)
        # Lancement Liste des sessions ouvertes par l'utilisateur
        echo "Sessions ouvertes par l'utilisateur $UTILISATEUR :"
        if ! who | grep "$UTILISATEUR"; then
            echo "Aucune session ouverte trouvée pour cet utilisateur."
        fi
    ;;
    4)
        # Lancement Groupe d’appartenance d’un utilisateur
            
    ;;
    5)
        # Lancement Historique des commandes exécutées par l'utilisateur
            
    ;;
    6)
        # Lancement Droits/permissions de l’utilisateur sur un dossier
            
    ;;
    7)
        # Lancement Droits/permissions de l’utilisateur sur un fichier
            
    ;;
    8)
        # Lancement Version de l'OS
        verionOS
    ;;
    9)
        # Lancement Nombre de disque
            
    ;;
    10)
        # Lancement Partition (nombre, nom, FS, taille) par disque
        disk2
    ;;
    11)
        # Lancement Espace disque restant par partition/volume
        disk3
    ;;
    12)
        # Lancement Nom et espace disque d'un dossier (nom de dossier demandé)
        disk4
    ;;
    13)
        # Lancement Liste des lecteurs monté (disque, CD, etc.)
        disk5
    ;;
    14)
        # Lancement Nombre d'interface
            
    ;;
    15)
        # Lancement Adresse IP de chaque interface
            
    ;;
    16)
        # Lancement Adresse Mac
            
    ;;
    17)
        # Lancement Liste des ports ouverts
            
    ;;
    18)
        # Lancement Statut du pare-feu
        
    ;;
    19)
        # Lancement Recherche des evenements dans le fichier log_evt.log pour un utilisateur
            
    ;;
    20)
        # Lancement Recherche des evenements dans le fichier log_evt.log pour un ordinateur
           
    ;;
    0)
        # Retour au Menu Principal
        echo -e "\e[1;32mRetour en arrière\e[0;m"
        return
    ;;
    *)
        # Lancement à nouveau de ce menu
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2, 3 ou 0 \e[0;m"
        menu3
    ;;
    esac
}


while true
do
    echo -e "\n"
    echo "Que voulez-vous faire ?"
    echo "1. Réaliser une action"
    echo "2. Rechercher une information"
    echo "0. Sortir de ce script"
    echo -e "\n"
    read -p "(Taper 1, 2 ou 0) : " choix

    case $choix in
    1)
        # Lancement du menu des Actions
        menu2
    ;;
    2)
        # Lancement du menu des Informations
        menu3
    ;;
    0)
        # Sortie
        echo -e "\e[1;35mSortie du script\e[0;m"
        echo -e "\n"
        exit 0
    ;;
    *)
        # Lancement à nouveau de ce menu (optionnel car le script est une boucle while et le ferait quoiqu'il arrive)
        echo -e "\e[0;31mMauvaise entrée. Tapez 1, 2 ou 0 \e[0;m"
        menu1
    ;;
    esac
done
