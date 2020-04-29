-- 列出那些產品沒有人買過

SELECT
	P.ProductName
FROM Products P
INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
WHERE NOT EXISTS
(
	SELECT *
	FROM Orders o
	WHERE o.OrderID = od.OrderID 
)

SELECT
	p.ProductName
FROM Products p
LEFT OUTER JOIN [Order Details] od ON od.ProductID = p.ProductID
WHERE od.OrderID IS NULL


