
{{ config(alias='dbt_dynamic_filter') }}

SELECT * FROM transformations.customers1905
WHERE name IN ({{ var("filters") }})
LIMIT 100