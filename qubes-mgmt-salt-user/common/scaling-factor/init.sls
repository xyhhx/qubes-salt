{%- if grains.id == "dom0" -%}

{%-   from "utils/macros/managed_policy.sls" import managed_policy -%}
{%-   set policy_file = "50-scaling-factor.policy" -%}

{{ managed_policy(policy_file) }}

{%- else -%}

"{{ slsdotpath }}: configure guest":
  file.managed:
    - names:
      - "{{ salt["pillar.get"]("user_qvms:prefs:dirs:user_bins") | path_join("set-scaling-factor") }}":
        - "{{ file }}":
          - source: "salt://{{ path_join(tpldir, file ~ ".j2") }}"
          - mode: "0755"
        - "/etc/systemd/system/sync-scaling-factor.service":
          - source: "salt://{{ tpldir | path_join("/etc/systemd/system/sync-scaling-factor.service.j2") }}"
          - mode: "0644"
          - context:
              scaling_factor_script: {{ salt["pillar.get"]("user_qvms:prefs:dirs:user_bins") | path_join("set-scaling-factor") }}
    - user: "root"
    - group: "root"
    - makedirs: true
    - template: "jinja"

"sync-scaling-factor.service":
  service.enabled

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
