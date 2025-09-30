WITH deduplicated_items AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) as deduplication_id
FROM
    {{ source('source', 'items') }}    
)

SELECT
    id,
    name,
    category,
    updated_at
FROM
    deduplicated_items
WHERE
    deduplication_id = 1