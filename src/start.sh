#!/bin/sh
# This script is used to perform actions at container startup.

set -eu
# Set shell options for better error handling and debugging.
# 'e' - Exit the script if any command returns a non-zero exit status.
# 'u' - Treat unset variables as errors.

# You can add other necessary actions or commands for startup here.
# For example, running database migrations, initializing settings, etc.

exec "$@"
# Replace the current shell process with the command specified as arguments.
# This is used to pass control from the script to another program or command.
# "$@" holds all the arguments passed to the script.
