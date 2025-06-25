{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:onlykey", "uses-app-onlykey") -%}

{% if grains.id == "dom0" %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{%- load_yaml as vm_options %}
features:
  - set:
    - menu-items: Alacritty.desktop
    - default-menu-items: Alacritty.desktop OnlyKey.desktop

{% endload -%}
{{ templatevm(vm_name, base_template="debian-12-xfce", options=vm_options) }}

{% else %}

{%- set source_url = "https://github.com/trustcrypto/OnlyKey-App/releases/download/v5.5.0/OnlyKey_5.5.0_amd64.deb" -%}
{%- set source_hash = "24d784cba9a919f7dcbccb85f344da85cfef4f648d07f9091c1362d9bdb1b69fcdb7d09831d2c476ad99bbc76f9d5ddbfa6da6a15bec01e7edd8464aa6886c98" -%}
{%- set deb_filename = "OnlyKey_5.5.0_amd64.deb" -%}

"{{ slsdotpath }}.{{ vm_name }} - set up onlykey app deb":
  cmd.run:
    - names:
      - "curl -sLO {{ source_url }}":
        - creates: /opt/{{ deb_filename }}
      - "echo -n '{{ source_hash }}  {{ deb_filename }}' | sha512sum -c"
      - "apt install -y /opt/{{ deb_filename }}"
    - use_vt: true
    - cwd: /opt
    - env:
      - https_proxy: http://127.0.0.1:8082

qubes-usb-proxy:
  pkg.installed

{% endif %}
