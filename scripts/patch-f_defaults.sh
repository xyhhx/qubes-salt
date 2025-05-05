#!/bin/bash
set -xeuo pipefail

src_vm="${1}"
src_dir="${2}"

qvm-run -p "$src_vm" "cat ${src_dir}/scripts/f_defaults.conf.patch" | sudo patch /etc/salt/minion.d/f_defaults.conf
