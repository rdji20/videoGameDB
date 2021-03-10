

CREATE PROCEDURE rdji_populatePublisher 
@Pubname VARCHAR(50),
@CountN VARCHAR(50)
AS
DECLARE @Ctyid INT

EXEC rdji_GetCountryID
@1cty_name = @CountN,
@1cty_id = @Ctyid OUTPUT

IF @Ctyid is NULL
    BEGIN
    PRINT 'Error in @Ctyidd';
    THROW 60000, '@Ctyid cannot be null', 1;
    END

BEGIN TRAN R1
INSERT INTO tblPublisher(PublisherName, CountryID)
VALUES (@Pubname, @Ctyid)
IF @@ERROR <> 0
    BEGIN
    PRINT 'There was an error before rollling stones'
    ROLLBACK TRAN R1
    END
ELSE COMMIT TRAN R1