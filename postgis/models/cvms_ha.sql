
{{ config(alias='korean_ha') }}

SELECT * FROM public.victorian
where "Last Name" = 'Ha' and "Country of Birth" ilike '%Korea%'
order by " Full Name" asc