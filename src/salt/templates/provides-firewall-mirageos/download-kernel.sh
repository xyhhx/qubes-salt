#!/bin/bash --
set -eo pipefail

for v in VERSION KERNEL_URL DIGEST_URL; do
  [[ -z "$v" ]] &&
    echo "The following env vars are required: $VERSION $KERNEL_URL $DIGEST_URL" &&
    exit 1
done

DESTDIR=${DESTDIR:-/var/lib/qubes/vm-kernels/mirage-firewall-${VERSION}}

if [[ -f "${DESTDIR}/vmlinuz" ]]; then
  echo "${DESTDIR} exists. backing up..."
  mv "$DESTDIR" "${HOME}/$(basename "$DESTDIR").$(date "+%F_+%s").bak"
fi

tmpdir="$(mktemp -d /tmp/mirage-firewall-"$VERSION"-XXXXXX)"

qvm-run --dispvm "dvm-fedora-41-xfce" -p "$(
  cat <<EOF
  set -euo pipefail
  cd \$(mktemp -d)
  curl -sLOO ${KERNEL_URL} ${DIGEST_URL}
  sed -i 's/dist\///' $(basename "${DIGEST_URL}")
  sha256sum -c $(basename "${DIGEST_URL}") 1>/dev/null && mv $(basename "${KERNEL_URL}") /tmp/$(basename "${KERNEL_URL}");
  cat /tmp/$(basename "${KERNEL_URL}")
EOF
)" > "${tmpdir}/vmlinuz"

echo "Sanity check..."

[[ $(du -k "${tmpdir}/vmlinuz" | cut -f1) == 0 ]] && exit 1

echo "Copying to ${DESTDIR}/vmlinuz"

mkdir -p "$DESTDIR"
cp "${tmpdir}/vmlinuz" "${DESTDIR}/vmlinuz"

echo "Removing ${tmpdir}"

rm -rf "$tmpdir"

echo "Done"

exit 0
