
CREATE PROCEDURE [dbo].[rdji_GetCountryID]
@1cty_name VARCHAR(30),
@1cty_id INT OUTPUT
AS

SET @1cty_id = (SELECT CountryID FROM tblCOUNTRY WHERE CountryName = @1cty_name)
GO
