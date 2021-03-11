
DECLARE @Run INT = 0
DECLARE @Rand INT, @PK INT, @game_name VARCHAR(100), @RatAbbv VARCHAR(10), @Price smallmoney, 
        @PubName VARCHAR(50), @CollName VARCHAR(50)
DECLARE @MatRows INT = (SELECT COUNT(*) FROM Maturity_Rating) 
DECLARE @PubRows INT = (SELECT COUNT(*) FROM tblPublisher)
DECLARE @CollRows INT = (SELECT COUNT(*) FROM tblCOLLECTION)

WHILE @Run = 0 
    BEGIN
    Set @game_name = (SELECT top 1 Game FROM rdjiMockTables.dbo.XBoxData)

    SET @Rand = (SELECT RAND() * 100 + 1)
    SET @PK = (CASE 
                WHEN @Rand BETWEEN 1 AND 40
                THEN 1
                WHEN @Rand BETWEEN 41 AND 70
                THEN 7
                ELSE
                (SELECT RAND() * @MatRows + 1)
                 END
                 )
    SET @RatAbbv = (SELECT RatingAbbreviation FROM Maturity_Rating WHERE MaturityRatingID = @PK)
    PRINT @RatAbbv
    WHILE @RatAbbv is NULL
        BEGIN
            SET @PK = (CASE 
                WHEN @Rand BETWEEN 1 AND 40
                THEN 1
                WHEN @Rand BETWEEN 41 AND 70
                THEN 7
                ELSE
                (SELECT RAND() * @MatRows + 1)
                 END
                 )
            SET @RatAbbv = (SELECT RatingAbbreviation FROM Maturity_Rating WHERE MaturityRatingID = @PK)
            PRINT @RatAbbv
        END

    SET @PK = (SELECT RAND() * @PubRows)
    SET @PubName = (SELECT PublisherName FROM tblPublisher WHERE publisherID = @PK)
    PRINT @PubName
    WHILE @PubName is NULL
        BEGIN
            SET @PK = (SELECT RAND() * @PubRows)
            SET @PubName = (SELECT PublisherName FROM tblPublisher WHERE publisherID = @PK)
            PRINT @PubName
        END

    SET @PK = (SELECT RAND() * @CollRows + 1)
    SET @CollName = (SELECT CollectionName FROM tblCOLLECTION WHERE CollectionID = @PK)
    WHILE @CollName is NULL
        BEGIN
            SET @PK = (SELECT RAND() * @CollRows + 1)
            SET @CollName = (SELECT CollectionName FROM tblCOLLECTION WHERE CollectionID = @PK)
        PRINT @CollName
        END


    SET @Rand = (SELECT RAND() * 100 + 1)
    SET @Price = (CASE 
                    WHEN @Rand between 1 and 30
                    THEN 19.99
                    WHEN @Rand between 31 and 50
                    then 29.99
                    when @Rand between 51 and 70
                    then 49.99
                    when @Rand between 71 and 80
                    then 39.99
                    else 9.99
                    END )

    EXEC rdji_PopulateGame
    @gam_name = @game_name,
    @price = @Price,
    @collname = @CollName,
    @pubname = @PubName,
    @rat_abbv = @RatAbbv


    delete top (1) from rdjiMockTables.dbo.XBoxData


    IF (SELECT COUNT(*) FROM rdjiMockTables.dbo.XBoxData) = 0
        BEGIN
            SET @Run = 1
        END
    
    END


