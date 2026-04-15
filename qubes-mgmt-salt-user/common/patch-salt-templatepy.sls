{%- if grains.id != "dom0" -%}

{%- set python_sitepackages = salt["grains.get"]("pythonpath") | select("match", "^/usr/lib/python") | first -%}
{%- set target_file = python_sitepackages | path_join("salt/template.py") -%}

"{{ slsdotpath }}:: patch salt/template.py":
  file.replace:
    - name: "{{ target_file }}"
    - pattern: "codecs.open"
    - repl: "open"
    - onlyif:
      - fun: file.file_exists
        args:
          - "{{ target_file }}"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
