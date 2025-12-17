{%- set vm_name = 'dvm-fetch' -%}

{%- if grains.id == 'dom0' -%}

{%- set template_name = 'provides-fetch' -%}
{%- set label = 'red' -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
      - mem: 400
    - prefs:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: Alacritty.desktop

'/usr/local/etc/qubes/policy.d/available/30-dvm-fetch.policy':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/30-dvm-fetch.policy.j2'
    - template: 'jinja'
    - user: 'root'
    - group: 'root'
    - mode: '0640'
    - context:
        vm_name: vm_name

'/usr/local/etc/qubes/policy.d/enabled/30-dvm-fetch.policy':
  file.symlink:
    - target: '/usr/local/etc/qubes/policy.d/available/30-dvm-fetch.policy'

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
