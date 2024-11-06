#!/bin/bash

echo "=============================="
echo "Gestion alimentation"
echo "=============================="

# Fonction pour arrêter l'ordinateur
fonction_arret() {
    echo "Voulez-vous vraiment arrêter ?"
    echo "1 - Arrêt immédiat"
    echo "2 - Arrêt dans une minute"
    echo "3 - Annuler"
    read -p "Choix : " confirmationArret

    case $confirmationArret in
        1)
            echo "Arrêt immédiat en cours..."
            sudo shutdown now
            ;;
        2)
            echo "Arrêt dans une minute en cours..."
            sudo shutdown +1
            ;;
        3)
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
            echo "Redémarrage immédiat en cours..."
            sudo reboot now
            ;;
        2)
            echo "Redémarrage dans une minute en cours..."
            sudo shutdown -r +1
            ;;
        3)
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
    gnome-screensaver-command -l || echo "Verrouillage non disponible."
}

# Menu principal 
while true; do
    echo "Que voulez-vous faire ?"
    echo "1 - Arrêter l'ordinateur"
    echo "2 - Redémarrer l'ordinateur"
    echo "3 - Verrouiller la session"
    echo "4 - Quitter"
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
        4)
            echo "Sortie du programme."
            break
            ;;
        *)
            echo "Choix invalide, veuillez réessayer."
            ;;
    esac
done