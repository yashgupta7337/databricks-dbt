WITH sales AS (
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        ROUND({{ multiply('unit_price','quantity') }}, 2) as calculated_amount,
        ROUND(gross_amount, 2) as gross_amount,
        payment_method
    FROM
        {{ ref('bronze_sales') }}
), 

products AS (
    SELECT
        product_sk,
        category
    FROM   
        {{ ref('bronze_product') }}
),

customers AS (
    SELECT
        customer_sk,
        gender,
        loyalty_tier
    FROM
        {{ ref('bronze_customer') }}
),

joined_sales AS (
SELECT 
    sales.sales_id,
    sales.product_sk,
    sales.customer_sk,
    sales.gross_amount,
    sales.calculated_amount,
    sales.payment_method,
    products.category,
    customers.gender,
    customers.loyalty_tier
FROM 
    sales
JOIN
    products ON sales.product_sk = products.product_sk
JOIN
    customers ON sales.customer_sk = customers.customer_sk
)

SELECT
    category,
    gender,
    ROUND(SUM(gross_amount), 2) as total_sales
FROM
    joined_sales
GROUP BY
    category,
    gender
ORDER BY
    total_sales DESC