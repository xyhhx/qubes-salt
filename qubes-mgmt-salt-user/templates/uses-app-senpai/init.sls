{%- set vm_name = "uses-app-senpai" -%}
{%- set base_template = "fedora-42-minimal" -%}

{%- if grains.id == 'dom0' -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{%- else -%}

'{{ vm_name }}':
  environ.setenv:
    - names:
      - http_proxy
      - https_proxy
      - all_proxy
    - value: 'http://127.0.0.1:8082'
    - update_minion: true
  pkg.installed:
    - pkgs:
      - golang
      - qubes-core-agent-networking
      - scdoc
  git.cloned:
    - name: 'https://git.sr.ht/~delthas/senpai'
    - target: '/opt/senpai'
  cmd.run:
    - names:
      - 'make'
      - 'make install':
        - creates: '/usr/bin/senpai'
        - env:
          - PREFIX: '/usr'
    - cwd: '/opt/senpai'
  file.managed:
    - name: '/usr/share/applications/senpai.desktop'
    - source: 'salt://{{ tpldir }}/files/senpai.desktop'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
