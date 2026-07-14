/*
Project: AdventureWorks Sales Analysis
File: 07_Returning_Customers.sql

Business Question:
Which customers are returning customers and how often do they purchase?

Purpose:
Analyze customer loyalty based on number of orders.
*/


USE AdventureWorksDW2025;
GO


WITH CustomerOrders AS
(
    SELECT
        c.CustomerKey,
        c.FirstName,
        c.LastName,
        COUNT(DISTINCT fs.SalesOrderNumber) AS NumberOfOrders,
        SUM(fs.SalesAmount) AS TotalSales
    FROM FactInternetSales fs
    JOIN DimCustomer c
        ON fs.CustomerKey = c.CustomerKey
    GROUP BY
        c.CustomerKey,
        c.FirstName,
        c.LastName
    HAVING COUNT(DISTINCT fs.SalesOrderNumber) > 1
)

SELECT
    CustomerKey,
    FirstName,
    LastName,
    NumberOfOrders,
    TotalSales,
    CASE
        WHEN NumberOfOrders >= 10 THEN 'Highly Loyal Customer'
        WHEN NumberOfOrders >= 5 THEN 'Returning Customer'
        ELSE 'Occasional Customer'
    END AS CustomerType
FROM CustomerOrders
ORDER BY
    NumberOfOrders DESC,
    TotalSales DESC;