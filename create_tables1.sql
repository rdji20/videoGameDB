
CREATE TABLE tblGAME
(
    gameID INT IDENTITY (1,1) PRIMARY KEY,
    gameName VARCHAR(50),
    collectionID INT FOREIGN KEY REFERENCES tblCOLLECTION(collectionID) NOT NULL,
    Price SMALLMONEY NOT NULL,
    PublisherID INT FOREIGN KEY REFERENCES tblPUBLISHER(PublisherID) NOT NULL,
    MaturityRatingID INT FOREIGN KEY REFERENCES Maturity_Rating(MaturityRatingID) NOT NULL
)
GO

CREATE TABLE tblCOLLECTION (
    CollectionID INT IDENTITY(1,1) PRIMARY KEY,
    CollectionName VARCHAR(50) NOT NULL,
    CollectionDescr VARCHAR(100) NULL
)
GO

CREATE TABLE tblGameConsole
(
    gameConsoleID INT IDENTITY(1,1) PRIMARY KEY,
    gameID INT FOREIGN KEY REFERENCES tblGame(gameID) NOT NULL,
    consoleID INT FOREIGN KEY REFERENCES tblConsole(consoleID) NOT NULL,
)
GO

CREATE TABLE tblOrderStatus
(
    orderStatusID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES tblOrder(OrderID) NOT NULL,
    StatusID INT FOREIGN KEY REFERENCES tblStatus(StatusID) NOT NULL,
    DateTime DATE
)
GO

CREATE TABLE tblDevelopment_Status
(
    StatusID INT IDENTITY (1,1) PRIMARY KEY,
    StatusName VARCHAR(50),
    StatusDesc VARCHAR(50)
)
go

CREATE TABLE tbldevelopment_status_game
(
    StatusGameID INT IDENTITY(1,1) PRIMARY KEY,
    StatusID INT FOREIGN KEY REFERENCES tblDevelopment_Status(StatusID) not null,
    gameID INT FOREIGN KEY REFERENCES tblGame(gameID) NOT NULL,
    DateTime DATE
)
GO

CREATE TABLE tblGameDeveloperRole
(
    gameDeveloperRoleID INT IDENTITY (1,1) PRIMARY KEY,
    gameID INT FOREIGN KEY REFERENCES tblGame(gameID) NOT NULL,
    DevloperID INT FOREIGN KEY REFERENCES tblDeveloper(DeveloperID) NOT NULL,
    RoleID INT FOREIGN KEY REFERENCES tblRole(RoleID) NOT NULL
)
GO

CREATE TABLE tblCART (
    CartID int IDENTITY(1,1) PRIMARY KEY,
    Qty SMALLINT not NULL,
    GameID INT FOREIGN KEY REFERENCES tblGAME(GameID) not NULL,
    CostumerID int FOREIGN KEY REFERENCES tblCustomer(CustomerID) not NULL
)
GO
