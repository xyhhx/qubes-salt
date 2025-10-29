#!/bin/env bash

if [[ -z "${SCRIPT}" ]]; then
  >&2 echo "No \$SCRIPT set. Are you sourcing this properly?"
  exit 1
fi

if [[ -z "${SYNOPSIS}" ]]; then
  >&2 echo "No \$SYNOPSIS set. Are you sourcing this properly?"
  exit 1
fi

die_usage() {
  args=$*
  >&2 echo "${SCRIPT}: ${args}"
  >&2 echo "Usage: ${SYNOPSIS}"
  exit 1
}

die() {
  CODE=$1
  shift
  opts=$*
  >&2 echo "${opts}"
  exit "${CODE}"
}

try() {
  args=$*
  debug_log "...Trying '${args}'"
  "$@" || die 2 "${args} ... failed"
}

log() {
  msg="${2:-$1}"
  test -z "${2+x}" && shift
  log_level="${1:-info}"
  printf "[%s]\t%s\n" "${log_level}" "${msg}"
}

debug_log() {
  test -z "${DEBUG:-}" || >&2 log "debug" "$@"
}

pushd_hush() {
  try pushd "$@" >/dev/null
}

popd_hush() {
  try popd >/dev/null
}

missing_env() {
  printf "The environment variable %s is required but not set. Exiting" "${1}"
  exit 1
}
