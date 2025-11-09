{%- set vm_name = "uses-app-element" -%}
{%- set base_template = "debian-13-minimal" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
features:
  - disable:
    - selinux
tags:
  - add:
    - whonix-updatevm
    - on-kicksecure
{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- else -%}

{%- set signing_key = '/usr/share/keyrings/element-io-archive-keyring.gpg' -%}

{%- from 'utils/user_info.jinja' import user -%}

'{{ signing_key }}':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/element-io.gpg'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0644'
    - makedirs: true

'deb [signed-by={{ signing_key }}] https://packages.element.io/debian/ default main':
  pkgrepo.managed:
    - file: '/etc/apt/sources.list.d/element-io.list'
    - key_url: 'salt://{{ tpldir }}/files/element-io.gpg'

'{{ slsdotpath }}:pkgs':
  pkg.installed:
    - pkgs:
      - element-desktop
      - element-nightly
      - gnome-keyring
      - qubes-core-agent-networking

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
