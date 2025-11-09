#!/usr/bin/env bash
set -xeuo pipefail

logger \
  -t "ivpn-connect.rc" \
  "Connecting to IVPN..."

: "${DISPLAY:=":0"}"

# shellcheck disable=SC2207
servers=( $(ivpn servers -p wg | awk '{ print $2}' | tail -n +2 | sed -nE 's/(.*)\|/\1/p') )
user="$(id -nu 1000)"
entry_svr="${servers[ ${RANDOM} % ${#servers[@]} ]}"
exit_svr="${servers[ ${RANDOM} % ${#servers[@]} ]}"

ivpn firewall -persistent_on
ivpn connect -v2ray quic -port UDP:443 -exit_svr "${exit_svr}" "${entry_svr}"

logger \
  -t "ivpn-connect.rc" \
  "Connected to ${entry_svr} and ${exit_svr} over WG, port 443/UDP over V2Ray"

sudo -u "${user}" \
  notify-send "IVPN Connected" \
  "Connected to ${entry_svr} and ${exit_svr} over WG, port 443/UDP over V2Ray"

# vim: ft=sh :
