{%- if grains.id == "dom0" -%}

{%-   set policies_dir = "/usr/local/etc/qubes/policy.d" -%}
{%-   set policy_files = [
  "30-onlykey-gpg.policy",
  "30-onlykey-ssh.policy"
] -%}

"{{ slsdotpath }}:: install policies":
  file.managed:
    - require:
      - qvm: "{{ vm_name }}"
    - names:
{%    for file in policy_files %}
      - "{{ policies_dir | path_join("available", file) }}":
        - source: "salt://{{ tpldir | path_join("files/dom0", policies_dir, file ) }}.j2"
{%    endfor %}
    - template: "jinja"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true
    - context:
        vm_name: "{{ vm_name }}"

"{{ slsdotpath }}:: enable policies":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policies"
    - names:
{%    for file in policy_files %}
      - "{{ policies_dir | path_join("enabled", file) }}":
        - target: "{{ policies_dir | path_join("available", file) }}"
{%    endfor %}
    - makedirs: true

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
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
