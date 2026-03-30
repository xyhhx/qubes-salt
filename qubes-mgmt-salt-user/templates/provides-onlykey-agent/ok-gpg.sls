{%- if grains.id != 'dom0' -%}

{%- from "./opts.jinja" import ok_agent_pkg -%}

{%- from 'utils/user_info.jinja' import user with context -%}
{%- from 'utils/macros/download_github_release.sls' import download_github_release -%}

{%- set tmpdir = salt["cmd.shell"]("mktemp -d") -%}

{{ download_github_release(download_url=ok_agent_pkg["download_url"], checksum=ok_agent_pkg["release"].checksum, output=tmpdir | path_join(ok_agent_pkg["release_asset"])) }}

'{{ slsdotpath }}:: install qubes-gpg-split':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split

'{{ slsdotpath }}:: extract ok bins':
  archive.extracted:
    - require:
      - cmd: '{{ slsdotpath }}:: downloading {{ ok_agent_pkg["download_url"] }}'
    - name: '/usr/bin'
    - source: '{{ '/tmp/' | path_join(ok_agent_pkg["release_asset"]) }}'
    - source_hash: 'sha256={{ ok_agent_pkg["release"].checksum }}'
    - keep_source: false

'{{ slsdotpath }}:: gpg-agent drop-in override':
  file.managed:
    - require:
      - archive: '{{ slsdotpath }}:: extract ok bins'
    - name: '/etc/systemd/user/gpg-agent.service.d/10-ok-gpg-agent.conf'
    - source: 'salt://{{ tpldir | path_join('files/vm/etc/systemd/user/gpg-agent.service.d', '10-ok-gpg-agent.conf') }}'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
