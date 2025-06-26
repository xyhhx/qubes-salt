{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- if grains.id != 'dom0' -%}

{%- if grains.os_family | lower == 'redhat' -%}

{%- set fedora_release = salt["cmd.run"]("rpm -E %fedora") -%}
{%- set licenses = ["free", "nonfree"] -%}
{%- set repos_variants = ["", "-updates"] -%}

{%- for license in licenses -%}

'curl -sL https://download1.rpmfusion.org/{{ license }}/fedora/rpmfusion-{{ license }}-release-{{ fedora_release }}.noarch.rpm | dnf in -y ':
  cmd.run:
    - use_vt: true
    - env:
      - https_proxy: http://127.0.0.1:8082

{%- endfor -%}

{%- endif -%}
{%- endif -%}
