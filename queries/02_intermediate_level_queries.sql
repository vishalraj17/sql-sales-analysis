-- 11. Total sales revenue
SELECT 
 SUM(s.OrderQuantity*p.ProductPrice) AS total_revenue
FROM 
 salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey;



-- 12. Total sales by product
SELECT 
 p.ProductName,
 SUM(s.OrderQuantity*p.ProductPrice) AS total_sales
FROM 
 salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey
GROUP BY p.ProductName;



-- 13. Quantity sold per category
SELECT 
 pc.CategoryName,
 SUM(s.OrderQuantity*p.ProductPrice)
FROM 
 salesdatacsv s
JOIN productlookup p ON s.ProductKey=p.ProductKey
JOIN productsubcategorieslookup ps ON p.ProductSubcategoryKey=ps.ProductSubcategoryKey
JOIN productcategorieslookup pc ON ps.ProductCategoryKey=pc.ProductCategoryKey
GROUP BY pc.CategoryName;



-- 14. Top 5 best-selling products (revenue)
SELECT 
 p.ProductName,
 SUM(s.OrderQuantity*p.ProductPrice) as revenue
FROM
 salesdatacsv s
JOIN productlookup p ON s.ProductKey=p.ProductKey
GROUP BY p.ProductName
ORDER BY revenue DESC
LIMIT 5;



-- 15. Total sales by customer
SELECT 
 CONCAT(c.FirstName,' ',c.LastName) AS Name,
 SUM(s.OrderQuantity*p.ProductPrice) as revenue
FROM
 salesdatacsv s
JOIN productlookup p ON s.ProductKey=p.ProductKey
JOIN customerlookup c ON s.CustomerKey=c.CustomerKey
GROUP BY Name;



-- 16. Monthly sales trend
SELECT 
 DATE_FORMAT(OrderDate, '%Y-%m') AS month,
 SUM(s.OrderQuantity*p.ProductPrice) AS revenue
FROM 
 salesdatacsv s
JOIN productlookup p ON s.ProductKey=p.ProductKey
GROUP BY month
ORDER BY month;



-- 17. Average order value
SELECT 
 AVG(s.OrderQuantity*p.ProductPrice) AS Average_Revenue
FROM 
 salesdatacsv s
JOIN productlookup p ON s.ProductKey=p.ProductKey


  
-- 18. Customers with more than 5 purchases
SELECT
 CustomerKey,
 COUNT(*) AS Order_Count
FROM 
 salesdatacsv
GROUP BY CustomerKey
HAVING COUNT(*) >5;



-- 19. Sales with product & category info
SELECT 
 s.OrderNumber,
 p.ProductName,
 pc.CategoryName,
 S.OrderQuantity*p.ProductPrice AS revenue
FROM
 salesdatacsv s
JOIN productlookup p ON s.ProductKey = p.ProductKey
JOIN productsubcategorieslookup ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN productcategorieslookup pc ON ps.ProductCategoryKey = pc.ProductCategoryKey;



-- 20. Revenue by Country
SELECT 
 t.Country,
 SUM(s.OrderQuantity*p.ProductPrice) AS Revenue
FROM
 salesdatacsv s
JOIN productlookup p ON s.ProductKey=p.ProductKey
JOIN territorylookup t ON s.TerritoryKey=t.SalesTerritoryKey
GROUP BY
 t.Country









