#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

set -eu
# Setting shell options for better error handling.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.

touch /home/www/started.time
# This command creates a file named 'started.time' in the '/home/www' directory.
# If the file already exists, the command does not change the file but updates its access and modification timestamps.

date > /home/www/started.time
# This command writes the current date and time to the 'started.time' file.
# The '>' operator is used to redirect the output of the 'date' command to the file.

exec "$@"
# This command replaces the current shell process with the command given as argument.
# It's used to pass control from the script to another program or command.
# The "$@" is a special variable that holds all the arguments passed to the script.
