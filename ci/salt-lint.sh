#!/bin/ash --
set -xeu

export PATH="${HOME}/.local/bin:${PATH}"

apk add pipx=1.7.1-r0
pipx install salt-lint
salt-lint \
  --force-color -v \
  src/salt/appvms/* \
  src/salt/dispvms/* \
  src/salt/templates/* \
  src/salt/common \
  src/salt/common/pkgs/*.sls \
  src/salt/dom0
