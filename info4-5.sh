#! /bin/bash

# Fonction Groupe d’appartenance d’un utilisateur
read -p "Quel est l'utilisateur dont vous souhaitez connaître les groupes ?" user
groups $user

# Fonction Historique des commandes exécutées par l'utilisateur
echo -e "\n"
echo -e "Quel est l'utilisateur dont vous souhaitez connaître l'historique ?"
read -p "" user
echo -e "\n"
echo -e "Vous souhaitez un historique des \e[0;36mn dernières commandes\e[0;m."
echo -e "\e[0;32mDéfinissez n\e[0;m : (intégralité si aucune valeur entrée)"
read -p "" number
test='^[0-9]+$'
if ! [[ $number =~ $test ]]
then
    echo -e "\n"
    echo -e "\e[0;31mVous n'avez pas entré de nombre\e[0;m"
    echo -e "\e[0;33mAffichage de l'intégralité de l'historique\e[0;m"
    echo -e "\n"
    sleep 5
    cat /home/$user/.bash_history
    echo -e "\n"
else
    echo -e "\n"
    tail -n $number /home/$user/.bash_history
    echo -e "\n"
fi
