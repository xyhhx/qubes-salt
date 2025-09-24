{%- set vm_name = 'vault-creds' -%}
{%- set template_name = 'uses-app-keepassxc' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: gray
    - prefs:
      - template: '{{ template_name }}'
      - label: gray
    - features:
      - enable:
        - service.custom-persist
      - set:
        - menu-items: org.keepassxc.KeePassXC.desktop
        - custom-persist.keepassxc_config: 'dir:user:user:0700:/home/user/.config/keepassxc'
        - custom-persist.usrlocal: 'dir:user:user:0700:/usr/local/share/keepassxc'

{% else %}

'/usr/local/share/keepassxc':
  file.directory:
    - user: 1000
    - group: 1000
    - dir_mode: '0700'
    - file_mode: '0600'
    - makedirs: true

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
