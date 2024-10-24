# Pseudo-code Info de connexion

# Je veux en lançant le script obtenir
#     - La date de dernière connexion d'un utilisateur
#     - La date de dernière modification du mdp
#     - La liste des sessions ouvertes par l'utilisateur
#     - les groupes auxquels appartient notre utilisateur
#     - l'historique des commandes exécutées par un utilisateur
#     - Les droits et permissions d'un user sur un objet

# Demander de quel utilisateur on veut récupérer les informations (avec possibilité de retour arrière)
# Vérifier que l'utilisateur existe
# Observer la liste des utilisateurs | rechercher le nom de l'utilisateur | Envoyer vers le dev-null
# Demander le code de sortie de la commande précédente
#   S'il n'existe pas
#       Afficher "l'utilisateur n'existe pas"
#       Recommencer
#   S'il existe
#       Continuer
#   Option retour
#       Revenir au menu précédent

# Demander quelle information on veut récupérer sur l'utilisateur
# Proposer choix 1. Date de dernière connexion
# Proposer choix 2. Date de dernière modif mdp
# Proposer choix 3. Liste sessions ouvertes
# Proposer choix 4. Groupes auxquels appartient user
# Proposer choix 5. Historique des commandes
# Proposer choix 6. Droits de l'utilisateur
# Proposer de changer d'utilisateur

#   Cas 1)
#       Afficher date de dernière connexion de l'utilisateur
#last wilder > /tmp/last.txt && head -n1 /tmp/last.txt
#   Fin Cas 1)

#   Cas 2)
#       Afficher la date de dernière modif mdp
#passwd -S user
#   Fin Cas 2)

#   Cas 3)
#       Afficher la liste des sessions ouvertes par l'utilisateur
#   Fin Cas 3)

#   Cas 4)
# Demander la liste des groupes auxquels appartient notre utilisateur
#groups user
#   Fin Cas 4)

#   Cas 5)
#   Demander combien de lignes d'historique on souhaite afficher
#       Si la réponse n est non vide et est un chiffre
#           Afficher les n dernières lignes du fichier /home/user/.bash_history
#       Si la réponse est vide ou n'est pas un chiffre
#           Afficher tout le fichier /home/user/.bash_history
#       Fin si
#   Fin cas 5)

#   Cas 6)
#   Demander si Répertoire
#   Si Répertoire
#       Demander le chemin réseau
#       Rechercher les droits pour ce chemin réseau
#       Filtrer la ligne correspondant au répertoire
#           namei -mo CheminRéseau > /tmp/droits.txt && head -n2 /tmp/droits.txt
#   Sinon (nécessairement un fichier)
#       Demander le chemin réseau
#       Rechercher les droits pour ce chemin réseau
#       Filtrer la ligne correspondant au ficher
#           namei -mo CheminRéseau > /tmp/droits.txt && tail -n1 /tmp/droits.txt
#   Fin Si
#   Fin Cas 6)

#   Autres cas)
#   Retour Choix utilisateur
#   Fin autres cas