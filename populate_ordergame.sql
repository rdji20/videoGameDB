CREATE PROCEDURE rdji_PopulateOrderGame
@g_name varchar(50),
@qty int,
@f_name varchar(30),
@l_name varchar(30),
@dob1 date,
@date1 date
as
declare @GaID int, @Oid int

exec rdji_getOrderID 
	@date = @date1
  ,@c_fname = @f_name
  ,@c_lname = @l_name
  ,@dob = @dob1
  ,@O_id = @Oid OUTPUT
IF @Oid is null
	begin
	print 'Oh my, mistake again';
	throw 60000, '@Oid cannot be null', 1;
	end

exec uspGetGameID
	@GameName = @g_name,
	@GameID = @GaID OUTPUT
IF @GaID is null
	begin
	print 'Oh my, mistake again';
	throw 60000, '@GaID cannot be null', 1;
	end

BEGIN TRAN R1
INSERT INTO OrderGame (gameID, OrderID, Quantity)
VALUES (@GaID, @Oid, @qty)
IF @@ERROR <> 0
	BEGIN
	Print 'there was an error trying to insert data, rollingback'
	ROLLBACK TRAN R1
	END
ELSE
	begin
	COMMIT TRAN R1
	end