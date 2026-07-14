/*
Project: AdventureWorks Sales Analysis
File: 06_Top_Products.sql

Business Question:
Which products are the top performers within each product category?

Purpose:
Rank products by revenue within each product category.
*/


USE AdventureWorksDW2025;
GO


WITH ProductSales AS
(
    SELECT
        pc.EnglishProductCategoryName AS ProductCategory,
        p.EnglishProductName AS ProductName,
        SUM(fs.SalesAmount) AS TotalSales
    FROM FactInternetSales fs
    JOIN DimProduct p
        ON fs.ProductKey = p.ProductKey
    JOIN DimProductSubcategory ps
        ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    JOIN DimProductCategory pc
        ON ps.ProductCategoryKey = pc.ProductCategoryKey
    GROUP BY
        pc.EnglishProductCategoryName,
        p.EnglishProductName
),

RankedProducts AS
(
    SELECT
        ProductCategory,
        ProductName,
        TotalSales,
        RANK() OVER
        (
            PARTITION BY ProductCategory
            ORDER BY TotalSales DESC
        ) AS ProductRank
    FROM ProductSales
)

SELECT
    ProductCategory,
    ProductRank,
    ProductName,
    TotalSales
FROM RankedProducts
WHERE ProductRank <= 3
ORDER BY
    ProductCategory,
    ProductRank;