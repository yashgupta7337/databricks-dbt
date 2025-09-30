-- example of singular test
SELECT
    *
FROM
    {{ ref('bronze_sales') }} 
WHERE
    gross_amount < 0
    OR net_amount < 0
    
