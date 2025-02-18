WITH shopee_top AS (
    SELECT 
        url,
        rating,
        reviews,
        sold AS sold_number
    FROM shopee_products
    ORDER BY sold DESC
    LIMIT 200
),
lazada_top AS (
    SELECT 
        url,
        rating,
        reviews,
        number_sold AS sold_number
    FROM lazada_products
    ORDER BY number_sold DESC
    LIMIT 200
)
SELECT  url, 
        rating, 
        reviews, 
        sold_number
FROM shopee_top
UNION ALL
SELECT 
        url, 
        rating, 
        reviews, 
        sold_number
FROM lazada_top
ORDER BY sold_number DESC
LIMIT 200;


SELECT 

CASE 

WHEN final_price < 100000 THEN 'Low'
WHEN final_price BETWEEN 100001 AND 500000 THEN 'Medium'
ELSE 'High'
END AS price_range,

COUNT(*) AS product_count,
SUM(number_sold) AS total_sold
FROM 
(
SELECT  url,
        rating,
        reviews,
        sold AS number_sold,
        final_price
FROM    shopee_products

UNION ALL 

SELECT  url,
        rating,
        reviews,
        number_sold,
        final_price
FROM    lazada_products

) AS combined_dataset
GROUP BY price_range
ORDER BY price_range DESC;


SELECT 

CASE 

WHEN final_price < 100000 THEN 'Low Buy Purchasing power'
WHEN final_price BETWEEN 100001 AND 500000 THEN 'Medium Purchasing Power'
ELSE 'High Purchasing Power'
END AS price_range,

COUNT(*) AS product_count,
SUM(number_sold) AS total_sold
FROM 
(
SELECT  url,
        rating,
        reviews,
        sold AS number_sold,
        final_price
FROM    shopee_products

UNION ALL 

SELECT  url,
        rating,
        reviews,
        number_sold,
        final_price
FROM    lazada_products

) AS combined_dataset
GROUP BY price_range
ORDER BY price_range DESC


/*

Query 1 - Analysing purhcase power by price range

For the first query, after the using UNION to unite both tables for combined data, it could be seen after calculating that:

Lower-priced products are purchased in significantly higher volumes.
Premium products have limited buyers, leading to lower total sales.
Mid range products could keep a balanced rate of purchasing.

==> Products in the lower price range dominate sales, indicating stronger consumer preference and decision.

*/
