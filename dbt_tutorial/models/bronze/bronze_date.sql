SELECT 
    *
FROM
    {{ source('source', 'dim_date') }}