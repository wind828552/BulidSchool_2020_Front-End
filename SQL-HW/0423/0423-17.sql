-- �C�X���P��a (Country) ���Ȥ���O�`���B

SELECT
	CU.Country,
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS Total
FROM Customers CU
INNER JOIN Orders O ON O.CustomerID = CU.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY CU.Country
