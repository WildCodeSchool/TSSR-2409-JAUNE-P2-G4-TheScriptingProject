#!/bin/bash
#Information sur les disques et lecteurs
function infodisk()
{
#Afficher le menu des informations disponibles
echo "Quelle information souhaitez-vous récupérer ?"
echo "1-Nombre de disque présent sur l'ordinateur"
echo "2-Détail des partitions présente sur un disque"
echo "3-Espace disponible"
echo "4-Rechercher l'emplacement d'un dossier"
echo "5-Liste des lecteurs montés monter sur l'ordinateur"
echo "6-Retour au menu précédant"
echo "7-Retour au menu principal"
#Demander quelle information souhaite obtenir l'utilisateur -> $choixInfoCl
read -p "" choix

#   SI [ $choixInfoCl COMPRIS ENTRE 1-7 ]
case $choix in
#   Alors 
#       case $choixInfoCl in
1)
#       1)Rechercher le nombre de disques présent sur la machine 
#         Retourner la liste des disques ou le nombre
    lsblk | grep disk | wc -l
    lsblk | grep disk
;;

2)            
#       2)Demander sur quel disque l'utilisateur souhaite avoir le détails du partitionnement
#         Vérifier si le disque existe
#             Si oui
#             Alors 
#                   Commande pour avoir les infos sur les partitions
#                   Retourner la liste des infos sur le disque sélectionné
#                   nombre de partitions | nom des partition | File Système | taille de la partition#  
#                   Retour au menu des info disques et lecteurs            
#             Sinon  
#                   message d'erreur le disque sélectionné est inconnue
#                   afficher liste des disques
#                   demander si l'utilisateur souhaite sélectionner un autre disque
#                   Si oui      
#                   Alors 
#                       relancer fonction partition
#                   Sinon   
#                       retour menu : info disque et lecteur
#                   fin
#             fin
;;

3)
#       3)Demander si l'information concerne un disque entier ou une partition
#             afficher menu 1 - disque
#                           2 - partition    
#                           3 - retour menu précédant
#                           4 - retour menu principal
#             Si 1
#                   Demander le non du disque
#                   Vérifier existence du disque demandé
#                       si disque existe
#                       alors
#                           récupérer espace libre sur le disque
#                           retourner nom du disque et taille d'espace libre
#                       Sinon
#                           message d'erreur le disque sélectionné n'existe pas
#                           afficher liste des disques
#                           retour début de la fonction break 
#            Si 2
#                   Demander le non de la partition
#                   Vérifier existence de la partition
#                       si existe
#                       alors
#                           récupérer espace libre sur la partition
#                           retourner nom de la partition et taille d'espace libre
#                       Sinon
#                           message d'erreur la partition sélectionné n'existe pas
#                           afficher liste des partitions
#                           retour début de la fonction break 
#                       fin
;;

4)
#       4)Quel est le nom du fichier dont vous souhaitez connaître l'emplacement
#           rechercher fichier dans les espace de stockages
#               Si résultat positif
#               Alors 
#                   retourner nom du dossier et emplacement
#               Sinon 
#                   retourner message: dossier inconnue
#                   retour menu info disque et lecteur
#               fin
;;      

5)
#       5)Rechercher liste des lecteur monté sur l'ordinateur et retourner liste
#         Retourner liste
#         Retour menu info disque et lecteur
;;  

6)
#       6)Retour au menu précédant : information sur un ordinateur client
;;

7)
#       7)Retour au menu principal
;;

*)
#   Sinon
#       Message d'erreur commande inconnue
#       Retour menu info disque et lecteur
;;
esac
}