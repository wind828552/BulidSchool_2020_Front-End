SELECT
	S.ShipperID,C.CategoryName
FROM Shippers S
INNER JOIN Orders O ON O.ShipVia = S.ShipperID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Categories C ON C.CategoryID = P.CategoryID

