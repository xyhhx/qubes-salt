{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- if grains.id != 'dom0' -%}
{%- if grains.os_family | lower == 'redhat' -%}

{%- set fedora_release = salt["cmd.run"]('rpm -E \%fedora') -%}
{%- set licenses = ["free", "nonfree"] -%}
{%- set repos_variants = ["", "-updates"] -%}


'rpmfusion':
  cmd.run:
    - names:
{% for license in licenses %}
      - 'curl -sL https://download1.rpmfusion.org/{{ license }}/fedora/rpmfusion-{{ license }}-release-{{ fedora_release }}.noarch.rpm | dnf in -y '
{% endfor %}

{% for license, variant in licenses | product(["", "-updates"]) %}
      - 'dnf config-manager setopt rpmfusiont-{{ license ~ variant }}.enabled=1'
{% endfor %}

    - use_vt: true


{%- endif -%}
{%- endif -%}
