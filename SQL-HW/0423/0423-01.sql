-- 列出消費總金額，高於所有客戶平均消費總金額，的客戶的名字，以及，客戶的消費總金額

SELECT
	c.CompanyName,
	SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) As total --消費總金額
	--( SELECT COUNT(c.CustomerID) FROM Customers c ) 客戶數量
FROM [Order Details] od
INNER JOIN Orders o ON o.OrderID = od.OrderID
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY C.CompanyName --用客戶名稱做分群 這樣會以客戶名稱做分群計算金額
HAVING SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) > 
(	SELECT
		SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) / (SELECT COUNT(c.CustomerID) FROM Customers c)
	FROM
		[Order Details] od
)
--平均金額
	SELECT
		SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) / (SELECT COUNT(c.CustomerID) FROM Customers c)
	FROM
		[Order Details] od
	