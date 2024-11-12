#! /bin/bash

# Fonction Groupe d’appartenance d’un utilisateur
read -p "Quel est l'utilisateur dont vous souhaitez connaître les groupes ?" user
groups $user

# Fonction Historique des commandes exécutées par l'utilisateur
read -p "Quel est l'utilisateur dont vous souhaitez connaître l'historique ?" user
cat /home/$user/.bash_history