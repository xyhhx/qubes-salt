#!/usr/bin/env sh
set -xeu

grep -Ir . -e '^#!' \
| grep -v .git \
| grep -v qubes-mgmt-salt-user/vendor \
| cut -f1 -d: \
| xargs -I {} shellcheck {} -x ./bin/lib.sh

