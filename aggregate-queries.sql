--How many titles do we have for each platform?

/*USE SoftwareShop;
SELECT Platforms.PlatformName, COUNT(*) AS #OfTitles
FROM Games JOIN Platforms ON Games.PlatformID = Platforms.PlatformID
GROUP BY Platforms.PlatformName;

--Which title do we carry the most of and which do we carry the least of?
USE SoftwareShop;
SELECT MAX(InStock) AS MaxInStock, MIN(InStock) AS MinInStock
FROM Games;

--What is the average price of a Nintendo Switch game in our store?
USE SoftwareShop;
SELECT Platforms.PlatformName, AVG(Games.Price) AS AvgPrice
FROM Games JOIN Platforms ON Games.PlatformID = Platforms.PlatformID
WHERE Games.PlatformID = 'NIN'
GROUP BY Platforms.PlatformName;

--How many items (games and platforms) do we currently have in our store?
USE SoftwareShop;
SELECT SUM(Platforms.InStock) AS PlatformsInStock, SUM(Games.InStock) AS GamesInStock
FROM Platforms JOIN Games ON Platforms.PlatformID = Games.PlatformID;*/
