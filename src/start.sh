#!/bin/sh
# Ce script est utilisé pour créer un fichier de timestamp dans un répertoire temporaire et y écrire la date et l'heure actuelles.

set -eu
# Setting shell options for better error handling and debugging.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.
# Ici on retire l'option 'x' comme demandé dans le raedme

# On crée un répertoire temporaire en écriture seule pour éviter les problèmes avec le mode lecture seule
mkdir -p /tmp/www

# On crée le fichier de timestamp dans le répertoire temporaire que l'on vient de créer juste au dessus
touch /tmp/www/started.time

if [ $? -ne 0 ]; then
    exit
fi
# This conditional statement checks the exit status of the last command (touch command in this case).
# If the exit status is not zero, which indicates an error, the script will exit immediately.

date > /tmp/www/started.time
# This command writes the current date and time to the 'started.time' file.
# The '>' operator is used to redirect the output of the 'date' command to the file.
# Ici, on change le répertoire de "home/www/" à "tmp/www/" car c'est là que ce trouve le fichier que l'on vient de créer

exec "$@"
# This command replaces the current shell process with the command given as argument.
# It's used to pass control from the script to another program or command.
# The "$@" is a special variable that holds all the arguments passed to the script.
