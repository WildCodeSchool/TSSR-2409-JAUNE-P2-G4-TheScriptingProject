#! /bin/bash

#Pseudo-code gestion des utilisateurs

##Création d'un nouveau compte utilisateur local
#   Demande de confirmation de la création d'un nouvel utilisateur
#       Si confirmation 
#       Alors
#           demander le nom du nouveau compte à créer  
#           Vérification que le nom de compte n'est pas déjà attribué
#               Si nom compte déjà existant
#               Alors
#                   message d'erreur et demande si l'opérateur souhaite créer un autre compte                    
#                   Si Oui 
#                       retour à la demande du nom du nouvel utilisateur(break?)
#                   Sinon 
#                       création du nouveau compte 
#                       Demande du mot de passe     
#                       Confirmation de la création du compte local
#       Sinon
#           message d'annulation de l'opération 
#           retour menu principal

##Changement du mot de passe d'un utilisateur local
#   Demande de confirmation de l'opération de changement du mot de passe
#       Si confirmation  
#       Alors 
#           Demande du nom du compte dont on souhaite modifier le mot de passe
#           Vérification de l'existence du compte 
#           Si compte existant 
#           Alors 
#               modification du mot de passe et confirmation de la modification
#           Sinon
#               Message d'erreur compte absent et retour au menu de modification du compte
#       Sinon
#           Retour au menu principal             



##Suppression d'un compte utilisateur local
#       Demande de confirmation de suppression
#       Si oui 
#       Alors
#           Demande du nom du compte à supprimer
#           Recherche du nom du compte 
#           Si compte inexistant 
#           Alors
#               message d'erreur et retour suppression de compte
#           Sinon 
#               Afficher compte similaires
#               Demande de confirmation de suppression du compte sélectionné
#               Si oui
#                   suppression du compte et message de confirmation 
#                   retour début fonction suppression
#               Sinon
#                   Message annulation et retour début de la fonction suppression
#       Sinon 
#           Message d'annulation de l'opération
#           Retour menu principal



##Désactivation d'un compte utilisateur local
#       Demande de confirmation de désactivation
#       Si oui 
#       Alors
#           Demande du nom du compte à désactiver
#           Recherche du nom du compte 
#           Si compte inexistant 
#           Alors
#               message d'erreur et retour au menu de désactivation
#           Sinon 
#               Afficher compte similaires
#               Demande de confirmation de désactivation du compte sélectionné
#               Si oui
#                   désactivation du compte et message de confirmation 
#                   retour début fonction désactivation
#               Sinon
#                   Message annulation et retour début de la fonction désactivation
#       Sinon 
#           Message d'annulation de l'opération
#           Retour menu principal   