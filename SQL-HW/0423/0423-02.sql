-- 列出一毛錢都沒買的客戶名稱

SELECT c.CompanyName
FROM Customers c
WHERE NOT EXISTS(
	SELECT*
	FROM Orders o
	WHERE o.CustomerID = c.CustomerID
)