#!/usr/bin/env sh
set -xeu

find "${1}" -type f \( -name \*.sls -o -name \*.top -o -name \+.jinja -o -name \*.j2 \) -print0 | xargs -0 --no-run-if-empty salt-lint --force-color
