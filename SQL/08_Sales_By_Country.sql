/*
Project: AdventureWorks Sales Analysis
File: 08_Sales_By_Country.sql

Business Question:
Which countries generate the highest sales revenue?

Purpose:
Analyze sales performance by country.
*/


USE AdventureWorksDW2025;
GO


SELECT
    g.EnglishCountryRegionName AS Country,
    COUNT(DISTINCT fs.SalesOrderNumber) AS NumberOfOrders,
    COUNT(DISTINCT fs.CustomerKey) AS NumberOfCustomers,
    SUM(fs.SalesAmount) AS TotalSales
FROM FactInternetSales fs
JOIN DimCustomer c
    ON fs.CustomerKey = c.CustomerKey
JOIN DimGeography g
    ON c.GeographyKey = g.GeographyKey
GROUP BY
    g.EnglishCountryRegionName
ORDER BY
    TotalSales DESC;