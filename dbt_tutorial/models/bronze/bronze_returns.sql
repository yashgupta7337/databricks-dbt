SELECT 
    *
FROM
    {{ source('source', 'fact_returns') }}