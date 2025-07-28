create database store;

use store;

CREATE TABLE supermarket_sales (
    invoice_id VARCHAR(20) PRIMARY KEY,
    branch CHAR(1),
    city VARCHAR(50),
    customer_type VARCHAR(20),
    gender VARCHAR(10),
    product_line VARCHAR(50),
    unit_price DECIMAL(10, 2),
    quantity INT,
    tax5 DECIMAL(10, 2),
    total DECIMAL(10, 2),
    date DATE,
    time TIME,
    payment VARCHAR(20),
    cogs DECIMAL(10, 2),
    gross_margin_percentage DECIMAL(5, 2),
    gross_income DECIMAL(10, 2),
    rating DECIMAL(3, 1)
);

select * FROM supermarket_sales;

DESCRIBE supermarket_sales;

select count(*) as total_records from supermarket_sales;

SELECT DISTINCT product_line
FROM supermarket_sales;

select branch, sum(total) as total_by_branch
from supermarket_sales
group by branch
order by total_by_branch desc;


select gender, sum(total) as total_by_gender
from supermarket_sales
group by gender
order by total_by_gender desc;


select payment, count(*) as customer_count
from supermarket_sales
group by payment;


select product_line, sum(quantity) as quantity_by_line
from supermarket_sales
group by product_line;


select product_line, sum(quantity) as quantity_more_100
from supermarket_sales
group by product_line
having sum(quantity) > 100;


SELECT city, SUM(total) AS total_revenue
FROM supermarket_sales
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 3;


select date, sum(total) as sales_by_date
from supermarket_sales
group by date
order by date;


SELECT 
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(YEAR FROM date) AS year
FROM supermarket_sales;


SELECT date, SUM(gross_income) AS total_income
FROM supermarket_sales
GROUP BY date
ORDER BY total_income DESC
LIMIT 1;


SELECT *
FROM supermarket_sales
WHERE total > (SELECT AVG(total) FROM supermarket_sales);


SELECT invoice_id, total,
  CASE 
    WHEN total < 200 THEN 'Low'
    WHEN total BETWEEN 200 AND 500 THEN 'Medium'
    ELSE 'High'
  END AS total_category
FROM supermarket_sales;


select invoice_id, total
from supermarket_sales
order by total desc
limit 1 offset 1;

SELECT date, invoice_id, total,
       SUM(total) OVER (ORDER BY date) AS running_total
FROM supermarket_sales;


SELECT invoice_id, gross_income,
       RANK() OVER (ORDER BY gross_income DESC) AS income_rank
FROM supermarket_sales;


SELECT product_line, invoice_id, total,
       AVG(total) OVER (PARTITION BY product_line) AS avg_total,
       RANK() OVER (PARTITION BY product_line ORDER BY total DESC) AS rank_within_line
FROM supermarket_sales;








