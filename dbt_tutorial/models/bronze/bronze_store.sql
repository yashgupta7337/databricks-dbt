SELECT 
    *
FROM
    {{ source('source', 'dim_store') }}