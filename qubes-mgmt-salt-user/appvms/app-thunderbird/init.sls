{%- set vm_name = 'app-thunderbird' -%}
{%- set template_name = 'uses-app-thunderbird' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: 'blue'
    - prefs:
      - template: '{{ template_name }}'
      - label: 'blue'
    - features:
      - enable:
        - service.custom-persist
        - service.split-gpg2-client
      - set:
        - custom-persist.home_autostart_thunderbird: 'dir:user:user:0700:/home/user/.config/autostart'
        - custom-persist.home_cache_thunderbird: 'dir:user:user:0700:/home/user/.cache/thunderbird'
        - custom-persist.home_gnupg: 'dir:user:user:0700:/home/user/.gnupg'
        - custom-persist.home_mozilla: 'dir:user:user:0700:/home/user/.mozilla'
        - custom-persist.home_pgpcertd: 'dir:user:user:0700:/home/user/.local/share/pgp.cert.d'
        - custom-persist.home_thunderbird: 'dir:user:user:0700:/home/user/.thunderbird'
        - menu-items: 'net.thunderbird.Thunderbird.desktop'
        - menu-favorites: 'net.thunderbird.Thunderbird.desktop'
    - tags:
      - add:
        - split-gpg2-client

{% else %}

'/home/user/.config/autostart/net.thunderbird.Thunderbird.desktop':
  file.symlink:
    - target: '/usr/share/applications/net.thunderbird.Thunderbird.desktop'
    - user: 'user'
    - group: 'user'
    - mode: '0700'
    - attrs: 'i'
    - makedirs: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
