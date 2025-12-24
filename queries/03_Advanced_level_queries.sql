-- 21. Top 3 products by sales in each category
SELECT *
FROM( 
 SELECT
  pc.CategoryName, p.ProductName,
  SUM(s.OrderQuantity * p.ProductPrice) AS Revenue,
  RANK() OVER (PARTITION BY pc.CategoryName ORDER BY SUM(s.OrderQuantity * p.ProductPrice) DESC) AS rnk
 FROM salesdatacsv s
 JOIN productlookup p ON s.ProductKey = p.ProductKey
 JOIN productsubcategorieslookup ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
 JOIN productcategorieslookup pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
 GROUP BY pc.CategoryName, p.ProductName
 ) t
WHERE rnk<= 3;



-- 22. Customers spending above average
SELECT 
    s.CustomerKey, 
    SUM(s.OrderQuantity * p.ProductPrice) AS total_spent
FROM salesdatacsv s
JOIN productlookup p  ON s.ProductKey = p.ProductKey
GROUP BY s.CustomerKey
HAVING SUM(s.OrderQuantity * p.ProductPrice) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT 
            SUM(s2.OrderQuantity * p2.ProductPrice) AS total_spent
        FROM salesdatacsv s2
        JOIN productlookup p2 
            ON s2.ProductKey = p2.ProductKey
        GROUP BY s2.CustomerKey
    ) x
);



-- 23. Products never sold
SELECT 
 p.ProductName
FROM
 productlookup p
LEFT JOIN salesdatacsv s ON p.ProductKey = s.ProductKey
WHERE s.ProductKey is NULL;



-- 24. Running total of sales by date
SELECT 
 s.OrderDate,
 SUM(s.OrderQuantity * p.ProductPrice) AS Total_spent,
 SUM(SUM(s.OrderQuantity * p.ProductPrice)) OVER (ORDER BY s.OrderDate) AS Running_total
FROM salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey
GROUP BY s.OrderDate;



-- 25. Rank customers by spending
SELECT 
 CustomerKey,
 SUM(S.OrderQuantity * p.ProductPrice) AS Total_Spent,
 RANK() OVER (ORDER BY SUM(S.OrderQuantity * p.ProductPrice) DESC) AS Rnk
FROM 
 salesdatacsv s
 JOIN productlookup p ON s.ProductKey = p.ProductKey
GROUP BY CustomerKey



-- 26. Month-over-month growth
SELECT 
  month,
  revenue,
  LAG(revenue) OVER (ORDER BY month) AS prev_month,
  ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) / 
        LAG(revenue) OVER (ORDER BY month) * 100, 2) AS growth_pct
FROM (
  SELECT DATE_FORMAT(orderdate, '%Y-%m') AS month,
         SUM(s.OrderQuantity * p.ProductPrice) AS revenue
  FROM salesdatacsv s
  JOIN productlookup p ON s.ProductKey = P.ProductKey
  GROUP BY month ) t;



-- 27. Repeat customers
SELECT CustomerKey
FROM salesdatacsv
GROUP BY CustomerKey
HAVING COUNT(*) > 1;



-- 28. Most profitable category
SELECT 
 pc.CategoryName,
 SUM(s.OrderQuantity * p.ProductPrice) AS revenue
FROM salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey
JOIN productsubcategorieslookup ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN productcategorieslookup pc ON ps.ProductSubcategoryKey = pc.ProductCategoryKey
GROUP BY pc.CategoryName
ORDER BY revenue DESC
LIMIT 1;



-- 29. Customer segmentation
SELECT 
 s.customerKey,
 SUM(s.OrderQuantity * p.ProductPrice) AS total_spent,
       CASE
         WHEN SUM(s.OrderQuantity * p.ProductPrice) > 50000 THEN 'High Value'
         WHEN SUM(s.OrderQuantity * p.ProductPrice) BETWEEN 20000 AND 50000 THEN 'Medium Value'
         ELSE 'Low Value'
       END AS customer_segment
FROM salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey 
GROUP BY s.CustomerKey;



-- 30. KPI dashboard (single query)
SELECT
  SUM(s.OrderQuantity * p.ProductPrice) AS total_revenue,
  COUNT(OrderQuantity) AS total_orders,
  COUNT(DISTINCT CustomerKey) AS total_customers,
  AVG(s.OrderQuantity * p.ProductPrice) AS avg_order_value
FROM salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey


