{%- macro download_github_release(download_url, checksum, output) -%}
{%- if grains.id != "dom0" -%}
{%- from "utils/user_info.jinja" import user -%}

{#-
  Downloads a release file from Github, compares it against supplied checksum,
  then copies it over Qubes RPC back to the originating qube
-#}

"{{ slsdotpath }}:: parent dir":
  file.directory:
    - name: "{{ salt["file.dirname"](output) }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0750"
    - makedirs: true

"{{ slsdotpath }}:: downloading {{ download_url }}":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}:: parent dir"
    - name: |
        qvm-run-vm @dispvm:dvm-fetch -- "/usr/share/qubes-user/download {{ download_url }} {{ checksum }}" > {{ output }}

{%- endif -%}
{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
