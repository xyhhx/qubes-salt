{%- macro download_mirage_kernel(version, checksum) -%}
{%- if grains.id == 'dom0' -%}

{#-
  This macro will download the mirage kernel and place it in /var/lib/qubes/vm-kernels/mirage-firewall-{{ version }}
-#}

{%- set kernel_filename = 'qubes-firewall.xen' -%}
{%- set download_url = 'https://github.com' | path_join('mirage/qubes-mirage-firewall/releases/download', version, kernel_filename) -%}
{%- set mirage_dest_dir = '/var/lib/qubes/vm-kernels/mirage-firewall-' ~ version -%}
{%- set tmpdir = salt["cmd.shell"]("mktemp -d") -%}

{#- If the kernel exists, we're done here -#}
{%- if salt['file.file_exists']( mirage_dest_dir | path_join('/vmlinuz') ) != true -%}

'{{ slsdotpath }}:: download mirage {{ version }}':
  cmd.run:
    - name: "qvm-run --dispvm dvm-fetch -p -- '/usr/share/qubes-user/download {{ download_url }} {{ checksum }}' > {{ tmpdir | path_join(kernel_filename) }}"
    - use_vt: true

'{{ slsdotpath }}:: verify and install mirage {{ version }}':
  file.managed:
    - require:
      - cmd: '{{ slsdotpath }}:: download mirage {{ version }}'
    - name: '{{ mirage_dest_dir | path_join('vmlinuz') }}'
    - source: '{{ tmpdir | path_join(kernel_filename) }}'
    - source_hash: 'sha256={{ checksum }}'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{%- endif -%}
{%- endif -%}
{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

