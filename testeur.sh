#!/bin/bash
# Fonction Détail des partitions
function Fonction_var()
{
    echo "On va tester"
    name=$(declare -F | awk '{print $3}')
    echo $name
}

Fonction_var

exit 0