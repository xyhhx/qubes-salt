#!/bin/bash
set -euxo pipefail

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
  required "source vm" "${1}"
  required "source directory" "${2}"

  src_vm="${1}"
  src_dir="${2}"
  tmp_dir=$(mktemp -d)
  src_tarball="/tmp/${default_tarball}"
  backup="/tmp/salt-backup/$(echo "${RANDOM}" | base64).bak"

  pushd "${tmp_dir}"
  qvm-run --pass-io "${src_vm}" "cd ${src_dir} && ${src_dir}/scripts/lift.sh"
  (qvm-run --pass-io "${src_vm}" "cat ${src_tarball}" > "${tmp_dir}/salt.tar.xz")

  mkdir -p "src/"
  cd src
  tar xjvf "${tmp_dir}/salt.tar.xz"

  mkdir -p "${backup}"
  sudo mv /srv/user "${backup}/srvuser"
  if [[ -d "${HOME}/salt" ]]; then
    sudo mv "${HOME}/salt" "${backup}"
  fi

  mkdir -p "${HOME}/salt"
  sudo mv ./srv/user /srv/user
  rmdir srv
  mv ./* "${HOME}/salt"
  ln -s /srv "${HOME}/salt/srv"
  popd

  rm -rf "${tmp_dir}"
  sudo qubesctl saltutil.clear_cache
  sudo qubesctl saltutil.sync_all

  cat <<-EOF
  --

  The project has been installed.

  Previous version backed up to: ${backup}
  Current version installed to: /srv/user
  The rest of the project is available at: ${HOME}/salt

  --
EOF
}

required() {
  if [[ -z "${2}" ]]; then
    cat <<-EOF
    ${1} is a required argument.
    Please call this script like make lift \$src_vm \$src_dir
    Exiting...
EOF
    exit 1
  fi
}

if [ "$(hostname)" == "dom0" ]; then
  unpack "${@}"
else
  pack
fi

