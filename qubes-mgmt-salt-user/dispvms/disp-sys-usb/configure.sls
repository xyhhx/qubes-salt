{%- if grains.id == "dom0" -%}
{%- set vm_name = "disp-sys-usb" -%}
{%- set policy_dir = "etc/qubes/policy.d" -%}
{%- set policy_file = "30-dispvm-usb-input.policy" -%}

"{{ slsdotpath }}:: install usb input policy":
  file.managed:
    - name: "{{ "/usr/local" | path_join(policy_dir, "available", policy_file) }}"
    - source: "salt://{{ tpldir | path_join("files/dom0", policy_dir, policy_file ~ ".j2") }}"
    - template: "jinja"
    - user: "root"
    - group: "qubes"
    - mode: "0640"
    - makedirs: true
    - replace: true
    - defaults:
        usb_qube: "{{ vm_name }}"
        keyboard_policy: "qubes.InputKeyboard"
        keyboard_policy_action: "ask"
        mouse_policy: "qubes.InputMouse"
        mouse_policy_action: "ask"
        tablet_policy: "qubes.InputTablet"
        tablet_policy_action: "deny"

"{{ slsdotpath }}:: enable usb input policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install usb input policy"
    - name: "{{ "/usr/local" | path_join(policy_dir, "enabled", policy_file) }}"
    - target: "{{ "/usr/local" | path_join(policy_dir, "available", policy_file) }}"
    - user: "root"
    - group: "qubes"
    - mode: "0640"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
