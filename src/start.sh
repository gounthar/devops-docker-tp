#!/bin/sh
set -eu

touch /tmp/started.time
date > /tmp/started.time

exec "$@"
