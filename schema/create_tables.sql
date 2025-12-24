CREATE TABLE customerlookup (
   CustomerKey INT UNSIGNED NOT NULL,
   Prefix VARCHAR(10),
   FirstName VARCHAR(30),
   LastName VARCHAR(30),
   BirthDate DATE,
   MaritalStatus CHAR(1) NOT NULL,
   Gender CHAR(1),
   EmailAddress VARCHAR(50),
   AnnualIncome INT UNSIGNED,
   TotalChildren TINYINT UNSIGNED,
   EducationLevel VARCHAR(30),
   Occupation VARCHAR(30),
   HomeOwner CHAR(1) NOT NULL,

   PRIMARY KEY (CustomerKey),
   UNIQUE KEY UC_Email (EmailAddress),
   CHECK (MaritalStatus IN ('S','M','D','W')),
   CHECK (Gender IN ('M','F','O') OR Gender IS NULL),
   CHECK (HomeOwner IN ('Y','N'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE productcategorieslookup (
   ProductCategoryKey INT UNSIGNED NOT NULL,
   CategoryName VARCHAR(50),
   PRIMARY KEY (ProductCategoryKey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE productsubcategorieslookup (
   ProductSubcategoryKey INT UNSIGNED NOT NULL,
   SubcategoryName VARCHAR(50),
   ProductCategoryKey INT UNSIGNED,
   PRIMARY KEY (ProductSubcategoryKey),
   KEY ProductCategoryKey (ProductCategoryKey),
   CONSTRAINT productsubcategorieslookup_ibfk_1 
     FOREIGN KEY (ProductCategoryKey)
     REFERENCES productcategorieslookup (ProductCategoryKey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE productlookup (
   ProductKey INT UNSIGNED NOT NULL,
   ProductSubcategoryKey INT UNSIGNED,
   ProductSKU VARCHAR(20),
   ProductName VARCHAR(50),
   ModelName VARCHAR(50),
   ProductDescription TEXT,
   ProductColor VARCHAR(20),
   ProductSize VARCHAR(20),
   ProductStyle VARCHAR(20),
   ProductCost DECIMAL(10,2),
   ProductPrice DECIMAL(10,2),

   PRIMARY KEY (ProductKey),
   KEY ProductSubcategoryKey (ProductSubcategoryKey),
   CONSTRAINT productlookup_ibfk_1 
     FOREIGN KEY (ProductSubcategoryKey)
     REFERENCES productsubcategorieslookup (ProductSubcategoryKey),
   CHECK (ProductCost >= 0),
   CHECK (ProductPrice >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE territorylookup (
   SalesTerritoryKey INT UNSIGNED NOT NULL,
   Region VARCHAR(30),
   Country VARCHAR(30),
   Continent VARCHAR(30),
   PRIMARY KEY (SalesTerritoryKey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE salesdatacsv (
   OrderDate DATE,
   StockDate DATE,
   OrderNumber VARCHAR(20),
   ProductKey INT UNSIGNED,
   CustomerKey INT UNSIGNED,
   TerritoryKey INT UNSIGNED,
   OrderLineItem INT,
   OrderQuantity INT,

   KEY ProductKey (ProductKey),
   KEY CustomerKey (CustomerKey),
   KEY TerritoryKey (TerritoryKey),

   CONSTRAINT salesdatacsv_ibfk_1 FOREIGN KEY (ProductKey) REFERENCES productlookup (ProductKey),
   CONSTRAINT salesdatacsv_ibfk_2 FOREIGN KEY (CustomerKey) REFERENCES customerlookup (CustomerKey),
   CONSTRAINT salesdatacsv_ibfk_3 FOREIGN KEY (TerritoryKey) REFERENCES territorylookup (SalesTerritoryKey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
