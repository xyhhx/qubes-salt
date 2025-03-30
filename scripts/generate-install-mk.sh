#!/bin/bash

[[ -n "$DEBUG" ]] && set -x
set -euo pipefail

topfiles=$(find src/salt -maxdepth 1 -type f -name "*.top")
state_files=$(find src -type f -not -wholename "src/salt/*.top")

echo "${topfiles}${state_files}" | sed 's/src\///;s/.*/install -m0644 -D & $(DESTDIR)$(USER_SALT)&/'
