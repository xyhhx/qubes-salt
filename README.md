<!-- vim: set wrap : -->

# my qubes os saltstack configuration

an attempt to rewrite my qubes os setup as saltstack configuration.

[canonical source](https://git.sr.ht/~xyhhx/qubes-salts)

mirrors:

[github](https://github.com/xyhhx/qubes-salt) | [codeberg](https://codeberg.org/xyhhx/qubes-salt)

[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](LICENSE.md)

______________________________________________________________________

## usage

- enable the `qubes.user_dirs` state

- replace any occurance of `/srv/user_salt` with `/srv/user/salt` etc

- clone the repo in any vm

- the commands to run in dom0 can be found by running `make cmd-install-domu` from the project workspace. **please inspect them before running them!**

- now you may enable tops as you please, and apply their states/highstates accordingly

  - for example:

    ```sh
    targets="on-fedora-41-minimal,uses-app-trivalent,dvm-trivalent"
    sudo qubesctl top.enable "${targets}"
    sudo qubesctl state.apply --targets "${targets}"
    ```

______________________________________________________________________

some resources i referenced while working on this (thanks!):

- <https://git.drkhsh.at/salt-n-pepper/file/README.md.html>
- <https://forum.qubes-os.org/t/qubes-salt-beginners-guide/20126>
- <https://github.com/ben-grande/qusal>
- <https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user>
- <https://github.com/unman/shaker>
- <https://github.com/freedomofpress/securedrop-workstation>
