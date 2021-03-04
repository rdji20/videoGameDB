-- Creation of a wrapper procedure
-- !!! Change the age to be more realistic 


CREATE PROCEDURE uspWRAPPER_rdjiPopCustOld_registration
@Run INT
AS
-- DECLARE variables to manage massive inserts --> get row counts for each look up table
DECLARE @wCust_ct int = (SELECT COUNT(*) FROM PEEPS.dbo.tblCUSTOMER)
DECLARE @wCty_ct INT = (SELECT COUNT(*) FROM tblCOUNTRY)
DECLARE @wCusty_ct INT = (SELECT COUNT(*) FROM tblCUSTOMER_TYPE)

DECLARE @wf VARCHAR(30), @wl VARCHAR(30), @wdob date, @wcity VARCHAR(50), @wstate CHAR(2), @waddss VARCHAR(50) --Participant info
DECLARE @wcty VARCHAR(30)
DECLARE @wcusty VARCHAR(30)

Declare @PK INT
DECLARE @Rand INT 

WHILE @Run > 0
BEGIN



-- SELECT * FROM tblCUSTOMER
-- Checking for duplicates
-- IF EXISTS (SELECT CustomerFname, CustomerLname, CustomerDOB 
--             FROM tblCUSTOMER 
--             WHERE )
-- BEGIN

-- END
-- Should I crate a trans table to store the previous used ids?
-- find a random value 

SET @PK = (SELECT RAND() * @wCust_ct + 1)


set @wf = (SELECT CustomerFname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @PK)
set @wl = (SELECT CustomerLname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @PK)
set @wdob = (SELECT DateOfBirth FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @PK)
set @wcity = (SELECT CustomerCity FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @PK)
set @wstate = (SELECT RIGHT (CustomerState, 2) FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @PK)
    IF (@wstate) IS NULL
        BEGIN 
        PRINT '@wstate is null ' + @wstate;
        THROW 70000, 'CustomerState cannot be null', 1;
    END

set @waddss = (SELECT CustomerAddress FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @PK)

SET @Rand = (select RAND() * 100 + 1)
SET @PK = (CASE 
            WHEN @Rand BETWEEN 1 AND 40
            THEN 1
            WHEN @Rand BETWEEN 41 AND 60
            THEN 2
            WHEN @Rand BETWEEN 61 AND 70
            THEN 5
            WHEN @Rand BETWEEN 71 AND 80
            THEN 7
            WHEN @Rand BETWEEN 81 AND 85
            THEN 8
            WHEN @Rand BETWEEN 86 AND 90
            THEN 10
            WHEN @Rand BETWEEN 91 AND 93
            THEN 4
            WHEN @Rand BETWEEN 94 AND 96
            THEN 6
            WHEN @Rand BETWEEN 97 AND 98
            THEN 11
            WHEN @Rand BETWEEN 98 AND 99
            THEN 3
            ELSE 9
            END
            )

SET @wcty = (SELECT CountryName FROM tblCountry WHERE CountryID = @PK)

SELECT * FROM tblCOUNTRY

SET @Rand = (select RAND() * 100 + 1)
SET @PK = (CASE 
                WHEN @Rand BETWEEN 23 AND 77
                THEN 1
                WHEN @Rand BETWEEN 78 AND 93
                THEN 3
                WHEN @Rand BETWEEN 8 AND 22
                THEN 3
                WHEN @Rand BETWEEN 3 AND 7
                THEN 4
                WHEN @Rand BETWEEN 93 AND 97
                THEN 4
                ELSE 5
                END
            )

SET @wcusty = (SELECT CustomerTypeName FROM tblCUSTOMER_TYPE WHERE CustomerTypeID = @PK)


EXECUTE [rdjiPopCustOld] 
   @cust_fname = @wf
  ,@cust_lname = @wl
  ,@cty_name = @wcty
  ,@custy_name = @wcusty
  ,@cust_address = @waddss
  ,@city = @wcity
  ,@state = @wstate
  ,@dob = @wdob


SET @Run = @Run - 1
END




