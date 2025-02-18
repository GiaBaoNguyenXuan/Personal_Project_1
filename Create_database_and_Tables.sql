CREATE DATABASE Personal_Project_1;

CREATE TABLE lazada_products
(   url                         TEXT,
    rating                      NUMERIC,
    reviews	                    INT,
    initial_price               NUMERIC,	
    final_price	                NUMERIC,
    currency    	            TEXT,
    seller_name	                TEXT,
    seller_ratings	            NUMERIC,
    seller_ship_on_time	        VARCHAR(50),
    seller_chat_response    	VARCHAR(50),
    sku	                        TEXT,
    mpn	                        NUMERIC,
    returns_and_warranty    	TEXT,
    is_super_seller	            BOOLEAN,
    brand	                    TEXT,
    stock	                    BOOLEAN,
    shop_url	                TEXT,
    lazmall		                BOOLEAN,
    domain                      TEXT,
    number_sold	                NUMERIC,
    gmv                         NUMERIC
);

CREATE TABLE shopee_products
(   url                         TEXT,
    id	                        NUMERIC,
    sold	                    NUMERIC,
    rating	                    NUMERIC,
    reviews	                    INT,
    initial_price	            NUMERIC,
    final_price	                NUMERIC,
    currency	                TEXT,
    stock	                    NUMERIC,
    favorite	                NUMERIC,
    shop_url	                TEXT,
    seller_rating	            NUMERIC,
    seller_products	            NUMERIC,
    seller_chats_responded_percentage   VARCHAR(50),	
    seller_chat_time_reply	    TEXT,
    seller_joined_date	        TIMESTAMP,
    seller_followers	        NUMERIC,
    domain	                    TEXT,
    brand	                    TEXT,
    category_id	                NUMERIC,
    flash_sale	                BOOLEAN,
    is_available	            BOOLEAN,
    seller_id                   NUMERIC
);

ALTER TABLE public.lazada_products OWNER TO postgres;
ALTER TABLE public.shopee_products OWNER TO postgres;

COPY lazada_products
FROM 'C:\Users\Gia Bao\Downloads\Personal_Project_1\lazada_products.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',' , ENCODING 'UTF8');

COPY shopee_products
FROM 'C:\Users\Gia Bao\Downloads\Personal_Project_1\shopee_products_final_v2.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',' , ENCODING 'UTF8');

SELECT url FROM lazada_products
LIMIT 5;

