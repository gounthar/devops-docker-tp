#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

set -eu
# Setting shell options for better error handling and debugging.
# 'e' option will cause the shell to exit if any invoked command fails.
# 'u' option treats unset variables and parameters as an error.

WORKDIR=/home/noroot/app

# Create a work directory
mkdir -p $WORKDIR

# Change to the work directory
cd $WORKDIR

# Create a timestamp file and write the current date and time into it
touch started.time
date > started.time

exec "$@"
