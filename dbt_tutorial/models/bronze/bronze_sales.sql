SELECT 
    *
FROM
    {{ source('source', 'fact_sales') }}