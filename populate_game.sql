-- Stored procedure to populate tblGAME
-- We have added modularity for a better performance

CREATE PROCEDURE rdji_GetCollectionID
@1collname VARCHAR(50),
@1coll_id int OUTPUT
AS 
SET @1coll_id = (SELECT CollectionID FROM tblCOLLECTION WHERE CollectionName = @1collname)
GO

CREATE PROCEDURE rdji_GetPublisherID
@1pubname VARCHAR(50),
@1pub_id INT OUTPUT
AS 
SET @1pub_id = (SELECT PublisherID FROM tblPublisher WHERE PublisherName = @1pubname)
GO

-- We look for the ID with just the abbreviation of the rating as they are all different
CREATE PROCEDURE rdji_GetMaturityRatingID
@1rat_abbv VARCHAR(50),
@1matrat_id INT OUTPUT
AS
SET @1matrat_id = (SELECT MaturityRatingID FROM Maturity_Rating WHERE RatingAbbreviation = @1rat_abbv)
GO

CREATE PROCEDURE rdji_PopulateGame
@gam_name VARCHAR(50),
@price SMALLMONEY,
@collname VARCHAR(50),
@pubname VARCHAR(50),
@rat_abbv VARCHAR(50)
AS 
DECLARE @coll_id INT, @pub_id INT, @matrat_id INT

EXEC rdji_GetCollectionID
@1collname = @collname,
@1coll_id = @coll_id OUTPUT

-- ERROR HANDLING 
    IF @coll_id IS NULL
    BEGIN
        PRINT 'There is an error in getting Collection ID';
        THROW 60000, '@coll_id Cannot be null, provide a real collection name', 1;
    END

EXEC rdji_GetPublisherID
@1pubname = @pubname,
@1pub_id = @pub_id OUTPUT
-- ERROR HANDLING
    IF @pub_id IS NULL 
    BEGIN
        PRINT 'There is an error in getting Publisher ID';
        THROW 60000, '@pub_id cannot be null, provide a real publisher name', 1;
    END

EXEC rdji_GetMaturityRatingID
@1rat_abbv = @rat_abbv,
@1matrat_id = @matrat_id OUTPUT
-- Error Handling
    IF @matrat_id IS NULL
    BEGIN
        PRINT 'There is an error in getting Maturity Rating ID';
        THROW 60000, '@matrat_id cannot be null, provide a real rating abbreviation', 1;
    END

BEGIN TRAN R1 
INSERT INTO tblGAME(gameName, collectionID, Price, PublisherID, MaturityRatingID)
VALUES (@gam_name, @coll_id, @price, @pub_id, @matrat_id)
IF @@ERROR <> 0
    BEGIN 
        PRINT 'THERE WAS AN ERROR BEFORE'
        ROLLBACK TRAN R1
    END 
ELSE
COMMIT TRAN R1
GO



