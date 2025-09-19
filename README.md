<!-- vim: set wrap : -->

<div align="center">

# Qubes OS workstation configuration

Documenting the configuration of my Qubes OS workstation through config-as-code with salt

Mirrors:

[![codeberg](https://img.shields.io/badge/codeberg-2185d0?style=for-the-badge&logo=codeberg&logoColor=fff)](https://codeberg.org/xyhhx/qubes-mgmt-salt-user)
[![sourcehut](https://img.shields.io/badge/srht-212529?style=for-the-badge&logo=sourcehut&logoColor=fff)](https://git.sr.ht/~xyhhx/qubes-mgmt-salt-user)
[![0xacab](https://img.shields.io/badge/0xacab-ea4636?style=for-the-badge&logo=gitlab&logoColor=fff)](https://0xacab.org/xyhhx/qubes-mgmt-salt-user)


[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?style=for-the-badge&label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](LICENSE.md)

---

</div>

### First time set up

- In a guest VM, clone the repo into `/usr/local/src` (this avoids username conflicts later)

  ```sh
  git clone ssh://git@codeberg.org/xyhhx/qubes-mgmt-salt-user.git /usr/local/src/qubes-mgmt-salt-user
  ```

- From dom0, run the first-time set up script

  ```sh
  (
    export GUEST=development-qube SRC_DIR=/usr/local/src/qubes-mgmt-salt-user; \
    qvm-run -p "${GUEST}" "cat ${SRC_DIR}/bin/install" | envsubst
  ) | bash
  ```
