{%- if grains.id != "dom0" -%}

{#-
  NOTE: This can be improved quite a bit.
  - custom-persist can be used to allow /usr/local to be populated from the
    template
  - a check can be applied to see if the repo is already cloned, pulling if so
  - a service can be added to check if the currently checked out commit matches
    the ref of the latest commit on remote's HEAD, then marking the vm as having
    available updates
    - actually, then the check for the repo being cloned already is needless
-#}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - golang
      - qubes-core-agent-networking
      - scdoc

"{{ slsdotpath }}:: set http proxy envs":
  environ.setenv:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - names:
      - http_proxy
      - https_proxy
      - all_proxy
    - value: "http://127.0.0.1:8082"
    - update_minion: true

"{{ slsdotpath }}:: clone repo":
  git.cloned:
    - require:
      - environ: "{{ slsdotpath }}:: set http proxy envs"
    - name: "https://git.sr.ht/~delthas/senpai"
    - target: "/opt/senpai"

"{{ slsdotpath }}:: install":
  cmd.run:
    - require:
      - git: "{{ slsdotpath }}:: clone repo"
    - names:
      - "make"
      - "make install":
        - creates: "/usr/bin/senpai"
        - env:
          - PREFIX: "/usr"
    - cwd: "/opt/senpai"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
