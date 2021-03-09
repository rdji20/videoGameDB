
CREATE VIEW rdjiCheckOrdersFromMewtwos 
AS
    SELECT C.CustomerID, G.gameID, gameName, S.StatusName
    FROM tblCUSTOMER C
    JOIN tblCUSTOMER_TYPE CT ON CT.CustomerTypeID = C.CustomerTypeID
    JOIN tblOrder O ON O.CustomerID = C.CustomerID
    JOIN tblOrderStatus OS ON OS.OrderID = O.OrderID
    JOIN tblSTATUS S ON S.StatusID = OS.StatusID
    JOIN tblORDER_GAME OG ON OG.OrderID = O.OrderID
    JOIN tblGAME G ON G.gameID = OG.gameID
    WHERE CT.CustomerTypeName = 'Mewtwo'

