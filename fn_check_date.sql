CREATE FUNCTION fn_checkDOBmoreThan(@PK int)
RETURNS INTEGER
AS
BEGIN 

DECLARE @Ret INTEGER = 0
    IF EXISTS ( 
        SELECT *
        FROM PEEPS.dbo.tblCUSTOMER
        WHERE DateOfBirth > 365
    )
    BEGIN
        SET @Ret = 1
    END
RETURN @Ret
END
go



