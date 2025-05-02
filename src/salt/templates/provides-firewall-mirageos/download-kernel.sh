#!/bin/bash --
set -eo pipefail

for v in VERSION DOMU KERNEL_URL DIGEST_URL; do
  [[ -z "$v" ]] &&
    echo "The following env vars are required: $VERSION $DOMU $KERNEL_URL $DIGEST_URL" &&
    exit 1
done

[[ "$DOMU" == "dom0" ]] && echo "Do not run in dom0." && exit 1

DESTDIR=${DESTDIR:-/var/lib/qubes/vm-kernels/mirage-firewall-${VERSION}}

if [[ -f "${DESTDIR}/vmlinuz" ]]; then
  echo "${DESTDIR} exists. backing up..."
  mv "$DESTDIR" "${HOME}/$(basename "$DESTDIR").$(date "+%F_+%s").bak"
fi

tmpdir="$(mktemp -d /tmp/mirage-firewall-"$VERSION"-XXXXXX)"

echo "Downloading kernel in ${DOMU}..."

qvm-run --dispvm "$(qvm-prefs management_dispvm)" -p "$DOMU" "$(
  cat <<EOF
  set -euo pipefail
  cd \$(mktemp -d)
  curl -sLOO ${KERNEL_URL} ${DIGEST_URL}
  sed -i 's/dist\///' $(basename "${DIGEST_URL}")
  sha256sum -c $(basename "${DIGEST_URL}") 1>/dev/null && mv $(basename "${KERNEL_URL}") /tmp/$(basename "${KERNEL_URL}");
  cat /tmp/$(basename "${KERNEL_URL}")
EOF
)"

echo "Sanity check..."

[[ $(du -k "${tmpdir}/vmlinuz" | cut -f1) == 0 ]] && exit 1

echo "Copying to ${DESTDIR}/vmlinuz"

mkdir -p "$DESTDIR"
cp "${tmpdir}/vmlinuz" "${DESTDIR}/vmlinuz"

echo "Removing ${tmpdir}"

rm -rf "$tmpdir"

echo "Done"

exit 0
