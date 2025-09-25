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
        - custom-persist.split_gpg2_conf: 'file:user:user:0600:/home/user/.config/qubes-split-gpg2/qubes-split-gpg2.conf'
        - custom-persist.split_gpg2_conf_d: 'dir:user:user:0700:/home/user/.config/qubes-split-gpg2/conf.d'
        - custom-persist.home_local_share: 'dir:user:user:0700:/home/user/.local/share'
    - require:
      - sls: templates.{{ template_name }}
  file.managed:
    - name: '/etc/qubes/policy.d/30-split-gpg2.policy'
    - source: 'salt://appvms/vault-pgp/files/split-gpg2.policy'
    - template: 'jinja'
    - replace: true
    - user: root
    - group: qubes
    - mode: '0640'
    - makedirs: true
    - defaults:
        client_tag: 'split-gpg2-client'
        policy: 'qubes.Gpg2'
        server_tag: 'split-gpg2-server'
        vault_vm: 'vault-pgp'
    - context:
        vault_vm: '{{ vm_name }}'


{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

