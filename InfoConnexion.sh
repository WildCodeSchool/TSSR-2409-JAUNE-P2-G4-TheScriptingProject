# Pseudo-code Info de connexion

# Je veux en lançant le script obtenir
#     - La date de dernière connexion d'un utilisateur
#     - La date de dernière modification du mdp
#     - La liste des sessions ouvertes par l'utilisateur

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
#   Autres cas)
#   Retour Choix utilisateur
#   Fin autres cas

