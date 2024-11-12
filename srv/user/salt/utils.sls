# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---

{% macro create_template(vm_name, base_template, prefs={}) %}
'{{ vm_name }} - qvm.template_installed':
  qvm.template_installed:
    - name: '{{ base_template }}'

'{{ vm_name }}':
  qvm.vm:
    - actions:
      - clone
      - prefs
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
{% endmacro %}

