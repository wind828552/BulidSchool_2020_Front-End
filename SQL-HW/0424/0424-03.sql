--列出目前沒有庫存的產品,在過去曾經被那些客戶訂購過

SELECT
	P.ProductID, O.CustomerID,
	COUNT(O.CustomerID)
FROM Products P
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON O.OrderID = OD.OrderID
WHERE P.UnitsInStock = 0
GROUP BY P.ProductID, O.CustomerID
ORDER BY O.CustomerID ASC

