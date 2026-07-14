/*
Project: AdventureWorks Sales Analysis
File: 03_Customer_Analysis.sql

Purpose:
Customer analysis including:
- Customer purchase behavior
- Number of orders per customer
- Total revenue per customer
- Average order value
- Top customers by sales
*/

USE AdventureWorksDW2025;
GO


-- Customer sales overview

SELECT
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    COUNT(DISTINCT fs.SalesOrderNumber) AS NumberOfOrders,
    SUM(fs.SalesAmount) AS TotalSales,
    AVG(fs.SalesAmount) AS AverageOrderValue
FROM FactInternetSales fs
JOIN DimCustomer c
    ON fs.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerKey,
    c.FirstName,
    c.LastName
ORDER BY
    TotalSales DESC;


-- Top 10 customers by revenue

SELECT TOP 10
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    SUM(fs.SalesAmount) AS TotalSales
FROM FactInternetSales fs
JOIN DimCustomer c
    ON fs.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerKey,
    c.FirstName,
    c.LastName
ORDER BY
    TotalSales DESC;