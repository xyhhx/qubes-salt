{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:gpg2", "provides-split-gpg2") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}

{{ templatevm(vm_name) }}

/etc/qubes/policy.d/user.d/39-split-gpg2.policy:
  file.managed:
    - contents: |
        qubes.Gpg2 + @tag:split-gpg2-client @tag:split-gpg2-server allow notify=yes
        qubes.Gpg2 + @tag:dev-vm            @tag:split-gpg2-server allow notify=yes
        qubes.Gpg2 + @anyvm                 @tag:split-gpg2-server ask   default_target=vault-pgp

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - pinentry-qt
      - pinentry-tty
      - split-gpg2
      - xfce4-notifyd
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
