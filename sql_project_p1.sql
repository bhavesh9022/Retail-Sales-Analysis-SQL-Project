--Database

Create database sql_projet_p1


__create table

drop table if exists retail_sales;
CREATE TABLE retail_sales
(            transactions_id int primary key,
             sale_date Date,
             sale_time Time,
             customer_id Int,
             gender Varchar(15),
             age int,
             category Varchar(15),
             quantiy int,
             price_per_unit float,
             cogs float,
			 total_sale float
)

-shoow data 

select * from retail_sales;

--COUNT NO OF ROWS 

select 
     count(*) 
from retail_sales;

SELECT * FROM RETAIL_SALES WHERE TRANSACTIONS_ID IS NULL;

SELECT *
FROM RETAIL_SALES
WHERE SALE_DATE IS NULL
   OR SALE_TIME IS NULL
   OR CUSTOMER_ID IS NULL
   OR GENDER IS NULL
   OR AGE IS NULL
   OR CATEGORY IS NULL
   OR quantiy IS NULL
   OR PRICE_PER_UNIT IS NULL
   OR COGS IS NULL
   OR TOTAL_SALE IS NULL;

--DELETE FORM RETAILS_SALES 

DELETE
FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL
   OR  SALE_DATE IS NULL
   OR SALE_TIME IS NULL
   OR CUSTOMER_ID IS NULL
   OR GENDER IS NULL
   OR AGE IS NULL
   OR CATEGORY IS NULL
   OR quantiy IS NULL
   OR PRICE_PER_UNIT IS NULL
   OR COGS IS NULL
   OR TOTAL_SALE IS NULL;

-- HOW MANY SALES WE HAVE 

SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

-- HOW MANY UNIOUE CUSTOMER WE HAVE 

SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALES FROM RETAIL_SALES;
-- HOW MABY CATGORY TYPE

SELECT DISTINCT CATEGORY AS DIFFERENT_CATGORY FROM RETAIL_SALES;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM RETAIL_SALES WHERE SALE_DATE ='2022-11-05'

--Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM RETAIL_SALES
   WHERE CATEGORY ='Clothing'
   AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
   AND QUANTIY < 4

-- Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT CATEGORY,
       SUM (total_sale) AS NET_SALE,
	   COUNT(*) AS TOTAL_ORDER
FROM RETAIL_SALES
GROUP BY CATEGORY

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category


SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * FROM RETAIL_SALES WHERE TOTAL_SALE <1000;


-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    CATEGORY,
	GENDER,
	COUNT(*) AS TOTAL_COUNT
FROM RETAIL_SALES
    GROUP BY
	CATEGORY,
	GENDER
ORDER BY 1


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT YEAR,
       MONTH,
	   AVG_SALE
FROM 
(SELECT 
       EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	   EXTRACT( MONTH FROM SALE_DATE) AS MONTH,
	   COUNT(*) AS AVG_SALE ,
	   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	   FROM RETAIL_SALES 
	   GROUP BY 1, 2
	   ) as t1
WHERE rank = 1

-- *Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT customer_id,
      sum(total_sale) as totalsale
FROM RETAIL_SALES
     group by 
	 customer_id
	 order by customer_id asc 
	 limit 5

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Write a SQL query to find the number of unique customers who purchased items from each category.

select customers_id,
       count(distinct category) as dis_cat
 from retail_sales
 group by category

-- Write SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

