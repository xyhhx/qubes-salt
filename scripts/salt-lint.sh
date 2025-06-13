#!/bin/bash --
set -xeuo pipefail

find src/ -type f \( -name \*.sls -o -name \*.top -o -name \+.jinja -o -name \*.j2 \) -exec salt-lint --force-color "${0}" {} \;
