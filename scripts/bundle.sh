#!/bin/bash --
set -xeuo pipefail

# workdir is probably the parent directory
workdir="$(realpath "${0%"${0##*/}"}/..")"
hostname="$(hostname)"
default_domu_bundle_path="/tmp/bundles/bundles.tar.gz"
default_dom0_bundles_path="${workdir}/.bundles"

do_domu() {
  output="${1:-${default_domu_bundle_path}}"
  output_dir="${output%/"${output##*/}"}"

  # we can loop through all the submodules and creates bundles
  git submodule foreach "git bundle create ${output_dir}/\$(basename \${sm_path}).bundle --all"
  git bundle create "${output_dir}/$(basename "${workdir}")".bundle --all
  find "${output_dir}" -type f | tar czT- >"${output}"
}

do_dom0(){
  guest_domain="${1}"

  qvm-run -p "${guest_domain}" "cat ${default_domu_bundle_path}" | tar xvC "${default_dom0_bundles_path}" -T-
  enable=all

}

if [[ "${hostname}" == "dom0" ]]; then do_dom "${@}"; else do_domu "${@}"; fi

# NOTE: yeah this is cooked, i know
