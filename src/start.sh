#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

set -eu
# Setting shell options for better error handling.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.

# Création d'un fichier started.time en tant que fichier temporaire pour qu'il soit accessible par validator.sh 
touch /tmp/started.time
# This command creates a file named 'started.time' in the 'tmp/ directory.
# If the file already exists, the command updates its access and modification timestamps.

if [ $? -ne 0 ]; then
    exit
fi
# This conditional statement checks the exit status of the previous command.
# If the exit status is not zero, which indicates an error, the script exits immediately.

# Write the current date and time to the 'started.time' file.
date > /tmp/started.time
# The '>' operator redirects the output of the 'date' command to the 'started.time' file.

# Replace the current shell process with the command passed as arguments.
exec "$@"
# This command passes control from the script to another program or command.
# "$@" holds all the arguments passed to the script.
