# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% macro create_template(vm_name, base_template, prefs={}) %}
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
{% endmacro %}

