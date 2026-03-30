{% if grains.id == 'dom0' %}

{%- from './opts.jinja' import mirageos_release -%}

{%- from 'utils/macros/download_mirage_kernel.sls' import download_mirage_kernel -%}
{{ download_mirage_kernel(version=mirageos_release.version, checksum=mirageos_release.checksum) }}

{% endif %}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
