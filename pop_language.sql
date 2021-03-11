CREATE PROCEDURE rdji_PopGameLanguage 
@LanguageN varchar(50),
@g_name varchar(100)
AS
DECLARE @LanID INT, @GamLanID int

EXEC uspGetGameID
@GameName = @g_name,
@GameID = @GamLanID OUTPUT
IF @GamLanID is null
	begin
	print 'There is no way that we can do something';
	throw 60000, '@GamID is null', 1;
	end

EXEC uspLanguageID
@LanguageName = @LanguageN,
@LanguageID = @LanID OUTPUT
IF @LanID is null
	begin
	print 'There is no way that we can do something';
	throw 60000, '@LanID is null', 1;
	end

BEGIN TRAN R1
INSERT INTO tblGame_Language (GameLanguageID, languageID)
VALUES (@GamLanID, @LanID)
IF @@ERROR <> 0
	BEGIN
	PRINT 'There was an error in the population of game language'
	ROLLBACK TRAN R1
	END
ELSE
	COMMIT TRAN R1