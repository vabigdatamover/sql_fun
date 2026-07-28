WITH ProductTotals AS (
    SELECT o.product_id,
           SUM(o.profit) AS total_profit,
           SUM(o.quantity) AS total_quantity,
           (SUM(o.profit) / NULLIF(SUM(o.quantity), 0)) AS Profit_PER_ITEM
    FROM public.orders o
    LEFT JOIN public.returns r 
           ON o.order_id = r.order_id 
          AND o.product_id = r.product_id
    WHERE o.region_id = '1488'
      AND o.profit > 0
      AND r.order_id IS NULL
    GROUP BY o.product_id
)
SELECT product_id,
       Profit_PER_ITEM,
       total_quantity,
       total_profit,
       SUM(total_quantity) OVER (ORDER BY Profit_PER_ITEM DESC) AS cumulative_quantity,
       SUM(total_profit) OVER (ORDER BY Profit_PER_ITEM DESC) AS cumulative_profit
FROM ProductTotals
ORDER BY Profit_PER_ITEM DESC
LIMIT 20;