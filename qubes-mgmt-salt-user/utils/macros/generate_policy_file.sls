{#-
  Generate a Qubes RPC policy file

  param policies: A list of Qubes RPC policies, where each line is a tuple of four
    values - the QubesRPC service, the arguments, the source VM, the destination VM,
    and the policy along with its options
  type policies: list(tuple(string))
-#}
{%- macro generate_policy_file(policies) -%}
{% for service, policies in policies | sort(attribute=0) | groupby(attribute=0) %}
{% for policy in policies %}

{%- set format_string = [] -%}

{%-   for i in range(0, 5) -%}
{%-     set col = policies | map(attribute=i) | list -%}
{%-     set col_length = ( col | map("length") | max / 4 ) | round(0, "ceil") * 4 -%}
{%-     do format_string.append("%-" ~ col_length | int ~ "s") -%}
{%-   endfor -%}
{{ format_string | join (" ") | format(*policy) }}

{% endfor %}
{%- endfor %}
{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
