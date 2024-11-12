# Récupérer l'adresse IP du client
$remoteComputer = "adresse_IP_du_client"  # Remplacez par l'adresse IP du client

# Lancer la connexion RDP avec MSTSC
Start-Process "mstsc" -ArgumentList "/v:$remoteComputer"