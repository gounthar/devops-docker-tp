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
#creation of an image from src directory, image name is $IMG

USR=$(docker container run --rm --entrypoint=whoami $IMG )
# Creation of a temporary container from the image built above with --rm
# Container is create with the image created above
#whaomi will be stocked in USR

if [[ $USR == "root" ]]; then
echo "User cannot be root!"
fi
# Check thaht the user is root

docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null
# temporary container is created in detached mode with --rm, --tmpfs and --read-only flags.
# use the image created above
# final output is redirected to /dev/null to suppress it.

ID=$(docker container ls -laq)
# Last container ID 

RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)
# docker container inspect command is used to obtain detailed information about the container, get the status of the container and store it in the RUNNING variable.

if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
echo "Container cannot run in read-only mode!"
fi
# Checking if the container is running.
# If it is, the container is killed.
# If it's not, shell will print the message "Container cannot run in read-only mode!".

docker rmi $IMG > /dev/null
# Delete the image created above
