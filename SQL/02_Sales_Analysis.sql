
/*
==========================================================
PROJECT: Sales Analytics & Employee Performance Dashboard
FILE: 02_Sales_Analysis.sql
DATABASE: AdventureWorks

PURPOSE:
Analyze sales performance, revenue trends, customer
contribution, order value and regional performance.

SQL CONCEPTS:
JOIN, CTE, GROUP BY, CASE, Aggregate Functions,
Window Functions, Subqueries
==========================================================
*/


/* ========================================================
   1. MONTHLY SALES REVENUE TREND
======================================================== */

SELECT
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.EnglishMonthName AS Month_Name,
    SUM(f.SalesAmount) AS Monthly_Revenue,
    COUNT(DISTINCT f.SalesOrderNumber) AS Total_Orders

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimDate d
    ON f.OrderDateKey = d.DateKey

GROUP BY
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.EnglishMonthName

ORDER BY
    d.CalendarYear,
    d.MonthNumberOfYear;


/* ========================================================
   2. YEAR-OVER-YEAR REVENUE GROWTH
======================================================== */

WITH YearlySales AS
(
    SELECT
        d.CalendarYear,
        SUM(f.SalesAmount) AS Total_Revenue

    FROM dbo.FactInternetSales f

    INNER JOIN dbo.DimDate d
        ON f.OrderDateKey = d.DateKey

    GROUP BY d.CalendarYear
)

SELECT
    CalendarYear,
    Total_Revenue,

    LAG(Total_Revenue) OVER
        (ORDER BY CalendarYear) AS Previous_Year_Revenue,

    Total_Revenue -
    LAG(Total_Revenue) OVER
        (ORDER BY CalendarYear) AS Revenue_Difference,

    ROUND(
        (
            Total_Revenue -
            LAG(Total_Revenue) OVER
                (ORDER BY CalendarYear)
        ) * 100.0 /
        NULLIF(
            LAG(Total_Revenue) OVER
                (ORDER BY CalendarYear), 0
        ), 2
    ) AS Revenue_Growth_Percentage

FROM YearlySales
ORDER BY CalendarYear;


/* ========================================================
   3. SALES PERFORMANCE BY TERRITORY
======================================================== */

SELECT
    st.SalesTerritoryRegion AS Region,
    st.SalesTerritoryCountry AS Country,

    SUM(f.SalesAmount) AS Total_Revenue,

    SUM(f.TotalProductCost) AS Total_Cost,

    SUM(f.SalesAmount - f.TotalProductCost)
        AS Gross_Profit,

    COUNT(DISTINCT f.SalesOrderNumber)
        AS Total_Orders

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimSalesTerritory st
    ON f.SalesTerritoryKey = st.SalesTerritoryKey

GROUP BY
    st.SalesTerritoryRegion,
    st.SalesTerritoryCountry

ORDER BY Total_Revenue DESC;


/* ========================================================
   4. CUSTOMER REVENUE CONTRIBUTION
======================================================== */

SELECT
    f.CustomerKey,

    SUM(f.SalesAmount) AS Customer_Revenue,

    COUNT(DISTINCT f.SalesOrderNumber)
        AS Total_Orders,

    SUM(f.OrderQuantity) AS Total_Units_Purchased

FROM dbo.FactInternetSales f

GROUP BY f.CustomerKey

ORDER BY Customer_Revenue DESC;


/* ========================================================
   5. AVERAGE ORDER VALUE ANALYSIS
======================================================== */

WITH OrderSales AS
(
    SELECT
        SalesOrderNumber,
        SUM(SalesAmount) AS Order_Revenue

    FROM dbo.FactInternetSales

    GROUP BY SalesOrderNumber
)

SELECT
    COUNT(*) AS Total_Orders,

    SUM(Order_Revenue) AS Total_Revenue,

    AVG(Order_Revenue) AS Average_Order_Value,

    MAX(Order_Revenue) AS Highest_Order_Value,

    MIN(Order_Revenue) AS Lowest_Order_Value

FROM OrderSales;


/* ========================================================
   6. REVENUE AND PROFIT BY PRODUCT CATEGORY
======================================================== */

SELECT
    pc.EnglishProductCategoryName AS Category,

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

INNER JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

INNER JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

GROUP BY pc.EnglishProductCategoryName

ORDER BY Revenue DESC;


/* ========================================================
   7. SALES DISCOUNT ANALYSIS
======================================================== */

SELECT
    SUM(SalesAmount) AS Total_Revenue,

    SUM(DiscountAmount) AS Total_Discount,

    AVG(UnitPriceDiscountPct) * 100
        AS Average_Discount_Percentage,

    SUM(OrderQuantity) AS Total_Units_Sold

FROM dbo.FactInternetSales;


/* ========================================================
   8. REVENUE PERFORMANCE RANKING BY REGION
======================================================== */

WITH RegionalSales AS
(
    SELECT
        st.SalesTerritoryRegion AS Region,
        SUM(f.SalesAmount) AS Total_Revenue

    FROM dbo.FactInternetSales f

    INNER JOIN dbo.DimSalesTerritory st
        ON f.SalesTerritoryKey = st.SalesTerritoryKey

    GROUP BY st.SalesTerritoryRegion
)

SELECT
    Region,
    Total_Revenue,

    RANK() OVER
        (ORDER BY Total_Revenue DESC) AS Revenue_Rank

FROM RegionalSales
ORDER BY Revenue_Rank;


/* ========================================================
   END OF SALES ANALYSIS
======================================================== */
