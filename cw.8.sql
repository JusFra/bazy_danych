USE AdventureWorks2019;

-- 1. Przygotuj blok anonimowy, który:
--		znajdzie średnią stawkę wynagrodzenia pracowników,
--		wyświetli szczegóły pracowników, których stawka wynagrodzenia jest niższa niż średnia.

BEGIN
	SELECT AVG(Rate * PayFrequency) AS average
	FROM HumanResources.EmployeePayHistory

	SELECT Employee.BusinessEntityID, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, Rate, PayFrequency, RateChangeDate
	FROM HumanResources.EmployeePayHistory
	JOIN HumanResources.Employee ON EmployeePayHistory.BusinessEntityID = Employee.BusinessEntityID
	WHERE Rate < (SELECT AVG(Rate * PayFrequency) FROM HumanResources.EmployeePayHistory)
END;

-- 2. Utwórz funkcję, która zwróci datę wysyłki określonego zamówienia.

SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader

CREATE FUNCTION GetShip (@SalesOrderID AS INT)
RETURNS DATE
AS
BEGIN
RETURN (SELECT ShipDate
		FROM Sales.SalesOrderHeader 
		WHERE SalesOrderID LIKE @SalesOrderID)
END;

SELECT dbo.GetShip(43659);

-- 3. Utwórz procedurę składowaną, która jako parametr przyjmuję nazwę produktu, a jako
--    rezultat wyświetla jego identyfikator, numer i dostępność.

CREATE PROCEDURE GetProductInfo 
@Name NVARCHAR(50)
AS
BEGIN
	SELECT Product.ProductID, ProductNumber, Location.Name AS 'NameLocation', Shelf, Bin, Quantity
	FROM Production.Product
	JOIN Production.ProductInventory ON ProductInventory.ProductID = Product.ProductID
	JOIN Production.Location ON Location.LocationID = ProductInventory.LocationID
	WHERE Product.Name LIKE @Name
END;

EXEC GetProductInfo 'Bearing Ball';


-- 4. Utwórz funkcję, która zwraca numer karty kredytowej dla konkretnego zamówienia.

CREATE FUNCTION GetCardNumber (@SalesOrderID AS INT)
RETURNS NVARCHAR(25)
AS
BEGIN
RETURN (SELECT CardNumber
		FROM Sales.SalesOrderHeader 
		JOIN Sales.CreditCard ON SalesOrderHeader.CreditCardID = CreditCard.CreditCardID
		WHERE SalesOrderID LIKE @SalesOrderID)
END;

SELECT dbo.GetCardNumber(43659);

-- 5. Utwórz procedurę składowaną, która jako parametry wejściowe przyjmuje dwie liczby, num1
--    i num2, a zwraca wynik ich dzielenia. Ponadto wartość num1 powinna zawsze być większa niż
--    wartość num2. Jeżeli wartość num1 jest mniejsza niż num2, wygeneruj komunikat o błędzie
--    „Niewłaściwie zdefiniowałeś dane wejściowe”.

ALTER PROCEDURE division
	@num1 FLOAT,
	@num2 FLOAT
AS
BEGIN
	BEGIN TRY 
		IF @num1 < @num2
			SET @num2 = 0
		SELECT @num1/@num2
	END TRY
	BEGIN CATCH
		PRINT 'Niewłaściwie zdefiniowałeś dane wejściowe.'
	END CATCH
END;

EXEC division 10,2;

-- 6. Napisz procedurę, która jako parametr przyjmie NationalIDNumber danej osoby, a zwróci
--	  stanowisko oraz liczbę dni urlopowych i chorobowych.

CREATE PROCEDURE FreeDays
@NationalIDNumber NVARCHAR(15)
AS
BEGIN
	SELECT JobTitle, VacationHours, SickLeaveHours
	FROM HumanResources.Employee
	WHERE NationalIDNumber LIKE @NationalIDNumber
END;

EXEC FreeDays 134969118;

-- 7. Napisz procedurę będącą kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currency
--    oraz Sales.CurrencyRate. Parametrami wejściowymi mają być: kwota, waluty oraz data
--    (CurrencyRateDate). Przyjmij, iż zawsze jedną ze stron jest dolar amerykański (USD).
--    Zaimplementuj kalkulację obustronną, tj:
--    1400 USD → PLN lub PLN → USD

ALTER PROCEDURE Calculator
	@amount FLOAT,
	@currency NCHAR(3),
	@date DATETIME
AS
DECLARE @rate FLOAT
DECLARE @sum FLOAT
BEGIN
	IF @currency = 'USD'
		BEGIN
			SELECT @rate = EndOfDayRate FROM Sales.CurrencyRate WHERE ToCurrencyCode = 'EUR' AND CurrencyRateDate = @date
			SET @sum = @amount * @rate
			PRINT @sum
		END
	ELSE IF @currency = 'EUR'
		BEGIN
			SELECT @rate = EndOfDayRate FROM Sales.CurrencyRate WHERE ToCurrencyCode = 'EUR' AND CurrencyRateDate = @date
			SET @sum = @amount / @rate
			PRINT @sum
		END
	ELSE
		PRINT 'Wpisz poprawną walutę (USD lub EUR).'		
END;

EXEC Calculator 20.34, 'USD', '2011-06-11';
EXEC Calculator 20.053, 'EUR', '2011-06-11';
EXEC Calculator 20.053, 'PLN', '2011-06-11';