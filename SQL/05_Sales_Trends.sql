/*
Project: AdventureWorks Sales Analysis
File: 05_Sales_Trends.sql

Business Question:
How have sales changed over time?
Are there yearly or monthly sales patterns?

Purpose:
Analyze sales trends by year and month.
*/


USE AdventureWorksDW2025;
GO


-- Sales trend by year

SELECT
    YEAR(OrderDate) AS SalesYear,
    SUM(SalesAmount) AS TotalSales,
    COUNT(DISTINCT SalesOrderNumber) AS NumberOfOrders
FROM FactInternetSales
GROUP BY
    YEAR(OrderDate)
ORDER BY
    SalesYear;


-- Sales trend by month

SELECT
    MONTH(OrderDate) AS SalesMonthNumber,
    DATENAME(MONTH, OrderDate) AS SalesMonth,
    SUM(SalesAmount) AS TotalSales,
    COUNT(DISTINCT SalesOrderNumber) AS NumberOfOrders
FROM FactInternetSales
GROUP BY
    MONTH(OrderDate),
    DATENAME(MONTH, OrderDate)
ORDER BY
    SalesMonthNumber;