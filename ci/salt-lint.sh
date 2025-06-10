#!/bin/bash --
set -xeuo pipefail

find src/ -type f -name \*.sls -print0 | xargs -0 -I {} salt-lint --force-color -vvv {}
