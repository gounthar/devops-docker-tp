#!/bin/sh
# This script is used to create a timestamp file and write the current date and time into it.

set -eux

# Use a temporary directory for writing
TEMP_DIR=$(mktemp -d)

# Create a timestamp file in the temporary directory
touch "$TEMP_DIR/started.time"

# Check if the touch command was successful
if [ $? -ne 0 ]; then
    exit
fi

# Write the current date and time to the file
date > "$TEMP_DIR/started.time"

# Execute the given command
exec "$@"
