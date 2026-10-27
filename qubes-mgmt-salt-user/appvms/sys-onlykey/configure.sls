{%- if grains.id == "dom0" -%}

{%-   set vm_name = "sys-onlykey" -%}
{%-   from "utils/macros/managed_policy.sls" import managed_policy -%}
{%-   set policy_files = [
  "30-onlykey-ctap.policy",
  "30-onlykey-gpg.policy",
  "30-onlykey-ssh.policy"
] -%}
{%-   load_yaml as context -%}
vm_name: "{{ vm_name }}"
{%-   endload -%}

{%    for policy in policy_files %}
{{ managed_policy(policy, context) }}
{%    endfor %}

{%- else -%}

{%-   from "utils/user_info.jinja" import user with context -%}

"/home/{{ user }}/.config/onlykey/ssh-agent.conf":
  file.managed:
    - replace: false
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - makedirs: true
    - contents: ""
    - replace: false

"/home/user/.config/autostart/ssh-add.desktop":
  file.managed:
    - source: "salt://{{ tpldir | path_join("files/vm/home/user/.config/autostart/ssh-add.desktop") }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - makedirs: true
    - replace: true


{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
