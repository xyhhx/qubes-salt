# vim: set syntax=yaml ft=sls ts=2 sw=2 sts=2 et :

---

{% macro create_template(vm_name, base_template, prefs={}) %}
## Avoid conflicting 'include' ID.
{% if base_template is iterable and (base_template is not string and base_template is not mapping) -%}

'{{ vm_name }} - qvm.template_installed':
  qvm.template_installed:
    - name: '{{ base_template }}'

'{{ vm_name }} - qvm.vm':
  qvm.vm:
    - name: '{{ vm_name }}'
    - actions:
      - clone
      - prefs
      - tags
    - clone:
      - source: '{{ base_template }}'
    - prefs: {{
      salt.slsutil.merge_all([
        {
          "label": "gray",
        },
        prefs,
      ])
    }}
    - tags:
      - add:
        - salt-managed
{% endif %}
{% endmacro %}

