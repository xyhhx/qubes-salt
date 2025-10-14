{%- macro download_mirage_kernel(options) -%}
{%- if grains.id == 'dom0' -%}

{#-
  This macro will download the mirage kernel and place it in /var/lib/qubes/vm-kernels/mirage-firewall-{{ version }}
-#}

{%- set mirage_version = options.release -%}
{%- set mirage_sha256sum = options.checksum -%}

{%- set kernel_filename = 'qubes-firewall.xen' -%}
{%- set kernel_dl_url = 'https://github.com/mirage/qubes-mirage-firewall/releases/download/' ~ mirage_version ~ '/' ~ kernel_filename -%}
{%- set dom0_mirage_kernel_directory = '/var/lib/qubes/vm-kernels/mirage-firewall-' ~ mirage_version -%}

{#- If the kernel exists, we're done here -#}
{%- if salt['file.file_exists']( dom0_mirage_kernel_directory ~ '/vmlinuz' ) != true -%}

{%- if dl_dispvm is eq '' -%}
{%- set dl_dispvm = salt['cmd.shell']('qubes-prefs default_dispvm') -%}
{%- endif -%}

'{{ dl_dispvm }}':
  qvm.vm:
    - actions:
      - start
      - run
      - shutdown
    - start:
      - flags:
        - dvm
    - run:
      - cmd: |
          mkdir -p -- /tmp/mirage
          cd /tmp/mirage
          curl --connect-timeout 10 \
            --tlsv1.3 --proto =https \
            -fsSLO {{ kernel_dl_url }}
          [ sha256sum /tmp/mirage/{{ kernel_filename }} | cut -f2 -d\  = '{{ mirage_sha256sum }}' ] || exit 1
          cat {{ kernel_filename }}
      - localcmd: |
          tee /tmp/mirage-firewall-{{ mirage_version }} >/dev/null
      - flags:
        - nogui
        - pass-io
    - shutdown
  file.managed:
    - name: '{{ dom0_mirage_kernel_directory }}/vmlinuz'
    - source: '/tmp/mirage-firewall-{{ mirage_version }}'
    - source_hash: 'sha256={{ mirage_sha256sum }}'
    - user: 'root'
    - group:  'root'
    - mode: '0644'
    - makedirs: true

'/tmp/mirage-firewall-{{ mirage_version }}':
  file.absent

{%- endif -%}
{%- endif -%}
{%- endmacro -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
