
CREATE PROCEDURE [dbo].[rdji_PopPokemonGame] 
@CollName VARCHAR(50)
AS
DECLARE @ColID INT, @MatID INT, @PUBID INT

IF @CollName <> 'Pokemon'
    BEGIN
    PRINT 'This procedure is just for pokemon games';
    THROW 70000, '@CollName is not pokemon', 1;
    END

EXEC rdji_GetCollectionID
@1collname = @CollName,
@1coll_id = @ColID OUTPUT
IF @ColID is NULL
    BEGIN
    PRINT 'Some error happened'; 
    THROW 60000, '@Colid cannot be null', 1;
    END

EXEC rdji_GetMaturityRatingID
@1rat_abbv = 'E',
@1matrat_id = @MatID output

IF @MatID is NULL
    BEGIN
    PRINT 'Some error happened'; 
    THROW 60000, '@MatID cannot be null', 1;
    END

EXEC rdji_GetPublisherID
@1pubname = 'Nintendo',
@1pub_id = @PUBID OUTPUT
IF @PUBID is NULL
    BEGIN
    PRINT 'Some error happened'; 
    THROW 60000, '@PUBID cannot be null', 1;
    END

SELECT slug, released
INTO #Temp200
FROM rdjiMockTables.dbo.nintendo3ds
WHERE slug like '%pokemon%'

SELECT top 1 * FROM #Temp200


DECLARE @Run INT = 0
WHILE @Run = 0
BEGIN
    IF EXISTS (SELECT * FROM #Temp200)
    BEGIN
        INSERT INTO tblGAME (gameName, collectionID, Price, PublisherID, MaturityRatingID)
        VALUES ((SELECT top 1 slug FROM #Temp200), @ColID, 39.99, @PUBID , @MatID)
        DELETE top (1) FROM #Temp200
    END
    ELSE 
        SET @Run = 1
END
DROP TABLE #Temp200
GO
