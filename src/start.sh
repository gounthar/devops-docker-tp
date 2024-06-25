#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

set -eux

# Setting shell options for better error handling and debugging.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.
# 'x' option prints each command that gets executed to the terminal, useful for debugging.
# Utiliser un répertoire temporaire pour les écritures
TMP_DIR=/tmp
TIMESTAMP_FILE="$TMP_DIR/started.time"

# Créer le fichier de timestamp dans le répertoire temporaire
touch $TIMESTAMP_FILE
if [ $? -ne 0 ]; then
    exit 1
fi
# This conditional statement checks the exit status of the last command (touch command in this case).
# If the exit status is not zero, which indicates an error, the script will exit immediately.

# Écrire la date actuelle dans le fichier de timestamp
date > $TIMESTAMP_FILE

# Exécuter la commande passée en argument
exec "$@"
