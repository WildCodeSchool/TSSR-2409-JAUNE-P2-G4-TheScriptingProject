Write-Output "===================================="
Write-Output "Informations sur l'ordinateur client"
Write-Output "===================================="
Write-Output ""

# Nombre d'interfaces réseau actives
Write-Output "Nombre d'interfaces réseau actives :"
$numInterfaces = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).Count
Write-Output "- $numInterfaces interfaces actives détectées"
Write-Output ""

# Adresse IP de chaque interface
Write-Output "Adresse IP de chaque interface :"
Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne "127.0.0.1" } | ForEach-Object {
    Write-Output "- Interface $($_.InterfaceAlias) : IP $($_.IPAddress)"
}
Write-Output ""

# Adresse MAC de chaque interface
Write-Output "Adresse MAC de chaque interface :"
Get-NetAdapter | ForEach-Object {
    if ($_.MacAddress) {
        Write-Output "- Interface $($_.Name) : MAC $($_.MacAddress)"
    }
}
Write-Output "===================================="