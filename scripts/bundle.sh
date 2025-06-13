#!/bin/bash --
set -xeuo pipefail

# workdir is probably the parent directory
workdir="$(realpath "${0%"${0##*/}"}/..")"
outdir="$(mktemp -d /tmp/"$(basenme "$workdir")"-XXXXXX)"
OUT_FILE="${OUT_FILE:-"${outdir}/bundles.tar.gz"}"

# we can loop through all the submodules and creates bundles
git submodule foreach "git bundle create ${outdir}/\$(basename \$sm_path).bundle --all"
git bundle create "${outdir}/$(basename "$workdir").bundle" --all
find "$outdir" -type f | tar czT- >"$OUT_FILE"
