{%- macro managed_policy(policy_file, context, defaults={}) -%}
{%- set policy_dir = "/usr/local/etc/qubes/policy.d" -%}

"{{ slsdotpath }}:: install policy":
  file.managed:
    - name: "{{ policy_dir | path_join("available", policy_file) }}"
    - source: "salt://{{ tpldir | path_join("files/dom0", policy_dir, policy_file ~ ".j2") }}"
    - template: "jinja"
    - user: "root"
    - group: "qubes"
    - mode: "0664"
    - context:
        {{ context | dict_to_yaml_sls_params | indent }}

"{{ slsdotpath }}:: enable policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policy"
    - name: "{{ policy_dir | path_join("enabled", policy_file) }}"
    - target: "{{ policy_dir | path_join("available", policy_file) }}"

{%- endmacro -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
