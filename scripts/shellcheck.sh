#!/bin/bash --
set -xeuo pipefail

find . -type f -name \*.sh -exec shellcheck {} ";"

