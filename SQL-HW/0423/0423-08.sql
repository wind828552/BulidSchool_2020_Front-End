-- �C�X�P���`���B�̰������� (Customers.City)

SELECT TOP 1
	C.City,
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount))
FROM Customers C
INNER JOIN Orders O ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.City 
ORDER BY SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) DESC

