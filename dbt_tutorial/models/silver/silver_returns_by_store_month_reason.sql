WITH month_info AS (
    SELECT
        date_sk,
        month
    FROM
        {{ ref('bronze_date') }}
),
returned_products AS (
    SELECT
        r.store_sk,
        m.month,
        r.return_reason,
        ROUND(SUM(r.refund_amount), 2) AS total_refund_amount
    FROM
        {{ ref('bronze_returns') }} AS r
    INNER JOIN
        month_info AS m ON m.date_sk = r.date_sk
    GROUP BY
        r.store_sk,
        m.month,
        r.return_reason
),
store_wise_return AS (
    SELECT
        s.store_code,
        s.store_name,
        rp.month,
        rp.return_reason,
        rp.total_refund_amount
    FROM
        {{ ref('bronze_store') }} AS s
    INNER JOIN
        returned_products AS rp ON s.store_sk = rp.store_sk
)
SELECT
    *
FROM
    store_wise_return
ORDER BY
    total_refund_amount DESC