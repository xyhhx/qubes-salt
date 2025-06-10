# vim: set ts=2 sw=2 sts=2 et sts :

---
{% set name = "templates.provides-flatpak.init" %}
{% set vm_name = salt["pillar.get"]("vm_names:templates:providers:flatpak") %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41
    - features:
      - set:
        - menu-items: Alacritty.desktop
        - default-menu-items: com.github.tchx84.Flatseal.desktop io.github.flattool.Warehouse Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}


{# unfortunately salt doesn't support --user args for systemctl so i gotta do it manually #}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - flatpak
  file.recurse:
    - name: /etc/skel/.config/systemd/user
    - source: salt://templates/provides-flatpak/files/systemd
    - user: root
    - group: root
    - file_mode: '0644'
    - dir_mode: '0755'
    - clean: true
    - makedirs: true
    - replace: true
    - force: true

'{{ name }} / ensure systemd targets dir perms':
  file.directory:
    - names:
      - /etc/systemd/user/default.target.wants
      - /etc/systemd/user/timers.target.wants
      - /etc/systemd/user/paths.target.wants
    - owner: root
    - group: root
    - dir_mode: '0755'
    - allow_symlinks: true
    - clean: false
    - makedirs: true

'{{ name }} / make symlinks':
  file.symlink:
    - names:

      - '/etc/systemd/user/paths.target.wants/user-flatpak-apps.path':
        - target: '/home/user/.config/systemd/user/user-flatpak-apps.path'

      - '/etc/systemd/user/default.target.wants/user-install-flathub.service':
        - target: '/home/user/.config/systemd/user/user-install-flathub.service'

      - '/etc/systemd/user/default.target.wants/qubes-sync-appmenus.service':
        - target: '/home/user/.config/systemd/user/qubes-sync-appmenus.service'

      - '/etc/systemd/user/default.target.wants/user-install-flatseal.service':
        - target: '/home/user/.config/systemd/user/user-install-flatseal.service'

      - '/etc/systemd/user/default.target.wants/user-install-warehouse.service':
        - target: '/home/user/.config/systemd/user/user-install-warehouse.service'

      - '/etc/systemd/user/default.target.wants/user-update-flatpaks.service':
        - target: '/home/user/.config/systemd/user/user-update-flatpaks.service'

      - '/etc/systemd/user/timers.target.wants/user-update-flatpaks.timer':
        - target: '/home/user/.config/systemd/user/user-update-flatpaks.timer'

    - makedirs: true
    - user: root
    - group: root
    - atomic: true
    - require:
      - file: '{{ name }}'


{% endif %}
