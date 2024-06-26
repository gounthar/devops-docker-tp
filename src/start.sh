#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

# enlever le x comme conseillé dans le README
set -eu
# Setting shell options for better error handling and debugging.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.
# 'x' option prints each command that gets executed to the terminal, useful for debugging.

# changement du path car sinon l'utiliseur n'a pas accès
touch /tmp/started.time
# This command creates a file named 'started.time' in the '/home/www' directory.
# If the file already exists, the command does not change the file but updates its access and modification timestamps.

if [ $? -ne 0 ]; then
    exit
fi
# This conditional statement checks the exit status of the last command (touch command in this case).
# If the exit status is not zero, which indicates an error, the script will exit immediately.

# changement du path également afin que l'on puisse écrire dans le fichier
date > /tmp/started.time
# This command writes the current date and time to the 'started.time' file.
# The '>' operator is used to redirect the output of the 'date' command to the file.

exec "$@"
# This command replaces the current shell process with the command given as argument.
# It's used to pass control from the script to another program or command.
# The "$@" is a special variable that holds all the arguments passed to the script.
