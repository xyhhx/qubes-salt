<!-- vim: set wrap : -->

<div align="center">

# Qubes OS workstation configuration

Documenting the configuration of my Qubes OS workstation through config-as-code with salt

Mirrors:

[![codeberg](https://img.shields.io/badge/codeberg-2185d0?style=for-the-badge&logo=codeberg&logoColor=fff)](https://codeberg.org/xyhhx/qubes-mgmt-salt-user)
[![sourcehut](https://img.shields.io/badge/srht-212529?style=for-the-badge&logo=sourcehut&logoColor=fff)](https://git.sr.ht/~xyhhx/qubes-mgmt-salt-user)
[![0xacab](https://img.shields.io/badge/0xacab-ea4636?style=for-the-badge&logo=gitlab&logoColor=fff)](https://0xacab.org/xyhhx/qubes-mgmt-salt-user)

[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?style=flat-square&label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](LICENSE.md)
[![Latest Release](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/badges/release.svg?style=flat-square)](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/releases)
[![Stars](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/badges/stars.svg?style=flat-square)](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/stars)
[![Open Issues](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/badges/issues/open.svg?style=flat-square)](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/issues)
[![Latest Build](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/badges/workflows/codeberg.yml/badge.svg?style=flat-square)](https://codeberg.org/xyhhx/qubes-mgmt-salt-user/actions?workflow=codeberg.yml&actor=0&status=0)
![Community on Matrix](https://img.shields.io/badge/User%20Community%20on%20Matrix-gray?style=flat-square&logo=matrix&labelColor=63a0ff&link=https%3A%2F%2Fmatrix.to%2F%23%2F%23qubes-os-user-community%3A4d2.org)


---

</div>

> [!Warning]
> **This repo isn't stable yet and stuff will pretty much surely break.**
>
> If you want to use it, feel free; but no promises anything works as expected. Feel free to open issues though!

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

### Using the Make tasks

> [!Important]
> The Make tasks requires a `GUEST` variable to be set. It should be the name of the guest domain that holds the repo's source code. You can either pass it directly (`GUEST=my-dev-qube make...`)

> [!Tip]
> You can export the `GUEST` variable to the environment to make life easier

> [!Warning]
> While the Make tasks try to ensure that commands are only ran in the appropriate domains (i.e. dom0 or guests), the checks are frail. Be mindful of what you're running!

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

    > [!Tip]
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
make pull-bundles
```

### Render a statefile

You can check what the Jinja renderer outputs by with the `render` task:

```sh
# in dom0
make render $(pwd)/qubes-mgmt-salt-user/common/hardening/kmods.sls
```

> [!Note]
> The parameter must be an absolute path

---

## Acknowledgments

The following resources were very useful for learning Salt, especially in the context of Qubes OS; and for getting inspiration about how to design my own states (thanks!):

- <https://github.com/ben-grande/qusal>
- <https://git.drkhsh.at/salt-n-pepper/file/README.md.html>
- <https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user>
- <https://github.com/unman/shaker>
- <https://github.com/freedomofpress/securedrop-workstation>
- <https://forum.qubes-os.org/t/qubes-salt-beginners-guide/20126>
