{%- if grains.id != 'dom0' -%}

'{{ slsdotpath }}':
  file.managed:
    - names:
      - '/usr/lib/systemd/system/hardened_malloc.service':
        - source: 'salt://{{ tpldir }}/files/hardened_malloc.service'
      - '/usr/share/qubes-user/preload-hardened-malloc':
        - source: 'salt://{{ tpldir }}/files/preload-hardened-malloc'
        - mode: '0755'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
  service.enabled:
    - name: 'hardened_malloc'
    - require:
      - file: '{{ slsdotpath }}'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
