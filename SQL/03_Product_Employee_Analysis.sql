
/*
==========================================================
PROJECT: Sales Analytics & Employee Performance Dashboard
FILE: 03_Product_Employee_Analysis.sql
DATABASE: AdventureWorks

PURPOSE:
Analyze product revenue, profitability, sales volume,
top-performing products and employee contributions.

SQL CONCEPTS:
JOIN, GROUP BY, CTE, CASE, RANK, DENSE_RANK,
Aggregate Functions, Window Functions
==========================================================
*/


/* ========================================================
   1. PRODUCT CATEGORY PERFORMANCE
======================================================== */

SELECT
    pc.EnglishProductCategoryName AS Product_Category,

    SUM(f.SalesAmount) AS Total_Revenue,

    SUM(f.TotalProductCost) AS Total_Cost,

    SUM(f.SalesAmount - f.TotalProductCost)
        AS Gross_Profit,

    SUM(f.OrderQuantity) AS Units_Sold

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

INNER JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

INNER JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

GROUP BY pc.EnglishProductCategoryName

ORDER BY Total_Revenue DESC;


/* ========================================================
   2. TOP 10 PRODUCTS BY REVENUE
======================================================== */

SELECT TOP 10
    p.EnglishProductName AS Product_Name,

    SUM(f.SalesAmount) AS Total_Revenue,

    SUM(f.OrderQuantity) AS Units_Sold,

    SUM(f.SalesAmount - f.TotalProductCost)
        AS Gross_Profit

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

GROUP BY p.EnglishProductName

ORDER BY Total_Revenue DESC;


/* ========================================================
   3. PRODUCT PROFITABILITY ANALYSIS
======================================================== */

SELECT
    p.EnglishProductName AS Product_Name,

    SUM(f.SalesAmount) AS Revenue,

    SUM(f.TotalProductCost) AS Product_Cost,

    SUM(f.SalesAmount - f.TotalProductCost)
        AS Gross_Profit,

    ROUND(
        SUM(f.SalesAmount - f.TotalProductCost) * 100.0 /
        NULLIF(SUM(f.SalesAmount), 0), 2
    ) AS Profit_Margin_Percentage

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

GROUP BY p.EnglishProductName

ORDER BY Gross_Profit DESC;


/* ========================================================
   4. PRODUCT REVENUE RANKING
======================================================== */

WITH ProductSales AS
(
    SELECT
        p.EnglishProductName AS Product_Name,
        SUM(f.SalesAmount) AS Revenue

    FROM dbo.FactInternetSales f

    INNER JOIN dbo.DimProduct p
        ON f.ProductKey = p.ProductKey

    GROUP BY p.EnglishProductName
)

SELECT
    Product_Name,
    Revenue,

    DENSE_RANK() OVER
        (ORDER BY Revenue DESC) AS Revenue_Rank

FROM ProductSales

ORDER BY Revenue_Rank;


/* ========================================================
   5. EMPLOYEE REVENUE AND PROFITABILITY
   Uses FactResellerSales, not FactInternetSales.
======================================================== */

SELECT
    e.EmployeeKey,

    e.FirstName + ' ' + e.LastName AS Employee_Name,

    SUM(rs.SalesAmount) AS Total_Revenue,

    SUM(rs.TotalProductCost) AS Total_Cost,

    SUM(rs.SalesAmount - rs.TotalProductCost)
        AS Gross_Profit,

    COUNT(DISTINCT rs.SalesOrderNumber)
        AS Total_Orders,

    SUM(rs.OrderQuantity) AS Units_Sold

FROM dbo.FactResellerSales rs

INNER JOIN dbo.DimEmployee e
    ON rs.EmployeeKey = e.EmployeeKey

GROUP BY
    e.EmployeeKey,
    e.FirstName,
    e.LastName

ORDER BY Total_Revenue DESC;


/* ========================================================
   6. TOP 10 EMPLOYEES BY REVENUE
======================================================== */

SELECT TOP 10
    e.FirstName + ' ' + e.LastName AS Employee_Name,

    SUM(rs.SalesAmount) AS Total_Revenue

FROM dbo.FactResellerSales rs

INNER JOIN dbo.DimEmployee e
    ON rs.EmployeeKey = e.EmployeeKey

GROUP BY
    e.FirstName,
    e.LastName

ORDER BY Total_Revenue DESC;


/* ========================================================
   7. EMPLOYEE PROFIT MARGIN ANALYSIS
======================================================== */

SELECT
    e.FirstName + ' ' + e.LastName AS Employee_Name,

    SUM(rs.SalesAmount) AS Revenue,

    SUM(rs.SalesAmount - rs.TotalProductCost)
        AS Gross_Profit,

    ROUND(
        SUM(rs.SalesAmount - rs.TotalProductCost) * 100.0 /
        NULLIF(SUM(rs.SalesAmount), 0), 2
    ) AS Profit_Margin_Percentage

FROM dbo.FactResellerSales rs

INNER JOIN dbo.DimEmployee e
    ON rs.EmployeeKey = e.EmployeeKey

GROUP BY
    e.FirstName,
    e.LastName

ORDER BY Gross_Profit DESC;


/* ========================================================
   8. EMPLOYEE REVENUE RANKING
======================================================== */

WITH EmployeeSales AS
(
    SELECT
        e.EmployeeKey,
        e.FirstName + ' ' + e.LastName AS Employee_Name,

        SUM(rs.SalesAmount) AS Revenue

    FROM dbo.FactResellerSales rs

    INNER JOIN dbo.DimEmployee e
        ON rs.EmployeeKey = e.EmployeeKey

    GROUP BY
        e.EmployeeKey,
        e.FirstName,
        e.LastName
)

SELECT
    EmployeeKey,
    Employee_Name,
    Revenue,

    RANK() OVER
        (ORDER BY Revenue DESC) AS Employee_Revenue_Rank

FROM EmployeeSales

ORDER BY Employee_Revenue_Rank;


/* ========================================================
   END OF PRODUCT AND EMPLOYEE ANALYSIS
======================================================== */
