# TSSR-2409-JAUNE-P2-G4-TheScriptingProject
Groupe 4 du projet 2 des TSSR 2024-09

# I. Présentation du projet
L'objectif de ce projet est de réaliser un script qui s'exécute sur une machine (un serveur) et effectue des tâches sur des machines distantes (des clients).
Exécuté sur un serveur Debian, le script effectue les tâches sur un client Ubuntu.
Exécuté sur un serveur Windows Server 2022, le script effectue les tâches sur un client Windows 10.
Toutes les machines sont sur le même réseau et les tâches consistent en des actions ou des requêtes d'information.

# II. Introduction - Mise en contexte
Ce projet a été réalisé à trois, Marilyn, Christophe et Paul-Alban (P.A.), dans un laboratoire virtuel hébergé sur Proxmox. Sur ce laboratoire ont été installées et configurées des machines virtuelles sous différents systèmes d'exploitation. 

# III. Rôles de chaque membre
## Sprint 1
- Product Owner : Christophe
- Scrum Master : P.A.
- Développeuse : Marilyn
## Sprint 2
- Product Owner : P.A.
- Scrum Master : Christophe
- Développeuse : Marilyn
## Sprint 3
- Product Owner : Marilyn
- Scrum Master : P.A.
- Développeur : Christophe
## Sprint 4
- Product Owner : Christophe
- Scrum Master : Marilyn
- Développeur : P.A.

# IV. Choix techniques
- Connexion Serveur-Client Windows :
    - Le groupe a fait le choix d'une connexion SSH et a dû, pour ce faire, installer et configurer les fonctionnalités SSH et WinRM sur le serveur ainsi que sur le client ;
- Connexion Serveur-Client Linux :
    - Le groupe a fait le choix d'une connexion SSH dont les fonctionnalités sont installées par défaut sur le serveur Debian.
- Menu de navigation du script :
    - Dans un premier temps, le groupe a souhaité diviser au maximum les menus de navigation au sein du script. L'utilisateur était confronté à un premier menu lui proposant de réaliser une action ou de requérir une information. Chacun de ces choix lui proposait ensuite s'il souhaitait exécuter cette tâche sur un utilisateur ou sur un ordinateur client. Les tâches étaient par la suite divisées par bloc de tâches similaires au sein desquelles l'utilisateur pouvait finalement sélectionner la tâche à accomplir.
    - Le groupe à finalement jugé cette organisation trop tentaculaire et demandant trop d'intéractions entre le script et l'utilisateur. Le groupe a donc choisi de réduire cette navigation à un premier menu proposant de réaliser une action ou de requérir une information puis, selon le choix, de se voir proposer l'ensemble des tâches correspondantes disponibles. 


# V. Difficultés / Solutions
- Manque d'information sur les fonctions, bash et Powershell
    - Beaucoup de ces fonctions ont été trouvées par navigation sur internet, lecture du manuel (`man` ou `Get-Help`) et suivi d'exemples.
- Complexité des fonctions
    - Le groupe a eu globalement tendance à complexifier les tâches demandées et à rendre des fonctions très complètes au prix d'un temps passé à leur rédaction bien trop long.
    - Les dernières fonctions réalisées l'ont été plus simplement tout en respectant les résultats attendus.
- 

# VI. Suggestions d'amélioration
- 

# VII. Conclusion
