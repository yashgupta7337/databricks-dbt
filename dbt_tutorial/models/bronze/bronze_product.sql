SELECT 
    *
FROM
    {{ source('source', 'dim_product') }}