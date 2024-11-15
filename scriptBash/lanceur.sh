read -p "Quel est le nom de la machine à connecter:" cible
read -p "Quel compte souhaitez-vous utiliser pour vous connecter (compte root recommandé):" user

scp script.sh "$user"@"$cible":/tmp

ssh "$user"@"$cible" 
chmod 765 /tmp/script.sh
cd /tmp

./script.sh
