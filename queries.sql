-- -- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

SELECT city_name, 
round((population * 0.25)/1000000,2) as coffee_consumers_in_millions,
city_rank
FROM city
ORDER by population DESC;

-- -- Q.2
-- Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales by each city in the last quarter of 2023?
SELECT 
ci.city_name,
sum(s.total) as total_revenue
FROM sales as s
JOIN customers as c
	ON s.customer_id = c.customer_id
JOIN city as ci
	ON c.city_id = ci.city_id
WHERE s.sale_date BETWEEN '2023-10-01' AND '2023-12-31'
GROUP BY ci.city_name
ORDER BY total_revenue DESC;

-- Q.3
-- Sales Count for Each Product
-- How many units of each coffee product have been sold?
SELECT 
    p.product_id,
    p.product_name,
    COUNT(s.product_id) AS total_units_sold,
    SUM(s.total) AS total_revenue
FROM sales AS s
JOIN products AS p 
    ON s.product_id = p.product_id
GROUP BY 
    p.product_id, 
    p.product_name
ORDER BY 
    total_revenue DESC;

-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?

SELECT 
    ci.city_name,
    ROUND(AVG(s.total), 2) AS avg_sales_per_city, 
    ROUND(SUM(s.total) / COUNT(DISTINCT c.customer_id), 2) AS avg_sales_per_customer
FROM sales AS s
JOIN customers AS c 
    ON s.customer_id = c.customer_id
JOIN city AS ci 
    ON c.city_id = ci.city_id
GROUP BY ci.city_name
ORDER BY avg_sales_per_city DESC;

-- -- Q.5
-- City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)
SELECT 
    city.city_name,
    COUNT(customers.customer_id) AS total_current_cx,       
    ROUND(city.population * 0.25, 0) AS estimated_coffee_consumers 
FROM city
JOIN customers 
    ON city.city_id = customers.city_id
GROUP BY 
    city.city_name, city.population;

-- -- Q6
-- Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?
WITH CityProductSales AS (
    SELECT 
        ci.city_name,
        p.product_name,
        COUNT(s.product_id) AS sales_volume
    FROM sales AS s
    JOIN customers AS c ON s.customer_id = c.customer_id
    JOIN city AS ci ON c.city_id = ci.city_id
    JOIN products AS p ON s.product_id = p.product_id
    GROUP BY ci.city_name, p.product_name
),
RankedProducts AS (
    SELECT 
        city_name,
        product_name,
        sales_volume,
        DENSE_RANK() OVER(PARTITION BY city_name ORDER BY sales_volume DESC) AS rank
    FROM CityProductSales
)
SELECT 
    city_name,
    product_name,
    sales_volume,
    rank
FROM RankedProducts
WHERE rank <= 3
ORDER BY city_name, rank;

-- Q.7
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?
SELECT 
    ci.city_name,
    COUNT(DISTINCT c.customer_id) AS unique_customers
FROM city AS ci
JOIN customers AS c 
    ON ci.city_id = c.city_id
JOIN sales AS s 
    ON c.customer_id = s.customer_id
GROUP BY 
    ci.city_name
ORDER BY 
    unique_customers DESC;
-- -- Q.8
-- Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer

-- Conclusions
SELECT 
    ci.city_name,
    ROUND(SUM(s.total) / COUNT(DISTINCT c.customer_id), 2) AS avg_sale_per_customer,
    ROUND(ci.estimated_rent / COUNT(DISTINCT c.customer_id), 2) AS avg_rent_per_customer
FROM city AS ci
JOIN customers AS c 
    ON ci.city_id = c.city_id
JOIN sales AS s 
    ON c.customer_id = s.customer_id
GROUP BY 
    ci.city_name, 
    ci.estimated_rent
ORDER BY 
    avg_sale_per_customer DESC;
	
-- Q.9
-- Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city
WITH MonthlySales AS (
    SELECT 
        ci.city_name,
        strftime('%Y-%m', s.sale_date) AS sale_month,
        SUM(s.total) AS total_sales
    FROM sales AS s
    JOIN customers AS c 
        ON s.customer_id = c.customer_id
    JOIN city AS ci 
        ON c.city_id = ci.city_id
    GROUP BY 
        ci.city_name, 
        strftime('%Y-%m', s.sale_date)
),
LaggedSales AS (  
    SELECT 
        city_name,
        sale_month,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY city_name 
            ORDER BY sale_month
        ) AS prev_month_sales
    FROM MonthlySales
)
SELECT 
    city_name,
    sale_month,
    total_sales,
    prev_month_sales,
    ROUND(
        ((total_sales - prev_month_sales) * 100.0 / prev_month_sales), 2
    ) AS growth_rate_percentage
FROM LaggedSales
ORDER BY 
    city_name, 
    sale_month;

-- Q.10
-- Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer
SELECT 
    ci.city_name,
    SUM(s.total) AS total_sale,
    ci.estimated_rent AS total_rent,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(ci.population * 0.25, 0) AS estimated_coffee_consumer
FROM city AS ci
JOIN customers AS c 
    ON ci.city_id = c.city_id
JOIN sales AS s 
    ON c.customer_id = s.customer_id
GROUP BY 
    ci.city_name,
    ci.estimated_rent,
    ci.population
ORDER BY 
    total_sale DESC
LIMIT 3;