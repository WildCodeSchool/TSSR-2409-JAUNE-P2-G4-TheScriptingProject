#! /bin/bash

# Vérification de la présence d'arguments
if [ $# -eq 0 ]
then
    echo -e "\e[0;31mIl manque les noms d'utilisateurs en argument - Fin du script \e[0;m"
    exit 1
fi

# Pour tout argument, créer les utilisateurs :
for user in $@
do
# Vérification de l'existence dans le système
    if cat /etc/passwd | grep $user >> /dev/null
#S'il existe déjà, un message indiquera "L'utilisateur <nom_utilisateur> existe déjà"
    then
        echo -e "\e[0;33mL'utilisateur $user existe déjà \e[0;m"
        break
    else
        sudo useradd $user
        # Vérification création utilisateur 
        if cat /etc/passwd | grep $user >> /dev/null
#Si la création s'est bien effectuée, un message affiche "L'utilisateur <nom_utilisateur> a été crée".
        then
              echo -e "\e[0;32mL'utilisateur $user a été crée \e[0;m"
#Sinon, un message affiche "Erreur à la création de l'utilisateur <nom_utilisateur>".
        else
               echo -e "\e[0;31mErreur à la création de l'utilisateur $user \e[0;m"
        fi
    fi
done