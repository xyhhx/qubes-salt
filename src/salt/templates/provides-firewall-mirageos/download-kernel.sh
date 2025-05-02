#!/bin/bash --
set -eo pipefail

for v in VERSION DOMU KERNEL_URL DIGEST_URL; do
  [[ -z "$v" ]] &&
    echo "The following env vars are required: $VERSION $DOMU $KERNEL_URL $DIGEST_URL" &&
    exit 1
done

DESTDIR=${DESTDIR:-/var/lib/qubes/vm-kernels/mirage-firewall-${VERSION}}

if ls -1 "${DESTDIR}/vmlinuz" 1>/dev/null && ! (grep -e "--force" <(echo "${@}")); then
  echo "${DESTDIR}/vmlinuz already exists! Use --force to overwrite"
  exit 1
fi

tmpdir="$(mktemp -d /tmp/mirage-firewall-"$VERSION"-XXXXXX)"

mkdir -p "$DESTDIR"

qvm-run -p "$DOMU" "$(
  cat <<EOF
  set -xeuo;
  cd /tmp \
    && curl -sLOO ${KERNEL_URL} ${DIGEST_URL}  \
    && diff <(sha256sum /tmp/$(basename "${KERNEL_URL}") | cut -f1 -d\\ ) <(cut -f1 -d\\  </tmp/$(basename "${DIGEST_URL}"))  \
    && echo "checksum match"  \
    && cat /tmp/$(basename "${KERNEL_URL}")
EOF
)" >"${tmpdir}/vmlinuz"

[[ $(du -k "${tmpdir}/vmlinuz" | cut -f1) == 0 ]] && exit 1

cp "${tmpdir}/vmlinuz" "${DESTDIR}/vmlinuz"

rm -rf "$tmpdir"
