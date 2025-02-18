SELECT 
    platform,
    ROUND(AVG(gmv),0) AS avg_gmv,
    COUNT(*) AS product_count,
    SUM(sold_number) AS total_sold,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(reviews), 0) AS avg_reviews

FROM (
    SELECT 'Shopee' AS platform, 
    rating, 
    reviews,
    (sold*final_price) AS gmv,
    sold AS sold_number 

FROM shopee_products

UNION ALL

SELECT 'Lazada' AS platform, 
    rating, 
    reviews,
    gmv, 
    number_sold AS sold_number 

FROM lazada_products

) combined_data

GROUP BY platform;

/* 

With GMV stands for: Gross Merchandise Value. It represents the total value of goods sold on a platform within a specific period, before deducting any fees, discounts, or returns.

GMV = Sold quality * Final price

As per the notice from the beginning of this project, the date from shopee dataset had been intervened for its lack of information and scrape malfunction, hence any conclusion in any section from this project just have reference value.
At the fourth query, from both 1000 products of both platforms, shopee showed an outstanding statistic at total_sold and average reviews. This could annotate the present and coverage on Vietnam Market. Even when the rating between two contestants is close, but the prominant outperformed lazada base on this data set. 
Not to mention the GMV stastic, shopee data set, despite the lack of data, still is more elaborate since lazada dataset showed some products twice or more times for scraping counted the url based on size, so products with more sizes could appear in the files more then once time. 
It could be predicted that with the more pricise dataset, shopee could still surpass lazada regarding GMV stastic. 

*/