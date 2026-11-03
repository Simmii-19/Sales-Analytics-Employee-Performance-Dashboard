
/*
==========================================================
PROJECT: Sales Analytics & Employee Performance Dashboard
DATABASE: AdventureWorks
FILE: 01_Data_Exploration.sql

PURPOSE:
Explore database structure, inspect sales data,
understand data quality and calculate initial KPIs.

TOOLS: Microsoft SQL Server
==========================================================
*/


/* ========================================================
   1. EXPLORE DATABASE TABLES
======================================================== */

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;


/* ========================================================
   2. CHECK FACT INTERNET SALES RECORD COUNT
======================================================== */

SELECT
    COUNT(*) AS Total_Sales_Records
FROM dbo.FactInternetSales;


/* ========================================================
   3. INSPECT FACT INTERNET SALES COLUMNS
======================================================== */

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FactInternetSales'
ORDER BY ORDINAL_POSITION;


/* ========================================================
   4. EXPLORE SALES DATE RANGE
======================================================== */

SELECT
    MIN(OrderDate) AS First_Order_Date,
    MAX(OrderDate) AS Last_Order_Date
FROM dbo.FactInternetSales;


/* ========================================================
   5. CALCULATE OVERALL SALES METRICS
======================================================== */

SELECT
    COUNT(*) AS Total_Sales_Records,

    COUNT(DISTINCT SalesOrderNumber)
        AS Total_Orders,

    COUNT(DISTINCT CustomerKey)
        AS Total_Customers,

    COUNT(DISTINCT ProductKey)
        AS Products_Sold,

    SUM(OrderQuantity)
        AS Total_Units_Sold,

    SUM(SalesAmount)
        AS Total_Revenue,

    SUM(TotalProductCost)
        AS Total_Product_Cost,

    SUM(SalesAmount) - SUM(TotalProductCost)
        AS Gross_Profit

FROM dbo.FactInternetSales;


/* ========================================================
   6. CHECK MISSING VALUES IN IMPORTANT COLUMNS
======================================================== */

SELECT
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END)
        AS Missing_ProductKey,

    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END)
        AS Missing_CustomerKey,

    SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END)
        AS Missing_OrderDate,

    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END)
        AS Missing_SalesAmount

FROM dbo.FactInternetSales;


/* ========================================================
   7. ANALYZE YEARLY REVENUE
======================================================== */

SELECT
    d.CalendarYear,
    SUM(f.SalesAmount) AS Total_Revenue,
    COUNT(DISTINCT f.SalesOrderNumber) AS Total_Orders

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimDate d
    ON f.OrderDateKey = d.DateKey

GROUP BY
    d.CalendarYear

ORDER BY
    d.CalendarYear;


/* ========================================================
   8. ANALYZE REVENUE BY PRODUCT CATEGORY
======================================================== */

SELECT
    pc.EnglishProductCategoryName AS Product_Category,

    SUM(f.SalesAmount) AS Total_Revenue,

    SUM(f.TotalProductCost) AS Total_Product_Cost,

    SUM(f.SalesAmount) - SUM(f.TotalProductCost)
        AS Gross_Profit

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

INNER JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

INNER JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

GROUP BY
    pc.EnglishProductCategoryName

ORDER BY
    Total_Revenue DESC;


/* ========================================================
   9. IDENTIFY TOP 10 PRODUCTS BY REVENUE
======================================================== */

SELECT TOP 10
    p.EnglishProductName AS Product_Name,

    SUM(f.SalesAmount) AS Total_Revenue,

    SUM(f.OrderQuantity) AS Total_Units_Sold

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

GROUP BY
    p.EnglishProductName

ORDER BY
    Total_Revenue DESC;


/* ========================================================
   10. ANALYZE SALES BY TERRITORY
======================================================== */

SELECT
    st.SalesTerritoryRegion AS Sales_Region,

    st.SalesTerritoryCountry AS Country,

    SUM(f.SalesAmount) AS Total_Revenue,

    COUNT(DISTINCT f.SalesOrderNumber) AS Total_Orders

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimSalesTerritory st
    ON f.SalesTerritoryKey = st.SalesTerritoryKey

GROUP BY
    st.SalesTerritoryRegion,
    st.SalesTerritoryCountry

ORDER BY
    Total_Revenue DESC;


/* ========================================================
   END OF DATA EXPLORATION
======================================================== */
