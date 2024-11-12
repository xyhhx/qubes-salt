<div align="center">

# My Qubes OS Saltstack Configuration

An attempt to rewrite my Qubes OS setup as Saltstack configuration.

[Canonical Source](https://git.sr.ht/~xyhhx/qubes-salt)

Mirrors:

[Github](https://github.com/xyhhx/qubes-salt) | [Codeberg](https://codeberg.org/xyhhx/qubes-salt)

</div>

---

> [!NOTE]
> For now this repo is only designed for my personal use, so helpers for others (for example, to install it) aren't included. In the future I will probably document how to spin this up for the first time on another system.

## Setting up

<small>The following steps assume the code has been cloned into a qube named `disp420` into `/home/user/code/qubes-salt`</small>

- Add `/srv/user/{formulas,pillar,salt}` to `/etc/salt/minion.d/f_defaults.conf`
  - A patchfile and helper script are available in `./scripts`, but the changes are trivial and can be done manually
- To use the helper script, dom0 needs `rsync` and the domU you clone this repo into needs `bzip2`
- Clone this repo into a qube
- From dom0, copy in the lift script:

  ```sh
  qvm-run -p disp420 'cat /home/user/code/qubes-salt/scripts/lift.sh' > lift.sh && chmod +x lift.sh
  ```

  - Consider auditing that script

- Use the script to "lift" the code from the domU into dom0:

  ```sh
  ./lift.sh disp420 /home/user/code/qubes-salt
  ```

---

Some references I referred to (thanks!):

- https://git.drkhsh.at/salt-n-pepper/file/README.md.html
- https://forum.qubes-os.org/t/qubes-salt-beginners-guide/20126