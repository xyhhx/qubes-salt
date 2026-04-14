# Style Guide

## VM Salts

### Qube Names

Qube names are designed with human intuition in mind. They're intended to be
named such that one could infer their usage based on the name as much as is
possible, and the patterns signify what class of qube they are (Template,
AppVM, DisposableVM, etc). This is achieved through predictable prefixes.

To some degree, existing patterns are maintained (such as `dvm-*` and `disp-*`
for disposable VMs). In some cases, existing patterns are diverged from (base
templates are not named directly after operating systems, and there is no
`default-dvm`)

#### TemplateVMs

> [!NOTE]
> The default templates (`fedora-43`, `fedora-43-minimal`, etc) are configured
> with the `prohibit-start`[^docs-prohib-start] and
> `skip-update`[^docs-skip-upd] QVM features. They're not intended to be used
> directly on systems using these salts, and are strictly to be used as a basis
> for other templates

1.  `on-*` - these are templates that are analogous to the base templates
    offered by Qubes repos (both ITL and otherwise), but with modifications
    fitting this repo.

    **Examples:** `on-fedora-43-minimal`, `on-debian-13-xfce` offer minimally
    modified versions of the baseline templates `fedora-43-minimal`, and
    `debian-13-xfce`, respectively.

1.  `uses-app-*` - these templates are intended to offer a single application,
    and are built on top of minimal templates. Typically they will not include
    other quality of life tools like file browsers. They will also default to
    adding the designated application to the app menu.

    **Examples:** `uses-app-thunderbird` offers the Thunderbird e-mail
    application, `uses-app-senpai` offers the Senapi IRC client.

1.  `uses-stack-*` - these templates have more fleshed out use cases, such as
    used for software development, building packages, or perhaps design tools.
    How they're intended to be used will vary somewhat on a per use case basis.

    **Examples:** `uses-stack-dev` provides all the tools needed for dev work;
    but *not* a browser, for example.

1.  `provides-*` - these templates "provide" tools to other qubes, and will
    almost always match a `sys-*` AppVM. They will probably contain RPC services
    and their policies, too.

    **Examples:** `provides-usb` is a template that can be used to create AppVMs
    suitable to be used as `sys-usb` qubes.

#### AppVMs

1.  `app-*` - these are AppVMs that offer a singular application, and are based
    on the `uses-app-*` templates.

    When possible, the `custom-persist`[^docs-custom-persist] feature should be
    used to minimize the persistent directories.

    **Examples:** `uses-app-thunderbird` would have only the Thunderbird mail
    client installed.

1.  `sys-*` - these AppVMs offer something to be used by other qubes. Generally
    they are not networked (but might be!) and have an accompanying RPC policy.
    They're based on `provides-*` templates.

    **Examples:** `sys-net` provides a network device to another qube;
    `sys-onlykey` provides Onlykey functions to another qube.

1.  `vault-*` - these AppVMs contain secrets that must never leave these qubes.
    They must never be networked, and won't include the
    `qubes-core-agent-networking` package. They may be based on either
    `uses-app-*` or `provides-*` templates, depending on use case.

    **Examples:** `vault-creds` holds password credentials, and is based on the
    `uses-app-keepassxc` template; whereas `vault-pgp` holds PGP private keys
    and is based on the `provides-split-gpg2` template, since it's used with Qubes
    split GPG-2[^docs-split-gpg2].

1.  `id-*` - some AppVMs may have this prefix to group them for certain
    identities. Ideally, they will likewise have their own RPC policies and
    firewall rules to enforce isolation. For now they're not handled by Salt.

    **Examples:** `id-1-trivalent`, and `id-1-mfw-trivalent` could describe a
    `uses-app-trivalent` AppVM that has been restricted to certain websites
    using Mirage OS firewall.

#### DisposableVMs

1.  `dvm-*` - these are AppVMs that are configured as disposable
    templates[^docs-disp-templates].

    **Examples:** `dvm-trivalent` is a disposable template to use the Trivalent
    browser in.

1.  `disp-*` - these are named disposables[^docs-named-disposables], based on a
    given `dvm-*` disposable template.

    **Examples:** `disp-sys-usb` is a named disposable that provides the USB
    device to the system, and can reliably be referred to in rules.

#### StandaloneVMs

StandaloneVMs follow the same names as AppVMs for now.


### Salt State Design

#### Directory Structure

All qubes' salt states should have the following files:

```text
.
├── configure.sls
├── create_vm.sls
├── init.sls
└── README.md
```

These are responsible for the following:

1.  `init.sls` is the index salt, and it should *only* be used to include other
    states

1.  `create_vm.sls` only holds states to run in dom0, and only contains code for
    configuring the qube itself

1.  `configure.sls` should hold basic configuration like `pkg.installed` states

    1.  This can hold code for both the guest as well as `dom0`. While the
        `pkg.installed` example is quite obvious, an example of what `dom0`
        configuration might include could be policies.

1.  `README.md` ideally every qubes' directory should have a readme that will
    contain some information about how to use it and what it's for.

#### File Includes

When adding files to qubes' states, they should be placed in directories that
match the following convention:

```jinja
{{ tpldir }}/files/{{ dest_vm }}/{{ dest_vm_full_path }}/{{ dest_filename }}
```

Where:

1.  `{{ tpldir }}` is the actual `tpldir` SLS template
    variable[^docs-sls-tpldir].

1.  `{{ dest_vm }}` is either `vm` if the file will be placed in a guest, or
    `dom0` if the file will be placed in dom0.

1.  `{{ dest_vm_full_path }}` is the full path to the destination where the file
    will be placed in the `dest_vm`. For example, an RPC policy might be
    `etc/qubes/policy.d`.

1.  `{{ dest_filename }}` is the name of the file as it will appear in the
    `dest_vm`.

      1. If the file is a Jinja template, then the `.j2` file extension should
         be appended to the filename.

#### Miscellaneous Coding Styles

1.  Use double-quotes whenever possible
1.  All SLS files should end with the following vimline comment:

    ```jinja
    {#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
    ```

[^docs-custom-persist]: https://dev.qubes-os.org/projects/core-admin-client/en/latest/manpages/qvm-features.html#custom-persist
[^docs-disp-templates]: https://doc.qubes-os.org/en/r4.3/user/how-to-guides/how-to-use-disposables.html#disposable-template
[^docs-named-disposables]: https://doc.qubes-os.org/en/r4.3/user/how-to-guides/how-to-use-disposables.html#named-disposable
[^docs-prohib-start]: https://dev.qubes-os.org/projects/core-admin-client/en/latest/manpages/qvm-features.html#prohibit-start
[^docs-skip-upd]: https://dev.qubes-os.org/projects/core-admin-client/en/latest/manpages/qvm-features.html#skip-update
[^docs-sls-tpldir]: https://docs.saltproject.io/en/3007/ref/states/vars.html#tpldir
[^docs-split-gpg-2]: https://doc.qubes-os.org/en/r4.3/user/security-in-qubes/split-gpg-2.html
