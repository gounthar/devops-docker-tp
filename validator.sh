#!/bin/bash
# This is a bash script for validating Docker images and containers.

set -euo pipefail
# The 'set' command is used to change the values of shell options and set the positional parameters.
# '-e' option will cause the shell to exit if any invoked command fails.
# '-u' option treats unset variables and parameters as an error.
# '-o pipefail' option sets the exit code of a pipeline to that of the rightmost command to exit with a non-zero status.

IMG=$(echo img$$)
# Creating a unique image name using the process ID of the current shell.

docker image build --tag $IMG ./src # --load
# Building a Docker image from the Dockerfile located in the ./src directory.
# The built image is tagged with the unique name generated above.
# The '--load' option ensures the built image is loaded into the Docker daemon only if you use docker buildx.

USR=$(docker container run --rm --entrypoint=whoami $IMG )
# Running a Docker container from the image built above.
# The container is removed after its execution (--rm option).
# The entrypoint of the container is overridden to execute the 'whoami' command.
# The output of 'whoami' (which is the username) is stored in the USR variable.

if [[ $USR == "root" ]]; then
echo "User cannot be root!"
fi
# Checking if the user inside the container is root.
# If it is, an error message is printed.

docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null
# Running a Docker container in detached mode from the image built above.
# The container is removed after its execution (--rm option).
# A temporary filesystem is mounted at /tmp inside the container (--tmpfs option).
# The filesystem of the container is mounted as read-only (--read-only option).
# The output of this command is redirected to /dev/null to suppress it.

ID=$(docker container ls -laq)
# Getting the ID of the last created container.

RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)
# Checking the status of the container with the ID obtained above.
# The status is extracted from the output of 'docker container inspect' command using a format string.

if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
echo "Container cannot run in read-only mode!"
fi
# Checking if the container is running.
# If it is, the container is killed.
# If it's not, an error message is printed.

docker rmi $IMG > /dev/null
# Removing the Docker image built above.
# The output of this command is redirected to /dev/null to suppress it.
