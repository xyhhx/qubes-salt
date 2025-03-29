<!-- vim: set wrap : -->

# qubes-mgmt-salt-user

an attempt to rewrite my qubes os setup as saltstack configuration.

[canonical source](https://git.sr.ht/~xyhhx/qubes-mgmt-salt-user)

mirrors:

[github](https://github.com/xyhhx/qubes-salt) | [codeberg](https://codeberg.org/xyhhx/qubes-salt)

[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](LICENSE.md)

---

## quick start

### prerequisites

you must have already enabled the user salts. you can run the following in dom0 to do that:

```sh
sudo qubesctl top.enable qubes.user-dirs
sudo qubesctl state.apply
```

### installation

- clone the repo in any vm
- the commands to run in dom0 can be found by running `make cmd-install-domu` from the project workspace. **please inspect them before running them!**
- now you may enable tops as you please, and apply their states/highstates accordingly

---

some resources i referenced while working on this (thanks!):

- https://git.drkhsh.at/salt-n-pepper/file/README.md.html
- https://forum.qubes-os.org/t/qubes-salt-beginners-guide/20126
- https://github.com/ben-grande/qusal
- https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user (obviously)
- https://github.com/unman/shaker
- https://github.com/freedomofpress/securedrop-workstation
