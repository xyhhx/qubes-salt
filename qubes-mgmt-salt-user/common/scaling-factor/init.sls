{%- if grains.id == "dom0" -%}

{%-   from "utils/macros/managed_policy.sls" import managed_policy -%}
{%-   set policy_file = "50-scaling-factor.policy" -%}

{{ managed_policy(policy_file) }}

{%- else -%}

{%-   set files = [
  "/usr/lib/qubes-user/set-scaling-factor",
  "/etc/systemd/system/sync-scaling-factor.service",
] -%}

"{{ slsdotpath }}: configure guest":
  file.managed:
    - names:
{% for file in files -%}
      - "{{ file }}":
        - source: "salt://{{ path_join(tpldir, file) }}"
{% endfor %}
    - user: "root"
    - group: "root"
    - mode: "0755"
    - makedirs: true
    - template: "jinja"

"sync-scaling-factor.service":
  service.enabled

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
