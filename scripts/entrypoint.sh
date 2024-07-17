#!/bin/bash

set -e

echo "Running rindexer"

/root/.rindexer/bin/rindexer --version

exec "$@"
