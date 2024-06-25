#!/bin/bash

set -euo pipefail

IMG=$(echo img$$)

docker image build --tag $IMG ./src # --load

USR=$(docker container run --rm --entrypoint=whoami $IMG )

if [[ $USR == "root" ]]; then
  echo "User cannot be root!"
fi

docker container run --rm --detach --tmpfs /tmp --read-only $IMG > /dev/null

ID=$(docker container ls -laq)

RUNNING=$(docker container inspect -f '{{.State.Status}}' $ID)

if [[ $RUNNING == "running" ]]; then
    docker kill $ID > /dev/null
else
  echo "Container cannot run in read-only mode!"
fi

docker rmi $IMG > /dev/null
