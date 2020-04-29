-- �C�X�̨S�H�n�R�����~���O (Categories)

SELECT TOP 1
	C.CategoryName,
	SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS Total
FROM Categories C
INNER JOIN Products P ON P.CategoryID = C.CategoryID
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY C.CategoryName
ORDER BY SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) ASC