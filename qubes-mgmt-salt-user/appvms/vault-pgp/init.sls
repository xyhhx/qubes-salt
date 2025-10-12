{%- set vm_name = "vault-pgp" -%}
{%- set template_name = "provides-split-gpg2" -%}

{% if grains.id == 'dom0' %}

include:
  - templates.{{ template_name }}

split-gpg2-dom0:
  pkg.installed

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: gray
      - mem: 400
    - prefs:
      - template: '{{ template_name }}'
      - label: gray
      - memory: 400
      - maxmem: 800
      - netvm: ''
    - features:
      - enable:
        - service.custom-persist
      - set:
        - custom-persist.gnupg_home: 'dir:user:user:0700:/home/user/.gnupg'
        - custom-persist.home_config: 'dir:user:user:0700:/home/user/.config'
        - custom-persist.home_local_share: 'dir:user:user:0700:/home/user/.local/share'
    - require:
      - sls: templates.{{ template_name }}

'/usr/local/etc/qubes/policy.d/available/30-split-gpg2.policy':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/split-gpg2.policy.j2'
    - template: 'jinja'
    - replace: true
    - user: 'root'
    - group: 'qubes'
    - mode: '0640'
    - attrs: 'i'
    - makedirs: true
    - defaults:
        client_tag: 'split-gpg2-client'
        policy: 'qubes.Gpg2'
        server_tag: 'split-gpg2-server'
        vault_vm: 'vault-pgp'
    - context:
        vault_vm: '{{ vm_name }}'

'/usr/local/etc/qubes/policy.d/enabled/30-split-gpg2.policy':
  file.symlink:
    - target: '/usr/local/etc/qubes/policy.d/available/30-split-gpg2.policy'
    - user: 'root'
    - group: 'qubes'
    - mode: '0640'
    - makedirs: true

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

