/* Design a stored procedure that has at least two joins and two parameters */
USE AdventureWorks2014
GO

CREATE PROC proc_Get_SalesPerson_Performance_and_City @minSalesYTD INT, @maxSalesYTD INT
AS
BEGIN
	SELECT Sales.SalesPerson.SalesYTD, person.Address.City FROM Person.BusinessEntityAddress 
	INNER JOIN Sales.SalesPerson ON Sales.SalesPerson.BusinessEntityID = Person.BusinessEntityAddress.BusinessEntityID
	INNER JOIN Person.Address ON Person.BusinessEntityAddress.AddressID = Person.Address.AddressID
	WHERE Sales.SalesPerson.SalesYTD >= @minSalesYTD AND Sales.SalesPerson.SalesYTD <= @maxSalesYTD;
END
GO

EXEC [dbo].[proc_Get_SalesPerson_Performance_and_City] @minSalesYTD = 3000000, @maxSalesYTD = 4000000;
