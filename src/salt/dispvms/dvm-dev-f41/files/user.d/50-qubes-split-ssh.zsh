[ -n "${QUBES_SPLIT_SSH_VAULT}" ] \
  && export SSH_AUTH_SOCK="$( find "/tmp/qubes-split-ssh/${QUBES_SPLIT_SSH_VAULT}" -type s | head -n1 )"

