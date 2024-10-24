#! /bin/bash

# Je veux accéder au fichier log_evt.log et y trouver les événements
# concernant un utilisateur ou un ordinateur client

# Demander si l'on souhaite consulter le journal d'événements utilisateur ou ordinateur

# Si utilisateur
#   Variable = user
# Si ordinateur
#   Variable = computer
# Sinon
#   Retour début fonction
# Fin Si

# Demander si l'on veut recherche un evt à une date précise
# Si non
# Afficher le fichier log_evt.log | Trier selon la variable (user/computer)
# Si oui
#   Demander Y=année
#   Demander M=mois
#   Demander D=jour
# Afficher le fichier log_evt.log | Trier selon la variable (user/computer) | Trier selon les variables $Y$M$D
# Fin Si

# Créer la journalisation de cette action dans ledit fichier log