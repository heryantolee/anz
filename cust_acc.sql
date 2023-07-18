/*
Hi Deepak & Alauddin,

I created the SQL version of technical case:
(just run it in BigQuery console)
*/


WITH sample AS (
  SELECT 1 AS customer_id, 10 AS account_id UNION ALL
  SELECT 1 AS customer_id, 11 AS account_id UNION ALL
  SELECT 2 AS customer_id, 13 AS account_id UNION ALL
  SELECT 3 AS customer_id, 10 AS account_id UNION ALL
  SELECT 3 AS customer_id, 11 AS account_id UNION ALL
  SELECT 4 AS customer_id, 13 AS account_id UNION ALL
  SELECT 4 AS customer_id, 14 AS account_id
)
-- Group customer_id, string aggregate account_id into string_array
,agg_account_id AS (
SELECT
  customer_id,
  STRING_AGG(CAST(account_id AS STRING) ORDER BY account_id ASC) AS array_account_id
FROM sample
GROUP BY
  customer_id
)
-- Count customer_id based on array_account_id
,count_customer_id AS (
SELECT
  array_account_id,
  COUNT(1) AS counts
FROM agg_account_id
GROUP BY
  array_account_id
)
-- Show customer_id that have exactly same account_id
  SELECT * FROM agg_account_id
  WHERE array_account_id IN (
  SELECT array_account_id
  FROM count_customer_id
  WHERE counts >= 2
)
;