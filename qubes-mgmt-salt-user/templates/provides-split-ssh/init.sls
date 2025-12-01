{%- set vm_name = "provides-split-ssh" -%}
{%- set base_template = "fedora-43-minimal" -%}

{% if grains.id == 'dom0' %}

include:
  - dom0.pkgs.qubes-ctap

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - openssh
      - openssh-askpass
      - qubes-usb-proxy
  file.managed:
    - name: '/etc/qubes-rpc/qubes.SshAgent'
    - source: 'salt://templates/provides-split-ssh/files/ssh-agent.rpc'
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
