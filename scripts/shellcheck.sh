#!/bin/bash --
set -xeuo pipefail

grep -r . -e '#!/bin/\(ba\)\?sh' | cut -f1 -d:  | xargs -I {} shellcheck {}
find . -type f -name \*.sh -exec shellcheck {} \;

