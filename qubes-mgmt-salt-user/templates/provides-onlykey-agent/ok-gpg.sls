{%- if grains.id != 'dom0' -%}

{%- from 'utils/user_info.jinja' import user with context -%}
{%- from 'utils/macros/download_github_release.sls' import download_github_release -%}

{#- TODO: Move some of this to pillar data (including pillar.example) -#}
{%- set release_number = 'v1.1.2' -%}
{%- set release_asset = 'ok-gpg-agent-linux.tar.gz' -%}
{%- set download_url = 'https://github.com/svareille/OnlyKey-gpg-agent/releases/download/' | path_join(release_number, release_asset) -%}
{%- set checksum = 'fd0d0dc493cef830132f84c7d66f5713db9cbf03195354bfe633ab1834b10340' -%}

'{{ slsdotpath }}:: install qubes-gpg-split':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split

{{ download_github_release(state_id=slsdotpath ~ ':: download ok-gpg-agent release', download_url=download_url, checksum=checksum, output='/tmp/' | path_join(release_asset)) }}

'{{ slsdotpath }}:: extract ok bins':
  archive.extracted:
    - require:
      - cmd: '{{ slsdotpath }}:: download ok-gpg-agent release'
    - name: '/usr/bin'
    - source: '{{ '/tmp/' | path_join(release_asset) }}'
    - source_hash: 'sha256={{ checksum }}'
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

{#
'{{ slsdotpath }}:: ok-agent.toml.example':
  file.managed:
    - require:
      - file: '{{ slsdotpath }}:: gpg-agent drop-in override'
    - name: '/etc/skel/ok-agent.toml.example'
    - source: 'salt://{{ tpldir | path_join('files/etc/skel', 'ok-agent.toml.example') }}'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
#}

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
