
/*
Project: Sales Analytics & Employee Performance Dashboard
File: 05_Advanced_SQL_Views.sql
Database: AdventureWorksDW
Purpose: Advanced SQL analysis and reusable business reporting
*/

-- 1. Create a reusable sales summary view
CREATE OR ALTER VIEW dbo.vw_SalesSummary
AS
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT SalesOrderNumber) AS Total_Orders,
    COUNT(DISTINCT CustomerKey) AS Total_Customers,
    SUM(OrderQuantity) AS Total_Units_Sold,
    SUM(SalesAmount) AS Total_Revenue,
    SUM(TotalProductCost) AS Total_Product_Cost,
    SUM(SalesAmount - TotalProductCost) AS Gross_Profit
FROM dbo.FactInternetSales;
GO

-- View the sales summary
SELECT *
FROM dbo.vw_SalesSummary;
GO


-- 2. Customer segmentation based on revenue
WITH CustomerRevenue AS
(
    SELECT
        CustomerKey,
        SUM(SalesAmount) AS Total_Revenue,
        COUNT(DISTINCT SalesOrderNumber) AS Total_Orders
    FROM dbo.FactInternetSales
    GROUP BY CustomerKey
)
SELECT
    CustomerKey,
    Total_Revenue,
    Total_Orders,
    CASE
        WHEN Total_Revenue >= 10000 THEN 'High Value'
        WHEN Total_Revenue >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Segment
FROM CustomerRevenue
ORDER BY Total_Revenue DESC;


-- 3. Running total of monthly revenue
WITH MonthlySales AS
(
    SELECT
        D.CalendarYear,
        D.MonthNumberOfYear,
        SUM(F.SalesAmount) AS Monthly_Revenue
    FROM dbo.FactInternetSales AS F
    INNER JOIN dbo.DimDate AS D
        ON F.OrderDateKey = D.DateKey
    GROUP BY
        D.CalendarYear,
        D.MonthNumberOfYear
)
SELECT
    CalendarYear,
    MonthNumberOfYear,
    Monthly_Revenue,
    SUM(Monthly_Revenue) OVER
    (
        ORDER BY CalendarYear, MonthNumberOfYear
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Running_Revenue
FROM MonthlySales
ORDER BY CalendarYear, MonthNumberOfYear;


-- 4. Month-over-month revenue comparison
WITH MonthlySales AS
(
    SELECT
        D.CalendarYear,
        D.MonthNumberOfYear,
        SUM(F.SalesAmount) AS Monthly_Revenue
    FROM dbo.FactInternetSales AS F
    INNER JOIN dbo.DimDate AS D
        ON F.OrderDateKey = D.DateKey
    GROUP BY
        D.CalendarYear,
        D.MonthNumberOfYear
),
RevenueComparison AS
(
    SELECT
        CalendarYear,
        MonthNumberOfYear,
        Monthly_Revenue,
        LAG(Monthly_Revenue) OVER
        (
            ORDER BY CalendarYear, MonthNumberOfYear
        ) AS Previous_Month_Revenue
    FROM MonthlySales
)
SELECT
    CalendarYear,
    MonthNumberOfYear,
    Monthly_Revenue,
    Previous_Month_Revenue,
    Monthly_Revenue - Previous_Month_Revenue AS Revenue_Change,
    CASE
        WHEN Previous_Month_Revenue IS NULL
          OR Previous_Month_Revenue = 0 THEN NULL
        ELSE
            (Monthly_Revenue - Previous_Month_Revenue)
            * 100.0 / Previous_Month_Revenue
    END AS MoM_Growth_Percentage
FROM RevenueComparison
ORDER BY CalendarYear, MonthNumberOfYear;


-- 5. Rank products within each category
WITH ProductSales AS
(
    SELECT
        PC.EnglishProductCategoryName AS Product_Category,
        P.EnglishProductName AS Product_Name,
        SUM(F.SalesAmount) AS Total_Revenue
    FROM dbo.FactInternetSales AS F
    INNER JOIN dbo.DimProduct AS P
        ON F.ProductKey = P.ProductKey
    INNER JOIN dbo.DimProductSubcategory AS PS
        ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
    INNER JOIN dbo.DimProductCategory AS PC
        ON PS.ProductCategoryKey = PC.ProductCategoryKey
    GROUP BY
        PC.EnglishProductCategoryName,
        P.EnglishProductName
)
SELECT
    Product_Category,
    Product_Name,
    Total_Revenue,
    DENSE_RANK() OVER
    (
        PARTITION BY Product_Category
        ORDER BY Total_Revenue DESC
    ) AS Category_Rank
FROM ProductSales
ORDER BY Product_Category, Category_Rank;
GO
