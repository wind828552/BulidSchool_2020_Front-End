-- �C�X�S���ǯu (Fax) ���Ȥ�M�������O�`���B

SELECT
	c.CompanyName,
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS Total
FROM Customers c
INNER JOIN Orders O ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE Fax IS NULL
GROUP BY C.CompanyName
