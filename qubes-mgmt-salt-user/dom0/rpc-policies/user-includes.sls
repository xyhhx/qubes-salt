{%- if grains.id == "dom0" -%}
{%- from "utils/user_info.jinja" import user with context -%}
{%- set policy_dir = "/etc/qubes/policy.d" -%}

"{{ slsdotpath }}:: set up rpc user includes":
  file.managed:
    - names:
      - "{{ policy_dir | path_join("10-user-includes.policy") }}":
        - source: "salt://{{ tpldir | path_join("files", policy_dir, "10-user-includes.policy.j2") }}"
        - context:
            user: "{{ user }}"
        - defaults:
            user: "user"
      - "{{ policy_dir | path_join("20-salt-includes.policy") }}":
        - source: "salt://{{ tpldir | path_join("files", policy_dir, "20-salt-includes.policy.j2") }}"
    - user: "root"
    - group: "qubes"
    - mode: "0660"
    - show_changes: true
    - makedirs: true
    - template: "jinja"

"{{ slsdotpath }}:: set up rpc user dirs":
  file.directory:
    - names:
      - "{{ "/home" | path_join(user, ".config/qubes/policy.d/available") }}"
      - "{{ "/home" | path_join(user, ".config/qubes/policy.d/enabled") }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - show_changes: true
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
