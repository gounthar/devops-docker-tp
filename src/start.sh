#!/bin/sh

set -eux

mkdir -p /home/newuser/www
touch /home/newuser/www/started.time

if [ $? -ne 0 ]; then
    exit
fi

date > /home/newuser/www/started.time

exec "$@"
