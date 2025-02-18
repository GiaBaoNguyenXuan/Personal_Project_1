# Introduction

This project marks a significant milestone on my journey to becoming an analyst, a dream I've been pursuing. It involves analyzing a database to evaluate purchasing power based on various factors such as discount rates, ratings and reviews, price ranges, and overall performance measured by GMV statistics.

For more details, please access to: [Personal_Project_1](/Personal_Project_1/)
# My background

Graduating from the University of Economics in Ho Chi Minh City, I was exposed to numbers and calculations early on. As I approached my final days at university, I developed a strong interest in the e-commerce industry and the rapid growth of major e-commerce platforms. Even the most prominent social media platforms have gradually entered the race, offering their own sales-driven solutions and customizations.

After working for a logistics company for nearly half a year, I moved to Kuala Lumpur, Malaysia, and joined one of Vietnam's biggest platforms—Meta. Starting as a Customer Service Representative and later transitioning into a Sales Representative (also known as an Account Manager), I gained valuable insights into e-commerce trends and operations.

Motivated by my experiences, I decided to learn SQL as a powerful tool for analysis—and I don't plan to stop there. This is Project_1, and I intend to update it as needed. Soon, I will release Project_2, which will focus on analyzing the same type of dataset using Excel to further showcase my skills.

If this project interests you, feel free to connect with me on LinkedIn. I am confident in presenting my work in English, and in the future, I aim to be proficient in another foreign languages.

# Tools I used

To finishing this project, I harnessed the capabilities of many tools:

- **SQL:** One of the most used and common tools in Analysing world. I used VS-code and do my query there.
- **PostgresSQL:** This data management system is friendly and helpful for this project.
- **Visual Studio Code:** My choice of database management and queries execution. 
- **Git and Github:** Essential for sharing, showcasing scripts and analysis, ensuring the cohesion and tracking. 

# Before diving in this small project:

- The lack of database and resources led me to the decision of applying some changes to the original datasets. If anyone gets interest, don't hesitate to ask me for source. My deepest thanks to brightdata.com for letting me dowload the Demo version for free. 

 **The Shopee dataset has been modified by chat GPT by the fomulas:**
- If a product has 0 reviews, its sold number must be less than 10 (random value from 1 to 9).
- If a product has 1 or more reviews, its sold number will be randomly between 1.5× and 3× the number of reviews.
- Ratings and reviews will remain unchanged.

# The Analysis

Four queries have been executed to anwser for questions regarding the purchase power of two most outstanding E-commerce platform. 

## 1. Analysing purhcase power by price range

To understand the relationship between customers decision and price of the products, I have devided the final price into three catagories and analyst the combined data for the conclusion. The first query is for the top 200 products from both datasets for the refference of the most atractive products. 

```sql
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
```

And here is my own conclusion from the analysis:

- For the first query, after the using UNION to unite both tables for combined data, it could be seen after calculating that:

- Lower-priced products are purchased in significantly higher volumes.
- Premium products have limited buyers, leading to lower total sales.
- Mid range products could keep a balanced rate of purchasing.
- **Conclusion:** Products in the lower price range dominate sales, indicating stronger consumer preference and decision.

|price_range|product_count|total_sold|
|-----------|-------------|----------|
|Medium     |	783	      |  944819  |
|Low Buy    |	669	      |  2645477 |
|High       |	548	      |  215909  |

*Table of the purchase power by Price Range*

## 2. Analysing purchase power by dicount rate

After considering the relation between price range and purchase power, I proceed to explore the connection between dicount rate and customer decision by applying the same method as the first query

```sql
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

```
My own thoughts on this connection are:

- For the second query, after comitting the same steps as the first one, after analysing combined data, it could come to the conclusion that:

- Customers are highly responsive to high discounts.
- Low discounts have minimal impact on consumer purchases
- Medium discount products could still keep a balanced rate of purchasing.

**Hence:** Products with higher discounts drive higher sales, meaning consumers are highly price-sensitive and more careful in their pusrchasing decision.

|discount_rate           |discounted_product_count |total_sold |
|------------------------|------------------------|----------|
|Medium Discount Rate    |537                      |893735    |
|Low Discount Rate       |186                      |306609    |
|High Discount Rate      |1277                     |2605861   |


*Table of the purchase power by Discount Rate*

## 3. Analysing purhcase power by rating

Same methods, same approaches, but I want to learn the affect of rating from previous customeres on new customers:

```sql
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

```

And my finds are:

- For the third query, the same processed would be executed for the insights of purchase power based on two platforms, and the results demonstrated that:

- For the first 1000 products from both platform that was scraped randomly, the high-rated number is significant compared to other two catagories. 
- Products came with high rating by consumers are holding the highest number of total sold.
- Low rated products significantly stay behind regarding total numer sold. 
- Medium rated products maintain a balanced performance.

**To recapitulate:** Whilst customers are looking for products with high discount rate and preference for low to middle price range, they would heavily look up to reviews and rating before making any decision.

|rating_range  |rating_count |total_sold |reviews_count |
|-------------|------------|-----------|--------------|
|Medium Rated |68          |110092     |679          |
|Low Rated    |3           |7          |2            |
|High Rated   |1929        |3696106    |817          |

*Table of the purchase power by Rating and reviews*

## 4. Analysing Platform's performance based on GMV

With GMV, I use the formula to calculate for Shopee before proceeding to the comparision between the two platforms. As I have mentioned from the beginning, this result is just for refference, but it might depict the current performance for the recent research have demonstrated the dominance of Shopee on the market:

```sql
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

```

- With GMV stands for: Gross Merchandise Value. It represents the total value of goods sold on a platform within a specific period, before deducting any fees, discounts, or returns.

**GMV = Sold quality * Final price**

- As per the notice from the beginning of this project, the date from shopee dataset had been intervened for its lack of information and scrape malfunction, hence any conclusion in any section from this project just have reference value.
- At the fourth query, from both 1000 products of both platforms, shopee showed an outstanding statistic at total_sold and average reviews. This could annotate the present and coverage on Vietnam Market. Even when the rating between two contestants is close, but the prominant outperformed lazada base on this data set. 
- Not to mention the GMV stastic, shopee data set, despite the lack of data, still is more elaborate since lazada dataset showed some products twice or more times for scraping counted the url based on size, so products with more sizes could appear in the files more then once time. 

- **To sum up:** It could be predicted that with the more pricise dataset, shopee could still surpass lazada regarding GMV stastic. 

|platform |avg_gmv    |product_count |total_sold |avg_rating |avg_reviews |
|---------|-----------|--------------|-----------|-----------|------------|
|Shopee   |349181223  |1000          |3310513    |5          |1493        |
|Lazada   |151893571  |1000          |495692     |5          |129         |

*Overall performance by GMV*

# What I have earned

After investing my time and effort into this project, I have gained unexpected but valuable experience—not only in handling SQL queries but also in processing Excel files. My top three takeaways are:

**Chance to work with complex queries**: I had the opportunity to work with advanced SQL, from creating my own dataset to connecting and posting it to Postgres, as well as inserting data through coding. These are essential skills that I need now and will continue to use in the future.

**Data collecting and processing**: The raw data was not perfect, and overcoming such obstacles has strengthened my ability to clean and process data efficiently. I will apply this experience to my next project, which will focus on Excel usage. 

**Putting questiones into action and vice versa**: From selecting a theme to finding and handling data, I learned that asking the right questions is crucial. Any analysis would be meaningless if no questions were answered. Training myself to formulate meaningful questions will strengthen my mindset and prepare me for a wider range of scenarios in future projects. 

# Final thought:

For all the above-mentioned insights and conclusions, I do not expect to be an expert. My data was uploaded and used by many companies, my conclusion might be clumsy and shallow, but above all, it could just depict my capabilities just fine. There are rooms for improvement, and I will carry on my own efford from now onward. My most sincere thanks to Luke Barousse. This project and everything so far was inspired by this wonderful teacher. 