
/*
Project: Sales Analytics & Employee Performance Dashboard
File: 04_Data_Quality_Analysis.sql
Purpose: Data quality checks and validation
Database: AdventureWorksDW
*/

-- 1. Check total records in Internet Sales
SELECT
    COUNT(*) AS Total_Records
FROM FactInternetSales;


-- 2. Check missing values in important columns
SELECT
    COUNT(CASE WHEN ProductKey IS NULL THEN 1 END) AS Missing_ProductKey,
    COUNT(CASE WHEN CustomerKey IS NULL THEN 1 END) AS Missing_CustomerKey,
    COUNT(CASE WHEN OrderDateKey IS NULL THEN 1 END) AS Missing_OrderDateKey,
    COUNT(CASE WHEN SalesOrderNumber IS NULL THEN 1 END) AS Missing_OrderNumber,
    COUNT(CASE WHEN SalesAmount IS NULL THEN 1 END) AS Missing_SalesAmount,
    COUNT(CASE WHEN OrderQuantity IS NULL THEN 1 END) AS Missing_OrderQuantity
FROM FactInternetSales;


-- 3. Identify duplicate sales order lines
-- Multiple lines per order are normal.
-- This checks duplicate order-line combinations.
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS Duplicate_Count
FROM FactInternetSales
GROUP BY
    SalesOrderNumber,
    SalesOrderLineNumber
HAVING COUNT(*) > 1;


-- 4. Check invalid sales values
SELECT *
FROM FactInternetSales
WHERE
    OrderQuantity <= 0
    OR SalesAmount < 0
    OR TotalProductCost < 0
    OR UnitPrice < 0;


-- 5. Validate ProductKey relationships
SELECT
    COUNT(*) AS Orphan_Product_Records
FROM FactInternetSales AS F
LEFT JOIN DimProduct AS P
    ON F.ProductKey = P.ProductKey
WHERE P.ProductKey IS NULL;


-- 6. Validate CustomerKey relationships
SELECT
    COUNT(*) AS Orphan_Customer_Records
FROM FactInternetSales AS F
LEFT JOIN DimCustomer AS C
    ON F.CustomerKey = C.CustomerKey
WHERE C.CustomerKey IS NULL;


-- 7. Validate OrderDateKey relationships
SELECT
    COUNT(*) AS Orphan_Date_Records
FROM FactInternetSales AS F
LEFT JOIN DimDate AS D
    ON F.OrderDateKey = D.DateKey
WHERE D.DateKey IS NULL;


-- 8. Check overall sales and profit calculations
SELECT
    COUNT(*) AS Total_Records,
    SUM(SalesAmount) AS Total_Revenue,
    SUM(TotalProductCost) AS Total_Product_Cost,
    SUM(SalesAmount - TotalProductCost) AS Gross_Profit,
    CASE
        WHEN SUM(SalesAmount) = 0 THEN 0
        ELSE
            SUM(SalesAmount - TotalProductCost)
            / SUM(SalesAmount) * 100
    END AS Profit_Margin_Percentage
FROM FactInternetSales;


-- 9. Check unusual order quantities
SELECT
    OrderQuantity,
    COUNT(*) AS Record_Count
FROM FactInternetSales
GROUP BY OrderQuantity
ORDER BY OrderQuantity;


-- 10. Check sales records by order date
SELECT
    OrderDate,
    COUNT(*) AS Total_Records,
    SUM(SalesAmount) AS Daily_Revenue
FROM FactInternetSales
GROUP BY OrderDate
ORDER BY OrderDate;
