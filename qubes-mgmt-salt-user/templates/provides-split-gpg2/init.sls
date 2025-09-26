{%- set vm_name = "provides-split-gpg2" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - pinentry-qt
      - sequoia-chameleon-gnupg
      - sequoia-keystore-server
      - sequoia-policy-config
      - sequoia-sop
      - sequoia-sq
      - sequoia-sqv
      - split-gpg2
    - install_recommends: false
    - skip_suggestions: true

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
