
CREATE PROCEDURE [dbo].[rdji_GetCustomerTypeID]
@1custy_name VARCHAR(30),
@1custy_id INT OUTPUT
AS
SET @1custy_id = (SELECT CustomerTypeID FROM tblCUSTOMER_TYPE WHERE CustomerTypeName = @1custy_name)
GO
