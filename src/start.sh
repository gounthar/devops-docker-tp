#!/bin/sh
# Ce script est utilisé pour créer un fichier de timestamp et y écrire la date et l'heure actuelles.

set -eu
# 'e' fait en sorte que le shell quitte en cas d'erreur.
# 'u' traite les variables non définies comme des erreurs.

# Crée un fichier nommé 'started.time' dans le répertoire temporaire.
touch /tmp/started.time

# Si la commande touch échoue, le script s'arrête.
if [ $? -ne 0 ]; then
    exit
fi

# Écrit la date et l'heure actuelles dans le fichier 'started.time'.
date > /tmp/started.time

# Remplace le processus shell actuel par la commande fournie en argument.
exec "$@"
