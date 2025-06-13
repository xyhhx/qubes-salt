#!/bin/bash --
set -xeuo pipefail

conf_file=/srv/salt/minion.d/user_includes.conf
uid="$(id -u)"
hostname="$(hostname)"

[[ "${uid}" == 0 ]] || echo "Run this as sudo or root" && exit
[[ "${hostname}" == "dom0" ]] || echo "Run this in dom0" && exit
test -f "${conf_file}" && echo "File exists. Delete it before continuing" && exit

CONFIG_DIR="${CONFIG_DIR:-$(sudo -su 1000 'echo "${XDG_CONFIG_DIR}"')}"
mkdir -p "${CONFIG_DIR}"

envsubst "${CONFIG_DIR}" <../config/user_includes.conf.tpl >/etc/salt/minion.d/user_includes.conf
