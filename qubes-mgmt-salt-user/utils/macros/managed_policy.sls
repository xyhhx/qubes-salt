{#-
  Install a Qubes RPC policy file from a Jinja2 template

  param policy_file: The filename of the j2 policy
  type policy_file: string
  param context: The context to pass to the j2 template
  type context: dict
  param defaults: The defaults to pass to the j2 template
  type defaults: dict
-#}
{%- macro managed_policy(policy_file, context={}, defaults={}) -%}

{%- if slspath | regex_match("dom0") -%}
{%-   set j2_path = "files" -%}
{%- else -%}
{%-   set j2_path = "files/dom0" -%}
{%- endif -%}

{%- set policy_dir = "/usr/local/etc/qubes/policy.d" -%}

"{{ slsdotpath }}:: install policy":
  file.managed:
    - name: "{{ policy_dir | path_join("available", policy_file) }}"
    - source: "salt://{{ slspath | path_join(j2_path, policy_dir, policy_file ~ ".j2") }}"
    - template: "jinja"
    - user: "root"
    - group: "qubes"
    - mode: "0664"
    - context: {{ context | yaml }}

"{{ slsdotpath }}:: enable policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policy"
    - name: "{{ policy_dir | path_join("enabled", policy_file) }}"
    - target: "{{ policy_dir | path_join("available", policy_file) }}"

{%- endmacro -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
