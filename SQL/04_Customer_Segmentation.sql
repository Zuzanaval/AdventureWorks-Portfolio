/*
Project: AdventureWorks Sales Analysis
File: 04_Customer_Segmentation.sql

Purpose:
Customer segmentation based on total revenue.

Segments:
- High Value Customer
- Medium Value Customer
- Low Value Customer
*/

USE AdventureWorksDW2025;
GO


WITH CustomerSales AS
(
    SELECT
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
)

SELECT
    CustomerKey,
    FirstName,
    LastName,
    TotalSales,
    CASE
        WHEN TotalSales >= 5000 THEN 'High Value Customer'
        WHEN TotalSales >= 2000 THEN 'Medium Value Customer'
        ELSE 'Low Value Customer'
    END AS CustomerSegment
FROM CustomerSales
ORDER BY
    TotalSales DESC;