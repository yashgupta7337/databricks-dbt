{# Block Level Config #}
{{ config(materialized='view')}}

SELECT 
    *
FROM
    {{ source('source', 'fact_sales') }}