#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

set -eu
# Setting shell options for better error handling and debugging.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.

# Le script de vérification validator.sh étant en read-only, on change le chemin de création ou modification du fichier vers le dossier temp pour garantir l'accès en USER
touch /tmp/started.time
# If the file already exists, the command does not change the file but updates its access and modification timestamps.

if [ $? -ne 0 ]; then
    exit
fi
# This conditional statement checks the exit status of the last command (touch command in this case).
# If the exit status is not zero, which indicates an error, the script will exit immediately.

# Suite aux changements précédents, on change également ce chemin-ci.
date > /tmp/started.time
# This command writes the current date and time to the 'started.time' file.
# The '>' operator is used to redirect the output of the 'date' command to the file.

exec "$@"
# This command replaces the current shell process with the command given as argument.
# It's used to pass control from the script to another program or command.
# The "$@" is a special variable that holds all the arguments passed to the script.
