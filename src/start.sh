#!/bin/sh

set -eux

TMP_DIR=$(mktemp -d /tmp/tmp.XXXXXX)

touch "$TMP_DIR/started.time"

if [ $? -ne 0 ]; then
    exit
fi

date > "$TMP_DIR/started.time"

exec "$@"
