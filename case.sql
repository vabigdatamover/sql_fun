---Setting up GitUp
SELECT DISTINCT discount,
  CASE
  WHEN discount = 1 THEN 'FREE'
  WHEN discount = 0 THEN 'NONE'
  WHEN discount BETWEEN .25 AND 1 THEN 'High'
  WHEN discount < .25 THEN 'Low'
  END as discount_level
FROM orders
ORDER BY discount;
