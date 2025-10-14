{%- set vm_name = "uses-app-thunderbird" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

include:
  - common.pkgs.dnf-plugins-core

'{{ slsdotpath }}':
  pkgrepo.managed:
    - copr: 'celenity/copr'
    - enabled: true
  pkg.installed:
    - pkgs:
      - dove
      - qubes-core-agent-networking
      - sequoia-sq
      - sequoia-chameleon-gnupg
      - split-gpg2
      - thunderbird
  file.managed:
    - name: '/etc/thunderbird/defaults/pref/dove-overrides.js'
    - source: 'salt://{{ tpldir }}/files/dove-overrides.js'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
