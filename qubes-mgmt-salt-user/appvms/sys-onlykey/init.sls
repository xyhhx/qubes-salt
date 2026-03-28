{%- set vm_name = 'sys-onlykey' -%}
{%- set template_name = 'provides-onlykey-agent' -%}

{%- if grains.id == 'dom0' -%}

{%- set policies_dir = '/usr/local/etc/qubes/policy.d' -%}
{%- set policy_files = [
  '30-onlykey-gpg.policy',
  '30-onlykey-ssh.policy'
] -%}

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
        - custom-persist.gnupghome: 'dir:user:user:0700:/home/user/.gnupg'
    - tags:
      - add:
        - onlykey-gpg-server
        - onlykey-ssh-server

'{{ slsdotpath }}:: install policies':
  file.managed:
    - require:
      - qvm: '{{ vm_name }}'
    - names:
{% for file in policy_files %}
      - '{{ policies_dir | path_join('available', file) }}':
        - source: 'salt://{{ tpldir | path_join('files/dom0', policies_dir, file ) }}.j2'
{% endfor %}
    - template: 'jinja'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
    - context:
        vm_name: '{{ vm_name }}'

'{{ slsdotpath }}:: enable policies':
  file.symlink:
    - require:
      - file: '{{ slsdotpath }}:: install policies'
    - names:
{% for file in policy_files %}
      - '{{ policies_dir | path_join('enabled', file) }}':
        - target: '{{ policies_dir | path_join('available', file) }}'
{% endfor %}
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

'/home/user/.config/autostart/ssh-add.desktop':
  file.managed:
    - source: 'salt://{{ tpldir | path_join('files/vm/home/user/.config/autostart/ssh-add.desktop') }}'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0700'
    - makedirs: true
    - replace: true


{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
