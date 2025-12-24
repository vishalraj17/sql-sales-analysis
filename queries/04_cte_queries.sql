-- 31. Total Revenue by Customer & Rank Them
WITH customer_revenue AS (
    SELECT
        s.Customerkey,
        SUM(s.OrderQuantity * p.ProductPrice) AS total_revenue
    FROM salesdatacsv s
    JOIN productlookup p ON s.ProductKey = p.ProductKey
    GROUP BY s.CustomerKey
)
SELECT
    CustomerKey,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_revenue;



-- 32. Customers Spending Above Average Revenue
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(OrderDate, '%Y-%m') AS month,
        SUM(s.OrderQuantity * p.ProductPrice) AS revenue
    FROM salesdatacsv s
    JOIN productlookup p ON s.ProductKey = p.ProductKey
    GROUP BY month)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) /
        LAG(revenue) OVER (ORDER BY month) * 100, 2
    ) AS growth_percentage
FROM monthly_sales;



-- 33. Monthly Revenue & Month-over-Month Growth
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(orderdate, '%Y-%m') AS month,
        SUM(s.OrderQuantity * p.ProductPrice) AS revenue
    FROM salesdatacsv s
    JOIN productlookup p ON s.ProductKey = p.ProductKey
    GROUP BY month )
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) /
        LAG(revenue) OVER (ORDER BY month) * 100, 2
    ) AS growth_percentage
FROM monthly_sales;



-- 34. Top 3 Products by Revenue in Each Category
WITH product_revenue AS (
    SELECT
        pc.CategoryName,
        p.ProductName,
        SUM(s.OrderQuantity * p.ProductPrice) AS revenue
    FROM salesdatacsv s
    JOIN productlookup p ON s.ProductKey = p.ProductKey
    JOIN productsubcategorieslookup ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    JOIN productcategorieslookup pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
    GROUP BY pc.CategoryName, p.ProductName )
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY CategoryName ORDER BY revenue DESC) AS rnk
    FROM product_revenue
) t
WHERE rnk <= 3;



-- 35. Identify Inactive Customers (No Purchase in Last 6 Months)
WITH last_purchase AS (
    SELECT
        CustomerKey,
        MAX(OrderDate) AS last_order_date
    FROM salesdatacsv
    GROUP BY CustomerKey
)
SELECT customerkey, last_order_date
FROM last_purchase
WHERE last_order_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);



-- 36. Customer Segmentation Using CTE
WITH customer_revenue AS (
    SELECT
        s.CustomerKey,
        SUM(s.OrderQuantity * p.ProductPrice) AS total_revenue
    FROM salesdatacsv s
    JOIN productlookup p ON s.ProductKey = p.ProductKey
    GROUP BY s.CustomerKey)
SELECT
    CustomerKey,
    total_revenue,
    CASE
        WHEN total_revenue > 50000 THEN 'High Value'
        WHEN total_revenue BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_revenue;
