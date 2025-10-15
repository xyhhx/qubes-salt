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

## Usage

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

### Getting started

#### Enabling/disabling top files

Make is used to interact with `qubesctl` and offers a few helper tasks to make working with top files a bit easier:

  - Enabling/disabling top file(s):

    ```sh
    # Enable a top
    make enable dvm-trivalent

    # Enable multiple tops
    make enable on-fedora-42-minimal provides-app-trivalent dvm-trivalent

    # Disabling top(s) work the same
    make disable on-fedora-42-minimal
    ```

  - Enabling/disabling all tops

    ```sh
    # Enable all tops
    make enable-all

    # Disable all tops
    make disable-all
    ```

    > [!Note]
    > This is handy when first setting the repo up. You can run `make enable-all` to quickstart the repo

  - Enable _only_ some tops:

    ```sh
    # Enable only a few tops
    make enable-only dom0 uses-stack-dev dvm-dev
    ```

    > [!Note]
    > This will disable all tops in this repo, then enable the ones provided

### Running `state.apply`

The makefile also has helper tasks for running `qubesctl state.apply`

  - Applying a state to a few targets:

    ```sh
    # Apply Trivalent states
    make apply uses-app-trivalent dvm-trivalent
    ```

  - Applying "batch targets" (i.e. `--all`, `--templates`, `--standalones`, `--apps`):

    ```sh
    # Apply all template states
    make apply templates
    ```

  - These can be used together:

    ```sh
    # Apply all templates and a few other tops
    make apply templates dvm-trivalent app-thunderbird
    ```

### Pulling updates to dom0

Bundling changes and lifting them to dom0 is also easily done with the available Make tasks:

```sh
# In dom0
make pull-bundle
```
