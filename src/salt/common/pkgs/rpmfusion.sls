{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- if grains.id != 'dom0' -%}
{%- if grains.os_family | lower == 'redhat' -%}

{%- set licenses = ["free", "nonfree"] -%}
{%- set release = salt["grains.get"]("osrelease", "41") -%}

'rpmfusion':
  cmd.run:
    - names:
{% for license in licenses %}
      - 'curl -sL https://download1.rpmfusion.org/{{ license }}/fedora/rpmfusion-{{ license }}-release-{{ release }}.noarch.rpm | dnf in -y '
{% endfor %}

{% for license, variant in licenses | product(["", "-updates"]) %}
      - 'dnf config-manager setopt rpmfusiont-{{ license ~ variant }}.enabled=1'
{% endfor %}

    - use_vt: true


{%- endif -%}
{%- endif -%}
