/*Final Project Procedures

--Procedure #1: Game Releases Within the Last Month (Retrives and Displays Data)

USE SoftwareShop;
GO
CREATE PROC spRecentReleases
AS
SELECT * FROM Games
WHERE (ReleaseDate > (DATEADD(month,-1,GETDATE())));
GO

EXEC spRecentReleases;

--Procedure #2: Genre Lookup (Takes a parameter)

USE SoftwareShop;
GO
CREATE PROC spGenreLookup
	@Genre varchar(30)
AS
SELECT * FROM Games
WHERE Genre = @Genre;
GO
EXEC spGenreLookup Action;

--Procedure #3: DiscountLookup (Returns multiple parameters)

USE SoftwareShop;
GO
CREATE PROC spCustomerDiscount
	@Birthdate datetime,
	@Name varchar(60) OUTPUT,
	@Rank varchar(6) OUTPUT,
	@Discount int OUTPUT
AS
BEGIN TRY
SELECT @Name = (FirstName + ' ' + LastName), @Rank = Rank, @Discount = Discount
FROM Memberships JOIN Discounts ON  Memberships.DiscountID = Discounts.DiscountID
WHERE Birthday = @Birthdate
END TRY
BEGIN CATCH
PRINT 'No such member exists in the database.'
END CATCH
GO

DECLARE @Name varchar(60), @Rank varchar(6), @Discount int

EXEC spCustomerDiscount '1963-01-09',@Name OUTPUT, @Rank OUTPUT, @Discount OUTPUT

SELECT @Name as Name, @Rank as Rank, @Discount as Discount;
PRINT 'Customer Name: ' + @Name;
PRINT 'Rank: ' + @Rank;
PRINT 'Discount: ' + CONVERT(varchar(2),@Discount)

--Procedure #4: Number of Titles in Stock (Returns value)

USE SoftwareShop;
GO
CREATE PROC spNumberInStock
AS
DECLARE @InStockGames int;
SELECT @InStockGames = COUNT(*) FROM Games WHERE InStock > 0;
RETURN @InStockGames
GO

DECLARE @InStockGames int;
EXEC @InStockGames = spNumberInStock;
PRINT 'We have ' + CONVERT(varchar,@InStockGames) + ' titles currently in stock.';

Final Project User Defined Functions

--Function #1: ID Lookup (Scalar Function)

USE SoftwareShop;
GO
CREATE FUNCTION fnIDLookup
    (@GameID int = '%')
    RETURNS varchar(50)
BEGIN
    RETURN (SELECT Title FROM Games WHERE GameID = @GameID);
END;
GO

SELECT Title FROM Games WHERE Title=dbo.fnIDLookup(1001);

--Function #2: General Lookup By Title (Table Function)

Use SoftwareShop;
GO
CREATE FUNCTION fnTitleLookup
	(@Title nvarchar(50) = '%')
	RETURNS table
	RETURN (SELECT * FROM Games WHERE Title LIKE @Title);
GO

SELECT * FROM dbo.fnTitleLookup('%Mario%');

Final Project Triggers

--Creating the archive table

USE SoftwareShop;
GO
SELECT * INTO Archive
FROM Games
WHERE 1=0;
GO
ALTER TABLE Archive
ADD Status varchar(30);


--Deletion archive trigger

CREATE TRIGGER Archive_Delete ON Games
	AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @GameID int
	DECLARE @Title varchar(100)
	DECLARE @PlatformID varchar(10)
	DECLARE @ReleaseDate datetime
	DECLARE @Genre varchar(30)
	DECLARE @RatingID tinyint
	DECLARE @Price money
	DECLARE @InStock smallint

	SELECT @GameID=DELETED.GameID, @Title=DELETED.Title, @PlatformID=DELETED.PlatformID, @ReleaseDate=DELETED.ReleaseDate,
			@Genre=DELETED.Genre, @RatingID = DELETED.RatingID, @Price=DELETED.Price, @Instock=DELETED.InStock FROM DELETED
	INSERT INTO Archive VALUES (@GameID, @Title, @PlatformID, @ReleaseDate, @Genre, @RatingID, @Price, @Instock, 'Deleted')
END
GO

--Insertion archive trigger

CREATE TRIGGER Archive_Insert ON Games
	AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @GameID int
	DECLARE @Title varchar(100)
	DECLARE @PlatformID varchar(10)
	DECLARE @ReleaseDate datetime
	DECLARE @Genre varchar(30)
	DECLARE @RatingID tinyint
	DECLARE @Price money
	DECLARE @InStock smallint

	SELECT @GameID=INSERTED.GameID, @Title=INSERTED.Title, @PlatformID=INSERTED.PlatformID, @ReleaseDate=INSERTED.ReleaseDate,
			@Genre=INSERTED.Genre, @RatingID = INSERTED.RatingID, @Price=INSERTED.Price, @Instock=INSERTED.InStock FROM INSERTED
	INSERT INTO Archive VALUES (@GameID, @Title, @PlatformID, @ReleaseDate, @Genre, @RatingID, @Price, @Instock, 'Inserted')
END
GO

--Update archive trigger


CREATE TRIGGER Archive_Update ON Games
	AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @GameID int
	DECLARE @Title varchar(100)
	DECLARE @PlatformID varchar(10)
	DECLARE @ReleaseDate datetime
	DECLARE @Genre varchar(30)
	DECLARE @RatingID tinyint
	DECLARE @Price money
	DECLARE @InStock smallint

	SELECT @GameID=INSERTED.GameID, @Title=INSERTED.Title, @PlatformID=INSERTED.PlatformID, @ReleaseDate=INSERTED.ReleaseDate,
			@Genre=INSERTED.Genre, @RatingID = INSERTED.RatingID, @Price=INSERTED.Price, @Instock=INSERTED.InStock FROM INSERTED
	INSERT INTO Archive VALUES (@GameID, @Title, @PlatformID, @ReleaseDate, @Genre, @RatingID, @Price, @Instock, 'Updated')
END
GO*/