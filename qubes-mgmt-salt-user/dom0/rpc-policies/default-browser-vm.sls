{%- if grains.id == "dom0" -%}
{%- from "utils/user_info.jinja" import user with context -%}
{%- set policy_dir = "/usr/local/etc/qubes/policy.d" -%}
{%- set policy_file = "30-default-browser-vm.policy" -%}
{%- set browser_vm = salt["pillar.get"]("user_qubes:browser_vm", default="dvm-trivalent") -%}

"{{ slsdotpath }}:: install policy":
  file.managed:
    - name: "{{ policy_dir | path_join("available", policy_file) }}"
    - source: "salt://{{ tpldir | path_join("files", policy_dir, policy_file ~ ".j2") }}"
    - user: "root"
    - group: "qubes"
    - mode: "0660"
    - show_changes: true
    - makedirs: true
    - template: "jinja"
    - context:
        browser_vm: "{{ browser_vm }}"

"{{ slsdotpath }}:: enable policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policy"
    - name: "{{ policy_dir | path_join("enabled", policy_file) }}"
    - target: "{{ policy_dir | path_join("available", policy_file) }}"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et tw& : -#}

