{%- set vm_name = 'sys-onlykey' -%}
{%- set template_name = 'provides-onlykey-agent' -%}

{%- if grains.id == 'dom0' -%}

{%- set policies_dir = '/usr/local/etc/qubes/policy.d' -%}
{%- set policy_file = '30-onlykey-ssh.policy' -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: yellow
    - prefs:
      - template: '{{ template_name }}'
      - label: yellow
      - memory: 600
      - maxmem: 1000
      - netvm: ''
    - features:
      - enable:
        - custom-persist
        - minimal-usbvm
        - servicevm
      - set:
        - menu-items: Alacritty.desktop
        - custom-persist.home_ok_config: 'dir:user:user:0700:/home/user/.config/onlykey'
    - tags:
      - add:
        - onlykey-ssh-server
'{{ policies_dir }}/available/{{ policy_file }}':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/dom0{{ policies_dir }}/{{ policy_file }}.j2'
    - template: 'jinja'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: 'i'
    - makedirs: true
    - context:
        vm_name: '{{ vm_name }}'

'{{ policies_dir }}/enabled/{{ policy_file }}':
  file.symlink:
    - target: '{{ policies_dir }}/available/{{ policy_file }}'
    - makedirs: true

{%- else -%}

{%- from 'utils/user_info.jinja' import user with context -%}

'/home/{{ user }}/.config/onlykey/ssh-agent.conf':
  file.managed:
    - replace: false
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0700'
    - makedirs: true
    - contents: ""

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
