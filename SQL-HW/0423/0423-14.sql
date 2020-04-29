-- �C�X�C�@�ӫ������O�����~�����ƶq

SELECT
	C.City, CA.CategoryName,
	COUNT (OD.Quantity) AS Quantity
FROM Customers C
INNER JOIN Orders O ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN Products P ON P.ProductID = OD.ProductID
INNER JOIN Categories CA ON CA.CategoryID = P.CategoryID
GROUP BY C.City,CA.CategoryName
ORDER BY C.City ASC