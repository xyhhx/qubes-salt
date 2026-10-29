{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}":
  file.managed:
    - names:
      - "/usr/lib/systemd/system/hardened_malloc.service":
        - source: "salt://{{ tpldir | path_join("/files/vm/hardened_malloc.service" ~ ".j2") }}"
        - mode: "0644"
        - template: "jinja"
        - context:
            preload_hardened_malloc_script: {{ salt("pillar.get")["user_qvms:prefs:dirs:user_bins"] }}
      - "/usr/share/qubes-user/preload-hardened-malloc":
        - source: "salt://{{ tpldir | path_join("/files/vm/preload-hardened-malloc") }}"
        - mode: "0755"
    - user: "root"
    - group: "root"
    - makedirs: true
  service.enabled:
    - name: "hardened_malloc"
    - require:
      - file: "{{ slsdotpath }}"

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

