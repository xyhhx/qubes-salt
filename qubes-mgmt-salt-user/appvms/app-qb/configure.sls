{%- if grains.id == "dom0" -%}

{%- set policy_dir = "etc/qubes/policy.d" -%}
{%- set policy_file = "50-qubesbuilder.policy" -%}
{%- from "./create_vm.sls" import vm_name -%}
{%- from "./opts.jinja" import executor_dvm, template_name -%}

"{{ slsdotpath }}:: install policy":
  file.managed:
    - name: "{{ "/usr/local" | path_join(policy_dir, "available", policy_file) }}"
    - source: "salt://{{ tpldir | path_join("files/dom0", policy_dir, policy_file ~ ".j2") }}"
    - template: "jinja"
    - user: "root"
    - group: "qubes"
    - mode: "0640"
    - makedirs: true
    - replace: true
    - context:
        builder_vm: "{{ vm_name }}"
        executor_dvm: "{{ executor_dvm }}"

"{{ slsdotpath }}:: enable policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policy"
    - name: "{{ "/usr/local" | path_join(policy_dir, "enabled", policy_file) }}"
    - target: "{{ "/usr/local" | path_join(policy_dir, "available", policy_file) }}"
    - user: "root"
    - group: "qubes"
    - mode: "0640"
    - makedirs: true

{%- else -%}

{%- from "utils/user_info.jinja" import user, user_home -%}
{%- set qb_gnupg_home = user_home | path_join(".gnupg/qb") -%}

include:
  - common.split-ssh-client

"{{ slsdotpath }}:: populate home":
  file.directory:
    - names:
      - "{{ user_home | path_join("src") }}"
      - "{{ qb_gnupg_home }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - makedirs: true

"{{ slsdotpath }}:: populate gnupg":
  file.recurse:
    - require:
      - file: "{{ slsdotpath }}:: populate home"
    - name: "{{ qb_gnupg_home }}"
    - source: "salt://{{ tpldir | path_join("files/vm", qb_gnupg_home) }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - dir_mode: "0700"
    - file_mode: "0600"
    - makedirs: true

"{{ slsdotpath }}:: import keys":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}:: populate gnupg"
    - name: |-
        gpg --import {{ qb_gnupg_home }}/certs/*.asc \
        && gpg --import-ownertrust {{ qb_gnupg_home }}/certs/ownertrust.txt
    - env:
      - GNUPGHOME: "{{ qb_gnupg_home }}"
    - runas: "{{ user }}"

"{{ slsdotpath }}:: clone repos":
  git.latest:
    - require:
      - file: "{{ slsdotpath }}:: populate home"
    - names:
      - "https://github.com/QubesOS/qubes-builderv2.git":
        - target: "{{ user_home | path_join("src/qubes-builderv2") }}"
      - "https://github.com/QubesOS/qubes-release-configs":
        - target: "{{ user_home | path_join("src/qubes-release-configs") }}"
    - user: "user"
    - force_checkout: true
    - submodules: true

"{{ slsdotpath }}:: verify HEAD":
  cmd.run:
    - require:
      - git: "{{ slsdotpath }}:: clone repos"
      - cmd: "{{ slsdotpath }}:: import keys"
    - name: "git verify-commit HEAD"
    - cwd: "{{ user_home | path_join ("src/qubes-builderv2") }}"
    - env:
      - GNUPGHOME: "{{ qb_gnupg_home }}"
    - runas: "{{ user }}"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
