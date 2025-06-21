{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:appvms:vault_pgp", "vault-pgp") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:providers:gpg2", "provides-split-gpg2") -%}
{% if grains.id == 'dom0' %}

include:
  - templates.{{ template }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: black
    - prefs:
      - template: '{{ template }}'
      - label: black
      - netvm: ""
      - audiovm: ""
      - memory: 400
      - maxmem: 800
      - vcpus: 2
    - require:
      - sls: templates.{{ template }}
    - tags:
      - add:
        - split-gpg2-server
        - vault-vm

{% else %}

/home/user/.config/qubes-split-gpg2/conf.d/30-defaults.conf:
  file.managed:
    - source: salt://appvms/vault-pgp/files/qubes-split-gpg2.conf
    - user: 1000
    - group: 1000
    - mode: '0644'
    - dir_mode: '0755'
    - makedirs: true

{% endif %}
