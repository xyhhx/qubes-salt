{%- set vm_name = "provides-split-ssh" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

'{{ sls }} ~ qubes-ctap-dom0':
  pkg.installed:
    - pkgs:
      - qubes-ctap-dom0
    - install_recommends: false
    - skip_suggestions: true

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - ksshaskpass
      - openssh
      - qubes-usb-proxy
  file.managed:
    - name: '/etc/qubes-rpc/qubes.SshAgent'
    - source: 'salt://templates/provides-split-ssh/files/ssh-agent.rpc'
    - user: root
    - group: root
    - mode: '0700'
    - attrs: i
    - makedirs: true

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et : 
