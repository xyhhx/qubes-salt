{%- if grains.id != "dom0" -%}

{%- set ivpn_data_dir = "/var/lib/ivpn" -%}
{%- set shared_cargo_bins = "/usr/share/cargo/bin" -%}
{%- set systemd_path = "/usr/lib/systemd/system/ivpn-tun2proxy" -%}
{%- set ivpn_api_server_list = "https://api.ivpn.net/v5/servers.json" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - qubes-core-agent-networking
    - install_recommends: false
    - skip_suggestions: true

"{{ slsdotpath }}:: create shared cargobin dir":
  file.directory:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "{{ shared_cargo_bins }}"
    - user: "root"
    - group: "root"
    - mode: "0755"
    - makedirs: true

"{{ slsdotpath }}:: fetch tun2proxy bin":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}:: create shared cargobin dir"
    - name: |
        qvm-run-vm @dispvm:dvm-dev -- cargo install --locked \
          --root /tmp tun2proxy \
          && cat /tmp/bin/tun2proxy-bin" \
        > {{ shared_cargo_bins | path_join("tun2proxy-bin") }}
    - creates: "{{ shared_cargo_bins | path_join("tun2proxy-bin") }}"
    - uses_vt: true

"{{ slsdotpath }}:: ensure bin perms":
  file.managed:
    - require:
      - cmd: "{{ slsdotpath }}:: fetch tun2proxy bin"
    - name: "{{ shared_cargo_bins | path_join("tun2proxy-bin") }}"
    - user: "root"
    - group: "root"
    - mode: "0755"
    - makedirs: true

"{{ slsdotpath }}:: install service unit":
  file.managed:
    - require:
      - file: "{{ slsdotpath }}:: ensure bin perms"
    - name: "{{ systemd_path | path_join("tun2proxy.service") }}"
    - source: "{{ tpldir | path_join("files/vm", systemd_path, "tun2proxy.service.j2") }}"
    - template: "jinja"
    - context:
        svc_bin_path: "{{ shared_cargo_bins | path_join("tun2proxy-bin") }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

"{{ slsdotpath }}:: set http proxy envs":
  environ.setenv:
    - require:
      - file: "{{ slsdotpath }}:: install service unit"
    - name: "https_proxy"
    - value: "http://127.0.0.1:8082"
    - update_minion: true

"{{ slsdotapth }}:: download server list":
  cmd.run:
    - require:
      - environ: "{{ slsdotpath }}:: set http proxy envs"
    - name: |
        curl -sL {{ ivpn_api_server_list }} -o {{ ivpn_data_dir | path_join("servers.json") }}
    - uses_vt: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
