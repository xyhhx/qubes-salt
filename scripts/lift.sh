#!/bin/bash
set -eux

# This script is used to send the repo up to dom0. It's intended to be used via
# Make, by running `make lift $domU`. Make will call this script from dom0.
#
# If called from a domU, it will pack itself into an xz-compressed tarball.
#
# If called from dom0, it will call itself in the specified domU (to compress itself),
# copy it into a temp dir, extract it and copy it into the user's homedir, then rsync
# the srv/ project directory to /srV

default_tarball="salt.tar.xz"

pack() {
  dest="/tmp/${default_tarball}"
  tar cjvf "${dest}" .
  cat <<-EOF


The project has been packed and is available at ${dest}
If you've already extracted this project to it, you can re-run this script to update it.
EOF
}

unpack() {
  src_vm="${1}"
  src_dir="${2}"
  src_tarball="/tmp/${default_tarball}"
  tmp_dir=$(mktemp -d)
  qvm-run --pass-io "${src_vm}" "cd ${src_dir} && ${src_dir}/scripts/lift.sh"
  qvm-run --pass-io "${src_vm}" "cat ${src_tarball}" > /tmp/salt.tar.xz
  tar xjvf /tmp/salt.tar.xz .
  pushd "${tmp_dir}"
  mkdir -p ~/qubes_salt
  rsync -azP . ~/qubes_salt
  popd
  sudo rsync -azP ~/qubes_salt/srv /
  rm /tmp/salt.tar.xz
}

if [ "$(hostname)" == "dom0" ]; then
  unpack "${@}"
else
  pack
fi
