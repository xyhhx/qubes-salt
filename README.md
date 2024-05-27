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

### Notes

- I don't like the default convention of `/srv/user_{formulas,pillar,salt}`, so I use `srv/user/{formulas,pillar,salt}` and symlink them.
- I prefer not to use the `git bundle` function that is recommended [in some other examples](https://git.drkhsh.at/salt-n-pepper/file/README.md.html), because I would rather not install Git in dom0 at all.

---

Some references I referred to (thanks!):

- https://git.drkhsh.at/salt-n-pepper/file/README.md.html
- https://forum.qubes-os.org/t/qubes-salt-beginners-guide/20126
