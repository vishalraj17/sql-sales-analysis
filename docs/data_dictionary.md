# Data Dictionary

This document describes the structure, columns, and business meaning of all datasets
used in the Sales Analysis project.

---

## Table: salesdatacsv

| Column Name   | Data Type | Description                                         | Key |
|--------------|-----------|-----------------------------------------------------|-----|
| OrderDate     | DATE      | Date when the order was placed                      |     |
| StockDate     | DATE      | Date when the product was stocked                   |     |
| OrderNumber   | INT       | Unique order transaction number                     |     |
| ProductKey    | INT       | Identifier for the ordered product                  | FK  |
| CustomerKey   | INT       | Identifier for the customer                         | FK  |
| TerritoryKey  | INT       | Identifier for the sales territory                  | FK  |
| OrderQuantity | INT       | Number of units ordered in the transaction          |     |

---

## Table: customerlookup

| Column Name    | Data Type    | Description                                  | Key |
|---------------|-------------|----------------------------------------------|-----|
| CustomerKey    | INT         | Unique identifier for customer               | PK  |
| Prefix         | VARCHAR(10) | Customer title (Mr., Ms., Dr., etc.)         |     |
| FirstName      | VARCHAR(50) | Customer first name                          |     |
| LastName       | VARCHAR(50) | Customer last name                           |     |
| BirthDate      | DATE        | Customer date of birth                       |     |
| MaritalStatus  | VARCHAR(10) | Customer marital status                      |     |
| Gender         | VARCHAR(10) | Customer gender                              |     |
| EmailAddress   | VARCHAR(100)| Customer email address                       |     |
| AnnualIncome   | INT         | Customer annual income                       |     |
| TotalChildren  | INT         | Number of children in the household          |     |
| EducationLevel | VARCHAR(50) | Highest education level attained             |     |
| Occupation     | VARCHAR(50) | Customer occupation                          |     |
| HomeOwner      | VARCHAR(5)  | Whether customer owns a home (Yes/No)        |     |

---

## Table: productcategorieslookup

| Column Name        | Data Type    | Description                        | Key |
|--------------------|-------------|------------------------------------|-----|
| ProductCategoryKey | INT         | Unique identifier for category     | PK  |
| CategoryName       | VARCHAR(50) | Name of the product category       |     |

---

## Table: productsubcategorieslookup

| Column Name           | Data Type    | Description                             | Key |
|-----------------------|-------------|-----------------------------------------|-----|
| ProductSubcategoryKey | INT         | Unique identifier for subcategory       | PK  |
| SubCategoryName       | VARCHAR(50) | Name of the product subcategory         |     |
| ProductCategoryKey    | INT         | Identifier for parent category          | FK  |

---

## Table: productlookup

| Column Name           | Data Type      | Description                                | Key |
|-----------------------|---------------|--------------------------------------------|-----|
| ProductKey            | INT           | Unique identifier for product              | PK  |
| ProductSubcategoryKey| INT           | Identifier for product subcategory         | FK  |
| ProductSKU            | VARCHAR(50)   | Stock keeping unit code                    |     |
| ProductName           | VARCHAR(100)  | Name of the product                        |     |
| ModelName             | VARCHAR(100)  | Model or variant name                      |     |
| ProductDescription    | TEXT          | Detailed description of the product        |     |
| ProductColor          | VARCHAR(30)   | Color of the product                       |     |
| ProductSize           | VARCHAR(20)   | Size or dimension of the product           |     |
| ProductStyle          | VARCHAR(30)   | Style or design classification             |     |
| ProductCost           | DECIMAL(10,2) | Cost of producing or acquiring the product|     |
| ProductPrice          | DECIMAL(10,2) | Selling price of the product               |     |

---

## Table: territorylookup

| Column Name       | Data Type    | Description                         | Key |
|-------------------|-------------|-------------------------------------|-----|
| SalesTerritoryKey | INT         | Unique identifier for territory     | PK  |
| Region            | VARCHAR(50) | Sales region                        |     |
| Country           | VARCHAR(50) | Country name                        |     |
| Continent         | VARCHAR(50) | Continent name                      |     |

---

## Relationships

- `salesdatacsv.ProductKey` → `productlookup.ProductKey`
- `salesdatacsv.CustomerKey` → `customerlookup.CustomerKey`
- `salesdatacsv.TerritoryKey` → `territorylookup.SalesTerritoryKey`
- `productlookup.ProductSubcategoryKey` → `productsubcategorieslookup.ProductSubcategoryKey`
- `productsubcategorieslookup.ProductCategoryKey` → `productcategorieslookup.ProductCategoryKey`

