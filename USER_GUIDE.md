# I. Utilisation de base

# Guide : Lancer un script en ligne de commande (Shell et PowerShell)

Si vous êtes déjà situé dans le dossier contenant le script, voici comment l'exécuter directement en ligne de commande.

---

## 1. Lancer un script Shell sous Linux 

- 1 - lancer  la commande
```bash
lanceur.sh
```
- 2 - On vous demandera la cible que vous souhaitez : cible ip ou nom machine
- 3 - Choisir sur quel compte se connecter : wilder
- 4 - Demande du mot de passe wilder pour transferer le fichier via scp 
- 5 - Il le stock dans le /tmp de la machine client
- 6 - Demande de mot de passe pour connexion ssh
- 7 - Connexion via ssh depuis la debian vers la ubuntu sous le compte wilder
- 8 - lancement du script avec la commande suivante : 


```bash
bash /tmp/script.sh
```

## 2. Lancer un script PowerShell sous Windows

Si vous êtes dans le dossier contenant le script PowerShell, lancez-le simplement en utilisant :

```powershell
./script.ps1
```

# II. Utilisation avancée



# III. F.A.Q.
