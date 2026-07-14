/*
Project: AdventureWorks Sales Analysis
File: 01_Sales_Overview.sql

Purpose:
Basic sales overview including:
- Total Sales
- Number of Orders
- Number of Customers
- Average Order Value
*/

USE AdventureWorksDW2025;
GO

SELECT
    SUM(SalesAmount) AS TotalSales,
    COUNT(DISTINCT SalesOrderNumber) AS NumberOfOrders,
    COUNT(DISTINCT CustomerKey) AS NumberOfCustomers,
    AVG(SalesAmount) AS AverageOrderValue
FROM FactInternetSales;