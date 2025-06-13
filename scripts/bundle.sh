#!/bin/bash --
set -xeuo pipefail

domain="$(qubesdb-read /name)"
workdir="$(git rev-parse --show-toplevel)"
domu_bundle_path="/tmp/bundles/bundles.tar.gz"
dom0_bundles_path="${workdir}/.bundles"


do_domu() {
  output="${1:-"${output:-"${domu_bundle_path}"}"}"
  output_dir="${output%/"${output##*/}"}"
  mkdir -p "${output_dir}"

  git submodule foreach "git bundle create ${output_dir}/\$(basename \${sm_path}).bundle --all"
  git bundle create "${output_dir}/$(basename "${workdir}")".bundle --all
  find "${output_dir}" -type f | tar czT - >"${output}"
}

do_dom0() {
  guest="${1:-"${guest:-"${GUEST_DOMAIN}"}"}"
  bundle="${2:-"${bundle:-"${GUEST_BUNDLE:-"${domu_bundle_path}"}"}"}"
  [[ -z "${guest}" ]] && (show_help; exit 1)

  qvm-run -p "${guest}" "cat ${bundle}" | tar xvC "${dom0_bundles_path}" -T-
  git stash -u
  git pull --recurse-submodules --rebase --force
}

show_help() {

  if [[ "${domain}" == "dom0" ]]; then

    cat <<-EOF
dom0 side helper to pull git bundles from a guest.

Usage:
bundle.sh [guest] [bundle]

guest    The guest VM to pull changes from. Can be set with GUEST_DOMAIN environment variable
bundle   The directory on the guest to pull the bundles from. Can be set with GUEST_BUNDLE. If nothing is specified, it will default to looking in /tmp/bundles/bundles.tar.gz
EOF
  else
    cat <<-EOF
domU side helper to bundle this repo and its submodules

Usage:
bundle.sh [output]

output    A file path where the script should produce a tarball. Defaults to /tmp/bundles/bundles.tar.gz
EOF
  fi
}


if [[ "${domain}" == "dom0" ]]; then do_dom "${@}"; else do_domu "${@}"; fi

