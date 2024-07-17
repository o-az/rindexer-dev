#!/bin/bash

set -e

echo "Running: $(/root/.rindexer/bin/rindexer --version)"

exec "$@"
