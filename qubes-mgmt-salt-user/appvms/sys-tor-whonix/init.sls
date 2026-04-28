{% if grains.id == "dom0" %}
{%- set template_name = "provides-tor-whonix" -%}
{%- from "./opts.jinja" import vm, template_name -%}

"{{ slsdotpath }}:: {{ template_name }} exists":
  qvm.exists:
    - name: "{{ template_name }}"

"{{ vm_name }}":
  qvm.vm:
    - require:
      - qvm: "{{ slsdotpath }}:: {{ template_name }} exists"

    {{ vm | dict_to_sls_yaml_params | indent }}


"/usr/local/etc/qubes/policy.d/available/30-whonix.policy":
  file.managed:
    - source: "salt://{{ tpldir }}/files/30-whonix.policy.j2"
    - template: "jinja"
    - user: "root"
    - group: "root"
    - mode: "0640"
    - defaults:
        gateway_vm: "{{ vm_name }}"

"/usr/local/etc/qubes/policy.d/enabled/30-whonix.policy":
  file.symlink:
    - target: "/usr/local/etc/qubes/policy.d/available/30-whonix.policy"

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
