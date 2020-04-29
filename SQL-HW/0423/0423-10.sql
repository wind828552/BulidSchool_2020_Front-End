-- �C�X��P��̦n�������ӶR�̦h���B���Ȥ�P�ʶR���B (�t�ʶR�䥦�����Ӫ����~)

DECLARE @SUP NVARCHAR(50)
SET @SUP = ( 
SELECT TOP 1
	su.CompanyName
	--SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount))
FROM Suppliers SU
INNER JOIN Products P ON P.SupplierID = SU.SupplierID
INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY su.CompanyName
--ORDER BY SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) DESC
)

SELECT TOP 1
	C.CompanyName, 
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS clienttotal
FROM Suppliers SU
INNER JOIN Products P ON P.SupplierID = SU.SupplierID
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
INNER JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE SU.CompanyName  = @SUP
GROUP BY C.CompanyName 
ORDER BY clienttotal DESC