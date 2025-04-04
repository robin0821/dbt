-- depends_on: {{ ref('PARAMETER_EXAMPLE') }}
{%- call statement('filters', fetch_result=True) -%}
    select * from {{ ref('PARAMETER_EXAMPLE') }}
{%- endcall -%}
{%- set results = load_result('filters') -%}
{%- set results_data = results['data'] -%}
{%- set results_status = results['response'] -%}

{%- set product_filter = [] -%}
{%- set parcel_filter = [] -%}
{%- set event_filter = [] -%}
{%- set lodged_filter = [] -%}
{%- set returned_filter = [] -%}
{%- set value_to_be_replaced = [] -%}
{%- set value_to_replace = [] -%}
{%- set return_from_custom = [] -%}
{%- set return_to_sender = [] -%}

{%- for item in results_data -%}
    {%- if item[0] == 'PRODUCT_FILTER' -%}
        {% set product_filter = product_filter.append(item[1]) %}
    {%- elif item[0] == 'PARCEL_FILTER' -%}
        {%- set parcel_filter = parcel_filter.append(item[1]) -%}
    {%- elif item[0] == 'EXTEVENT_FILTER' -%}
        {%- set event_filter = event_filter.append(item[1]) -%}
    {%- elif item[0] == 'LODGED_FILTER' -%}
        {%- set lodged_filter = lodged_filter.append(item[1]) -%}
    {%- elif item[0] == 'RETURNED_FILTER' -%}
        {%- set returned_filter = returned_filter.append(item[1]) -%}
    {%- elif item[0] == 'REPLACE_VALUE_1' -%}
        {%- set value_to_be_replaced = value_to_be_replaced.append(item[1]) -%}
        {%- set value_to_replace = value_to_replace.append(item[2]) -%}
    {%- elif item[0] == 'RETURNED_FROM_CUSTOM' -%}
        {%- set return_from_custom = return_from_custom.append(item[1]) -%}
    {%- elif item[0] == 'RETURNED_TO_SENDER' -%}
        {%- set return_to_sender = return_to_sender.append(item[1]) -%}
    {%- endif -%}

{%- endfor -%}

{{ log(results_data) }}
{{ print(results_status) }}
{{ print(product_filter) }}
{{ print(event_filter) }}
{{ print(lodged_filter) }}
{{ print(returned_filter) }}
{{ print(value_to_be_replaced) }}
{{ print(value_to_replace) }}
{{ print(return_from_custom) }}
{{ print(return_to_sender[0]) }}

{{ config(alias='korean_ha_test') }}

SELECT * FROM public.victorian
where "Last Name" = 'Ha' and "Country of Birth" ilike '{{ return_to_sender[0] }}'
order by " Full Name" asc