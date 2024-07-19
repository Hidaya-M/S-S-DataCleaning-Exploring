--Fist Step Data Cleaning
                     --Converting the date field (Order Date , Ship Date) into the date data type, so we just see the date and not the time
SELECT
CAST ( [Order Date] as date) as OrderDateConverted
, CAST ( [Ship Date] as date)	as ShipDateConverted
  FROM [Sales].[dbo].[Orders]

                                                            --Adding New Column Called OrderDateConverted
ALTER TABLE [Sales].[dbo].[Orders]
ADD OrderDateConverted Date;

UPDATE [Sales].[dbo].[Orders]
SET OrderDateConverted = CAST ( [Order Date] as date);

select OrderDateConverted
from [Sales].[dbo].[Orders]

                                                             --Adding New Column Called ShipDateConverted
ALTER TABLE [Sales].[dbo].[Orders]
ADD ShipDateConverted Date;

UPDATE [Sales].[dbo].[Orders]
SET ShipDateConverted = CAST ( [Ship Date] as date);

select ShipDateConverted
from [Sales].[dbo].[Orders]

                                                          --capitalize the first letter in First Name
select 
UPPER(left([First Name],1))+ SUBSTRING( [First Name],2, LEN([First Name]))
FROM [Sales].[dbo].[Orders]

----Adding New Column FirstNameConverted
ALTER TABLE [Sales].[dbo].[Orders]
ADD FirstNameConverted NVARCHAR(50);

UPDATE [Sales].[dbo].[Orders]
SET FirstNameConverted = UPPER(left([First Name],1))+ SUBSTRING( [First Name],2, LEN([First Name]));

select FirstNameConverted
from [Sales].[dbo].[Orders]

                                                           --Combining the first name with the last name 
Select 
CONCAT ( FirstNameConverted , ' ' , [Last Name] ) as FullName
FROM [Sales].[dbo].[Orders]

--Adding New Column FullName
ALTER TABLE [Sales].[dbo].[Orders]
ADD FullName NVARCHAR(50);

UPDATE [Sales].[dbo].[Orders]
SET FullName = CONCAT ( FirstNameConverted , ' ' , [Last Name] );

select FullName
from [Sales].[dbo].[Orders]

  
                                                  --Split the Country/State column into two columns

                                                                 --Country Column
Select
[Country/state],
LEFT([Country/state], CHARINDEX(' ', [Country/state], CHARINDEX(' ', [Country/state]) + 1) - 1) as Country
FROM [Sales].[dbo].[Orders]

----Adding New Column Called Country
ALTER TABLE [Sales].[dbo].[Orders]
ADD Country NVARCHAR(100);

UPDATE [Sales].[dbo].[Orders]
SET Country = LEFT([Country/state], CHARINDEX(' ', [Country/state], CHARINDEX(' ', [Country/state]) + 1) - 1);

select Country
from [Sales].[dbo].[Orders]

                                                                   --City Column
select
SUBSTRING( [Country/state], CHARINDEX('/', [Country/state])+1, LEN([Country/state])) as City
FROM [Sales].[dbo].[Orders]

----Adding New Column Called City
ALTER TABLE [Sales].[dbo].[Orders]
ADD City NVARCHAR(100);

UPDATE [Sales].[dbo].[Orders]
SET City = SUBSTRING( [Country/state], CHARINDEX('/', [Country/state])+1, LEN([Country/state]));

select City
from [Sales].[dbo].[Orders]

--Round the sales and profit so they have 2 decimals

select 
Sales
,Profit
,ROUND(Sales, 2)
,ROUND(Profit, 2)
from [Sales].[dbo].[Orders]

--Adding New Column Called SalesConverted
ALTER TABLE [Sales].[dbo].[Orders]
ADD SalesConverted DECIMAL(30,2);

UPDATE [Sales].[dbo].[Orders]
SET SalesConverted = ROUND(Sales, 2);

select SalesConverted
from [Sales].[dbo].[Orders]

--Adding New Column Called ProfitConverted
ALTER TABLE [Sales].[dbo].[Orders]
ADD ProfitConverted DECIMAL(30,2);

UPDATE [Sales].[dbo].[Orders]
SET ProfitConverted = ROUND(Profit, 2);

select ProfitConverted
from [Sales].[dbo].[Orders]



                                                              --Removing Duplicate
select [Order ID], [Ship Mode], [Customer ID] ,Segment, State,[Postal Code], Region, [Product ID] , Category ,[Sub-Category], [Product Name],
Quantity,Discount,OrderDateConverted,ShipDateConverted,FullName , Country,City,SalesConverted,ProfitConverted, Count(*) as duplicates
from [Sales].[dbo].[Orders]
group by [Order ID] , [Ship Mode], [Customer ID] ,Segment, State,[Postal Code], Region, [Product ID] , Category ,[Sub-Category], [Product Name],
Quantity,Discount,OrderDateConverted,ShipDateConverted,FullName , Country,City,SalesConverted,ProfitConverted
having Count(*) > 1

                                                     --Verification to see the rows will be affected
SELECT o1.*
FROM [Sales].[dbo].[Orders] o1
INNER JOIN [Sales].[dbo].[Orders] o2
ON 
    o1.[Order ID] = o2.[Order ID]
    AND o1.[Ship Mode] = o2.[Ship Mode]
    AND o1.[Customer ID] = o2.[Customer ID]
    AND o1.Segment = o2.Segment
    AND o1.State = o2.State
    AND o1.[Postal Code] = o2.[Postal Code]
    AND o1.Region = o2.Region
    AND o1.[Product ID] = o2.[Product ID]
    AND o1.Category = o2.Category
    AND o1.[Sub-Category] = o2.[Sub-Category]
    AND o1.[Product Name] = o2.[Product Name]
    AND o1.Quantity = o2.Quantity
    AND o1.Discount = o2.Discount
    AND o1.OrderDateConverted = o2.OrderDateConverted
    AND o1.ShipDateConverted = o2.ShipDateConverted
    AND o1.FullName = o2.FullName
    AND o1.Country = o2.Country
    AND o1.City = o2.City
    AND o1.SalesConverted = o2.SalesConverted
    AND o1.ProfitConverted = o2.ProfitConverted
WHERE 
    o1.[Row ID]=o2.[Row ID];

	                                                     --Deleteing 
Delete o1
FROM [Sales].[dbo].[Orders] o1
INNER JOIN [Sales].[dbo].[Orders] o2
ON 
    o1.[Order ID] = o2.[Order ID]
    AND o1.[Ship Mode] = o2.[Ship Mode]
    AND o1.[Customer ID] = o2.[Customer ID]
    AND o1.Segment = o2.Segment
    AND o1.State = o2.State
    AND o1.[Postal Code] = o2.[Postal Code]
    AND o1.Region = o2.Region
    AND o1.[Product ID] = o2.[Product ID]
    AND o1.Category = o2.Category
    AND o1.[Sub-Category] = o2.[Sub-Category]
    AND o1.[Product Name] = o2.[Product Name]
    AND o1.Quantity = o2.Quantity
    AND o1.Discount = o2.Discount
    AND o1.OrderDateConverted = o2.OrderDateConverted
    AND o1.ShipDateConverted = o2.ShipDateConverted
    AND o1.FullName = o2.FullName
    AND o1.Country = o2.Country
    AND o1.City = o2.City
    AND o1.SalesConverted = o2.SalesConverted
    AND o1.ProfitConverted = o2.ProfitConverted
WHERE 
   o1.[Row ID]=o2.[Row ID];
   
   
                                                              --second step data exploration

--What is the total (sales , profit) for the company?
SELECT SUM(SalesConverted)as TotalSales,SUM(ProfitConverted) as TotalProfit
FROM [Sales].[dbo].[Orders] 

--What is the average (sales , profit) for the company?
SELECT cast(AVG(SalesConverted) as decimal(10,2))as AverageSales,cast(AVG(ProfitConverted) as decimal(10,2)) as AverageProfit
FROM [Sales].[dbo].[Orders] 


--What is the total (sales , profit) for the company by year?
SELECT YEAR (OrderDateConverted) as Years , SUM(SalesConverted)as TotalSales,SUM(ProfitConverted) as TotalProfit
FROM [Sales].[dbo].[Orders] 
GROUP BY YEAR (OrderDateConverted)
ORDER BY YEAR (OrderDateConverted)

--What is the average (sales , profit) for the company by year?
SELECT YEAR (OrderDateConverted) as Years , cast(AVG(SalesConverted) as decimal(10,2))as AverageSales,cast(AVG(ProfitConverted) as decimal(10,2)) as AverageProfit
FROM [Sales].[dbo].[Orders] 
GROUP BY YEAR (OrderDateConverted)
ORDER BY YEAR (OrderDateConverted)

--What is the total (sales , profit) for the company by month?
SELECT MONTH (OrderDateConverted) as Months , SUM(SalesConverted)as TotalSales,SUM(ProfitConverted) as TotalProfit
FROM [Sales].[dbo].[Orders] 
GROUP BY Month (OrderDateConverted)
ORDER BY MONTH (OrderDateConverted)

--What is the average (sales , profit) for the company by month?
SELECT MONTH (OrderDateConverted) as Months , cast(AVG(SalesConverted) as decimal(10,2))as AverageSales,cast(AVG(ProfitConverted) as decimal(10,2)) as AverageProfit
FROM [Sales].[dbo].[Orders] 
GROUP BY Month (OrderDateConverted)
ORDER BY MONTH (OrderDateConverted)

--What category has the highest sales ?
SELECT TOP 1 Category, SUM(SalesConverted) AS TotalSales
FROM [Sales].[dbo].[Orders]
GROUP BY Category
ORDER BY TotalSales DESC;

--What category has the lowest sales ?
SELECT TOP 1 Category, SUM(SalesConverted) AS TotalSales
FROM [Sales].[dbo].[Orders]
GROUP BY Category
ORDER BY TotalSales ;

--What category has the highest quantity ?
SELECT TOP 1 Category, SUM(Quantity) AS TotalQuantity
FROM [Sales].[dbo].[Orders]
GROUP BY Category
ORDER BY TotalQuantity DESC

--What region has the highest profit ?
SELECT TOP 1 Region, SUM(ProfitConverted) AS TotalProfit
FROM [Sales].[dbo].[Orders]
GROUP BY Region
ORDER BY TotalProfit DESC

--What region has the highest sales ?
SELECT TOP 1 Region, SUM(SalesConverted) AS TotalSales
FROM [Sales].[dbo].[Orders]
GROUP BY Region
ORDER BY TotalSales DESC

--What are the Top 5 state with the most sales 
SELECT Top 5 State , SUM(SalesConverted) as TotalSales
FROM [Sales].[dbo].[Orders]
GROUP BY State
ORDER BY TotalSales DESC

--Who are the top 10 customers by sales?
SELECT Top 10 FullName , SUM(SalesConverted) as TotalSales
FROM [Sales].[dbo].[Orders]
GROUP BY FullName
ORDER BY TotalSales DESC

--What are the sales and profit for each segment?
SELECT Segment , SUM(SalesConverted) as TotalSales , SUM(ProfitConverted) as TotalProfit
FROM [Sales].[dbo].[Orders]
GROUP BY Segment
ORDER BY TotalSales DESC

--Which products are the top 10 by Sales?
SELECT Top 10 [Product Name] ,[Product ID], SUM(SalesConverted) as TotalSales
FROM [Sales].[dbo].[Orders]
GROUP BY [Product Name] ,[Product ID]
ORDER BY TotalSales DESC

--Which products have the highest sales when discounts are applied?
SELECT [Product Name], Discount, SUM(SalesConverted) as TotalSales
FROM [Sales].[dbo].[Orders]
where Discount > 0
GROUP BY [Product Name] , Discount
ORDER BY TotalSales desc

--Which products have the highest Profit when discounts are applied?
SELECT [Product Name], Discount, SUM(ProfitConverted) as TotalProfit
FROM [Sales].[dbo].[Orders]
where Discount > 0
GROUP BY [Product Name] , Discount
ORDER BY TotalProfit desc

--Which products have the highest number of orders when discounts are applied?
SELECT [Product Name], Discount, Count(*) as TotalOrders
FROM [Sales].[dbo].[Orders]
where Discount > 0
GROUP BY [Product Name] , Discount
ORDER BY TotalOrders desc

--Which discount has the highest average profit (profitability)
SELECT [Product Name], Discount,AVG(ProfitConverted) AverageProfit,AVG(SalesConverted) as AverageSales
FROM [Sales].[dbo].[Orders]
where Discount > 0
GROUP BY [Product Name] , Discount
ORDER BY AverageProfit desc

--Count of Returned Orders
SELECT COUNT(*) as NumReturnedOrders
FROM [Sales].[dbo].[Returns]

--Percentage of Returned Orders
SELECT cast((CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM [Sales].[dbo].[Orders]) * 100)as decimal(10,2))  AS PerReturnedOrders
FROM [Sales].[dbo].[Returns]










