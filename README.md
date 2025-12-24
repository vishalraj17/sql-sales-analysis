# SQL Sales Analysis Project
## Project Overview

This project analyzes sales transaction data using SQL to uncover meaningful business insights related to revenue trends, customer behavior, and product performance.
The goal is to demonstrate strong proficiency in SQL through the use of joins, aggregations, subqueries, Common Table Expressions (CTEs), and window functions.

The project simulates a real-world retail analytics use case where raw transactional data is transformed into actionable insights for business decision-making.


## Dataset Description
The dataset consists of multiple relational tables:

Table Name	Description
sales	Transaction-level sales data
product_lookup	Product details including price and category
customer_lookup	Customer demographic information
category_lookup	Product category mapping
subcategory_lookup	Product subcategory mapping


## Key Columns
- OrderDate — Date of transaction

- ProductKey — Unique product identifier

- CustomerKey — Unique customer identifier

- OrderQuantity — Number of units sold

- ProductPrice — Price per unit

Revenue is not stored directly and is calculated dynamically using:

Revenue = OrderQuantity × ProductPrice


## Tools & Technologies
- Database: MySQL

- Language: SQL

### Concepts Used:

- Joins

- Aggregations

- Subqueries

- Common Table Expressions (CTEs)

- Window Functions

- Data modeling


## Analysis Performed
### 1. Data Exploration

- Row counts and distinct counts

- Null checks and data validation

- Understanding table relationships

### 2. Revenue Calculation

- Joined sales and product_lookup tables to compute revenue

- Validated calculations at row and aggregate levels

### 3. Customer Analysis

- Total revenue per customer

- Identification of high-value customers (above average spenders)

### 4. Product Performance

- Revenue contribution by product and category

- Identification of top-selling and low-performing products

### 5. Time Series Analysis

- Daily revenue trends

- Running total of cumulative revenue using window functions


## Example Queries
### Revenue per Customer
SELECT 
    s.CustomerKey,
    SUM(s.OrderQuantity * p.ProductPrice) AS total_spent
FROM sales s
JOIN product_lookup p
ON s.ProductKey = p.ProductKey
GROUP BY s.CustomerKey;

### Running Total of Revenue
SELECT 
    OrderDate,
    SUM(s.OrderQuantity * p.ProductPrice) AS daily_revenue,
    SUM(SUM(s.OrderQuantity * p.ProductPrice))
        OVER (ORDER BY OrderDate) AS running_total
FROM sales s
JOIN product_lookup p
ON s.ProductKey = p.ProductKey
GROUP BY OrderDate;


## Key Business Insights

- A small percentage of customers contribute a large share of total revenue (Pareto principle).

- Certain product categories dominate overall sales performance.

- Revenue shows consistent growth over time with identifiable seasonal spikes.

- High-value customers can be targeted for loyalty and retention strategies.

(Exact values and screenshots are available in the /screenshots folder.)


## Folder Structure
sql-sales-analysis
- │
- ├── data/
- ├── schema/
- ├── queries/
- ├── screenshots/
- ├── docs/
- └── README.md


## Learnings & Outcomes

- Strengthened ability to model relational datasets.

- Improved writing and optimization of complex SQL queries.

- Learned how to transform raw data into structured business insights.

- Gained experience in documenting analytical work professionally.


## Author
- Vishal Raj
- Aspiring Data Analyst
- Skills: SQL | MySQL | Power BI | Excel | Data Analysis
