{%- if grains.id != "dom0" -%}

{%- from "utils/user_info.jinja" import user with context -%}

"{{ slsdotpath }}:: onlykey-ssh-agent unit files":
  file.managed:
    - names:
{% for file in [
  "/etc/systemd/user/onlykey-ssh-agent.service",
  "/etc/systemd/user/onlykey-ssh-agent.socket"
] %}
      - "{{ file }}":
        - source: "salt://{{ tpldir | path_join("files/vm", file) }}"
{% endfor %}
      - "/etc/qubes-rpc/qubes.SshAgent":
        - source: "salt://{{ tpldir | path_join("files/vm/etc/qubes-rpc/qubes.SshAgent") }}"
        - mode: "0755"
      - "/etc/environment.d/30-onlykey-ssh.conf":
        - source: "salt://{{ tpldir | path_join("files/vm/etc/environment.d/30-onlykey-ssh.conf.j2") }}"
        - template: "jinja"
        - makedirs: true
        - dir_mode: "0755"
        - defaults:
            user: "user"
        - context:
            user: "{{ user }}"

"{{ slsdotpath }}:: enable onlykey-ssh-agent":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}:: onlykey-ssh-agent unit files"
    - name: "systemctl --machine={{ user }}@.host --user enable onlykey-ssh-agent.socket"
    - use_vt: true

"/etc/skel/.config/onlykey/ssh-agent.conf":
  file.managed:
    - require:
      - cmd: "{{ slsdotpath }}:: enable onlykey-ssh-agent"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true
    - contents: ""

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
