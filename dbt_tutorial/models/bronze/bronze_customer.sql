SELECT 
    *
FROM
    {{ source('source', 'dim_customer') }}