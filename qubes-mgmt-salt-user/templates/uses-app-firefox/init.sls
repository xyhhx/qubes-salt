{%- set vm_name = "uses-app-firefox" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

include:
  - common.pkgs.dnf-plugins-core

'{{ vm_name }}':
  pkgrepo.managed:
    - name: 'celenity'
    - copr: 'celenity/copr'
  pkg.installed:
    - pkgs:
      - firefox
      - phoenix
      - qubes-ctap
      - qubes-core-agent-networking

{# FIXME: This isn't working properly #}
'/etc/firefox/defaults/pref/phoenix-overrides.js':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/phoenix-overrides.js'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

'{{ slsdotpath }}: configure qubes-ctapproxy':
  cmd.run:
    - names:
      - 'systemctl disable qubes-ctapproxy@sys-usb.service'
      - 'systemctl enable qubes-ctapproxy@disp-sys-usb.service':
        - creates: '/etc/systemd/system/multi-user.target.wants/qubes-ctapproxy@disp-sys-usb.service'

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
