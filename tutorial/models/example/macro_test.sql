

{{ config(materialized='table') }}

with source_data as (

    select 1 as id, {{ sum_of_2_nums(2,3) }} as sum

)

select *
from source_data
