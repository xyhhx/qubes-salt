{%- if grains.id != "dom0" -%}

{%- from "utils/user_info.jinja" import user, user_home with context -%}

include:
  - common.split-ssh-client
  - common.pkgs.split-gpg2-client

"{{ slsdotpath }}:init":
  git.cloned:
    - names:
      - "https://github.com/astronvim/template":
        - target: "{{ user_home | path_join(".config/nvim") }}"
      - "https://github.com/folke/lazy.nvim.git":
        - target: "{{ user_home | path_join(".local/share/nvim/lazy/lazy.nvim") }}"
        - require:
          - git: "https://github.com/astronvim/template"
        - branch: "stable"
    - user: "{{ user }}"
  cmd.run:
    - names:
      - "nvim --headless +q"
      - "starship init fish | source":
        - shell: "/usr/bin/fish"
    - runas: "{{ user }}"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
