SELECT 

CASE 

WHEN ((initial_price -final_price)/initial_price)*100 < 10 THEN 'Low Discount Rate'
WHEN ((initial_price -final_price)/initial_price)*100 BETWEEN 10 AND 30 THEN 'Medium Discount Rate'
ELSE 'High Discount Rate'
END AS discount_rate,

COUNT(*) AS discouted_product_count,
SUM(number_sold) AS total_sold
FROM 
(
SELECT  url,
        rating,
        reviews,
        sold AS number_sold,
        initial_price,
        final_price
FROM    shopee_products

UNION ALL 

SELECT  url,
        rating,
        reviews,
        number_sold,
        initial_price,
        final_price
FROM    lazada_products

) AS combined_dataset
GROUP BY discount_rate
ORDER BY discount_rate DESC

/*

Query 2 - Analysing purhcase power by dicount rate

For the second query, after comitting the same steps as the first one, after analysing combined data, it could come to the conclusion that:

Customers are highly responsive to high discounts.
Low discounts have minimal impact on consumer purchases
Medium discount products could still keep a balanced rate of purchasing.

==> Products with higher discounts drive higher sales, meaning consumers are highly price-sensitive and more careful in their pusrchasing decision.

*/
