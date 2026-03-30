{%- macro download_github_release(download_url, checksum, output) -%}
{%- if grains.id != 'dom0' -%}

{#-
  Downloads a release file from Github, compares it against supplied checksum,
  then copies it over Qubes RPC back to the originating qube
-#}

'{{ slsdotpath }}:: parent dir':
  file.directory:
    - name: '{{ salt['file.dirname'](output) }}'
    - makedirs: true

'{{ slsdotpath }}:: downloading {{ download_url }}':
  cmd.run:
    - name: "qvm-run-vm -p @dispvm:dvm-fetch -- '/usr/share/qubes-user/download {{ download_url }} {{ checksum }}' > {{ output }}"
    - require:
      - file: '{{ slsdotpath }}:: parent dir'
    - unless:
      - fun: file.check_hash
        args:
          - '{{ output }}'
          - '{{ checksum }}'

{%- endif -%}
{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
