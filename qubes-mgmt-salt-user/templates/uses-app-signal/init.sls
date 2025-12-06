{%- set vm_name = "uses-app-signal" -%}
{%- set base_template = "debian-13-minimal" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
features:
  - set:
    - default-menu-items: signal-desktop.desktop
  - disable:
    - selinux
tags:
  - add:
    - on-kicksecure
    - whonix-updatevm
{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- else %}
{% set signing_key = '/usr/share/keyrings/signal-desktop-keyring.gpg' -%}

{%- from 'utils/user_info.jinja' import user -%}

include:
  - common.hardening.kicksecure

'{{ signing_key }}':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/signal-desktop.gpg'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0644'
    - makedirs: true
    - require:
      - sls: common.hardening.kicksecure

'deb [signed-by={{ signing_key }}] tor+https://updates.signal.org/desktop/apt xenial main':
  pkgrepo.managed:
    - file: '/etc/apt/sources.list.d/signal-desktop.list'
    - key_url: 'salt://{{ tpldir }}/files/signal-desktop.gpg'

'{{ slsdotpath }}:pkgs':
  pkg.installed:
    - pkgs:
      - signal-desktop
      - qubes-core-agent-networking

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
