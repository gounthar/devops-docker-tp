#!/bin/sh
set -eu

# Create a temporary directory to store the started.time file
temp_dir=$(mktemp -d)

# Create a file named started.time in the temporary directory
touch "$temp_dir/started.time"

# Write the current date and time into the started.time file
date > "$temp_dir/started.time"

# Pass control to the next command
exec "$@"
