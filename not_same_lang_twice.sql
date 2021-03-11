CREATE FUNCTION fn_NotSameLangTwice(@GAM INT, @LAN INT)
RETURNS INT
AS
BEGIN

DECLARE @Ret INT  = 0 
	IF EXISTS ( SELECT * 
				FROM tblGAME G
				JOIN tblGame_Language GL ON GL.gameID = G.gameID
				JOIN Language_Type LT ON LT.languageID = GL.languageID
				WHERE g.gameID = @GAM
				AND LT.languageID = @LAN)
		BEGIN
			SET @Ret = 1
		END
RETURN @Ret
END