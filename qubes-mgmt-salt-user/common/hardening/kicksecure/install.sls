{%- if grains.os_family | lower == 'debian' -%}
{%-   if salt["cmd.retcode"]("apt list --installed | grep kicksecure") != 0 -%}

'{{ slsdotpath }}:: prereqs':
  pkg.installed:
    - pkgs:
      - apt-transport-tor
      - extrepo
    - refresh: true

'{{ slsdotpath }}::enable kicksecure extrepo':
  cmd.run:
    - name: 'https_proxy=http://127.0.0.1:8082 extrepo enable kicksecure'
    - use_vt: true
    - require:
      - pkg: '{{ slsdotpath }}:: prereqs'

'{{ slsdotpath }}::install kicksecure':
  pkg.installed:
    - name: 'kicksecure-qubes-cli'
    - refresh: true
    - require:
      - cmd: '{{ slsdotpath }}::enable kicksecure extrepo'

'{{ slsdotpath }}::install extra pkgs':
  pkg.installed:
    - pkgs:
      - mokutil
      - tirdad
    - refresh: true
    - require:
      - pkg: '{{ slsdotpath }}::install kicksecure'

{%-   else -%}

"{{ slsdotpath }}:: already installed":
  test.succeed_without_changes:
    - name: "Kicksecure is already installed"

{%-   endif -%}
{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
