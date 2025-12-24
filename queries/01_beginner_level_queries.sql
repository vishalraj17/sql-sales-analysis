-- 1.Display all records from the sales table
Select * 
FROM salesdatacsv;

-- 2. Show the first 10 rows from the customer lookup table
SELECT * 
FROM customerlookup LIMIT 10;

-- 3. List unique product categories
SELECT DISTINCT CategoryName 
FROM productcategorieslookup;

-- 4. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customerlookup;

-- 5. Sales with quantity > 2
SELECT * FROM salesdatacsv
WHERE OrderQuantity>2;

-- 6. Sales on a specific date
SELECT * FROM salesdatacsv
WHERE OrderDate = '2021-09-22';

-- 7. Products priced above average
SELECT * FROM productlookup
WHERE ProductPrice >(
  SELECT AVG(ProductPrice) FROM productlookup);

-- 8. Customer names and birthday with concat
SELECT CONCAT(FirstName,' ',LastName) AS Name, BirthDate
FROM customerlookup;

-- 9. Products ordered by price (desc)
SELECT ProductName, ProductPrice
FROM productlookup 
ORDER BY ProductPrice DESC;

-- 10. Total number of orders Quantity
SELECT count(OrderQuantity) TotalOrder
FROM salesdatacsv;







