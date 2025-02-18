SELECT 

CASE 

WHEN rating BETWEEN 4.5 AND 5 THEN 'High Rated'
WHEN rating BETWEEN 4 AND 4.5 THEN 'Medium Rated'
ELSE 'Low Rated'
END AS rating_range,

COUNT(*) AS rating_count,
SUM(number_sold) AS total_sold,
ROUND(AVG(reviews), 0) AS reviews_count
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
GROUP BY rating_range
ORDER BY rating_range DESC

/*

Query 3 - Analysing purhcase power by rating

For the third query, the same processed would be executed for the insights of purchase power based on two platforms, and the results demonstrated that:

For the first 1000 products from both platform that was scraped randomly, the high-rated number is significant compared to other two catagories. 
Products came with high rating by consumers are holding the highest number of total sold.
Low rated products significantly stay behind regarding total numer sold. 
Medium rated products maintain a balanced performance.

==> Whilst customers are looking for products with high discount rate and preference for low to middle price range, they would heavily look up to reviews and rating before making any decision.

*/
