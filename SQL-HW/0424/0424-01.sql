-- CustomerID, CompanyName, City, 定單筆數, 定單總金額

SELECT
	C.CustomerID,C.CompanyName,C.City,
	COUNT(DISTINCT O.OrderID) AS Quantity,
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS Total
FROM Customers C
INNER JOIN Orders O ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID,C.CompanyName,C.City
ORDER BY C.CustomerID ASC
