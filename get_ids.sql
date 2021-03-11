Create PROCEDURE rdji_getOrderID 
@date date,
@c_fname varchar(30),
@c_lname varchar(30),
@dob date,
@O_id int OUTPUT
AS

DECLARE @CustID INT

EXEC usp_GETCUSTID
@CustomerFname = @c_fname,
@CustomerLname = @c_lname,
@CustomerDOB = @dob,
@CustomerID = @CustID OUTPUT
IF @CustID is null
	begin
	print 'Error in getting cust id';
	Throw 60000, '@CustID cannote be null', 1;
	end

SET @O_id = (SELECT OrderID FROM tblOrder WHERE CustomerID = @CustID AND OrderDate = @date)