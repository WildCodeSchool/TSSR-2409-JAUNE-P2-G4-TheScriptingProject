#!/bin/bash

# Fonction pour arrêter l'ordinateur
fonction_arret() {
    echo "Voulez-vous vraiment arrêter ?"
    echo "1 - Arrêt immédiat"
    echo "2 - Arrêt dans une minute"
    echo "3 - Annuler"
    read -p "Choix : " confirmationArret

    case $confirmationArret in
        1)
            # Arrêt immédiat
            echo "Arrêt immédiat en cours..."
            sudo shutdown now
            ;;
        2)
            # Arrêt avec délai d'une minute
            echo "Arrêt dans une minute en cours..."
            sudo shutdown +1
            ;;
        3)
            # Annuler l'arrêt
            echo "Arrêt annulé."
            return
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
}

# Fonction pour redémarrer l'ordinateur
fonction_redemarrage() {
    echo "Voulez-vous vraiment redémarrer ?"
    echo "1 - Redémarrage immédiat"
    echo "2 - Redémarrage dans une minute"
    echo "3 - Annuler"
    read -p "Choix : " confirmationRedemarrage

    case $confirmationRedemarrage in
        1)
            # Redémarrage immédiat
            echo "Redémarrage immédiat en cours..."
            sudo reboot now
            ;;
        2)
            # Redémarrage avec délai d'une minute
            echo "Redémarrage dans une minute en cours..."
            sudo shutdown -r +1
            ;;
        3)
            # Annuler le redémarrage
            echo "Redémarrage annulé."
            return
            ;;
        *)
            echo "Choix invalide."
            ;;
    esac
}

# Fonction pour verrouiller la session
fonction_verrouillage() {
    echo "Verrouillage de la session..."
    # Cette commande verrouille l'écran pour Ubuntu/Gnome. Modifiez-la selon votre gestionnaire de fenêtres si nécessaire.
    gnome-screensaver-command -l || echo "Verrouillage non disponible."
}

# Fonction principale de gestion de l'alimentation
gestion_alimentation() {
    echo "Que voulez-vous faire ?"
    echo "1 - Arrêter l'ordinateur"
    echo "2 - Redémarrer l'ordinateur"
    echo "3 - Verrouiller la session"
    read -p "Choix : " choixUtilisateur

    case $choixUtilisateur in
        1)
            fonction_arret
            ;;
        2)
            fonction_redemarrage
            ;;
        3)
            fonction_verrouillage
            ;;
        *)
            echo "Choix invalide, veuillez réessayer."
            gestion_alimentation  # Relance la fonction en cas de choix invalide
            ;;
    esac
}
