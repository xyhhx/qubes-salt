{%- set vm_name = "uses-app-keepassxc" -%}
{%- set base_template = "fedora-43-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - qrencode
      - keepassxc
  file.directory:
    - name: '/usr/local.orig/share/keepassxc'
    - user: root
    - group: root
    - dir_mode: '0755'
    - file_mode: '0644'
    - makedirs: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : 
