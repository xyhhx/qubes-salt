{% macro templatevm(name, options={}, base_template="fedora-43-minimal") %}

{%- load_yaml as defaults -%}
prefs:
  - label: black

  - memory: 400
  - maxmem: 2000
  - vcpus: 1

  - kernel: "*default*"
  - kernelopts: "*default*"
  - pci-strictreset: true
  - virt-mode: pvh

  - audiovm: "*default*"
  - guivm: "*default*"
  - netvm: "*default*"

  - autostart: false
  - debug: false
  - default-user: user
  - include-in-backups: false
  - internal: false
  - qrexec-timeout: 120

features:
  - enable:
    - selinux
    - service.hardened_malloc

  # These remain after cloning the base templates, so they have to be removed
  - disable:
    - prohibit-start
    - skip-updates

  - set:
    - menu-items: Alacritty.desktop
    - default-menu-items: Alacritty.desktop
{%- endload -%}

{%- set vm = {} -%}
{%- do salt["defaults.merge"](vm, defaults, in_place=true) -%}
{%- do salt["defaults.merge"](vm, salt["pillar.get"]("qvm_defaults", default={}), in_place=true) -%}
{%- do salt["defaults.merge"](vm, options, in_place=true) -%}

"{{ slsdotpath }}.{{ sls }}:qvm.template_installed":
  qvm.template_installed:
    - name: "{{ base_template }}"

"{{ name }}":
  qvm.vm:

    - clone:
      - source: "{{ base_template }}"

    {{ vm | dict_to_sls_yaml_params | indent }}

    - order: 1
    - require:
      - qvm: '{{ slsdotpath }}.{{ sls }}:qvm.template_installed'

"{{ name }}:disable-qvm-features":
  qvm.features:
    - name: "{{ name }}"
    # These remain after cloning the base templates, so they have to be removed
    - disable:
      - prohibit-start
      - skip-updates


{% endmacro %}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
