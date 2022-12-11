--Final Project Views--

USE SoftwareShop;
GO

--View #1--

--Current Members--

CREATE VIEW CurrentMembers
AS
SELECT FirstName, LastName, Birthday, Phone, [Rank]
FROM Memberships JOIN Discounts ON Memberships.DiscountID = Discounts.DiscountID
WHERE MembershipExpire > GETDATE()
WITH CHECK OPTION;
GO

--Display Current Members--

SELECT * FROM CurrentMembers;
GO

--View #2--

--Nintendo Games--

CREATE VIEW NintendoGames
AS
SELECT Title, PlatformName, ReleaseDate, Genre, Price, Games.Instock
FROM Games JOIN Platforms ON Games.PlatformID = Platforms.PlatformID
WHERE PlatformName = 'Nintendo Switch';
GO

--Display all Nintendo Games in Stock--

SELECT * FROM NintendoGames
WHERE InStock > 0;
GO

--View #3--

--Transactions Within the Last Year--

CREATE VIEW RecentTransactions
AS
SELECT Receipts.ReceiptID, TransactionDate, SUM(Quantity) AS TotalQuantity, Total
FROM Receipts LEFT JOIN ReceiptDetails ON Receipts.ReceiptID = ReceiptDetails.ReceiptID
WHERE DATEDIFF(YEAR,TransactionDate,GETDATE()) < 1
GROUP BY Receipts.ReceiptID, TransactionDate, Total;
GO

--View Recent Transactions (NOTE: TotalQuantity is null because ReceiptID 6 does not have transaction details yet, but the view works)--

SELECT * FROM RecentTransactions;
GO

--View #4--

--All Games In Stock--

CREATE VIEW GamesInStock
AS
SELECT Title, PlatformName, Genre, Price, Games.InStock
FROM Games JOIN Platforms ON Games.PlatformID = Platforms.PlatformID
WHERE Games.InStock > 0;
GO

--View All Games In Stock--
SELECT * FROM GamesInStock;
GO

--Update Items In Stock--

UPDATE GamesInStock
SET InStock=8
WHERE Title = 'Danganronpa';
GO

--View Updated Games In Stock--

SELECT * FROM GamesInStock;
GO
