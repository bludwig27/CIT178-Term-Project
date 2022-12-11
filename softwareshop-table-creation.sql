CREATE DATABASE SoftwareShop;
GO

USE SoftwareShop;
CREATE TABLE Games(
	GameID int NOT NULL,
	Title varchar(100) NOT NULL,
	PlatformID varchar(10) NOT NULL,
	ReleaseDate datetime,
	Genre varchar(30),
	RatingID tinyint NOT NULL,
	Price money,
	InStock smallint,
	PRIMARY KEY(GameID)
	);
GO

CREATE TABLE Platforms(
	PlatformID varchar(10) NOT NULL,
	PlatformName varchar(50) NOT NULL,
	PlatformPrice money,
	InStock smallint,
	PRIMARY KEY(PlatformID)
	);
GO

CREATE TABLE Ratings(
	RatingID tinyint NOT NULL,
	ESRB varchar(5) NOT NULL,
	AgeRestriction varchar(50) NOT NULL,
	PRIMARY KEY(RatingID)
	);
GO

CREATE TABLE Memberships(
	MemberID smallint NOT NULL,
	FirstName varchar(30),
	LastName varchar(30) NOT NULL,
	MembershipStart datetime,
	MembershipExpire datetime,
	DiscountID tinyint NOT NULL,
	Birthday datetime,
	Phone int,
	PRIMARY KEY(MemberID)
	);
GO

CREATE TABLE Discounts(
	DiscountID tinyint NOT NULL,
	Rank varchar(30) NOT NULL,
	Discount tinyint NOT NULL,
	PRIMARY KEY(DiscountID)
	);
GO

CREATE TABLE Receipts(
	ReceiptID int NOT NULL,
	TransactionDate datetime,
	Total money NOT NULL,
	PRIMARY KEY(ReceiptID)
	);
GO

CREATE TABLE ReceiptDetails(
	ReceiptID int NOT NULL,
	LineSequence smallint NOT NULL,
	GameID int NOT NULL,
	Quantity int NOT NULL,
	DiscountID tinyint,
	LineTotal money NOT NULL,
	CONSTRAINT PK_ReceiptDetails PRIMARY KEY (ReceiptID,LineSequence)
	);
GO