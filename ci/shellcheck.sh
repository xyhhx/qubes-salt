#!/usr/bin/env sh
set -xeu

grep -Ir . -e '^#!' | grep -v .git | cut -f1 -d: | xargs -I {} shellcheck {}

